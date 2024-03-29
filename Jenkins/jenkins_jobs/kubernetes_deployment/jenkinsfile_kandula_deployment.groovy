properties([
  parameters([
    choice(name: 'HELM',choices: ['upgrade', 'uninstall'],description: 'Helm Install Upgrade or Uninstall')
    ])
])

def KUBECONFIG_VAR = "AWS-EKS-KANDULA-kubeconfig"

pipeline {

    agent {
        label 'docker-ubuntu'
    }

    environment{
        REGISTRY = "erandocker"
        REGISTRY_CREDENTIAL = 'dockerhub.erandocker'
    }

    options {
        buildDiscarder(logRotator(numToKeepStr: '20'))
        disableConcurrentBuilds()
    }

    stages {
        stage('Preparing Kandula deployment file') {
             steps {
             withCredentials([string(credentialsId: 'aws.access_key', variable: 'AWS_ACCESS_KEY_ID'), string(credentialsId: 'aws.secret_key', variable: 'AWS_SECRET_ACCESS_KEY')]) {
                sh """
                                 tee kalandula_app.yaml <<-'EOF'
                                 apiVersion: apps/v1
                                 kind: Deployment
                                 metadata:
                                   name: kandula-app
                                   annotations:
                                     kubernetes.io/change-cause: "First release of kandula app"
                                 spec:
                                   replicas: 2
                                   selector:
                                     matchLabels:
                                       app: kandula-app
                                   template:
                                     metadata:
                                       labels:
                                         app: kandula-app
                                     spec:
                                       containers:
                                         - name: kandula-app
                                           image: erandocker/ops-school-kandula:latest
                                           env:
                                             - name: FLASK_ENV
                                               value: "development"
                                             - name: AWS_ACCESS_KEY_ID
                                               value: "${AWS_ACCESS_KEY_ID}"
                                             - name: AWS_SECRET_ACCESS_KEY
                                               value: "${AWS_SECRET_ACCESS_KEY}"
                                             - name: AWS_DEFAULT_REGION
                                               value: "us-east-1"
                                           ports:
                                             - containerPort: 5000
                                               name: http
                                               protocol: TCP
                                       nodeSelector:
                                         role: kandula
                             """
                sh "ls -la"
                }
            }
        }
        stage('Installing Kandula on EKS prod') {
            when {
                 expression { params.HELM == "upgrade" }
            }
            steps {
                withCredentials([file(credentialsId: 'AWS-KANDULA-Credentials', variable: 'CREDENTIALSFILE'), file(credentialsId: "${KUBECONFIG_VAR}", variable: 'KUBECONFIG')]) {
                    sh 'mkdir /home/jenkins/.aws/ && cp \$CREDENTIALSFILE /home/jenkins/.aws/credentials && chmod 640 /home/jenkins/.aws/credentials'
                    sh 'mkdir /home/jenkins/.kube/ && cp \$KUBECONFIG /home/jenkins/.kube/config && chmod 640 /home/jenkins/.kube/config'
                    configFileProvider([configFile(fileId: 'AWS-KANDULA-config', targetLocation: '/home/jenkins/.aws/config')]) {
                        sh "kubectl get nodes -o wide"
                        sh "kubectl get pods -o wide -n kandula-development"
                        sh "kubectl apply -f kalandula_app.yaml --namespace=kandula-development"
                        sh "sleep 10"
                        sh "kubectl get pods -o wide -n kandula-development"
                    }
                }
            }
            post {
                always {
                    sh 'rm -rf /home/jenkins/.aws'
                    sh 'rm -rf /home/jenkins/.kube'
                }
            }
        }
        stage('Uninstalling Kandula on EKS prod') {
            when {
                expression { params.HELM == "uninstall" }
          }
            steps {
                withCredentials([file(credentialsId: 'AWS-KANDULA-Credentials', variable: 'CREDENTIALSFILE'), file(credentialsId: "${KUBECONFIG_VAR}", variable: 'KUBECONFIG')]) {
                    sh 'mkdir /home/jenkins/.aws/ && cp \$CREDENTIALSFILE /home/jenkins/.aws/credentials && chmod 640 /home/jenkins/.aws/credentials'
                    sh 'mkdir /home/jenkins/.kube/ && cp \$KUBECONFIG /home/jenkins/.kube/config && chmod 640 /home/jenkins/.kube/config'
                    configFileProvider([configFile(fileId: 'AWS-KANDULA-config', targetLocation: '/home/jenkins/.aws/config')]) {
                        sh "kubectl get pods -o wide -n kandula-development"
                        sh "kubectl delete -f kalandula_app.yaml --namespace=kandula-development"
                        sh "sleep 10"
                        sh "kubectl get pods -o wide -n kandula-development"
                    }
                }
            }
            post {
                always {
                    sh 'rm -rf /home/jenkins/.aws'
                    sh 'rm -rf /home/jenkins/.kube'
                }
            }
        }

        stage('Preparing LB deployment file') {
            steps {
                sh """
                tee kandula_lb.yaml <<-'EOF'
                apiVersion: v1
                kind: Service
                metadata:
                  name: kandula-service
                  annotations:
                    service.beta.kubernetes.io/aws-load-balancer-backend-protocol: http
                    service.beta.kubernetes.io/aws-load-balancer-ssl-cert: arn:aws:acm:us-east-1:113379206287:certificate/09a00715-ea90-46a2-a5c1-3a8b601aad57
                    service.beta.kubernetes.io/aws-load-balancer-ssl-ports: "https"
                spec:
                  selector:
                    app: kandula-app
                  type: LoadBalancer
                  ports:
                    - name: https
                      port: 443
                      targetPort: 5000
                      protocol: TCP
                """
            }
        }

        stage('Installing LB in EKS Prod') {
            when {
                 expression { params.HELM == "upgrade" }
            }
            steps {
                withCredentials([file(credentialsId: 'AWS-KANDULA-Credentials', variable: 'CREDENTIALSFILE'), file(credentialsId: "${KUBECONFIG_VAR}", variable: 'KUBECONFIG')]) {
                    sh 'mkdir /home/jenkins/.aws/ && cp \$CREDENTIALSFILE /home/jenkins/.aws/credentials && chmod 640 /home/jenkins/.aws/credentials'
                    sh 'mkdir /home/jenkins/.kube/ && cp \$KUBECONFIG /home/jenkins/.kube/config && chmod 640 /home/jenkins/.kube/config'
                    configFileProvider([configFile(fileId: 'AWS-KANDULA-config', targetLocation: '/home/jenkins/.aws/config')]) {
                        sh "pwd"
                        sh "ls -laht"
                        sh "kubectl get services -o wide -n kandula-development"
                        sh "kubectl apply -f kandula_lb.yaml --namespace=kandula-development"
                        sh "sleep 20"
                        sh "kubectl get services -o wide -n kandula-development"
                    }
                }
            }
            post {
                always {
                    sh 'rm -rf /home/jenkins/.aws'
                    sh 'rm -rf /home/jenkins/.kube'
                }
            }
        }
        stage('Uninstalling LB in EKS Prod') {
            when {
                expression { params.HELM == "uninstall" }
          }
            steps {
                withCredentials([file(credentialsId: 'AWS-KANDULA-Credentials', variable: 'CREDENTIALSFILE'), file(credentialsId: "${KUBECONFIG_VAR}", variable: 'KUBECONFIG')]) {
                    sh 'mkdir /home/jenkins/.aws/ && cp \$CREDENTIALSFILE /home/jenkins/.aws/credentials && chmod 640 /home/jenkins/.aws/credentials'
                    sh 'mkdir /home/jenkins/.kube/ && cp \$KUBECONFIG /home/jenkins/.kube/config && chmod 640 /home/jenkins/.kube/config'
                    configFileProvider([configFile(fileId: 'AWS-KANDULA-config', targetLocation: '/home/jenkins/.aws/config')]) {
                        sh "kubectl get services -o wide -n kandula-development"
                        sh "kubectl delete -f kandula_lb.yaml --namespace=kandula-development"
                        sh "sleep 20"
                        sh "kubectl get services -o wide -n kandula-development"
                    }
                }
            }
            post {
                always {
                    sh 'rm -rf /home/jenkins/.aws'
                    sh 'rm -rf /home/jenkins/.kube'
                }
            }
        }
    }

    post {
        success {
            slackSend(
                color: 'good',
                message: "SUCCESSFUL: Job ${env.JOB_NAME} - #${env.BUILD_NUMBER} - (<${env.BUILD_URL}|Open>)"
            )
        }
        failure {
            slackSend(
                color: 'danger',
                message: "FAILED: Job ${env.JOB_NAME} - #${env.BUILD_NUMBER} - (<${env.BUILD_URL}|Open>)"
            )
        }
    }
}