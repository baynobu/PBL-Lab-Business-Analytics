--
-- PostgreSQL database dump
--

\restrict PYOJ0G4oi3JfCeR6WOzLUqNc5nd7JDzhai5rp2dgw8lnNpRPCknlddabiUTdoK6

-- Dumped from database version 15.3
-- Dumped by pg_dump version 17.6

-- Started on 2025-11-20 00:55:17

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
-- TOC entry 2 (class 3079 OID 37796)
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA public;


--
-- TOC entry 3488 (class 0 OID 0)
-- Dependencies: 2
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 215 (class 1259 OID 37833)
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
-- TOC entry 216 (class 1259 OID 37838)
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
-- TOC entry 3489 (class 0 OID 0)
-- Dependencies: 216
-- Name: admin_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.admin_id_seq OWNED BY public.admin.id;


--
-- TOC entry 217 (class 1259 OID 37839)
-- Name: dosen; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dosen (
    id integer NOT NULL,
    nama character varying(100) NOT NULL,
    keahlian character varying(150) NOT NULL,
    foto character varying(255),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    kategori_id integer
);


ALTER TABLE public.dosen OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 37846)
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
-- TOC entry 3490 (class 0 OID 0)
-- Dependencies: 218
-- Name: dosen_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.dosen_id_seq OWNED BY public.dosen.id;


--
-- TOC entry 219 (class 1259 OID 37847)
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
-- TOC entry 220 (class 1259 OID 37854)
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
-- TOC entry 3491 (class 0 OID 0)
-- Dependencies: 220
-- Name: galeri_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.galeri_id_seq OWNED BY public.galeri.id;


--
-- TOC entry 236 (class 1259 OID 37955)
-- Name: kategori; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.kategori (
    id integer NOT NULL,
    nama character varying(100) NOT NULL
);


ALTER TABLE public.kategori OWNER TO postgres;

--
-- TOC entry 235 (class 1259 OID 37954)
-- Name: kategori_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.kategori_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.kategori_id_seq OWNER TO postgres;

--
-- TOC entry 3492 (class 0 OID 0)
-- Dependencies: 235
-- Name: kategori_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.kategori_id_seq OWNED BY public.kategori.id;


--
-- TOC entry 221 (class 1259 OID 37855)
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
-- TOC entry 222 (class 1259 OID 37861)
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
-- TOC entry 3493 (class 0 OID 0)
-- Dependencies: 222
-- Name: kontak_lab_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.kontak_lab_id_seq OWNED BY public.kontak_lab.id;


--
-- TOC entry 223 (class 1259 OID 37862)
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
-- TOC entry 224 (class 1259 OID 37868)
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
-- TOC entry 3494 (class 0 OID 0)
-- Dependencies: 224
-- Name: log_aktivitas_admin_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.log_aktivitas_admin_id_seq OWNED BY public.log_aktivitas_admin.id;


--
-- TOC entry 225 (class 1259 OID 37869)
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
-- TOC entry 226 (class 1259 OID 37877)
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
-- TOC entry 3495 (class 0 OID 0)
-- Dependencies: 226
-- Name: peminjaman_lab_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.peminjaman_lab_id_seq OWNED BY public.peminjaman_lab.id;


--
-- TOC entry 227 (class 1259 OID 37878)
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
-- TOC entry 228 (class 1259 OID 37885)
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
-- TOC entry 3496 (class 0 OID 0)
-- Dependencies: 228
-- Name: profil_lab_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.profil_lab_id_seq OWNED BY public.profil_lab.id;


--
-- TOC entry 234 (class 1259 OID 37944)
-- Name: publikasi; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.publikasi (
    id integer NOT NULL,
    judul character varying(255) NOT NULL,
    penulis character varying(255),
    tanggal date,
    file character varying(255),
    link character varying(255),
    deskripsi text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    kategori_id integer
);


ALTER TABLE public.publikasi OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 37943)
-- Name: publikasi_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.publikasi_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.publikasi_id_seq OWNER TO postgres;

--
-- TOC entry 3497 (class 0 OID 0)
-- Dependencies: 233
-- Name: publikasi_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.publikasi_id_seq OWNED BY public.publikasi.id;


--
-- TOC entry 229 (class 1259 OID 37886)
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
-- TOC entry 230 (class 1259 OID 37892)
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
-- TOC entry 3498 (class 0 OID 0)
-- Dependencies: 230
-- Name: settings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.settings_id_seq OWNED BY public.settings.id;


