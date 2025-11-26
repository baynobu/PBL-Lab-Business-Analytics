<?php
require_once "../../app/utils/session.php";
checkAdminLogin();
require_once "../../app/models/Berita.php";
require_once "../../app/utils/log.php";
$berita = Berita::all(100, 0);
include "../../views/layouts/header.php";
?>
<section class="py-4 min-vh-100 bg-white">
    <div class="container">
        <div class="d-flex flex-wrap align-items-center justify-content-between mb-4 gap-2">
            <h3 class="fw-bold text-primary-custom mb-0">Manajemen Berita</h3>
            <a href="tambah.php" class="btn btn-accent rounded-pill fw-semibold"><i class="bi bi-plus-square me-1"></i>Tambah Berita</a>
        </div>
        <div class="card shadow-lg border-0 rounded-4">
            <div class="card-body p-4">
                <div class="table-responsive">
                    <table class="table table-hover align-middle mb-0">
                        <thead class="table-light">
                            <tr>
                                <th>Judul</th>
                                <th>Tanggal</th>
                                <th>Penulis</th>
                                <th>Gambar</th>
                                <th>Aksi</th>
                            </tr>
                        </thead>
                        <tbody>
                            <?php foreach ($berita as $b): ?>
                                <tr>
                                    <td><?= htmlspecialchars($b['judul']) ?></td>
                                    <td><?= htmlspecialchars($b['tanggal']) ?></td>
                                    <td><?= htmlspecialchars($b['penulis']) ?></td>
                                    <td>
                                        <?php if ($b['gambar']): ?>
                                            <img src="/lab-ba/public/uploads/berita/<?= htmlspecialchars($b['gambar']) ?>" alt="Gambar" style="height:40px;max-width:60px;object-fit:cover;">
                                        <?php endif; ?>
                                    </td>
                                    <td>
                                        <a href="edit.php?id=<?= $b['id']; ?>" class="btn btn-warning btn-sm rounded-pill px-3"><i class="bi bi-pencil-square"></i> Edit</a>
                                        <a href="hapus.php?id=<?= $b['id']; ?>" class="btn btn-danger btn-sm rounded-pill px-3 ms-1" onclick="return confirm('Hapus berita ini?')"><i class="bi bi-trash"></i> Hapus</a>
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