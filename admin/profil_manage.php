<?php
require_once "../app/utils/session.php";
checkAdminLogin();
require_once "../app/models/Profil.php";
require_once "../app/utils/log.php";

$profil = Profil::all();

include "../views/layouts/header.php";
?>

<h3>Manajemen Profil Lab</h3>

<a href="profil_tambah.php" class="btn btn-primary mb-3">+ Tambah Konten Profil</a>

<table class="table table-bordered">
    <thead>
        <tr>
            <th>Kategori</th>
            <th>Judul</th>
            <th>Konten</th>
            <th>Aksi</th>
        </tr>
    </thead>
    <tbody>
        <?php foreach ($profil as $p): ?>
            <tr>
                <td><?= $p['kategori']; ?></td>
                <td><?= $p['judul']; ?></td>
                <td style="max-width: 400px;"><?= nl2br(substr($p['isi'], 0, 150)); ?>...</td>
                <td>
                    <a href="profil_edit.php?id=<?= $p['id']; ?>" class="btn btn-warning btn-sm">Edit</a>
                    <a href="profil_hapus.php?id=<?= $p['id']; ?>" class="btn btn-danger btn-sm" onclick="return confirm('Hapus konten ini?')">Hapus</a>
                </td>
            </tr>
        <?php endforeach; ?>
    </tbody>
</table>

<?php include "../views/layouts/footer.php"; ?>