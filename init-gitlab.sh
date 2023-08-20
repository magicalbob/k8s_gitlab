# Create gitlab namespace
kubectl create namespace gitlab || true

# Install gitlab deployment
kubectl apply -f gitlab.deploy.yml -n gitlab

echo "DEBUG: Wait for gitlab to be running"
until kubectl get pod -n gitlab|grep gitlab|grep -v postgresql|grep 1/1; do
  sleep 5
done

echo "DEBUG: Wait for port 80"
until kubectl exec $(kubectl get pod -n gitlab|grep gitlab|grep -v postgresql|grep 1/1|head -n1|cut -d\  -f1) -n gitlab -- curl -s 127.0.0.1:80 ; do
  echo "Sleep 5"
  sleep 5
done

echo "DEBUG: Now port-froward to the deployment (re-launching on failure)"
while true
do
    kubectl port-forward -n gitlab deployment/gitlab --address 192.168.0.8 8081:80
    sleep 2
done



