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
                sh 'echo "Implement this"'
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
