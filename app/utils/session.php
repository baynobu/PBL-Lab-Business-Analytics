<?php
function checkAdminLogin() {
    session_start();
    if (!isset($_SESSION['admin_id'])) {
        header("Location: /lab-ba/public/login.php");
        exit;
    }
}
