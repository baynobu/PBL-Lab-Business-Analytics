<?php
require_once __DIR__ . "/../config/database.php";

class Settings
{


    public static function get()
    {
        global $pdo;
        return $pdo->query("SELECT * FROM site_settings LIMIT 1")->fetch(PDO::FETCH_ASSOC);
    }

    public static function update($site_name, $footer_text, $logo = null, $copyright_text = null)
    {
        global $pdo;
        $fields = "site_name = :site_name, footer_text = :footer_text, updated_at = NOW()";
        $params = ['site_name' => $site_name, 'footer_text' => $footer_text];
        if ($logo) {
            $fields .= ", logo = :logo";
            $params['logo'] = $logo;
        }
        if ($copyright_text !== null) {
            $fields .= ", copyright_text = :copyright_text";
            $params['copyright_text'] = $copyright_text;
        }
        $stmt = $pdo->prepare("UPDATE site_settings SET $fields");
        return $stmt->execute($params);
    }
}
