<?php
require_once "../app/utils/session.php";
checkAdminLogin();
require_once "../app/models/Profil.php";
require_once "../app/utils/log.php";

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    Profil::create($_POST['kategori'], $_POST['judul'], $_POST['isi']);
    logActivity("Menambah konten profil: {$_POST['kategori']}");
    header("Location: profil_manage.php");
    exit;
}

include "../views/layouts/header.php";
?>

<h3>Tambah Konten Profil</h3>

<form method="POST">
    <div class="mb-3">
        <label>Kategori</label>
        <select name="kategori" class="form-control" required>
            <option value="">-- Pilih Kategori --</option>
            <option value="profile">Profile</option>
            <option value="visi">Visi</option>
            <option value="misi">Misi</option>
            <option value="tujuan">Tujuan</option>
            <option value="latar belakang">Latar Belakang</option>
        </select>
    </div>
    <div class="mb-3">
        <label>Judul</label>
        <input type="text" name="judul" class="form-control">
    </div>
    <div class="mb-3">
        <label>Isi Konten</label>
        <textarea name="isi" class="form-control" rows="6" required></textarea>
    </div>
    <button type="submit" class="btn btn-success">Simpan</button>
</form>

<?php include "../views/layouts/footer.php"; ?>
<a href="profil_manage.php" class="btn btn-secondary mt-2">Kembali</a>