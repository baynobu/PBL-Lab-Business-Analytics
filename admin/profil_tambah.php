<?php
require_once "../app/utils/session.php";
checkAdminLogin();
require_once "../app/models/Profil.php";
require_once "../app/utils/log.php";

$message = "";
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    Profil::create($_POST['kategori'], $_POST['judul'], $_POST['isi']);
    logActivity("Menambah konten profil: {$_POST['kategori']}");
    $message = "<div class='alert alert-success'>Konten profil berhasil ditambahkan.</div>";
    // header("Location: profil_manage.php");
    // exit;
}

include "../views/layouts/header.php";
?>
<section class="py-4 min-vh-100 bg-white">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-lg-7 col-md-9">
                <div class="card shadow-lg border-0 rounded-4 p-4 p-md-5">
                    <h3 class="fw-bold text-primary-custom mb-3">Tambah Konten Profil</h3>
                    <?= $message ?>
                    <form method="POST" autocomplete="off">
                        <div class="mb-3">
                            <label class="form-label fw-semibold">Kategori</label>
                            <select name="kategori" class="form-control rounded-pill" required>
                                <option value="">-- Pilih Kategori --</option>
                                <option value="profile">Profile</option>
                                <option value="visi">Visi</option>
                                <option value="misi">Misi</option>
                                <option value="tujuan">Tujuan</option>
                                <option value="latar belakang">Latar Belakang</option>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label class="form-label fw-semibold">Judul</label>
                            <input type="text" name="judul" class="form-control rounded-pill">
                        </div>
                        <div class="mb-3">
                            <label class="form-label fw-semibold">Isi Konten</label>
                            <textarea name="isi" class="form-control" rows="6" required></textarea>
                        </div>
                        <div class="d-flex justify-content-end gap-2 mt-4">
                            <a href="profil_manage.php" class="btn btn-secondary">Kembali</a>
                            <button type="submit" class="btn btn-success">Simpan</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</section>