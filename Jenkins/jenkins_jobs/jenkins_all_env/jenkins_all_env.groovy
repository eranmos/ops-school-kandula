properties([
  parameters([
    choice(name: 'TERRAFORM',choices: ['plan', 'apply', 'destroy'],description: 'Please choose your Terraform desire task: plan, apply or destroy')
  ])
])

pipeline {

    agent {
        label 'docker-ubuntu'
    }

    options {
        ansiColor('xterm')
        buildDiscarder(logRotator(numToKeepStr: '25'))
        disableConcurrentBuilds()
        timestamps()
        timeout(180)
    }

    stages {
        stage('Creating VPC for Kandula') {
            steps {
            build job:'terraform-vpc', parameters: [string(name: '', value: params.)]
            }
        }
        stage('Creating Jenkins Servers') {
            steps {
            build job:'terraform-jenkins', parameters: [string(name: '', value: params.) ]
            }
        }
        stage('Creating servers') {
            steps {
            build job:'terraform-servers', parameters: [string(name: '', value: params.) ]
            }
        }
        stage('Creating Postgres DB') {
            steps {
            build job:'terraform-postgres', parameters: [string(name: '', value: params.) ]
            }
        }
        stage('Creating K8S Cluster') {
            steps {
            build job:'terraform-eks', parameters: [string(name: '', value: params.) ]
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