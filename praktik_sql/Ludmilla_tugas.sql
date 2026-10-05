--Menambahkan kolom jenis_member
INSERT INTO jenis_member(kode_jenis,nama_jenis,persen_diskon) VALUES
	('G','Gold',15),
	('S','Silver',10),
	('R','Reguler',0);
--Menampilkan Jenis_member
SELECT* FROM jenis_member
--===================================
--Menambahkan staaf
INSERT INTO staff(id_staff,nama_staff) VALUES
	('S1','Wulan Sari'),
	('S2','Teguh Prasetyo');
--Menampilkan Jenis_member
SELECT* FROM staff
--===================================
--Menambahkan lapangan
INSERT INTO lapangan(kode_lapangan,nama_lapangan,jenis_olahraga,tarif_per_jam)VALUES
	('L1','Futsal A(sintetis)','Futsal',150000),
	('L2','Futsal b(viny1)','Futsal',120000),
	('L3','Badminton 1','Badminton',60000),
	('L4','Mini Soccer','Mini Soccer',350000),
	('L5','Badminton2','Badminton',60000);

UPDATE lapangan
SET nama_lapangan= 'Futsal B(viny1)'
WHERE kode_lapangan='L2';
--Menampilkan lapangan
SELECT* FROM lapangan
SELECT * FROM lapangan ORDER BY kode_lapangan;
--===================================
--Menambahkan promo
INSERT INTO promo(kode_promo,potongan_promo) VALUES
	('HEMAT10',20000),
	('NEWYEAR',50000),
	('WEEKDAY',30000);
--Menampilkan promo
SELECT *FROM promo
--===================================
--Menambahkan member
INSERT INTO member(id_member,nama_member,no_hp,kode_jenis)VALUES
	('M01','Dimas Anggara','0811-9087-6655','G'),
	('M02','Salsa Bilqis','0812-7766-5544','S'),
	('M03','Rian Hidayat','0896-1122-3399','R'),
	('M04','Nadia Safitri','0812-2211-4455','S'),
	('M05','Ludmilla Riza Maharuni','0831-1184-4636','G');
--Menampilkan member
SELECT*FROM member
--===================================
--Menambahkan booking
INSERT INTO booking(no_booking,tgl_booking,id_member,id_staff,kode_promo,dp,status_bayar) VALUES
	('BK-0901','2026-09-01','M01','S1','HEMAT10',100000,'Lunas'),
	('BK-0902','2026-09-02','M02','S2',NULL,50000,'DP'),
	('BK-0903','2026-09-03','M03','S2','WEEKDAY',0,'belum bayar'),
	('BK-0904','2026-09-04','M04','S1',NULL,60000,'Lunas'),
	('BK-0001','2026-10-01','M05','S2', 'HEMAT10',0,'Lunas');

UPDATE booking
SET dp= '0'
WHERE no_booking='BK-0001';
--Menampilkan booking
SELECT*FROM booking
--===================================
--Menambahkan jadwal Main
INSERT INTO jadwal_main(no_booking,kode_lapangan,tgl_main,jam_mulai,durasi_jam,tarif_saat_booking)VALUES
	('BK-0901','L1','2026-09-05','19:00',2,150000),
	(' BK-0901','L3','2026-09-06','08:00',2,60000),
	( 'BK-0902','L2','2026-09-05','20:00',1,120000),
	(' BK-0903','L4','2026-09-09','16:00',2,350000),
	( 'BK-0903','L1','2026-09-10','19:00',1,150000),
	(' BK-0903','L1','2026-09-17','19:00',1,150000),
	( 'BK-0904','L3','2026-09-08','19:00',1,60000),
	('BK-0001','L5','2026-10-01','20:00',1,60000),
	('BK-0001','L3','2026-10-12','17:00',2,60000);
--Menampilkan jadwal main
ALTER TABLE jadwal_main RENAME COLUMN tgl_mail TO tgl_main;
SELECT*FROM jadwal_main