--
-- TOC entry 231 (class 1259 OID 37893)
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
-- TOC entry 232 (class 1259 OID 37901)
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
-- TOC entry 3499 (class 0 OID 0)
-- Dependencies: 232
-- Name: site_settings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.site_settings_id_seq OWNED BY public.site_settings.id;


--
-- TOC entry 3260 (class 2604 OID 37902)
-- Name: admin id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admin ALTER COLUMN id SET DEFAULT nextval('public.admin_id_seq'::regclass);


--
-- TOC entry 3263 (class 2604 OID 37903)
-- Name: dosen id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dosen ALTER COLUMN id SET DEFAULT nextval('public.dosen_id_seq'::regclass);


--
-- TOC entry 3266 (class 2604 OID 37904)
-- Name: galeri id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.galeri ALTER COLUMN id SET DEFAULT nextval('public.galeri_id_seq'::regclass);


--
-- TOC entry 3288 (class 2604 OID 37958)
-- Name: kategori id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kategori ALTER COLUMN id SET DEFAULT nextval('public.kategori_id_seq'::regclass);


--
-- TOC entry 3269 (class 2604 OID 37905)
-- Name: kontak_lab id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kontak_lab ALTER COLUMN id SET DEFAULT nextval('public.kontak_lab_id_seq'::regclass);


--
-- TOC entry 3271 (class 2604 OID 37906)
-- Name: log_aktivitas_admin id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.log_aktivitas_admin ALTER COLUMN id SET DEFAULT nextval('public.log_aktivitas_admin_id_seq'::regclass);


--
-- TOC entry 3273 (class 2604 OID 37907)
-- Name: peminjaman_lab id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.peminjaman_lab ALTER COLUMN id SET DEFAULT nextval('public.peminjaman_lab_id_seq'::regclass);


--
-- TOC entry 3277 (class 2604 OID 37908)
-- Name: profil_lab id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.profil_lab ALTER COLUMN id SET DEFAULT nextval('public.profil_lab_id_seq'::regclass);


--
-- TOC entry 3286 (class 2604 OID 37947)
-- Name: publikasi id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.publikasi ALTER COLUMN id SET DEFAULT nextval('public.publikasi_id_seq'::regclass);


--
-- TOC entry 3280 (class 2604 OID 37909)
-- Name: settings id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.settings ALTER COLUMN id SET DEFAULT nextval('public.settings_id_seq'::regclass);


--
-- TOC entry 3282 (class 2604 OID 37910)
-- Name: site_settings id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.site_settings ALTER COLUMN id SET DEFAULT nextval('public.site_settings_id_seq'::regclass);


--
-- TOC entry 3461 (class 0 OID 37833)
-- Dependencies: 215
-- Data for Name: admin; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.admin (id, username, password, created_at, updated_at, nama_lengkap) FROM stdin;
4	admin	$2y$10$hiH0SuChynMIA8tFFdA/K.JeBbrYfezXZFjcHN5Z37vyeRrzcZUvK	2025-11-17 22:19:57.329151	2025-11-17 22:19:57.329151	administrator
\.


--
-- TOC entry 3463 (class 0 OID 37839)
-- Dependencies: 217
-- Data for Name: dosen; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dosen (id, nama, keahlian, foto, created_at, updated_at, kategori_id) FROM stdin;
5	Dr. Farid Angga Pribadi	Business Analytics, Machine Learning	farid.jpg	2025-11-17 22:15:29.71911	2025-11-17 22:15:29.71911	\N
12	Dr. Lina Kusuma	Sistem Informasi	person.jpg	2025-11-19 22:08:21.526891	2025-11-19 22:08:21.526891	4
11	Dr. Budi Santoso	Statistika Terapan	person.jpg	2025-11-19 22:08:21.526891	2025-11-19 22:08:21.526891	3
10	Prof. Siti Rahma	Big Data Analytics	person.jpg	2025-11-19 22:08:21.526891	2025-11-19 22:08:21.526891	1
9	Dr. Andi Wijaya	Machine Learning	person.jpg	2025-11-19 22:08:21.526891	2025-11-19 22:08:21.526891	1
\.


--
-- TOC entry 3465 (class 0 OID 37847)
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
-- TOC entry 3482 (class 0 OID 37955)
-- Dependencies: 236
-- Data for Name: kategori; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.kategori (id, nama) FROM stdin;
1	Data Science
2	Artificial Intelligence
3	Statistika
4	Sistem Informasi
\.


