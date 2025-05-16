pipeline {
  agent any

  environment {
    IMAGE_NAME = "tarun2210/threebroomsticks-inn"
    IMAGE_TAG = "${env.BUILD_ID}"
    DOCKER_CREDENTIALS_ID = "docker-creds"
    KUBE_CONFIG_ID = "kubeconfig"
    PATH+EXTRA = "/opt/homebrew/bin" // Ensures proper path handling on macOS
  }

  stages {
    stage('Checkout') {
      steps {
        git credentialsId: 'github-creds', url: 'https://github.com/Tarun-Kataruka/ThreeBroomSticksInn.git'
      }
    }

    stage('Validate Code') {
      steps {
        sh '''#!/bin/bash
          set -e
          echo "🔍 Installing and running HTML5 validator..."
          pip install --user html5validator
          ~/.local/bin/html5validator --root . --show-warnings

          echo "🎨 Installing and running CSSLint..."
          npm install -g csslint
          csslint **/*.css || echo "⚠️ CSS warnings found but continuing..."
        '''
      }
    }

    stage('Build Docker Image') {
      steps {
        script {
          echo "🐳 Building Docker image ${IMAGE_NAME}:${IMAGE_TAG}..."
          docker.build("${IMAGE_NAME}:${IMAGE_TAG}")
        }
      }
    }

    stage('Push Docker Image') {
      steps {
        withCredentials([usernamePassword(credentialsId: DOCKER_CREDENTIALS_ID, usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
          sh '''#!/bin/bash
            set -e
            echo "🔐 Logging into Docker Hub..."
            echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin

            echo "📦 Pushing Docker images..."
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
            set -e
            echo "🚀 Deploying to Kubernetes..."
            kubectl apply -f k8s/deployment.yaml
            kubectl apply -f k8s/service.yaml
          '''
        }
      }
    }
  }
}
