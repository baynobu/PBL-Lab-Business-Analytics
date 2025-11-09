<?php
require_once "../app/models/Peminjaman.php";

if ($_SERVER["REQUEST_METHOD"] == "POST") {

    Peminjaman::create(
        $_POST['nama_peminjam'],
        $_POST['nim'],
        $_POST['tanggal_mulai'],
        $_POST['tanggal_selesai'] ?: null,
        $_POST['waktu_mulai'],
        $_POST['waktu_selesai'],
        $_POST['keperluan']
    );

    echo "<script>alert('Pengajuan peminjaman berhasil dikirim. Silakan menunggu persetujuan admin.'); window.location='peminjaman.php';</script>";
}

include "../views/layouts/header.php";
?>

<h2>Peminjaman Laboratorium Business Analytics</h2>
<p>Silakan isi formulir berikut untuk pengajuan peminjaman lab:</p>

<form method="POST">
  <div class="mb-3">
    <label>Nama Peminjam</label>
    <input type="text" name="nama_peminjam" class="form-control" required>
  </div>

  <div class="mb-3">
    <label>NIM</label>
    <input type="text" name="nim" class="form-control" required>
  </div>

  <div class="mb-3">
    <label>Tanggal Mulai</label>
    <input type="date" name="tanggal_mulai" class="form-control" required>
  </div>

  <div class="mb-3">
    <label>Tanggal Selesai (Opsional)</label>
    <input type="date" name="tanggal_selesai" class="form-control">
  </div>

  <div class="mb-3">
    <label>Waktu Mulai</label>
    <input type="time" name="waktu_mulai" class="form-control" required>
  </div>

  <div class="mb-3">
    <label>Waktu Selesai</label>
    <input type="time" name="waktu_selesai" class="form-control" required>
  </div>

  <div class="mb-3">
    <label>Keperluan Peminjaman</label>
    <textarea name="keperluan" class="form-control" rows="4" required></textarea>
  </div>

  <button type="submit" class="btn btn-primary">Ajukan Peminjaman</button>
</form>

<?php include "../views/layouts/footer.php"; ?>
