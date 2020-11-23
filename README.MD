# Question-1

# Total time to setup EKS cluster and EKS nodes is around 20 mminutes

# EKS Cluster Creation

#Infrastructure as a code 


```console
Setup aws configure to run aws cloudformation 

i) Validate the cf yaml

aws cloudformation validate-template --template-body file://./amazon-eks-vpc-private-subnets-ekscluster.yaml  --region us-east-2

ii) run command:

eks-cluster-cf]$ aws cloudformation create-stack --stack-name vpc-eks-cluster-stack --template-body file://./amazon-eks-vpc-private-subnets-ekscluster.yaml --region us-east-2 --parameters ParameterKey=EKSClusterName,ParameterValue=ekscluster --capabilities CAPABILITY_NAMED_IAM
```
output:

![Screenshot](./eks-cluster-cf/eks-cluster-completed.PNG)


# EKS worker node group Creation

#Infrastructure as a code 


```console
Setup aws configure to run aws cloudformation 

i) Validate the cf yaml

aws cloudformation validate-template --template-body file://./amazon-eks-nodegroup.yaml --region us-east-2

ii) run command:

eks-cluster-cf]$ aws cloudformation create-stack --stack-name eks-node-group-stack --template-body file://./amazon-eks-nodegroup.yaml --region us-east-2 --parameters ParameterKey=ClusterControlPlaneSecurityGroup,ParameterValue=<> ParameterKey=NodeGroupName,ParameterValue=eks-node-group ParameterKey=KeyName,ParameterValue=<> 
ParameterKey=Subnets,ParameterValue=<> ParameterKey=VpcId,ParameterValue=<> ParameterKey=ClusterName,ParameterValue=<>
--capabilities CAPABILITY_NAMED_IAM


**Please take the reference of below requested parameters of VPC from EKS Cluster output

when calling the CreateStack operation: Parameters: [ClusterControlPlaneSecurityGroup, NodeGroupName, KeyName, Subnets, VpcId, ClusterName] must have values



```
output:

![Screenshot](./worker-nodes-cf/eks-workernodegroup-completed.PNG)


#Tools used :  Cloudformation, Jenkins(pipeline with inbuild plugins), git/github, docker/dockerhub, Ansible 

# Set up a KubeCtl server. Create a EC2 instance and execute following commands or pass as a userdata


```console

curl -o aws-iam-authenticator https://amazon-eks.s3.us-west-2.amazonaws.com/1.18.9/2020-11-02/bin/linux/amd64/aws-iam-authenticator

chmod +x ./aws-iam-authenticator

mkdir -p $HOME/bin && cp ./aws-iam-authenticator $HOME/bin/aws-iam-authenticator && export PATH=$PATH:$HOME/bin

curl -o kubectl https://amazon-eks.s3.us-west-2.amazonaws.com/1.17.12/2020-11-02/bin/linux/amd64/kubectl

chmod +x ./kubectl

mkdir -p $HOME/bin && cp ./kubectl $HOME/bin/kubectl && export PATH=$PATH:$HOME/bin

aws eks --region us-east-2 update-kubeconfig --name eks-cluster

export KUBECONFIG=~/.kube/config

```
* Details for above setup

Amazon EKS uses IAM to provide authentication to your Kubernetes cluster through the AWS IAM authenticator for Kubernetes 

# IAM Authenticator

c) Install IAM authenticator

```console

download the binary

https://docs.aws.amazon.com/eks/latest/userguide/install-aws-iam-authenticator.html

curl -o aws-iam-authenticator https://amazon-eks.s3.us-west-2.amazonaws.com/1.18.9/2020-11-02/bin/linux/amd64/aws-iam-authenticator

```

b) Apply execute permissions to the binary.

```console
chmod +x ./aws-iam-authenticator
```

c) Copy the binary to a folder in your $PATH. We recommend creating a $HOME/bin/aws-iam-authenticator and ensuring that $HOME/bin comes first in your $PATH.

```console
mkdir -p $HOME/bin && cp ./aws-iam-authenticator $HOME/bin/aws-iam-authenticator && export PATH=$PATH:$HOME/bin
```

d) check setup : aws-iam-authenticator help

```console
aws-iam-authenticator help
```
# Kubectl

a) Install Kubectl aws

```console
downlaod the binary
curl -o kubectl https://amazon-eks.s3.us-west-2.amazonaws.com/1.17.12/2020-11-02/bin/linux/amd64/kubectl
```
b) Apply execute permissions to the binary.

```console
chmod +x ./kubectl
```

c) Copy the binary to a folder in your PATH. If you have already installed a version of kubectl , then we recommend creating a $HOME/bin/kubectl and ensuring that $HOME/bin comes first in your $PATH.
```console
mkdir -p $HOME/bin && cp ./kubectl $HOME/bin/kubectl && export PATH=$PATH:$HOME/bin
```

d) check Kubectl :  kubectl version --short --client
```console
kubectl version --short --client
```

e) update kubectl config file for eks cluster demo is cluster name
```console
aws eks --region us-east-2 update-kubeconfig --name eks-cluster
```
f) Register the worker node with EKS cluster

```console
download the file from amazone

curl -o aws-auth-cm.yaml https://amazon-eks.s3-us-west-2.amazonaws.com/cloudformation/2019-02-11/aws-auth-cm.yaml

update the node instance role which is created after executed the worker node group  cloud formation in aws-auth-cm.yaml and run below command

kubectl apply -f aws-auth-cm.yaml
```



