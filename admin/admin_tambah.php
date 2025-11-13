<?php
require_once "../app/utils/session.php";
checkAdminLogin();
require_once "../app/models/Admin.php";
require_once "../app/utils/log.php";

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    Admin::create($_POST['username'], $_POST['password'], $_POST['nama']);
    logActivity("Menambah admin baru: {$_POST['username']}");
    header("Location: admin_manage.php");
    exit;
}

include "../views/layouts/header.php";
?>

<h3>Tambah Admin</h3>

<form method="POST">
    <div class="mb-3">
        <label>Nama Lengkap</label>
        <input type="text" name="nama" class="form-control" required>
    </div>

    <div class="mb-3">
        <label>Username</label>
        <input type="text" name="username" class="form-control" required>
    </div>

    <div class="mb-3">
        <label>Password</label>
        <input type="password" name="password" class="form-control" required>
    </div>

    <button type="submit" class="btn btn-success">Simpan</button>
</form>

<?php include "../views/layouts/footer.php"; ?>