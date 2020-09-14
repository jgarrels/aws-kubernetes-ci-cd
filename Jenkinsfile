pipeline {
    agent any
    stages {
        stage('Linting') {
            steps {
                sh 'hadolint Dockerfile'
                sh 'tidy -q -e *.html'
            }
        }
    }
}