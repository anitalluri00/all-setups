#vim .bashrc
#export PATH=$PATH:/usr/local/bin/
#source .bashrc


#! /bin/bash
aws configure
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
wget https://github.com/kubernetes/kops/releases/download/v1.25.0/kops-linux-amd64
chmod +x kops-linux-amd64 kubectl
mv kubectl /usr/local/bin/kubectl
mv kops-linux-amd64 /usr/local/bin/kops

aws s3api create-bucket --bucket anirudhs3bick007.k8s.local --region ap-south-1
aws s3api put-bucket-versioning --bucket anirudhs3bick007.k8s.local --region ap-south-1 --versioning-configuration Status=Enabled
export KOPS_STATE_STORE=s3://anirudhs3bick007.k8s.local
kops create cluster --name rahams.k8s.local --zones ap-south-1a --master-count=1 --master-size t2.large --node-count=2 --node-size t2.2xlarge
kops update cluster --name rahams.k8s.local --yes --admin
