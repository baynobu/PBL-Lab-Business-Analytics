<?php
require_once "../app/utils/session.php";
checkAdminLogin();
require_once "../app/models/Dosen.php";
require_once "../app/models/Kategori.php";
require_once "../app/utils/log.php";

$id = $_GET['id'];
$d = Dosen::find($id);

if (!$d) {
    die("Data dosen tidak ditemukan.");
}

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $nama = $_POST['nama'];
    $keahlian = $_POST['keahlian'];
    $kategori_id = $_POST['kategori_id'];
    // Jika upload foto baru
    if (!empty($_FILES['foto']['name'])) {
        $foto = $_FILES['foto']['name'];
        $tmp = $_FILES['foto']['tmp_name'];
        // Hapus foto lama
        if (!empty($d['foto']) && file_exists("../public/uploads/dosen/" . $d['foto'])) {
            unlink("../public/uploads/dosen/" . $d['foto']);
        }
        move_uploaded_file($tmp, "../public/uploads/dosen/" . $foto);
    } else {
        // Tidak upload gambar baru → gunakan gambar lama
        $foto = $d['foto'];
    }
    Dosen::update($id, $nama, $keahlian, $foto, $kategori_id);
    logActivity("Mengedit dosen: {$d['nama']} → $nama");
    header("Location: dosen_manage.php");
    exit;
}

include "../views/layouts/header.php";
?>

<h3>Edit Dosen</h3>

<form method="POST" enctype="multipart/form-data">
    <div class="mb-3">
        <label>Nama</label>
        <input type="text" name="nama" class="form-control" value="<?= $d['nama']; ?>" required>
    </div>
    <div class="mb-3">
        <label>Keahlian</label>
        <input type="text" name="keahlian" class="form-control" value="<?= $d['keahlian']; ?>" required>
    </div>
    <div class="mb-3">
        <label>Kategori</label>
        <select name="kategori_id" class="form-control" required>
            <option value="">-- Pilih Kategori --</option>
            <?php foreach (Kategori::all() as $k): ?>
                <option value="<?= $k['id'] ?>" <?= $d['kategori_id'] == $k['id'] ? 'selected' : '' ?>><?= htmlspecialchars($k['nama']) ?></option>
            <?php endforeach; ?>
        </select>
    </div>
    <div class="mb-3">
        <label>Foto Saat Ini</label><br>
        <img src="/lab-ba/public/uploads/dosen/<?= $d['foto']; ?>" width="120">
    </div>
    <div class="mb-3">
        <label>Ganti Foto (Opsional)</label>
        <input type="file" name="foto" class="form-control">
    </div>
    <button type="submit" class="btn btn-success">Update</button>
</form>

<?php include "../views/layouts/footer.php"; ?>
<a href="dosen_manage.php" class="btn btn-secondary mt-2">Kembali</a>