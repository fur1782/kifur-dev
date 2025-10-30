# Script d'ajuda per Docker Compose - Kifur Dev

Write-Host "=== Kifur Dev - Docker Compose Helper ===" -ForegroundColor Cyan
Write-Host ""
Write-Host "Selecciona una opcio:" -ForegroundColor Yellow
Write-Host "1. Iniciar tots els serveis"
Write-Host "2. Iniciar en mode detached (segon pla)"
Write-Host "3. Aturar tots els serveis"
Write-Host "4. Veure logs (tots)"
Write-Host "5. Veure logs del Backend"
Write-Host "6. Veure logs del Frontend"
Write-Host "7. Reconstruir i iniciar"
Write-Host "8. Aturar i eliminar volums (ESBORRA DADES)"
Write-Host "9. Estat dels serveis"
Write-Host "0. Sortir"
Write-Host ""

$option = Read-Host "Opcio"

switch ($option) {
    "1" {
        Write-Host "Iniciant serveis..." -ForegroundColor Green
        docker-compose up
    }
    "2" {
        Write-Host "Iniciant serveis en mode detached..." -ForegroundColor Green
        docker-compose up -d
        Write-Host ""
        Write-Host "Serveis iniciats! Accedeix a:" -ForegroundColor Green
        Write-Host "  Frontend: http://localhost:5173" -ForegroundColor Cyan
        Write-Host "  Backend: http://localhost:3000" -ForegroundColor Cyan
        Write-Host "  Mongo Express: http://localhost:8081" -ForegroundColor Cyan
    }
    "3" {
        Write-Host "Aturant serveis..." -ForegroundColor Yellow
        docker-compose down
    }
    "4" {
        Write-Host "Mostrant logs (Ctrl+C per sortir)..." -ForegroundColor Green
        docker-compose logs -f
    }
    "5" {
        Write-Host "Mostrant logs del Backend (Ctrl+C per sortir)..." -ForegroundColor Green
        docker-compose logs -f backend
    }
    "6" {
        Write-Host "Mostrant logs del Frontend (Ctrl+C per sortir)..." -ForegroundColor Green
        docker-compose logs -f frontend
    }
    "7" {
        Write-Host "Reconstruint i iniciant..." -ForegroundColor Green
        docker-compose up --build
    }
    "8" {
        $confirm = Read-Host "Aixo esborrarà totes les dades de MongoDB. Continuar? (s/n)"
        if ($confirm -eq "s" -or $confirm -eq "S") {
            Write-Host "Aturant i eliminant volums..." -ForegroundColor Red
            docker-compose down -v
        } else {
            Write-Host "Operacio cancel·lada" -ForegroundColor Yellow
        }
    }
    "9" {
        Write-Host "Estat dels serveis:" -ForegroundColor Green
        docker-compose ps
    }
    "0" {
        Write-Host "Adeu!" -ForegroundColor Cyan
        exit
    }
    default {
        Write-Host "Opcio no valida" -ForegroundColor Red
    }
}
