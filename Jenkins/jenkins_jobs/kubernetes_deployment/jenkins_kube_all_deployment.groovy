properties([
  parameters([
    choice(name: 'HELM',choices: ['upgrade', 'uninstall'],description: 'Helm Install Upgrade or Uninstall')
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
        stage('Deploying prometheus_stack') {
            steps {
            build job:'Kandula-Prometheus-Stack-Deployment', parameters: [string(name: 'HELM', value: params.HELM)]
            }
        }
        stage('Deploying Filebeat') {
            steps {
            build job:'Kandula-Filebeat-Deployment', parameters: [string(name: 'HELM', value: params.HELM) ]
            }
        }
        stage('Deploying Kandula app') {
            steps {
            build job:'Kandula-Application-Deployment', parameters: [string(name: 'HELM', value: params.HELM) ]
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