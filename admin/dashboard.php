<?php
require_once "../app/utils/session.php";
checkAdminLogin();
?>


<?php include "../views/layouts/header.php"; ?>

<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-lg-7">
            <div class="card shadow-lg border-0 mb-4" style="border-radius: 1.5rem;">
                <div class="card-body p-5 text-center">
                    <img src="../public/assets/img/maskot.png" alt="Lab BA" width="76" class="mb-3 hero-maskot-img shadow-sm" style="background:transparent;">
                    <h2 class="fw-bold text-primary-custom mb-2">Selamat Datang, <?= htmlspecialchars($_SESSION['admin_username']); ?> 👋</h2>
                    <p class="lead mb-4">Panel Admin <span class="fw-semibold text-accent">Laboratorium Business Analytics</span>.<br>Kelola data, pantau aktivitas, dan lakukan administrasi dengan mudah.</p>
                    <a href="logout.php" class="btn btn-outline-danger btn-lg rounded-pill px-4 fw-bold">Logout</a>
                </div>
            </div>
            <!-- <div class="alert alert-info text-center rounded-4 shadow-sm">
                <strong>Tips:</strong> Gunakan menu di atas untuk mengelola data dosen, galeri, peminjaman, dan pengaturan website.
            </div> -->
            <style>
                .hero-maskot-img {
                    border-radius: 18px;
                    box-shadow: 0 4px 16px 0 rgba(10, 42, 67, 0.10);
                }
            </style>
        </div>
    </div>
</div>