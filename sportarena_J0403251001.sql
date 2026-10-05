-- =============================================================
-- TUGAS PERTEMUAN 6 - BASIS DATA: SPORT ARENA
-- Nama     : LUDMILLA RIZA MAHARUNI
-- NIM      : J0403251001
-- Database : sportarena1_J0403251001

-- =====================================================
-- BAGIAN B: DDL - MEMBUAT 7 TABEL
-- =====================================================

DROP TABLE IF EXISTS jadwal_main, booking, member, promo,
                     lapangan, staff, jenis_member CASCADE;


-- 1. JENIS_MEMBER
CREATE TABLE jenis_member (
    kode_jenis CHAR(1) PRIMARY KEY,
    nama_jenis VARCHAR(20) NOT NULL UNIQUE,
    persen_diskon SMALLINT NOT NULL
        CHECK (persen_diskon BETWEEN 0 AND 100)
);


-- 2. STAFF
CREATE TABLE staff (
    id_staff CHAR(2) PRIMARY KEY,
    nama_staff VARCHAR(60) NOT NULL
);


-- 3. LAPANGAN
CREATE TABLE lapangan (
    kode_lapangan CHAR(2) PRIMARY KEY,
    nama_lapangan VARCHAR(50) NOT NULL,
    jenis_olahraga VARCHAR(20) NOT NULL,
    tarif_per_jam NUMERIC(12,2) NOT NULL
        CHECK (tarif_per_jam > 0)
);


-- 4. PROMO
CREATE TABLE promo (
    kode_promo VARCHAR(10) PRIMARY KEY,
    potongan_promo NUMERIC(12,2) NOT NULL
        CHECK (potongan_promo > 0)
);


-- 5. MEMBER
CREATE TABLE member (
    id_member CHAR(3) PRIMARY KEY,
    nama_member VARCHAR(60) NOT NULL,
    no_hp VARCHAR(20) NOT NULL UNIQUE,
    kode_jenis CHAR(1) NOT NULL,
    FOREIGN KEY (kode_jenis)
        REFERENCES jenis_member(kode_jenis)
);


-- 6. BOOKING
CREATE TABLE booking (
    no_booking VARCHAR(10) PRIMARY KEY,
    tgl_booking DATE NOT NULL,
    id_member CHAR(3) NOT NULL,
    id_staff CHAR(2) NOT NULL,
    kode_promo VARCHAR(10),
    dp NUMERIC(12,2) NOT NULL DEFAULT 0
        CHECK (dp >= 0),
    status_bayar VARCHAR(12) NOT NULL DEFAULT 'Belum bayar'
        CHECK (status_bayar IN ('Belum bayar', 'DP', 'Lunas')),

    FOREIGN KEY (id_member)
        REFERENCES member(id_member),

    FOREIGN KEY (id_staff)
        REFERENCES staff(id_staff),

    FOREIGN KEY (kode_promo)
        REFERENCES promo(kode_promo)
);


-- 7. JADWAL_MAIN
CREATE TABLE jadwal_main (
    no_booking VARCHAR(10),
    kode_lapangan CHAR(2),
    tgl_main DATE,
    jam_mulai TIME,
    durasi_jam SMALLINT NOT NULL
        CHECK (durasi_jam > 0),
    tarif_saat_booking NUMERIC(12,2) NOT NULL
        CHECK (tarif_saat_booking > 0),

    PRIMARY KEY (
        no_booking,
        kode_lapangan,
        tgl_main,
        jam_mulai
    ),

    FOREIGN KEY (no_booking)
        REFERENCES booking(no_booking),

    FOREIGN KEY (kode_lapangan)
        REFERENCES lapangan(kode_lapangan)
);


-- =====================================================
-- BAGIAN C: DML - ISIKAN DATA DARI 7 TABEL BERIKUT
-- =====================================================
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
	('L2','Futsal B(vinyl)','Futsal',120000),
	('L3','Badminton 1','Badminton',60000),
	('L4','Mini Soccer','Mini Soccer',350000),
	('L5','Badminton2','Badminton',60000);


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
	('BK-0903','2026-09-03','M03','S2','WEEKDAY',0,'Belum bayar'),
	('BK-0904','2026-09-04','M04','S1',NULL,60000,'Lunas'),
	('BK-0001','2026-10-01','M05','S2', 'HEMAT10',0,'Lunas');

