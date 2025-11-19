<?php
require_once "../app/utils/session.php";
checkAdminLogin();
require_once "../app/models/Kategori.php";
require_once "../app/utils/log.php";

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $nama = $_POST['nama'];
    Kategori::create($nama);
    logActivity("Menambah kategori: $nama");
    header("Location: kategori_manage.php");
    exit;
}
include "../views/layouts/header.php";
?>

<h3>Tambah Kategori</h3>
<form method="POST">
    <div class="mb-3">
        <label>Nama Kategori</label>
        <input type="text" name="nama" class="form-control" required>
    </div>
    <button type="submit" class="btn btn-success">Simpan</button>
    <a href="kategori_manage.php" class="btn btn-secondary mt-2">Kembali</a>
</form>
<?php include "../views/layouts/footer.php"; ?>