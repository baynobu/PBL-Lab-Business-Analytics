<?php
require_once "../app/utils/session.php";
checkAdminLogin();
require_once "../app/models/KontakLab.php";
require_once "../app/utils/log.php";

$kontak = KontakLab::get();
if (!$kontak) {
    $kontak = [
        'alamat' => '',
        'email' => '',
        'telepon' => '',
        'website' => '',
        'maps_embed' => ''
    ];
}

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $alamat = $_POST['alamat'];
    $email = $_POST['email'];
    $telepon = $_POST['telepon'];
    $website = $_POST['website'];
    $maps_embed = $_POST['maps_embed'];

    if (KontakLab::get()) {
        KontakLab::update($alamat, $email, $telepon, $website, $maps_embed);
        logActivity("Update kontak lab");
    } else {
        KontakLab::create($alamat, $email, $telepon, $website, $maps_embed);
        logActivity("Create kontak lab");
    }
    header("Location: kontak_lab.php");
    exit;
}

include "../views/layouts/header.php";
?>


<section class="py-4 min-vh-100 bg-white">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-lg-7 col-md-9">
                <div class="card shadow-lg border-0 rounded-4 p-4 p-md-5">
                    <h3 class="fw-bold text-primary-custom mb-3">Pengaturan Kontak Lab</h3>
                    <form method="POST" autocomplete="off">
                        <div class="mb-3">
                            <label class="form-label fw-semibold">Alamat</label>
                            <textarea name="alamat" class="form-control rounded-3" required><?= htmlspecialchars($kontak['alamat']) ?></textarea>
                        </div>
                        <div class="mb-3">
                            <label class="form-label fw-semibold">Email</label>
                            <input type="email" name="email" class="form-control rounded-pill" value="<?= htmlspecialchars($kontak['email']) ?>" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label fw-semibold">Telepon</label>
                            <input type="text" name="telepon" class="form-control rounded-pill" value="<?= htmlspecialchars($kontak['telepon']) ?>" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label fw-semibold">Website</label>
                            <input type="text" name="website" class="form-control rounded-pill" value="<?= htmlspecialchars($kontak['website']) ?>">
                        </div>
                        <div class="mb-3">
                            <label class="form-label fw-semibold">Embed Google Maps (iframe)</label>
                            <textarea name="maps_embed" class="form-control rounded-3" rows="3"><?= htmlspecialchars($kontak['maps_embed']) ?></textarea>
                        </div>
                        <div class="d-grid mt-4">
                            <button type="submit" class="btn btn-accent btn-lg rounded-pill fw-bold shadow-sm">
                                <i class="bi bi-save me-2"></i>Simpan Kontak
                            </button>
                            <a href="dashboard.php" class="btn btn-secondary btn-lg rounded-pill fw-bold shadow-sm mt-2">Kembali</a>
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