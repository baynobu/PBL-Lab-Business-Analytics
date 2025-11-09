<?php
require_once __DIR__ . "/../config/database.php";

class Settings
{

    public static function get()
    {
        global $pdo;
        return $pdo->query("SELECT * FROM site_settings LIMIT 1")->fetch(PDO::FETCH_ASSOC);
    }

    public static function update($site_name, $footer_text, $logo = null)
    {
        global $pdo;

        if ($logo) {
            $stmt = $pdo->prepare("
                UPDATE site_settings 
                SET site_name = :site_name, footer_text = :footer_text, logo = :logo, updated_at = NOW()
            ");
            return $stmt->execute(['site_name' => $site_name, 'footer_text' => $footer_text, 'logo' => $logo]);
        } else {
            $stmt = $pdo->prepare("
                UPDATE site_settings 
                SET site_name = :site_name, footer_text = :footer_text, updated_at = NOW()
            ");
            return $stmt->execute(['site_name' => $site_name, 'footer_text' => $footer_text]);
        }
    }
}
