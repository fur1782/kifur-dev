@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion

echo.
echo =====================================
echo   Kifur Dev - Script d'Inicialitzacio
echo =====================================
echo.

REM 1. Verificar Docker
echo [1/5] Verificant Docker Desktop...
docker ps >nul 2>&1
if errorlevel 1 (
    echo ERROR: Docker Desktop no esta executant-se.
    echo Si us plau, inicia Docker Desktop i torna a executar aquest script.
    pause
    exit /b 1
)
echo OK: Docker Desktop esta executant-se
echo.

REM 2. Crear fitxer .env del Backend
echo [2/5] Configurant fitxers d'entorn (.env)...
if not exist "kifur_be\.env" (
    echo Creant fitxer .env per al Backend...
    (
        echo # MongoDB Configuration
        echo MONGODB_URI=mongodb://admin:admin123@mongodb:27017/kifur?authSource=admin
        echo.
        echo # Server Configuration
        echo PORT=3000
        echo NODE_ENV=development
    ) > kifur_be\.env
    echo OK: Fitxer .env creat a kifur_be/.env
) else (
    echo OK: Fitxer .env ja existeix a kifur_be/.env
)

if not exist "kifur_fe\.env" (
    echo Creant fitxer .env per al Frontend...
    (
        echo # API Configuration
        echo VITE_API_BASE_URL=http://localhost:3000
        echo VITE_SOCKET_URL=http://localhost:3000
    ) > kifur_fe\.env
    echo OK: Fitxer .env creat a kifur_fe/.env
) else (
    echo OK: Fitxer .env ja existeix a kifur_fe/.env
)
echo.

REM 3. Preguntar si vol instal·lar dependències localment
echo [3/5] Instalacio de dependencies locals (opcional)
echo Les dependencies s'instal·laran dins dels contenidors Docker.
echo Vols instal·lar tambe les dependencies localment? (util per IDE/editors)
set /p installLocal="Instal·lar dependencies localment? (s/N): "

if /i "%installLocal%"=="s" (
    echo.
    echo Instal·lant dependencies del Backend...
    cd kifur_be
    call npm install
    if errorlevel 1 (
        echo AVIS: Error instal·lant dependencies del Backend
    ) else (
        echo OK: Dependencies del Backend instal·lades
    )
    cd ..
    
    echo.
    echo Instal·lant dependencies del Frontend...
    cd kifur_fe
    call npm install
    if errorlevel 1 (
        echo AVIS: Error instal·lant dependencies del Frontend
    ) else (
        echo OK: Dependencies del Frontend instal·lades
    )
    cd ..
) else (
    echo OK: S'instal·laran les dependencies nomes dins dels contenidors
)
echo.

REM 4. Construir les imatges Docker
echo [4/5] Construint imatges Docker...
echo Aixo pot trigar uns minuts la primera vegada...
docker-compose build
if errorlevel 1 (
    echo ERROR: Error construint les imatges Docker
    pause
    exit /b 1
)
echo OK: Imatges Docker construides correctament
echo.

REM 5. Iniciar els serveis
echo [5/5] Vols iniciar els serveis ara?
set /p startNow="Iniciar serveis? (S/n): "

if /i not "%startNow%"=="n" (
    echo.
    echo Iniciant serveis en mode detached...
    docker-compose up -d
    
    if not errorlevel 1 (
        echo.
        echo =====================================
        echo   INICIALITZACIO COMPLETADA!
        echo =====================================
        echo.
        echo Els serveis estan executant-se:
        echo   Frontend:      http://localhost:5173
        echo   Backend:       http://localhost:3000
        echo   Mongo Express: http://localhost:8081
        echo.
        echo Comandes utils:
        echo   docker-compose logs -f          # Veure tots els logs
        echo   docker-compose logs -f backend  # Veure logs del backend
        echo   docker-compose logs -f frontend # Veure logs del frontend
        echo   docker-compose down             # Aturar els serveis
        echo   .\docker-helper.ps1             # Script d'ajuda interactiu
        echo.
        echo Estat dels contenidors:
        docker-compose ps
        echo.
        set /p viewLogs="Vols veure els logs ara? (s/N): "
        if /i "!viewLogs!"=="s" (
            echo.
            echo Mostrant logs (Ctrl+C per sortir)...
            docker-compose logs -f
        )
    ) else (
        echo ERROR: Error iniciant els serveis
    )
) else (
    echo.
    echo =====================================
    echo   INICIALITZACIO COMPLETADA!
    echo =====================================
    echo.
    echo Per iniciar els serveis manualment:
    echo   docker-compose up -d
    echo.
    echo O utilitza l'script d'ajuda:
    echo   .\docker-helper.ps1
    echo.
)

echo.
echo Gracies per utilitzar Kifur Dev!
echo.
pause
