<?php
require_once "../../app/utils/session.php";
checkAdminLogin();
require_once "../../app/models/Dosen.php";
require_once "../../app/models/Kategori.php";
require_once "../../app/utils/log.php";

$id = $_GET['id'];
$d = Dosen::find($id);

if (!$d) {
    die("Data dosen tidak ditemukan.");
}

$message = "";
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $nama = $_POST['nama'];
    $keahlian = $_POST['keahlian'];
    $kategori_id = $_POST['kategori_id'];
    if (!empty($_FILES['foto']['name'])) {
        $foto = $_FILES['foto']['name'];
        $tmp = $_FILES['foto']['tmp_name'];
        if (!empty($d['foto']) && file_exists("../../public/uploads/dosen/" . $d['foto'])) {
            unlink("../../public/uploads/dosen/" . $d['foto']);
        }
        move_uploaded_file($tmp, "../../public/uploads/dosen/" . $foto);
    } else {
        $foto = $d['foto'];
    }
    Dosen::update($id, $nama, $keahlian, $foto);
    logActivity("Mengedit dosen: {$d['nama']} → $nama");
    $d = Dosen::find($id); // refresh data
    $message = "<div class='alert alert-success'>Data dosen berhasil diupdate.</div>";
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
                    <h3 class="fw-bold text-primary-custom mb-3">Edit Dosen</h3>
                    <?= $message ?>
                    <form method="POST" enctype="multipart/form-data" autocomplete="off">
                        <div class="mb-3">
                            <label class="form-label fw-semibold">Nama</label>
                            <input type="text" name="nama" class="form-control rounded-pill" value="<?= htmlspecialchars($d['nama']); ?>" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label fw-semibold">Keahlian</label>
                            <input type="text" name="keahlian" class="form-control rounded-pill" value="<?= htmlspecialchars($d['keahlian']); ?>" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label fw-semibold">Kategori</label>
                            <select name="kategori_id" class="form-control rounded-pill" required>
                                <option value="">-- Pilih Kategori --</option>
                                <?php foreach (Kategori::all() as $k): ?>
                                    <option value="<?= $k['id'] ?>" <?= (isset($d['kategori_id']) && $d['kategori_id'] == $k['id']) ? 'selected' : '' ?>><?= htmlspecialchars($k['nama']) ?></option>
                                <?php endforeach; ?>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label class="form-label fw-semibold">Foto Saat Ini</label><br>
                            <img src="/lab-ba/public/uploads/dosen/<?= htmlspecialchars($d['foto']); ?>" width="120">
                        </div>
                        <div class="mb-3">
                            <label class="form-label fw-semibold">Ganti Foto (Opsional)</label>
                            <input type="file" name="foto" class="form-control rounded-pill">
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