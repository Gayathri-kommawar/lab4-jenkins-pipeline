@echo off

echo ========================================
echo Starting Production Deployment
echo ========================================

if not exist target\payment-2.7.jar (
    echo ERROR: payment-2.7.jar not found
    exit /b 1
)

copy /Y target\payment-2.7.jar deployed-payment.jar

if errorlevel 1 (
    echo ERROR: Deployment failed
    exit /b 1
)

echo.
echo Production deployment completed successfully.
echo Deployed artifact: deployed-payment.jar
echo ========================================

exit /b 0