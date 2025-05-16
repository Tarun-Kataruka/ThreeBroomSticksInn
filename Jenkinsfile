pipeline {
  agent any

  environment {
    IMAGE_NAME = "tarun2210/threebroomsticks-inn"
    IMAGE_TAG = "${env.BUILD_ID}"
    DOCKER_CREDENTIALS_ID = "docker-creds"
    KUBE_CONFIG_ID = "kubeconfig"
  }

  stages {
    stage('Checkout') {
      steps {
        git credentialsId: 'github-creds', url: 'https://github.com/Tarun-Kataruka/ThreeBroomSticksInn.git'
      }
    }

    stage('Validate Code') {
      steps {
        // Use sh with direct command rather than multiline script
        sh 'export PATH="/opt/homebrew/bin:$PATH" && pip install html5validator'
        sh 'export PATH="/opt/homebrew/bin:$PATH" && html5validator --root . --show-warnings || true'
        sh 'export PATH="/opt/homebrew/bin:$PATH" && npm install -g csslint || true'
        sh 'export PATH="/opt/homebrew/bin:$PATH" && find . -name "*.css" -exec csslint {} \\; || true'
      }
    }

    stage('Build Docker Image') {
      steps {
        script {
          docker.build("${IMAGE_NAME}:${IMAGE_TAG}")
        }
      }
    }

    stage('Push Docker Image') {
      steps {
        withCredentials([usernamePassword(credentialsId: "${DOCKER_CREDENTIALS_ID}", usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
          // Break down complex multiline script into individual sh steps
          sh 'echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin'
          sh "docker tag ${IMAGE_NAME}:${IMAGE_TAG} ${IMAGE_NAME}:latest"
          sh "docker push ${IMAGE_NAME}:${IMAGE_TAG}"
          sh "docker push ${IMAGE_NAME}:latest"
        }
      }
    }

    stage('Deploy to Kubernetes') {
      steps {
        withCredentials([file(credentialsId: "${KUBE_CONFIG_ID}", variable: 'KUBECONFIG')]) {
          sh 'kubectl apply -f k8s/deployment.yaml'
          sh 'kubectl apply -f k8s/service.yaml'
        }
      }
    }
  }

  post {
    always {
      cleanWs()
    }
  }
}