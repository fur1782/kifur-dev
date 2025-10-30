# Script d'Inicialització - Kifur Dev
# Aquest script prepara l'entorn de desenvolupament

Write-Host ""
Write-Host "=====================================" -ForegroundColor Cyan
Write-Host "  Kifur Dev - Script d'Inicialitzacio" -ForegroundColor Cyan
Write-Host "=====================================" -ForegroundColor Cyan
Write-Host ""

# Funcio per verificar si Docker està executant-se
function Test-DockerRunning {
    try {
        docker ps | Out-Null
        return $true
    }
    catch {
        return $false
    }
}

# 1. Verificar Docker
Write-Host "[1/5] Verificant Docker Desktop..." -ForegroundColor Yellow
if (-not (Test-DockerRunning)) {
    Write-Host "ERROR: Docker Desktop no esta executant-se." -ForegroundColor Red
    Write-Host "Si us plau, inicia Docker Desktop i torna a executar aquest script." -ForegroundColor Yellow
    Read-Host "Prem Enter per sortir"
    exit 1
}
Write-Host "OK: Docker Desktop esta executant-se" -ForegroundColor Green
Write-Host ""

# 2. Crear fitxer .env del Backend si no existeix
Write-Host "[2/5] Configurant fitxers d'entorn (.env)..." -ForegroundColor Yellow

$backendEnvPath = ".\kifur_be\.env"
if (-not (Test-Path $backendEnvPath)) {
    Write-Host "Creant fitxer .env per al Backend..." -ForegroundColor Cyan
    $envContent = @"
# MongoDB Configuration
MONGODB_URI=mongodb://admin:admin123@mongodb:27017/kifur?authSource=admin

# Server Configuration
PORT=3000
NODE_ENV=development
"@
    Set-Content -Path $backendEnvPath -Value $envContent
    Write-Host "OK: Fitxer .env creat a kifur_be/.env" -ForegroundColor Green
} else {
    Write-Host "OK: Fitxer .env ja existeix a kifur_be/.env" -ForegroundColor Green
}

$frontendEnvPath = ".\kifur_fe\.env"
if (-not (Test-Path $frontendEnvPath)) {
    Write-Host "Creant fitxer .env per al Frontend..." -ForegroundColor Cyan
    $envContent = @"
# API Configuration
VITE_API_BASE_URL=http://localhost:3000
VITE_SOCKET_URL=http://localhost:3000
"@
    Set-Content -Path $frontendEnvPath -Value $envContent
    Write-Host "OK: Fitxer .env creat a kifur_fe/.env" -ForegroundColor Green
} else {
    Write-Host "OK: Fitxer .env ja existeix a kifur_fe/.env" -ForegroundColor Green
}
Write-Host ""

# 3. Preguntar si vol instal·lar dependències localment (opcional)
Write-Host "[3/5] Instalacio de dependencies locals (opcional)" -ForegroundColor Yellow
Write-Host "Les dependencies s'instal·laran dins dels contenidors Docker." -ForegroundColor Gray
Write-Host "Vols instal·lar tambe les dependencies localment? (util per IDE/editors)" -ForegroundColor Gray
$installLocal = Read-Host "Instal·lar dependencies localment? (s/N)"

if ($installLocal -eq "s" -or $installLocal -eq "S") {
    Write-Host ""
    Write-Host "Instal·lant dependencies del Backend..." -ForegroundColor Cyan
    Push-Location kifur_be
    npm install
    if ($LASTEXITCODE -ne 0) {
        Write-Host "AVIS: Error instal·lant dependencies del Backend" -ForegroundColor Yellow
    } else {
        Write-Host "OK: Dependencies del Backend instal·lades" -ForegroundColor Green
    }
    Pop-Location
    
    Write-Host ""
    Write-Host "Instal·lant dependencies del Frontend..." -ForegroundColor Cyan
    Push-Location kifur_fe
    npm install
    if ($LASTEXITCODE -ne 0) {
        Write-Host "AVIS: Error instal·lant dependencies del Frontend" -ForegroundColor Yellow
    } else {
        Write-Host "OK: Dependencies del Frontend instal·lades" -ForegroundColor Green
    }
    Pop-Location
} else {
    Write-Host "OK: S'instal·laran les dependencies nomes dins dels contenidors" -ForegroundColor Green
}
Write-Host ""

