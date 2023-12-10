CREATE DATABASE AKADEMIK_31102023

USE AKADEMIK_31102023 

--buat table MHS MATKUL NILAI (DDL)
CREATE TABLE MHS (nim CHAR(3) PRIMARY KEY, nama VARCHAR(40), tinggi INT,	berat FLOAT)
CREATE TABLE MATKUL (kodemk CHAR(2) PRIMARY KEY, namamk VARCHAR(15), sks FLOAT)
CREATE TABLE NILAI (ID int IDENTITY(1,1) PRIMARY KEY,nim CHAR(3) FOREIGN KEY REFERENCES MHS(nim),
kodemk CHAR(2) FOREIGN KEY REFERENCES MATKUL(kodemk), nilai FLOAT)

--buat table baru Dosen (DDL)
CREATE TABLE DOSEN (kodeds CHAR(2) PRIMARY KEY,	namads VARCHAR(30), umur FLOAT)
--tambah field col baru dengan sintaks alter table
ALTER TABLE DOSEN ADD alamat VARCHAR(50), nohp VARCHAR(15)
ALTER TABLE DOSEN ALTER COLUMN nohp VARCHAR(20)
--hapus tabel dosen
DROP TABLE DOSEN

--isi data MHS (DML)
INSERT INTO MHS (nim,nama,tinggi,berat) VALUES ('100','Adi Susanto',170,65.5)
INSERT INTO MHS (nim,nama,tinggi,berat) VALUES ('101','Budi Susanto',175,70.3)
INSERT INTO MHS (nim,nama,tinggi,berat) VALUES ('102','Susi Susanti',165,50.5)
select*from MHS

--isi data MATKUL (DML)
insert into matkul (kodemk,namamk,sks) values ('M1','Pancasila',2)
insert into matkul (kodemk,namamk,sks) values ('M2','Matematika',3)
insert into matkul (kodemk,namamk,sks) values ('M3','Manajemen',3)
select*from MATKUL

--isi data NILAI (DML)
insert into NILAI (nim,kodemk,nilai) values('100','M1',4)
insert into NILAI (nim,kodemk,nilai) values('100','M2',3)
insert into NILAI (nim,kodemk,nilai) values('100','M3',2)
insert into NILAI (nim,kodemk,nilai) values('101','M1',3)
insert into NILAI (nim,kodemk,nilai) values('101','M2',2)
insert into NILAI (nim,kodemk,nilai) values('101','M3',4)
insert into NILAI (nim,kodemk,nilai) values('102','M1',3)
insert into NILAI (nim,kodemk,nilai) values('102','M2',2)
insert into NILAI (nim,kodemk,nilai) values('102','M3',2)
select*from NILAI

--isi data DOSEN (DML)
insert into DOSEN (kodeds,namads,umur,alamat,nohp) values('D1','Ir. Sumijan,M.SC',60,'Bekasi','081213112222')
insert into DOSEN (kodeds,namads,umur,alamat,nohp) values('D2','Ronaldo, S.Kom, M.Kom',50,'Jakarta','08121312122')
insert into DOSEN (kodeds,namads,umur,alamat,nohp) values('D3','Sri Wahyuni, S.Kom, M.Kom',42,'Bali','08121312123')
insert into DOSEN (kodeds,namads,umur,alamat,nohp) values('D4','Ir. Soepono,M.SC',75,'Bogor','08121312111')
select*from DOSEN

--update data DOSEN (DML)
UPDATE DOSEN SET umur = 56, alamat='sukabumi',nohp='081232245645' WHERE kodeds='D1'
--delete data dosen
Delete from DOSEN WHERE kodeds='D1'
select*from DOSEN

--LATIHAN SQL SELECT--

--1. tampilkan data MHS
select*from MHS

--2. tampilkan data nim&nama MHS
select nim,nama from MHS

--3. tampilkan MHS berdasarkan berat (asc)
select*from MHS order by berat asc

