#!/bin/bash
set -e

APP_NAME=native-spring-boot-demo
IMAGE_NAME=easonwu/$APP_NAME:latest
BINARY_PATH=target/$APP_NAME

echo "🚀 Step 1: 清理旧的构建..."
rm -rf target

echo "🚀 Step 2: 构建 native binary（GraalVM 容器）..."
docker run --rm \
  -v "$HOME/.m2":/root/.m2 \
  -v "$(pwd)":/workspace \
  -w /workspace \
  ghcr.io/graalvm/graalvm-ce:ol8-java17 \
  ./mvnw -Pnative -DskipTests clean package

echo "✅ Binary 构建完成: $BINARY_PATH"
file $BINARY_PATH

echo "🔍 Step 3: 检测是否为静态链接..."
if ldd $BINARY_PATH 2>&1 | grep -q "not a dynamic executable"; then
  echo "✅ 检测结果: 静态链接，使用 distroless/static 镜像"

  cat > Dockerfile <<EOF
FROM gcr.io/distroless/static
WORKDIR /app
COPY $BINARY_PATH .
EXPOSE 8080
ENTRYPOINT ["./$APP_NAME"]
EOF

else
  echo "✅ 检测结果: 动态链接，使用 debian:bookworm-slim 并安装依赖库"

  cat > Dockerfile <<EOF
FROM debian:bookworm-slim AS runtime

RUN apt-get update && apt-get install -y --no-install-recommends \\
        libz1 \\
        ca-certificates && \\
    apt-get clean && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY $BINARY_PATH .
EXPOSE 8080
ENTRYPOINT ["./$APP_NAME"]
EOF

fi

echo "📦 Step 4: 构建 Docker 镜像: $IMAGE_NAME"
docker build -t $IMAGE_NAME .

echo "🎉 镜像构建完成，可使用以下命令运行："
echo "    docker run -p 8080:8080 $IMAGE_NAME"