-- Name				Description
-- AVG()			Return the average value of the argument
-- BIT_AND()		Return bitwise AND
-- BIT_OR()			Return bitwise OR
-- BIT_XOR()		Return bitwise XOR
-- COUNT()			Return a count of the number of rows returned
-- COUNT(DISTINCT)	Return the count of a number of different values
-- GROUP_CONCAT()	Return a concatenated string
-- JSON_ARRAYAGG()	Return result set as a single JSON array
-- JSON_OBJECTAGG()	Return result set as a single JSON object
-- MAX()			Return the maximum value
-- MIN()			Return the minimum value
-- STD()			Return the population standard deviation
-- STDDEV()			Return the population standard deviation
-- STDDEV_POP()		Return the population standard deviation
-- STDDEV_SAMP()	Return the sample standard deviation
-- SUM()			Return the sum
-- VAR_POP()		Return the population standard variance
-- VAR_SAMP()		Return the sample variance
-- VARIANCE()		Return the population standard variance

-- Function yang sering digunakan
-- Name				Description
-- AVG()			Return the average value of the argument
-- COUNT()			Return a count of the number of rows returned
-- GROUP_CONCAT()	Return a concatenated string
-- MAX()			Return the maximum value
-- MIN()			Return the minimum value
-- STD()			Return the population standard deviation
-- SUM()			Return the sum

-- Tampilkan Jumlah Rata Rata anak yang dimiliki Group By Gender -- AVG()
SELECT
mst_employee.Gender,
AVG (mst_employee.NumberOfChildren)
FROM mst_employee
GROUP BY mst_employee.Gender

-- Tampilkan Jumlah Rata Rata anak yang dimiliki Group By Marital Status -- AVG()
SELECT 
mst_employee.MaritalStatus,
AVG (mst_employee.NumberOfChildren)
FROM mst_employee
GROUP BY mst_employee.MaritalStatus

-- Tampilkan Jumlah Rata Rata anak yang dimiliki Group By Marital Status Kemudian Gender -- AVG()
SELECT
mst_employee.MaritalStatus,
mst_employee.Gender,
AVG(mst_employee.NumberOfChildren)
FROM mst_employee
GROUP BY mst_employee.MaritalStatus, mst_employee.Gender

-- Tampilkan Jumlah Paling Besar anak yang dimiliki Group By Gender -- MAX()
SELECT
mst_employee.Gender,
MAX(mst_employee.NumberOfChildren)
FROM mst_employee
GROUP BY mst_employee.Gender

-- Tampilkan Jumlah Paling Besar anak yang dimiliki Group By Marital Status -- MAX()
SELECT
mst_employee.MaritalStatus,
MAX(mst_employee.NumberOfChildren)
FROM mst_employee
GROUP BY mst_employee.MaritalStatus

-- Tampilkan Jumlah Paling Besar anak yang dimiliki Group By Marital Status Kemudian Gender -- MAX()
SELECT
mst_employee.MaritalStatus,
mst_employee.Gender,
MAX(mst_employee.NumberOfChildren)
FROM mst_employee
GROUP BY mst_employee.MaritalStatus, mst_employee.Gender

-- Tampilkan Jumlah Paling Besar anak yang dimiliki Group By Gender -- MIN()
SELECT
mst_employee.Gender,
MIN(mst_employee.NumberOfChildren)
FROM mst_employee
GROUP BY mst_employee.Gender

-- Tampilkan Jumlah Paling Besar anak yang dimiliki Group By Marital Status -- MIN()
SELECT
mst_employee.MaritalStatus,
MIN(mst_employee.NumberOfChildren)
FROM mst_employee
GROUP BY mst_employee.MaritalStatus

-- Tampilkan Jumlah Paling Besar anak yang dimiliki Group By Marital Status Kemudian Gender -- MIN()
SELECT
mst_employee.MaritalStatus,
mst_employee.Gender,
MIN(mst_employee.NumberOfChildren)
FROM mst_employee
GROUP BY mst_employee.MaritalStatus, mst_employee.Gender

-- Jumlahkan semua Number Of Children Group By Gender -- SUM()
SELECT 
mst_employee.Gender,
SUM(mst_employee.NumberOfChildren) 
FROM mst_employee
GROUP BY mst_employee.Gender

-- Jumlahkan semua Number Of Children group by Marital Status -- SUM()
SELECT 
mst_employee.MaritalStatus,
SUM(mst_employee.NumberOfChildren) 
FROM mst_employee
GROUP BY mst_employee.MaritalStatus

-- Jumlahkan semua Number Of Children group by Marital Status kemudian Gender -- SUM()
SELECT 
mst_employee.MaritalStatus,
mst_employee.Gender,
SUM(mst_employee.NumberOfChildren) 
FROM mst_employee
GROUP BY mst_employee.MaritalStatus, mst_employee.Gender

-- Hitung Jumlah Record group kemudian Gender -- SUM()
SELECT 
mst_employee.Gender,
COUNT(mst_employee.NumberOfChildren) 
FROM mst_employee
GROUP BY mst_employee.Gender