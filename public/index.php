<?php
require_once "../app/models/Profil.php";
require_once "../app/models/Galeri.php";
include "../views/layouts/header.php";
?>

<!-- HERO SECTION -->
<div class="p-5 mb-4 bg-light rounded-3">
    <div class="container py-5">
        <h1 class="display-5 fw-bold">Laboratorium Business Analytics</h1>
        <p class="col-md-8 fs-5">
            Fasilitas penelitian, pengembangan, dan pembelajaran berbasis data untuk mendukung inovasi akademik.
        </p>
        <a href="peminjaman.php" class="btn btn-primary btn-lg">Ajukan Peminjaman Lab</a>
    </div>
</div>

<!-- SEKILAS PROFIL -->
<div class="container mb-5">
    <h2 class="mb-3">Profil Laboratorium</h2>
    <?php foreach (Profil::all() as $p): ?>
        <h5 class="fw-semibold"><?= $p['judul']; ?> (<?= $p['kategori']; ?>)</h5>
        <p><?= nl2br($p['isi']); ?></p>
        <hr>
    <?php endforeach; ?>
</div>

<!-- GALERI SLIDER -->
<div class="container mb-5">
    <h2 class="mb-3">Galeri Kegiatan</h2>

    <div id="carouselGaleri" class="carousel slide" data-bs-ride="carousel">
        <div class="carousel-inner">
            <?php $i = 0;
            foreach (Galeri::all() as $g): ?>
                <div class="carousel-item <?= $i == 0 ? 'active' : '' ?>">
                    <img src="/lab-ba/public/uploads/galeri/<?= $g['gambar']; ?>" class="d-block w-100" style="max-height: 450px; object-fit: cover;">
                    <div class="carousel-caption d-none d-md-block bg-dark bg-opacity-50 rounded">
                        <h5><?= $g['judul']; ?></h5>
                    </div>
                </div>
            <?php $i++;
            endforeach; ?>
        </div>

        <button class="carousel-control-prev" type="button" data-bs-target="#carouselGaleri" data-bs-slide="prev">
            <span class="carousel-control-prev-icon"></span>
        </button>
        <button class="carousel-control-next" type="button" data-bs-target="#carouselGaleri" data-bs-slide="next">
            <span class="carousel-control-next-icon"></span>
        </button>
    </div>

    <div class="text-end mt-2">
        <a href="galeri.php" class="btn btn-outline-secondary btn-sm">Lihat Semua Galeri</a>
    </div>
</div>

<!-- JADWAL LINK -->
<div class="container mb-5 text-center">
    <a href="jadwal.php" class="btn btn-success">Lihat Jadwal Peminjaman</a>
</div>

<!-- HERO -->
<section class="hero">
    <div class="container">
        <img src="/lab-ba/public/uploads/logo/<?= $S['logo'] ?: 'default.png'; ?>">
        <h1 class="fw-bold"><?= $S['site_name']; ?></h1>
        <p>Fasilitas penelitian dan pembelajaran berbasis analisis data.</p>
        <a href="peminjaman.php" class="btn btn-primary btn-lg mt-3">Ajukan Peminjaman</a>
    </div>
</section>


<?php include "../views/layouts/footer.php"; ?>