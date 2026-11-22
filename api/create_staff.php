<?php
require_once "db.php";
$in = json_decode(file_get_contents("php://input"), true) ?? [];
$stmt = $pdo->prepare("INSERT INTO staff (staff_code, staff_name, job_title, department, phone, salary) VALUES (:c, :n, :j, :d, :p, :s)");
$stmt->execute([
  ':c' => trim($in['staff_code'] ?? ''),
  ':n' => trim($in['staff_name'] ?? ''),
  ':j' => trim($in['job_title'] ?? ''),
  ':d' => trim($in['department'] ?? ''),
  ':p' => trim($in['phone'] ?? ''),
  ':s' => floatval($in['salary'] ?? 0),
]);
http_response_code(201);
echo json_encode(["success" => true, "message" => "บันทึกข้อมูลพนักงานเรียบร้อยแล้ว"]);
?>
