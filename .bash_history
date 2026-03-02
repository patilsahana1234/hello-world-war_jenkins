clear
sudo apt update
sudo swapoff -a
sudo sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab
sudo tee /etc/modules-load.d/containerd.conf <<EOF
overlay
br_netfilter
EOF

sudo modprobe overlay
sudo modprobe br_netfilter
sudo tee /etc/sysctl.d/kubernetes.conf <<EOF
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.ip_forward = 1
EOF

sudo sysctl --system
sudo apt install -y ca-certificates curl gnupg lsb-release
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update
sudo apt install -y containerd.io
containerd config default | sudo tee /etc/containerd/config.toml >/dev/null 2>&1
sudo sed -i 's/SystemdCgroup = false/SystemdCgroup = true/g' /etc/containerd/config.toml
sudo systemctl restart containerd
sudo systemctl enable containerd
sudo systemctl status containerd
sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl gpg
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.33/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.33/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update
sudo apt-get install -y kubelet=1.33.0-1.1 kubeadm=1.33.0-1.1 kubectl=1.33.0-1.1
sudo apt-mark hold kubelet kubeadm kubectl
sudo systemctl enable --now kubelet
vi kubeadm-config.yaml
sudo kubeadm init --config kubeadm-config.yaml
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
export KUBECONFIG=/etc/kubernetes/admin.conf
kubectl apply -f https://raw.githubusercontent.com/projectcalico/calico/v3.28.0/manifests/calico.yaml
kubectl get nodes
helm repo add aws-cloud-controller-manager https://kubernetes.github.io/cloud-provider-aws
snap install helm --classic
helm repo update
helm repo add aws-cloud-controller-manager https://kubernetes.github.io/cloud-provider-aws
helm repo update
vi aws-ccm-values.yaml
helm install aws-cloud-controller-manager aws-cloud-controller-manager/aws-cloud-controller-manager   --namespace kube-system   --create-namespace   --values aws-ccm-values.yaml
helm status aws-cloud-controller-manager -n kube-system

kubectl get pods -A
kubectl get nodes
kubectl get pods -A
kubectl taint nodes ip-172-31-31-57 node.cloudprovider.kubernetes.io/uninitialized-
kubectl get pods -A
kubectl get nodes
kubectl get pods -n cube-system
kubectl get pods -n kube-system

kubectl get pods -n kube-system -owide
history
kubectl get nodes
vi nginx-pod.yaml
kubectl apply -f nginx-pod.yaml
kubectl get pods
vi nginx-elb.yaml
kubectl apply -f nginx-elb.yaml 
kubectl get pods
kubectl get pods -A
kubectl get pods 
kubectl get svc
kubectl get pods 
kubectl get pods -owide
ls
node.cloudprovider.kubernetes.io/uninitialized-
kubectl get pods -owide
kubectl get pods -A
node.cloudprovider.kubernetes.io/uninitialized-
kubectl get nodes
kubectl get pods -A
kubectl describe pod nginx-pod
kubectl get nodes -o wide
kubectl get pods -A
kubectl describe node ip-172-31-31-57 | grep Taint -A 3
kubectl describe node ip-172-31-16-40 | grep Taint -A 3
kubectl taint nodes ip-172-31-31-57 node-role.kubernetes.io/control-plane-
kubectl describe node ip-172-31-31-57 | grep Taint
kubectl describe node ip-172-31-16-40 | grep Taint -A 3
kubectl taint nodes ip-172-31-16-40 node.cloudprovider.kubernetes.io/uninitialized-
kubectl get pods -o wide
kubectl get pods -A
kubectl get svc
vi replicaset.yaml
kubectl apply -f replicaset.yaml
kubectl get pods 
kubectl get replicaset
kubectl getpods --show-labels
kubectl get pods --show-labels
kubectl delete pod nginx-rs-2lff2
kubectl get pods
vi replicaset.yaml
kubectl scale rs nginx-rs --replicas=3
kubectl get pods
kubectl get pods --show-labels
kubectl get pods -A
kubectl get pods -o wide
curl 10.244.166.202:80
kubectl get nodes
kubectl get pods
kubectl create namespace QA
clear
kubectl get nodes
kubectl get pods
kubectl create namespace sahana
kubectl get namespace
ls
vi nginx-pod.yaml
kubectl apply -f nginx-pod.yaml
kubectl get pods
kubectl get pods -n sahana
ls
kubectl apply -f nginx-elb.yaml -n sahana
kubectl get pods -n sahana
kubectl get svc
kubectl get svc -n sahana
ls
kubectl delete pods --all
kubectl delete deployment --all
kubectl delete rs --all
kubectl get pods
ls
vi replicaset.yaml 
kubectl apply -f replicaset.yaml 
kubectl get pods
vi replicaset.yaml 
clear
ls
vi replicaset.yaml 
kubectl apply -f replicaset.yaml
kubectl get pods
cat replicaset.yaml 
clear
ls
vi replicaset.yaml 
kubectl apply -f replicaset.yaml
kubectl get pods
cat replicaset.yaml 
kubectl delete pods --all
clear

