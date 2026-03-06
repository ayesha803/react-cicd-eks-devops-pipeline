pipeline{
    agent any
    environment{
        IMAGE_NAME = 'ayeshadockerhub/trend-app'
        IMAGE_TAG = "${BUILD_NUMBER}"
        CLUSTER_NAME = 'trend-eks-cluster'
        AWS_REGION = 'us-east-1'
    }
    stages{
        stage('Docker Build'){
            steps{
              sh "docker build -t $IMAGE_NAME:$IMAGE_TAG ."
            }
        }
        
        stage ('Docker login & push the image'){
            steps{
                withCredentials([usernamePassword(credentialsId: 'dockerhubcreds', passwordVariable: 'DOCKER_PASSWORD', usernameVariable: 'DOCKER_USERNAME')]) {
    sh '''echo $DOCKER_PASSWORD |  docker login -u $DOCKER_USERNAME --password-stdin
'''
sh "docker push $IMAGE_NAME:$IMAGE_TAG"

}
            }
        }

        stage('Update Kubernetes YAML'){
    steps{
        sh '''
        sed -i "s|image: ayeshadockerhub/trend-app:.*|image: $IMAGE_NAME:$IMAGE_TAG|" trend-app.yml
        '''
    }
}

        stage('Configure & Deploy to EKS'){
    steps{
        sh '''
        aws eks update-kubeconfig --region us-east-1 --name trend-cluster
        
        kubectl apply -f trend-app.yml
        kubectl apply -f trend-service.yml
        '''
    }
}
    }
}
