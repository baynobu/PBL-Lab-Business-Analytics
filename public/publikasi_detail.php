<?php
require_once __DIR__ . '/../app/models/Publikasi.php';
require_once __DIR__ . '/../app/models/Dosen.php';
require_once __DIR__ . '/../app/models/Kategori.php';

$id = isset($_GET['id']) ? intval($_GET['id']) : 0;
$pub = Publikasi::find($id);
if (!$pub) {
    include __DIR__ . '/../views/layouts/header.php';
    echo '<main class="container py-5"><div class="alert alert-danger">Publikasi tidak ditemukan.</div></main>';
    include __DIR__ . '/../views/layouts/footer.php';
    exit;
}
$dosen = Publikasi::getDosen($id);
$kategori = Publikasi::getKategori($id);

include __DIR__ . '/../views/layouts/header.php';
?>
<main class="container py-5">
    <nav aria-label="breadcrumb">
        <ol class="breadcrumb mb-4">
            <li class="breadcrumb-item"><a href="publikasi.php">Publikasi</a></li>
            <li class="breadcrumb-item active" aria-current="page">Detail</li>
        </ol>
    </nav>
    <div class="row">
        <div class="col-lg-8 mx-auto">
            <div class="card shadow-sm mb-4">
                <div class="card-body">
                    <h2 class="fw-bold text-primary-custom mb-3"><?= htmlspecialchars($pub['judul']) ?></h2>
                    <div class="mb-2">
                        <?php foreach ($dosen as $ds): ?>
                            <a href="dosen.php?id=<?= $ds['id'] ?>" class="badge bg-info text-dark me-1 mb-1"> <?= htmlspecialchars($ds['nama']) ?> </a>
                        <?php endforeach; ?>
                    </div>
                    <div class="mb-2">
                        <?php if ($kategori): ?>
                            <?php foreach ($kategori as $kat): ?>
                                <span class="badge bg-secondary me-1 mb-1"> <?= htmlspecialchars($kat['nama']) ?> </span>
                            <?php endforeach; ?>
                        <?php else: ?>
                            <span class="badge bg-light text-muted">Tidak Berkategori</span>
                        <?php endif; ?>
                    </div>
                    <div class="mb-2 text-muted small">
                        <?= date('d F Y', strtotime($pub['tanggal'])) ?>
                    </div>
                    <div class="mb-3">
                        <?= nl2br(htmlspecialchars($pub['deskripsi'])) ?>
                    </div>
                    <?php if ($pub['file']): ?>
                        <a href="/lab-ba/public/uploads/publikasi/<?= htmlspecialchars($pub['file']) ?>" target="_blank" class="btn btn-outline-success me-2 mb-2">Download PDF</a>
                    <?php endif; ?>
                    <?php if ($pub['link']): ?>
                        <a href="<?= htmlspecialchars($pub['link']) ?>" target="_blank" class="btn btn-outline-primary mb-2">Lihat di SINTA</a>
                    <?php endif; ?>
                </div>
            </div>
        </div>
    </div>
</main>
<?php include __DIR__ . '/../views/layouts/footer.php'; ?>