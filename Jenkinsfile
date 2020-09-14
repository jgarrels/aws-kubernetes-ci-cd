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
            echo 'Now building Docker image'
            steps {
                sh 'echo "Implement this"'
            }
        }
        stage('Deploy to AWS EKS') {
            echo 'Now deploying Docker image to AWS EKS'
            steps {
                sh 'echo "Implement this"'
            }
        }
    }
}
