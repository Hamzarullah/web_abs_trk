
-- Tampilkan Semua Pegawi yang Punya Nama 'BUDI'
SELECT 
mst_employee.Code AS EmployeeCode,
mst_employee.NIK AS EmployeeNIK,
mst_employee.Name AS EmployeeName
FROM mst_employee 
WHERE mst_employee.Name LIKE '%BUDI%'

-- Tampilkan Semua Pegawi yang Punya Nama Depan nya 'BUDI'
SELECT
mst_employee.Code AS EmployeeCode,
mst_employee.NIK AS EmployeeNIK,
mst_employee.Name AS EmployeeName
FROM mst_employee
WHERE mst_employee.Name LIKE 'BUDI%'

-- Tampilkan Semua Pegawi yang Punya Nama Belakang  nya 'BUDI'
SELECT
mst_employee.Code AS EmployeeCode,
mst_employee.NIK AS EmployeeNIK,
mst_employee.Name AS EmployeeName
FROM mst_employee
WHERE mst_employee.Name LIKE '%BUDI'

-- Tampilkan Semua Pegawai punya anak lebih dari 2
SELECT
mst_employee.Code AS EmployeeCode,
mst_employee.NIK AS EmployeeNIK,
mst_employee.Name AS EmployeeName,
mst_employee.NumberOfChildren AS NumberOfChildren
FROM mst_employee
WHERE mst_employee.NumberOfChildren > 2

-- Tampilkan Semu Pegawai yang Anak nya kurang dari 3
SELECT
mst_employee.Code AS EmployeeCode,
mst_employee.NIK AS EmployeeNIK,
mst_employee.Name AS EmployeeName, 
mst_employee.NumberOfChildren
FROM mst_employee
WHERE mst_employee.NumberOfChildren < 3

-- Tampilkan Semua Pegawai yang Anaknya antara 2 - 4
SELECT
mst_employee.Code AS EmployeeCode,
mst_employee.NIK AS EmployeeNIK,
mst_employee.Name AS EmployeeName,
mst_employee.NumberOfChildren AS NumberOfChildren
FROM mst_employee
WHERE mst_employee.NumberOfChildren BETWEEN 2 AND 4

-- Tampilkan Semua Pegawai yang kota nya di SOLO
SELECT 
mst_employee.Code AS EmployeeCode,
mst_employee.NIK AS EmployeeNIK,
mst_employee.Name AS EmployeeName,
mst_city.Code AS CityCode,
mst_city.Name AS CityName
FROM mst_employee
INNER JOIN mst_city ON mst_city.Code = mst_employee.CityCode
WHERE mst_city.Name = 'SOLO'

-- Tampilkan Semua Pegawai yang kota nya di JAKARTA atau MEDAN
SELECT
mst_employee.Code AS EmployeeCode,
mst_employee.NIK AS EmployeeNIK,
mst_employee.Name AS EmployeeName,
mst_city.Code AS CityCode,
mst_city.Name AS CityName
FROM mst_employee
INNER JOIN mst_city ON mst_city.Code = mst_employee.CityCode
WHERE mst_city.Name LIKE '%JAKARTA%' OR mst_city.Name LIKE '%MEDAN%'

-- Tampilkan Semua Pegawai yang agama nya ISLAM
SELECT 
mst_employee.Code AS EmployeeCode,
mst_employee.NIK AS EmployeeNIK,
mst_employee.Name AS EmployeeName,
mst_religion.Code AS EmployeeReligion
FROM mst_employee
INNER JOIN mst_religion ON mst_religion.Code = mst_employee.ReligionCode
WHERE mst_religion.Name = 'ISLAM'

-- Tampilkan Semua Pegawai yang agama nya BUDHA atau HINDU
SELECT 
mst_employee.Code AS EmployeeCode,
mst_employee.NIK AS EmployeeNIK,
mst_employee.Name AS EmployeeName,
mst_religion.Code AS EmployeeReligion
FROM mst_employee
INNER JOIN mst_religion ON mst_religion.Code = mst_employee.ReligionCode
WHERE mst_religion.Name IN ('BUDHA', 'HINDU')

