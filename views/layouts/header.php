<?php require_once "../app/models/Settings.php";
$S = Settings::get();
if (!$S) {
  $S = [
    'site_name' => 'Lab Business Analytics',
    'logo' => ''
  ];
}
?>

<!DOCTYPE html>
<html>

<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Lab Business Analytics</title>
  <!-- Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <!-- Google Fonts: Poppins, Inter, Rubik -->
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600&family=Poppins:wght@400;700&family=Rubik:wght@400;700&display=swap" rel="stylesheet">
  <!-- Custom Style -->
  <link rel="stylesheet" href="/lab-ba/public/assets/css/style.css">
  <!-- Bootstrap JS (agar dropdown berfungsi di admin) -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
  <!-- Dropdown fix jika JS tidak otomatis jalan -->
  <script src="/lab-ba/public/assets/js/dropdown-fix.js"></script>
  <style>
    body {
      font-family: 'Poppins', 'Inter', 'Rubik', Arial, sans-serif;
      background-color: #f8f9fa;
    }

    .bg-primary-custom {
      background-color: #0A2A43 !important;
    }

    .text-primary-custom {
      color: #0A2A43 !important;
    }

    .bg-accent {
      background-color: #3FA2F7 !important;
    }

    .text-accent {
      color: #3FA2F7 !important;
    }

    .navbar-brand {
      font-weight: 700;
      letter-spacing: 1px;
    }

    .btn-accent {
      background-color: #3FA2F7;
      color: #fff;
      border: none;
    }

    .btn-accent:hover {
      background-color: #2196f3;
      color: #fff;
    }

    .section-title {
      font-size: 2.2rem;
      font-weight: 700;
      color: #0A2A43;
      margin-bottom: 1.5rem;
    }

    .section-subtitle {
      color: #3FA2F7;
      font-weight: 600;
    }

    html {
      scroll-behavior: smooth;
    }
  </style>
</head>


<?php
// Deteksi admin login
if (session_status() === PHP_SESSION_NONE) {
  session_start();
}
$isAdmin = isset($_SESSION['admin_id']);
$adminName = $isAdmin ? $_SESSION['admin_username'] : null;
// Daftar menu sidebar admin (otomatis dari file di folder admin)
$adminMenus = [
  ['label' => 'Dashboard', 'file' => 'dashboard.php', 'icon' => 'bi-speedometer2'],
  ['label' => 'Manajemen Admin', 'file' => 'admin_manage.php', 'icon' => 'bi-person-badge'],
  ['label' => 'Manajemen Dosen', 'file' => 'dosen_manage.php', 'icon' => 'bi-people'],
  ['label' => 'Manajemen Galeri', 'file' => 'galeri_manage.php', 'icon' => 'bi-images'],
  ['label' => 'Manajemen Publikasi', 'file' => 'publikasi_manage.php', 'icon' => 'bi-journal-text'],
  ['label' => 'Manajemen Kategori', 'file' => 'kategori_manage.php', 'icon' => 'bi-tags'],
  ['label' => 'Manajemen Peminjaman', 'file' => 'peminjaman_manage.php', 'icon' => 'bi-calendar-check'],
  ['label' => 'Manajemen Profil', 'file' => 'profil_manage.php', 'icon' => 'bi-person-lines-fill'],
  ['label' => 'Pengaturan Website', 'file' => 'pengaturan_website.php', 'icon' => 'bi-gear'],
  ['label' => 'Pengaturan Kontak', 'file' => 'kontak_lab.php', 'icon' => 'bi-telephone'],
];
?>

