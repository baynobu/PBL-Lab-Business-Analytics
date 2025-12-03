<?php
require_once "../../app/utils/session.php";
checkAdminLogin();
require_once "../../app/models/Settings.php";
require_once "../../app/utils/log.php";

$settings = Settings::get();
if (!$settings) {
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

    $logo_polinema = null;
    $logo_jti = null;
    if (!empty($_FILES['logo_polinema']['name'])) {
        $logo_polinema = $_FILES['logo_polinema']['name'];
        $tmp = $_FILES['logo_polinema']['tmp_name'];
        move_uploaded_file($tmp, "../../public/uploads/logo/" . $logo_polinema);
    }
    if (!empty($_FILES['logo_jti']['name'])) {
        $logo_jti = $_FILES['logo_jti']['name'];
        $tmp = $_FILES['logo_jti']['tmp_name'];
        move_uploaded_file($tmp, "../../public/uploads/logo/" . $logo_jti);
    }

    if (!empty($_FILES['logo']['name'])) {
        $logo = $_FILES['logo']['name'];
        $tmp = $_FILES['logo']['tmp_name'];
        move_uploaded_file($tmp, "../../public/uploads/logo/" . $logo);
        Settings::update($site_name, $footer_text, $logo, $copyright_text, $logo_polinema, $logo_jti);
        logActivity("Mengubah pengaturan website + logo baru");
    } else {
        Settings::update($site_name, $footer_text, null, $copyright_text, $logo_polinema, $logo_jti);
        logActivity("Mengubah pengaturan website");
    }

    header("Location: website.php");
    exit;
}

include "../../views/layouts/header.php";
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
                            <label class="form-label fw-semibold">Logo Website</label>
                            <input type="file" name="logo" class="form-control rounded-pill">
                            <?php if (!empty($settings['logo'])): ?>
                                <img src="../../public/uploads/logo/<?= htmlspecialchars($settings['logo']) ?>" alt="Logo" style="height:48px;max-width:120px;object-fit:contain;" class="mt-2">
                            <?php endif; ?>
                        </div>
                        <div class="mb-3">
                            <label class="form-label fw-semibold">Logo Polinema</label>
                            <input type="file" name="logo_polinema" class="form-control rounded-pill">
                            <?php if (!empty($settings['logo_polinema'])): ?>
                                <img src="../../public/uploads/logo/<?= htmlspecialchars($settings['logo_polinema']) ?>" alt="Logo Polinema" style="height:48px;max-width:120px;object-fit:contain;" class="mt-2">
                            <?php endif; ?>
                        </div>
                        <div class="mb-3">
                            <label class="form-label fw-semibold">Logo JTI</label>
                            <input type="file" name="logo_jti" class="form-control rounded-pill">
                            <?php if (!empty($settings['logo_jti'])): ?>
                                <img src="../../public/uploads/logo/<?= htmlspecialchars($settings['logo_jti']) ?>" alt="Logo JTI" style="height:48px;max-width:120px;object-fit:contain;" class="mt-2">
                            <?php endif; ?>
                        </div>
                        <div class="d-flex justify-content-end gap-2 mt-4">
                            <button type="submit" class="btn btn-success">Simpan</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</section>