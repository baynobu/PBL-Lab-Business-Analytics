<?php
require_once "../app/utils/session.php";
checkAdminLogin();
require_once "../app/models/Galeri.php";

// Ambil data galeri berdasarkan id
$id = isset($_GET['id']) ? intval($_GET['id']) : 0;
$galeri = Galeri::find($id);
if (!$galeri) {
    header("Location: galeri_manage.php");
    exit;
}

$message = "";
if ($_SERVER["REQUEST_METHOD"] === "POST") {
    $judul = $_POST['judul'] ?? '';
    $tanggal = $_POST['tanggal'] ?? '';
    $deskripsi = $_POST['deskripsi'] ?? '';
    $gambar = $galeri['gambar'];

    // Handle upload gambar baru jika ada
    if (!empty($_FILES['gambar']['name'])) {
        $targetDir = "../public/uploads/galeri/";
        $fileName = time() . '_' . basename($_FILES['gambar']['name']);
        $targetFile = $targetDir . $fileName;
        if (move_uploaded_file($_FILES['gambar']['tmp_name'], $targetFile)) {
            $gambar = $fileName;
        } else {
            $message = "Gagal upload gambar.";
        }
    }

    if (Galeri::update($id, $judul, $tanggal, $gambar, $deskripsi)) {
        $message = "<div class='alert alert-success'>Data galeri berhasil diupdate.</div>";
        $galeri = Galeri::find($id); // refresh data
    } else {
        $message = "<div class='alert alert-danger'>Gagal update data galeri.</div>";
    }
}

include "../views/layouts/header.php";
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
                            <img src="/lab-ba/public/uploads/galeri/<?= htmlspecialchars($galeri['gambar']) ?>" alt="Gambar Galeri" class="img-fluid rounded mb-2" style="max-height:180px;">
                            <input type="file" name="gambar" class="form-control mt-2">
                            <div class="form-text">Kosongkan jika tidak ingin mengganti gambar.</div>
                        </div>
                        <div class="mb-3">
                            <label class="form-label fw-semibold">Deskripsi</label>
                            <textarea name="deskripsi" class="form-control rounded-4" rows="4" required><?= htmlspecialchars($galeri['deskripsi']) ?></textarea>
                        </div>
                        <div class="d-grid mt-4">
                            <button type="submit" class="btn btn-accent btn-lg rounded-pill fw-bold shadow-sm">
                                <i class="bi bi-save me-2"></i>Simpan Perubahan
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</section>

<style>
    .text-primary-custom {
        color: #0A2A43 !important;
    }

    .btn-accent {
        background-color: #3FA2F7;
        color: #fff;
        border: none;
    }

    .btn-accent:hover,
    .btn-accent:focus {
        background: #2196f3;
        color: #fff;
    }
</style>

<?php include "../views/layouts/footer.php"; ?>