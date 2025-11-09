@echo off
echo Stopping all OrderFlow microservices...
echo.

echo Killing Java processes for OrderFlow services...
taskkill /FI "WINDOWTITLE eq User Service*" /T /F >nul 2>&1
taskkill /FI "WINDOWTITLE eq Order Service*" /T /F >nul 2>&1
taskkill /FI "WINDOWTITLE eq Gateway Service*" /T /F >nul 2>&1
taskkill /FI "WINDOWTITLE eq Inventory Service*" /T /F >nul 2>&1
taskkill /FI "WINDOWTITLE eq Payment Service*" /T /F >nul 2>&1
taskkill /FI "WINDOWTITLE eq Notification Service*" /T /F >nul 2>&1
taskkill /FI "WINDOWTITLE eq Analytics Service*" /T /F >nul 2>&1

REM Also kill Java processes on the specific ports
for /f "tokens=5" %%a in ('netstat -aon ^| findstr ":8080" ^| findstr "LISTENING"') do taskkill /F /PID %%a >nul 2>&1
for /f "tokens=5" %%a in ('netstat -aon ^| findstr ":8081" ^| findstr "LISTENING"') do taskkill /F /PID %%a >nul 2>&1
for /f "tokens=5" %%a in ('netstat -aon ^| findstr ":8082" ^| findstr "LISTENING"') do taskkill /F /PID %%a >nul 2>&1
for /f "tokens=5" %%a in ('netstat -aon ^| findstr ":8083" ^| findstr "LISTENING"') do taskkill /F /PID %%a >nul 2>&1
for /f "tokens=5" %%a in ('netstat -aon ^| findstr ":8084" ^| findstr "LISTENING"') do taskkill /F /PID %%a >nul 2>&1
for /f "tokens=5" %%a in ('netstat -aon ^| findstr ":8085" ^| findstr "LISTENING"') do taskkill /F /PID %%a >nul 2>&1
for /f "tokens=5" %%a in ('netstat -aon ^| findstr ":8086" ^| findstr "LISTENING"') do taskkill /F /PID %%a >nul 2>&1

echo All services stopped.
pause

