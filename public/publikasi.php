<?php
require_once "../app/models/Publikasi.php";
include "../views/layouts/header.php";
$publikasiList = Publikasi::all();
?>
<section class="bg-white py-5 min-vh-100">
    <div class="container">
        <h2 class="section-title mb-4">Daftar Publikasi</h2>
        <?php if (count($publikasiList) === 0): ?>
            <div class="alert alert-info">Belum ada publikasi.</div>
        <?php else: ?>
            <div class="row g-4">
                <?php foreach ($publikasiList as $pub): ?>
                    <div class="col-md-6 col-lg-4">
                        <div class="card h-100 shadow-sm border-0">
                            <div class="card-body d-flex flex-column">
                                <h5 class="card-title text-primary-custom mb-2"><?= htmlspecialchars($pub['judul']) ?></h5>
                                <div class="mb-1 text-muted small">Oleh: <?= htmlspecialchars($pub['penulis']) ?></div>
                                <div class="mb-2 text-muted small">Tanggal: <?= htmlspecialchars($pub['tanggal']) ?></div>
                                <div class="mb-2" style="min-height:48px;">
                                    <?= nl2br(htmlspecialchars(mb_strimwidth($pub['deskripsi'], 0, 120, '...'))) ?>
                                </div>
                                <?php if ($pub['file']): ?>
                                    <a href="/lab-ba/public/uploads/publikasi/<?= htmlspecialchars($pub['file']) ?>" target="_blank" class="btn btn-outline-accent btn-sm mb-1">Download File</a>
                                <?php endif; ?>
                                <?php if ($pub['link']): ?>
                                    <a href="<?= htmlspecialchars($pub['link']) ?>" target="_blank" class="btn btn-outline-accent btn-sm mb-1">Lihat Link</a>
                                <?php endif; ?>
                            </div>
                        </div>
                    </div>
                <?php endforeach; ?>
            </div>
        <?php endif; ?>
        <div class="d-grid mt-4">
            <a href="index.php" class="btn btn-secondary btn-lg rounded-pill fw-bold shadow-sm">Kembali</a>
        </div>
    </div>
</section>
<?php include "../views/layouts/footer.php"; ?>