<?php
require_once __DIR__ . '/../config/database.php';

class JamTidakTersedia
{
    public static function allByRange($start, $end)
    {
        global $pdo;
        $stmt = $pdo->prepare("SELECT * FROM jam_tidak_tersedia WHERE tanggal BETWEEN :start AND :end");
        $stmt->execute(['start' => $start, 'end' => $end]);
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }

    public static function insert($tanggal, $mulai, $selesai, $alasan)
    {
        global $pdo;
        $stmt = $pdo->prepare("INSERT INTO jam_tidak_tersedia (tanggal, waktu_mulai, waktu_selesai, alasan, created_at) VALUES (:tanggal, :mulai, :selesai, :alasan, NOW())");
        return $stmt->execute([
            'tanggal' => $tanggal,
            'mulai' => $mulai,
            'selesai' => $selesai,
            'alasan' => $alasan
        ]);
    }

    public static function delete($id)
    {
        global $pdo;
        $stmt = $pdo->prepare("DELETE FROM jam_tidak_tersedia WHERE id = :id");
        return $stmt->execute(['id' => $id]);
    }
}
