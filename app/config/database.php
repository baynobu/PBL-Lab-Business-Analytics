<?php
$host = "localhost";
$port = "5432";
$dbname = "lab_ba"; // sesuai yang sudah kamu buat
$user = "postgres"; // jika berbeda ubah
$password = "biasanyabisa";     // jika ada password masukkan disini

try {
    $pdo = new PDO("pgsql:host=$host;port=$port;dbname=$dbname", $user, $password);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch(PDOException $e) {
    die("Koneksi database gagal: " . $e->getMessage());
}
