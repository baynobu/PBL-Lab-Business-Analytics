<?php
require_once __DIR__ . "/../config/database.php";

class Dosen
{


    public static function all()
    {
        global $pdo;
        $stmt = $pdo->query("SELECT dosen.*, kategori.nama AS kategori_nama FROM dosen LEFT JOIN kategori ON dosen.kategori_id = kategori.id ORDER BY dosen.id DESC");
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }


    public static function find($id)
    {
        global $pdo;
        $stmt = $pdo->prepare("SELECT dosen.*, kategori.nama AS kategori_nama FROM dosen LEFT JOIN kategori ON dosen.kategori_id = kategori.id WHERE dosen.id = :id");
        $stmt->execute(['id' => $id]);
        return $stmt->fetch(PDO::FETCH_ASSOC);
    }


    public static function create($nama, $keahlian, $foto, $kategori_id)
    {
        global $pdo;
        $stmt = $pdo->prepare("INSERT INTO dosen (nama, keahlian, foto, kategori_id) VALUES (:nama, :keahlian, :foto, :kategori_id)");
        return $stmt->execute(['nama' => $nama, 'keahlian' => $keahlian, 'foto' => $foto, 'kategori_id' => $kategori_id]);
    }


    public static function update($id, $nama, $keahlian, $foto = null, $kategori_id = null)
    {
        global $pdo;
        if ($foto) {
            $stmt = $pdo->prepare("UPDATE dosen SET nama = :nama, keahlian = :keahlian, foto = :foto, kategori_id = :kategori_id WHERE id = :id");
            return $stmt->execute(['nama' => $nama, 'keahlian' => $keahlian, 'foto' => $foto, 'kategori_id' => $kategori_id, 'id' => $id]);
        } else {
            $stmt = $pdo->prepare("UPDATE dosen SET nama = :nama, keahlian = :keahlian, kategori_id = :kategori_id WHERE id = :id");
            return $stmt->execute(['nama' => $nama, 'keahlian' => $keahlian, 'kategori_id' => $kategori_id, 'id' => $id]);
        }
    }

    public static function delete($id)
    {
        global $pdo;
        $stmt = $pdo->prepare("DELETE FROM dosen WHERE id = :id");
        return $stmt->execute(['id' => $id]);
    }
}
