set -e 

function delete_deployment() {

  kubectl delete secret vnc-password
  kubectl delete -f yml/ubuntu-desktop-deployment.yml
  kubectl delete -f yml/ubuntu-desktop-service.yml
}


function docker_build() {

  DOCKER='jmcdice/k8s-ubuntu-desktop:latest'

  # Build and Push Docker
  docker build --rm -t ${DOCKER} .
  docker push ${DOCKER}
}

function create_deployment() {
  # Deploy to k8s
  kubectl create secret generic -n default vnc-password --from-literal=password='my_password'
  kubectl create -f yml/ubuntu-desktop-deployment.yml
  kubectl create -f yml/ubuntu-desktop-service.yml
}

docker_build
create_deployment
