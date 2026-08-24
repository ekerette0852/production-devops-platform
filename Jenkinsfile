pipeline {
    agent any

    options {
        timeout(time: 10, unit: 'MINUTES')
        disableConcurrentBuilds()
        buildDiscarder(logRotator(numToKeepStr: '10'))
    }

    environment {
        AWS_DEFAULT_REGION = 'us-east-1'
        AWS_REGION = 'us-east-1'
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Verify AWS Identity') {
            steps {
                withCredentials([
                    string(credentialsId: 'aws-access-key-id', variable: 'AWS_ACCESS_KEY_ID'),
                    string(credentialsId: 'aws-secret-access-key', variable: 'AWS_SECRET_ACCESS_KEY')
                ]) {
                    sh '''
                        echo "Verifying AWS identity..."
                        aws sts get-caller-identity
                    '''
                }
            }
        }

stage('Record Current Version') {
    steps {
        script {
            env.CURRENT_COMMIT = sh(
                script: 'git rev-parse HEAD',
                returnStdout: true
            ).trim()

            env.PREVIOUS_COMMIT = sh(
                script: 'git rev-parse HEAD^',
                returnStdout: true
            ).trim()

            echo "Current commit: ${env.CURRENT_COMMIT}"
            echo "Rollback commit: ${env.PREVIOUS_COMMIT}"
        }
    }
}

    stage('Deploy Production') {
        steps {
            withCredentials([
                string(credentialsId: 'aws-access-key-id', variable: 'AWS_ACCESS_KEY_ID'),
                string(credentialsId: 'aws-secret-access-key', variable: 'AWS_SECRET_ACCESS_KEY')
            ]) {
                script {
                    try {
                        sh './scripts/deploy-production.sh'
                    } catch (err) {
                        echo '========================================'
                        echo 'DEPLOYMENT FAILED - STARTING ROLLBACK'
                        echo '========================================'

                        sh """
                            git checkout ${env.PREVIOUS_COMMIT}
                            ./scripts/deploy-production.sh
                            git checkout ${env.CURRENT_COMMIT}
                        """

                        echo '========================================'
                        echo 'ROLLBACK COMPLETED'
                        echo '========================================'

                        throw err
                    }
                }
            }
        }
    }
}

post {
    success {
        echo '========================================'
        echo 'PRODUCTION DEPLOYMENT SUCCESSFUL'
        echo '========================================'
    }

    failure {
        echo '========================================'
        echo 'PRODUCTION DEPLOYMENT FAILED'
        echo '========================================'

        emailext(
            to: 'slylaw4u@gmail.com',
            subject: "FAILED: ${env.JOB_NAME} #${env.BUILD_NUMBER}",
            body: """
Jenkins production deployment failed.

Job: ${env.JOB_NAME}
Build: #${env.BUILD_NUMBER}
Status: FAILED

Build URL:
${env.BUILD_URL}

Please review the Jenkins console output.
"""
        )
    }

    fixed {
        echo '========================================'
        echo 'PRODUCTION PIPELINE RECOVERED'
        echo '========================================'

        emailext(
            to: 'slylaw4u@gmail.com',
            subject: "RECOVERED: ${env.JOB_NAME} #${env.BUILD_NUMBER}",
            body: """
Jenkins production pipeline has recovered.

Job: ${env.JOB_NAME}
Build: #${env.BUILD_NUMBER}
Status: SUCCESS

The previous build failed, but this build completed successfully.

Build URL:
${env.BUILD_URL}
"""
        )
    }

    aborted {
        echo '========================================'
        echo 'PRODUCTION DEPLOYMENT ABORTED'
        echo '========================================'
    }

    always {
        echo "Build: ${env.BUILD_NUMBER}"
        echo "Job: ${env.JOB_NAME}"
    }
}
}
