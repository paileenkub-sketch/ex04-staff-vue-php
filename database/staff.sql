CREATE DATABASE IF NOT EXISTS db_office CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE db_office;
CREATE TABLE IF NOT EXISTS staff (
  staff_id INT AUTO_INCREMENT PRIMARY KEY,
  staff_code VARCHAR(20) NOT NULL UNIQUE,
  staff_name VARCHAR(120) NOT NULL,
  job_title VARCHAR(100) NOT NULL,
  department VARCHAR(100) NOT NULL,
  phone VARCHAR(20) NOT NULL,
  salary DECIMAL(10,2) NOT NULL DEFAULT 0.00,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
INSERT INTO staff (staff_code, staff_name, job_title, department, phone, salary) VALUES
('STF101', 'พีรพล วัฒนากูล', 'วิศวกรซอฟต์แวร์', 'พัฒนาซอฟต์แวร์', '089-412-1101', 44000.00),
('STF102', 'ศิริกัญญา บุญมี', 'นักออกแบบ UX/UI', 'พัฒนาซอฟต์แวร์', '089-412-1102', 36000.00),
('STF103', 'ณัฐวุฒิ เจริญสุข', 'ผู้ดูแลระบบคลาวด์', 'โครงสร้างพื้นฐาน', '089-412-1103', 41000.00),
('STF104', 'กัญญารัตน์ ทองแท้', 'เจ้าหน้าที่ฝ่ายบุคคล', 'บริหารบุคคล', '089-412-1104', 27500.00);
