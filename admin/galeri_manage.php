<?php
require_once "../app/utils/session.php";
checkAdminLogin();
require_once "../app/models/Galeri.php";
require_once "../app/utils/log.php";

$data = Galeri::all();
include "../views/layouts/header.php";
?>

<h3>Manajemen Galeri</h3>

<a href="galeri_tambah.php" class="btn btn-primary mb-3">+ Tambah Foto Kegiatan</a>

<table class="table table-bordered">
    <thead>
        <tr>
            <th>Judul</th>
            <th>Foto</th>
            <th>Tanggal</th>
            <th>Aksi</th>
        </tr>
    </thead>
    <tbody>
        <?php foreach ($data as $g): ?>
            <tr>
                <td><?= $g['judul']; ?></td>
                <td><img src="/lab-ba/public/uploads/galeri/<?= $g['gambar']; ?>" width="120"></td>
                <td><?= $g['tanggal']; ?></td>
                <td>
                    <a href="galeri_edit.php?id=<?= $g['id']; ?>" class="btn btn-warning btn-sm">Edit</a>
                    <a href="galeri_hapus.php?id=<?= $g['id']; ?>" class="btn btn-danger btn-sm" onclick="return confirm('Hapus data ini?')">Hapus</a>
                </td>
            </tr>
        <?php endforeach; ?>
    </tbody>
</table>

<?php include "../views/layouts/footer.php"; ?>