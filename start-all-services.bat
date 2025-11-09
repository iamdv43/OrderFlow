@echo off
echo Starting all OrderFlow microservices in Windows Terminal tabs...
echo.

REM Get the current directory
set "PROJECT_DIR=%~dp0"

REM Check if Windows Terminal (wt.exe) is available
where wt.exe >nul 2>&1
if errorlevel 1 goto :use_separate_windows

REM Use Windows Terminal tabs
:use_wt_tabs
    echo Using Windows Terminal with tabs...
    echo.
    
    REM Start all services in tabs using Windows Terminal
    wt.exe new-tab -d "%PROJECT_DIR%gateway" --title "Gateway Service (8080)" cmd /k "mvnw.cmd spring-boot:run"
    timeout /t 2 /nobreak >nul
    
    wt.exe new-tab -d "%PROJECT_DIR%user" --title "User Service (8082)" cmd /k "mvnw.cmd spring-boot:run"
    timeout /t 2 /nobreak >nul
    
    wt.exe new-tab -d "%PROJECT_DIR%order" --title "Order Service (8081)" cmd /k "mvnw.cmd spring-boot:run"
    timeout /t 2 /nobreak >nul
    
    wt.exe new-tab -d "%PROJECT_DIR%inventory" --title "Inventory Service (8083)" cmd /k "mvnw.cmd spring-boot:run"
    timeout /t 2 /nobreak >nul
    
    wt.exe new-tab -d "%PROJECT_DIR%payment" --title "Payment Service (8084)" cmd /k "mvnw.cmd spring-boot:run"
    timeout /t 2 /nobreak >nul
    
    wt.exe new-tab -d "%PROJECT_DIR%notification" --title "Notification Service (8085)" cmd /k "mvnw.cmd spring-boot:run"
    timeout /t 2 /nobreak >nul
    
    wt.exe new-tab -d "%PROJECT_DIR%analytics" --title "Analytics Service (8086)" cmd /k "mvnw.cmd spring-boot:run"
    
    echo.
    echo All services are starting in Windows Terminal tabs...
    echo Close the tabs to stop individual services.
    goto :end

:use_separate_windows
    echo Windows Terminal (wt.exe) not found. Falling back to separate windows...
    echo.
    
    echo Starting Gateway Service on port 8080...
    start "Gateway Service" cmd /k "cd /d %PROJECT_DIR%gateway && mvnw.cmd spring-boot:run"
    timeout /t 3 /nobreak >nul
    
    echo Starting User Service on port 8082...
    start "User Service" cmd /k "cd /d %PROJECT_DIR%user && mvnw.cmd spring-boot:run"
    timeout /t 3 /nobreak >nul
    
    echo Starting Order Service on port 8081...
    start "Order Service" cmd /k "cd /d %PROJECT_DIR%order && mvnw.cmd spring-boot:run"
    timeout /t 3 /nobreak >nul
    
    echo Starting Inventory Service on port 8083...
    start "Inventory Service" cmd /k "cd /d %PROJECT_DIR%inventory && mvnw.cmd spring-boot:run"
    timeout /t 3 /nobreak >nul
    
    echo Starting Payment Service on port 8084...
    start "Payment Service" cmd /k "cd /d %PROJECT_DIR%payment && mvnw.cmd spring-boot:run"
    timeout /t 3 /nobreak >nul
    
    echo Starting Notification Service on port 8085...
    start "Notification Service" cmd /k "cd /d %PROJECT_DIR%notification && mvnw.cmd spring-boot:run"
    timeout /t 3 /nobreak >nul
    
    echo Starting Analytics Service on port 8086...
    start "Analytics Service" cmd /k "cd /d %PROJECT_DIR%analytics && mvnw.cmd spring-boot:run"
    
    echo.
    echo All services are starting in separate windows...
    echo Close the individual windows to stop each service.

:end

pause

