pipeline {
    agent any
    stages {
        stage('Linting') {
            steps {
                sh "hadolint Dockerfile"
                sh "tidy -q -e *.html"
            }
        }
        stage('Build Docker image') {
            steps {
                sh 'echo "Now building Docker image"'
                withCredentials([usernamePassword(credentialsId: 'docker', passwordVariable: 'dockerPassword', usernameVariable: 'dockerUsername')]) {
                    sh "docker login -u ${env.dockerUsername} -p ${env.dockerPassword}"
                    sh "docker build --tag ${env.dockerUsername}/capstone:1.0 ."
                    sh "docker push ${env.dockerUsername}/capstone:1.0"
                }
            }
        }
        stage('Run Docker image on Kubernetes on Code9 EC2 instance') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'docker', passwordVariable: 'dockerPassword', usernameVariable: 'dockerUsername')]) {
                    sh 'echo "Now deploying Docker image to local Kubernetes cluster"'
                    sh "docker login -u ${env.dockerUsername} -p ${env.dockerPassword}"
                    sh "docker run -p 8000:80 --name capstone capstone:1.0"
                    sh "kubectl run capstone --image=${env.dockerUsername}/capstone"
                    sh "kubectl get pods"
                    sh "kubectl port-forward capstone 8000:80"
                }
            }
        }
    }
}
