--
-- PostgreSQL database dump
--

\restrict LjGIXwxJhwjVmHmZU166ZKCbbvUCXF0bNyQAyZucnbyELxfuC8fAmpdQ9GMBuHM

-- Dumped from database version 15.3
-- Dumped by pg_dump version 17.6

-- Started on 2025-11-17 22:51:56

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

--
-- TOC entry 2 (class 3079 OID 37648)
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA public;


--
-- TOC entry 3465 (class 0 OID 0)
-- Dependencies: 2
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 215 (class 1259 OID 37685)
-- Name: admin; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.admin (
    id integer NOT NULL,
    username character varying(50) NOT NULL,
    password character varying(255) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    nama_lengkap character varying(100)
);


ALTER TABLE public.admin OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 37690)
-- Name: admin_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.admin_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.admin_id_seq OWNER TO postgres;

--
-- TOC entry 3466 (class 0 OID 0)
-- Dependencies: 216
-- Name: admin_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.admin_id_seq OWNED BY public.admin.id;


--
-- TOC entry 217 (class 1259 OID 37691)
-- Name: dosen; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dosen (
    id integer NOT NULL,
    nama character varying(100) NOT NULL,
    keahlian character varying(150) NOT NULL,
    foto character varying(255),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.dosen OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 37698)
-- Name: dosen_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.dosen_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.dosen_id_seq OWNER TO postgres;

--
-- TOC entry 3467 (class 0 OID 0)
-- Dependencies: 218
-- Name: dosen_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.dosen_id_seq OWNED BY public.dosen.id;


--
-- TOC entry 219 (class 1259 OID 37699)
-- Name: galeri; Type: TABLE; Schema: public; Owner: postgres
--

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

--
-- TOC entry 220 (class 1259 OID 37706)
-- Name: galeri_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.galeri_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.galeri_id_seq OWNER TO postgres;

--
-- TOC entry 3468 (class 0 OID 0)
-- Dependencies: 220
-- Name: galeri_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.galeri_id_seq OWNED BY public.galeri.id;


--
-- TOC entry 221 (class 1259 OID 37707)
-- Name: kontak_lab; Type: TABLE; Schema: public; Owner: postgres
--

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

--
-- TOC entry 222 (class 1259 OID 37713)
-- Name: kontak_lab_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.kontak_lab_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.kontak_lab_id_seq OWNER TO postgres;

--
-- TOC entry 3469 (class 0 OID 0)
-- Dependencies: 222
-- Name: kontak_lab_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.kontak_lab_id_seq OWNED BY public.kontak_lab.id;


--
-- TOC entry 223 (class 1259 OID 37714)
-- Name: log_aktivitas_admin; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.log_aktivitas_admin (
    id integer NOT NULL,
    admin_id integer,
    aktivitas text NOT NULL,
    waktu timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    ip_address character varying(45),
    user_agent text
);


ALTER TABLE public.log_aktivitas_admin OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 37720)
-- Name: log_aktivitas_admin_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.log_aktivitas_admin_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.log_aktivitas_admin_id_seq OWNER TO postgres;

--
-- TOC entry 3470 (class 0 OID 0)
-- Dependencies: 224
-- Name: log_aktivitas_admin_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.log_aktivitas_admin_id_seq OWNED BY public.log_aktivitas_admin.id;


