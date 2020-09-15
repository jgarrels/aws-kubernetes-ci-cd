# Kubernetes CI/CD on AWS

## Prerequisites

For this project, you will need

- an AWS account

## Get started

- Create a Cloud9 coding environment. You can choose any instance size (I used the t2.micro which is free-tier eligible),
  but please make sure it runs Ubuntu (not Amazon Linux).
- Enter your own AWS credentials (e.g. the ones associated with the IAM user you used for creating the Cloud9 environment). When prompted, click cancel 
  (do not force a credentials update which would give you another set of temporary credentials) and then "disable permanently" (this will prevent AWS from 
  overwriting your credentials with yet another set of temporar ones). Otherwise, you could run into problems with the EKS cluster if you have temporary credentials.
- Configure the Cloud9 EC2 instance's security group to allow Custom TCP access from your IP address on port 8080 (this will be used to access Jenkins in a browser).
- Clone this repository into your Cloud9 instance with `git clone https://github.com/jgarrels/aws-kubernetes-ci-cd` and go into the folder with `cd aws-kubernetes-ci-cd`.
- Run `make setup` to configure the EBS storage size, install and start Jenkins and other dependencies. If you get an error, run `make setup` again and 
  it should run without problems. Should you need to run the make steps included in setup separately, it is important that you run `make setup-ebs-size` first.
- Use the output from `make setup-jenkins` (the last step in `make setup` - its output should be displayed as the last thing in the terminal):
  go to the public DNS address for the Jenkins interface displayed (something starting with ec2- and ending with :8080)
  and enter the alphanumeric initial password displayed.
- Set up Jenkins: Choose "Install suggested plugins", then create an admin user.
  Go to "Manage Jenkins" -> "Manage plugins" -> "Available" and install "Blue Ocean - Blue Ocean Aggregator".
- Go back to the Jenkins landing page and click on "Blue Ocean" in the sidebar on the left.
- Create a pipeline: create a GitHub token, select the repository and create the pipeline.
- Go to the classic Jenkins view, to the pipeline, and under "Configure" set "Scan Repository Triggers" to something reasonable (e.g. 2 minutes for demo purposes).
- Wait for the pipeline to run and view the results.

## Project description

This project deploys an application into a Kubernetes cluster on AWS, using the CI/CD tool Jenkins.