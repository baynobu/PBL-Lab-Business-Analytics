<?php include "../views/layouts/header.php"; ?>
<?php require_once "../app/models/Profil.php"; ?>

<h2>Profil Laboratorium Business Analytics</h2>

<section>
    <div class="container">
        <h2 class="section-title">Profil Laboratorium</h2>
        ...
    </div>
</section>


<?php foreach (Profil::all() as $p): ?>
    <h4><?= $p['judul']; ?> (<?= $p['kategori']; ?>)</h4>
    <p><?= nl2br($p['isi']); ?></p>
    <hr>
<?php endforeach; ?>

<?php include "../views/layouts/footer.php"; ?>