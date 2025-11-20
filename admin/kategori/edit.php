<?php
require_once "../../app/utils/session.php";
checkAdminLogin();
require_once "../../app/models/Kategori.php";
require_once "../../app/utils/log.php";

$id = $_GET['id'];
$k = Kategori::find($id);
if (!$k) {
    header("Location: manage.php");
    exit;
}
$message = "";
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $nama = $_POST['nama'];
    Kategori::update($id, $nama);
    logActivity("Mengedit kategori: $nama");
    $k = Kategori::find($id);
    $message = "<div class='alert alert-success'>Kategori berhasil diupdate.</div>";
    // header("Location: manage.php");
    // exit;
}
include "../../views/layouts/header.php";
?>
<section class="py-4 min-vh-100 bg-white">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-lg-7 col-md-9">
                <div class="card shadow-lg border-0 rounded-4 p-4 p-md-5">
                    <h3 class="fw-bold text-primary-custom mb-3">Edit Kategori</h3>
                    <?= $message ?>
                    <form method="POST" autocomplete="off">
                        <div class="mb-3">
                            <label class="form-label fw-semibold">Nama Kategori</label>
                            <input type="text" name="nama" class="form-control rounded-pill" value="<?= htmlspecialchars($k['nama']) ?>" required>
                        </div>
                        <div class="d-flex justify-content-end gap-2 mt-4">
                            <a href="manage.php" class="btn btn-secondary">Kembali</a>
                            <button type="submit" class="btn btn-success">Update</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</section>