-- Tampilkan Semua Pegawai yang MaritalStatus nya SINGLE
SELECT
mst_employee.Code AS EmployeeCode,
mst_employee.NIK AS EmployeeNIK,
mst_employee.Name AS EmployeeName,
mst_employee.MaritalStatus AS MaritalStatus
FROM mst_employee
WHERE mst_employee.MaritalStatus = 'SINGLE'

-- Tampilkan Semua Pegawai yang MaritalStatus nya SINGLE atau MARRIED
SELECT
mst_employee.Code AS EmployeeCode,
mst_employee.NIK AS EmployeeNIK,
mst_employee.Name AS EmployeeName,
mst_employee.MaritalStatus AS MaritalStatus
FROM mst_employee
WHERE mst_employee.MaritalStatus = 'SINGLE' OR mst_employee.MaritalStatus = 'MARRIED'

-- Tampilkan Semua Pegawai yang MaritalStatus nya BUKAN DIVORCE
SELECT
mst_employee.Code AS EmployeeCode,
mst_employee.NIK AS EmployeeNIK,
mst_employee.Name AS EmployeeName,
mst_employee.MaritalStatus AS MaritalStatus
FROM mst_employee
WHERE mst_employee.MaritalStatus <> 'DIVORCE'

-- Tampilkan Semua Pegawai yang Education nya 'SD' atau 'SMP'
SELECT
mst_employee.Code AS EmployeeCode,
mst_employee.NIK AS EmployeeNIK,
mst_employee.Name AS EmployeeName,
mst_education.Code AS EmployeeEducation
FROM mst_employee
INNER JOIN mst_education ON mst_education.Code = mst_employee.EducationCode
WHERE mst_employee.EducationCode IN ('SD', 'SMP')

-- Tampilkan Semua Pegawai yang Education nya bukan 'SD' atau 'SMP'
SELECT
mst_employee.Code AS EmployeeCode,
mst_employee.NIK AS EmployeeNIK,
mst_employee.Name AS EmployeeName,
mst_education.Code AS EmployeeEducation
FROM mst_employee
INNER JOIN mst_education ON mst_education.Code = mst_employee.EducationCode
WHERE mst_employee.EducationCode NOT IN ('SD', 'SMP')

-- Tampilkan Semua Pegawai yang Education nya 'SD' dan Agamanya ISLAM
SELECT	
mst_employee.Code AS EmployeeCode,
mst_employee.NIK AS EmployeeNIK,
mst_employee.Name AS EmployeeName,
mst_education.Code AS EmployeeEducation,
mst_religion.Code AS EmployeeReligion
FROM mst_employee
INNER JOIN mst_education ON mst_education.Code = mst_employee.EducationCode
INNER JOIN mst_religion ON mst_religion.Code = mst_employee.ReligionCode
WHERE mst_religion.Name = 'ISLAM' AND mst_employee.EducationCode = 'SD'

-- Tampilkan Semua Pegawai yang lahirnya kurang dari tanggal 1 Januari 1980
SELECT
mst_employee.Code AS EmployeeCode,
mst_employee.NIK AS EmployeeNIK,
mst_employee.Name AS EmployeeName,
mst_employee.BirthDate AS EmployeeBirthDate
FROM mst_employee
WHERE mst_employee.BirthDate < '1980-01-01'

-- Tampilkan Semua Pegawai yang lahirnya kurang dari atau sama dengan tanggal 1 Januari 1980
SELECT
mst_employee.Code AS EmployeeCode,
mst_employee.NIK AS EmployeeNIK,
mst_employee.Name AS EmployeeName,
mst_employee.BirthDate AS EmployeeBirthDate
FROM mst_employee
WHERE mst_employee.BirthDate <= '1980-01-01'

