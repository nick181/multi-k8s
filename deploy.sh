docker build -t nihal181/multi-client:latest -t nihal181/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t nihal18/multi-server:latest -t nihal181/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t nihal181/multi-worker:latest -t nihal181/multi-worker:$SHA ./worker/Dockerfile ./worker
docker push nick181/multi-client:latest
docker push nick181/multi-server:latest
docker push nick181/multi-worker:latest

docker push nick181/multi-client:latest:$SHA
docker push nick181/multi-server:latest:$SHA
docker push nick181/multi-worker:latest:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=nihal181/multi-server:$SHA
kubectl set image deployments/client-deployment client=nihal181/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=nihal181/multi-worker:$SHA