# 4. Construir les imatges Docker
Write-Host "[4/5] Construint imatges Docker..." -ForegroundColor Yellow
Write-Host "Aixo pot trigar uns minuts la primera vegada..." -ForegroundColor Gray
docker-compose build
if ($LASTEXITCODE -ne 0) {
    Write-Host "ERROR: Error construint les imatges Docker" -ForegroundColor Red
    Read-Host "Prem Enter per sortir"
    exit 1
}
Write-Host "OK: Imatges Docker construides correctament" -ForegroundColor Green
Write-Host ""

# 5. Iniciar els serveis
Write-Host "[5/5] Vols iniciar els serveis ara?" -ForegroundColor Yellow
$startNow = Read-Host "Iniciar serveis? (S/n)"

if ($startNow -ne "n" -and $startNow -ne "N") {
    Write-Host ""
    Write-Host "Iniciant serveis en mode detached..." -ForegroundColor Cyan
    docker-compose up -d
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host ""
        Write-Host "=====================================" -ForegroundColor Green
        Write-Host "  INICIALITZACIO COMPLETADA!" -ForegroundColor Green
        Write-Host "=====================================" -ForegroundColor Green
        Write-Host ""
        Write-Host "Els serveis estan executant-se:" -ForegroundColor Cyan
        Write-Host "  Frontend:      http://localhost:5173" -ForegroundColor White
        Write-Host "  Backend:       http://localhost:3000" -ForegroundColor White
        Write-Host "  Mongo Express: http://localhost:8081" -ForegroundColor White
        Write-Host ""
        Write-Host "Comandes utils:" -ForegroundColor Yellow
        Write-Host "  docker-compose logs -f         # Veure tots els logs" -ForegroundColor Gray
        Write-Host "  docker-compose logs -f backend # Veure logs del backend" -ForegroundColor Gray
        Write-Host "  docker-compose logs -f frontend# Veure logs del frontend" -ForegroundColor Gray
        Write-Host "  docker-compose down            # Aturar els serveis" -ForegroundColor Gray
        Write-Host "  .\docker-helper.ps1            # Script d'ajuda interactiu" -ForegroundColor Gray
        Write-Host ""
        
        # Mostrar estat dels contenidors
        Write-Host "Estat dels contenidors:" -ForegroundColor Yellow
        docker-compose ps
        
        Write-Host ""
        $viewLogs = Read-Host "Vols veure els logs ara? (s/N)"
        if ($viewLogs -eq "s" -or $viewLogs -eq "S") {
            Write-Host ""
            Write-Host "Mostrant logs (Ctrl+C per sortir)..." -ForegroundColor Cyan
            docker-compose logs -f
        }
    } else {
        Write-Host "ERROR: Error iniciant els serveis" -ForegroundColor Red
    }
} else {
    Write-Host ""
    Write-Host "=====================================" -ForegroundColor Green
    Write-Host "  INICIALITZACIO COMPLETADA!" -ForegroundColor Green
    Write-Host "=====================================" -ForegroundColor Green
    Write-Host ""
    Write-Host "Per iniciar els serveis manualment:" -ForegroundColor Cyan
    Write-Host "  docker-compose up -d" -ForegroundColor White
    Write-Host ""
    Write-Host "O utilitza l'script d'ajuda:" -ForegroundColor Cyan
    Write-Host "  .\docker-helper.ps1" -ForegroundColor White
    Write-Host ""
}

Write-Host ""
Write-Host "Gracies per utilitzar Kifur Dev!" -ForegroundColor Cyan
Write-Host ""
