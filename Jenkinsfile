pipeline {
  agent any

  environment {
    IMAGE_NAME = "tarun2210/threebroomsticks-inn"
    IMAGE_TAG = "latest"  // Always deploy latest tag
    KUBE_CONFIG_ID = "kubeconfig"  // Jenkins credentials ID for kubeconfig file
    DOCKERHUB_CREDENTIALS = credentials('docker-creds')  // Jenkins Docker Hub credentials ID
  }

  stages {
    stage('Pull Latest Image') {
      steps {
        sh '''
          echo "Logging into Docker Hub..."
          docker login -u ${DOCKERHUB_CREDENTIALS_USR} -p ${DOCKERHUB_CREDENTIALS_PSW}
          echo "Pulling Docker image: ${IMAGE_NAME}:${IMAGE_TAG}"
          docker pull ${IMAGE_NAME}:${IMAGE_TAG}
        '''
      }
    }

    stage('Deploy to Kubernetes') {
      steps {
        withCredentials([file(credentialsId: "${KUBE_CONFIG_ID}", variable: 'KUBECONFIG')]) {
          sh '''
            echo "Deploying image: ${IMAGE_NAME}:${IMAGE_TAG}"

            kubectl set image deployment/threebroomsticks-deployment \
              threebroomsticks-container=${IMAGE_NAME}:${IMAGE_TAG} --record

            kubectl rollout status deployment/threebroomsticks-deployment --timeout=300s

            echo "Listing pods with label app=threebroomsticks:"
            kubectl get pods -l app=threebroomsticks
          '''
        }
      }
    }
  }

  post {
    success {
      echo "Deployment completed successfully!"
    }
    failure {
      echo "Deployment failed! Rolling back..."
      withCredentials([file(credentialsId: "${KUBE_CONFIG_ID}", variable: 'KUBECONFIG')]) {
        sh '''
          kubectl rollout undo deployment/threebroomsticks-deployment
        '''
      }
    }
    always {
      echo "Cleaning up workspace..."
      cleanWs()
    }
  }
}
