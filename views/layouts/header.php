<?php require_once "../app/models/Settings.php";
$S = Settings::get(); ?>

<!DOCTYPE html>
<html>

<head>
  <title>Laboratorium Business Analytics</title>
  <img src="/lab-ba/public/uploads/logo/<?= $S['logo'] ?: 'default.png'; ?>" height="45">
  <span><?= $S['site_name']; ?></span>

  <link rel="stylesheet" href="/lab-ba/public/vendor/bootstrap.min.css">
  <link rel="stylesheet" href="/lab-ba/public/assets/css/style.css">
</head>

<body>
  <nav class="navbar navbar-expand-lg navbar-light bg-light">
    <a class="navbar-brand" href="/lab-ba/public/index.php">Lab BA</a>
    <li class="nav-item">
      <a class="nav-link" href="/lab-ba/public/jadwal.php">Jadwal</a>
    </li>
  </nav>
  <div class="container mt-4">