--
-- TOC entry 3467 (class 0 OID 37855)
-- Dependencies: 221
-- Data for Name: kontak_lab; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.kontak_lab (id, alamat, email, telepon, website, maps_embed, updated_at) FROM stdin;
2	Jl. Soekarno Hatta No. 9 Malang, Politeknik Negeri Malang	lab.ba@polinema.ac.id	081234567890	https://polinema.ac.id	<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d246.97072187996525!2d112.6146365458301!3d-7.943892236221397!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x2dd629dfd58aaf95%3A0xe72a182dfd18e01c!2sCivil%20Engineering%20and%20Information%20Technology%20Building%2C%20POLINEMA!5e0!3m2!1sen!2sid!4v1763392281012!5m2!1sen!2sid" width="600" height="450" style="border:0;" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>	2025-11-17 22:50:23.476193
\.


--
-- TOC entry 3469 (class 0 OID 37862)
-- Dependencies: 223
-- Data for Name: log_aktivitas_admin; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.log_aktivitas_admin (id, admin_id, aktivitas, waktu, ip_address, user_agent) FROM stdin;
141	4	Logout dari sistem	2025-11-20 00:54:31.587004	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0
\.


--
-- TOC entry 3471 (class 0 OID 37869)
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
-- TOC entry 3473 (class 0 OID 37878)
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
-- TOC entry 3480 (class 0 OID 37944)
-- Dependencies: 234
-- Data for Name: publikasi; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.publikasi (id, judul, penulis, tanggal, file, link, deskripsi, created_at, kategori_id) FROM stdin;
1	Analisis Data Mahasiswa Menggunakan Python	Dr. Andi Wijaya	2024-05-10	data-mahasiswa.pdf	\N	Studi kasus analisis data mahasiswa dengan Python dan Pandas.	2025-11-19 22:08:21.526891	1
2	Penerapan AI untuk Prediksi Cuaca	Prof. Siti Rahma	2024-06-15	\N	https://contoh-link.com/ai-cuaca	Penelitian tentang penggunaan AI dalam prediksi cuaca di Indonesia.	2025-11-19 22:08:21.526891	2
3	Statistika Dasar untuk Penelitian	Dr. Budi Santoso	2023-12-01	statistika-dasar.pdf	\N	Materi statistika dasar untuk penelitian ilmiah.	2025-11-19 22:08:21.526891	3
4	Sistem Informasi Akademik Modern	Dr. Lina Kusuma	2024-01-20	\N	https://contoh-link.com/sia-modern	Pengembangan sistem informasi akademik berbasis web.	2025-11-19 22:08:21.526891	4
\.


--
-- TOC entry 3475 (class 0 OID 37886)
-- Dependencies: 229
-- Data for Name: settings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.settings (id, key, value, updated_at) FROM stdin;
\.


--
-- TOC entry 3477 (class 0 OID 37893)
-- Dependencies: 231
-- Data for Name: site_settings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.site_settings (id, site_name, logo, footer_text, updated_at, copyright_text) FROM stdin;
3	Laboratorium Business Analytics	logo.png	Transforming Data into Decisions - Laboratorium Business Analytics Politeknik Negeri Malang	2025-11-17 22:50:07.566114	
\.


--
-- TOC entry 3500 (class 0 OID 0)
-- Dependencies: 216
-- Name: admin_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.admin_id_seq', 6, true);


--
-- TOC entry 3501 (class 0 OID 0)
-- Dependencies: 218
-- Name: dosen_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.dosen_id_seq', 12, true);


--
-- TOC entry 3502 (class 0 OID 0)
-- Dependencies: 220
-- Name: galeri_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.galeri_id_seq', 16, true);


--
-- TOC entry 3503 (class 0 OID 0)
-- Dependencies: 235
-- Name: kategori_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.kategori_id_seq', 4, true);


--
-- TOC entry 3504 (class 0 OID 0)
-- Dependencies: 222
-- Name: kontak_lab_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.kontak_lab_id_seq', 2, true);


--
-- TOC entry 3505 (class 0 OID 0)
-- Dependencies: 224
-- Name: log_aktivitas_admin_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.log_aktivitas_admin_id_seq', 141, true);


--
-- TOC entry 3506 (class 0 OID 0)
-- Dependencies: 226
-- Name: peminjaman_lab_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.peminjaman_lab_id_seq', 22, true);


--
-- TOC entry 3507 (class 0 OID 0)
-- Dependencies: 228
-- Name: profil_lab_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.profil_lab_id_seq', 10, true);