--
-- TOC entry 225 (class 1259 OID 37721)
-- Name: peminjaman_lab; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.peminjaman_lab (
    id integer NOT NULL,
    nama_peminjam character varying(100) NOT NULL,
    nim character varying(20) NOT NULL,
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

--
-- TOC entry 226 (class 1259 OID 37729)
-- Name: peminjaman_lab_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.peminjaman_lab_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.peminjaman_lab_id_seq OWNER TO postgres;

--
-- TOC entry 3471 (class 0 OID 0)
-- Dependencies: 226
-- Name: peminjaman_lab_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.peminjaman_lab_id_seq OWNED BY public.peminjaman_lab.id;


--
-- TOC entry 227 (class 1259 OID 37730)
-- Name: profil_lab; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.profil_lab (
    id integer NOT NULL,
    kategori character varying(50) NOT NULL,
    judul character varying(100),
    isi text NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.profil_lab OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 37737)
-- Name: profil_lab_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.profil_lab_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.profil_lab_id_seq OWNER TO postgres;

--
-- TOC entry 3472 (class 0 OID 0)
-- Dependencies: 228
-- Name: profil_lab_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.profil_lab_id_seq OWNED BY public.profil_lab.id;


--
-- TOC entry 229 (class 1259 OID 37738)
-- Name: settings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.settings (
    id integer NOT NULL,
    key character varying(100) NOT NULL,
    value text NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.settings OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 37744)
-- Name: settings_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.settings_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.settings_id_seq OWNER TO postgres;

--
-- TOC entry 3473 (class 0 OID 0)
-- Dependencies: 230
-- Name: settings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.settings_id_seq OWNED BY public.settings.id;


--
-- TOC entry 231 (class 1259 OID 37745)
-- Name: site_settings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.site_settings (
    id integer NOT NULL,
    site_name character varying(100) DEFAULT 'Laboratorium Business Analytics'::character varying NOT NULL,
    logo character varying(255),
    footer_text character varying(255) DEFAULT 'Laboratorium Business Analytics - All Rights Reserved'::character varying,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    copyright_text text
);


ALTER TABLE public.site_settings OWNER TO postgres;

--
-- TOC entry 232 (class 1259 OID 37753)
-- Name: site_settings_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.site_settings_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.site_settings_id_seq OWNER TO postgres;

--
-- TOC entry 3474 (class 0 OID 0)
-- Dependencies: 232
-- Name: site_settings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.site_settings_id_seq OWNED BY public.site_settings.id;


--
-- TOC entry 3250 (class 2604 OID 37754)
-- Name: admin id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admin ALTER COLUMN id SET DEFAULT nextval('public.admin_id_seq'::regclass);


--
-- TOC entry 3253 (class 2604 OID 37755)
-- Name: dosen id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dosen ALTER COLUMN id SET DEFAULT nextval('public.dosen_id_seq'::regclass);


--
-- TOC entry 3256 (class 2604 OID 37756)
-- Name: galeri id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.galeri ALTER COLUMN id SET DEFAULT nextval('public.galeri_id_seq'::regclass);


--
-- TOC entry 3259 (class 2604 OID 37757)
-- Name: kontak_lab id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kontak_lab ALTER COLUMN id SET DEFAULT nextval('public.kontak_lab_id_seq'::regclass);


--
-- TOC entry 3261 (class 2604 OID 37758)
-- Name: log_aktivitas_admin id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.log_aktivitas_admin ALTER COLUMN id SET DEFAULT nextval('public.log_aktivitas_admin_id_seq'::regclass);


--
-- TOC entry 3263 (class 2604 OID 37759)
-- Name: peminjaman_lab id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.peminjaman_lab ALTER COLUMN id SET DEFAULT nextval('public.peminjaman_lab_id_seq'::regclass);


--
-- TOC entry 3267 (class 2604 OID 37760)
-- Name: profil_lab id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.profil_lab ALTER COLUMN id SET DEFAULT nextval('public.profil_lab_id_seq'::regclass);


--
-- TOC entry 3270 (class 2604 OID 37761)
-- Name: settings id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.settings ALTER COLUMN id SET DEFAULT nextval('public.settings_id_seq'::regclass);


--
-- TOC entry 3272 (class 2604 OID 37762)
-- Name: site_settings id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.site_settings ALTER COLUMN id SET DEFAULT nextval('public.site_settings_id_seq'::regclass);


--
-- TOC entry 3442 (class 0 OID 37685)
-- Dependencies: 215
-- Data for Name: admin; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.admin (id, username, password, created_at, updated_at, nama_lengkap) FROM stdin;
4	admin	$2y$10$hiH0SuChynMIA8tFFdA/K.JeBbrYfezXZFjcHN5Z37vyeRrzcZUvK	2025-11-17 22:19:57.329151	2025-11-17 22:19:57.329151	administrator
\.


--
-- TOC entry 3444 (class 0 OID 37691)
-- Dependencies: 217
-- Data for Name: dosen; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dosen (id, nama, keahlian, foto, created_at, updated_at) FROM stdin;
5	Dr. Farid Angga Pribadi	Business Analytics, Machine Learning	farid.jpg	2025-11-17 22:15:29.71911	2025-11-17 22:15:29.71911
\.


--
-- TOC entry 3446 (class 0 OID 37699)
-- Dependencies: 219
-- Data for Name: galeri; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.galeri (id, judul, deskripsi, gambar, tanggal, created_at, updated_at) FROM stdin;
10	Workshop Data Analytics	Pelatihan analisis data bersama mahasiswa TI.	pexels-divinetechygirl-1181396.jpg	2025-01-10	2025-11-17 22:15:29.71911	2025-11-17 22:15:29.71911
12	Workshop Pengolahan Data dengan Python	Pelatihan intensif mengenai penggunaan Python untuk analisis data dasar hingga menengah.	pexels-fauxels-3183183.jpg	2025-01-10	2025-11-17 22:31:52.771979	2025-11-17 22:31:52.771979
13	Kuliah Tamu: Business Intelligence Modern	Kegiatan kuliah tamu bersama praktisi industri mengenai penerapan Business Intelligence dalam perusahaan modern.	pexels-fauxels-3183186.jpg	2025-02-05	2025-11-17 22:31:52.771979	2025-11-17 22:31:52.771979
14	Pelatihan Dashboard Menggunakan Power BI	Mahasiswa belajar membuat dashboard interaktif menggunakan Microsoft Power BI.	pexels-icsa-833425-1709003.jpg	2025-03-12	2025-11-17 22:31:52.771979	2025-11-17 22:31:52.771979
15	Kegiatan Riset Analitik Data Sosial Media	Tim lab melakukan penelitian mengenai analisis sentimen media sosial menggunakan teknik NLP.	pexels-pixabay-416405.jpg	2025-04-14	2025-11-17 22:31:52.771979	2025-11-17 22:31:52.771979
\.


--
-- TOC entry 3448 (class 0 OID 37707)
-- Dependencies: 221
-- Data for Name: kontak_lab; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.kontak_lab (id, alamat, email, telepon, website, maps_embed, updated_at) FROM stdin;
2	Jl. Soekarno Hatta No. 9 Malang, Politeknik Negeri Malang	lab.ba@polinema.ac.id	081234567890	https://polinema.ac.id	<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d246.97072187996525!2d112.6146365458301!3d-7.943892236221397!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x2dd629dfd58aaf95%3A0xe72a182dfd18e01c!2sCivil%20Engineering%20and%20Information%20Technology%20Building%2C%20POLINEMA!5e0!3m2!1sen!2sid!4v1763392281012!5m2!1sen!2sid" width="600" height="450" style="border:0;" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>	2025-11-17 22:50:23.476193
\.


--
-- TOC entry 3450 (class 0 OID 37714)
-- Dependencies: 223
-- Data for Name: log_aktivitas_admin; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.log_aktivitas_admin (id, admin_id, aktivitas, waktu, ip_address, user_agent) FROM stdin;
\.


--
-- TOC entry 3452 (class 0 OID 37721)
-- Dependencies: 225
-- Data for Name: peminjaman_lab; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.peminjaman_lab (id, nama_peminjam, nim, tanggal_mulai, tanggal_selesai, waktu_mulai, waktu_selesai, keperluan, status, admin_id, created_at, updated_at) FROM stdin;
18	Abdul Rahman Hanif	2341720010	2025-11-20	\N	09:00:00	11:00:00	Penggunaan Lab untuk Uji Coba Program	menunggu	\N	2025-11-17 22:47:07.41296	2025-11-17 22:47:07.41296
19	Zahra Nur Aisyah	2341720044	2025-11-21	\N	10:00:00	12:00:00	Presentasi Proyek Mata Kuliah BA	disetujui	\N	2025-11-17 22:47:07.41296	2025-11-17 22:47:07.41296
20	Muhammad Farhan	2341720033	2025-11-18	\N	13:00:00	15:00:00	Persiapan Praktikum Big Data	ditolak	\N	2025-11-17 22:47:07.41296	2025-11-17 22:47:07.41296
21	Rina Kartika	2341720022	2025-11-19	\N	08:00:00	10:00:00	Rapat Kelompok Penelitian	menunggu	\N	2025-11-17 22:47:07.41296	2025-11-17 22:47:07.41296
\.


--
-- TOC entry 3454 (class 0 OID 37730)
-- Dependencies: 227
-- Data for Name: profil_lab; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.profil_lab (id, kategori, judul, isi, created_at, updated_at) FROM stdin;
5	visi	Visi Laboratorium Business Analytics	Menjadi pusat unggulan pengembangan analitik bisnis di Polinema.	2025-11-17 22:15:29.71911	2025-11-17 22:15:29.71911
7	tujuan	Tujuan Pendirian Lab	Menjadi sarana pelatihan, penelitian, dan pengembangan kompetensi mahasiswa terkait data analytics.	2025-11-17 22:15:29.71911	2025-11-17 22:15:29.71911
8	latar belakang	Latar Belakang	Laboratorium Business Analytics didirikan berdasarkan kebutuhan akan kompetensi analitik bisnis yang meningkat di era digital.	2025-11-17 22:15:29.71911	2025-11-17 22:15:29.71911
6	misi	Misi Laboratorium Business Analytics	Mendukung kegiatan pembelajaran dan penelitian. Mengintegrasikan teknologi analitik bisnis dalam dunia industri.	2025-11-17 22:15:29.71911	2025-11-17 22:15:29.71911
\.


--
-- TOC entry 3456 (class 0 OID 37738)
-- Dependencies: 229
-- Data for Name: settings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.settings (id, key, value, updated_at) FROM stdin;
\.


--
-- TOC entry 3458 (class 0 OID 37745)
-- Dependencies: 231
-- Data for Name: site_settings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.site_settings (id, site_name, logo, footer_text, updated_at, copyright_text) FROM stdin;
3	Laboratorium Business Analytics	logo.png	Transforming Data into Decisions - Laboratorium Business Analytics Politeknik Negeri Malang	2025-11-17 22:50:07.566114	
\.


--
-- TOC entry 3475 (class 0 OID 0)
-- Dependencies: 216
-- Name: admin_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.admin_id_seq', 6, true);


--
-- TOC entry 3476 (class 0 OID 0)
-- Dependencies: 218
-- Name: dosen_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.dosen_id_seq', 8, true);


--
-- TOC entry 3477 (class 0 OID 0)
-- Dependencies: 220
-- Name: galeri_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.galeri_id_seq', 16, true);


--
-- TOC entry 3478 (class 0 OID 0)
-- Dependencies: 222
-- Name: kontak_lab_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.kontak_lab_id_seq', 2, true);


--
-- TOC entry 3479 (class 0 OID 0)
-- Dependencies: 224
-- Name: log_aktivitas_admin_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.log_aktivitas_admin_id_seq', 127, true);


--
-- TOC entry 3480 (class 0 OID 0)
-- Dependencies: 226
-- Name: peminjaman_lab_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.peminjaman_lab_id_seq', 22, true);


--
-- TOC entry 3481 (class 0 OID 0)
-- Dependencies: 228
-- Name: profil_lab_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.profil_lab_id_seq', 10, true);


--
-- TOC entry 3482 (class 0 OID 0)
-- Dependencies: 230
-- Name: settings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.settings_id_seq', 1, false);


--
-- TOC entry 3483 (class 0 OID 0)
-- Dependencies: 232
-- Name: site_settings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.site_settings_id_seq', 3, true);


--
-- TOC entry 3277 (class 2606 OID 37764)
-- Name: admin admin_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admin
    ADD CONSTRAINT admin_pkey PRIMARY KEY (id);


--
-- TOC entry 3279 (class 2606 OID 37766)
-- Name: admin admin_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admin
    ADD CONSTRAINT admin_username_key UNIQUE (username);


--
-- TOC entry 3281 (class 2606 OID 37768)
-- Name: dosen dosen_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dosen
    ADD CONSTRAINT dosen_pkey PRIMARY KEY (id);


--
-- TOC entry 3283 (class 2606 OID 37770)
-- Name: galeri galeri_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.galeri
    ADD CONSTRAINT galeri_pkey PRIMARY KEY (id);


--
-- TOC entry 3285 (class 2606 OID 37772)
-- Name: kontak_lab kontak_lab_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kontak_lab
    ADD CONSTRAINT kontak_lab_pkey PRIMARY KEY (id);


--
-- TOC entry 3287 (class 2606 OID 37774)
-- Name: log_aktivitas_admin log_aktivitas_admin_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.log_aktivitas_admin
    ADD CONSTRAINT log_aktivitas_admin_pkey PRIMARY KEY (id);


--
-- TOC entry 3289 (class 2606 OID 37776)
-- Name: peminjaman_lab peminjaman_lab_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.peminjaman_lab
    ADD CONSTRAINT peminjaman_lab_pkey PRIMARY KEY (id);


--
-- TOC entry 3291 (class 2606 OID 37778)
-- Name: profil_lab profil_lab_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.profil_lab
    ADD CONSTRAINT profil_lab_pkey PRIMARY KEY (id);


--
-- TOC entry 3293 (class 2606 OID 37780)
-- Name: settings settings_key_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.settings
    ADD CONSTRAINT settings_key_key UNIQUE (key);


--
-- TOC entry 3295 (class 2606 OID 37782)
-- Name: settings settings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.settings
    ADD CONSTRAINT settings_pkey PRIMARY KEY (id);


--
-- TOC entry 3297 (class 2606 OID 37784)
-- Name: site_settings site_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.site_settings
    ADD CONSTRAINT site_settings_pkey PRIMARY KEY (id);


--
-- TOC entry 3298 (class 2606 OID 37785)
-- Name: log_aktivitas_admin log_aktivitas_admin_admin_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.log_aktivitas_admin
    ADD CONSTRAINT log_aktivitas_admin_admin_id_fkey FOREIGN KEY (admin_id) REFERENCES public.admin(id) ON DELETE CASCADE;


--
-- TOC entry 3299 (class 2606 OID 37790)
-- Name: peminjaman_lab peminjaman_lab_admin_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.peminjaman_lab
    ADD CONSTRAINT peminjaman_lab_admin_id_fkey FOREIGN KEY (admin_id) REFERENCES public.admin(id) ON DELETE SET NULL;


-- Completed on 2025-11-17 22:51:56

--
-- PostgreSQL database dump complete
--

\unrestrict LjGIXwxJhwjVmHmZU166ZKCbbvUCXF0bNyQAyZucnbyELxfuC8fAmpdQ9GMBuHM

