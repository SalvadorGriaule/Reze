
# 🚀 SkillShare Mini

Une **micro-plateforme d’échange de compétences**  
Laravel + SQLite + Vite (PNPM) – containerisé avec Docker.

---

## 🧩 Description

SkillShare Mini permet à chaque utilisateur de :

- ✅ indiquer les compétences qu’il peut **enseigner**  
- 📚 indiquer les compétences qu’il souhaite **apprendre**  
- 👀 consulter les **profils** des autres membres

---

## 📦 Stack technique

| Côté | Techno |
|------|--------|
| Back | **Laravel 11** |
| BDD  | **SQLite** |
| Front Build | **Vite** (via PNPM) |
| Container | **Docker** |

---

## 🏁 Démarrage rapide

```bash
# 1. Cloner le repo
git clone https://github.com/SalvadorGriaule/Reze.git
cd Reze

# 2. Installer les dépendances PHP
composer install
composer run build          # build Laravel + optimise

# 3. Installer les assets
pnpm install
pnpm run dev                # dev server Vite (hot reload)

# 4. Créer la BDD + tables
php artisan migrate         # (SQLite créé automatiquement)

# 5. Lancer le serveur
php artisan serve --port=8047
```

> Ouvrir [http://localhost:8047](http://localhost:8047)

---

## 🐳 Via Docker

```bash
sudo docker build -t app:1.0 .
sudo docker run -p 8047:8047 app:1.0
```

---

## 📝 Commandes utiles

| Tâche | Commande |
|-------|----------|
| Rafraîchir autoload | `composer dump-autoload` |
| Cache config prod | `php artisan optimize` |
| Accès conteneur | `docker exec -it <id> bash` |

---

## 🤝 Contributions

Les PR sont bienvenues !  
Merci d’ouvrir une **issue** avant toute grosse modification.

---

## 📄 Licence

MIT – voir fichier `LICENSE`