<?php
require_once "../app/utils/session.php";
checkAdminLogin();
require_once "../app/models/Kategori.php";
require_once "../app/utils/log.php";

$id = $_GET['id'];
$k = Kategori::find($id);
if (!$k) {
    header("Location: kategori_manage.php");
    exit;
}
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $nama = $_POST['nama'];
    Kategori::update($id, $nama);
    logActivity("Mengedit kategori: $nama");
    header("Location: kategori_manage.php");
    exit;
}
include "../views/layouts/header.php";
?>

<h3>Edit Kategori</h3>
<form method="POST">
    <div class="mb-3">
        <label>Nama Kategori</label>
        <input type="text" name="nama" class="form-control" value="<?= htmlspecialchars($k['nama']) ?>" required>
    </div>
    <button type="submit" class="btn btn-success">Update</button>
    <a href="kategori_manage.php" class="btn btn-secondary mt-2">Kembali</a>
</form>
<?php include "../views/layouts/footer.php"; ?>
