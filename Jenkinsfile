pipeline {
  agent any

  environment {
    IMAGE_NAME = "tarun2210/threebroomsticks-inn"
    IMAGE_TAG = "${env.BUILD_ID}"  // Optional: You can also pass it via parameter
    KUBE_CONFIG_ID = "kubeconfig"  // Jenkins credentials ID that holds your kubeconfig file
    DOCKERHUB_CREDENTIALS = credentials('dockerhub-credentials')
  }

  stages {
    stage('Pull Latest Image') {
      steps {
        sh '''
          docker login -u ${DOCKERHUB_CREDENTIALS_USR} -p ${DOCKERHUB_CREDENTIALS_PSW}
          docker pull ${IMAGE_NAME}:latest
        '''
      }
    }

    stage('Deploy to Kubernetes') {
      steps {
        withCredentials([file(credentialsId: "${KUBE_CONFIG_ID}", variable: 'KUBECONFIG')]) {
          sh '''
            echo "Deploying image: ${IMAGE_NAME}:${IMAGE_TAG}"

            # Update the image in the Kubernetes deployment
            kubectl set image deployment/threebroomsticks-deployment \
              threebroomsticks-container=${IMAGE_NAME}:latest --record

            # Check the rollout status
            kubectl rollout status deployment/threebroomsticks-deployment --timeout=300s

            # Verify the deployment
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
