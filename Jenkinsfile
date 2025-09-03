pipeline {
    agent any
    environment {
        DOCKER_IMAGE = "sri642/springboot-app-hello:${BUILD_NUMBER}"
        DOCKER_HUB_CREDS = "Docker_token"
        KUBE_NAMESPACE = "srilatha-namespace"
    }
    tools{
        maven 'maven3'
    }
    stages {
        stage('Checkout') {
            steps {
                git credentialsId: 'Github_token', url: 'https://github.com/20NN1A05F0/SpringBoot_Application.git', branch: 'main'
            }
        }
        stage('Build with Maven') {
            steps {
                sh 'mvn clean package'
            }
        }
        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $DOCKER_IMAGE .'
            }
        }
        stage('Push to Docker Hub') {
            steps {
                withCredentials([usernamePassword(credentialsId: "$DOCKER_HUB_CREDS", usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh 'echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin'
                    sh 'docker push $DOCKER_IMAGE'
                }
            }
        }
        stage('Deploy to EKS') {
            steps {
                sh '''
                  sed -i "s@<IMAGE_PLACEHOLDER>@$DOCKER_IMAGE@g" k8s/deployment.yaml
                  kubectl apply -f k8s/namespace.yaml
                  kubectl apply -n srilatha-namespace -f k8s/deployment.yaml
                '''
            }
        }
    }
}









/*pipeline {
    agent any

    triggers {
        githubPush()
    }
    tools{
        maven 'Maven'
    }
    environment {
        SONARQUBE_URL = 'https://9f4c4c55e951.ngrok-free.app'
        SONARQUBE_TOKEN = credentials ('SonarQube_token')
    }
    stages {
        stage('Checkout'){
            steps{
                git branch: 'main', credentialsId: 'Github_token', url: 'https://github.com/20NN1A05F0/SpringBoot_Application'
                sh 'ls -la'
            }
        }
        stage('Build'){
            steps{
                sh 'mvn clean install'
            }
        }
        stage('Package'){
            steps{
                sh 'mvn package'
            }
        }
        stage('SonarQube Analysis'){
            steps{
                sh '''
                mvn sonar:sonar \
                  -Dsonar.projectKey=springboot-demo \
                  -Dsonar.host.url=https://9f4c4c55e951.ngrok-free.app \
                  -Dsonar.login=$SONARQUBE_TOKEN
                '''
            }
        }
        stage('Deploy'){
            steps{
                sh '''
                nohup java -jar target/simple-hello-Srilatha-1.0.0.jar --server.port=9090 > app.log 2>&1 &
                '''
            }
        }
    }
}*/