--4. tampilkan MHS berdasarkan tinggi (desc)
select*from MHS order by tinggi desc

--5. tampilkan MHS tinggi diatas 170
select*from MHS where tinggi>170

--6. tampilkan MHS berat dibawah 70
select*from MHS where berat<70

--7. tampilkan MHS tinggi diatas 165 dan berat dibawah 70
select*from MHS where tinggi>165 and berat<70

--8. tampilkan MHS tinggi antara 168 - 180
select*from MHS where tinggi between 168 and 180

--9. tampilkan MHS tinggi tidak diantara 168 - 180
select*from MHS where tinggi not between 168 and 180

--10. tampilkan BMI(body mass index) MHS
select *,(berat/(tinggi*tinggi)*10000) as BMI from MHS

--fungsi agregat(rekap)--

--11. tampilkan tinggi maximal MHS
select *,max(tinggi) as tinggi_maximal from MHS

--12. tampilkan berat minimal MHS
Select *,min(berat) as minimum_berat from MHS

--13. tampilkan rata-rata tinggi MHS
Select *,avg(tinggi) as tinggi_rata2 from MHS

--14. tampilkan jumlah berat badan total MHS
Select *,sum(berat) as jumlah_berat from MHS

--15. tampilkan MHS yg tingginya diatas rata rata
Select * from MHS where tinggi > (select avg(tinggi) from MHS)

--16. tampilkan MHS yg tertinggi
select * from MHS where tinggi>=(select max(tinggi) as tinggi_maximal from MHS)

--17. tampilkan nama dan nilai mahasiswa untuk matkul matematika
select MHS.nama,NILAI.nilai,MATKUL.namamk 
from MHS
inner join NILAI 
on MHS.nim=NILAI.nim
inner join MATKUL 
on NILAI.kodemk=MATKUL.kodemk
where MATKUL.namamk ='Matematika'

--18. tampilkan nama dan nilai mahasiswa untuk matakuliah selain Pancasila dan nilainya diatas 2.
select MHS.nama,NILAI.nilai,MATKUL.namamk 
from MHS
inner join NILAI 
on MHS.nim=NILAI.nim
inner join MATKUL 
on NILAI.kodemk=MATKUL.kodemk
where MATKUL.namamk !='Pancasila' and NILAi.nilai>2 

--19. tampilkan IPK semua MHS nim dan namanya
SELECT MHS.nim,MHS.nama,SUM(NILAI.nilai*MATKUL.sks) / SUM(MATKUL.sks) AS IPK
FROM MHS 
INNER JOIN NILAI
ON MHS.nim = NILAI.nim
INNER JOIN MATKUL
ON NILAI.kodemk = MATKUL.kodemk
GROUP BY
    MHS.nim, MHS.nama


--20. tampilkan IPK semua MHS nim dan namanya secara urut berdasarkan IPK.
SELECT MHS.nim,MHS.nama,SUM(NILAI.nilai*MATKUL.sks) / SUM(MATKUL.sks) AS IPK
FROM MHS,NILAI,MATKUL
WHERE MHS.nim=NILAI.nim and NILAI.kodemk=MATKUL.kodemk
GROUP BY
    MHS.nim, MHS.nama
ORDER BY 
	IPK Desc

--21. tampilkan IPK semua MHS nim dan namanya khusus yg IPK diatas 2.75
SELECT MHS.nim,MHS.nama,SUM(NILAI.nilai*MATKUL.sks) / SUM(MATKUL.sks) AS IPK
FROM MHS 
INNER JOIN NILAI
ON MHS.nim = NILAI.nim
INNER JOIN MATKUL
ON NILAI.kodemk = MATKUL.kodemk
GROUP BY
    MHS.nim, MHS.nama
HAVING
	SUM(NILAI.nilai*MATKUL.sks) / SUM(MATKUL.sks)>2.75
