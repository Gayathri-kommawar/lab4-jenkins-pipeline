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
                archiveArtifacts(
                    artifacts: 'target/payment-2.7.jar',
                    fingerprint: true
                )
            }
        }

        stage('Approval') {
            when {
                expression {
                    env.GIT_BRANCH == 'origin/main'
                }
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
                expression {
                    env.GIT_BRANCH == 'origin/main'
                }
            }

            steps {
                bat '''
                    echo ========================================
                    echo Starting Production Deployment
                    echo ========================================

                    if not exist target\\payment-2.7.jar (
                        echo ERROR: payment-2.7.jar not found
                        exit /b 1
                    )

                    copy /Y target\\payment-2.7.jar deployed-payment.jar

                    if errorlevel 1 (
                        echo ERROR: Deployment failed
                        exit /b 1
                    )

                    echo.
                    echo Production deployment completed successfully.
                    echo Deployed artifact: payment-2.7.jar
                    echo ========================================
                '''
            }
        }
    }

    post {

        always {
            junit(
                testResults: 'target/surefire-reports/*.xml',
                allowEmptyResults: false
            )

            cleanWs()
        }

        success {
            echo 'SUCCESS: Build, tests, archive and deployment completed successfully.'
        }

        failure {
            echo 'FAILURE: Build, test or deployment failed.'
        }

        aborted {
            echo 'ABORTED: Production deployment was rejected or cancelled.'
        }
    }
}