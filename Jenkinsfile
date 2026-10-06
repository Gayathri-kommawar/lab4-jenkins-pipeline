pipeline {
    agent any

    options {
        skipDefaultCheckout(true)
    }

    stages {

        stage('Build') {
            steps {
                checkout scm

                bat 'mvn clean package'
            }
        }

        stage('Test') {
            steps {
                bat 'mvn test'
            }
        }

        stage('Archive') {
            steps {
                archiveArtifacts artifacts: 'target/*.jar', fingerprint: true
            }
        }

        stage('Approval') {
            when {
                branch 'main'
            }

            steps {
                input(
                    message: 'Approve deployment to production?',
                    ok: 'Deploy'
                )
            }
        }

        stage('Deploy') {
            when {
                branch 'main'
            }

            steps {
                bat 'deploy.bat'
            }
        }
    }

    post {
        always {
            junit 'target/surefire-reports/*.xml'
            cleanWs()
        }

        success {
            echo 'Build and deployment completed successfully.'
        }

        failure {
            echo 'Build or deployment failed.'
        }

        aborted {
            echo 'Production deployment was aborted.'
        }
    }
}