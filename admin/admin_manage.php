<?php
require_once "../app/utils/session.php";
checkAdminLogin();
require_once "../app/models/Admin.php";
require_once "../app/utils/log.php";

$data = Admin::all();
include "../views/layouts/header.php";
?>

<h3>Manajemen Admin</h3>

<a href="admin_tambah.php" class="btn btn-primary mb-3">+ Tambah Admin</a>

<table class="table table-bordered">
    <thead>
        <tr>
            <th>Nama</th>
            <th>Username</th>
            <th>Aksi</th>
        </tr>
    </thead>
    <tbody>
        <?php foreach ($data as $a): ?>
            <tr>
                <td><?= $a['nama_lengkap']; ?></td>
                <td><?= $a['username']; ?></td>
                <td>
                    <a href="admin_edit.php?id=<?= $a['id']; ?>" class="btn btn-warning btn-sm">Edit</a>
                    <?php if ($a['id'] != $_SESSION['admin_id']): ?>
                        <a href="admin_hapus.php?id=<?= $a['id']; ?>" class="btn btn-danger btn-sm" onclick="return confirm('Hapus admin ini?')">Hapus</a>
                    <?php endif; ?>
                </td>
            </tr>
        <?php endforeach; ?>
    </tbody>
</table>

<?php include "../views/layouts/footer.php"; ?>