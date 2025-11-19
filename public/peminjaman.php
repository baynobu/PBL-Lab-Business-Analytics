<?php
require_once "../app/models/Peminjaman.php";
if ($_SERVER["REQUEST_METHOD"] == "POST") {
  Peminjaman::create(
    $_POST['nama_peminjam'],
    $_POST['nip'],
    $_POST['tanggal_mulai'],
    $_POST['tanggal_selesai'] ?: null,
    $_POST['waktu_mulai'],
    $_POST['waktu_selesai'],
    $_POST['keperluan']
  );
  $showSuccessModal = true;
}
include "../views/layouts/header.php";
?>

<section class="py-5" style="padding-top: 110px; margin-top: 40px;">
  <section class="py-5" style="margin-top:-140px;">
    <!-- Modal Success -->
    <div class="modal fade" id="successModal" tabindex="-1" aria-labelledby="successModalLabel" aria-hidden="true">
      <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content rounded-4">
          <div class="modal-header border-0">
            <h5 class="modal-title fw-bold text-success" id="successModalLabel"><i class="bi bi-check-circle me-2"></i>Pengajuan Berhasil</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
          </div>
          <div class="modal-body text-center">
            Pengajuan peminjaman berhasil dikirim.<br>Silakan menunggu persetujuan admin.
          </div>
          <div class="modal-footer border-0 justify-content-center">
            <a href="peminjaman.php" class="btn btn-accent rounded-pill px-4">OK</a>
          </div>
        </div>
      </div>
    </div>
  </section>
  <?php if (!empty($showSuccessModal)): ?>
    <script>
      var successModal = new bootstrap.Modal(document.getElementById('successModal'));
      window.addEventListener('DOMContentLoaded', function() {
        successModal.show();
      });
    </script>
  <?php endif; ?>
  <div class="container">
    <div class="row justify-content-center">
      <div class="col-lg-7 col-md-9">
        <div class="card shadow-lg border-0 rounded-4 p-4 p-md-5 bg-white" style="margin-top:0;">
          <div class="text-center mb-4">
            <div class="mb-2">
              <span class="d-inline-flex align-items-center justify-content-center rounded-circle bg-white shadow-sm" style="width:64px;height:64px;">
                <img src="../public/assets/img/maskot.png" alt="Maskot Lab BA" style="width:48px;height:48px;object-fit:contain;" loading="lazy">
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
              <label class="form-label fw-semibold">NIP</label>
              <input type="text" name="nip" class="form-control rounded-pill" required placeholder="Nomor Induk Pegawai (Dosen)">
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
          <div class="d-grid mt-3">
            <a href="index.php" class="btn btn-secondary btn-lg rounded-pill fw-bold shadow-sm">Kembali</a>
          </div>
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