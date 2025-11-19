<?php
// app/models/Publikasi.php
require_once __DIR__ . '/../config/database.php';

class Publikasi {
    public static function all() {
        global $pdo;
        $stmt = $pdo->query('SELECT publikasi.*, kategori.nama AS kategori_nama FROM publikasi LEFT JOIN kategori ON publikasi.kategori_id = kategori.id ORDER BY tanggal DESC, publikasi.id DESC');
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }

    public static function find($id) {
        global $pdo;
        $stmt = $pdo->prepare('SELECT publikasi.*, kategori.nama AS kategori_nama FROM publikasi LEFT JOIN kategori ON publikasi.kategori_id = kategori.id WHERE publikasi.id = ?');
        $stmt->execute([$id]);
        return $stmt->fetch(PDO::FETCH_ASSOC);
    }

    public static function create($judul, $penulis, $tanggal, $deskripsi, $file, $link, $kategori_id) {
        global $pdo;
        $stmt = $pdo->prepare('INSERT INTO publikasi (judul, penulis, tanggal, deskripsi, file, link, kategori_id) VALUES (?, ?, ?, ?, ?, ?, ?)');
        $stmt->execute([$judul, $penulis, $tanggal, $deskripsi, $file, $link, $kategori_id]);
    }

    public static function update($id, $judul, $penulis, $tanggal, $deskripsi, $file, $link, $kategori_id) {
        global $pdo;
        $stmt = $pdo->prepare('UPDATE publikasi SET judul=?, penulis=?, tanggal=?, deskripsi=?, file=?, link=?, kategori_id=? WHERE id=?');
        $stmt->execute([$judul, $penulis, $tanggal, $deskripsi, $file, $link, $kategori_id, $id]);
    }

    public static function delete($id) {
        global $pdo;
        $stmt = $pdo->prepare('DELETE FROM publikasi WHERE id=?');
        $stmt->execute([$id]);
    }
}
