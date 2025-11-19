<?php
require_once "../app/utils/session.php";
checkAdminLogin();
require_once "../app/models/Kategori.php";
require_once "../app/utils/log.php";

$kategori = Kategori::all();
include "../views/layouts/header.php";
?>

<section class="py-4 min-vh-100 bg-white">
    <div class="container">
        <div class="d-flex flex-wrap align-items-center justify-content-between mb-4 gap-2">
            <h3 class="fw-bold text-primary-custom mb-0">Manajemen Kategori</h3>
            <a href="kategori_tambah.php" class="btn btn-accent rounded-pill fw-semibold"><i class="bi bi-plus-square me-1"></i>Tambah Kategori</a>
        </div>
        <div class="card shadow-lg border-0 rounded-4">
            <div class="card-body p-4">
                <div class="table-responsive">
                    <table class="table table-hover align-middle mb-0">
                        <thead class="table-light">
                            <tr>
                                <th>Nama Kategori</th>
                                <th>Aksi</th>
                            </tr>
                        </thead>
                        <tbody>
                            <?php foreach ($kategori as $k): ?>
                                <tr>
                                    <td><?= htmlspecialchars($k['nama']) ?></td>
                                    <td>
                                        <a href="kategori_edit.php?id=<?= $k['id']; ?>" class="btn btn-warning btn-sm rounded-pill px-3"><i class="bi bi-pencil-square"></i> Edit</a>
                                        <a href="kategori_hapus.php?id=<?= $k['id']; ?>" class="btn btn-danger btn-sm rounded-pill px-3 ms-1" onclick="return confirm('Hapus kategori ini?')"><i class="bi bi-trash"></i> Hapus</a>
                                    </td>
                                </tr>
                            <?php endforeach; ?>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</section>

<?php include "../views/layouts/footer.php"; ?>
