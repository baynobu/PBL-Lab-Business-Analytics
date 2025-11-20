<?php
require_once "../../app/utils/session.php";
checkAdminLogin();
require_once "../../app/models/Galeri.php";
$data = Galeri::all();
include "../../views/layouts/header.php";
?>

<section class="py-4 min-vh-100 bg-white">
    <div class="container">
        <div class="d-flex flex-wrap align-items-center justify-content-between mb-4 gap-2">
            <h3 class="fw-bold text-primary-custom mb-0">Manajemen Galeri</h3>
            <a href="tambah.php" class="btn btn-accent rounded-pill fw-semibold"><i class="bi bi-plus-square me-1"></i>Tambah Galeri</a>
        </div>
        <div class="card shadow-lg border-0 rounded-4">
            <div class="card-body p-4">
                <div class="table-responsive">
                    <table class="table table-hover align-middle mb-0">
                        <thead class="table-light">
                            <tr>
                                <th>Judul</th>
                                <th>Tanggal</th>
                                <th>Aksi</th>
                            </tr>
                        </thead>
                        <tbody>
                            <?php foreach ($data as $g): ?>
                                <tr>
                                    <td><?= htmlspecialchars($g['judul']) ?></td>
                                    <td><?= htmlspecialchars($g['tanggal']) ?></td>
                                    <td>
                                        <a href="edit.php?id=<?= $g['id']; ?>" class="btn btn-warning btn-sm rounded-pill px-3"><i class="bi bi-pencil-square"></i> Edit</a>
                                        <a href="hapus.php?id=<?= $g['id']; ?>" class="btn btn-danger btn-sm rounded-pill px-3 ms-1" onclick="return confirm('Hapus galeri ini?')"><i class="bi bi-trash"></i> Hapus</a>
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

<style>
    .text-primary-custom {
        color: #0A2A43 !important;
    }

    .btn-accent {
        background-color: #3FA2F7;
        color: #fff;
        border: none;
    }

    .btn-accent:hover,
    .btn-accent:focus {
        background: #2196f3;
        color: #fff;
    }
</style>