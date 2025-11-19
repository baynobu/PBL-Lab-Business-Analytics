<?php
require_once "../app/utils/session.php";
checkAdminLogin();
require_once "../app/models/Dosen.php";
require_once "../app/models/Kategori.php";
require_once "../app/utils/log.php";

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $nama = $_POST['nama'];
    $keahlian = $_POST['keahlian'];
    $kategori_id = $_POST['kategori_id'];
    $foto = $_FILES['foto']['name'];
    $tmp = $_FILES['foto']['tmp_name'];
    move_uploaded_file($tmp, "../public/uploads/dosen/" . $foto);
    Dosen::create($nama, $keahlian, $foto, $kategori_id);
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
        <label>Kategori</label>
        <select name="kategori_id" class="form-control" required>
            <option value="">-- Pilih Kategori --</option>
            <?php foreach (Kategori::all() as $k): ?>
                <option value="<?= $k['id'] ?>"><?= htmlspecialchars($k['nama']) ?></option>
            <?php endforeach; ?>
        </select>
    </div>
    <div class="mb-3">
        <label>Foto</label>
        <input type="file" name="foto" class="form-control" required>
    </div>
    <button type="submit" class="btn btn-success">Simpan</button>
</form>

<?php include "../views/layouts/footer.php"; ?>
<a href="dosen_manage.php" class="btn btn-secondary mt-2">Kembali</a>