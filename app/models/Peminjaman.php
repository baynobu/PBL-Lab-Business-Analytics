<?php
require_once __DIR__ . "/../config/database.php";

class Peminjaman
{

    public static function all()
    {
        global $pdo;
        $stmt = $pdo->query("SELECT * FROM peminjaman_lab ORDER BY created_at DESC");
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }

    public static function create($nama, $nim, $tanggal_mulai, $tanggal_selesai, $waktu_mulai, $waktu_selesai, $keperluan)
    {
        global $pdo;
        $stmt = $pdo->prepare("
            INSERT INTO peminjaman_lab 
            (nama_peminjam, nim, tanggal_mulai, tanggal_selesai, waktu_mulai, waktu_selesai, keperluan) 
            VALUES 
            (:nama, :nim, :tm, :ts, :wm, :ws, :kep)
        ");
        return $stmt->execute([
            'nama' => $nama,
            'nim' => $nim,
            'tm' => $tanggal_mulai,
            'ts' => $tanggal_selesai,
            'wm' => $waktu_mulai,
            'ws' => $waktu_selesai,
            'kep' => $keperluan
        ]);
    }

    public static function setStatus($id, $status, $admin_id)
    {
        global $pdo;
        $stmt = $pdo->prepare("
            UPDATE peminjaman_lab 
            SET status = :status, admin_id = :admin, updated_at = NOW() 
            WHERE id = :id
        ");
        return $stmt->execute(['status' => $status, 'admin' => $admin_id, 'id' => $id]);
    }

    public static function approved()
    {
        global $pdo;
        $stmt = $pdo->query("SELECT * FROM peminjaman_lab WHERE status = 'disetujui' ORDER BY tanggal_mulai ASC");
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }
}
