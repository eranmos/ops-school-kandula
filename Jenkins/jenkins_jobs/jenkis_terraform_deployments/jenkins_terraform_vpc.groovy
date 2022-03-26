properties([
  parameters([
    choice(name: 'TERRAFORM',choices: ['plan', 'apply', 'destroy'],description: 'Terraform: plan, apply or destroy')
  ])
])

def KUBECONFIG_VAR = "AWS-EKS-KANDULA-kubeconfig"
def NAMESPACE = "monitoring"
def DEPLOYMENT_NAME = "consul"

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
        stage('Terraform') {
            steps {
                dir ('terraform/terraform_vpc') {
                            echo 'Going to run terraform plan to see that changes that you done'
                            sh """wget https://raw.githubusercontent.com/warrensbox/terraform-switcher/release/install.sh && chmod 755 install.sh"""
                            sh './install.sh -b $(pwd)/.bin'
                            sh 'CUSTOMBIN=$(pwd)/.bin'
                            sh 'export PATH=$CUSTOMBIN:$PATH'
                            sh '$CUSTOMBIN/tfswitch -b $CUSTOMBIN/terraform 1.1.7'
                            sh 'terraform -v'
                            echo "Yoy successfully run terraform plan to see your changes via terraform"
                    }
                }
            }
        }
        stage('Terraform plan') {
           when {
             expression { params.TERRAFORM == "plan" }
           }
            steps {
                dir ('terraform/terraform_vpc') {
                    withCredentials([file(credentialsId: 'AWS-KANDULA-Credentials', variable: 'CREDENTIALSFILE'), file(credentialsId: "${KUBECONFIG_VAR}", variable: 'KUBECONFIG')]) {
                        sh 'mkdir /home/jenkins/.aws/ && cp \$CREDENTIALSFILE /home/jenkins/.aws/credentials && chmod 640 /home/jenkins/.aws/credentials'
                        sh 'mkdir /home/jenkins/.kube/ && cp \$KUBECONFIG /home/jenkins/.kube/config && chmod 640 /home/jenkins/.kube/config'
                        configFileProvider([configFile(fileId: 'AWS-KANDULA-config', targetLocation: '/home/jenkins/.aws/config')]) {
                            echo 'Going to run terraform plan to see that changes that you done'
                            sh """terraform apply -auto-approve -no-color"""
                            echo "Yoy successfully run terraform plan to see your changes via terraform"
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
        stage('Terraform apply') {
          when {
            expression { params.TERRAFORM == "apply" }
          }
            steps {
                dir ('terraform/terraform_vpc') {
                    withCredentials([file(credentialsId: 'AWS-KANDULA-Credentials', variable: 'CREDENTIALSFILE'), file(credentialsId: "${KUBECONFIG_VAR}", variable: 'KUBECONFIG')]) {
                        sh 'mkdir /home/jenkins/.aws/ && cp \$CREDENTIALSFILE /home/jenkins/.aws/credentials && chmod 640 /home/jenkins/.aws/credentials'
                        sh 'mkdir /home/jenkins/.kube/ && cp \$KUBECONFIG /home/jenkins/.kube/config && chmod 640 /home/jenkins/.kube/config'
                        configFileProvider([configFile(fileId: 'AWS-KANDULA-config', targetLocation: '/home/jenkins/.aws/config')]) {
                            echo 'Going to run terraform plan'
                            sh """terraform apply -auto-approve -no-color"""
                            echo "Yoy successfully apply your changes via terraform"
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
        stage('Terraform destroy') {
            when {
            expression { params.TERRAFORM == "destroy" }
          }
            steps {
                dir ('terraform/terraform_vpc') {
                    withCredentials([file(credentialsId: 'AWS-KANDULA-Credentials', variable: 'CREDENTIALSFILE'), file(credentialsId: "${KUBECONFIG_VAR}", variable: 'KUBECONFIG')]) {
                        sh 'mkdir /home/jenkins/.aws/ && cp \$CREDENTIALSFILE /home/jenkins/.aws/credentials && chmod 640 /home/jenkins/.aws/credentials'
                        sh 'mkdir /home/jenkins/.kube/ && cp \$KUBECONFIG /home/jenkins/.kube/config && chmod 640 /home/jenkins/.kube/config'
                        configFileProvider([configFile(fileId: 'AWS-KANDULA-config', targetLocation: '/home/jenkins/.aws/config')]) {
                            echo 'Going to run terraform Destroy!!!'
                            sh """terraform destroy -auto-approve -no-color"""
                            echo "Yoy successfully destroy your changes via terraform"
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