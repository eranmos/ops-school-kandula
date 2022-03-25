properties([
  parameters([
    choice(name: 'HELM',choices: ['upgrade', 'uninstall'],description: 'Helm Install Upgrade or Uninstall')
  ])
])
def KUBECONFIG_VAR = "AWS-EKS-KANDULA-kubeconfig"
def NAMESPACE = "monitoring"
def DEPLOYMENT_NAME = "filebeat"

pipeline {

    agent {
        label 'docker-ubuntu'
    }

    options {
        ansiColor('xterm')
        buildDiscarder(logRotator(numToKeepStr: '25'))
        disableConcurrentBuilds()
        timestamps()
        timeout(60)
    }

    stages {
        stage('Install Filebeat') {
           when {
             expression { params.HELM == "upgrade" }
           }
            steps {
                dir ('Jenkins/jenkins_jobs/kubernetes_deployment') {
                    withCredentials([file(credentialsId: 'AWS-KANDULA-Credentials', variable: 'CREDENTIALSFILE'), file(credentialsId: "${KUBECONFIG_VAR}", variable: 'KUBECONFIG')]) {
                        sh 'mkdir /home/jenkins/.aws/ && cp \$CREDENTIALSFILE /home/jenkins/.aws/credentials && chmod 640 /home/jenkins/.aws/credentials'
                        sh 'mkdir /home/jenkins/.kube/ && cp \$KUBECONFIG /home/jenkins/.kube/config && chmod 640 /home/jenkins/.kube/config'
                        configFileProvider([configFile(fileId: 'AWS-KANDULA-config', targetLocation: '/home/jenkins/.aws/config')]) {
                            echo 'Going to Install/Upgrade Filebeat'
                            sh "kubectl get pods -o wide -n ${NAMESPACE}"
                            sh "kubectl apply -f filebeat-k8s-config.yaml"
                            sh "sleep 10"
                            sh "kubectl get pods -o wide -n ${NAMESPACE}"
                            echo "Yoy successfully Installed Filebeat on your Env"
                        }
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
        stage('Uninstall Filebeat') {
          when {
            expression { params.HELM == "uninstall" }
          }
            steps {
                dir ('Jenkins/jenkins_jobs/kubernetes_deployment/') {
                    withCredentials([file(credentialsId: 'AWS-KANDULA-Credentials', variable: 'CREDENTIALSFILE'), file(credentialsId: "${KUBECONFIG_VAR}", variable: 'KUBECONFIG')]) {
                        sh 'mkdir /home/jenkins/.aws/ && cp \$CREDENTIALSFILE /home/jenkins/.aws/credentials && chmod 640 /home/jenkins/.aws/credentials'
                        sh 'mkdir /home/jenkins/.kube/ && cp \$KUBECONFIG /home/jenkins/.kube/config && chmod 640 /home/jenkins/.kube/config'
                        configFileProvider([configFile(fileId: 'AWS-KANDULA-config', targetLocation: '/home/jenkins/.aws/config')]) {
                            echo 'Going to Uninstall Filebeat'
                            sh "kubectl get pods -o wide -n ${NAMESPACE}"
                            sh "kubectl delete -f filebeat-k8s-config.yaml"
                            sh "sleep 10"
                            sh "kubectl get pods -o wide -n ${NAMESPACE}"
                            echo "Yoy successfully Uninstalled Filebeat on your Env"
                        }
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
            echo "BUILD FAILED \u274C"
            slackSend(
                color: 'danger',
                message: "FAILED: Job ${env.JOB_NAME} - #${env.BUILD_NUMBER} - (<${env.BUILD_URL}|Open>)"
            )
        }
    }
}