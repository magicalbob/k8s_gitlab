unset USE_KIND
# Check if kubectl is available in the system
if kubectl 2>/dev/null >/dev/null; then
  # Check if kubectl can communicate with a Kubernetes cluster
  if kubectl get nodes 2>/dev/null >/dev/null; then
    echo "Kubernetes cluster is available. Using existing cluster."
    export USE_KIND=0
  else
    echo "Kubernetes cluster is not available. Creating a Kind cluster..."
    export USE_KIND=X
  fi
else
  echo "kubectl is not installed. Please install kubectl to interact with Kubernetes."
  export USE_KIND=X
fi

if [ "X${USE_KIND}" == "XX" ]; then
    # Make sure kind cluster exists
    kind  get clusters 2>&1 | grep "kind-gitlab"
    if [ $? -gt 0 ]
    then
        envsubst < kind-config.yml.template > kind-config.yml
        kind create cluster --config kind-config.yml --name kind-gitlab
    fi
    
    # Make sure create cluster succeeded
    kind  get clusters 2>&1 | grep "kind-gitlab"
    if [ $? -gt 0 ]
    then
        echo "Creation of cluster failed. Aborting."
        exit 666
    fi
fi

# add metrics
kubectl apply -f https://dev.ellisbs.co.uk/files/components.yaml

# install local storage
kubectl apply -f  local-storage-class.yml

# create gitlab namespace, if it doesn't exist
kubectl get ns gitlab 2> /dev/null
if [ $? -eq 1 ]
then
    kubectl create namespace gitlab
fi

# sort out persistent volume
IS_IT_KIND=$(kubectl get nodes|grep -v ^NAME|head -n1|cut -d\  -f1)
if [ "${IS_IT_KIND}" == "kind-gitlab-control-plane" ];then
  export NODE_NAME=$(kubectl get nodes |grep control-plane|cut -d\  -f1|head -1)
  envsubst < gitlab.postgres.pv.kind.yml.template > gitlab.pv.yml
  envsubst < gitlab.etc.pv.kind.yml.template >> gitlab.pv.yml
else
  export NODE_NAME=$(kubectl get nodes | grep -v ^NAME|grep -v control-plane|cut -d\  -f1|head -1)
  envsubst < gitlab.postgres.pv.linux.yml.template > gitlab.pv.yml
  envsubst < gitlab.etc.pv.linux.yml.template >> gitlab.pv.yml
  echo mkdir -p ${PWD}/postgres-data|ssh -o StrictHostKeyChecking=no ${NODE_NAME}
fi
kubectl apply -f gitlab.pv.yml

# Install gitlab postgres
kubectl apply -f gitlab.postgres.yml -n gitlab

# Install gitlab deployment
kubectl apply -f gitlab.deploy.yml -n gitlab
