# Kubernetes CI/CD on AWS

## Prerequisites

For this project, you will need

- an AWS account

## Get started

- Create a Cloud9 coding environment. You can choose any instance size (I used the t2.micro which is free-tier eligible),
  but please make sure it runs Ubuntu (not Amazon Linux).
- Configure the Cloud9 EC2 instance's security group to allow Custom TCP access from your IP address on port 8080 (this will be used to access Jenkins in a browser).
- Clone this repository into your Cloud9 instance with `git clone https://github.com/jgarrels/aws-kubernetes-ci-cd` and go into the folder with `cd aws-kubernetes-ci-cd`.
- Run the following to set up the EBS volume and Jenkins: `make setup-ebs-size` and `make setup-jenkins`. It is important that you run `make setup-ebs-size` first.
- Use the output from `make setup-jenkins`: go to the public DNS address for the Jenkins interface displayed (something starting with ec2- and ending with :8080) 
  and enter the alphanumeric initial password displayed.

## Project description

This project deploys an application into a Kubernetes cluster on AWS, using the CI/CD tool Jenkins.