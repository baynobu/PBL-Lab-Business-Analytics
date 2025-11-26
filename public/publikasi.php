<?php
require_once __DIR__ . '/../app/models/Publikasi.php';
require_once __DIR__ . '/../app/models/Dosen.php';
require_once __DIR__ . '/../app/models/Kategori.php';

// Get filters
$page = max(1, intval($_GET['page'] ?? 1));
$limit = 12;
$offset = ($page - 1) * $limit;
$search = trim($_GET['search'] ?? '');
$dosen_id = isset($_GET['dosen']) ? intval($_GET['dosen']) : null;
$kategori_id = isset($_GET['kategori']) ? intval($_GET['kategori']) : null;

// Get data
$publikasi = Publikasi::all($limit, $offset, $search, $dosen_id, $kategori_id);
$total = Publikasi::count($search, $dosen_id, $kategori_id);
$dosenList = Dosen::all();
$kategoriList = Kategori::all();
$totalPages = ceil($total / $limit);

include __DIR__ . '/../views/layouts/header.php';
?>
<main class="container py-5">
    <h2 class="fw-bold mb-4 text-primary-custom">Daftar Publikasi</h2>
    <form class="row g-2 mb-4" method="GET">
        <div class="col-md-4">
            <input type="text" name="search" class="form-control" placeholder="Cari judul publikasi..." value="<?= htmlspecialchars($search) ?>">
        </div>
        <div class="col-md-3">
            <select name="kategori" class="form-select">
                <option value="">Semua Kategori</option>
                <?php foreach ($kategoriList as $kat): ?>
                    <option value="<?= $kat['id'] ?>" <?= $kategori_id == $kat['id'] ? 'selected' : '' ?>><?= htmlspecialchars($kat['nama']) ?></option>
                <?php endforeach; ?>
            </select>
        </div>
        <div class="col-md-3">
            <select name="dosen" class="form-select">
                <option value="">Semua Dosen</option>
                <?php foreach ($dosenList as $d): ?>
                    <option value="<?= $d['id'] ?>" <?= $dosen_id == $d['id'] ? 'selected' : '' ?>><?= htmlspecialchars($d['nama']) ?></option>
                <?php endforeach; ?>
            </select>
        </div>
        <div class="col-md-2">
            <button type="submit" class="btn btn-primary w-100">Filter</button>
        </div>
    </form>
    <div class="row row-cols-1 row-cols-md-2 row-cols-lg-4 g-4">
        <?php foreach ($publikasi as $pub): ?>
            <div class="col">
                <div class="card h-100 shadow-sm">
                    <div class="card-body d-flex flex-column">
                        <h5 class="card-title mb-2 fw-bold">
                            <a href="publikasi_detail.php?id=<?= $pub['id'] ?>" class="text-decoration-none text-primary-custom"> <?= htmlspecialchars($pub['judul']) ?> </a>
                        </h5>
                        <div class="mb-2">
                            <?php $dosen = Publikasi::getDosen($pub['id']); ?>
                            <?php foreach ($dosen as $ds): ?>
                                <a href="dosen.php?id=<?= $ds['id'] ?>" class="badge bg-info text-dark me-1 mb-1"> <?= htmlspecialchars($ds['nama']) ?> </a>
                            <?php endforeach; ?>
                        </div>
                        <div class="mb-2">
                            <?php $kategori = Publikasi::getKategori($pub['id']); ?>
                            <?php if ($kategori): ?>
                                <?php foreach ($kategori as $kat): ?>
                                    <a href="publikasi.php?kategori=<?= $kat['id'] ?>" class="badge bg-secondary me-1 mb-1"> <?= htmlspecialchars($kat['nama']) ?> </a>
                                <?php endforeach; ?>
                            <?php else: ?>
                                <span class="badge bg-light text-muted">Tidak Berkategori</span>
                            <?php endif; ?>
                        </div>
                        <div class="mb-2 text-muted small">
                            <?= date('Y', strtotime($pub['tanggal'])) ?>
                        </div>
                        <div class="mt-auto">
                            <a href="publikasi_detail.php?id=<?= $pub['id'] ?>" class="btn btn-outline-primary w-100">Lihat Detail</a>
                        </div>
                    </div>
                </div>
            </div>
        <?php endforeach; ?>
    </div>
    <?php if ($totalPages > 1): ?>
        <nav class="mt-4">
            <ul class="pagination justify-content-center">
                <?php for ($p = 1; $p <= $totalPages; $p++): ?>
                    <li class="page-item <?= $p == $page ? 'active' : '' ?>">
                        <a class="page-link" href="?<?= http_build_query(array_merge($_GET, ['page' => $p])) ?>"> <?= $p ?> </a>
                    </li>
                <?php endfor; ?>
            </ul>
        </nav>
    <?php endif; ?>
</main>
<?php include __DIR__ . '/../views/layouts/footer.php'; ?>