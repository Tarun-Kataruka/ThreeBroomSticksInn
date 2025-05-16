// jenkinsfile for a simple web application that validates HTML and CSS, builds a Docker image, pushes it to Docker Hub, and deploys it to a Kubernetes cluster.

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
        git 'https://github.com/YOUR_USERNAME/YOUR_REPO.git'
      }
    }

    stage('Validate Code') {
      steps {
        sh 'pip install html5validator'
        sh 'html5validator --root . --show-warnings'
        sh 'npm install -g csslint'
        sh 'csslint **/*.css || true'
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
        withCredentials([usernamePassword(credentialsId: DOCKER_CREDENTIALS_ID, usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
          sh """
            echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
            docker tag ${IMAGE_NAME}:${IMAGE_TAG} ${IMAGE_NAME}:latest
            docker push ${IMAGE_NAME}:${IMAGE_TAG}
            docker push ${IMAGE_NAME}:latest
          """
        }
      }
    }

    stage('Deploy to Kubernetes') {
      steps {
        withCredentials([file(credentialsId: KUBE_CONFIG_ID, variable: 'KUBECONFIG')]) {
          sh '''
            kubectl apply -f k8s/deployment.yaml
            kubectl apply -f k8s/service.yaml
          '''
        }
      }
    }
  }
}
