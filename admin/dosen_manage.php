<?php
require_once "../app/utils/session.php";
checkAdminLogin();
require_once "../app/models/Dosen.php";
require_once "../app/utils/log.php";

$dosen = Dosen::all();

include "../views/layouts/header.php";
?>

<h3>Manajemen Dosen</h3>

<a href="dosen_tambah.php" class="btn btn-primary mb-3">+ Tambah Dosen</a>

<table class="table table-bordered">
    <thead>
        <tr>
            <th>No</th>
            <th>Nama</th>
            <th>Keahlian</th>
            <th>Foto</th>
            <th>Aksi</th>
        </tr>
    </thead>
    <tbody>
        <?php $no = 1;
        foreach ($dosen as $d): ?>
            <tr>
                <td><?= $no++; ?></td>
                <td><?= $d['nama']; ?></td>
                <td><?= $d['keahlian']; ?></td>
                <td><img src="/lab-ba/public/uploads/dosen/<?= $d['foto']; ?>" width="70"></td>
                <td>
                    <a href="dosen_edit.php?id=<?= $d['id']; ?>" class="btn btn-warning btn-sm">Edit</a>
                    <a href="dosen_hapus.php?id=<?= $d['id']; ?>" class="btn btn-danger btn-sm" onclick="return confirm('Yakin hapus?')">Hapus</a>
                </td>
            </tr>
        <?php endforeach; ?>
    </tbody>
</table>

<?php include "../views/layouts/footer.php"; ?>