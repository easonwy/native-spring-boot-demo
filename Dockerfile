FROM debian:bookworm-slim AS runtime

RUN apt-get update && apt-get install -y --no-install-recommends \
        libz1 \
        ca-certificates && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY target/native-spring-boot-demo .
EXPOSE 8080
ENTRYPOINT ["./native-spring-boot-demo"]