UPDATE booking
SET dp= '0'
WHERE no_booking='BK-0001';
--Menampilkan booking
SELECT*FROM booking
--===================================
--Menambahkan jadwal Main
SELECT * FROM booking;
INSERT INTO jadwal_main
(no_booking, kode_lapangan, tgl_main, jam_mulai, durasi_jam, tarif_saat_booking)
VALUES
('BK-0901','L1','2026-09-05','19:00',2,150000),
('BK-0901','L3','2026-09-06','08:00',2,60000),
('BK-0902','L2','2026-09-05','20:00',1,120000),
('BK-0903','L4','2026-09-09','16:00',2,350000),
('BK-0903','L1','2026-09-10','19:00',1,150000),
('BK-0903','L1','2026-09-17','19:00',1,150000),
('BK-0904','L3','2026-09-08','19:00',1,60000),
('BK-0001','L5','2026-10-01','20:00',1,60000),
('BK-0001','L3','2026-10-12','17:00',2,60000);


-- =====================================================
-- BAGIAN D: DQL - QUERY TINGKAT DASAR
-- =====================================================
--===== Query1–8:memilih,menyaring,danmengurutkan ====
-- Nomor 1
SELECT * FROM lapangan;

-- Nomor 2
SELECT kode_lapangan, nama_lapangan, tarif_per_jam FROM lapangan ORDER BY tarif_per_jam DESC;

-- Nomor 3
SELECT * FROM lapangan WHERE jenis_olahraga = 'Futsal';

-- Nomor 4
SELECT * FROM lapangan WHERE tarif_per_jam < 100000 ORDER BY tarif_per_jam ASC;

-- Nomor 5
SELECT nama_member AS "Nama Member", no_hp AS "Nomor HP" FROM member ORDER BY nama_member ASC;

-- Nomor 6
SELECT DISTINCT jenis_olahraga FROM lapangan ORDER BY jenis_olahraga ASC;

-- Nomor 7
SELECT * FROM member WHERE kode_jenis <> 'R';

-- Nomor 8
SELECT * FROM member WHERE nama_member ILIKE '%sa%';

--===== Query9–16:rentang,daftarnilai,NULL,hitungan====
--9. Tampilkan jadwal main yang tanggalnya antara 5 dan 10 September2026,urut tanggal lalu jam.
SELECT * FROM jadwal_main WHERE tgl_main BETWEEN '2026-09-05' AND '2026-09-10' ORDER BY tgl_main, jam_mulai;

-- 10.  Tampilkan booking yang statusnya DP atau Belum bayar(gunakanIN),urut tanggal booking.
SELECT * FROM booking WHERE status_bayar IN ('DP', 'Belum bayar') ORDER BY tgl_booking ASC;

--11.  Tampilkan booking yang tidak memakai promo
SELECT * FROM booking WHERE kode_promo IS NULL;

--12.  Tampilkan booking yang memakai promo,urut nomor booking.
SELECT * FROM booking WHERE kode_promo IS NOT NULL ORDER BY no_booking ASC;

--- 13. tampilkan durasi main minimal 2 jam
SELECT * FROM jadwal_main WHERE durasi_jam >= 2 ORDER BY durasi_jam DESC, tgl_main;

-- 14. Tampilkan 3 jadwal main paling awal berdasarkan tanggal dan jam.
SELECT * FROM jadwal_main ORDER BY tgl_main, jam_mulai LIMIT 3;

--15. Hitung subtotal setiap jadwalmain (durasi×tarif saat booking)dengan alias
subtotal,urutsubtotal terbesar.
SELECT no_booking,
       kode_lapangan,
       tgl_main,
       jam_mulai,
       durasi_jam,
       tarif_saat_booking,
       durasi_jam * tarif_saat_booking AS subtotal
FROM jadwal_main
ORDER BY subtotal DESC;

--16. Hitung jumlah member dan jumlah lapangan yang terdaftar,masing-masing dengan alias yang jelas.
SELECT (SELECT COUNT(*) FROM member) AS jumlah_member,(SELECT COUNT(*) FROM lapangan) AS jumlah_lapangan;

-- =====================================================
-- BAGIAN E: Membuktikan Constraint Bekerja
-- =====================================================
--E1.Masukkan member dengan id_member yang sudah dipakai,misalnya M01 lagi.
INSERT INTO member VALUES ('M01', 'Uji Ganda', '0800-0000-0000', 'R');

--E2.Membuktikan FOREIGN KEY bekerja
INSERT INTO booking VALUES ('BK-0999', '2026-10-01', 'M99', 'S1', NULL, 0, 'DP');

-- E3. Membuktikan CHECK constraint bekerja
INSERT INTO jadwal_main VALUES ('BK-0901', 'L2', '2026-09-20', '10:00', 0, 120000);