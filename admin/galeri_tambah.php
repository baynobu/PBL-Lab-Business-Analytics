<?php
require_once "../app/utils/session.php";
checkAdminLogin();
require_once "../app/models/Galeri.php";
require_once "../app/utils/log.php";

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $judul = $_POST['judul'];
    $deskripsi = $_POST['deskripsi'];
    $tanggal = $_POST['tanggal'];

    $gambar = $_FILES['gambar']['name'];
    $tmp = $_FILES['gambar']['tmp_name'];

    move_uploaded_file($tmp, "../public/uploads/galeri/" . $gambar);

    Galeri::create($judul, $deskripsi, $gambar, $tanggal);
    logActivity("Menambah foto galeri: $judul");

    header("Location: galeri_manage.php");
    exit;
}

include "../views/layouts/header.php";
?>

<h3>Tambah Foto Galeri</h3>

<form method="POST" enctype="multipart/form-data">
    <div class="mb-3">
        <label>Judul</label>
        <input type="text" name="judul" class="form-control" required>
    </div>
    <div class="mb-3">
        <label>Deskripsi</label>
        <textarea name="deskripsi" class="form-control" rows="4"></textarea>
    </div>
    <div class="mb-3">
        <label>Tanggal Kegiatan</label>
        <input type="date" name="tanggal" class="form-control" required>
    </div>
    <div class="mb-3">
        <label>Foto</label>
        <input type="file" name="gambar" class="form-control" required>
    </div>
    <button type="submit" class="btn btn-success">Simpan</button>
</form>

<?php include "../views/layouts/footer.php"; ?>