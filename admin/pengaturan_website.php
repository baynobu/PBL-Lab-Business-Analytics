<?php
require_once "../app/utils/session.php";
checkAdminLogin();
require_once "../app/models/Settings.php";
require_once "../app/utils/log.php";

$settings = Settings::get();

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $site_name = $_POST['site_name'];
    $footer_text = $_POST['footer_text'];

    // Cek jika upload logo
    if (!empty($_FILES['logo']['name'])) {
        $logo = $_FILES['logo']['name'];
        $tmp = $_FILES['logo']['tmp_name'];

        move_uploaded_file($tmp, "../public/uploads/logo/" . $logo);

        Settings::update($site_name, $footer_text, $logo);
        logActivity("Mengubah pengaturan website + logo baru");
    } else {
        Settings::update($site_name, $footer_text);
        logActivity("Mengubah pengaturan website");
    }

    header("Location: pengaturan_website.php");
    exit;
}

include "../views/layouts/header.php";
?>

<h3>Pengaturan Website</h3>

<form method="POST" enctype="multipart/form-data">

    <div class="mb-3">
        <label>Nama Website</label>
        <input type="text" name="site_name" class="form-control" value="<?= $settings['site_name']; ?>" required>
    </div>

    <div class="mb-3">
        <label>Footer Text</label>
        <input type="text" name="footer_text" class="form-control" value="<?= $settings['footer_text']; ?>" required>
    </div>

    <div class="mb-3">
        <label>Logo Saat Ini:</label><br>
        <?php if ($settings['logo']): ?>
            <img src="/lab-ba/public/uploads/logo/<?= $settings['logo']; ?>" width="120">
        <?php else: ?>
            <i>Belum ada logo</i>
        <?php endif; ?>
    </div>

    <div class="mb-3">
        <label>Ganti Logo (Opsional)</label>
        <input type="file" name="logo" class="form-control">
    </div>

    <button type="submit" class="btn btn-success">Simpan Pengaturan</button>

</form>

<?php include "../views/layouts/footer.php"; ?>