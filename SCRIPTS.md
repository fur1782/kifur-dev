# 🚀 Scripts d'Inicialització Kifur Dev

Aquest projecte inclou scripts automatitzats per facilitar la configuració i gestió de l'entorn de desenvolupament.

## 📝 Scripts Disponibles

### 1. `setup.ps1` / `setup.bat` - Configuració Inicial

**Què fa:**
- ✅ Verifica que Docker Desktop està executant-se
- ✅ Crea automàticament els fitxers `.env` necessaris
- ✅ Opcionalment instal·la dependències localment (útil per IDEs)
- ✅ Construeix les imatges Docker
- ✅ Inicia els serveis

**Com executar-lo:**

**PowerShell (Recomanat):**
```powershell
.\setup.ps1
```

**Si tens problemes amb PowerShell, usa el .bat:**
```cmd
setup.bat
```

**Nota:** Només cal executar aquest script **una vegada**, la primera vegada que clones el projecte.

---

### 2. `docker-helper.ps1` - Gestió de Serveis

**Què fa:**
Menú interactiu per gestionar els serveis Docker:
- Iniciar/aturar serveis
- Veure logs
- Reconstruir imatges
- Esborrar volums
- Veure estat dels contenidors

**Com executar-lo:**
```powershell
.\docker-helper.ps1
```

---

## 🔧 Solució de Problemes

### Error: "No es pot executar scripts en aquest sistema"

Si veus aquest error en PowerShell:
```
.\setup.ps1 : No se puede cargar el archivo...
```

**Solució:**
1. Obre PowerShell com a administrador
2. Executa: `Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser`
3. Confirma amb "S" (Sí)
4. Torna a executar l'script

**O simplement usa el fitxer .bat:**
```cmd
setup.bat
```

---

### Els scripts no funcionen?

**Alternativa manual:**

1. Crea el fitxer `.env`:
   ```bash
   cd kifur_be
   cp .env.example .env
   cd ..
   ```

2. Construeix i inicia:
   ```bash
   docker-compose build
   docker-compose up -d
   ```

---

## 📚 Més Informació

- [README.md](./README.md) - Informació general del projecte
- [QUICK-START.md](./QUICK-START.md) - Guia ràpida
- [DOCKER-DEV.md](./DOCKER-DEV.md) - Documentació completa de Docker

---

## 💡 Consells

- **Primera vegada?** → Executa `setup.ps1` o `setup.bat`
- **Gestionar serveis?** → Usa `docker-helper.ps1`
- **Prefereixis comandes manuals?** → Veure [DOCKER-DEV.md](./DOCKER-DEV.md)