<body class="d-flex flex-column min-vh-100">

  <!-- Navbar -->
  <?php if ($isAdmin && strpos($_SERVER['PHP_SELF'], '/admin/') !== false): ?>
    <nav class="navbar navbar-expand-lg bg-primary-custom navbar-dark py-3 fixed-top shadow-sm">
      <div class="container-fluid">
        <a class="navbar-brand d-flex align-items-center gap-2" href="/lab-ba/public/index.php">
          <?php if (!empty($S['logo'])): ?>
            <img src="/lab-ba/public/uploads/logo/<?= htmlspecialchars($S['logo']) ?>" alt="Logo" style="height:36px;max-width:48px;object-fit:contain;">
          <?php endif; ?>
          <?= htmlspecialchars($S['site_name'] ?? 'Lab Business Analytics') ?>
        </a>
        <ul class="navbar-nav ms-auto mb-2 mb-lg-0">
          <li class="nav-item">
            <a class="btn btn-danger fw-semibold rounded-pill px-4" href="/lab-ba/admin/logout.php">
              <i class="bi bi-box-arrow-right"></i> Logout
            </a>
          </li>
        </ul>
      </div>
    </nav>
  <?php else: ?>
    <nav class="navbar navbar-expand-lg bg-primary-custom navbar-dark py-3 fixed-top shadow-sm">
      <div class="container-fluid">
        <a class="navbar-brand d-flex align-items-center gap-2" href="/lab-ba/public/index.php">
          <?php if (!empty($S['logo'])): ?>
            <img src="/lab-ba/public/uploads/logo/<?= htmlspecialchars($S['logo']) ?>" alt="Logo" style="height:36px;max-width:48px;object-fit:contain;">
          <?php endif; ?>
          <?= htmlspecialchars($S['site_name'] ?? 'Lab Business Analytics') ?>
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
          <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
          <ul class="navbar-nav ms-auto mb-2 mb-lg-0">
            <li class="nav-item"><a class="nav-link" href="#hero">Home</a></li>
            <li class="nav-item"><a class="nav-link" href="#profile">Profile</a></li>
            <li class="nav-item"><a class="nav-link" href="#galeri">Galeri</a></li>
            <li class="nav-item"><a class="nav-link" href="#dosen">Dosen</a></li>
            <li class="nav-item"><a class="nav-link" href="#kontak">Kontak</a></li>
            <?php if (!$isAdmin): ?>
              <li class="nav-item"><a class="nav-link" href="/lab-ba/public/login.php">Login</a></li>
            <?php else: ?>
              <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" href="#" id="adminDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                  <i class="bi bi-person-circle"></i> Hi, <?= htmlspecialchars($adminName) ?>
                </a>
                <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="adminDropdown">
                  <li><a class="dropdown-item" href="/lab-ba/admin/dashboard.php">Dashboard Admin</a></li>
                  <li>
                    <hr class="dropdown-divider">
                  </li>
                  <li><a class="dropdown-item" href="/lab-ba/admin/logout.php">Logout</a></li>
                </ul>
              </li>
            <?php endif; ?>
          </ul>
        </div>
      </div>
    </nav>
  <?php endif; ?>
  <!-- End Navbar -->

  <style>
    body {
      padding-top: 74px !important;
    }

    @media (max-width: 991.98px) {
      body {
        padding-top: 62px !important;
      }
    }

    .navbar.fixed-top {
      box-shadow: 0 2px 16px 0 rgba(10, 42, 67, 0.10);
    }
  </style>

  <?php if ($isAdmin && strpos($_SERVER['PHP_SELF'], '/admin/') !== false): ?>
    <div class="container-fluid">
      <div class="row">
        <!-- Sidebar -->
        <nav class="col-md-2 d-none d-md-block bg-light sidebar py-4" style="min-height: 100vh;">
          <div class="position-sticky">
            <ul class="nav flex-column">
              <?php foreach ($adminMenus as $menu): ?>
                <li class="nav-item mb-1">
                  <a class="nav-link d-flex align-items-center gap-2 <?php if (basename($_SERVER['PHP_SELF']) === $menu['file']) echo 'active text-accent fw-bold'; ?>" href="/lab-ba/admin/<?= $menu['file'] ?>">
                    <i class="bi <?= $menu['icon'] ?>"></i> <?= $menu['label'] ?>
                  </a>
                </li>
              <?php endforeach; ?>
            </ul>
          </div>
        </nav>
        <main class="col-md-10 ms-sm-auto px-4 py-4">
        <?php endif; ?>