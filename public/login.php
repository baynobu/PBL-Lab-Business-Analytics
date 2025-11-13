<?php
session_start();
require_once "../app/config/database.php";

$message = "";

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $username = $_POST['username'];
    $password = $_POST['password'];

    $stmt = $pdo->prepare("SELECT * FROM admin WHERE username = :username LIMIT 1");
    $stmt->execute(['username' => $username]);
    $admin = $stmt->fetch(PDO::FETCH_ASSOC);

    if ($admin && password_verify($password, $admin['password'])) {
        $_SESSION['admin_id'] = $admin['id'];
        $_SESSION['admin_username'] = $admin['username'];

        require_once "../app/utils/log.php";
        logActivity("Login ke sistem");

        header("Location: /lab-ba/admin/dashboard.php");
        exit;
    } else {
        $message = "Username atau Password salah!";
    }
}
?>





<?php include_once "../views/layouts/header.php"; ?>


<div class="d-flex align-items-center justify-content-center min-vh-100 bg-light" style="padding-top: 60px; padding-bottom: 60px;">
    <div class="card shadow-lg p-4 p-md-5 border-0" style="max-width: 400px; width: 100%; border-radius: 1.5rem;">
        <div class="text-center mb-4">
            <img src="/lab-ba/public/assets/img/maskot.png" alt="Lab BA" width="64" class="mb-2 hero-maskot-img shadow-sm" style="background:transparent;">
            <h3 class="mb-0 text-primary-custom fw-bold">Login Admin</h3>
        </div>
        <?php if ($message): ?>
            <div class="alert alert-danger text-center py-2"><?= $message ?></div>
        <?php endif; ?>
        <form method="POST" autocomplete="off">
            <div class="mb-3">
                <label class="form-label fw-semibold">Username</label>
                <input type="text" name="username" class="form-control rounded-pill" required autofocus>
            </div>
            <div class="mb-3">
                <label class="form-label fw-semibold">Password</label>
                <input type="password" name="password" class="form-control rounded-pill" required>
            </div>
            <div class="d-grid mt-3">
                <button type="submit" class="btn btn-accent btn-lg rounded-pill fw-bold shadow-sm">
                    <i class="bi bi-box-arrow-in-right me-2"></i>Login
                </button>
            </div>
        </form>
    </div>
</div>

<style>
    .hero-maskot-img {
        border-radius: 18px;
        box-shadow: 0 4px 16px 0 rgba(10, 42, 67, 0.10);
    }
</style>

<?php include_once "../views/layouts/footer.php"; ?>