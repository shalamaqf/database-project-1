
-- create table for siswa
create table siswa
(
    id_siswa serial not null,
    nama_siswa varchar(100) not null,
    kelas varchar(5) not null,
    primary key (id_siswa)
);


-- create table for buku
create table buku
(
    id_buku serial not null,
    nama_buku varchar(100) not null,
    pengarang varchar(100) not null,
    stok_buku int not null,
    primary key (id_buku)
);


-- create status as enum type
create type status as enum('Dipinjam', 'Dikembalikan');


-- create table for peminjaman (relation one to many)
create table peminjaman
(
    id_peminjaman serial not null,
    id_siswa int not null,
    id_buku int not null,
    tanggal_pinjam TIMESTAMP not null default current_timestamp,
    status_peminjaman status default 'Dipinjam',
    constraint fk_siswa foreign key (id_siswa) REFERENCES siswa(id_siswa) on delete cascade,
    constraint fk_buku foreign key (id_buku) REFERENCES buku(id_buku),
    primary key(id_peminjaman)
);


-- create table for pengembalian (relation one to many)
create table pengembalian
(
    id_peminjaman int not null,
    tanggal_pengembalian TIMESTAMP not null default current_timestamp,
    constraint fk_peminjaman foreign key(id_peminjaman) REFERENCES peminjaman(id_peminjaman),
    primary key (id_peminjaman)
);

-- add check constraint in table buku, for check if stock is more or equal than 0
alter table buku
add constraint check_stok_buku check(stok_buku >= 0);


-- select query for every table
select * from siswa;
select * from buku;
select * from peminjaman;
select * from pengembalian;


-- insert some values to table siswa
insert into siswa(nama_siswa, kelas)
values('Anto', '7A'),
      ('Budi', '8B'),
      ('Chika', '9C'),
      ('Dennis', '7D'),
      ('Eko', '9A'),
      ('Fina', '8C');


-- insert some values to table buku
insert into buku(nama_buku, pengarang, stok_buku)
values('Cantik Itu Luka', 'Eka Kurniawan', 1),
      ('Ronggeng Dukuh Paruk', 'Ahmad Tohari', 3),
      ('Bumi Manusia', 'Pramoedya Ananta Noer', 2),
      ('Laut Bercerita', 'Leila Shalika Chudori', 1),
      ('Saman', 'Ayu Utami', 3),
      ('Laskar Pelangi', 'Andrea Hirata', 5),
      ('BUMI', 'Tere Liye', 2),
      ('Sitti Nurbaya', 'Marah Roesli', 2),
      ('HUJAN', 'Tere Liye', 1),
      ('Entrok', 'Okky Madasari', 3);


-- insert values to table peminjaman
insert into peminjaman(id_siswa, id_buku)
values(1, 3),
      (2, 1),
      (3, 2),
      (4, 3),
      (5, 2),
      (6, 10);


-- update stok_buku after using peminjaman relation
update buku
set stok_buku = stok_buku - 1
where id_buku = 3;

update buku
set stok_buku = stok_buku - 1
where id_buku = 1;

update buku
set stok_buku = stok_buku - 1
where id_buku = 2;

update buku
set stok_buku = stok_buku - 1
where id_buku = 3;

update buku
set stok_buku = stok_buku - 1
where id_buku = 2;

update buku
set stok_buku = stok_buku - 1
where id_buku = 10;


-- insert values to table pengembalian
insert into pengembalian(id_peminjaman)
values(1);

insert into pengembalian(id_peminjaman)
values(3),
      (6);


-- update status_peminjaman after using pengembalian relation
update peminjaman
set status_peminjaman = 'Dikembalikan'
where id_peminjaman in (1, 3, 6);


-- try to join query table siswa, buku, and pengembalian into peminjaman table
select siswa.nama_siswa, buku.nama_buku, pengembalian.tanggal_pengembalian, status_peminjaman
from peminjaman
join siswa on peminjaman.id_siswa = siswa.id_siswa
join buku on peminjaman.id_buku = buku.id_buku
join pengembalian on peminjaman.id_peminjaman = pengembalian.id_peminjaman;


-- try to left join query table siswa, buku, and pengembalian table into peminjaman table
-- WE USE LEFT JOIN IN THIS CASE --
select siswa.nama_siswa, buku.nama_buku, pengembalian.tanggal_pengembalian
from peminjaman
left join siswa on peminjaman.id_siswa = siswa.id_siswa
left join buku on peminjaman.id_buku = buku.id_buku
left join pengembalian on peminjaman.id_peminjaman = pengembalian.id_peminjaman;

