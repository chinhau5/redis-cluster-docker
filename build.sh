docker build -t redis-cluster .
docker tag redis-cluster chinhau5/redis-cluster:latest
docker push chinhau5/redis-cluster
