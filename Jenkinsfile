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
                withCredentials([usernamePassword(credentialsId: 'dockerhubcreadentials', passwordVariable: 'DOCKER_PASSWORD', usernameVariable: 'DOCKER_USERNAME')]) {
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
        kubectl apply -f trend-ingress.yml
        eksctl utils associate-iam-oidc-provider --cluster demo-cluster --approve
        
        aws iam create-policy \
    --policy-name AWSLoadBalancerControllerIAMPolicy \
    --policy-document https://raw.githubusercontent.com/kubernetes-sigs/aws-alb-ingress-controller/v1.1.4/docs/examples/iam-policy.json

    eksctl create iamserviceaccount \
  --cluster=trend-cluster \
  --namespace=kube-system \
  --name=aws-load-balancer-controller \
  --role-name AmazonEKSLoadBalancerControllerRole \
  --attach-policy-arn=arn:aws:iam::956123261594:policy/AWSLoadBalancerControllerIAMPolicy \
  --approve

        '''
    }
}

        stage ('get vpc ID & install alb controller') {
            steps{
                sh '''
                 VPC_ID=$(aws eks describe-cluster \
                --name trend-cluster \
                --region us-east-1 \
                --query 'cluster.resourcesVpcConfig.vpcId' \
                --output text)

                '''

            }
        }

        stage ('install alb controller') {
            steps{
                sh '''
                  helm install aws-load-balancer-controller eks/aws-load-balancer-controller -n kube-system \
  --set clusterName=trend-cluster \
  --set serviceAccount.create=false \
  --set serviceAccount.name=aws-load-balancer-controller \
  --set region=us-east-1 \
  --set vpcId=VPC_ID
  '''
            }
        }
    }
}
