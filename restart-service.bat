@echo off
if "%1"=="" (
    echo Usage: restart-service.bat [service-name]
    echo.
    echo Available services:
    echo   gateway      - Gateway Service (port 8080)
    echo   user         - User Service (port 8082)
    echo   order        - Order Service (port 8081)
    echo   inventory    - Inventory Service (port 8083)
    echo   payment      - Payment Service (port 8084)
    echo   notification - Notification Service (port 8085)
    echo   analytics    - Analytics Service (port 8086)
    echo.
    pause
    exit /b 1
)

set "SERVICE=%1"
set "PROJECT_DIR=%~dp0"

REM Set service details based on argument
if /i "%SERVICE%"=="gateway" (
    set "SERVICE_NAME=Gateway Service"
    set "SERVICE_DIR=gateway"
    set "PORT=8080"
) else if /i "%SERVICE%"=="user" (
    set "SERVICE_NAME=User Service"
    set "SERVICE_DIR=user"
    set "PORT=8082"
) else if /i "%SERVICE%"=="order" (
    set "SERVICE_NAME=Order Service"
    set "SERVICE_DIR=order"
    set "PORT=8081"
) else if /i "%SERVICE%"=="inventory" (
    set "SERVICE_NAME=Inventory Service"
    set "SERVICE_DIR=inventory"
    set "PORT=8083"
) else if /i "%SERVICE%"=="payment" (
    set "SERVICE_NAME=Payment Service"
    set "SERVICE_DIR=payment"
    set "PORT=8084"
) else if /i "%SERVICE%"=="notification" (
    set "SERVICE_NAME=Notification Service"
    set "SERVICE_DIR=notification"
    set "PORT=8085"
) else if /i "%SERVICE%"=="analytics" (
    set "SERVICE_NAME=Analytics Service"
    set "SERVICE_DIR=analytics"
    set "PORT=8086"
) else (
    echo Error: Unknown service "%SERVICE%"
    echo.
    echo Available services: user, order, gateway, inventory, payment, notification, analytics
    pause
    exit /b 1
)

echo Restarting %SERVICE_NAME% (port %PORT%)...
echo.

REM Kill process on the service port
for /f "tokens=5" %%a in ('netstat -aon ^| findstr ":%PORT%" ^| findstr "LISTENING"') do (
    echo Stopping process on port %PORT% (PID: %%a)...
    taskkill /F /PID %%a >nul 2>&1
)

timeout /t 2 /nobreak >nul

REM Check if Windows Terminal is available
where wt.exe >nul 2>&1
if errorlevel 1 goto :use_separate_window

REM Use Windows Terminal tab
:use_wt_tab
    echo Starting %SERVICE_NAME% in new tab...
    wt.exe new-tab -d "%PROJECT_DIR%%SERVICE_DIR%" --title "%SERVICE_NAME% (%PORT%)" cmd /k "mvnw.cmd spring-boot:run"
    goto :end

:use_separate_window
    echo Starting %SERVICE_NAME% in new window...
    start "%SERVICE_NAME%" cmd /k "cd /d %PROJECT_DIR%%SERVICE_DIR% && mvnw.cmd spring-boot:run"

:end

echo %SERVICE_NAME% restarted.
pause

