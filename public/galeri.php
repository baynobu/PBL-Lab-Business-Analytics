<?php include "../views/layouts/header.php"; ?>
<?php require_once "../app/models/Galeri.php"; ?>

<section class="bg-white py-5 min-vh-100">
    <div class="container">
        <div class="text-center mb-5">
            <h2 class="fw-bold mb-1 text-primary-custom">Galeri Kegiatan Laboratorium</h2>
            <div class="text-muted">Dokumentasi aktivitas, event, dan suasana Laboratorium Business Analytics</div>
        </div>
        <div class="row g-4">
            <?php $galeriList = Galeri::all();
            foreach ($galeriList as $g): ?>
                <div class="col-md-6 col-lg-4">
                    <div class="card h-100 shadow-sm border-0 galeri-card" style="cursor:pointer;" data-bs-toggle="modal" data-bs-target="#galeriModal<?= $g['id'] ?>">
                        <img src="/lab-ba/public/uploads/galeri/<?= htmlspecialchars($g['gambar']) ?>" class="card-img-top" alt="<?= htmlspecialchars($g['judul']) ?>" style="object-fit:cover;max-height:240px;">
                        <div class="card-body">
                            <h5 class="card-title mb-1 text-primary-custom"><?= htmlspecialchars($g['judul']) ?></h5>
                            <div class="text-muted small mb-2">Tanggal: <?= htmlspecialchars($g['tanggal'] ?? '-') ?></div>
                            <div class="card-text text-truncate" style="max-width:100%;">
                                <?= nl2br(htmlspecialchars(mb_strimwidth($g['deskripsi'] ?? '', 0, 80, '...'))) ?>
                            </div>
                        </div>
                    </div>
                </div>
            <?php endforeach; ?>
        </div>

        <!-- Galeri Modals -->
        <?php foreach ($galeriList as $g): ?>
            <div class="modal fade" id="galeriModal<?= $g['id'] ?>" tabindex="-1" aria-labelledby="galeriModalLabel<?= $g['id'] ?>" aria-hidden="true">
                <div class="modal-dialog modal-lg modal-dialog-centered">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="galeriModalLabel<?= $g['id'] ?>"><?= htmlspecialchars($g['judul']) ?></h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <img src="/lab-ba/public/uploads/galeri/<?= htmlspecialchars($g['gambar']) ?>" class="img-fluid rounded mb-3" style="max-height:350px;object-fit:cover;">
                            <div><?= nl2br(htmlspecialchars($g['deskripsi'] ?? '')) ?></div>
                            <div class="mt-2 text-muted small">Tanggal: <?= htmlspecialchars($g['tanggal'] ?? '-') ?></div>
                        </div>
                    </div>
                </div>
            </div>
        <?php endforeach; ?>
    </div>
</section>

<style>
    .text-primary-custom {
        color: #0A2A43 !important;
    }

    .galeri-card:hover {
        box-shadow: 0 8px 32px 0 rgba(10, 42, 67, 0.13), 0 1.5px 8px 0 rgba(63, 162, 247, 0.10);
        transform: translateY(-2px) scale(1.01);
        transition: box-shadow .2s, transform .2s;
    }
</style>

<?php include "../views/layouts/footer.php"; ?>