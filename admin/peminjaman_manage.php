<?php
require_once "../app/utils/session.php";
checkAdminLogin();
require_once "../app/models/Peminjaman.php";
require_once "../app/utils/log.php";

$data = Peminjaman::all();

include "../views/layouts/header.php";
?>

<h3>Manajemen Peminjaman Lab</h3>

<table class="table table-bordered">
    <thead>
        <tr>
            <th>Nama</th>
            <th>NIM</th>
            <th>Tanggal</th>
            <th>Waktu</th>
            <th>Keperluan</th>
            <th>Status</th>
            <th>Aksi</th>
        </tr>
    </thead>
    <tbody>
        <?php foreach ($data as $p): ?>
            <tr>
                <td><?= $p['nama_peminjam']; ?></td>
                <td><?= $p['nim']; ?></td>
                <td><?= $p['tanggal_mulai']; ?> → <?= $p['tanggal_selesai'] ?: '-'; ?></td>
                <td><?= $p['waktu_mulai']; ?> - <?= $p['waktu_selesai']; ?></td>
                <td><?= $p['keperluan']; ?></td>
                <td><b><?= $p['status']; ?></b></td>
                <td>
                    <a class="btn btn-success btn-sm" href="peminjaman_set.php?id=<?= $p['id']; ?>&status=disetujui">ACC</a>
                    <a class="btn btn-danger btn-sm" href="peminjaman_set.php?id=<?= $p['id']; ?>&status=ditolak">Tolak</a>
                </td>
            </tr>
        <?php endforeach; ?>
    </tbody>
</table>

<?php include "../views/layouts/footer.php"; ?>