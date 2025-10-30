# Kifur Dev

Aplicació de quizzes interactius amb Vue.js, Node.js, Socket.IO i MongoDB.

## 🚀 Inici Ràpid amb Docker (Recomanat)

### Primera vegada? Executa l'script d'inicialització:

```powershell
.\setup.ps1
```

Aquest script automàticament:
- ✅ Verifica que Docker està executant-se
- ✅ Crea els fitxers `.env` necessaris
- ✅ Construeix les imatges Docker
- ✅ (Opcional) Instal·la dependències localment per al teu IDE
- ✅ Inicia els serveis

### Ja tens tot configurat?

```bash
# Iniciar tots els serveis
docker-compose up

# O en mode detached (segon pla)
docker-compose up -d
```

**Serveis disponibles:**
- Frontend (Vue.js): http://localhost:5173
- Backend (Node.js): http://localhost:3000  
- Mongo Express: http://localhost:8081
- MongoDB: mongodb://localhost:27017

### Scripts d'ajuda per Windows

```powershell
# Configuració inicial (primera vegada)
.\setup.ps1

# Menú interactiu per gestionar serveis
.\docker-helper.ps1
```

**Nota:** Si tens problemes executant scripts PowerShell, usa `setup.bat` o consulta [SCRIPTS.md](./SCRIPTS.md)

📖 **Més informació:** Veure [DOCKER-DEV.md](./DOCKER-DEV.md)

---

## 📁 Estructura del Projecte

```
kifur-dev/
├── kifur_be/          # Backend (Node.js + Express + Socket.IO)
├── kifur_fe/          # Frontend (Vue.js + Vite)
├── docker-compose.yml # Configuració Docker per desenvolupament
└── DOCKER-DEV.md      # Documentació Docker detallada
```

## 🛠️ Desenvolupament Local (sense Docker)

### Prerequisits
- Node.js >= 20.19.0
- MongoDB instal·lat i executant-se

### Backend

```bash
cd kifur_be
npm install
npm run start:mongo
```

### Frontend

```bash
cd kifur_fe
npm install
npm run dev
```

## 🔧 Tecnologies

### Frontend
- Vue.js 3
- Vue Router
- Pinia (State Management)
- Vite
- TypeScript

### Backend
- Node.js
- Express.js
- Socket.IO
- MongoDB + Mongoose
- Zod (Validació)

## 📝 Scripts Disponibles

### Backend (`kifur_be`)
- `npm run start:local` - Servidor amb dades locals (sense MongoDB)
- `npm run start:mongo` - Servidor amb MongoDB (amb hot-reload)

### Frontend (`kifur_fe`)
- `npm run dev` - Servidor de desenvolupament Vite
- `npm run build` - Build per producció
- `npm run preview` - Preview del build
- `npm run lint` - Linting del codi
- `npm run format` - Formatejar el codi

## 🐛 Hot Reload

Amb Docker Compose, tots els canvis que facis als fitxers es reflectiran automàticament:
- **Frontend**: Vite HMR (Hot Module Replacement)
- **Backend**: Node amb flag `--watch`

## 📄 Llicència

ISC
