k8s-ubuntu-desktop
==================
Docker image and k8s manifests for running a web-based Linux Desktop.

[![Docker Hub](https://hub.docker.com/r/jmcdice/k8s-ubuntu-desktop:latest)]

Quick Start
-------------------------

### Set a VNC password (update value: changeme)
```console
  $ kubectl create secret generic -n default vnc-password --from-literal=password='my_password'
```

### Deploy the container
```console
  $ kubectl create -f yml/ubuntu-desktop-deployment.yml
```

### (Optional: Create a NodePort service)
```console
  $ kubectl create -f yml/ubuntu-desktop-service.yml
```

### Connect to your desktop:
http://<HOSTIP>:<PORT>/vnc.html

## Clean up
```console
  $ kubectl delete secret vnc-password
  $ kubectl delete -f yml/ubuntu-desktop-deployment.yml
  $ kubectl delete -f yml/ubuntu-desktop-service.yml
```

