<?php
require_once "../../app/utils/session.php";
checkAdminLogin();
require_once "../../app/models/Publikasi.php";
require_once "../../app/models/Dosen.php";
require_once "../../app/models/Kategori.php";
require_once "../../app/utils/log.php";

$id = $_GET['id'];
$p = Publikasi::find($id);
if (!$p) {
    header("Location: manage.php");
    exit;
}
$dosen_selected = array_map(function ($d) {
    return $d['id'];
}, Publikasi::getDosen($id));
$kategori_selected = array_map(function ($k) {
    return $k['id'];
}, Publikasi::getKategori($id));
$message = "";
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $judul = trim($_POST['judul'] ?? '');
    $tanggal = $_POST['tanggal'] ?? '';
    $deskripsi = trim($_POST['deskripsi'] ?? '');
    $link = trim($_POST['link'] ?? '');
    $dosen_ids = $_POST['dosen_ids'] ?? [];
    $kategori_ids = $_POST['kategori_ids'] ?? [];
    $file = $p['file'];
    // Validasi
    if (!$judul) {
        $message = "<div class='alert alert-danger'>Judul wajib diisi.</div>";
    } elseif (!$link) {
        $message = "<div class='alert alert-danger'>Link SINTA wajib diisi.</div>";
    } elseif (count($dosen_ids) < 1) {
        $message = "<div class='alert alert-danger'>Minimal 1 dosen wajib dipilih.</div>";
    } elseif (!empty($_FILES['file']['name'])) {
        $ext = strtolower(pathinfo($_FILES['file']['name'], PATHINFO_EXTENSION));
        $size = $_FILES['file']['size'];
        if ($ext !== 'pdf' || $size > 2 * 1024 * 1024) {
            $message = "<div class='alert alert-danger'>File harus PDF dan maksimal 2MB.</div>";
        } else {
            $file = time() . '_' . preg_replace('/[^a-zA-Z0-9_.-]/', '', $_FILES['file']['name']);
            move_uploaded_file($_FILES['file']['tmp_name'], "../../public/uploads/publikasi/" . $file);
        }
    }
    if (!$message) {
        $data = [
            'judul' => $judul,
            'tanggal' => $tanggal,
            'file' => $file,
            'link' => $link,
            'deskripsi' => $deskripsi
        ];
        Publikasi::update($id, $data, $dosen_ids, $kategori_ids);
        logActivity("Mengedit publikasi: $judul");
        $p = Publikasi::find($id);
        $dosen_selected = array_map(function ($d) {
            return $d['id'];
        }, Publikasi::getDosen($id));
        $kategori_selected = array_map(function ($k) {
            return $k['id'];
        }, Publikasi::getKategori($id));
        $message = "<div class='alert alert-success'>Data publikasi berhasil diupdate.</div>";
        // header("Location: manage.php");
        // exit;
    }
}
include "../../views/layouts/header.php";
?>
<section class="py-4 min-vh-100 bg-white">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-lg-7 col-md-9">
                <div class="card shadow-lg border-0 rounded-4 p-4 p-md-5">
                    <h3 class="fw-bold text-primary-custom mb-3">Edit Publikasi</h3>
                    <?= $message ?>
                    <form method="POST" enctype="multipart/form-data" autocomplete="off">
                        <div class="mb-3">
                            <label class="form-label fw-semibold">Judul <span class="text-danger">*</span></label>
                            <input type="text" name="judul" class="form-control rounded-pill" value="<?= htmlspecialchars($p['judul']) ?>" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label fw-semibold">Tanggal</label>
                            <input type="date" name="tanggal" class="form-control rounded-pill" value="<?= htmlspecialchars($p['tanggal']) ?>">
                        </div>
                        <div class="mb-3">
                            <label class="form-label fw-semibold">Dosen Peneliti <span class="text-danger">*</span></label>
                            <select name="dosen_ids[]" class="form-select" multiple required>
                                <?php foreach (Dosen::all() as $d): ?>
                                    <option value="<?= $d['id'] ?>" <?= in_array($d['id'], $dosen_selected) ? 'selected' : '' ?>> <?= htmlspecialchars($d['nama']) ?> </option>
                                <?php endforeach; ?>
                            </select>
                            <small class="text-muted">Pilih satu atau lebih dosen.</small>
                        </div>
                        <div class="mb-3">
                            <label class="form-label fw-semibold">Kategori</label>
                            <select name="kategori_ids[]" class="form-select" multiple>
                                <?php foreach (Kategori::all() as $k): ?>
                                    <option value="<?= $k['id'] ?>" <?= in_array($k['id'], $kategori_selected) ? 'selected' : '' ?>> <?= htmlspecialchars($k['nama']) ?> </option>
                                <?php endforeach; ?>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label class="form-label fw-semibold">Deskripsi</label>
                            <textarea name="deskripsi" class="form-control" rows="4"><?= htmlspecialchars($p['deskripsi']) ?></textarea>
                        </div>
                        <div class="mb-3">
                            <label class="form-label fw-semibold">File PDF (Opsional, max 2MB)</label>
                            <input type="file" name="file" class="form-control rounded-pill" accept="application/pdf">
                            <?php if ($p['file']): ?>
                                <div class="mt-2"><a href="/lab-ba/public/uploads/publikasi/<?= htmlspecialchars($p['file']) ?>" target="_blank">File saat ini</a></div>
                            <?php endif; ?>
                        </div>
                        <div class="mb-3">
                            <label class="form-label fw-semibold">Link SINTA <span class="text-danger">*</span></label>
                            <input type="url" name="link" class="form-control rounded-pill" value="<?= htmlspecialchars($p['link']) ?>" required>
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