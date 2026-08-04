# PDF Tools (Stirling-PDF Custom Deployment)

Aplikasi manipulasi PDF berbasis web berbasis **Stirling-PDF**, yang dikonfigurasi untuk kemudahan instalasi & deployment di server **Ubuntu + Docker**.

---

## 🚀 Fitur Utama

- **Manipulasi PDF**: Merge, Split, Rotate, Reorder, Compress, Crop, Watermark, Password Protect, Unlock, dll.
- **Konversi Dokumen**: PDF ke Office, Office ke PDF, Gambar ke PDF, dll.
- **OCR Scan**: Mengenali teks dari scan PDF (Tesseract OCR).
- **Keamanan Login**: Sistem otentikasi login admin bawaan & integrasi SSO (OAuth2 / SAML2).
- **Kustomisasi Mudah**: Bebas mengubah Logo, Nama Aplikasi, Tema (Light Mode), dan CSS via folder `customFiles/`.

---

## 💻 Panduan Deploy di Server Ubuntu (Docker)

### 1. Clone Repository ke Server
```bash
git clone https://github.com/muhshi/pdf-tools.git ~/pdf-tools
cd ~/pdf-tools
```

### 2. Beri Izin Eksekusi pada `deploy.sh`
```bash
chmod +x deploy.sh
```

### 3. Jalankan Deployment
```bash
./deploy.sh
```

Aplikasi akan otomatis mengunduh container image resmi, menyiapkan konfigurasi, dan berjalan di port **`8880`** (dapat diakses via `http://IP_SERVER:8880`).

---

## 🛠️ Perintah `deploy.sh` Useful Commands

- **Deploy / Update Standar**:
  ```bash
  ./deploy.sh
  ```
- **Melihat Log Live Container**:
  ```bash
  ./deploy.sh --logs
  ```
- **Menghentikan Application**:
  ```bash
  ./deploy.sh --stop
  ```
- **Build dari Local Source Code**:
  ```bash
  ./deploy.sh --build
  ```

---

## ⚙️ Kustomisasi Tampilan & SSO (Tanpa Re-build)

1. **Ubah Nama Aplikasi / Login Admin / Port / Light Mode**:
   Edit file `.env` di folder proyek:
   ```env
   PORT=8880
   SECURITY_ENABLELOGIN=true
   ADMIN_USERNAME=admin
   ADMIN_PASSWORD=PasswordRahasiaKamu
   APP_NAME=Nama Aplikasi Kamu
   SYSTEM_DEFAULTTHEME=light
   ```

2. **Ganti Logo & Favicon**:
   Letakkan file logo kamu di folder `customFiles/static/classic-logo/logo.svg` atau `customFiles/static/favicon.svg`.

3. **Custom CSS / Warna**:
   Letakkan file `custom.css` kamu di `customFiles/static/custom.css`.

---

## 📋 Changelog

### 2026-08-04
- **Perbaikan OAuth2 OIDC Discovery (`ApplicationProperties` & `OAuth2Configuration`)**: Menambahkan dukungan konfigurasi eksplisit `authorizationUri`, `tokenUri`, dan `userInfoUri` untuk Sipetra SSO (Custom OAuth2 tanpa OpenID Connect Discovery), serta menangani exception discovery secara aman agar aplikasi tidak crash saat startup.
- **Optimasi Script Deployment (`deploy.sh`)**: Mengganti alur sinkronisasi Git menggunakan `git fetch --all` dan `git reset --hard` agar deployment tidak pernah gagal akibat `unstaged changes` atau bentrok `git pull`.
- **Konfigurasi Kredensial SSO Sipetra (OAuth2)**: Mengintegrasikan Client ID (`019fca70-defd-73c4-b5d5-f2ac581a0792`) dan Client Secret Sipetra SSO ke dalam `.env`, `.env.example`, dan `docker-compose.yml` dengan provider `sipetra`.
- **Perencanaan Integrasi SSO Sipetra & Light Mode**: Menambahkan file perencanaan kerja `tasks/plan.md` dan checklist `tasks/todo.md` untuk integrasi SSO Sipetra (OAuth2) dan pengaturan Light Mode bawaan.
- **Konfigurasi Light Mode**: Menambahkan default theme `light` pada `extraConfigs/custom_settings.yml` dan file styling `customFiles/static/custom.css`.

### 2026-08-03
- **Perbaikan Deployment Git**: Memperbarui `deploy.sh` menggunakan `git fetch && git reset --hard origin/main` agar tidak gagal pada server.
- **Pembersihan Docker Compose**: Menghapus atribut `version: '3.8'` pada `docker-compose.yml`.
- **Update Port Default Server**: Mengubah default port aplikasi dari `8080` menjadi **`8880`**.
- **Inisialisasi Repositori**: Menyiapkan repositori bersih `pdf-tools` berbasis Stirling-PDF.
