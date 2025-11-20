<?php
require_once "../../app/utils/session.php";
checkAdminLogin();
require_once "../../app/models/Publikasi.php";
require_once "../../app/models/Kategori.php";
require_once "../../app/utils/log.php";

$id = $_GET['id'];
$p = Publikasi::find($id);
if (!$p) {
    header("Location: manage.php");
    exit;
}
$message = "";
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $judul = $_POST['judul'];
    $penulis = $_POST['penulis'];
    $tanggal = $_POST['tanggal'];
    $deskripsi = $_POST['deskripsi'];
    $link = $_POST['link'];
    $kategori_id = $_POST['kategori_id'];
    $file = $p['file'];
    if (!empty($_FILES['file']['name'])) {
        $file = time() . '_' . basename($_FILES['file']['name']);
        move_uploaded_file($_FILES['file']['tmp_name'], "../../public/uploads/publikasi/" . $file);
    }
    Publikasi::update($id, $judul, $penulis, $tanggal, $deskripsi, $file, $link, $kategori_id);
    logActivity("Mengedit publikasi: $judul");
    $p = Publikasi::find($id);
    $message = "<div class='alert alert-success'>Data publikasi berhasil diupdate.</div>";
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
                    <h3 class="fw-bold text-primary-custom mb-3">Edit Publikasi</h3>
                    <?= $message ?>
                    <form method="POST" enctype="multipart/form-data" autocomplete="off">
                        <div class="mb-3">
                            <label class="form-label fw-semibold">Judul</label>
                            <input type="text" name="judul" class="form-control rounded-pill" value="<?= htmlspecialchars($p['judul']) ?>" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label fw-semibold">Penulis</label>
                            <input type="text" name="penulis" class="form-control rounded-pill" value="<?= htmlspecialchars($p['penulis']) ?>">
                        </div>
                        <div class="mb-3">
                            <label class="form-label fw-semibold">Tanggal</label>
                            <input type="date" name="tanggal" class="form-control rounded-pill" value="<?= htmlspecialchars($p['tanggal']) ?>">
                        </div>
                        <div class="mb-3">
                            <label class="form-label fw-semibold">Kategori</label>
                            <select name="kategori_id" class="form-control rounded-pill" required>
                                <option value="">-- Pilih Kategori --</option>
                                <?php foreach (Kategori::all() as $k): ?>
                                    <option value="<?= $k['id'] ?>" <?= $p['kategori_id'] == $k['id'] ? 'selected' : '' ?>><?= htmlspecialchars($k['nama']) ?></option>
                                <?php endforeach; ?>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label class="form-label fw-semibold">Deskripsi</label>
                            <textarea name="deskripsi" class="form-control" rows="4"><?= htmlspecialchars($p['deskripsi']) ?></textarea>
                        </div>
                        <div class="mb-3">
                            <label class="form-label fw-semibold">File (Opsional)</label>
                            <input type="file" name="file" class="form-control rounded-pill">
                        </div>
                        <div class="mb-3">
                            <label class="form-label fw-semibold">Link (Opsional)</label>
                            <input type="url" name="link" class="form-control rounded-pill" value="<?= htmlspecialchars($p['link']) ?>">
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