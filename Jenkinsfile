pipeline {
    agent any

    environment {
        AWS_ACCESS_KEY_ID     = credentials('aws-access-key-id')
        AWS_SECRET_ACCESS_KEY = credentials('aws-secret-access-key')
        AWS_DEFAULT_REGION    = 'us-east-1'
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Verify AWS Identity') {
            steps {
                sh 'aws sts get-caller-identity'
            }
        }

        stage('Deploy Production') {
            steps {
                sh './scripts/deploy-production.sh'
            }
        }
    }
}
