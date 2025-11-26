<?php
require_once __DIR__ . '/../app/models/Berita.php';
$page = max(1, intval($_GET['page'] ?? 1));
$limit = 6;
$offset = ($page - 1) * $limit;
$search = trim($_GET['search'] ?? '');
$berita = Berita::all($limit, $offset, $search);
$total = Berita::count($search);
$totalPages = ceil($total / $limit);

include __DIR__ . '/../views/layouts/header.php';
?>
<main class="container py-5">
    <h2 class="fw-bold mb-4 text-primary-custom">Berita Terbaru</h2>
    <form class="row g-2 mb-4" method="GET">
        <div class="col-md-8">
            <input type="text" name="search" class="form-control" placeholder="Cari berita..." value="<?= htmlspecialchars($search) ?>">
        </div>
        <div class="col-md-4">
            <button type="submit" class="btn btn-primary w-100">Cari</button>
        </div>
    </form>
    <?php if (count($berita) === 0): ?>
        <div class="alert alert-info">Belum ada berita.</div>
    <?php else: ?>
        <div class="row row-cols-1 row-cols-md-2 row-cols-lg-3 g-4">
            <?php foreach ($berita as $b): ?>
                <div class="col">
                    <div class="card h-100 shadow-sm">
                        <?php if ($b['gambar']): ?>
                            <img src="/lab-ba/public/uploads/berita/<?= htmlspecialchars($b['gambar']) ?>" class="card-img-top" alt="Thumbnail Berita" style="object-fit:cover;max-height:180px;">
                        <?php endif; ?>
                        <div class="card-body d-flex flex-column">
                            <div class="mb-2 text-muted small"> <?= date('d M Y', strtotime($b['tanggal'])) ?> </div>
                            <h5 class="card-title mb-2 fw-bold">
                                <a href="berita_detail.php?id=<?= $b['id'] ?>" class="text-decoration-none text-primary-custom"> <?= htmlspecialchars($b['judul']) ?> </a>
                            </h5>
                            <div class="mb-2">
                                <?= htmlspecialchars(mb_strimwidth(strip_tags($b['isi']), 0, 160, '...')) ?>
                            </div>
                            <div class="mt-auto">
                                <a href="berita_detail.php?id=<?= $b['id'] ?>" class="btn btn-outline-primary w-100">Read more</a>
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
    <?php endif; ?>
</main>
<?php include __DIR__ . '/../views/layouts/footer.php'; ?>