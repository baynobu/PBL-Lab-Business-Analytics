<?php
require_once "../app/utils/session.php";
checkAdminLogin();
require_once "../app/models/Dosen.php";
$data = Dosen::all();
include "../views/layouts/header.php";
?>

<section class="py-4 min-vh-100 bg-white">
    <div class="container">
        <div class="d-flex flex-wrap align-items-center justify-content-between mb-4 gap-2">
            <h3 class="fw-bold text-primary-custom mb-0">Manajemen Dosen</h3>
            <a href="dosen_tambah.php" class="btn btn-accent rounded-pill fw-semibold"><i class="bi bi-person-plus me-1"></i>Tambah Dosen</a>
        </div>
        <div class="card shadow-lg border-0 rounded-4">
            <div class="card-body p-4">
                <div class="table-responsive">
                    <table class="table table-hover align-middle mb-0">
                        <thead class="table-light">
                            <tr>
                                <th>Nama</th>
                                <th>Keahlian</th>
                                <th>Aksi</th>
                            </tr>
                        </thead>
                        <tbody>
                            <?php foreach ($data as $d): ?>
                                <tr>
                                    <td><?= htmlspecialchars($d['nama'] ?? '') ?></td>
                                    <td><?= isset($d['keahlian']) ? htmlspecialchars($d['keahlian']) : '<span class="text-muted">-</span>' ?></td>
                                    <td>
                                        <a href="dosen_edit.php?id=<?= $d['id']; ?>" class="btn btn-warning btn-sm rounded-pill px-3"><i class="bi bi-pencil-square"></i> Edit</a>
                                        <a href="dosen_hapus.php?id=<?= $d['id']; ?>" class="btn btn-danger btn-sm rounded-pill px-3 ms-1" onclick="return confirm('Hapus dosen ini?')"><i class="bi bi-trash"></i> Hapus</a>
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