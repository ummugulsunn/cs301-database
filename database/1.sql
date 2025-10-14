-- Veritabanını seç
USE university;

-- Tabloları listele
SHOW TABLES;

-- Öğrenci sayısını kontrol et
SELECT COUNT(*) FROM students;

-- İlk 3 öğrenciyi gör
SELECT * FROM students LIMIT 3;