k8s-ubuntu-desktop
==================
Docker image and k8s manifests for running a web-based Linux Desktop.

[Docker Hub](https://hub.docker.com/r/jmcdice/k8s-ubuntu-desktop)

Quick Start
-------------------------

### Create a NS and password secret
```console
  $ kubectl create ns desktop
  $ kubectl create secret generic -n desktop vnc-password --from-literal=password='my_password'
```

### Deploy the container
```console
  $ kubectl create -f yml/ubuntu-desktop-deployment.yml
```

### Optional: Create a service
```console
  $ kubectl create -f yml/ubuntu-desktop-service.yml
```

### port-forward to the desktop service
```console
  kubectl port-forward service/ubuntu-desktop -n desktop 8080:80
```

### Access the desktop UI
http://localhost:8080/vnc.html

## Clean up
```console
  $ kubectl delete ns desktop
```

## Run as a docker on localhost
```console
  $ docker run -p 6080:80 --name ubuntu-desktop -v $HOME:/home/mate/mount jmcdice/k8s-ubuntu-desktop:latest
  # Browse to: http://localhost:6080/vnc.html
```
