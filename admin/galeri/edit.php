<?php
require_once "../../app/utils/session.php";
checkAdminLogin();
require_once "../../app/models/Galeri.php";

// Ambil data galeri berdasarkan id
$id = isset($_GET['id']) ? intval($_GET['id']) : 0;
$galeri = Galeri::find($id);
if (!$galeri) {
    header("Location: manage.php");
    exit;
}

$message = "";
if ($_SERVER["REQUEST_METHOD"] === "POST") {
    $judul = $_POST['judul'] ?? '';
    $tanggal = $_POST['tanggal'] ?? '';
    $deskripsi = $_POST['deskripsi'] ?? '';
    $gambar = $galeri['gambar'];

    if (!empty($_FILES['gambar']['name'])) {
        $targetDir = "../../public/uploads/galeri/";
        $fileName = time() . '_' . basename($_FILES['gambar']['name']);
        $targetFile = $targetDir . $fileName;
        if (move_uploaded_file($_FILES['gambar']['tmp_name'], $targetFile)) {
            $gambar = $fileName;
        } else {
            $message = "Gagal upload gambar.";
        }
    }

    if (Galeri::update($id, $judul, $deskripsi, $tanggal, $gambar)) {
        $message = "<div class='alert alert-success'>Data galeri berhasil diupdate.</div>";
        $galeri = Galeri::find($id); // refresh data
    } else {
        $message = "<div class='alert alert-danger'>Gagal update data galeri.</div>";
    }
}

include "../../views/layouts/header.php";
?>

<section class="py-4 min-vh-100 bg-white">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-lg-7 col-md-9">
                <div class="card shadow-lg border-0 rounded-4 p-4 p-md-5">
                    <h3 class="fw-bold text-primary-custom mb-3">Edit Galeri</h3>
                    <?= $message ?>
                    <form method="POST" enctype="multipart/form-data" autocomplete="off">
                        <div class="mb-3">
                            <label class="form-label fw-semibold">Judul</label>
                            <input type="text" name="judul" class="form-control rounded-pill" required value="<?= htmlspecialchars($galeri['judul']) ?>">
                        </div>
                        <div class="mb-3">
                            <label class="form-label fw-semibold">Tanggal</label>
                            <input type="date" name="tanggal" class="form-control rounded-pill" required value="<?= htmlspecialchars($galeri['tanggal']) ?>">
                        </div>
                        <div class="mb-3">
                            <label class="form-label fw-semibold">Gambar Saat Ini</label><br>
                            <img src="/lab-ba/public/uploads/galeri/<?= htmlspecialchars($galeri['gambar']) ?>" width="120">
                        </div>
                        <div class="mb-3">
                            <label class="form-label fw-semibold">Ganti Foto (Opsional)</label>
                            <input type="file" name="gambar" class="form-control rounded-pill">
                        </div>
                        <div class="mb-3">
                            <label class="form-label fw-semibold">Deskripsi</label>
                            <textarea name="deskripsi" class="form-control" rows="4"><?= htmlspecialchars($galeri['deskripsi']) ?></textarea>
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