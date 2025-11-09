<?php
require_once "../app/models/Peminjaman.php";
include "../views/layouts/header.php";

$data = Peminjaman::approved();
?>

<h2>Jadwal Peminjaman Laboratorium BA</h2>
<p>Berikut adalah daftar jadwal pemakaian laboratorium yang telah disetujui:</p>

<table class="table table-bordered table-striped">
    <thead>
        <tr>
            <th>Nama Peminjam</th>
            <th>Tanggal</th>
            <th>Waktu</th>
            <th>Keperluan</th>
        </tr>
    </thead>
    <tbody>
        <?php foreach ($data as $d): ?>
            <tr>
                <td><?= $d['nama_peminjam']; ?> (<?= $d['nim']; ?>)</td>
                <td>
                    <?= $d['tanggal_mulai']; ?>
                    <?php if ($d['tanggal_selesai']): ?>
                        → <?= $d['tanggal_selesai']; ?>
                    <?php endif; ?>
                </td>
                <td><?= $d['waktu_mulai']; ?> - <?= $d['waktu_selesai']; ?></td>
                <td><?= $d['keperluan']; ?></td>
            </tr>
        <?php endforeach; ?>
    </tbody>
</table>

<?php include "../views/layouts/footer.php"; ?>