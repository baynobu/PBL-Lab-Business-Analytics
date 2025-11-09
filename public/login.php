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

<div class="row justify-content-center">
    <div class="col-md-4">
        <h3 class="mb-4 text-center">Login Admin</h3>

        <?php if ($message): ?>
            <div class="alert alert-danger"><?= $message ?></div>
        <?php endif; ?>

        <form method="POST">
            <div class="form-group mb-3">
                <label>Username</label>
                <input type="text" name="username" class="form-control" required>
            </div>
            <div class="form-group mb-3">
                <label>Password</label>
                <input type="password" name="password" class="form-control" required>
            </div>
            <button type="submit" class="btn btn-primary w-100">Login</button>
        </form>
    </div>
</div>

<?php include_once "../views/layouts/footer.php"; ?>