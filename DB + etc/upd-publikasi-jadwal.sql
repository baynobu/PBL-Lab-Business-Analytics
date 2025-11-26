--
-- PostgreSQL database dump
--

\restrict W53jIdQZvcgVWQx21mlB5ey8xc7Y42JXHd37nERXOQWKTaYaa1xEnG2f0UhKj5b

-- Dumped from database version 15.3
-- Dumped by pg_dump version 17.6

-- Started on 2025-11-26 08:24:28

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
-- TOC entry 3525 (class 0 OID 0)
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
-- TOC entry 3526 (class 0 OID 0)
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
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
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
-- TOC entry 3527 (class 0 OID 0)
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
-- TOC entry 3528 (class 0 OID 0)
-- Dependencies: 220
-- Name: galeri_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.galeri_id_seq OWNED BY public.galeri.id;


--
-- TOC entry 238 (class 1259 OID 37972)
-- Name: jam_tidak_tersedia; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.jam_tidak_tersedia (
    id integer NOT NULL,
    tanggal date NOT NULL,
    waktu_mulai time without time zone NOT NULL,
    waktu_selesai time without time zone NOT NULL,
    alasan text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.jam_tidak_tersedia OWNER TO postgres;

--
-- TOC entry 237 (class 1259 OID 37971)
-- Name: jam_tidak_tersedia_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.jam_tidak_tersedia_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.jam_tidak_tersedia_id_seq OWNER TO postgres;

--
-- TOC entry 3529 (class 0 OID 0)
-- Dependencies: 237
-- Name: jam_tidak_tersedia_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.jam_tidak_tersedia_id_seq OWNED BY public.jam_tidak_tersedia.id;


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
-- TOC entry 3530 (class 0 OID 0)
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
-- TOC entry 3531 (class 0 OID 0)
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
-- TOC entry 3532 (class 0 OID 0)
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
-- TOC entry 3533 (class 0 OID 0)
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
-- TOC entry 3534 (class 0 OID 0)
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
    tanggal date,
    file character varying(255),
    link character varying(255),
    deskripsi text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.publikasi OWNER TO postgres;

--
-- TOC entry 240 (class 1259 OID 37982)
-- Name: publikasi_dosen; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.publikasi_dosen (
    id integer NOT NULL,
    publikasi_id integer NOT NULL,
    dosen_id integer NOT NULL
);


ALTER TABLE public.publikasi_dosen OWNER TO postgres;

--
-- TOC entry 239 (class 1259 OID 37981)
-- Name: publikasi_dosen_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.publikasi_dosen_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.publikasi_dosen_id_seq OWNER TO postgres;

--
-- TOC entry 3535 (class 0 OID 0)
-- Dependencies: 239
-- Name: publikasi_dosen_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.publikasi_dosen_id_seq OWNED BY public.publikasi_dosen.id;


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
-- TOC entry 3536 (class 0 OID 0)
-- Dependencies: 233
-- Name: publikasi_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.publikasi_id_seq OWNED BY public.publikasi.id;


--
-- TOC entry 242 (class 1259 OID 37999)
-- Name: publikasi_kategori; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.publikasi_kategori (
    id integer NOT NULL,
    publikasi_id integer NOT NULL,
    kategori_id integer NOT NULL
);


ALTER TABLE public.publikasi_kategori OWNER TO postgres;

--
-- TOC entry 241 (class 1259 OID 37998)
-- Name: publikasi_kategori_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.publikasi_kategori_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.publikasi_kategori_id_seq OWNER TO postgres;

--
-- TOC entry 3537 (class 0 OID 0)
-- Dependencies: 241
-- Name: publikasi_kategori_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.publikasi_kategori_id_seq OWNED BY public.publikasi_kategori.id;


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
-- TOC entry 3538 (class 0 OID 0)
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
-- TOC entry 3539 (class 0 OID 0)
-- Dependencies: 232
-- Name: site_settings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.site_settings_id_seq OWNED BY public.site_settings.id;


--
-- TOC entry 3275 (class 2604 OID 37902)
-- Name: admin id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admin ALTER COLUMN id SET DEFAULT nextval('public.admin_id_seq'::regclass);


--
-- TOC entry 3278 (class 2604 OID 37903)
-- Name: dosen id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dosen ALTER COLUMN id SET DEFAULT nextval('public.dosen_id_seq'::regclass);


--
-- TOC entry 3281 (class 2604 OID 37904)
-- Name: galeri id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.galeri ALTER COLUMN id SET DEFAULT nextval('public.galeri_id_seq'::regclass);


--
-- TOC entry 3304 (class 2604 OID 37975)
-- Name: jam_tidak_tersedia id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.jam_tidak_tersedia ALTER COLUMN id SET DEFAULT nextval('public.jam_tidak_tersedia_id_seq'::regclass);


--
-- TOC entry 3303 (class 2604 OID 37958)
-- Name: kategori id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kategori ALTER COLUMN id SET DEFAULT nextval('public.kategori_id_seq'::regclass);


--
-- TOC entry 3284 (class 2604 OID 37905)
-- Name: kontak_lab id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kontak_lab ALTER COLUMN id SET DEFAULT nextval('public.kontak_lab_id_seq'::regclass);


--
-- TOC entry 3286 (class 2604 OID 37906)
-- Name: log_aktivitas_admin id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.log_aktivitas_admin ALTER COLUMN id SET DEFAULT nextval('public.log_aktivitas_admin_id_seq'::regclass);


--
-- TOC entry 3288 (class 2604 OID 37907)
-- Name: peminjaman_lab id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.peminjaman_lab ALTER COLUMN id SET DEFAULT nextval('public.peminjaman_lab_id_seq'::regclass);


--
-- TOC entry 3292 (class 2604 OID 37908)
-- Name: profil_lab id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.profil_lab ALTER COLUMN id SET DEFAULT nextval('public.profil_lab_id_seq'::regclass);


--
-- TOC entry 3301 (class 2604 OID 37947)
-- Name: publikasi id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.publikasi ALTER COLUMN id SET DEFAULT nextval('public.publikasi_id_seq'::regclass);


--
-- TOC entry 3306 (class 2604 OID 37985)
-- Name: publikasi_dosen id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.publikasi_dosen ALTER COLUMN id SET DEFAULT nextval('public.publikasi_dosen_id_seq'::regclass);


--
-- TOC entry 3307 (class 2604 OID 38002)
-- Name: publikasi_kategori id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.publikasi_kategori ALTER COLUMN id SET DEFAULT nextval('public.publikasi_kategori_id_seq'::regclass);


--
-- TOC entry 3295 (class 2604 OID 37909)
-- Name: settings id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.settings ALTER COLUMN id SET DEFAULT nextval('public.settings_id_seq'::regclass);


--
-- TOC entry 3297 (class 2604 OID 37910)
-- Name: site_settings id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.site_settings ALTER COLUMN id SET DEFAULT nextval('public.site_settings_id_seq'::regclass);


--
-- TOC entry 3492 (class 0 OID 37833)
-- Dependencies: 215
-- Data for Name: admin; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.admin (id, username, password, created_at, updated_at, nama_lengkap) FROM stdin;
4	admin	$2y$10$hiH0SuChynMIA8tFFdA/K.JeBbrYfezXZFjcHN5Z37vyeRrzcZUvK	2025-11-17 22:19:57.329151	2025-11-20 18:56:35.61357	administrator
\.


--
-- TOC entry 3494 (class 0 OID 37839)
-- Dependencies: 217
-- Data for Name: dosen; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dosen (id, nama, keahlian, foto, created_at, updated_at) FROM stdin;
5	Dr. Farid Angga Pribadi	Business Analytics, Machine Learning	farid.jpg	2025-11-17 22:15:29.71911	2025-11-17 22:15:29.71911
12	Dr. Lina Kusuma	Sistem Informasi	person.jpg	2025-11-19 22:08:21.526891	2025-11-19 22:08:21.526891
11	Dr. Budi Santoso	Statistika Terapan	person.jpg	2025-11-19 22:08:21.526891	2025-11-19 22:08:21.526891
10	Prof. Siti Rahma	Big Data Analytics	person.jpg	2025-11-19 22:08:21.526891	2025-11-19 22:08:21.526891
9	Dr. Andi Wijaya	Machine Learning	person.jpg	2025-11-19 22:08:21.526891	2025-11-19 22:08:21.526891
\.


--
-- TOC entry 3496 (class 0 OID 37847)
-- Dependencies: 219
-- Data for Name: galeri; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.galeri (id, judul, deskripsi, gambar, tanggal, created_at, updated_at) FROM stdin;
10	Workshop Data Analytics	Pelatihan analisis data bersama mahasiswa TI.	pexels-divinetechygirl-1181396.jpg	2025-01-10	2025-11-17 22:15:29.71911	2025-11-17 22:15:29.71911
13	Kuliah Tamu: Business Intelligence Modern	Kegiatan kuliah tamu bersama praktisi industri mengenai penerapan Business Intelligence dalam perusahaan modern.	pexels-fauxels-3183186.jpg	2025-02-05	2025-11-17 22:31:52.771979	2025-11-17 22:31:52.771979
14	Pelatihan Dashboard Menggunakan Power BI	Mahasiswa belajar membuat dashboard interaktif menggunakan Microsoft Power BI.	pexels-icsa-833425-1709003.jpg	2025-03-12	2025-11-17 22:31:52.771979	2025-11-17 22:31:52.771979
15	Kegiatan Riset Analitik Data Sosial Media	Tim lab melakukan penelitian mengenai analisis sentimen media sosial menggunakan teknik NLP.	pexels-pixabay-416405.jpg	2025-04-14	2025-11-17 22:31:52.771979	2025-11-17 22:31:52.771979
12	Workshop Pengolahan Data dengan Python	Pelatihan intensif mengenai penggunaan Python untuk analisis data dasar hingga menengah.	1763577286_pexels-fauxels-3183183.jpg	2025-01-10	2025-11-17 22:31:52.771979	2025-11-17 22:31:52.771979
\.


--
-- TOC entry 3515 (class 0 OID 37972)
-- Dependencies: 238
-- Data for Name: jam_tidak_tersedia; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.jam_tidak_tersedia (id, tanggal, waktu_mulai, waktu_selesai, alasan, created_at) FROM stdin;
6	2025-11-22	08:00:00	10:00:00	-	2025-11-22 00:10:48.37451
11	2025-11-26	14:00:00	18:00:00	-	2025-11-25 21:24:08.822904
\.


--
-- TOC entry 3513 (class 0 OID 37955)
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
-- TOC entry 3498 (class 0 OID 37855)
-- Dependencies: 221
-- Data for Name: kontak_lab; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.kontak_lab (id, alamat, email, telepon, website, maps_embed, updated_at) FROM stdin;
2	Jl. Soekarno Hatta No. 9 Malang, Politeknik Negeri Malang	lab.ba@polinema.ac.id	081234567890	https://polinema.ac.id	<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d246.97072187996525!2d112.6146365458301!3d-7.943892236221397!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x2dd629dfd58aaf95%3A0xe72a182dfd18e01c!2sCivil%20Engineering%20and%20Information%20Technology%20Building%2C%20POLINEMA!5e0!3m2!1sen!2sid!4v1763392281012!5m2!1sen!2sid" width="600" height="450" style="border:0;" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>	2025-11-20 21:14:05.861099
\.


--
-- TOC entry 3500 (class 0 OID 37862)
-- Dependencies: 223
-- Data for Name: log_aktivitas_admin; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.log_aktivitas_admin (id, admin_id, aktivitas, waktu, ip_address, user_agent) FROM stdin;
141	4	Logout dari sistem	2025-11-20 00:54:31.587004	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0
142	4	Login ke sistem	2025-11-20 00:55:35.73582	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0
143	4	Menambah admin baru: testing	2025-11-20 00:55:52.385986	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0
144	4	Mengubah password admin: testing	2025-11-20 00:56:06.746025	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0
145	4	Mengubah data admin: testing	2025-11-20 00:56:06.747005	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0
146	4	Menambah dosen: testing	2025-11-20 00:56:35.179605	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0
147	4	Menghapus admin: testingg	2025-11-20 00:56:44.328901	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0
148	4	Mengedit dosen: testing → testingg	2025-11-20 00:56:59.12761	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0
149	4	Mengedit dosen: testingg → testingg	2025-11-20 00:57:06.536964	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0
150	4	Menghapus dosen: testingg	2025-11-20 00:57:11.294705	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0
151	4	Menambah foto galeri: testing	2025-11-20 00:57:29.440762	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0
152	4	Menghapus foto galeri: testingg	2025-11-20 00:57:52.30916	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0
153	4	Menambah publikasi: testing	2025-11-20 00:58:24.984932	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0
154	4	Mengedit publikasi: testingg	2025-11-20 00:59:01.902035	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0
155	4	Menghapus publikasi: testingg	2025-11-20 00:59:17.52425	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0
156	4	Menambah kategori: testing	2025-11-20 00:59:28.62635	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0
157	4	Mengedit kategori: testingg	2025-11-20 00:59:34.079815	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0
158	4	Menghapus kategori: 5	2025-11-20 00:59:37.585886	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0
159	4	Mengubah status peminjaman menjadi: disetujui	2025-11-20 01:26:24.39088	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0
160	4	Mengubah status peminjaman menjadi: ditolak	2025-11-20 01:26:25.663849	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0
161	4	Menghapus peminjaman ID 25	2025-11-20 01:26:29.542818	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0
162	4	Menghapus peminjaman ID 23	2025-11-20 01:26:32.205759	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0
163	4	Menghapus peminjaman ID 27	2025-11-20 01:26:34.046351	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0
164	4	Menghapus peminjaman ID 26	2025-11-20 01:26:35.912073	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0
165	4	Menambah konten profil: profile	2025-11-20 01:26:44.057099	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0
166	4	Mengedit konten profil: profile → profileasdf	2025-11-20 01:26:52.035462	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0
167	4	Menghapus konten profil: profileasdf	2025-11-20 01:26:56.640289	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0
168	4	Mengubah pengaturan website + logo baru	2025-11-20 01:27:18.576063	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0
169	4	Mengubah pengaturan website + logo baru	2025-11-20 01:27:37.883961	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0
170	4	Update kontak lab	2025-11-20 01:27:47.723863	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0
171	4	Update kontak lab	2025-11-20 01:27:56.88462	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0
172	4	Logout dari sistem	2025-11-20 01:58:13.011155	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0
173	4	Login ke sistem	2025-11-20 18:08:51.085227	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0
174	4	Mengubah data admin: admin	2025-11-20 18:56:35.615865	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0
175	4	Menambah admin baru: testing	2025-11-20 21:10:01.89094	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0
176	4	Mengubah password admin: testing	2025-11-20 21:10:17.438153	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0
177	4	Mengubah data admin: testing	2025-11-20 21:10:17.439297	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0
178	4	Menghapus admin: testingg	2025-11-20 21:10:22.322915	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0
179	4	Menambah dosen: testing	2025-11-20 21:10:53.032947	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0
180	4	Mengedit dosen: testing → testingg	2025-11-20 21:11:07.825638	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0
181	4	Menghapus dosen: testingg	2025-11-20 21:11:20.01722	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0
182	4	Menambah foto galeri: testing	2025-11-20 21:11:39.741383	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0
183	4	Menghapus foto galeri: testingg	2025-11-20 21:12:00.296505	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0
184	4	Menambah publikasi: asdf	2025-11-20 21:12:32.574147	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0
185	4	Mengedit publikasi: asdfasdf	2025-11-20 21:12:48.173438	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0
186	4	Menghapus publikasi: asdfasdf	2025-11-20 21:12:53.185308	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0
187	4	Menambah kategori: asdfadsf	2025-11-20 21:12:58.841096	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0
188	4	Mengedit kategori: asdfadsfasdf	2025-11-20 21:13:05.69422	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0
189	4	Menghapus kategori: 6	2025-11-20 21:13:08.585022	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0
190	4	Mengubah status peminjaman menjadi: ditolak	2025-11-20 21:13:13.795007	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0
191	4	Mengubah status peminjaman menjadi: disetujui	2025-11-20 21:13:14.823718	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0
192	4	Mengubah status peminjaman menjadi: disetujui	2025-11-20 21:13:16.669325	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0
193	4	Mengubah status peminjaman menjadi: disetujui	2025-11-20 21:13:18.221621	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0
194	4	Mengubah status peminjaman menjadi: ditolak	2025-11-20 21:13:19.75488	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0
195	4	Mengubah status peminjaman menjadi: ditolak	2025-11-20 21:13:20.824899	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0
196	4	Mengubah status peminjaman menjadi: ditolak	2025-11-20 21:13:21.526552	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0
197	4	Mengubah status peminjaman menjadi: ditolak	2025-11-20 21:13:22.533842	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0
198	4	Menghapus peminjaman ID 20	2025-11-20 21:13:26.559384	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0
199	4	Menambah konten profil: visi	2025-11-20 21:13:33.150055	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0
200	4	Mengedit konten profil: visi → visiasdf	2025-11-20 21:13:42.636249	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0
201	4	Menghapus konten profil: visiasdf	2025-11-20 21:13:48.850296	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0
202	4	Mengubah pengaturan website	2025-11-20 21:13:56.14202	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0
203	4	Mengubah pengaturan website	2025-11-20 21:13:58.915141	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0
204	4	Update kontak lab	2025-11-20 21:14:02.947623	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0
205	4	Update kontak lab	2025-11-20 21:14:05.862478	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0
206	4	Logout dari sistem	2025-11-20 21:15:47.774254	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0
207	4	Login ke sistem	2025-11-20 21:52:38.888746	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0
208	4	Mengubah status peminjaman menjadi: disetujui	2025-11-20 21:52:49.284498	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0
209	4	Mengubah status peminjaman menjadi: disetujui	2025-11-20 21:52:50.733209	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0
210	4	Mengubah status peminjaman menjadi: ditolak	2025-11-20 21:53:17.616355	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0
211	4	Mengubah status peminjaman menjadi: ditolak	2025-11-20 21:53:19.225985	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0
212	4	Mengubah status peminjaman menjadi: disetujui	2025-11-20 21:55:31.303332	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0
213	4	Logout dari sistem	2025-11-20 22:02:33.983821	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0
214	4	Login ke sistem	2025-11-21 16:49:25.832683	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0
215	4	Mengubah status peminjaman menjadi: disetujui	2025-11-21 16:49:35.614228	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0
216	4	Mengubah status peminjaman menjadi: ditolak	2025-11-21 16:49:38.39699	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0
217	4	Menghapus peminjaman ID 29	2025-11-21 16:49:41.727924	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0
218	4	Menghapus peminjaman ID 35	2025-11-21 16:50:10.014007	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0
219	4	Menghapus peminjaman ID 34	2025-11-21 16:50:12.670783	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0
220	4	Menghapus peminjaman ID 33	2025-11-21 16:50:15.296943	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0
221	4	Menghapus peminjaman ID 32	2025-11-21 16:50:32.629129	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0
222	4	Menghapus peminjaman ID 31	2025-11-21 16:50:35.662506	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0
223	4	Menghapus peminjaman ID 30	2025-11-21 16:50:47.598085	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0
224	4	Menghapus peminjaman ID 19	2025-11-21 16:51:19.463024	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0
225	4	Mengubah status peminjaman menjadi: ditolak	2025-11-21 16:52:02.702391	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0
226	4	Menghapus peminjaman ID 41	2025-11-21 23:27:26.01328	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0
227	4	Menghapus peminjaman ID 40	2025-11-21 23:27:28.792267	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0
228	4	Menghapus peminjaman ID 39	2025-11-21 23:27:31.043143	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0
229	4	Menghapus peminjaman ID 38	2025-11-21 23:27:32.867129	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0
230	4	Menghapus peminjaman ID 37	2025-11-21 23:27:35.498334	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0
231	4	Menghapus peminjaman ID 36	2025-11-21 23:27:37.880573	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0
232	4	Menghapus peminjaman ID 42	2025-11-21 23:34:40.830971	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0
233	4	Mengubah status peminjaman menjadi: disetujui	2025-11-21 23:34:43.361317	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0
234	4	Mengubah status peminjaman menjadi: ditolak	2025-11-21 23:35:00.440964	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0
235	4	Menghapus peminjaman ID 44	2025-11-21 23:41:41.618477	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0
236	4	Menghapus peminjaman ID 45	2025-11-21 23:41:43.905682	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0
237	4	Menghapus peminjaman ID 43	2025-11-21 23:41:46.451014	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0
238	4	Menghapus peminjaman ID 46	2025-11-21 23:41:47.940742	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0
239	4	Menghapus peminjaman ID 18	2025-11-21 23:41:57.151836	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0
240	4	Menghapus peminjaman ID 28	2025-11-21 23:41:58.959416	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0
241	4	Mengubah status peminjaman menjadi: ditolak	2025-11-21 23:42:00.132187	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0
242	4	Menghapus peminjaman ID 21	2025-11-21 23:42:02.880419	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0
243	4	Logout dari sistem	2025-11-21 23:47:40.539139	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0
244	4	Login ke sistem	2025-11-21 23:49:39.530824	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0
245	4	Mengubah status peminjaman menjadi: disetujui	2025-11-25 21:19:48.324802	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0
246	4	Mengubah status peminjaman menjadi: ditolak	2025-11-25 21:19:51.01325	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0
247	4	Mengubah status peminjaman menjadi: disetujui	2025-11-25 21:19:51.523845	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0
248	4	Tambah jam tidak tersedia: 2025-11-26 08:00-12:00 (-)	2025-11-25 22:14:33.470374	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0
249	4	Hapus jam tidak tersedia ID: 12	2025-11-25 22:14:50.598213	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0
250	4	Mengubah status peminjaman menjadi: disetujui	2025-11-25 23:34:42.529106	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0
251	4	Mengedit publikasi: Penerapan AI untuk Prediksi Cuaca	2025-11-26 00:18:26.755432	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0
252	4	Mengedit publikasi: Implementasi Deep Learning untuk Klasifikasi Citra Medis	2025-11-26 00:34:33.764123	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0
253	4	Mengedit publikasi: Pemodelan Regresi dalam Analisis Data Sosial	2025-11-26 00:55:16.638508	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0
254	4	Logout dari sistem	2025-11-26 01:01:16.57108	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0
\.


--
-- TOC entry 3502 (class 0 OID 37869)
-- Dependencies: 225
-- Data for Name: peminjaman_lab; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.peminjaman_lab (id, nama_peminjam, nip, tanggal_mulai, tanggal_selesai, waktu_mulai, waktu_selesai, keperluan, status, admin_id, created_at, updated_at) FROM stdin;
51	Testing 2	244000000002	2025-11-25	2025-11-25	12:00:00	15:00:00	-	ditolak	4	2025-11-25 21:13:08.772804	2025-11-25 21:19:51.010855
49	Testing 1	244000000001	2025-11-25	2025-11-25	08:00:00	11:00:00	-	disetujui	4	2025-11-25 21:11:14.834147	2025-11-25 21:19:51.521639
55	Testing 4	244000000004	2025-11-25	2025-11-25	11:00:00	11:00:00	-	menunggu	\N	2025-11-25 21:20:40.030975	2025-11-25 21:20:40.030975
56	Testing 5	244000000005	2025-11-28	2025-11-28	08:00:00	12:00:00	-	menunggu	\N	2025-11-25 21:49:20.568185	2025-11-25 21:49:20.568185
57	Testing 6	244000000006	2025-11-27	2025-11-27	08:00:00	15:00:00	-	disetujui	4	2025-11-25 23:33:59.852074	2025-11-25 23:34:42.525704
53	Testing 3	244000000003	2025-11-26	2025-11-26	08:00:00	13:00:00	-	disetujui	4	2025-11-25 21:14:58.964306	2025-11-25 21:19:48.321613
\.


--
-- TOC entry 3504 (class 0 OID 37878)
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
-- TOC entry 3511 (class 0 OID 37944)
-- Dependencies: 234
-- Data for Name: publikasi; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.publikasi (id, judul, tanggal, file, link, deskripsi, created_at) FROM stdin;
1	Analisis Prediksi Penjualan Menggunakan Random Forest	2024-05-10	\N	https://sinta.kemdiktisaintek.go.id/publication/12345	Model prediksi berbasis machine learning pada data retail.	2025-11-26 00:20:30.515256
3	Evaluasi Dashboard Business Intelligence untuk Instansi Pemerintah	2023-12-21	dashboard-bi.pdf	https://sinta.kemdiktisaintek.go.id/publication/54321	Studi usability dashboard BI berbasis Power BI.	2025-11-26 00:20:30.515256
4	Optimasi Sistem Rekomendasi Menggunakan Collaborative Filtering	2024-01-15	\N	https://sinta.kemdiktisaintek.go.id/publication/11223	Model rekomendasi untuk platform e-commerce Indonesia.	2025-11-26 00:20:30.515256
2	Implementasi Deep Learning untuk Klasifikasi Citra Medis	2024-06-02	\N	https://sinta.kemdiktisaintek.go.id/publication/98765	Penelitian klasifikasi citra CT-scan menggunakan CNN.	2025-11-26 00:20:30.515256
5	Pemodelan Regresi dalam Analisis Data Sosial	2023-11-08	regresi-sosial.pdf	https://sinta.kemdiktisaintek.go.id/publication/99887	Eksplorasi regresi multivariat pada data sosial.	2025-11-26 00:20:30.515256
\.


--
-- TOC entry 3517 (class 0 OID 37982)
-- Dependencies: 240
-- Data for Name: publikasi_dosen; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.publikasi_dosen (id, publikasi_id, dosen_id) FROM stdin;
10	1	9
11	1	5
13	3	11
14	4	12
15	4	9
16	2	10
17	5	9
\.


--
-- TOC entry 3519 (class 0 OID 37999)
-- Dependencies: 242
-- Data for Name: publikasi_kategori; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.publikasi_kategori (id, publikasi_id, kategori_id) FROM stdin;
2	1	1
3	1	4
6	3	4
7	4	2
8	4	1
26	2	2
27	2	1
28	2	4
29	2	3
30	5	1
31	5	4
32	5	3
\.


--
-- TOC entry 3506 (class 0 OID 37886)
-- Dependencies: 229
-- Data for Name: settings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.settings (id, key, value, updated_at) FROM stdin;
\.


--
-- TOC entry 3508 (class 0 OID 37893)
-- Dependencies: 231
-- Data for Name: site_settings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.site_settings (id, site_name, logo, footer_text, updated_at, copyright_text) FROM stdin;
3	Laboratorium Business Analytics	logo.png	Transforming Data into Decisions - Laboratorium Business Analytics Politeknik Negeri Malang	2025-11-20 21:13:58.914109	
\.


--
-- TOC entry 3540 (class 0 OID 0)
-- Dependencies: 216
-- Name: admin_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.admin_id_seq', 8, true);


--
-- TOC entry 3541 (class 0 OID 0)
-- Dependencies: 218
-- Name: dosen_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.dosen_id_seq', 14, true);


--
-- TOC entry 3542 (class 0 OID 0)
-- Dependencies: 220
-- Name: galeri_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.galeri_id_seq', 18, true);


--
-- TOC entry 3543 (class 0 OID 0)
-- Dependencies: 237
-- Name: jam_tidak_tersedia_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.jam_tidak_tersedia_id_seq', 12, true);


--
-- TOC entry 3544 (class 0 OID 0)
-- Dependencies: 235
-- Name: kategori_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.kategori_id_seq', 6, true);


--
-- TOC entry 3545 (class 0 OID 0)
-- Dependencies: 222
-- Name: kontak_lab_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.kontak_lab_id_seq', 2, true);


--
-- TOC entry 3546 (class 0 OID 0)
-- Dependencies: 224
-- Name: log_aktivitas_admin_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.log_aktivitas_admin_id_seq', 254, true);


--
-- TOC entry 3547 (class 0 OID 0)
-- Dependencies: 226
-- Name: peminjaman_lab_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.peminjaman_lab_id_seq', 57, true);


--
-- TOC entry 3548 (class 0 OID 0)
-- Dependencies: 228
-- Name: profil_lab_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.profil_lab_id_seq', 12, true);


--
-- TOC entry 3549 (class 0 OID 0)
-- Dependencies: 239
-- Name: publikasi_dosen_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.publikasi_dosen_id_seq', 17, true);


--
-- TOC entry 3550 (class 0 OID 0)
-- Dependencies: 233
-- Name: publikasi_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.publikasi_id_seq', 6, true);


--
-- TOC entry 3551 (class 0 OID 0)
-- Dependencies: 241
-- Name: publikasi_kategori_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.publikasi_kategori_id_seq', 32, true);


--
-- TOC entry 3552 (class 0 OID 0)
-- Dependencies: 230
-- Name: settings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.settings_id_seq', 1, false);


--
-- TOC entry 3553 (class 0 OID 0)
-- Dependencies: 232
-- Name: site_settings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.site_settings_id_seq', 3, true);


--
-- TOC entry 3309 (class 2606 OID 37912)
-- Name: admin admin_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admin
    ADD CONSTRAINT admin_pkey PRIMARY KEY (id);


--
-- TOC entry 3311 (class 2606 OID 37914)
-- Name: admin admin_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admin
    ADD CONSTRAINT admin_username_key UNIQUE (username);


--
-- TOC entry 3313 (class 2606 OID 37916)
-- Name: dosen dosen_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dosen
    ADD CONSTRAINT dosen_pkey PRIMARY KEY (id);


--
-- TOC entry 3315 (class 2606 OID 37918)
-- Name: galeri galeri_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.galeri
    ADD CONSTRAINT galeri_pkey PRIMARY KEY (id);


--
-- TOC entry 3335 (class 2606 OID 37980)
-- Name: jam_tidak_tersedia jam_tidak_tersedia_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.jam_tidak_tersedia
    ADD CONSTRAINT jam_tidak_tersedia_pkey PRIMARY KEY (id);


--
-- TOC entry 3333 (class 2606 OID 37960)
-- Name: kategori kategori_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kategori
    ADD CONSTRAINT kategori_pkey PRIMARY KEY (id);


--
-- TOC entry 3317 (class 2606 OID 37920)
-- Name: kontak_lab kontak_lab_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kontak_lab
    ADD CONSTRAINT kontak_lab_pkey PRIMARY KEY (id);


--
-- TOC entry 3319 (class 2606 OID 37922)
-- Name: log_aktivitas_admin log_aktivitas_admin_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.log_aktivitas_admin
    ADD CONSTRAINT log_aktivitas_admin_pkey PRIMARY KEY (id);


--
-- TOC entry 3321 (class 2606 OID 37924)
-- Name: peminjaman_lab peminjaman_lab_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.peminjaman_lab
    ADD CONSTRAINT peminjaman_lab_pkey PRIMARY KEY (id);


--
-- TOC entry 3323 (class 2606 OID 37926)
-- Name: profil_lab profil_lab_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.profil_lab
    ADD CONSTRAINT profil_lab_pkey PRIMARY KEY (id);


--
-- TOC entry 3339 (class 2606 OID 37987)
-- Name: publikasi_dosen publikasi_dosen_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.publikasi_dosen
    ADD CONSTRAINT publikasi_dosen_pkey PRIMARY KEY (id);


--
-- TOC entry 3343 (class 2606 OID 38004)
-- Name: publikasi_kategori publikasi_kategori_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.publikasi_kategori
    ADD CONSTRAINT publikasi_kategori_pkey PRIMARY KEY (id);


--
-- TOC entry 3331 (class 2606 OID 37952)
-- Name: publikasi publikasi_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.publikasi
    ADD CONSTRAINT publikasi_pkey PRIMARY KEY (id);


--
-- TOC entry 3325 (class 2606 OID 37928)
-- Name: settings settings_key_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.settings
    ADD CONSTRAINT settings_key_key UNIQUE (key);


--
-- TOC entry 3327 (class 2606 OID 37930)
-- Name: settings settings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.settings
    ADD CONSTRAINT settings_pkey PRIMARY KEY (id);


--
-- TOC entry 3329 (class 2606 OID 37932)
-- Name: site_settings site_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.site_settings
    ADD CONSTRAINT site_settings_pkey PRIMARY KEY (id);


--
-- TOC entry 3336 (class 1259 OID 38016)
-- Name: idx_pub_dosen_dosen; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_pub_dosen_dosen ON public.publikasi_dosen USING btree (dosen_id);


--
-- TOC entry 3337 (class 1259 OID 38015)
-- Name: idx_pub_dosen_pub; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_pub_dosen_pub ON public.publikasi_dosen USING btree (publikasi_id);


--
-- TOC entry 3340 (class 1259 OID 38018)
-- Name: idx_pub_kategori_kategori; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_pub_kategori_kategori ON public.publikasi_kategori USING btree (kategori_id);


--
-- TOC entry 3341 (class 1259 OID 38017)
-- Name: idx_pub_kategori_pub; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_pub_kategori_pub ON public.publikasi_kategori USING btree (publikasi_id);


--
-- TOC entry 3344 (class 2606 OID 37933)
-- Name: log_aktivitas_admin log_aktivitas_admin_admin_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.log_aktivitas_admin
    ADD CONSTRAINT log_aktivitas_admin_admin_id_fkey FOREIGN KEY (admin_id) REFERENCES public.admin(id) ON DELETE CASCADE;


--
-- TOC entry 3345 (class 2606 OID 37938)
-- Name: peminjaman_lab peminjaman_lab_admin_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.peminjaman_lab
    ADD CONSTRAINT peminjaman_lab_admin_id_fkey FOREIGN KEY (admin_id) REFERENCES public.admin(id) ON DELETE SET NULL;


--
-- TOC entry 3346 (class 2606 OID 37993)
-- Name: publikasi_dosen publikasi_dosen_dosen_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.publikasi_dosen
    ADD CONSTRAINT publikasi_dosen_dosen_id_fkey FOREIGN KEY (dosen_id) REFERENCES public.dosen(id) ON DELETE CASCADE;


--
-- TOC entry 3347 (class 2606 OID 37988)
-- Name: publikasi_dosen publikasi_dosen_publikasi_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.publikasi_dosen
    ADD CONSTRAINT publikasi_dosen_publikasi_id_fkey FOREIGN KEY (publikasi_id) REFERENCES public.publikasi(id) ON DELETE CASCADE;


--
-- TOC entry 3348 (class 2606 OID 38010)
-- Name: publikasi_kategori publikasi_kategori_kategori_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.publikasi_kategori
    ADD CONSTRAINT publikasi_kategori_kategori_id_fkey FOREIGN KEY (kategori_id) REFERENCES public.kategori(id) ON DELETE CASCADE;


--
-- TOC entry 3349 (class 2606 OID 38005)
-- Name: publikasi_kategori publikasi_kategori_publikasi_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.publikasi_kategori
    ADD CONSTRAINT publikasi_kategori_publikasi_id_fkey FOREIGN KEY (publikasi_id) REFERENCES public.publikasi(id) ON DELETE CASCADE;


-- Completed on 2025-11-26 08:24:28

--
-- PostgreSQL database dump complete
--

\unrestrict W53jIdQZvcgVWQx21mlB5ey8xc7Y42JXHd37nERXOQWKTaYaa1xEnG2f0UhKj5b

