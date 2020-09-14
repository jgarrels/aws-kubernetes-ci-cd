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

setup-other:
	sudo apt-get update
	sudo apt-get -y install tidy
	sudo wget -O /bin/hadolint https://github.com/hadolint/hadolint/releases/download/v1.18.0/hadolint-Linux-x86_64
	sudo chmod +x /bin/hadolint

	
