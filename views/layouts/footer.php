</div>
<?php require_once "../app/models/Settings.php"; $S = Settings::get(); ?>
<footer class="text-center p-3 bg-light">
  <?= $S['footer_text']; ?>
</footer>
<script src="/lab-ba/public/vendor/bootstrap.bundle.min.js"></script>
<script src="/lab-ba/public/assets/js/script.js"></script>
</body>
</html>
