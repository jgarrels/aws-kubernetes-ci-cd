pipeline {
    agent any
    stages {
        stage('Linting') {
            steps {
                sh 'hadolint Dockerfile'
                sh 'tidy -q -e *.html'
            }
        }
        stage('Build Docker image') {
            steps {
                sh 'echo "Now building Docker image"'
                withCredentials([usernamePassword(credentialsId: 'docker', passwordVariable: 'dockerPassword', usernameVariable: 'dockerUsername')]) {
                    sh "sudo docker login -u ${env.dockerUsername} -p ${env.dockerPassword}"
                    sh "sudo docker build --tag ${env.dockerUsername}/capstone:1.0 ."
                    sh "sudo docker push --tag ${env.dockerUsername}/capstone:1.0"
                }
            }
        }
        stage('Deploy to AWS EKS') {
            steps {
                sh 'echo "Now deploying Docker image to AWS EKS"'
                sh 'echo "Implement this"'
            }
        }
    }
}
