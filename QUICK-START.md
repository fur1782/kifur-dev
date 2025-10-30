# Guia Ràpida - Kifur Dev amb Docker

## ⚡ Primera vegada? Inici en 2 passos

1. **Assegura't que Docker Desktop està executant-se**

2. **Executa l'script d'inicialització:**
   ```powershell
   .\setup.ps1
   ```
   
   Aquest script farà tot el necessari automàticament! 🎉

---

## ⚡ Ja tens tot configurat? Inici en 3 passos

1. **Assegura't que Docker Desktop està executant-se**

2. **Inicia els serveis:**
   ```bash
   docker-compose up -d
   ```

3. **Obre el navegador:**
   - Frontend: http://localhost:5173
   - Backend API: http://localhost:3000
   - Mongo Express: http://localhost:8081

---

## 📊 Veure els logs

```bash
# Tots els logs
docker-compose logs -f

# Només backend
docker-compose logs -f backend

# Només frontend  
docker-compose logs -f frontend
```

---

## 🛑 Aturar els serveis

```bash
docker-compose down
```

---

## 🔄 Hot Reload

✅ Els canvis als fitxers es reflecteixen automàticament!

- Modifica qualsevol fitxer `.js` al backend → El servidor es reinicia automàticament
- Modifica qualsevol fitxer `.vue` o `.ts` al frontend → Vite recarrega la pàgina automàticament

---

## 🔧 Problemes comuns

### Els canvis no es veuen?

```bash
# Reinicia els serveis
docker-compose restart
```

### Vols reconstruir tot des de zero?

```bash
# Atura, elimina tot i reconstrueix
docker-compose down -v
docker-compose up --build
```

### Veure l'estat dels contenidors

```bash
docker-compose ps
```

---

## 💡 Consells

- Utilitza `.\docker-helper.ps1` per un menú interactiu (Windows)
- Els node_modules estan dins dels contenidors, no cal instal·lar-los localment
- Les dades de MongoDB es guarden en un volum persistent
- Per esborrar les dades: `docker-compose down -v`

---

📖 **Més informació:** [DOCKER-DEV.md](./DOCKER-DEV.md)
