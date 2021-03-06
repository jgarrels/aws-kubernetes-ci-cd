pipeline {
    agent any
    stages {
        stage('Linting') {
            steps {
                sh "hadolint Dockerfile"
                sh "tidy -q -e *.html"
            }
        }
        stage('Build Docker image and run it locally') {
            steps {
                sh 'echo "Now building Docker image"'
                withCredentials([usernamePassword(credentialsId: 'docker', passwordVariable: 'dockerPassword', usernameVariable: 'dockerUsername')]) {
                    sh "docker login -u ${env.dockerUsername} -p ${env.dockerPassword}"
                    sh "echo 'remove docker container if exists'"
                    sh "docker rm -f capstone || true"
                    sh "docker build --tag ${env.dockerUsername}/capstone:1.2 ."
                    sh "docker push ${env.dockerUsername}/capstone:1.2"
                    sh "docker run -d -p 8000:80 --name capstone ${env.dockerUsername}/capstone"
                }
            }
        }
        stage('Deploying to AWS EKS') {
            steps {
                echo 'Deploying to AWS EKS'
                withAWS(credentials: 'aws', region: 'us-west-2') {
                    sh "aws eks --region us-east-2 update-kubeconfig --name capstone"
                    sh "kubectl apply -f ./deployment.yml"
                    sh "kubectl apply -f ./service.yml"
                    sh "kubectl get deployments"
                    sh "kubectl get nodes"
                    sh "kubectl get pods"
                    sh "kubectl get -o wide svc capstone-loadbalancer"
                    sh "kubectl describe svc capstone-loadbalancer"
                }
            }
        }
    }
}
