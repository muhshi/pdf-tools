# Implementation Plan: Integrasi SSO Sipetra & Light Mode Theme

## 📌 Overview
Rencana implementasi integrasi **Single Sign-On (SSO) Sipetra** (OAuth2/OIDC atau SAML2) dan pengaturan tampilan bawaan ke **Light Mode** pada aplikasi **PDF Tools (Stirling-PDF)**. 

Dokumen ini disusun menggunakan panduan `/planning-and-task-breakdown` agar siap dieksekusi secara terstruktur dan dapat dilanjutkan melalui IDE.

---

## 🏗️ Architecture & Configuration Decisions

1. **SSO Sipetra (OAuth2 / OIDC)**:
   - Menggunakan modul `Spring Security OAuth2` bawaan Stirling-PDF.
   - Mengonfigurasi `SECURITY_OAUTH2_*` pada `.env` tanpa perlu mem-build ulang kode Java.
   - Mendaftarkan Callback URL: `http://10.133.21.24:8880/login/oauth2/code/custom` (atau URL domain produksi).

2. **Light Mode Theme**:
   - Mengatur tema bawaan aplikasi menjadi `light` melalui parameter `.env` (`SYSTEM_DEFAULTTHEME=light`) dan `settings.yml`.
   - Menyiapkan `customFiles/static/custom.css` untuk kustomisasi palet warna terang jika diperlukan.

---

## 📋 Task List & Breakdown

### Phase 1: Preparation & Configuration (Foundation)

#### Task 1: Dapatkan Kredensial SSO Sipetra & Daftarkan Callback URL
- **Description:** Meminta Client ID, Client Secret, dan Issuer URI dari Tim IT/Admin SSO Sipetra, serta mendaftarkan Redirect URI aplikasi.
- **Acceptance criteria:**
  - [ ] Client ID dan Client Secret SSO Sipetra diperoleh.
  - [ ] Issuer URI / Authorize URL SSO Sipetra diperoleh.
  - [ ] Redirect Callback URL `http://10.133.21.24:8880/login/oauth2/code/custom` terdaftar di Sipetra SSO.
- **Verification:** Konfirmasi dari Admin SSO Sipetra bahwa Client ID & Redirect URL aktif.
- **Estimated scope:** XS (0 files / Admin Coordination)

#### Task 2: Konfigurasi SSO Sipetra di `.env` & `.env.example`
- **Description:** Menambahkan konfigurasi OAuth2 Sipetra dan Light Mode ke `.env` dan `.env.example`.
- **Acceptance criteria:**
  - [ ] File `.env` dan `.env.example` memuat variabel `SECURITY_OAUTH2_*`.
  - [ ] File `.env` memuat `SYSTEM_DEFAULTTHEME=light`.
- **Verification:** File `.env` dan `.env.example` ter-update dengan variabel SSO Sipetra dan Light Mode.
- **Estimated scope:** XS (2 files: `.env`, `.env.example`)

---

### Checkpoint 1: Configuration Readiness
- [ ] Kredensial SSO Sipetra lengkap
- [ ] Variable `.env` dan `.env.example` ter-update

---

### Phase 2: Theme Kustomisasi (Light Mode)

#### Task 3: Konfigurasi Default Light Mode pada `custom_settings.yml` & `custom.css`
- **Description:** Mengatur default theme ke Light Mode di `extraConfigs/custom_settings.yml` dan menyediakan CSS override jika diperlukan.
- **Acceptance criteria:**
  - [ ] `extraConfigs/custom_settings.yml` memiliki `system.defaultTheme: light`.
  - [ ] Template `customFiles/static/custom.css` siap untuk penyesuaian warna jika diperlukan.
- **Verification:** Aplikasi tampil dengan latar belakang terang/light mode secara default saat dibuka pertama kali.
- **Estimated scope:** S (2 files: `extraConfigs/custom_settings.yml`, `customFiles/static/custom.css`)

---

### Phase 3: Deployment & Integration Testing

#### Task 4: Deploy Updates ke Server Ubuntu
- **Description:** Jalankan script `./deploy.sh` di server Ubuntu untuk menerapkan `.env` baru dan restart container.
- **Acceptance criteria:**
  - [ ] Container `pdf-tools` berhasil di-restart tanpa error.
  - [ ] Log menunjukkan `Security profile: active` dan `OAuth2 client registered`.
- **Verification:** Exec `./deploy.sh --logs` menampilkan log startup bersih.
- **Estimated scope:** XS (Exec script `./deploy.sh`)

#### Task 5: Testing Login SSO Sipetra & UI Light Mode End-to-End
- **Description:** Pengujian alur login SSO Sipetra di browser dan verifikasi mode terang UI.
- **Acceptance criteria:**
  - [ ] Tombol **Login with Sipetra SSO** muncul di halaman login (`http://10.133.21.24:8880/login`).
  - [ ] Klik tombol SSO mengarahkan pengguna ke halaman login Sipetra.
  - [ ] Setelah sukses login Sipetra, pengguna kembali ke PDF Tools dan berhasil masuk.
  - [ ] Tampilan halaman utama PDF Tools berupa Light Mode.
- **Verification:** Pengujian login di browser secara manual.
- **Estimated scope:** S (Manual Testing & Verification)

---

### Checkpoint 2: Feature Complete
- [ ] Login SSO Sipetra sukses end-to-end
- [ ] Tampilan aplikasi default Light Mode
- [ ] Semua pengujian terverifikasi OK

---

## 🛡️ Risks and Mitigations

| Risk | Impact | Mitigation |
|------|--------|------------|
| SSL / HTTPS Mismatch pada SSO Callback | High | Gunakan HTTPS via Nginx Reverse Proxy jika SSO Sipetra mewajibkan HTTPS pada Callback URL. |
| User Attribute Mismatch (Attribute email/name beda) | Medium | Atur `SECURITY_OAUTH2_USER_ATTRIBUTE` sesuai claim yang dikirim oleh Sipetra (cth: `preferred_username` / `email`). |

---

## 📝 Open Questions
- Apakah SSO Sipetra menggunakan **OAuth2/OIDC** atau **SAML 2.0**? *(Default rencana di atas menggunakan OAuth2/OIDC)*.
- Apakah Callback URL membutuhkan **HTTPS / Domain** (misal `https://pdf.sipetra.id/login/oauth2/code/custom`)?
