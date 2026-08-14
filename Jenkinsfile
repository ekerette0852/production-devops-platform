pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Deploy Production') {
            steps {
                sh './scripts/deploy-production.sh'
            }
        }
    }
}
