<?php
require_once "../app/utils/session.php";
checkAdminLogin();
require_once "../app/models/Admin.php";
require_once "../app/utils/log.php";

$id = $_GET['id'];
$a = Admin::find($id);

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    Admin::update($id, $_POST['username'], $_POST['nama']);
    if (!empty($_POST['password'])) {
        Admin::updatePassword($id, $_POST['password']);
        logActivity("Mengubah password admin: {$a['username']}");
    }
    logActivity("Mengubah data admin: {$a['username']}");
    header("Location: admin_manage.php");
    exit;
}

include "../views/layouts/header.php";
?>

<h3>Edit Admin</h3>

<form method="POST">
    <div class="mb-3">
        <label>Nama Lengkap</label>
        <input type="text" name="nama" value="<?= $a['nama_lengkap']; ?>" class="form-control" required>
    </div>

    <div class="mb-3">
        <label>Username</label>
        <input type="text" name="username" value="<?= $a['username']; ?>" class="form-control" required>
    </div>

    <div class="mb-3">
        <label>Ubah Password (opsional)</label>
        <input type="password" name="password" class="form-control">
    </div>

    <button type="submit" class="btn btn-success">Update</button>
</form>

<?php include "../views/layouts/footer.php"; ?>