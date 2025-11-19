<?php
require_once "../app/utils/session.php";
checkAdminLogin();
require_once "../app/models/Publikasi.php";
require_once "../app/models/Kategori.php";
require_once "../app/utils/log.php";

$id = $_GET['id'];
$p = Publikasi::find($id);
if (!$p) {
    header("Location: publikasi_manage.php");
    exit;
}
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
        move_uploaded_file($_FILES['file']['tmp_name'], "../public/uploads/publikasi/" . $file);
    }
    Publikasi::update($id, $judul, $penulis, $tanggal, $deskripsi, $file, $link, $kategori_id);
    logActivity("Mengedit publikasi: $judul");
    header("Location: publikasi_manage.php");
    exit;
}
include "../views/layouts/header.php";
?>

<h3>Edit Publikasi</h3>
<form method="POST" enctype="multipart/form-data">
    <div class="mb-3">
        <label>Judul</label>
        <input type="text" name="judul" class="form-control" value="<?= htmlspecialchars($p['judul']) ?>" required>
    </div>
    <div class="mb-3">
        <label>Penulis</label>
        <input type="text" name="penulis" class="form-control" value="<?= htmlspecialchars($p['penulis']) ?>">
    </div>
    <div class="mb-3">
        <label>Tanggal</label>
        <input type="date" name="tanggal" class="form-control" value="<?= htmlspecialchars($p['tanggal']) ?>">
    </div>
    <div class="mb-3">
        <label>Kategori</label>
        <select name="kategori_id" class="form-control" required>
            <option value="">-- Pilih Kategori --</option>
            <?php foreach (Kategori::all() as $k): ?>
                <option value="<?= $k['id'] ?>" <?= $p['kategori_id'] == $k['id'] ? 'selected' : '' ?>><?= htmlspecialchars($k['nama']) ?></option>
            <?php endforeach; ?>
        </select>
    </div>
    <div class="mb-3">
        <label>Deskripsi</label>
        <textarea name="deskripsi" class="form-control" rows="4"><?= htmlspecialchars($p['deskripsi']) ?></textarea>
    </div>
    <div class="mb-3">
        <label>File (PDF, optional)</label>
        <?php if ($p['file']): ?>
            <div class="mb-2"><a href="/lab-ba/public/uploads/publikasi/<?= htmlspecialchars($p['file']) ?>" target="_blank">File saat ini</a></div>
        <?php endif; ?>
        <input type="file" name="file" class="form-control">
    </div>
    <div class="mb-3">
        <label>Link (opsional)</label>
        <input type="url" name="link" class="form-control" value="<?= htmlspecialchars($p['link']) ?>">
    </div>
    <button type="submit" class="btn btn-success">Update</button>
    <a href="publikasi_manage.php" class="btn btn-secondary mt-2">Kembali</a>
</form>
<?php include "../views/layouts/footer.php"; ?>