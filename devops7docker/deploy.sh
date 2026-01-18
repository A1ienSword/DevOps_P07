#!/bin/bash -x
echo "Stopping and removing old container..."
docker stop nginx-cont 2>/dev/null
docker rm nginx-cont 2>/dev/null

echo "Building Docker image..."
docker build -t devops/nginx-server ./nginx

echo "Starting new container..."
docker run -d \
    --name nginx-cont \
    -p 54321:80 \
    --restart unless-stopped \
    devops/nginx-server

echo "Waiting for container to start..."
sleep 5

echo "Container status:"
docker ps -a | grep nginx-cont

echo "Testing web server..."
curl -s http://127.0.0.1:54321

echo "Container logs:"
docker logs -n 10 nginx-cont
