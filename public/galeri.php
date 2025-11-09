<?php include "../views/layouts/header.php"; ?>
<?php require_once "../app/models/Galeri.php"; ?>

<h2>Galeri Kegiatan Laboratorium</h2>

<div id="carouselGaleri" class="carousel slide" data-bs-ride="carousel">
    <div class="carousel-inner">
        <?php $i = 0;
        foreach (Galeri::all() as $g): ?>
            <div class="carousel-item <?= $i == 0 ? 'active' : '' ?>">
                <img src="/lab-ba/public/uploads/galeri/<?= $g['gambar']; ?>" class="d-block w-100" style="max-height: 500px; object-fit: cover;">
                <div class="carousel-caption d-none d-md-block bg-dark bg-opacity-50">
                    <h5><?= $g['judul']; ?></h5>
                    <p><?= $g['deskripsi']; ?></p>
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

<section>
    <div class="container">
        <h2 class="section-title">Galeri Lab</h2>
        ...
    </div>
</section>


<?php include "../views/layouts/footer.php"; ?>