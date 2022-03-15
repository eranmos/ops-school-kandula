properties([
  parameters([
    string(name: 'CHARTS_BRANCH', trim: true, defaultValue: 'master', description: 'charts branch'),
    choice(name: 'HELM',choices: ['upgrade', 'uninstall'],description: 'Helm Install Upgrade or Uninstall')
  ])
])

def KUBECONFIG_VAR = "AWS-EKS-KANDULA-kubeconfig"
def NAMESPACE = "monitoring"
def DEPLOYMENT_NAME = "fluentd"

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
        stage('Deploy consul') {
            steps {
                dir ('helm-releases') {
                    withCredentials([file(credentialsId: 'AWS-KANDULA-Credentials', variable: 'CREDENTIALSFILE'), file(credentialsId: "${KUBECONFIG_VAR}", variable: 'KUBECONFIG')]) {
                        sh 'mkdir /home/jenkins/.aws/ && cp \$CREDENTIALSFILE /home/jenkins/.aws/credentials && chmod 640 /home/jenkins/.aws/credentials'
                        sh 'mkdir /home/jenkins/.kube/ && cp \$KUBECONFIG /home/jenkins/.kube/config && chmod 640 /home/jenkins/.kube/config'
                        configFileProvider([configFile(fileId: 'AWS-KANDULA-config', targetLocation: '/home/jenkins/.aws/config')]) {
                            echo 'Going to Install Upgrade helm chart'
                            sh """helm upgrade ${DEPLOYMENT_NAME} ./fluentd/values-stg.yaml --install --atomic --namespace=${NAMESPACE}"""
                            sh "kubectl get pods -n ${NAMESPACE}"
                            sh "kubectl get deployments -n ${NAMESPACE}"
                            sh "kubectl rollout status deployment fluentd -n ${NAMESPACE}"
                            echo "Yoy successfully deployed consul on your Env"
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

        stage('Show Deployments') {
            steps {
                withCredentials([file(credentialsId: 'AWS-KANDULA-Credentials', variable: 'CREDENTIALSFILE'), file(credentialsId: "${KUBECONFIG_VAR}", variable: 'KUBECONFIG')]) {
                    sh 'mkdir /home/jenkins/.aws/ && cp \$CREDENTIALSFILE /home/jenkins/.aws/credentials && chmod 640 /home/jenkins/.aws/credentials'
                    sh 'mkdir /home/jenkins/.kube/ && cp \$KUBECONFIG /home/jenkins/.kube/config && chmod 640 /home/jenkins/.kube/config'
                    configFileProvider([configFile(fileId: 'AWS-KANDULA-config', targetLocation: '/home/jenkins/.aws/config')]) {
                        sh "helm ls -n ${NAMESPACE}"
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