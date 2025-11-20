<?php
require_once "../../app/utils/session.php";
checkAdminLogin();
require_once "../../app/models/Publikasi.php";
require_once "../../app/models/Kategori.php";
require_once "../../app/utils/log.php";

$message = "";
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $judul = $_POST['judul'];
    $penulis = $_POST['penulis'];
    $tanggal = $_POST['tanggal'];
    $deskripsi = $_POST['deskripsi'];
    $link = $_POST['link'];
    $kategori_id = $_POST['kategori_id'];
    $file = '';
    if (!empty($_FILES['file']['name'])) {
        $file = time() . '_' . basename($_FILES['file']['name']);
        move_uploaded_file($_FILES['file']['tmp_name'], "../../public/uploads/publikasi/" . $file);
    }
    Publikasi::create($judul, $penulis, $tanggal, $deskripsi, $file, $link, $kategori_id);
    logActivity("Menambah publikasi: $judul");
    $message = "<div class='alert alert-success'>Publikasi berhasil ditambahkan.</div>";
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
                    <h3 class="fw-bold text-primary-custom mb-3">Tambah Publikasi</h3>
                    <?= $message ?>
                    <form method="POST" enctype="multipart/form-data" autocomplete="off">
                        <div class="mb-3">
                            <label class="form-label fw-semibold">Judul</label>
                            <input type="text" name="judul" class="form-control rounded-pill" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label fw-semibold">Penulis</label>
                            <input type="text" name="penulis" class="form-control rounded-pill">
                        </div>
                        <div class="mb-3">
                            <label class="form-label fw-semibold">Tanggal</label>
                            <input type="date" name="tanggal" class="form-control rounded-pill">
                        </div>
                        <div class="mb-3">
                            <label class="form-label fw-semibold">Kategori</label>
                            <select name="kategori_id" class="form-control rounded-pill" required>
                                <option value="">-- Pilih Kategori --</option>
                                <?php foreach (Kategori::all() as $k): ?>
                                    <option value="<?= $k['id'] ?>"><?= htmlspecialchars($k['nama']) ?></option>
                                <?php endforeach; ?>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label class="form-label fw-semibold">Deskripsi</label>
                            <textarea name="deskripsi" class="form-control" rows="4"></textarea>
                        </div>
                        <div class="mb-3">
                            <label class="form-label fw-semibold">File (Opsional)</label>
                            <input type="file" name="file" class="form-control rounded-pill">
                        </div>
                        <div class="mb-3">
                            <label class="form-label fw-semibold">Link (Opsional)</label>
                            <input type="url" name="link" class="form-control rounded-pill">
                        </div>
                        <div class="d-flex justify-content-end gap-2 mt-4">
                            <a href="manage.php" class="btn btn-secondary">Kembali</a>
                            <button type="submit" class="btn btn-success">Simpan</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</section>