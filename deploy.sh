docker build -t simonpcpc/multi-client:latest -t simonpcpc/multi-client:$(SHA) -f ./client/Dockerfile ./client
docker build -t simonpcpc/multi-server:latest -t simonpcpc/multi-server:$(SHA) -f ./server/Dockerfile ./server
docker build -t simonpcpc/multi-worker:latest -t simonpcpc/multi-worker:$(SHA) -f ./worker/Dockerfile ./worker

docker push simonpcpc/multi-client:latest
docker push simonpcpc/multi-server:latest
docker push simonpcpc/multi-worker:latest

docker push simonpcpc/multi-client:$(SHA)
docker push simonpcpc/multi-server:$(SHA)
docker push simonpcpc/multi-worker:$(SHA)

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=simonpcpc/multi-client:$(SHA)
kubectl set image deployments/server-deployment server=simonpcpc/multi-server:$(SHA)
kubectl set image deployments/worker-deployment worker=simonpcpc/multi-worker:$(SHA)


