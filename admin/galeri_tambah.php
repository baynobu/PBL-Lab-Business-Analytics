<?php
require_once "../app/utils/session.php";
checkAdminLogin();
require_once "../app/models/Galeri.php";
require_once "../app/utils/log.php";

$message = "";
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $judul = $_POST['judul'];
    $deskripsi = $_POST['deskripsi'];
    $tanggal = $_POST['tanggal'];

    $gambar = $_FILES['gambar']['name'];
    $tmp = $_FILES['gambar']['tmp_name'];

    move_uploaded_file($tmp, "../public/uploads/galeri/" . $gambar);

    Galeri::create($judul, $deskripsi, $gambar, $tanggal);
    logActivity("Menambah foto galeri: $judul");

    $message = "<div class='alert alert-success'>Foto galeri berhasil ditambahkan.</div>";
    // header("Location: galeri_manage.php");
    // exit;
}

include "../views/layouts/header.php";
?>
<section class="py-4 min-vh-100 bg-white">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-lg-7 col-md-9">
                <div class="card shadow-lg border-0 rounded-4 p-4 p-md-5">
                    <h3 class="fw-bold text-primary-custom mb-3">Tambah Foto Galeri</h3>
                    <?= $message ?>
                    <form method="POST" enctype="multipart/form-data" autocomplete="off">
                        <div class="mb-3">
                            <label class="form-label fw-semibold">Judul</label>
                            <input type="text" name="judul" class="form-control rounded-pill" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label fw-semibold">Deskripsi</label>
                            <textarea name="deskripsi" class="form-control" rows="4"></textarea>
                        </div>
                        <div class="mb-3">
                            <label class="form-label fw-semibold">Tanggal Kegiatan</label>
                            <input type="date" name="tanggal" class="form-control rounded-pill" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label fw-semibold">Foto</label>
                            <input type="file" name="gambar" class="form-control rounded-pill" required>
                        </div>
                        <div class="d-flex justify-content-end gap-2 mt-4">
                            <a href="galeri_manage.php" class="btn btn-secondary">Kembali</a>
                            <button type="submit" class="btn btn-success">Simpan</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</section>