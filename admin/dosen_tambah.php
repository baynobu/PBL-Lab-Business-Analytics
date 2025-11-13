<?php
require_once "../app/utils/session.php";
checkAdminLogin();
require_once "../app/models/Dosen.php";
require_once "../app/utils/log.php";

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $nama = $_POST['nama'];
    $keahlian = $_POST['keahlian'];

    $foto = $_FILES['foto']['name'];
    $tmp = $_FILES['foto']['tmp_name'];
    move_uploaded_file($tmp, "../public/uploads/dosen/" . $foto);

    Dosen::create($nama, $keahlian, $foto);
    logActivity("Menambah dosen: $nama");

    header("Location: dosen_manage.php");
    exit;
}

include "../views/layouts/header.php";
?>

<h3>Tambah Dosen</h3>

<form method="POST" enctype="multipart/form-data">
    <div class="mb-3">
        <label>Nama</label>
        <input type="text" name="nama" class="form-control" required>
    </div>
    <div class="mb-3">
        <label>Keahlian</label>
        <input type="text" name="keahlian" class="form-control" required>
    </div>
    <div class="mb-3">
        <label>Foto</label>
        <input type="file" name="foto" class="form-control" required>
    </div>
    <button type="submit" class="btn btn-success">Simpan</button>
</form>

<?php include "../views/layouts/footer.php"; ?>