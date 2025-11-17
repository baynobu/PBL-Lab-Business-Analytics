</div>
<?php require_once "../app/models/Settings.php";
$S = Settings::get();
if (!$S) {
  $S = [
    'site_name' => 'Lab Business Analytics',
    'footer_text' => 'Laboratorium Business Analytics Universitas Anda',
    'logo' => ''
  ];
}
?>
<footer class="mt-auto bg-primary-custom text-white pt-5 pb-3">
  <div class="container">
    <div class="row">
      <div class="col-md-6 mb-3 mb-md-0">
        <div class="d-flex align-items-center gap-2 mb-2">
          <?php if (!empty($S['logo'])): ?>
            <img src="/lab-ba/public/uploads/logo/<?= htmlspecialchars($S['logo']) ?>" alt="Logo" style="height:36px;max-width:48px;object-fit:contain;">
          <?php endif; ?>
          <h5 class="fw-bold mb-0"><?= htmlspecialchars($S['site_name'] ?? 'Lab Business Analytics') ?></h5>
        </div>
        <p class="mb-1"><?= nl2br(htmlspecialchars($S['footer_text'] ?? 'Laboratorium Business Analytics Universitas Anda')) ?></p>
      </div>
      <div class="col-md-3 mb-3 mb-md-0">
        <h6 class="text-accent fw-bold mb-2">Navigasi</h6>
        <ul class="list-unstyled">
          <li><a href="#hero" class="text-white text-decoration-none">Home</a></li>
          <li><a href="#galeri" class="text-white text-decoration-none">Galeri</a></li>
          <li><a href="#dosen" class="text-white text-decoration-none">Dosen</a></li>
          <li><a href="#kontak" class="text-white text-decoration-none">Kontak</a></li>
        </ul>
      </div>
      <!-- Kontak info dihapus, sekarang ada di section kontak halaman utama -->
    </div>
    <hr class="border-light mt-4 mb-3">
    <div class="text-center small">
      <?php if (!empty($S['copyright_text'])): ?>
        <?= htmlspecialchars($S['copyright_text']) ?>
      <?php else: ?>
        &copy; <?= date('Y') ?> <?= htmlspecialchars($S['site_name'] ?? 'Lab Business Analytics') ?>. All rights reserved.
      <?php endif; ?>
    </div>
  </div>
</footer>
<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>

</html>