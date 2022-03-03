properties([
  parameters([
    string(name: 'CHARTS_BRANCH', trim: true, defaultValue: 'master', description: 'charts branch'),
    choice(name: 'HELM',choices: ['upgrade', 'uninstall'],description: 'Helm Install Upgrade or Uninstall')
  ])
])
def HELM = params.HELM
def KUBECONFIG_VAR = "AWS-EKS-KANDULA-kubeconfig"
def NAMESPACE = "monitoring"
def DEPLOYMENT_NAME = "prometheus-stack"

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

        stage("Checkout Charts"){
            steps {
                checkout poll: false,
                    scm: [
                            $class: 'GitSCM',
                            branches: [[name: "*/${CHARTS_BRANCH}"]], browser: [$class: 'GithubWeb', repoUrl: 'https://github.com/eranmos/ops-school-kandula.git', version: '9.3'],
                            doGenerateSubmoduleConfigurations: false,
                            extensions: [[$class: 'CloneOption', depth: 1, noTags: false, reference: '/home/jenkins/Git-Cache/reference', shallow: true], [$class: 'AuthorInChangelog'], [$class: 'CleanBeforeCheckout']],
                            submoduleCfg: [],
                            userRemoteConfigs: [[credentialsId: 'jenkins.github.ssh', url: 'git@github.com:eranmos/ops-school-kandula.git']]
                        ]
            }
        }

        stage('Deploy prometheus-stack') {
            steps {
                dir ('helm-releases') {
                    withCredentials([file(credentialsId: 'AWS-KANDULA-Credentials', variable: 'CREDENTIALSFILE'), file(credentialsId: "${KUBECONFIG_VAR}", variable: 'KUBECONFIG')]) {
                        sh 'mkdir /home/jenkins/.aws/ && cp \$CREDENTIALSFILE /home/jenkins/.aws/credentials && chmod 640 /home/jenkins/.aws/credentials'
                        configFileProvider([configFile(fileId: 'AWS-KANDULA-config', targetLocation: '/home/jenkins/.aws/config')]) {
                                if (HELM == 'upgrade') {
                                    echo 'Going to Install Upgrade helm chart'
                                    sh """helm upgrade ${DEPLOYMENT_NAME} ./kube-prometheus-stack --install --atomic --namespace=${NAMESPACE}"""
                                    sh "kubectl get pods -n ${NAMESPACE}"
                                    sh "kubectl rollout status deployment ${DEPLOYMENT_NAME} -n ${NAMESPACE}"
                                    echo "Yoy successfully deployed kube-prometheus-stack on your Env"
                                }

                                if (HELM == 'upgrade') {
                                    echo 'Going to uninstall helm chart'
                                    sh """helm uninstall ${DEPLOYMENT_NAME} --namespace=${NAMESPACE}"""
                                    sh "kubectl get pods -n ${NAMESPACE}"
                                    sh "kubectl rollout status deployment ${DEPLOYMENT_NAME} -n ${NAMESPACE}"
                                    echo "Yoy successfully uninstall kube-prometheus-stack on your Env"
                            }
                        }
                    }
                }
            }
            post {
                always {
                    sh 'rm -rf /home/jenkins/.aws'
                }
            }
        }

        stage('Show Deployments') {
            steps {
                withCredentials([file(credentialsId: 'AWS-KANDULA-Credentials', variable: 'CREDENTIALSFILE'), file(credentialsId: "${KUBECONFIG_VAR}", variable: 'KUBECONFIG')]) {
                    sh 'mkdir /home/jenkins/.aws/ && cp \$CREDENTIALSFILE /home/jenkins/.aws/credentials && chmod 640 /home/jenkins/.aws/credentials'
                    configFileProvider([configFile(fileId: 'AWS-KANDULA-config', targetLocation: '/home/jenkins/.aws/config')]) {
                        sh "helm ls -n ${NAMESPACE}"
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
