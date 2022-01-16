pipeline {
    agent {
        label 'docker-ubuntu'
    }

    options {
        buildDiscarder(logRotator(numToKeepStr: '25'))
        disableConcurrentBuilds()
    }

    stages {
        stage("Adding Ansible SSH keys") {
            steps {
                script {
                   withCredentials([file(credentialsId: 'ansible-ssh-keys', variable: 'CREDENTIALSFILE')]) {
                       sh 'cp \$CREDENTIALSFILE /home/jenkins/.ssh/id_rsa && chmod 400 /home/jenkins/.ssh/id_rsa'
                   }
                }
            }
        }
        stage("Installing consul server") {
            steps {
                dir ("ansible/") {
                    sh "pwd"
                    sh "ls -lhta"
                    sh "ansible-playbook consul_server_ansible_playbook.yaml"
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