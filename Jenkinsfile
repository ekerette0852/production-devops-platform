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
