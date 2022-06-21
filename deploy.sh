docker build -t simonpcpc/multi-client:latest -t simonpcpc/multi-client:${{ env.SHA }} -f ./client/Dockerfile ./client
docker build -t simonpcpc/multi-server:latest -t simonpcpc/multi-server:${{ env.SHA }} -f ./server/Dockerfile ./server
docker build -t simonpcpc/multi-worker:latest -t simonpcpc/multi-worker:${{ env.SHA }} -f ./worker/Dockerfile ./worker

docker push simonpcpc/multi-client:latest
docker push simonpcpc/multi-server:latest
docker push simonpcpc/multi-worker:latest

docker push simonpcpc/multi-client:${{ env.SHA }}
docker push simonpcpc/multi-server:${{ env.SHA }}
docker push simonpcpc/multi-worker:${{ env.SHA }}

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=simonpcpc/multi-client:${{ env.SHA }}
kubectl set image deployments/server-deployment server=simonpcpc/multi-server:${{ env.SHA }}
kubectl set image deployments/worker-deployment worker=simonpcpc/multi-worker:${{ env.SHA }}


