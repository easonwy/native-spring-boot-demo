# Native Spring Boot Demo

A demo project showcasing Spring Boot native compilation using GraalVM.

## Features

- Spring Boot REST API with a `/hello` endpoint
- GraalVM native image compilation
- Docker containerization
- Automatic detection of static/dynamic linking
- Optimized container images (distroless for static, debian-slim for dynamic)

## Prerequisites

- Docker
- Maven (or use included `mvnw`)
- Java 17+

## Building

Run the build script to create a native binary and Docker image:

```bash
./build-native.sh
```

This script will:
1. Clean previous builds
2. Build native binary using GraalVM in a container
3. Detect linking type and create appropriate Dockerfile
4. Build Docker image

## Running

After building, run the container with:

```bash
docker run -p 8080:8080 easonwu/native-spring-boot-demo:latest
```

The application will be available at `http://localhost:8080/hello`

## Configuration

The hello message can be configured using the `hello` property. Default value will be "default message".

## Development

The main application is in [`NativeSpringBootDemoApplication`](src/main/java/com/yitech/demo/NativeSpringBootDemoApplication.java) which includes:
- REST controller with `/hello` endpoint
- Configurable message via Spring properties

## Testing

Run tests using Maven:

```bash
./mvnw test
```