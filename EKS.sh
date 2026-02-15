aws configure
curl.exe -LO "https://dl.k8s.io/release/v1.32.0/bin/windows/amd64/kubectl.exe"
curl.exe -LO "https://dl.k8s.io/v1.32.0/bin/windows/amd64/kubectl.exe.sha256"
Invoke-WebRequest -Uri "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_Windows_amd64.zip" -OutFile "eksctl.zip"
Expand-Archive -Path "eksctl.zip" -DestinationPath "C:\eksctl"
[Environment]::SetEnvironmentVariable("Path", "$env:Path;C:\eksctl", [EnvironmentVariableTarget]::Machine)
eksctl create cluster --name=kscluster --region=us-east-1 --zones=us-east-1a,us-east-1b --without-nodegroup
eksctl utils associate-iam-oidc-provider --cluster kscluster --approve
eksctl create nodegroup --cluster=kscluster --region=us-east-1 --name=kseks-node-group --node-type=t3.medium --nodes=2 --nodes-min=2 --nodes-max=3  --node-volume-size=20 --ssh-access --ssh-public-key=ksaws --managed --asg-access --external-dns-access  --appmesh-access --full-ecr-access --appmesh-access --alb-ingress-access
