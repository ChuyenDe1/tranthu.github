-- ============================================================
-- THIẾT KẾ CƠ SỞ DỮ LIỆU - PHẦN TRẦN THƯ PHỤ TRÁCH (TUẦN 1 & 2)
-- Đề tài: Hệ thống Điểm danh Thông minh chống gian lận
-- Bảng phụ trách: users (Người dùng) và classrooms (Phòng học)
-- ============================================================

-- 1. Tạo Database nếu chưa tồn tại
CREATE DATABASE IF NOT EXISTS smart_attendance 
DEFAULT CHARACTER SET utf8mb4 
COLLATE utf8mb4_unicode_ci;

USE smart_attendance;

-- 2. Bảng users: Quản lý Tài khoản & Mã hóa băm mật khẩu
CREATE TABLE IF NOT EXISTS users (
    user_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    full_name VARCHAR(100) NOT NULL,
    role ENUM('admin', 'lecturer', 'student') NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 3. Bảng classrooms: Quản lý Phòng học & Tọa độ gốc GPS
CREATE TABLE IF NOT EXISTS classrooms (
    classroom_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    room_code VARCHAR(20) NOT NULL UNIQUE,
    latitude DECIMAL(10,7) NOT NULL,
    longitude DECIMAL(10,7) NOT NULL,
    CONSTRAINT chk_classroom_latitude CHECK (latitude BETWEEN -90.0000000 AND 90.0000000),
    CONSTRAINT chk_classroom_longitude CHECK (longitude BETWEEN -180.0000000 AND 180.0000000)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================
-- DỮ LIỆU MẪU BAN ĐẦU ĐỂ KIỂM THỬ GIAO DIỆN VÀ PHIÊN ĐIỂM DANH
-- ============================================================

-- Chèn người dùng mẫu (Admin, Giảng viên, Sinh viên)
-- Mật khẩu mặc định cho các tài khoản là: 123456 (đã băm bằng Bcrypt)
INSERT INTO users (username, password_hash, full_name, role) VALUES
('admin', '$2y$10$e0MYzXyjpJS7Pd0RVvHwHe11gJ36dG/GzU.p.90Kz8aR.5X1O.', 'Quản trị viên Hệ thống', 'admin'),
('gv_tu', '$2y$10$e0MYzXyjpJS7Pd0RVvHwHe11gJ36dG/GzU.p.90Kz8aR.5X1O.', 'ThS. Trần Thanh Tú', 'lecturer'),
('231A010203', '$2y$10$e0MYzXyjpJS7Pd0RVvHwHe11gJ36dG/GzU.p.90Kz8aR.5X1O.', 'Nguyễn Trần Anh Thư', 'student');

-- Chèn phòng học mẫu cùng tọa độ mốc GPS
INSERT INTO classrooms (room_code, latitude, longitude) VALUES
('A1.01', 10.7626220, 106.6601720),
('B2.02', 10.7630000, 106.6610000);