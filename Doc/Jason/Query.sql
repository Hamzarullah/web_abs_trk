-- SELECT = MENAMPILKAN RECORD
-- INSERT = MENAMBAH RECORD
-- UPDATE = MERUBAH RECORD
-- DELETE = MENGHAPUS RECORD
-- QUERY

-- SELECT = Menampilkan
-- * = FIELD APA (* SEMUA FIELD)
-- FROM = DARI
-- mst_city = Nama Table
-- Where = Kondisi
-- ORDER BY = Mengurutkan Sesuai Field yang diminta (ASC (A-Z/DESC (Z-A))

-- 
-- OPERATOR 
-- AND
-- OR
-- LIKE
-- NOT LIKE
-- =
-- <>
-- >
-- <
-- <=
-- >=

-- between
-- in

-- Parameter
-- Variable
-- Character

-- Tampilkan semua Record Kota
SELECT * FROM mst_city

-- Tampilkan semua Record Kota untuk Field Code, Name, ProvinceCode
SELECT mst_city.Code, mst_city.Name, mst_city.ProvinceCode FROM mst_city

-- Tampilkan Semua Kota yang Name nya mengandung "ilang" nya
SELECT * FROM mst_city WHERE NAME LIKE '%ILANG%'

-- Tampilkan Semua Kota yang Name nya depan nya huruf "Cil" nya
SELECT * FROM mst_city WHERE NAME LIKE 'CIL%'

-- Tampilkan Semua Kota yang Name nya Belakang nya huruf "KAP" nya
SELECT * FROM mst_city WHERE NAME LIKE '%KAP'

-- Tampilkan Semua Kota yang Name nya ada "Kota" nya
SELECT * FROM mst_city WHERE NAME LIKE '%KOTA%'

-- Tampilkan Semua Kota yang Name ada Huruf "DE"
SELECT * FROM mst_city WHERE NAME LIKE '%DE%'

-- Tampilkan Semua Kota yang Name ada Huruf "DE" dan yang Code nya depan nya huruf "P"
SELECT * FROM mst_city WHERE NAME LIKE '%DE%' AND CODE LIKE 'P%'

-- Tampilkan Semua Kota yang ada Huruf "DE" atau yang Code nya depan nya huruf "P"
SELECT * FROM mst_city WHERE NAME LIKE '%DE%' OR CODE LIKE 'P%'

-- Tampilkan Semua Kota yang Name nya = 'CILANGKAP' atau yang name nya Depan nya 'KOTA' nya
SELECT * FROM mst_city WHERE NAME = 'CILANGKAP' OR NAME LIKE 'KOTA%'

-- Tampilkan Semua Kota yang Name nya = 'CILANGKAP' atau yang name nya Depan nya 'KOTA' nya
SELECT * FROM mst_city WHERE NAME = 'CILANGKAP' AND NAME LIKE 'KOTA%'

-- Tampilkan Semua Kota yang name ada 'KOTA' nya
SELECT * FROM mst_city WHERE NAME LIKE '%KOTA%'

-- Tampilkan Semua Kota yang name tidak ada 'KOTA' nya
SELECT * FROM mst_city WHERE NAME NOT LIKE '%KOTA%'

-- Tampilkan Semua Kota yang Name nya adalah "Cilangkap" nya
SELECT * FROM mst_city WHERE NAME = 'CILANGKAP'

-- Tampilkan Semua Kota yang Name nya bukan "Cilangkap" nya
SELECT * FROM mst_city WHERE NAME <> 'CILANGKAP'

-- Tampilkan semua Record Kota untuk Field Code, Name, ProvinceCode
SELECT CODE, NAME, ProvinceCode FROM mst_city

-- JOIN
-- INNER JOIN
-- LEFT JOIN
-- RIGHT JOIN

-- Tampilkan semua Record Kota untuk Field Code, Name, ProvinceCode, Province Name
SELECT *
FROM mst_city
INNER JOIN mst_province 
ON mst_province.Code = mst_city.ProvinceCode

SELECT 
mst_city.CODE AS CityCode, 
mst_city.NAME AS CityName, 
mst_city.ProvinceCode, 
mst_province.Name AS ProvinceName
FROM mst_city
INNER JOIN mst_province ON mst_province.Code = mst_city.ProvinceCode

-- Tampilkan semua Record Kota untuk Field Code, Name, ProvinceCode, Province Name, IslandCode, Island Name
SELECT 
mst_city.CODE AS CityCode, 
mst_city.NAME AS CityName, 
mst_province.Code AS ProvinceCode, 
mst_province.Name AS ProvinceName,
mst_island.Code AS IslandCode,
mst_island.Name AS IslandName
FROM mst_city
INNER JOIN mst_province ON mst_province.Code = mst_city.ProvinceCode
INNER JOIN mst_island ON mst_island.Code = mst_province.IslandCode

-- Tampilkan semua Record Kota untuk Field Code, Name, ProvinceCode, Province Name, IslandCode, Island Name, CountryCode, CountryNamez
SELECT 
mst_city.Code AS CityCode,
mst_city.Name AS CityName,
mst_province.Code AS ProvinceCode,
mst_province.Name AS ProvinceName,
mst_island.Code AS IslandCode,
mst_island.Name AS IslandName,
mst_country.Code AS CountryCode,
mst_country.Name AS CountryName
FROM mst_city
INNER JOIN mst_province ON mst_province.Code = mst_city.ProvinceCode
INNER JOIN mst_island ON mst_island.Code = mst_province.IslandCode
INNER JOIN mst_country ON mst_country.Code = mst_island.CountryCode

-- Tampilkan semua Record Kota untuk Field Code, Name, ProvinceCode, Province Name, IslandCode, Island Name, 
-- CountryCode, CountryName yang Kota name ada 'Bandung' nya
SELECT 
mst_city.Code AS CityCode,
mst_city.Name AS CityName,
mst_province.Code AS ProvinceCode,
mst_province.Name AS ProvinceName,
mst_island.Code AS IslandCode,
mst_island.Name AS IslandName,
mst_country.Code AS CountryCode,
mst_country.Name AS CountryName
FROM mst_city
INNER JOIN mst_province ON mst_province.Code = mst_city.ProvinceCode
INNER JOIN mst_island ON mst_island.Code = mst_province.IslandCode
INNER JOIN mst_country ON mst_country.Code = mst_island.CountryCode
WHERE mst_city.Name LIKE '%Bandung%'

-- Tampilkan semua Record Kota untuk Field Code, Name, ProvinceCode, Province Name, IslandCode, Island Name, 
-- CountryCode, CountryName yang Kota name ada 'Bandung' nya atau Kota name ada 'JAKARTA' nya
SELECT 
mst_city.Code AS CityCode,
mst_city.Name AS CityName,
mst_province.Code AS ProvinceCode,
mst_province.Name AS ProvinceName,
mst_island.Code AS IslandCode,
mst_island.Name AS IslandName,
mst_country.Code AS CountryCode,
mst_country.Name AS CountryName
FROM mst_city
INNER JOIN mst_province ON mst_province.Code = mst_city.ProvinceCode
INNER JOIN mst_island ON mst_island.Code = mst_province.IslandCode
INNER JOIN mst_country ON mst_country.Code = mst_island.CountryCode
WHERE mst_city.Name LIKE '%Bandung%' OR mst_city.Name LIKE '%JAKARTA%'
