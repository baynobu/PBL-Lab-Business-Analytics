# PBL Lab Business Analytics

## Installation

Untuk Instalasi Ikuti Step Berikut:

1. Clone Repository:

```
git clone -b prod https://github.com/baynobu/PBL-Lab-Business-Analytics.git
```

Lalu ubah nama folder nya menjadi lab-ba

2. Create Database 'lab-ba':

```
CREATE DATABASE lab-ba;
```

3. Backup Database .sql file
   [Click here](https://github.com/baynobu/PBL-Lab-Business-Analytics/blob/docs/DB%20%2B%20etc/db-seed-lab-ba-completed.sql)

4. Run laragon server

5. Configure database di folder /app/config/database.php

6. Lalu run

```
localhost/lab-ba/public/index.php
```

## Daftar Halaman Aplikasi (Update)

Berikut adalah daftar halaman utama beserta deskripsi dan link aksesnya:

| URL                                    | Deskripsi                                                  |
| -------------------------------------- | ---------------------------------------------------------- |
| `localhost/lab-ba/public/index.php`      | Halaman utama aplikasi (Landing page)                      |
| `localhost/lab-ba/public/login.php`      | Halaman login admin                                        |
| `localhost/lab-ba/public/galeri.php`     | Galeri foto kegiatan laboratorium                          |
| `localhost/lab-ba/public/dosen.php`      | Daftar dosen pengampu lab (dengan modal detail)            |
| `localhost/lab-ba/public/profil.php`     | Profil laboratorium (visi, misi, tujuan, dsb)              |
| `localhost/lab-ba/public/peminjaman.php` | Formulir pengajuan peminjaman lab                          |
| `localhost/lab-ba/public/jadwal.php`     | Jadwal pemakaian/peminjaman laboratorium                   |
| `localhost/lab-ba/public/publikasi.php`  | Daftar publikasi ilmiah/berita lab (dengan modal detail)   |
| `localhost/lab-ba/public/berita.php`     | Daftar berita/liputan terbaru laboratorium (card & detail) |

#### Halaman Admin (akses: login sebagai admin)

| URL                                                  | Deskripsi                                  |
| ---------------------------------------------------- | ------------------------------------------ |
| `localhost/lab-ba/admin/dashboard.php`          | Dashboard admin                            |
| `localhost/lab-ba/admin/admin_manage.php`       | Manajemen akun admin                       |
| `localhost/lab-ba/admin/dosen_manage.php`       | Manajemen data dosen                       |
| `localhost/lab-ba/admin/galeri_manage.php`      | Manajemen galeri foto                      |
| `localhost/lab-ba/admin/profil_manage.php`      | Manajemen konten profil lab                |
| `localhost/lab-ba/admin/peminjaman_manage.php`  | Manajemen peminjaman lab                   |
| `localhost/lab-ba/admin/pengaturan_website.php` | Pengaturan website (nama, logo, copyright) |
| `localhost/lab-ba/admin/kontak_lab.php`         | Pengaturan kontak lab                      |
| `localhost/lab-ba/admin/kategori_manage.php`    | Manajemen kategori dosen & publikasi       |
| `localhost/lab-ba/admin/publikasi_manage.php`   | Manajemen publikasi lab                    |
| `localhost/lab-ba/admin/berita_manage.php`      | Manajemen berita/liputan lab               |

> Pastikan folder aplikasi web bernama `lab-ba`.

## Fitur Terbaru & Catatan

### Fitur Terbaru

- **Berita/Liputan:**
  - Halaman publik berita (`berita.php`, `berita_detail.php`), card grid, detail, search, pagination, upload gambar
  - Admin CMS berita: CRUD (tambah, edit, hapus), validasi, log aktivitas admin
- **Log Aktivitas Admin:**
  - Semua aksi CRUD pada CMS admin (tambah, edit, hapus, set status) tercatat otomatis di log
- **Navigasi Footer & Sidebar:**
  - Link ke fitur terbaru (Publikasi, Berita, Peminjaman) sudah tersedia di footer dan sidebar admin
- **UI/UX Modern:**
  - Bootstrap 5, responsive, animasi, modal detail, badge, dan icon
- **Validasi & Keamanan:**
  - Validasi form, upload file, prepared statement, session admin

### Catatan

- Semua aksi penting di CMS admin (tambah, edit, hapus, set status) sudah otomatis tercatat di log aktivitas admin
- Untuk menambah log pada aksi lain (misal: ekspor, filter, akses halaman), dapat menambah pemanggilan `logActivity()`
- Fitur Berita/Liputan dapat diakses publik dan admin

## Folder Structure

```
├── README.md
├── admin
│   ├── berita
│   │   ├── edit.php
│   │   ├── hapus.php
│   │   ├── manage.php
│   │   └── tambah.php
│   ├── dashboard.php
│   ├── dosen
│   │   ├── edit.php
│   │   ├── hapus.php
│   │   ├── manage.php
│   │   └── tambah.php
│   ├── galeri
│   │   ├── edit.php
│   │   ├── hapus.php
│   │   ├── manage.php
│   │   └── tambah.php
│   ├── kategori
│   │   ├── edit.php
│   │   ├── hapus.php
│   │   ├── manage.php
│   │   └── tambah.php
│   ├── kelola_jam
│   │   └── jam-tidak-tersedia.php
│   ├── kontak
│   │   └── lab.php
│   ├── logout.php
│   ├── peminjaman
│   │   ├── hapus.php
│   │   ├── manage.php
│   │   └── set.php
│   ├── pengaturan
│   │   └── website.php
│   ├── profil
│   │   ├── edit.php
│   │   ├── hapus.php
│   │   ├── manage.php
│   │   └── tambah.php
│   ├── publikasi
│   │   ├── edit.php
│   │   ├── hapus.php
│   │   ├── manage.php
│   │   └── tambah.php
│   └── users
│       ├── edit.php
│       ├── hapus.php
│       ├── manage.php
│       └── tambah.php
├── app
│   ├── config
│   │   └── database.php
│   ├── controllers
│   │   └── PeminjamanController.php
│   ├── models
│   │   ├── Admin.php
│   │   ├── Berita.php
│   │   ├── Dosen.php
│   │   ├── Galeri.php
│   │   ├── JamTidakTersedia.php
│   │   ├── Kategori.php
│   │   ├── KontakLab.php
│   │   ├── Peminjaman.php
│   │   ├── Profil.php
│   │   ├── Publikasi.php
│   │   └── Settings.php
│   └── utils
│       ├── log.php
│       └── session.php
├── public
│   ├── assets
│   │   ├── css
│   │   │   └── style.css
│   │   ├── img
│   │   │   ├── logo.png
│   │   │   └── maskot.png
│   │   └── js
│   │       ├── dropdown-fix.js
│   │       └── script.js
│   ├── berita.php
│   ├── berita_detail.php
│   ├── dosen.php
│   ├── galeri.php
│   ├── index.php
│   ├── jadwal.php
│   ├── login.php
│   ├── peminjaman.php
│   ├── profil.php
│   ├── publikasi.php
│   ├── publikasi_detail.php
│   ├── test-db.php
│   └── uploads
│       ├── berita
│       ├── dosen
│       ├── galeri
│       ├── logo
│       │   └── logo.png
│       └── publikasi
└── views
    ├── home.php
    ├── layouts
    │   ├── footer.php
    │   └── header.php
    └── peminjaman.php
```
