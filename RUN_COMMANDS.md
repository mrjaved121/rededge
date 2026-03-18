# Red Edge — Setup & Run Commands

## Prerequisites

- **Node.js** v18+ — [nodejs.org](https://nodejs.org)
- **MongoDB** v6+ — [mongodb.com](https://www.mongodb.com/try/download/community)
- **Flutter** v3.22+ — [flutter.dev](https://flutter.dev)
- **Android device/emulator** with USB debugging enabled

---

## 1. Start MongoDB

```bash
# Windows (if installed as service, it starts automatically)
# Otherwise run:
mongod

# Verify connection:
mongosh mongodb://127.0.0.1:27017/rededge
```

---

## 2. Backend Setup (first time only)

```bash
cd backend
npm install
```

### Configure Environment

Edit `backend/.env`:

```env
PORT=3000
MONGODB_URI=mongodb://127.0.0.1:27017/rededge
JWT_SECRET=rededge_jwt_secret_change_in_production_2026
JWT_EXPIRES_IN=7d
UPLOAD_DIR=uploads

# ImageKit.io — get from https://imagekit.io/dashboard/developer/api-keys
IMAGEKIT_PUBLIC_KEY=your_public_key
IMAGEKIT_PRIVATE_KEY=your_private_key
IMAGEKIT_URL_ENDPOINT=https://ik.imagekit.io/your_id
```

### Seed Database (first time / reset)

```bash
cd backend
npm run seed
```

This creates:
- Admin user: `admin@rededge.com` / `password123`
- System types (Hemisphere VR1000 Dozer, Excavator, Stonex STX-DIG, etc.)
- Checklist templates for each system type

---

## 3. Start Backend Server

```bash
cd backend
node src/server.js
```

Expected output:
```
MongoDB connected
Red Edge API running on port 3000
```

API base URL: `http://<your-ip>:3000/api/v1`

Find your IP:
```bash
# Windows
ipconfig
# Look for IPv4 Address under Wi-Fi adapter
```

---

## 4. Flutter App Setup

### Update API base URL

Edit `lib/core/network/api_client.dart` — update the base URL to your computer's IP:

```dart
static const String baseUrl = 'http://<your-ip>:3000/api/v1';
```

### Run the app

```bash
cd D:\Desktop\redEdge
flutter run
```

Or for a specific device:
```bash
flutter devices          # list connected devices
flutter run -d <device>  # run on specific device
```

### Hot reload / restart

- Press `r` in terminal for hot reload
- Press `R` for hot restart (clears state)

---

## 5. All-in-One Quick Start

Open two terminals:

**Terminal 1 — Backend:**
```bash
cd D:\Desktop\redEdge\backend
node src/server.js
```

**Terminal 2 — Flutter:**
```bash
cd D:\Desktop\redEdge
flutter run
```

---

## Login Credentials

| Role      | Email              | Password    |
|-----------|--------------------|-------------|
| Admin     | admin@rededge.com  | password123 |
| Installer | (create from admin panel or seed) | |

---

## Useful Commands

```bash
# Check MongoDB status
mongosh --eval "db.adminCommand('ping')"

# View all collections
mongosh mongodb://127.0.0.1:27017/rededge --eval "db.getCollectionNames()"

# View all jobs
mongosh mongodb://127.0.0.1:27017/rededge --eval "db.jobs.find().pretty()"

# View all users
mongosh mongodb://127.0.0.1:27017/rededge --eval "db.users.find({}, {name:1, email:1, role:1}).pretty()"

# View all photos
mongosh mongodb://127.0.0.1:27017/rededge --eval "db.photos.find().pretty()"

# Reset database (drop and re-seed)
mongosh mongodb://127.0.0.1:27017/rededge --eval "db.dropDatabase()"
cd backend && npm run seed

# Kill process on port 3000 (if port busy)
npx kill-port 3000

# Flutter clean rebuild
flutter clean && flutter pub get && flutter run
```

---

## API Endpoints

| Method | Endpoint                     | Description            |
|--------|------------------------------|------------------------|
| POST   | /api/v1/auth/register        | Register user          |
| POST   | /api/v1/auth/login           | Login                  |
| GET    | /api/v1/auth/me              | Current user           |
| GET    | /api/v1/jobs                 | List jobs              |
| GET    | /api/v1/jobs/:id             | Job details            |
| POST   | /api/v1/jobs                 | Create job (admin)     |
| PUT    | /api/v1/jobs/:id             | Update job             |
| DELETE | /api/v1/jobs/:id             | Delete job (admin)     |
| PUT    | /api/v1/jobs/:id/status      | Update job status      |
| POST   | /api/v1/photos/upload        | Upload photo (ImageKit)|
| GET    | /api/v1/photos               | List photos            |
| DELETE | /api/v1/photos/:id           | Delete photo           |
| GET    | /api/v1/system-types         | List system types      |
| POST   | /api/v1/system-types         | Create system type     |
| GET    | /api/v1/users                | List users (admin)     |
