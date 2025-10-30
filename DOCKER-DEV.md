# Kifur Dev - Entorn de Desenvolupament amb Docker

Aquest projecte utilitza Docker Compose per proporcionar un entorn de desenvolupament complet amb hot-reload per al frontend i backend.

## 🚀 Serveis Inclosos

- **Frontend (Vue.js + Vite)**: http://localhost:5173
- **Backend (Node.js + Express + Socket.IO)**: http://localhost:3000
- **MongoDB**: mongodb://localhost:27017
- **Mongo Express (UI)**: http://localhost:8081

## 📋 Prerequisits

- Docker Desktop instal·lat
- Docker Compose (inclòs amb Docker Desktop)

## 🎬 Primera Inicialització

### Opció 1: Script Automàtic (Recomanat)

Executa l'script d'inicialització que configurarà tot automàticament:

```powershell
.\setup.ps1
```

L'script farà:
- ✅ Verificar que Docker està executant-se
- ✅ Crear els fitxers `.env` necessaris
- ✅ (Opcional) Instal·lar dependències localment per al teu IDE
- ✅ Construir les imatges Docker
- ✅ Iniciar els serveis

### Opció 2: Manual

1. Crea el fitxer `.env` al backend:
   ```bash
   cd kifur_be
   cp .env.example .env
   cd ..
   ```

2. Construeix les imatges:
   ```bash
   docker-compose build
   ```

3. Inicia els serveis:
   ```bash
   docker-compose up -d
   ```

## 🛠️ Instruccions d'Ús

### Scripts d'Ajuda (Windows)

```powershell
# Configuració inicial (només primera vegada)
.\setup.ps1

# Menú interactiu per gestionar els serveis
.\docker-helper.ps1
```

### Iniciar tots els serveis

```bash
docker-compose up
```

O en mode detached (segon pla):

```bash
docker-compose up -d
```

### Veure els logs

```bash
# Tots els serveis
docker-compose logs -f

# Només el backend
docker-compose logs -f backend

# Només el frontend
docker-compose logs -f frontend
```

### Aturar els serveis

```bash
docker-compose down
```

### Aturar els serveis i eliminar els volums (esborrar dades de MongoDB)

```bash
docker-compose down -v
```

### Reconstruir les imatges (després de canvis a package.json)

```bash
docker-compose up --build
```

## 🔄 Hot Reload

Els canvis que facis als fitxers es reflectiran automàticament:

- **Frontend**: Vite detecta canvis i recarrega automàticament
- **Backend**: Node amb flag `--watch` reinicia automàticament

## 📁 Estructura de Volums

Els volums estan configurats per:
- Muntar el codi font dins dels contenidors
- Mantenir `node_modules` aïllat per evitar conflictes entre Windows i Linux

## 🔐 Credencials MongoDB

- **Usuario**: admin
- **Contraseña**: admin123
- **Base de datos**: kifur

## 🐛 Solució de Problemes

### Els canvis no es reflecteixen

1. Assegura't que Docker Desktop està executant-se
2. Verifica que els contenidors estan actius: `docker-compose ps`
3. Revisa els logs: `docker-compose logs -f`

### Error de connexió a MongoDB

1. Espera uns segons perquè MongoDB s'inicialitzi completament
2. Verifica que el contenidor està healthy: `docker-compose ps`

### Reconstruir des de zero

```bash
docker-compose down -v
docker-compose build --no-cache
docker-compose up
```

## 📝 Notes

- El primer `docker-compose up` pot trigar uns minuts mentre instal·la les dependències
- Mongo Express està accessible sense autenticació per facilitar el desenvolupament
- Les dades de MongoDB es mantenen en un volum persistent fins que executis `docker-compose down -v`
