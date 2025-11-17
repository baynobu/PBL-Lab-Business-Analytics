<?php
require_once "../app/utils/session.php";
checkAdminLogin();
require_once "../app/models/Admin.php";
require_once "../app/utils/log.php";

$idToDelete = $_GET['id'];
if ($idToDelete == $_SESSION['admin_id']) {
    // Tidak boleh hapus diri sendiri
    $_SESSION['error'] = "Anda tidak dapat menghapus akun admin yang sedang login.";
    header("Location: admin_manage.php");
    exit;
}
$a = Admin::find($idToDelete);
Admin::delete($idToDelete);
logActivity("Menghapus admin: {$a['username']}");
header("Location: admin_manage.php");
exit;
