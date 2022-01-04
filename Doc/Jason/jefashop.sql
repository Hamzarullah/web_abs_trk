CREATE TABLE tbl_prodi
(kode_prodi VARCHAR(5) PRIMARY KEY,
nama_prodi VARCHAR(30)
);

CREATE TABLE tbl_mhs 
(nim VARCHAR(15) PRIMARY KEY,
nama_mhs VARCHAR(30),
alamat VARCHAR(55),
umur VARCHAR(5),
tahun_lulus VARCHAR(5),
kode_prodi VARCHAR(5)
);

INSERT INTO tbl_prodi
(kode_prodi, nama_prodi)
VALUES
('A01', 'Sistem Komputer'),
('A02', 'Sistem Informasi'),
('A03', 'Teknik Informatika')

INSERT INTO tbl_mhs
VALUES
('04102001', 'Nur Qomari', 'Surabaya', '25', '2009', 'A01'),
('04102002', 'Akham Adhan', 'Surabaya', '23', '2007', 'A01'),
('04102003', 'Junior', 'Sidoarjo', '22', '2007', 'A01'),
('04202001', 'Eko Prasetyo', 'Sidoarjo', '20', '2006', 'A02'),
('04202002', 'Hadi Irawan', 'Gresik', '26', '2009', 'A02'),
('04202003', 'Badruzzaman', 'Surabaya', '27', '2009', 'A02'),
('04202004', 'Budi Irawan', 'Surabaya', '23', '2007', 'A02')

SELECT
tbl_mhs.nama_mhs AS Nama,
tbl_mhs.umur AS Umur
FROM tbl_mhs
WHERE Umur < 25

SELECT COUNT(tbl_mhs.tahun_lulus)
FROM tbl_mhs
WHERE tahun_lulus = 2009

SELECT *
FROM tbl_prodi
WHERE tbl_prodi.kode_prodi =
(SELECT MIN(tbl_prodi.kode_prodi)FROM tbl_mhs,tbl_prodi
WHERE tbl_prodi.kode_prodi = tbl_mhs.kode_prodi)

SELECT *
FROM tbl_prodi
WHERE tbl_prodi.kode_prodi =
(SELECT MAX(tbl_prodi.kode_prodi)FROM tbl_mhs,tbl_prodi
WHERE tbl_prodi.kode_prodi = tbl_mhs.kode_prodi)

SELECT*
FROM tbl_mhs
WHERE tbl_mhs.nama_mhs LIKE '%Irawan%'

SELECT alamat,
COUNT(nama_mhs)
FROM tbl_mhs
GROUP BY (ALAMAT)

INSERT INTO tbl_mhs
VALUE
('04102005', 'Asep Syaeful Bahri', 'Banten', '18', '2012', 'A03')

UPDATE tbl_mhs
SET nama_mhs = 'Gunawan Susilo'
WHERE nim = 04102005

DELETE tbl_mhs
FROM tbl_mhs
WHERE nim = 04102005