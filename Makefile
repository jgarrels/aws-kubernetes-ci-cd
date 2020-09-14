setup-ebs-size:
	# make the attached EBS volume big enough for this project:
	sh resize.sh 50

setup-jenkins:
	# Install Jenkins, a CI/CD tool
	wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -
	sudo sh -c 'echo deb https://pkg.jenkins.io/debian-stable binary/ > \
    /etc/apt/sources.list.d/jenkins.list'
	sudo apt-get update
	sudo apt-get -y install openjdk-8-jdk jenkins
	
	# start Jenkins
	sudo systemctl start jenkins
	
	# check Jenkins status
	sudo systemctl status jenkins
	
	# get the public DNS address of this EC2 instance for accessing Jenkins:
	curl -s http://169.254.169.254/latest/meta-data/public-hostname >> public_dns.txt
	echo ":8080" >> public_dns.txt
	
	# open Jenkins here:
	cat public_dns.txt
	
	# the initial password required by Jenkins should be:
	sudo cat /var/lib/jenkins/secrets/initialAdminPassword
	# If this throws an error, please use the file location indicated 
	# in the Jenkins interface.
	
	# grant Jenkins and Docker permissions to each other
	sudo usermod -aG docker jenkins
	sudo systemctl restart jenkins

setup-other:
	sudo apt-get update
	
	# install tidy
	sudo apt-get -y install tidy
	
	# install hadolint
	sudo wget -O /bin/hadolint https://github.com/hadolint/hadolint/releases/download/v1.18.0/hadolint-Linux-x86_64
	sudo chmod +x /bin/hadolint
	
	# install eksctl
	curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_Linux_amd64.tar.gz" | tar xz -C /tmp
	sudo mv /tmp/eksctl /usr/local/bin
	eksctl version
	
	# install kubectl
	sudo apt-get update && sudo apt-get install -y apt-transport-https gnupg2
	curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
	echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
	sudo apt-get update
	sudo apt-get install -y kubectl
	# kubectl version
	kubectl version --client
	
	# install minikube
	curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 \
		&& sudo chmod +x minikube
	sudo mkdir -p /usr/local/bin/
	sudo install minikube /usr/local/bin/
	
	# grant Jenkins and Docker access to each other
	sudo usermod -a -G docker $(USER)

setup: setup-ebs-size setup-other setup-jenkins
