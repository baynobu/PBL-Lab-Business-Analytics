<?php
require_once "../app/utils/session.php";
checkAdminLogin();
require_once "../app/models/Peminjaman.php";
require_once "../app/utils/log.php";

if (!isset($_GET['id'])) {
    header("Location: peminjaman_manage.php");
    exit;
}

$id = $_GET['id'];

if (Peminjaman::delete($id)) {
    logActivity("Menghapus peminjaman ID $id");
    $_SESSION['success'] = "Data peminjaman berhasil dihapus.";
} else {
    $_SESSION['error'] = "Gagal menghapus data peminjaman.";
}

header("Location: peminjaman_manage.php");
exit;
