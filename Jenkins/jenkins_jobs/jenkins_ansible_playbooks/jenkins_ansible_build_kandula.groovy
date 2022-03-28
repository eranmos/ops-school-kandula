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
        stage('Creating Consul Cluster') {
            steps {
            build job:'ansible-playbook-consul-server'
            }
        }
        stage('Installing Consul agents') {
            steps {
            build job:'ansible-playbook-consul-agent'
            }
        }
        stage('Installing Consul Registrator') {
            steps {
            build job:'ansible-playbook-consul-registrator'
            }
        }
        stage('Creating Elstic Cluster') {
            steps {
            build job:'ansible-playbook-elasticsearch'
            }
        }
        stage('Installing Filebeat') {
            steps {
            build job:'ansible-playbook-filebeat-server'
            }
        }
        stage('Installing Logstash') {
            steps {
            build job:'ansible-playbook-logstahs-agent'
            }
        }
        stage('Installing Prometheus') {
            steps {
            build job:'ansible-playbook-prometheus'
            }
        }
        stage('Installing Node Exporter') {
            steps {
            build job:'ansible-playbook-node-exporter'
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