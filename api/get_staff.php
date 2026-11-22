<?php
require_once "db.php";
$rows = $pdo->query("SELECT * FROM staff ORDER BY staff_id DESC")->fetchAll(PDO::FETCH_ASSOC);
echo json_encode(["success" => true, "data" => $rows]);
?>
