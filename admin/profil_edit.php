<?php
require_once "../app/utils/session.php";
checkAdminLogin();
require_once "../app/models/Profil.php";
require_once "../app/utils/log.php";

$id = $_GET['id'];
$p = Profil::find($id);

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    Profil::update($id, $_POST['kategori'], $_POST['judul'], $_POST['isi']);
    logActivity("Mengedit konten profil: {$p['kategori']} → {$_POST['kategori']}");
    header("Location: profil_manage.php");
    exit;
}

include "../views/layouts/header.php";
?>

<h3>Edit Konten Profil</h3>

<form method="POST">
    <div class="mb-3">
        <label>Kategori</label>
        <input type="text" name="kategori" class="form-control" value="<?= $p['kategori']; ?>" required>
    </div>
    <div class="mb-3">
        <label>Judul</label>
        <input type="text" name="judul" class="form-control" value="<?= $p['judul']; ?>">
    </div>
    <div class="mb-3">
        <label>Isi Konten</label>
        <textarea name="isi" class="form-control" rows="6" required><?= $p['isi']; ?></textarea>
    </div>
    <button type="submit" class="btn btn-success">Update</button>
</form>

<?php include "../views/layouts/footer.php"; ?>
<a href="profil_manage.php" class="btn btn-secondary mt-2">Kembali</a>