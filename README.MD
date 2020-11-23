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

![Screenshot]()


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

![Screenshot]()




