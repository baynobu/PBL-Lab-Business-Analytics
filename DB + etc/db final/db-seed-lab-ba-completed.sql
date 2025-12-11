SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA public;
COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';

SET default_tablespace = '';
SET default_table_access_method = heap;

-- SCHEMA
CREATE TABLE public.admin (
    id integer NOT NULL,
    username character varying(50) NOT NULL,
    password character varying(255) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    nama_lengkap character varying(100)
);
ALTER TABLE public.admin OWNER TO postgres;

CREATE SEQUENCE public.admin_id_seq AS integer START WITH 1 INCREMENT BY 1 NO MINVALUE NO MAXVALUE CACHE 1;
ALTER SEQUENCE public.admin_id_seq OWNER TO postgres;
ALTER SEQUENCE public.admin_id_seq OWNED BY public.admin.id;

CREATE TABLE public.berita (
    id integer NOT NULL,
    judul character varying(150) NOT NULL,
    isi text NOT NULL,
    gambar character varying(255),
    tanggal date DEFAULT CURRENT_DATE,
    penulis character varying(100) DEFAULT 'Admin'::character varying,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
ALTER TABLE public.berita OWNER TO postgres;

CREATE SEQUENCE public.berita_id_seq AS integer START WITH 1 INCREMENT BY 1 NO MINVALUE NO MAXVALUE CACHE 1;
ALTER SEQUENCE public.berita_id_seq OWNER TO postgres;
ALTER SEQUENCE public.berita_id_seq OWNED BY public.berita.id;

CREATE TABLE public.dosen (
    id integer NOT NULL,
    nama character varying(100) NOT NULL,
    keahlian character varying(150) NOT NULL,
    foto character varying(255),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
ALTER TABLE public.dosen OWNER TO postgres;

CREATE SEQUENCE public.dosen_id_seq AS integer START WITH 1 INCREMENT BY 1 NO MINVALUE NO MAXVALUE CACHE 1;
ALTER SEQUENCE public.dosen_id_seq OWNER TO postgres;
ALTER SEQUENCE public.dosen_id_seq OWNED BY public.dosen.id;

CREATE TABLE public.galeri (
    id integer NOT NULL,
    judul character varying(100) NOT NULL,
    deskripsi text,
    gambar character varying(255) NOT NULL,
    tanggal date NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
ALTER TABLE public.galeri OWNER TO postgres;

CREATE SEQUENCE public.galeri_id_seq AS integer START WITH 1 INCREMENT BY 1 NO MINVALUE NO MAXVALUE CACHE 1;
ALTER SEQUENCE public.galeri_id_seq OWNER TO postgres;
ALTER SEQUENCE public.galeri_id_seq OWNED BY public.galeri.id;

CREATE TABLE public.jam_tidak_tersedia (
    id integer NOT NULL,
    tanggal date NOT NULL,
    waktu_mulai time without time zone NOT NULL,
    waktu_selesai time without time zone NOT NULL,
    alasan text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
ALTER TABLE public.jam_tidak_tersedia OWNER TO postgres;

CREATE SEQUENCE public.jam_tidak_tersedia_id_seq AS integer START WITH 1 INCREMENT BY 1 NO MINVALUE NO MAXVALUE CACHE 1;
ALTER SEQUENCE public.jam_tidak_tersedia_id_seq OWNER TO postgres;
ALTER SEQUENCE public.jam_tidak_tersedia_id_seq OWNED BY public.jam_tidak_tersedia.id;

CREATE TABLE public.kategori (
    id integer NOT NULL,
    nama character varying(100) NOT NULL
);
ALTER TABLE public.kategori OWNER TO postgres;

CREATE SEQUENCE public.kategori_id_seq AS integer START WITH 1 INCREMENT BY 1 NO MINVALUE NO MAXVALUE CACHE 1;
ALTER SEQUENCE public.kategori_id_seq OWNER TO postgres;
ALTER SEQUENCE public.kategori_id_seq OWNED BY public.kategori.id;

CREATE TABLE public.kontak_lab (
    id integer NOT NULL,
    alamat text,
    email character varying(100),
    telepon character varying(30),
    website character varying(100),
    maps_embed text,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
ALTER TABLE public.kontak_lab OWNER TO postgres;

CREATE SEQUENCE public.kontak_lab_id_seq AS integer START WITH 1 INCREMENT BY 1 NO MINVALUE NO MAXVALUE CACHE 1;
ALTER SEQUENCE public.kontak_lab_id_seq OWNER TO postgres;
ALTER SEQUENCE public.kontak_lab_id_seq OWNED BY public.kontak_lab.id;

CREATE TABLE public.log_aktivitas_admin (
    id integer NOT NULL,
    admin_id integer,
    aktivitas text NOT NULL,
    waktu timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    ip_address character varying(45),
    user_agent text
);
ALTER TABLE public.log_aktivitas_admin OWNER TO postgres;

CREATE SEQUENCE public.log_aktivitas_admin_id_seq AS integer START WITH 1 INCREMENT BY 1 NO MINVALUE NO MAXVALUE CACHE 1;
ALTER SEQUENCE public.log_aktivitas_admin_id_seq OWNER TO postgres;
ALTER SEQUENCE public.log_aktivitas_admin_id_seq OWNED BY public.log_aktivitas_admin.id;

CREATE TABLE public.peminjaman_lab (
    id integer NOT NULL,
    nama_peminjam character varying(100) NOT NULL,
    nip character varying(20) NOT NULL,
    tanggal_mulai date NOT NULL,
    tanggal_selesai date,
    waktu_mulai time without time zone,
    waktu_selesai time without time zone,
    keperluan text NOT NULL,
    status character varying(20) DEFAULT 'menunggu'::character varying NOT NULL,
    admin_id integer,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
ALTER TABLE public.peminjaman_lab OWNER TO postgres;

CREATE SEQUENCE public.peminjaman_lab_id_seq AS integer START WITH 1 INCREMENT BY 1 NO MINVALUE NO MAXVALUE CACHE 1;
ALTER SEQUENCE public.peminjaman_lab_id_seq OWNER TO postgres;
ALTER SEQUENCE public.peminjaman_lab_id_seq OWNED BY public.peminjaman_lab.id;

CREATE TABLE public.profil_lab (
    id integer NOT NULL,
    kategori character varying(50) NOT NULL,
    judul character varying(100),
    isi text NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
ALTER TABLE public.profil_lab OWNER TO postgres;

CREATE SEQUENCE public.profil_lab_id_seq AS integer START WITH 1 INCREMENT BY 1 NO MINVALUE NO MAXVALUE CACHE 1;
ALTER SEQUENCE public.profil_lab_id_seq OWNER TO postgres;
ALTER SEQUENCE public.profil_lab_id_seq OWNED BY public.profil_lab.id;

CREATE TABLE public.publikasi (
    id integer NOT NULL,
    judul character varying(255) NOT NULL,
    tanggal date,
    file character varying(255),
    link character varying(255),
    deskripsi text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
ALTER TABLE public.publikasi OWNER TO postgres;

CREATE TABLE public.publikasi_dosen (
    id integer NOT NULL,
    publikasi_id integer NOT NULL,
    dosen_id integer NOT NULL
);
ALTER TABLE public.publikasi_dosen OWNER TO postgres;

CREATE SEQUENCE public.publikasi_dosen_id_seq AS integer START WITH 1 INCREMENT BY 1 NO MINVALUE NO MAXVALUE CACHE 1;
ALTER SEQUENCE public.publikasi_dosen_id_seq OWNER TO postgres;
ALTER SEQUENCE public.publikasi_dosen_id_seq OWNED BY public.publikasi_dosen.id;

CREATE SEQUENCE public.publikasi_id_seq AS integer START WITH 1 INCREMENT BY 1 NO MINVALUE NO MAXVALUE CACHE 1;
ALTER SEQUENCE public.publikasi_id_seq OWNER TO postgres;
ALTER SEQUENCE public.publikasi_id_seq OWNED BY public.publikasi.id;

CREATE TABLE public.publikasi_kategori (
    id integer NOT NULL,
    publikasi_id integer NOT NULL,
    kategori_id integer NOT NULL
);
ALTER TABLE public.publikasi_kategori OWNER TO postgres;

CREATE SEQUENCE public.publikasi_kategori_id_seq AS integer START WITH 1 INCREMENT BY 1 NO MINVALUE NO MAXVALUE CACHE 1;
ALTER SEQUENCE public.publikasi_kategori_id_seq OWNER TO postgres;
ALTER SEQUENCE public.publikasi_kategori_id_seq OWNED BY public.publikasi_kategori.id;

CREATE TABLE public.settings (
    id integer NOT NULL,
    key character varying(100) NOT NULL,
    value text NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
ALTER TABLE public.settings OWNER TO postgres;

CREATE SEQUENCE public.settings_id_seq AS integer START WITH 1 INCREMENT BY 1 NO MINVALUE NO MAXVALUE CACHE 1;
ALTER SEQUENCE public.settings_id_seq OWNER TO postgres;
ALTER SEQUENCE public.settings_id_seq OWNED BY public.settings.id;

-- UPDATED: site_settings with new columns logo_polinema and logo_jti
CREATE TABLE public.site_settings (
    id integer NOT NULL,
    site_name character varying(100) DEFAULT 'Laboratorium Business Analytics'::character varying NOT NULL,
    logo character varying(255),
    footer_text character varying(255) DEFAULT 'Laboratorium Business Analytics - All Rights Reserved'::character varying,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    copyright_text text,
    logo_polinema character varying(255),
    logo_jti character varying(255),
    social_facebook text,
    social_instagram text,
    social_youtube text
);
ALTER TABLE public.site_settings OWNER TO postgres;

CREATE SEQUENCE public.site_settings_id_seq AS integer START WITH 1 INCREMENT BY 1 NO MINVALUE NO MAXVALUE CACHE 1;
ALTER SEQUENCE public.site_settings_id_seq OWNER TO postgres;
ALTER SEQUENCE public.site_settings_id_seq OWNED BY public.site_settings.id;

-- DEFAULTS
ALTER TABLE ONLY public.admin ALTER COLUMN id SET DEFAULT nextval('public.admin_id_seq'::regclass);
ALTER TABLE ONLY public.berita ALTER COLUMN id SET DEFAULT nextval('public.berita_id_seq'::regclass);
ALTER TABLE ONLY public.dosen ALTER COLUMN id SET DEFAULT nextval('public.dosen_id_seq'::regclass);
ALTER TABLE ONLY public.galeri ALTER COLUMN id SET DEFAULT nextval('public.galeri_id_seq'::regclass);
ALTER TABLE ONLY public.jam_tidak_tersedia ALTER COLUMN id SET DEFAULT nextval('public.jam_tidak_tersedia_id_seq'::regclass);
ALTER TABLE ONLY public.kategori ALTER COLUMN id SET DEFAULT nextval('public.kategori_id_seq'::regclass);
ALTER TABLE ONLY public.kontak_lab ALTER COLUMN id SET DEFAULT nextval('public.kontak_lab_id_seq'::regclass);
ALTER TABLE ONLY public.log_aktivitas_admin ALTER COLUMN id SET DEFAULT nextval('public.log_aktivitas_admin_id_seq'::regclass);
ALTER TABLE ONLY public.peminjaman_lab ALTER COLUMN id SET DEFAULT nextval('public.peminjaman_lab_id_seq'::regclass);
ALTER TABLE ONLY public.profil_lab ALTER COLUMN id SET DEFAULT nextval('public.profil_lab_id_seq'::regclass);
ALTER TABLE ONLY public.publikasi ALTER COLUMN id SET DEFAULT nextval('public.publikasi_id_seq'::regclass);
ALTER TABLE ONLY public.publikasi_dosen ALTER COLUMN id SET DEFAULT nextval('public.publikasi_dosen_id_seq'::regclass);
ALTER TABLE ONLY public.publikasi_kategori ALTER COLUMN id SET DEFAULT nextval('public.publikasi_kategori_id_seq'::regclass);
ALTER TABLE ONLY public.settings ALTER COLUMN id SET DEFAULT nextval('public.settings_id_seq'::regclass);
ALTER TABLE ONLY public.site_settings ALTER COLUMN id SET DEFAULT nextval('public.site_settings_id_seq'::regclass);

-- DATA COPY (admin per dump asli)
COPY public.admin (id, username, password, created_at, updated_at, nama_lengkap) FROM stdin;
1	admin	$2y$10$hiH0SuChynMIA8tFFdA/K.JeBbrYfezXZFjcHN5Z37vyeRrzcZUvK	2025-11-17 22:19:57.329151	2025-11-20 18:56:35.61357	administrator
\.

-- SEQUENCE SETVAL PER DUMP ASLI
SELECT pg_catalog.setval('public.admin_id_seq', 8, true);
SELECT pg_catalog.setval('public.berita_id_seq', 5, true);
SELECT pg_catalog.setval('public.dosen_id_seq', 14, true);
SELECT pg_catalog.setval('public.galeri_id_seq', 18, true);
SELECT pg_catalog.setval('public.jam_tidak_tersedia_id_seq', 12, true);
SELECT pg_catalog.setval('public.kategori_id_seq', 6, true);
SELECT pg_catalog.setval('public.kontak_lab_id_seq', 2, true);
SELECT pg_catalog.setval('public.log_aktivitas_admin_id_seq', 258, true);
SELECT pg_catalog.setval('public.peminjaman_lab_id_seq', 57, true);
SELECT pg_catalog.setval('public.profil_lab_id_seq', 12, true);
SELECT pg_catalog.setval('public.publikasi_dosen_id_seq', 17, true);
SELECT pg_catalog.setval('public.publikasi_id_seq', 6, true);
SELECT pg_catalog.setval('public.publikasi_kategori_id_seq', 32, true);
SELECT pg_catalog.setval('public.settings_id_seq', 1, false);
SELECT pg_catalog.setval('public.site_settings_id_seq', 3, true);

-- CONSTRAINTS
ALTER TABLE ONLY public.admin ADD CONSTRAINT admin_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.admin ADD CONSTRAINT admin_username_key UNIQUE (username);
ALTER TABLE ONLY public.berita ADD CONSTRAINT berita_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.dosen ADD CONSTRAINT dosen_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.galeri ADD CONSTRAINT galeri_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.jam_tidak_tersedia ADD CONSTRAINT jam_tidak_tersedia_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.kategori ADD CONSTRAINT kategori_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.kontak_lab ADD CONSTRAINT kontak_lab_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.log_aktivitas_admin ADD CONSTRAINT log_aktivitas_admin_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.peminjaman_lab ADD CONSTRAINT peminjaman_lab_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.profil_lab ADD CONSTRAINT profil_lab_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.publikasi_dosen ADD CONSTRAINT publikasi_dosen_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.publikasi_kategori ADD CONSTRAINT publikasi_kategori_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.publikasi ADD CONSTRAINT publikasi_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.settings ADD CONSTRAINT settings_key_key UNIQUE (key);
ALTER TABLE ONLY public.settings ADD CONSTRAINT settings_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.site_settings ADD CONSTRAINT site_settings_pkey PRIMARY KEY (id);

-- INDEXES
CREATE INDEX idx_pub_dosen_dosen ON public.publikasi_dosen USING btree (dosen_id);
CREATE INDEX idx_pub_dosen_pub ON public.publikasi_dosen USING btree (publikasi_id);
CREATE INDEX idx_pub_kategori_kategori ON public.publikasi_kategori USING btree (kategori_id);
CREATE INDEX idx_pub_kategori_pub ON public.publikasi_kategori USING btree (publikasi_id);

-- FOREIGN KEYS
ALTER TABLE ONLY public.log_aktivitas_admin
    ADD CONSTRAINT log_aktivitas_admin_admin_id_fkey FOREIGN KEY (admin_id) REFERENCES public.admin(id) ON DELETE CASCADE;
ALTER TABLE ONLY public.peminjaman_lab
    ADD CONSTRAINT peminjaman_lab_admin_id_fkey FOREIGN KEY (admin_id) REFERENCES public.admin(id) ON DELETE SET NULL;
ALTER TABLE ONLY public.publikasi_dosen
    ADD CONSTRAINT publikasi_dosen_dosen_id_fkey FOREIGN KEY (dosen_id) REFERENCES public.dosen(id) ON DELETE CASCADE;
ALTER TABLE ONLY public.publikasi_dosen
    ADD CONSTRAINT publikasi_dosen_publikasi_id_fkey FOREIGN KEY (publikasi_id) REFERENCES public.publikasi(id) ON DELETE CASCADE;
ALTER TABLE ONLY public.publikasi_kategori
    ADD CONSTRAINT publikasi_kategori_kategori_id_fkey FOREIGN KEY (kategori_id) REFERENCES public.kategori(id) ON DELETE CASCADE;
ALTER TABLE ONLY public.publikasi_kategori
    ADD CONSTRAINT publikasi_kategori_publikasi_id_fkey FOREIGN KEY (publikasi_id) REFERENCES public.publikasi(id) ON DELETE CASCADE;

-- SEED DATA TAMBAHAN
-- 2. KATEGORI
INSERT INTO public.kategori (id, nama) VALUES
  (1, 'Data Mining'),
  (2, 'Machine Learning'),
  (3, 'Business Intelligence');

-- 3. DOSEN
INSERT INTO public.dosen (id, nama, keahlian, foto, created_at, updated_at) VALUES
  (1, 'Dr. Andi Pratama', 'Machine Learning, Predictive Analytics', 'andi.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  (2, 'Dr. Sari Lestari', 'Business Intelligence, Data Warehouse', 'sari.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  (3, 'Ir. Budi Santoso', 'Data Visualization, Dashboarding', 'budi.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 4. PROFIL LAB
INSERT INTO public.profil_lab (id, kategori, judul, isi, created_at, updated_at) VALUES
  (1, 'Visi', 'Visi Laboratorium', 'Menjadi pusat unggulan analitik bisnis.', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  (2, 'Misi', 'Misi Laboratorium', 'Mendukung penelitian dan pembelajaran berbasis data.', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  (3, 'Fasilitas', 'Fasilitas Utama', 'Ruang kolaborasi, workstation high-performance, dataset internal.', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 5. SITE SETTINGS (dengan logo_polinema & logo_jti)
INSERT INTO public.site_settings (id, site_name, logo, footer_text, copyright_text, logo_polinema, logo_jti, social_facebook, social_instagram, social_youtube, updated_at)
VALUES (1, 'Laboratorium Business Analytics', 'logo.png',
        'Laboratorium Business Analytics - All Rights Reserved',
        '© 2025 Laboratorium Business Analytics',
        'logo-polinema.png',
        'logo-jti.png',
        'https://facebook.com/',
        'https://instagram.com/',
        'https://youtube.com/',
        CURRENT_TIMESTAMP);

-- 6. SETTINGS (key unik)
INSERT INTO public.settings (id, key, value, updated_at) VALUES
  (1, 'maintenance_mode', 'off', CURRENT_TIMESTAMP),
  (2, 'max_booking_days', '30', CURRENT_TIMESTAMP),
  (3, 'contact_email', 'lab@univ.ac.id', CURRENT_TIMESTAMP);

-- 7. KONTAK LAB
INSERT INTO public.kontak_lab (id, alamat, email, telepon, website, maps_embed, updated_at) VALUES
  (1, 'Jl. Kampus No. 1', 'lab@univ.ac.id', '+62-811-0000', 'https://lab-analytics.univ.ac.id',
   '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d2848.4658695213698!2d112.61598334130734!3d-7.945183846678682!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x2dd629dfd58aaf95%3A0xe72a182dfd18e01c!2sCivil%20Engineering%20and%20Information%20Technology%20Building%2C%20POLINEMA!5e0!3m2!1sen!2sid!4v1764169895576!5m2!1sen!2sid" width="600" height="450" style="border:0;" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>',
   CURRENT_TIMESTAMP);

-- 8. BERITA
INSERT INTO public.berita (id, judul, isi, gambar, tanggal, penulis, created_at, updated_at) VALUES
  (1, 'Peluncuran Program Riset Baru', 'Laboratorium meluncurkan program riset analitik bisnis.', 'berita1.jpg', CURRENT_DATE, 'Admin', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  (2, 'Workshop Data Mining', 'Workshop internal mengenai teknik clustering dan classification.', 'berita2.jpg', CURRENT_DATE, 'Admin', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 9. GALERI
INSERT INTO public.galeri (id, judul, deskripsi, gambar, tanggal, created_at, updated_at) VALUES
  (1, 'Workshop ML', 'Kegiatan workshop machine learning.', 'galeri1.jpg', CURRENT_DATE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  (2, 'Sesi Kolaborasi', 'Diskusi proyek analitik.', 'galeri2.jpg', CURRENT_DATE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 10. PEMINJAMAN LAB
INSERT INTO public.peminjaman_lab (id, nama_peminjam, nip, tanggal_mulai, tanggal_selesai, waktu_mulai, waktu_selesai, keperluan, status, admin_id, created_at, updated_at) VALUES
  (1, 'Dosen Tamu', '19781212', CURRENT_DATE + INTERVAL '2 day', CURRENT_DATE + INTERVAL '2 day', '09:00', '12:00', 'Kuliah tamu', 'menunggu', NULL, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  (2, 'Tim Riset A', '19800101', CURRENT_DATE + INTERVAL '5 day', CURRENT_DATE + INTERVAL '5 day', '13:00', '16:00', 'Analisis dataset internal', 'disetujui', 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 11. JAM TIDAK TERSEDIA
INSERT INTO public.jam_tidak_tersedia (id, tanggal, waktu_mulai, waktu_selesai, alasan, created_at) VALUES
  (1, CURRENT_DATE + INTERVAL '2 day', '08:00', '09:00', 'Persiapan ruangan', CURRENT_TIMESTAMP),
  (2, CURRENT_DATE + INTERVAL '5 day', '12:00', '13:00', 'Pembersihan perangkat', CURRENT_TIMESTAMP);

-- 12. PUBLIKASI
INSERT INTO public.publikasi (id, judul, tanggal, file, link, deskripsi, created_at) VALUES
  (1, 'Analisis Tren Penjualan', CURRENT_DATE - INTERVAL '30 day', 'tren_penjualan.pdf', 'https://repo.univ/publikasi/1', 'Studi regresi multi variabel.', CURRENT_TIMESTAMP),
  (2, 'Optimasi Inventori', CURRENT_DATE - INTERVAL '15 day', 'inventori_optimasi.pdf', 'https://repo.univ/publikasi/2', 'Model pengurangan biaya penyimpanan.', CURRENT_TIMESTAMP);

-- 13. PUBLIKASI_DOSEN
INSERT INTO public.publikasi_dosen (id, publikasi_id, dosen_id) VALUES
  (1, 1, 1),
  (2, 1, 2),
  (3, 2, 2),
  (4, 2, 3);

-- 14. PUBLIKASI_KATEGORI
INSERT INTO public.publikasi_kategori (id, publikasi_id, kategori_id) VALUES
  (1, 1, 2),
  (2, 1, 3),
  (3, 2, 1);

-- 15. LOG AKTIVITAS ADMIN
INSERT INTO public.log_aktivitas_admin (id, admin_id, aktivitas, ip_address, user_agent, waktu) VALUES
  (1, 1, 'Login berhasil', '127.0.0.1', 'Mozilla/5.0', CURRENT_TIMESTAMP),
  (2, 1, 'Menyetujui peminjaman ID 2', '127.0.0.1', 'Mozilla/5.0', CURRENT_TIMESTAMP);

-- ADJUST SEQUENCES TO MAX SEEDED IDs
SELECT setval('public.admin_id_seq', 8, true);
SELECT setval('public.kategori_id_seq', 3, true);
SELECT setval('public.dosen_id_seq', 3, true);
SELECT setval('public.profil_lab_id_seq', 3, true);
SELECT setval('public.site_settings_id_seq', 1, true);
SELECT setval('public.settings_id_seq', 3, true);
SELECT setval('public.kontak_lab_id_seq', 1, true);
SELECT setval('public.berita_id_seq', 2, true);
SELECT setval('public.galeri_id_seq', 2, true);
SELECT setval('public.peminjaman_lab_id_seq', 2, true);
SELECT setval('public.jam_tidak_tersedia_id_seq', 2, true);
SELECT setval('public.publikasi_id_seq', 2, true);
SELECT setval('public.publikasi_dosen_id_seq', 4, true);
SELECT setval('public.publikasi_kategori_id_seq', 3, true);
SELECT setval('public.log_aktivitas_admin_id_seq', 2, true);

-- VIEWS AND STORED PROCEDURES (compatible with current schema)

-- View: Jadwal Peminjaman
CREATE OR REPLACE VIEW public.view_jadwal_peminjaman AS
SELECT 
    p.id,
    p.nama_peminjam,
    p.nip,
    p.tanggal_mulai,
    p.tanggal_selesai,
    p.waktu_mulai,
    p.waktu_selesai,
    p.keperluan,
    p.status,
    COALESCE(a.nama_lengkap, a.username) AS admin_nama,
    p.created_at
FROM public.peminjaman_lab p
LEFT JOIN public.admin a ON p.admin_id = a.id;

-- View: Publikasi Lengkap
CREATE OR REPLACE VIEW public.view_publikasi_lengkap AS
SELECT 
    pub.id AS publikasi_id,
    pub.judul,
    pub.tanggal,
    pub.file,
    pub.link,
    kat.nama AS kategori,
    STRING_AGG(DISTINCT d.nama, ', ' ORDER BY d.nama) AS daftar_dosen
FROM public.publikasi pub
JOIN public.publikasi_kategori pk ON pk.publikasi_id = pub.id
JOIN public.kategori kat ON kat.id = pk.kategori_id
JOIN public.publikasi_dosen pd ON pd.publikasi_id = pub.id
JOIN public.dosen d ON d.id = pd.dosen_id
GROUP BY pub.id, pub.judul, pub.tanggal, pub.file, pub.link, kat.nama;

-- Procedure: Tambah Peminjaman (validation + conflict checks)
CREATE OR REPLACE FUNCTION public.tambah_peminjaman(
    p_nama VARCHAR,
    p_nip VARCHAR,
    p_tanggal DATE,
    p_mulai TIME,
    p_selesai TIME,
    p_keperluan TEXT
)
RETURNS TEXT AS $$
DECLARE
    bentrok INTEGER;
BEGIN
    IF p_mulai >= p_selesai THEN
        RETURN 'GAGAL: Waktu mulai harus lebih kecil dari waktu selesai.';
    END IF;

    SELECT COUNT(*) INTO bentrok
    FROM public.peminjaman_lab
    WHERE tanggal_mulai = p_tanggal
      AND status = 'disetujui'
      AND (p_mulai < waktu_selesai AND p_selesai > waktu_mulai);

    IF bentrok > 0 THEN
        RETURN 'GAGAL: Waktu bentrok dengan peminjaman lain yang sudah disetujui.';
    END IF;

    SELECT COUNT(*) INTO bentrok
    FROM public.jam_tidak_tersedia j
    WHERE j.tanggal = p_tanggal
      AND (p_mulai < j.waktu_selesai AND p_selesai > j.waktu_mulai);

    IF bentrok > 0 THEN
        RETURN 'GAGAL: Waktu berada pada periode jam tidak tersedia.';
    END IF;

    INSERT INTO public.peminjaman_lab(
        nama_peminjam, nip, tanggal_mulai, waktu_mulai, waktu_selesai, keperluan
    )
    VALUES (p_nama, p_nip, p_tanggal, p_mulai, p_selesai, p_keperluan);

    RETURN 'OK';
END;
$$ LANGUAGE plpgsql;

-- Procedure: Set Jam Tidak Tersedia
CREATE OR REPLACE FUNCTION public.set_jam_tidak_tersedia(
    p_tanggal DATE,
    p_mulai TIME,
    p_selesai TIME,
    p_alasan TEXT DEFAULT 'Tidak Tersedia'
)
RETURNS VOID AS $$
BEGIN
    INSERT INTO public.jam_tidak_tersedia(tanggal, waktu_mulai, waktu_selesai, alasan)
    VALUES (p_tanggal, p_mulai, p_selesai, p_alasan);
END;
$$ LANGUAGE plpgsql;

-- Procedure: Tambah Publikasi + Relasi
CREATE OR REPLACE FUNCTION public.tambah_publikasi(
    p_judul VARCHAR,
    p_tanggal DATE,
    p_file VARCHAR,
    p_link VARCHAR,
    p_kategori INTEGER[],
    p_dosen INTEGER[]
)
RETURNS VOID AS $$
DECLARE
    pub_id INTEGER;
    k INTEGER;
    d INTEGER;
BEGIN
    INSERT INTO public.publikasi(judul, tanggal, file, link)
    VALUES (p_judul, p_tanggal, p_file, p_link)
    RETURNING id INTO pub_id;

    FOREACH k IN ARRAY p_kategori LOOP
        INSERT INTO public.publikasi_kategori(publikasi_id, kategori_id)
        VALUES (pub_id, k);
    END LOOP;

    FOREACH d IN ARRAY p_dosen LOOP
        INSERT INTO public.publikasi_dosen(publikasi_id, dosen_id)
        VALUES (pub_id, d);
    END LOOP;
END;
$$ LANGUAGE plpgsql;