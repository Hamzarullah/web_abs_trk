INSERT INTO pegawai
VALUE
(002, 'Amin Imsyorry', 'Jln Cipaku 5', '1989-12-02', 08123337777, 2009, 2, 1350000),
(003, 'Budhy Bungaox', 'Jln Cisoka 112', '1989-01-20', 0812367654, 2011, 4, 1050000),
(004, 'Zulkarnaen', 'Jln Alhambra 2', '1991-02-20', 0812367655, 2009, 1, 1450000),
(005, 'Dewi Sudewa', 'Jln Iman 34', '1990-12-02', 08123337766, 2009, 1, 1450000),
(006, 'Ina Nurlian', 'Jln Cisatu 1', '1993-08-09', 0812345676, 2011, 4, 1050000),
(007, 'Cheppy Chardut', 'Jln Cilama 13', '1992-07-09', 0812345688, 2011, 4, 1050000),
(008, 'Dodong M', 'Jln Sutami 16', '1990-07-10', 0812345555, 2010, 3, 1250000)

SELECT *
FROM pegawai
WHERE pegawai.nama LIKE 'D%' AND pegawai.nama LIKE '%a'

SELECT 
pegawai.nip AS NIP,
pegawai.nama AS Nama,
pegawai.golongan AS Golongan,
pegawai.kota AS Kota
FROM pegawai
WHERE pegawai.kota = 'Semarang'

SELECT 
pegawai.nip AS NIP,
pegawai.nama AS Nama,
pegawai.golongan AS Golongan,
pegawai.kota AS Kota
FROM pegawai
WHERE pegawai.kota <> 'Semarang'

SELECT 
pegawai.nip AS NIP,
pegawai.nama AS Nama,
pegawai.golongan AS Golongan,
pegawai.gaji AS Gaji,
0.1 * pegawai.gaji AS GajiPersen
FROM pegawai

SELECT DISTINCT pegawai.golongan , kota
FROM pegawai
ORDER BY Golongan

SELECT *
FROM pegawai
WHERE pegawai.nama LIKE '%ud%'

INSERT INTO perusahaan.pegawai_harian
(nip,
nama,
alamat,
kota,
tgl_lahir,
no_telp,
kode_area,
thn_masuk,
golongan,
gaji)
SELECT
nip,
nama,
alamat,
kota,
tgl_lahir,
no_telp,
kode_area,
thn_masuk,
golongan,
gaji
FROM perusahaan.pegawai_bulanan
WHERE pegawai_bulanan.kota = 'Semarang'

DELETE pegawai_bulanan
FROM pegawai_bulanan
WHERE pegawai_bulanan.nip = '001'