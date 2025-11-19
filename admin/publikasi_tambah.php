<?php
require_once "../app/utils/session.php";
checkAdminLogin();
require_once "../app/models/Publikasi.php";
require_once "../app/models/Kategori.php";
require_once "../app/utils/log.php";

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
        move_uploaded_file($_FILES['file']['tmp_name'], "../public/uploads/publikasi/" . $file);
    }
    Publikasi::create($judul, $penulis, $tanggal, $deskripsi, $file, $link, $kategori_id);
    logActivity("Menambah publikasi: $judul");
    header("Location: publikasi_manage.php");
    exit;
}
include "../views/layouts/header.php";
?>

<h3>Tambah Publikasi</h3>
<form method="POST" enctype="multipart/form-data">
    <div class="mb-3">
        <label>Judul</label>
        <input type="text" name="judul" class="form-control" required>
    </div>
    <div class="mb-3">
        <label>Penulis</label>
        <input type="text" name="penulis" class="form-control">
    </div>
    <div class="mb-3">
        <label>Tanggal</label>
        <input type="date" name="tanggal" class="form-control">
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
        <label>Deskripsi</label>
        <textarea name="deskripsi" class="form-control" rows="4"></textarea>
    </div>
    <div class="mb-3">
        <label>File (PDF, optional)</label>
        <input type="file" name="file" class="form-control">
    </div>
    <div class="mb-3">
        <label>Link (opsional)</label>
        <input type="url" name="link" class="form-control">
    </div>
    <button type="submit" class="btn btn-success">Simpan</button>
    <a href="publikasi_manage.php" class="btn btn-secondary mt-2">Kembali</a>
</form>
<?php include "../views/layouts/footer.php"; ?>