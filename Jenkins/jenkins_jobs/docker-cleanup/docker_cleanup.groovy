properties([
  parameters([
    booleanParam(defaultValue: false, description: '''Do you want to perform full cleanup?\nTrue will execute: "docker system prune"\nFalse will execute: "docker container prune" and "docker image prune"''', name: 'FullCleanup')
    ])
])

pipeline {

    agent {
        label 'docker-ubuntu'
    }

    triggers {
        cron('@midnight')
    }

    options {
        buildDiscarder(logRotator(numToKeepStr: '10'))
        disableConcurrentBuilds()
    }

    stages {
        stage("Docker Nightly") {
            when { triggeredBy 'TimerTrigger' }
            steps {
                sh "docker container prune -f && docker image prune -f"
            }
        }
        stage("Docker User Cleanup") {
            when{ environment name: 'FullCleanup', value: 'true' }
            steps {
                sh "echo 'available images' && docker images"
                sh "docker system prune -f"
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