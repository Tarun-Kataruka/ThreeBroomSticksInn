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
        withEnv(['PATH+HOME=/opt/homebrew/bin']) {
          sh '''#!/bin/bash
            pip install html5validator
            html5validator --root . --show-warnings
            npm install -g csslint
            csslint **/*.css || true
          '''
        }
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
          sh '''#!/bin/bash
            echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
            docker tag ${IMAGE_NAME}:${IMAGE_TAG} ${IMAGE_NAME}:latest
            docker push ${IMAGE_NAME}:${IMAGE_TAG}
            docker push ${IMAGE_NAME}:latest
          '''
        }
      }
    }

    stage('Deploy to Kubernetes') {
      steps {
        withCredentials([file(credentialsId: KUBE_CONFIG_ID, variable: 'KUBECONFIG')]) {
          sh '''#!/bin/bash
            kubectl apply -f k8s/deployment.yaml
            kubectl apply -f k8s/service.yaml
          '''
        }
      }
    }
  }
}
