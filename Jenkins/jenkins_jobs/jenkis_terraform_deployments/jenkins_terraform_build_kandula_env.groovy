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
        stage('Terrafrom Plan - Creating Kandula Env on AWS') {
                stage('Creating VPC for Kandula') {
                    steps {
                    build job:'terraform-vpc', parameters: [choice(name: 'TERRAFORM',choices: ['plan', 'apply', 'destroy'],description: 'Terraform: plan, apply or destroy')]
                    }
                }
                stage('Creating Jenkins Servers') {
                    steps {
                    build job:'terraform-vpc', parameters: [choice(name: 'TERRAFORM',choices: ['plan', 'apply', 'destroy'],description: 'Terraform: plan, apply or destroy')]
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