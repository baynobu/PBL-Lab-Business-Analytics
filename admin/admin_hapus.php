<?php
require_once "../app/utils/session.php";
checkAdminLogin();
require_once "../app/models/Admin.php";
require_once "../app/utils/log.php";

$a = Admin::find($_GET['id']);
Admin::delete($_GET['id']);
logActivity("Menghapus admin: {$a['username']}");

header("Location: admin_manage.php");
exit;
