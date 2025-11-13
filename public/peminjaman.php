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

<section class="bg-accent bg-opacity-10 min-vh-100 d-flex align-items-center py-5">
  <div class="container">
    <div class="row justify-content-center">
      <div class="col-lg-7 col-md-9">
        <div class="card shadow-lg border-0 rounded-4 p-4 p-md-5">
          <div class="text-center mb-4">
            <div class="mb-2">
              <span class="d-inline-flex align-items-center justify-content-center bg-accent bg-opacity-75 rounded-circle" style="width:56px;height:56px;">
                <i class="bi bi-calendar2-plus text-white fs-2"></i>
              </span>
            </div>
            <h2 class="fw-bold mb-1 text-primary-custom">Formulir Peminjaman Lab</h2>
            <div class="text-muted">Silakan isi formulir berikut untuk pengajuan peminjaman laboratorium.</div>
          </div>
          <form method="POST" autocomplete="off">
            <div class="mb-3">
              <label class="form-label fw-semibold">Nama Peminjam</label>
              <input type="text" name="nama_peminjam" class="form-control rounded-pill" required placeholder="Nama lengkap">
            </div>
            <div class="mb-3">
              <label class="form-label fw-semibold">NIM</label>
              <input type="text" name="nim" class="form-control rounded-pill" required placeholder="Nomor Induk Mahasiswa">
            </div>
            <div class="row g-3">
              <div class="col-md-6">
                <label class="form-label fw-semibold">Tanggal Mulai</label>
                <input type="date" name="tanggal_mulai" class="form-control rounded-pill" required>
              </div>
              <div class="col-md-6">
                <label class="form-label fw-semibold">Tanggal Selesai <span class="text-muted small">(Opsional)</span></label>
                <input type="date" name="tanggal_selesai" class="form-control rounded-pill">
              </div>
            </div>
            <div class="row g-3 mt-2">
              <div class="col-md-6">
                <label class="form-label fw-semibold">Waktu Mulai</label>
                <input type="time" name="waktu_mulai" class="form-control rounded-pill" required>
              </div>
              <div class="col-md-6">
                <label class="form-label fw-semibold">Waktu Selesai</label>
                <input type="time" name="waktu_selesai" class="form-control rounded-pill" required>
              </div>
            </div>
            <div class="mb-3 mt-3">
              <label class="form-label fw-semibold">Keperluan Peminjaman</label>
              <textarea name="keperluan" class="form-control rounded-4" rows="4" required placeholder="Contoh: Praktikum, Penelitian, dsb"></textarea>
            </div>
            <div class="d-grid mt-4">
              <button type="submit" class="btn btn-accent btn-lg rounded-pill fw-bold shadow-sm">
                <i class="bi bi-send me-2"></i>Ajukan Peminjaman
              </button>
            </div>
          </form>
        </div>
      </div>
    </div>
  </div>
</section>

<style>
  .bg-accent {
    background-color: #3FA2F7 !important;
  }

  .text-primary-custom {
    color: #0A2A43 !important;
  }

  .btn-accent {
    background: #3FA2F7;
    color: #fff;
    border: none;
  }

  .btn-accent:hover,
  .btn-accent:focus {
    background: #2386d9;
    color: #fff;
  }
</style>

<?php include "../views/layouts/footer.php"; ?>