# PDF Tools (Stirling-PDF Custom Deployment)

Aplikasi manipulasi PDF berbasis web berbasis **Stirling-PDF**, yang dikonfigurasi untuk kemudahan instalasi & deployment di server **Ubuntu + Docker**.

---

## 🚀 Fitur Utama

- **Manipulasi PDF**: Merge, Split, Rotate, Reorder, Compress, Crop, Watermark, Password Protect, Unlock, dll.
- **Konversi Dokumen**: PDF ke Office, Office ke PDF, Gambar ke PDF, dll.
- **OCR Scan**: Mengenali teks dari scan PDF (Tesseract OCR).
- **Keamanan Login**: Sistem otentikasi login admin bawaan.
- **Kustomisasi Mudah**: Bebas mengubah Logo, Nama Aplikasi, dan CSS via folder `customFiles/`.

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

Aplikasi akan otomatis mengunduh container image resmi, menyiapkan konfigurasi, dan berjalan di port `8080` (dapat diakses via `http://IP_SERVER:8080`).

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
- **Build dari Local Source Code (jika ada perubahan kodingan Java/React)**:
  ```bash
  ./deploy.sh --build
  ```

---

## ⚙️ Kustomisasi Tampilan (Tanpa Re-build)

1. **Ubah Nama Aplikasi / Login Admin / Port**:
   Edit file `.env` di folder proyek:
   ```env
   PORT=8080
   SECURITY_ENABLELOGIN=true
   ADMIN_USERNAME=admin
   ADMIN_PASSWORD=PasswordRahasiaKamu
   APP_NAME=Nama Aplikasi Kamu
   ```

2. **Ganti Logo & Favicon**:
   Letakkan file logo kamu di folder `customFiles/static/classic-logo/logo.svg` atau `customFiles/static/favicon.svg`.

3. **Custom CSS / Warna**:
   Letakkan file `custom.css` kamu di `customFiles/static/custom.css`.

---

## 📋 Changelog

### 2026-08-03
- **Inisialisasi Repositori**: Menyiapkan repositori bersih `pdf-tools` berbasis Stirling-PDF.
- **Konfigurasi Docker**: Menambahkan `docker-compose.yml` siap pakai untuk produksi di server Ubuntu.
- **Otomatisasi Deployment**: Menambahkan script `deploy.sh` untuk mempermudah `git pull`, build, restart, dan pemantauan log di server.
- **Konfigurasi Environment**: Menambahkan `.env.example` untuk pengaturan port, kredensial login, dan nama aplikasi.
