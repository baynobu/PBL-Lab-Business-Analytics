<?php
require_once "../app/utils/session.php";
checkAdminLogin();
?>

<?php include "../views/layouts/header.php"; ?>

<h3>Selamat Datang, <?= $_SESSION['admin_username']; ?> 👋</h3>
<p>Ini adalah panel admin Laboratorium Business Analytics.</p>

<a href="logout.php" class="btn btn-danger btn-sm mt-3">Logout</a>

<?php include "../views/layouts/footer.php"; ?>