-- Tampilkan Semua Pegawai yang lahirnya kurang dari tanggal 1 Januari 1980 dan yang nama nya ada Budi
SELECT
mst_employee.Code AS EmployeeCode,
mst_employee.NIK AS EmployeeNIK,
mst_employee.Name AS EmployeeName,
mst_employee.BirthDate AS EmployeeBirthDate
FROM mst_employee
WHERE mst_employee.BirthDate < '1980-01-01' AND mst_employee.Name LIKE '%BUDI%'
ORDER BY mst_employee.Birthdate

-- Tampilkan Semua Pegawai yang JoinDate nya lebih besar dari 5 Agustus 2017
SELECT
mst_employee.Code AS EmployeeCode,
mst_employee.NIK AS EmployeeNIK,
mst_employee.Name AS EmployeeName,
mst_employee.JoinDate AS EmployeeJoinDate
FROM mst_employee
WHERE mst_employee.JoinDate > '2017-08-05'
ORDER BY mst_employee.JoinDate

-- Tampilkan Semua Pegawai yang Tahun JoinDate nya lebih besar 2017
SELECT
mst_employee.Code AS EmployeeCode,
mst_employee.NIK AS EmployeeNIK,
mst_employee.Name AS EmployeeName,
mst_employee.JoinDate AS EmployeeJoinDate
FROM mst_employee
WHERE YEAR(mst_employee.JoinDate) > '2017'
ORDER BY mst_employee.JoinDate

-- Tampilkan Semua Pegawai yang Tahun JoinDate nya lebih besar atau sama dengan 2017
SELECT
mst_employee.Code AS EmployeeCode,
mst_employee.NIK AS EmployeeNIK,
mst_employee.Name AS EmployeeName,
mst_employee.JoinDate AS EmployeeJoinDate
FROM mst_employee
WHERE YEAR(mst_employee.JoinDate) >= '2017'
ORDER BY mst_employee.JoinDate

-- Tampilkan Semua Pegawai yang Tahun JoinDate nya antara Tahun 2015 - 2017
SELECT
mst_employee.Code AS EmployeeCode,
mst_employee.NIK AS EmployeeNIK,
mst_employee.Name AS EmployeeName,
mst_employee.JoinDate AS EmployeeJoinDate
FROM mst_employee
WHERE YEAR(mst_employee.JoinDate) BETWEEN 2015 AND 2017
ORDER BY mst_employee.JoinDate

-- Tamplikan Semua Pegawai yang masih Aktif (ActiveStatus nya 1)
SELECT
mst_employee.Code AS EmployeeCode,
mst_employee.NIK AS EmployeeNIK,
mst_employee.Name AS EmployeeName,
mst_employee.ActiveStatus AS EmployeeActiveStatus
FROM mst_employee
WHERE mst_employee.ActiveStatus = 1

-- Tampilkan Semua Pegawai yang Gajinya menggunakan IDR atau USD
SELECT 
mst_employee.Code AS EmployeeCode,
mst_employee.NIK AS EmployeeNIK,
mst_employee.Name AS EmployeeName,
mst_employee.SalaryCurrency AS SalaryCurrency
FROM mst_employee
WHERE mst_employee.SalaryCurrency IN ('IDR', 'USD')

-- Tampilkan Semua Pegawai yang Alamatnya ada 'Juna' nya
SELECT 
mst_employee.Code AS EmployeeCode,
mst_employee.NIK AS EmployeeNIK,
mst_employee.Name AS EmployeeName,
mst_employee.Address AS EmployeeAddress
FROM mst_employee
WHERE mst_employee.Address LIKE '%JUNA%'

SELECT
mst_employee.Name AS EmployeeName,
mst_city.Code AS CityCode,
mst_city.Name AS CityName
FROM mst_employee
LEFT JOIN mst_city ON mst_city.Code = mst_employee.CityCode
GROUP BY mst_employee.Name

SELECT
mst_employee.Name AS EmployeeName,
mst_city.Code AS CityCode,
mst_city.Name AS CityName
FROM mst_employee
INNER JOIN mst_city ON mst_city.Code = mst_employee.CityCode
GROUP BY mst_employee.Name