# TODO List: SSO Sipetra & Light Mode Integration

## Phase 1: Foundation & Configuration
- [ ] **Task 1**: Dapatkan Client ID, Client Secret, & Issuer URI dari Admin SSO Sipetra
- [ ] **Task 2**: Update `.env` & `.env.example` dengan konfigurasi OAuth2 Sipetra & `SYSTEM_DEFAULTTHEME=light`

## Checkpoint 1: Configuration Readiness
- [ ] File `.env` terkonfigurasi dengan variabel SSO Sipetra & Light Mode

## Phase 2: Theme Customization (Light Mode)
- [ ] **Task 3**: Atur `system.defaultTheme: light` pada `extraConfigs/custom_settings.yml` & siapkan `customFiles/static/custom.css`

## Phase 3: Deployment & End-to-End Verification
- [ ] **Task 4**: Jalankan `./deploy.sh` di server Ubuntu untuk merestart container dengan `.env` baru
- [ ] **Task 5**: Verifikasi alur login SSO Sipetra & tampilan Light Mode di browser (`http://10.133.21.24:8880`)

## Checkpoint 2: Feature Complete
- [ ] Login SSO Sipetra sukses & tampilan default Light Mode aktif