--
-- TOC entry 3508 (class 0 OID 0)
-- Dependencies: 233
-- Name: publikasi_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.publikasi_id_seq', 4, true);


--
-- TOC entry 3509 (class 0 OID 0)
-- Dependencies: 230
-- Name: settings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.settings_id_seq', 1, false);


--
-- TOC entry 3510 (class 0 OID 0)
-- Dependencies: 232
-- Name: site_settings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.site_settings_id_seq', 3, true);


--
-- TOC entry 3290 (class 2606 OID 37912)
-- Name: admin admin_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admin
    ADD CONSTRAINT admin_pkey PRIMARY KEY (id);


--
-- TOC entry 3292 (class 2606 OID 37914)
-- Name: admin admin_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admin
    ADD CONSTRAINT admin_username_key UNIQUE (username);


--
-- TOC entry 3294 (class 2606 OID 37916)
-- Name: dosen dosen_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dosen
    ADD CONSTRAINT dosen_pkey PRIMARY KEY (id);


--
-- TOC entry 3296 (class 2606 OID 37918)
-- Name: galeri galeri_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.galeri
    ADD CONSTRAINT galeri_pkey PRIMARY KEY (id);


--
-- TOC entry 3314 (class 2606 OID 37960)
-- Name: kategori kategori_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kategori
    ADD CONSTRAINT kategori_pkey PRIMARY KEY (id);


--
-- TOC entry 3298 (class 2606 OID 37920)
-- Name: kontak_lab kontak_lab_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kontak_lab
    ADD CONSTRAINT kontak_lab_pkey PRIMARY KEY (id);


--
-- TOC entry 3300 (class 2606 OID 37922)
-- Name: log_aktivitas_admin log_aktivitas_admin_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.log_aktivitas_admin
    ADD CONSTRAINT log_aktivitas_admin_pkey PRIMARY KEY (id);


--
-- TOC entry 3302 (class 2606 OID 37924)
-- Name: peminjaman_lab peminjaman_lab_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.peminjaman_lab
    ADD CONSTRAINT peminjaman_lab_pkey PRIMARY KEY (id);


--
-- TOC entry 3304 (class 2606 OID 37926)
-- Name: profil_lab profil_lab_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.profil_lab
    ADD CONSTRAINT profil_lab_pkey PRIMARY KEY (id);


--
-- TOC entry 3312 (class 2606 OID 37952)
-- Name: publikasi publikasi_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.publikasi
    ADD CONSTRAINT publikasi_pkey PRIMARY KEY (id);


--
-- TOC entry 3306 (class 2606 OID 37928)
-- Name: settings settings_key_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.settings
    ADD CONSTRAINT settings_key_key UNIQUE (key);


--
-- TOC entry 3308 (class 2606 OID 37930)
-- Name: settings settings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.settings
    ADD CONSTRAINT settings_pkey PRIMARY KEY (id);


--
-- TOC entry 3310 (class 2606 OID 37932)
-- Name: site_settings site_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.site_settings
    ADD CONSTRAINT site_settings_pkey PRIMARY KEY (id);


--
-- TOC entry 3315 (class 2606 OID 37961)
-- Name: dosen dosen_kategori_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dosen
    ADD CONSTRAINT dosen_kategori_id_fkey FOREIGN KEY (kategori_id) REFERENCES public.kategori(id);


--
-- TOC entry 3316 (class 2606 OID 37933)
-- Name: log_aktivitas_admin log_aktivitas_admin_admin_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.log_aktivitas_admin
    ADD CONSTRAINT log_aktivitas_admin_admin_id_fkey FOREIGN KEY (admin_id) REFERENCES public.admin(id) ON DELETE CASCADE;


--
-- TOC entry 3317 (class 2606 OID 37938)
-- Name: peminjaman_lab peminjaman_lab_admin_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.peminjaman_lab
    ADD CONSTRAINT peminjaman_lab_admin_id_fkey FOREIGN KEY (admin_id) REFERENCES public.admin(id) ON DELETE SET NULL;


--
-- TOC entry 3318 (class 2606 OID 37966)
-- Name: publikasi publikasi_kategori_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.publikasi
    ADD CONSTRAINT publikasi_kategori_id_fkey FOREIGN KEY (kategori_id) REFERENCES public.kategori(id);


-- Completed on 2025-11-20 00:55:17

--
-- PostgreSQL database dump complete
--

\unrestrict PYOJ0G4oi3JfCeR6WOzLUqNc5nd7JDzhai5rp2dgw8lnNpRPCknlddabiUTdoK6

