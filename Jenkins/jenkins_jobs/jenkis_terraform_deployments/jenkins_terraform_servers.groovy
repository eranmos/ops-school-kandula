properties([
  parameters([
    choice(name: 'TERRAFORM',choices: ['plan', 'apply', 'destroy'],description: 'Terraform: plan, apply or destroy')
  ])
])

pipeline {

    agent {
        label 'docker-ubuntu'
    }
    tools {
        terraform "Terraform_1.1.2"
      }

    options {
        ansiColor('xterm')
        buildDiscarder(logRotator(numToKeepStr: '25'))
        disableConcurrentBuilds()
        timestamps()
        timeout(60)
    }

    stages {
        stage('Terraform plan') {
           when {
             expression { params.TERRAFORM == "plan" }
           }
            steps {
                dir ('terraform/terraform_servers') {
                    withCredentials([file(credentialsId: 'terraform.credentials', variable: 'CREDENTIALSFILE'), file(credentialsId: 'terraform.config', variable: 'CONFIG')]) {
                        sh 'mkdir -p /home/jenkins/.aws/ && cp \$CREDENTIALSFILE /home/jenkins/.aws/credentials && chmod 640 /home/jenkins/.aws/credentials'
                        sh 'cp \$CONFIG /home/jenkins/.aws/config && chmod 640 /home/jenkins/.aws/config'
                        sh """terraform -version"""
                        sh """terraform init"""
                        echo 'Going to run terraform plan to see that changes that you done'
                        sh """terraform plan"""
                        echo "Yoy successfully run terraform plan to see your changes via terraform"
                    }
                }
            }
            post {
                always {
                    sh 'rm -rf /home/jenkins/.aws'
                }
            }
        }
        stage('Terraform apply') {
          when {
            expression { params.TERRAFORM == "apply" }
          }
            steps {
                dir ('terraform/terraform_servers') {
                    withCredentials([file(credentialsId: 'terraform.credentials', variable: 'CREDENTIALSFILE'), file(credentialsId: 'terraform.config', variable: 'CONFIG')]) {
                        sh 'mkdir -p /home/jenkins/.aws/ && cp \$CREDENTIALSFILE /home/jenkins/.aws/credentials && chmod 640 /home/jenkins/.aws/credentials'
                        sh 'cp \$CONFIG /home/jenkins/.aws/config && chmod 640 /home/jenkins/.aws/config'
                        sh """terraform -version"""
                        sh """terraform init"""
                        echo 'Going to run terraform apply!'
                        sh """terraform apply -auto-approve -no-color"""
                        echo "Yoy successfully apply your changes via terraform"
                    }
                }
            }
            post {
                always {
                    sh 'rm -rf /home/jenkins/.aws'
                }
            }
        }
        stage('Terraform destroy') {
          when {
            expression { params.TERRAFORM == "destroy" }
          }
            steps {
                dir ('terraform/terraform_servers') {
                    withCredentials([file(credentialsId: 'terraform.credentials', variable: 'CREDENTIALSFILE'), file(credentialsId: 'terraform.config', variable: 'CONFIG')]) {
                        sh 'mkdir -p /home/jenkins/.aws/ && cp \$CREDENTIALSFILE /home/jenkins/.aws/credentials && chmod 640 /home/jenkins/.aws/credentials'
                        sh 'cp \$CONFIG /home/jenkins/.aws/config && chmod 640 /home/jenkins/.aws/config'
                        sh """terraform -version"""
                        sh """terraform init"""
                        echo 'Going to run terraform Destroy!!!'
                        sh """terraform destroy -auto-approve -no-color"""
                        echo "Yoy successfully destroy your changes via terraform"
                    }
                }
            }
            post {
                always {
                    sh 'rm -rf /home/jenkins/.aws'
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