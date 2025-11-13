<?php include "../views/layouts/header.php"; ?>
<?php require_once "../app/models/Profil.php"; ?>

<section class="bg-white py-5 min-vh-100">
    <div class="container">
        <div class="text-center mb-5">
            <h2 class="fw-bold mb-1 text-primary-custom">Profil Laboratorium Business Analytics</h2>
            <div class="text-muted">Informasi lengkap tentang visi, misi, dan aktivitas Laboratorium Business Analytics</div>
        </div>
        <div class="row g-4">
            <?php foreach (Profil::all() as $p): ?>
                <div class="col-md-6 col-lg-4">
                    <div class="card h-100 shadow-sm border-0">
                        <div class="card-body">
                            <h5 class="card-title mb-1 text-primary-custom"><?= htmlspecialchars($p['judul']) ?></h5>
                            <span class="badge bg-accent mb-2"><?= htmlspecialchars($p['kategori']) ?></span>
                            <div class="card-text" style="white-space:pre-line;">
                                <?= nl2br(htmlspecialchars($p['isi'])) ?>
                            </div>
                        </div>
                    </div>
                </div>
            <?php endforeach; ?>
        </div>
    </div>
</section>

<style>
    .text-primary-custom {
        color: #0A2A43 !important;
    }

    .bg-accent {
        background-color: #3FA2F7 !important;
        color: #fff !important;
    }
</style>

<?php include "../views/layouts/footer.php"; ?>