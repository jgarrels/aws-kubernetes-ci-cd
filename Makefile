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


	
