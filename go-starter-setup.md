## Run golang service in pods

1. run minikube
   `minikube start --driver=hyperkit`
2. watch components:
   `watch kubectl get all -o wide`
3. deploy go starter in pods

4. run database
   `kubectl apply -f pods/go-starter-db.yaml`
5. initialize database with new user and database

```bash
## get inside docker container of postgres
## first get docker container id, then run `docker exec -it <container_id> bash`
## for the above command to work you have to set local docker context to minikube docker context => `eval $(minikube docker-env)`

## create user
psql -U postgres -c "create user paymentuser password 'db@password'"
## create database
psql -U postgres -c "create database payment_db_go owner=paymentuser"
```

or do this: https://stackoverflow.com/questions/67316206/how-to-create-a-role-and-a-database-with-kubectl-and-the-chart-of-postgresql

- `kubectl exec -i postgres-pod -- psql -U postgres -c "create user paymentuser password 'db@password'"`
- `kubectl exec -i postgres-pod -- psql -U postgres -c "create database payment_db_go owner=paymentuser"`

6. run service

- just make sure to use the same db password as above

```bash
kubectl apply -f pods/go-starter.yaml
```

7. Verify

- ssh into minikube cluster => `minikube ssh`
- get ip of go starter, it is same as pod ip which is running go-starter
- curl `<ip>:8888/health`

## Run golang service in rs

1. run go starter replica set
   `kubectl apply -f rs/go-starter-rs.yaml`
2. Database: Im assuming we will use the same database as above
3. Access service:
   1. you can use pod ip to access the service

### creating service to access the go starter

1. cluster ip: is only accessible within the cluster
   `kubectl apply -f svc/go-starter-cluster-ip.yaml`
2. node port: node ip + exposed node port can be used to access the service outside the cluster
   `kubectl apply -f svc/go-starter-node-port.yaml`
   - to get node ip, use `minikube ip`
