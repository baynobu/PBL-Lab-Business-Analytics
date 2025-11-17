<?php
require_once "../app/utils/session.php";
checkAdminLogin();
require_once "../app/models/Settings.php";
require_once "../app/utils/log.php";

$settings = Settings::get();
if (!$settings) {
    // Jika belum ada data, buat default kosong agar form tetap tampil
    $settings = [
        'site_name' => '',
        'footer_text' => '',
        'logo' => '',
        'copyright_text' => ''
    ];
}

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $site_name = $_POST['site_name'];
    $footer_text = $_POST['footer_text'];
    $copyright_text = $_POST['copyright_text'] ?? '';

    // Cek jika upload logo
    if (!empty($_FILES['logo']['name'])) {
        $logo = $_FILES['logo']['name'];
        $tmp = $_FILES['logo']['tmp_name'];
        move_uploaded_file($tmp, "../public/uploads/logo/" . $logo);
        Settings::update($site_name, $footer_text, $logo, $copyright_text);
        logActivity("Mengubah pengaturan website + logo baru");
    } else {
        Settings::update($site_name, $footer_text, null, $copyright_text);
        logActivity("Mengubah pengaturan website");
    }

    header("Location: pengaturan_website.php");
    exit;
}

include "../views/layouts/header.php";
?>


<section class="py-4 min-vh-100 bg-white">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-lg-7 col-md-9">
                <div class="card shadow-lg border-0 rounded-4 p-4 p-md-5">
                    <h3 class="fw-bold text-primary-custom mb-3">Pengaturan Website</h3>
                    <form method="POST" enctype="multipart/form-data" autocomplete="off">
                        <div class="mb-3">
                            <label class="form-label fw-semibold">Nama Website</label>
                            <input type="text" name="site_name" class="form-control rounded-pill" value="<?= htmlspecialchars($settings['site_name']) ?>" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label fw-semibold">Footer Text</label>
                            <input type="text" name="footer_text" class="form-control rounded-pill" value="<?= htmlspecialchars($settings['footer_text']) ?>" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label fw-semibold">Copyright (Footer)</label>
                            <input type="text" name="copyright_text" class="form-control rounded-pill" value="<?= htmlspecialchars($settings['copyright_text'] ?? '') ?>" placeholder="Contoh: © 2025 Laboratorium Business Analytics. All rights reserved.">
                        </div>
                        <div class="mb-3">
                            <label class="form-label fw-semibold">Logo Saat Ini:</label><br>
                            <?php if ($settings['logo']): ?>
                                <img src="/lab-ba/public/uploads/logo/<?= htmlspecialchars($settings['logo']) ?>" style="max-width:120px;max-height:80px;object-fit:contain;" alt="Logo Saat Ini" class="rounded shadow mb-2">
                            <?php else: ?>
                                <i>Belum ada logo</i>
                            <?php endif; ?>
                        </div>
                        <div class="mb-3">
                            <label class="form-label fw-semibold">Ganti Logo (Opsional)</label>
                            <input type="file" name="logo" class="form-control">
                        </div>
                        <div class="d-grid mt-4">
                            <button type="submit" class="btn btn-accent btn-lg rounded-pill fw-bold shadow-sm">
                                <i class="bi bi-save me-2"></i>Simpan Pengaturan
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