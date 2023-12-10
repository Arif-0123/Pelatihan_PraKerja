create database perpustakaan

use perpustakaan

create table Anggota(
NoAnggota char(8) primary key, Nama varchar(25), Sex varchar(15), Telepon varchar(15),
Alamat varchar(30), TglEntry date, Keterangan varchar(25)
)

create table Buku(
KdBuku char(12) primary key, KdJenis char(12) foreign key references JenisBuku(KdJenis),
KdPenulis char(12) foreign key references Penulis(KdPenulis), KdPenerbit char(12) foreign key references Penerbit(KdPenerbit),
ThnTerbit varchar(5), JlhBuku int, TglEntry date, Isbn varchar(12), Judul varchar(30),
Rakbuku varchar(4), Status varchar(25)
)

create table Deskripsi(
NoDeskripsi char(12) primary key, KdBuku char(12) foreign key references Buku(KdBuku), Deskripsi varchar(30)
)

create table JenisBuku(
KdJenis char(12) primary key , NmJenis varchar(25), Keterangan varchar(25)
)

create table Penerbit(
KdPenerbit char(12) primary key, Penerbit varchar(20), Alamat varchar(30), Kota varchar(15), Telepon varchar(15),
Email varchar(30), Keterangan varchar(25)
)

create table Penulis(
KdPenulis char(12) primary key, NmPenulis varchar(20), Alamat varchar(30), Email varchar(30), Keterangan varchar(25)
)

create table Pinjaman(
KdPinjaman char(12) primary key, NoAnggota char(8) foreign key references Anggota(NoAnggota), 
KdBuku char(12) foreign key references Buku(KdBuku), TglPinjaman date, TglKembali date, Keterangan varchar(25)
)

--penulis
insert into Penulis values('ks01','rian','jati','rian@gmail.com','cerita dongeng')
insert into Penulis values('ks02','budi','jakarta','budi@gmail.com','cerita romantis')
insert into Penulis values('ks03','patrick','padang','patrick@gmail.com','filsuf cinta')

--penerbit
insert into Penerbit values('kt01','gramedia','Gedung Kompas Gramedia',
	'jakarta','0822558899','gramedia@gmail.com','jenis buku berbagai genre')
insert into Penerbit values('kt02','bintang media','Gedung bintang media',
	'bandung','0822558888','bintangmedia@gmail.com','jenis buku novel')
insert into Penerbit values('kt03','bukunesia','Gedung bukunesia',
	'Yogyakarta','0822558877','bukunesia@gmail.com','jenis buku fiksi')

--jenis buku
insert into JenisBuku values('kj1','novel','hasil karya imajinasi')
insert into JenisBuku values('kj2','manga','hasil karya imajinasi')
insert into JenisBuku values('kj3','karyailmiah','hasil konvensi ilmiah')

--buku
insert into Buku values('kb1','kj1','ks02','kt02','2019',5,'2023-01-01','978602851991','Indahnya Warnamu','rk10','Tersedia')
insert into Buku values('kb2','kj2','ks01','kt03','2020',2,'2023-02-01','978602851992','Martial art 100 years','rk20','Tersedia')
insert into Buku values('kb3','kj3','ks03','kt01','2021',4,'2023-03-01','978602851993','HTS? Jaya jaya','rk30','Tersedia')

--deskripsi
insert into Deskripsi values('nd1','kb2','berisi latihan bela diri 100th')
insert into Deskripsi values('nd2','kb1','berisi indahnya dia')
insert into Deskripsi values('nd3','kb3','berisi hubungan tanpa status')

--anggota
insert into Anggota values('na1','jamal','Men','081122334451','indarung','2023-05-01','SMA')
insert into Anggota values('na2','jamilah','Women','081122334452','panggilun','2023-05-25','Mahasiswa')
insert into Anggota values('na3','japura','Men','081122334453','kuranji','2023-05-11','SMA')

--pinjaman
insert into Pinjaman values('kp1','na3','kb3','2023-11-01','2023-11-10','buku "Indahnya warnamu"')
insert into Pinjaman values('kp2','na1','kb2','2023-11-05','2023-11-15','buku "Martial art 100 th"')
insert into Pinjaman values('kp3','na2','kb1','2023-11-07','2023-11-19','buku "HTS? Jaya jaya"')


--3. tampilkan penerbit dan buku yang diterbitkan
select Penerbit.*,Buku.KdBuku,Buku.KdJenis,Buku.KdPenulis,Buku.ThnTerbit,Buku.Isbn,Buku.Judul
from Penerbit
inner join Buku
on
	Penerbit.KdPenerbit=Buku.KdPenerbit


--4. tampilkan anggota dan buku yg dipinjam
select Anggota.*,Pinjaman.KdPinjaman,Pinjaman.KdBuku,Pinjaman.TglPinjaman,Pinjaman.TglKembali,Pinjaman.Keterangan
from Anggota
inner join Pinjaman
on
	Anggota.NoAnggota=Pinjaman.NoAnggota

--5. tampilkan penulis dan buku karangannya
select Penulis.*,Buku.KdBuku,Buku.KdPenerbit,Buku.ThnTerbit,Buku.Isbn,Buku.Judul
from Penulis
inner join Buku
on
	Penulis.KdPenulis=Buku.KdPenulis

--6. tampilkan menampilkan jenis buku, buku dan deskripsi dari masing-masing buku tersebut
select JenisBuku.*,Buku.KdBuku,Buku.Judul,Buku.Isbn,Buku.KdPenerbit,Buku.KdPenulis,Buku.ThnTerbit,
Deskripsi.Deskripsi
from JenisBuku
inner join Buku
on
	JenisBuku.KdJenis=Buku.KdJenis
inner join Deskripsi
on
	Buku.KdBuku=Deskripsi.KdBuku


