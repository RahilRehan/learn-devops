## Deploy payment backend

### 1. Setup minikube

```bash
$ brew install minikube
$ minikube start --driver=hyperkit
$ eval $(minikube docker-env)
$ minikube addons enable ingress
$ cd k8s-practice
```

After running above steps, we will have a local 1 node k8s cluster running with docker cri exposed to our terminal.

### 2. Copy payment-backend image to minikube images

```bash
# do not run the below command, it was used to create the image to save time
$ docker save -o images/payment-backend-latest.tar demo_payment-service:latest

# import image to minikube
docker load --input images/payment-backend-latest.tar
```

### 3. Deploy payment backend using helm

```bash
$ helm install payment-backend payment-backend
```

### 4. Create db and user in postgres

```bash
# replace payment-pod with pod name of db
$ `kubectl exec -i postgres-pod -- psql -U postgres -c "create user paymentuser password 'db@password'"`
$ `kubectl exec -i postgres-pod -- psql -U postgres -c "create database payment_db_go owner=paymentuser"`
# restart the payment-backend deployment
$ kubectl rollout restart deployment.apps/payment-backend-depl
```

### 5. Test the deployment

```bash
# enable ingress in minikube
$ kubectl get ingress # may take sometime to update the ip address of cluster
$ curl <IP>/health # or use postman and have fun
```