vi replicaset.yaml
kubectl apply -f replicaset.yaml
kubectl get pods
kubectl get pods -owide
kubectl get rs
vi deployment.yaml
kubectl apply -f deployment.yaml
kubectl get deployment
vi deployment.yaml 
kubectl apply -f deployment.yaml

kubectl delete replicaset --all
kubectl apply -f deployment.yaml
kubectl get pods
kubectl get deployment
vi deployment.yaml 
kubectl apply -f deployment.yaml
kubectl get deployment
kubectl get replicaset
vi deployment.yaml 
kubectl get deployment
vi deamonset.yml
kubectl apply -f deamonset.yml
kubectl get deamonset
kubectl get daemonset
kubectl get pods
vi deamonset.yml
kubectl get nodes
clear
hjuyte
clear
nhgtyu
sahana
abcde
clear
mnopq
clear
kubectl get pods
kubectl get pods --delete all

kubectl get --help
clear
kubectl delete pods --all
kubectl get pods
clear
kubectl get nodes
clear
kubectl get nodes
kubectl create namespace n8n
vi postgres-deployment.yaml
kubectl apply -f postgres-deployment.yaml
vi n8n-deployment.yaml
kubectl apply -f n8n-deployment.yaml
kubectl get pods -n n8n -o wide
vi n8n-deployment.yaml
vi postgres-deployment.yaml
kubectl describe pod <one-evicted-pod-name> -n n8n
kubectl delete pod --all -n n8n
kubectl apply -f n8n-deployment.yaml
kubectl get pods -n n8n -o wide
kubectl get nodes
vi postgres-deployment.yaml
vi n8n-deployment.yaml
kubectl apply -f postgres.yaml
vi postgres-deployment.yaml
kubectl apply -f postgres-deployment.yaml
kubectl apply -f n8n-deployment.yaml
kubectl delete pod --all -n n8n
kubectl get pods -n n8n -o wide
kubectl taint nodes ip-172-31-31-57 node-role.kubernetes.io/control-plane-
df -h
vi postgres-deployment.yaml
vi n8n-deployment.yaml
kubectl apply -f postgres-deployment.yaml
kubectl apply -f n8n-deployment.yaml
kubectl delete pod --all -n n8n
kubectl get pods -n n8n -o wide
kubectl logs postgres-548fc859db-psqhn -n n8n
kubectl get pods -n n8n -o wide
sudo reboot
kubectl get pods -n n8n -o wide
kubectl get svc -n n8n
curl http://localhost:30080
sudo ss -tulpn | grep 30080
sudo netstat -tulpn | grep 30080
curl http://localhost:30080
curl -v http://localhost:30080
kubectl edit deployment n8n -n n8n
curl -v http://localhost:30080
kubectl logs deployment/n8n -n n8n
kubectl edit deployment n8n -n n8n
kubectl get pods -n n8n -w
curl -v http://localhost:30080
kubectl describe svc n8n-service -n n8n
vi n8n-deployment.yaml
kubectl get pods -n n8n -w
curl -v http://localhost:30080
kubectl exec -it n8n-5c48899d5c-4nw6t -n n8n -- sh
kubectl describe pod n8n-88d5ff79f-z72np -n n8n
df -h
sudo crictl images
sudo crictl rmi --prune
sudo journalctl --vacuum-time=2d
sudo systemctl restart kubelet
sudo growpart /dev/nvme0n1 1
sudo resize2fs /dev/nvme0n1p1
df -h
kubectl delete pod --all -n n8n
kubectl get pods -n n8n -w
