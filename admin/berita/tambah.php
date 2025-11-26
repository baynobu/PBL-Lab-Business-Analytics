<?php
require_once "../../app/utils/session.php";
checkAdminLogin();
require_once "../../app/models/Berita.php";
require_once "../../app/utils/log.php";

$errors = [];
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $judul = trim($_POST['judul'] ?? '');
    $isi = trim($_POST['isi'] ?? '');
    $penulis = trim($_POST['penulis'] ?? '');
    $tanggal = trim($_POST['tanggal'] ?? date('Y-m-d'));
    $gambar = $_FILES['gambar'] ?? null;

    if ($judul === '') $errors[] = 'Judul wajib diisi.';
    if ($isi === '') $errors[] = 'Isi berita wajib diisi.';
    if ($penulis === '') $errors[] = 'Penulis wajib diisi.';

    $gambarName = '';
    if ($gambar && $gambar['tmp_name']) {
        $allowed = ['jpg', 'jpeg', 'png', 'webp'];
        $ext = strtolower(pathinfo($gambar['name'], PATHINFO_EXTENSION));
        if (!in_array($ext, $allowed)) {
            $errors[] = 'Format gambar harus jpg, jpeg, png, atau webp.';
        } elseif ($gambar['size'] > 2 * 1024 * 1024) {
            $errors[] = 'Ukuran gambar maksimal 2MB.';
        } else {
            $gambarName = uniqid('berita_') . '.' . $ext;
            move_uploaded_file($gambar['tmp_name'], "../../public/uploads/berita/" . $gambarName);
        }
    }

    if (!$errors) {
        Berita::create([
            'judul' => $judul,
            'isi' => $isi,
            'penulis' => $penulis,
            'tanggal' => $tanggal,
            'gambar' => $gambarName
        ]);
        logActivity("Menambah berita: $judul");
        header("Location: manage.php");
        exit;
    }
}
include "../../views/layouts/header.php";
?>
<section class="py-4 min-vh-100 bg-white">
    <div class="container">
        <div class="d-flex flex-wrap align-items-center justify-content-between mb-4 gap-2">
            <h3 class="fw-bold text-primary-custom mb-0">Tambah Berita</h3>
            <a href="manage.php" class="btn btn-secondary rounded-pill fw-semibold"><i class="bi bi-arrow-left me-1"></i>Kembali</a>
        </div>
        <div class="card shadow-lg border-0 rounded-4">
            <div class="card-body p-4">
                <?php if ($errors): ?>
                    <div class="alert alert-danger">
                        <ul class="mb-0">
                            <?php foreach ($errors as $e): ?><li><?= htmlspecialchars($e) ?></li><?php endforeach; ?>
                        </ul>
                    </div>
                <?php endif; ?>
                <form method="post" enctype="multipart/form-data" class="row g-3">
                    <div class="col-md-6">
                        <label class="form-label">Judul Berita</label>
                        <input type="text" name="judul" class="form-control" required value="<?= htmlspecialchars($_POST['judul'] ?? '') ?>">
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Penulis</label>
                        <input type="text" name="penulis" class="form-control" required value="<?= htmlspecialchars($_POST['penulis'] ?? '') ?>">
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Tanggal</label>
                        <input type="date" name="tanggal" class="form-control" required value="<?= htmlspecialchars($_POST['tanggal'] ?? date('Y-m-d')) ?>">
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Gambar (jpg, jpeg, png, webp, max 2MB)</label>
                        <input type="file" name="gambar" accept="image/*" class="form-control">
                    </div>
                    <div class="col-12">
                        <label class="form-label">Isi Berita</label>
                        <textarea name="isi" class="form-control" rows="6" required><?= htmlspecialchars($_POST['isi'] ?? '') ?></textarea>
                    </div>
                    <div class="col-12">
                        <button type="submit" class="btn btn-accent rounded-pill px-4 fw-semibold"><i class="bi bi-save me-1"></i>Simpan</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</section>