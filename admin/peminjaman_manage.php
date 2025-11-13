<?php
require_once "../app/utils/session.php";
checkAdminLogin();
require_once "../app/models/Peminjaman.php";
$data = Peminjaman::all();
include "../views/layouts/header.php";
?>

<section class="py-4 min-vh-100 bg-white">
    <div class="container">
        <div class="d-flex flex-wrap align-items-center justify-content-between mb-4 gap-2">
            <h3 class="fw-bold text-primary-custom mb-0">Manajemen Peminjaman</h3>
        </div>
        <div class="card shadow-lg border-0 rounded-4">
            <div class="card-body p-4">
                <div class="table-responsive">
                    <table class="table table-hover align-middle mb-0">
                        <thead class="table-light">
                            <tr>
                                <th>Nama Peminjam</th>
                                <th>Tanggal</th>
                                <th>Waktu</th>
                                <th>Status</th>
                                <th>Aksi</th>
                            </tr>
                        </thead>
                        <tbody>
                            <?php foreach ($data as $p): ?>
                                <tr>
                                    <td><?= htmlspecialchars($p['nama_peminjam']) ?></td>
                                    <td><?= htmlspecialchars($p['tanggal_mulai']) ?><?php if ($p['tanggal_selesai']): ?> <span class="mx-1">→</span> <?= htmlspecialchars($p['tanggal_selesai']) ?><?php endif; ?></td>
                                    <td><?= htmlspecialchars($p['waktu_mulai']) ?> - <?= htmlspecialchars($p['waktu_selesai']) ?></td>
                                    <td>
                                        <?php
                                        $status = strtolower($p['status']);
                                        $badge = 'secondary';
                                        if ($status === 'disetujui' || $status === 'approved') $badge = 'success';
                                        elseif ($status === 'ditolak' || $status === 'rejected') $badge = 'danger';
                                        elseif ($status === 'menunggu' || $status === 'pending') $badge = 'warning';
                                        ?>
                                        <span class="badge bg-<?= $badge ?>"><?= htmlspecialchars($p['status']) ?></span>
                                    </td>
                                    <td>
                                        <a href="peminjaman_set.php?id=<?= $p['id']; ?>&status=disetujui" class="btn btn-success btn-sm rounded-pill px-3 me-1"><i class="bi bi-check2"></i> Setujui</a>
                                        <a href="peminjaman_set.php?id=<?= $p['id']; ?>&status=ditolak" class="btn btn-danger btn-sm rounded-pill px-3 me-1"><i class="bi bi-x-lg"></i> Tolak</a>
                                        <a href="peminjaman_hapus.php?id=<?= $p['id']; ?>" class="btn btn-danger btn-sm rounded-pill px-3 ms-1" onclick="return confirm('Hapus data ini?')"><i class="bi bi-trash"></i> Hapus</a>
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