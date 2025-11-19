# PBL Lab Business Analytics

## Installation

Untuk Instalasi Ikuti Step Berikut:

1. Clone Repository:

```
git clone -b prod https://github.com/baynobu/PBL-Lab-Business-Analytics.git
```

2. Create Database 'lab-ba':

```
CREATE DATABASE lab-ba;
```

3. Backup Database .sql file
   [Click here](https://github.com/baynobu/PBL-Lab-Business-Analytics/blob/docs/DB%20%2B%20etc/db-seed-lab-ba-v2.sql)

4. Run laragon server

5. Configure database di folder /app/config/database.php

6. Lalu run

```
localhost/your_folder/index.php
```

## Daftar Halaman Aplikasi (Update)

Berikut adalah daftar halaman utama beserta deskripsi dan link aksesnya:

| URL                                    | Deskripsi                                                |
| -------------------------------------- | -------------------------------------------------------- |
| `localhost/your_folder/index.php`      | Halaman utama aplikasi (Landing page)                    |
| `localhost/your_folder/login.php`      | Halaman login admin                                      |
| `localhost/your_folder/galeri.php`     | Galeri foto kegiatan laboratorium                        |
| `localhost/your_folder/dosen.php`      | Daftar dosen pengampu lab (dengan modal detail)          |
| `localhost/your_folder/profil.php`     | Profil laboratorium (visi, misi, tujuan, dsb)            |
| `localhost/your_folder/peminjaman.php` | Formulir pengajuan peminjaman lab                        |
| `localhost/your_folder/jadwal.php`     | Jadwal pemakaian/peminjaman laboratorium                 |
| `localhost/your_folder/publikasi.php`  | Daftar publikasi ilmiah/berita lab (dengan modal detail) |

#### Halaman Admin (akses: login sebagai admin)

| URL                                                  | Deskripsi                                  |
| ---------------------------------------------------- | ------------------------------------------ |
| `localhost/your_folder/admin/dashboard.php`          | Dashboard admin                            |
| `localhost/your_folder/admin/admin_manage.php`       | Manajemen akun admin                       |
| `localhost/your_folder/admin/dosen_manage.php`       | Manajemen data dosen                       |
| `localhost/your_folder/admin/galeri_manage.php`      | Manajemen galeri foto                      |
| `localhost/your_folder/admin/profil_manage.php`      | Manajemen konten profil lab                |
| `localhost/your_folder/admin/peminjaman_manage.php`  | Manajemen peminjaman lab                   |
| `localhost/your_folder/admin/pengaturan_website.php` | Pengaturan website (nama, logo, copyright) |
| `localhost/your_folder/admin/kontak_lab.php`         | Pengaturan kontak lab                      |
| `localhost/your_folder/admin/kategori_manage.php`    | Manajemen kategori dosen & publikasi       |
| `localhost/your_folder/admin/publikasi_manage.php`   | Manajemen publikasi lab                    |

> Ganti `your_folder` dengan nama folder aplikasi Anda di localhost.


## Folder Structure

```
lab-ba/
├── admin/
│   ├── admin_edit.php
│   ├── admin_hapus.php
│   ├── admin_manage.php
│   ├── admin_tambah.php
│   ├── dashboard.php
│   ├── dosen_edit.php
│   ├── dosen_hapus.php
│   ├── dosen_manage.php
│   ├── dosen_tambah.php
│   ├── galeri_edit.php
│   ├── galeri_hapus.php
│   ├── galeri_manage.php
│   ├── galeri_tambah.php
│   ├── logout.php
│   ├── peminjaman_manage.php
│   ├── peminjaman_set.php
│   ├── pengaturan_website.php
│   ├── profil_edit.php
│   ├── profil_hapus.php
│   ├── profil_manage.php
│   ├── profil_tambah.php
│   ├── kontak_lab.php
│   ├── kategori_manage.php
│   ├── publikasi_manage.php
├── app/
│   ├── config/
│   │   └── database.php
│   ├── controllers/
│   ├── models/
│   │   ├── Admin.php
│   │   ├── Dosen.php
│   │   ├── Galeri.php
│   │   ├── Peminjaman.php
│   │   ├── Profil.php
│   │   ├── Settings.php
│   ├── utils/
│   │   ├── log.php
│   │   └── session.php
├── public/
│   ├── galeri.php
│   ├── index.php
│   ├── jadwal.php
│   ├── login.php
│   ├── peminjaman.php
│   ├── profil.php
│   ├── test-db.php
│   ├── assets/
│   │   ├── css/
│   │   │   └── style.css
│   │   ├── img/
│   │   └── js/
│   │       └── script.js
├── uploads/
│   └── dosen/
├── views/
│   ├── home.php
│   └── layouts/
│       ├── footer.php
│       └── header.php
├── README.md
```
