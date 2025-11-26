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
    <div class="row align-items-center">
      <div class="col-md-6 mb-3 mb-md-0">
        <div class="d-flex align-items-center gap-2 mb-2">
          <?php if (!empty($S['logo'])): ?>
            <img src="/lab-ba/public/uploads/logo/<?= htmlspecialchars($S['logo']) ?>" alt="Logo" style="height:36px;max-width:48px;object-fit:contain;">
          <?php else: ?>
            <i class="bi bi-bar-chart-fill fs-2 text-accent"></i>
          <?php endif; ?>
          <h5 class="fw-bold mb-0"><?= htmlspecialchars($S['site_name'] ?? 'Lab Business Analytics') ?></h5>
        </div>
        <p class="mb-1 small"><i class="bi bi-info-circle me-1 text-accent"></i><?= nl2br(htmlspecialchars($S['footer_text'] ?? 'Laboratorium Business Analytics Universitas Anda')) ?></p>
      </div>
      <div class="col-md-3 mb-3 mb-md-0">
        <h6 class="text-accent fw-bold mb-2"><i class="bi bi-list-ul me-1"></i> Navigasi</h6>
        <ul class="list-unstyled mb-0">
          <li><a href="#hero" class="text-white text-decoration-none"><i class="bi bi-house-door me-1"></i> Home</a></li>
          <li><a href="../public/galeri.php" class="text-white text-decoration-none"><i class="bi bi-images me-1"></i> Galeri</a></li>
          <li><a href="../public/dosen.php" class="text-white text-decoration-none"><i class="bi bi-person-badge me-1"></i> Dosen</a></li>
          <li><a href="../public/publikasi.php" class="text-white text-decoration-none"><i class="bi bi-journal-text me-1"></i> Publikasi</a></li>
          <li><a href="../public/berita.php" class="text-white text-decoration-none"><i class="bi bi-newspaper me-1"></i> Berita</a></li>
          <li><a href="../public/peminjaman.php" class="text-white text-decoration-none"><i class="bi bi-calendar-check me-1"></i> Peminjaman</a></li>
          <li><a href="#kontak" class="text-white text-decoration-none"><i class="bi bi-envelope me-1"></i> Kontak</a></li>
        </ul>
      </div>
    </div>
    <hr class="border-light mt-4 mb-3">
    <div class="text-center small">
      <span class="me-1"><i class="bi bi-c-circle"></i></span>
      <?php if (!empty($S['copyright_text'])): ?>
        <?= htmlspecialchars($S['copyright_text']) ?>
      <?php else: ?>
        <?= date('Y') ?> <?= htmlspecialchars($S['site_name'] ?? 'Lab Business Analytics') ?>. All rights reserved.
      <?php endif; ?>
    </div>
  </div>
</footer>
<!-- Bootstrap Icons -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>

</html>