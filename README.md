### This repositiry manage reworking-dev infrastructure

We primary use following services 
1. EC2 service
2. S3 Bucket service
3. Application Load Balancer 
4. VPC 
5. IAM 
6. AWS Cloudformation 

## Set Up

### Steps

#### Step-1
Create one s3 bucket manually for storing backend of terraform OR you can remove provide.tf file so terraform will not have any backend

#### Step-2
Replace name of S3 bucket in backend.tf file 

#### Step-3
Initializes infrastructure using below command

```shell
tf init
```

#### Step-4
See plan of infrastructure using below command

```shell
tf plan
```

#### Step-5
Apply infrastructure using below command

```shell
tf apply --auto-approve
```

## notes

1. Your frontend EC2 public IP address is your front-end URL
2. backend load balancer URL is your backend URL
3. All infrastructure resources are in new VPC 
4. Cloudformation template used for creating S3 bucket and dynamo db table 
