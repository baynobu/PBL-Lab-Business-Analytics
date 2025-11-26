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

CREATE TABLE public.admin (
    id integer NOT NULL,
    username character varying(50) NOT NULL,
    password character varying(255) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    nama_lengkap character varying(100)
);
ALTER TABLE public.admin OWNER TO postgres;

CREATE SEQUENCE public.admin_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
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

CREATE SEQUENCE public.berita_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
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

CREATE SEQUENCE public.dosen_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
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

CREATE SEQUENCE public.galeri_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
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

CREATE SEQUENCE public.jam_tidak_tersedia_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.jam_tidak_tersedia_id_seq OWNER TO postgres;
ALTER SEQUENCE public.jam_tidak_tersedia_id_seq OWNED BY public.jam_tidak_tersedia.id;

CREATE TABLE public.kategori (
    id integer NOT NULL,
    nama character varying(100) NOT NULL
);
ALTER TABLE public.kategori OWNER TO postgres;

CREATE SEQUENCE public.kategori_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
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

CREATE SEQUENCE public.kontak_lab_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
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

CREATE SEQUENCE public.log_aktivitas_admin_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
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

CREATE SEQUENCE public.peminjaman_lab_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
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

CREATE SEQUENCE public.profil_lab_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
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

CREATE SEQUENCE public.publikasi_dosen_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.publikasi_dosen_id_seq OWNER TO postgres;
ALTER SEQUENCE public.publikasi_dosen_id_seq OWNED BY public.publikasi_dosen.id;

CREATE SEQUENCE public.publikasi_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.publikasi_id_seq OWNER TO postgres;
ALTER SEQUENCE public.publikasi_id_seq OWNED BY public.publikasi.id;

CREATE TABLE public.publikasi_kategori (
    id integer NOT NULL,
    publikasi_id integer NOT NULL,
    kategori_id integer NOT NULL
);
ALTER TABLE public.publikasi_kategori OWNER TO postgres;

CREATE SEQUENCE public.publikasi_kategori_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.publikasi_kategori_id_seq OWNER TO postgres;
ALTER SEQUENCE public.publikasi_kategori_id_seq OWNED BY public.publikasi_kategori.id;

CREATE TABLE public.settings (
    id integer NOT NULL,
    key character varying(100) NOT NULL,
    value text NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
ALTER TABLE public.settings OWNER TO postgres;

CREATE SEQUENCE public.settings_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.settings_id_seq OWNER TO postgres;
ALTER SEQUENCE public.settings_id_seq OWNED BY public.settings.id;

CREATE TABLE public.site_settings (
    id integer NOT NULL,
    site_name character varying(100) DEFAULT 'Laboratorium Business Analytics'::character varying NOT NULL,
    logo character varying(255),
    footer_text character varying(255) DEFAULT 'Laboratorium Business Analytics - All Rights Reserved'::character varying,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    copyright_text text
);
ALTER TABLE public.site_settings OWNER TO postgres;

CREATE SEQUENCE public.site_settings_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.site_settings_id_seq OWNER TO postgres;
ALTER SEQUENCE public.site_settings_id_seq OWNED BY public.site_settings.id;

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

COPY public.admin (id, username, password, created_at, updated_at, nama_lengkap) FROM stdin;
1	admin	$2y$10$hiH0SuChynMIA8tFFdA/K.JeBbrYfezXZFjcHN5Z37vyeRrzcZUvK	2025-11-17 22:19:57.329151	2025-11-20 18:56:35.61357	administrator
\.

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

ALTER TABLE ONLY public.admin
    ADD CONSTRAINT admin_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.admin
    ADD CONSTRAINT admin_username_key UNIQUE (username);
ALTER TABLE ONLY public.berita
    ADD CONSTRAINT berita_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.dosen
    ADD CONSTRAINT dosen_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.galeri
    ADD CONSTRAINT galeri_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.jam_tidak_tersedia
    ADD CONSTRAINT jam_tidak_tersedia_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.kategori
    ADD CONSTRAINT kategori_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.kontak_lab
    ADD CONSTRAINT kontak_lab_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.log_aktivitas_admin
    ADD CONSTRAINT log_aktivitas_admin_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.peminjaman_lab
    ADD CONSTRAINT peminjaman_lab_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.profil_lab
    ADD CONSTRAINT profil_lab_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.publikasi_dosen
    ADD CONSTRAINT publikasi_dosen_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.publikasi_kategori
    ADD CONSTRAINT publikasi_kategori_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.publikasi
    ADD CONSTRAINT publikasi_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.settings
    ADD CONSTRAINT settings_key_key UNIQUE (key);
ALTER TABLE ONLY public.settings
    ADD CONSTRAINT settings_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.site_settings
    ADD CONSTRAINT site_settings_pkey PRIMARY KEY (id);

CREATE INDEX idx_pub_dosen_dosen ON public.publikasi_dosen USING btree (dosen_id);
CREATE INDEX idx_pub_dosen_pub ON public.publikasi_dosen USING btree (publikasi_id);
CREATE INDEX idx_pub_kategori_kategori ON public.publikasi_kategori USING btree (kategori_id);
CREATE INDEX idx_pub_kategori_pub ON public.publikasi_kategori USING btree (publikasi_id);

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