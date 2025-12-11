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

CREATE FUNCTION public.set_jam_tidak_tersedia(p_tanggal date, p_mulai time without time zone, p_selesai time without time zone, p_alasan text DEFAULT 'Tidak Tersedia'::text) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    INSERT INTO public.jam_tidak_tersedia(tanggal, waktu_mulai, waktu_selesai, alasan)
    VALUES (p_tanggal, p_mulai, p_selesai, p_alasan);
END;
$$;

ALTER FUNCTION public.set_jam_tidak_tersedia(p_tanggal date, p_mulai time without time zone, p_selesai time without time zone, p_alasan text) OWNER TO postgres;

CREATE FUNCTION public.tambah_peminjaman(p_nama character varying, p_nip character varying, p_tanggal date, p_mulai time without time zone, p_selesai time without time zone, p_keperluan text) RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
    bentrok INTEGER;
BEGIN
    -- validasi dasar interval waktu
    IF p_mulai >= p_selesai THEN
        RETURN 'GAGAL: Waktu mulai harus lebih kecil dari waktu selesai.';
    END IF;

    -- cek bentrok slot peminjaman yang sudah disetujui pada tanggal yang sama
    SELECT COUNT(*) INTO bentrok
    FROM public.peminjaman_lab
    WHERE tanggal_mulai = p_tanggal
      AND status = 'disetujui'
      AND (p_mulai < waktu_selesai AND p_selesai > waktu_mulai);

    IF bentrok > 0 THEN
        RETURN 'GAGAL: Waktu bentrok dengan peminjaman lain yang sudah disetujui.';
    END IF;

    -- cek bentrok dengan jam tidak tersedia (blokir)
    SELECT COUNT(*) INTO bentrok
    FROM public.jam_tidak_tersedia j
    WHERE j.tanggal = p_tanggal
      AND (p_mulai < j.waktu_selesai AND p_selesai > j.waktu_mulai);

    IF bentrok > 0 THEN
        RETURN 'GAGAL: Waktu berada pada periode jam tidak tersedia.';
    END IF;

    -- insert pengajuan (status default: 'menunggu')
    INSERT INTO public.peminjaman_lab(
        nama_peminjam, nip, tanggal_mulai, waktu_mulai, waktu_selesai, keperluan
    )
    VALUES (p_nama, p_nip, p_tanggal, p_mulai, p_selesai, p_keperluan);

    RETURN 'OK';
END;
$$;

ALTER FUNCTION public.tambah_peminjaman(p_nama character varying, p_nip character varying, p_tanggal date, p_mulai time without time zone, p_selesai time without time zone, p_keperluan text) OWNER TO postgres;

CREATE FUNCTION public.tambah_publikasi(p_judul character varying, p_tanggal date, p_file character varying, p_link character varying, p_kategori integer[], p_dosen integer[]) RETURNS void
    LANGUAGE plpgsql
    AS $$
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
$$;

ALTER FUNCTION public.tambah_publikasi(p_judul character varying, p_tanggal date, p_file character varying, p_link character varying, p_kategori integer[], p_dosen integer[]) OWNER TO postgres;

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
    copyright_text text,
    logo_jti character varying(255),
    logo_polinema character varying(255),
    social_instagram text,
    social_facebook text,
    social_youtube text
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

CREATE VIEW public.view_jadwal_peminjaman AS
 SELECT p.id,
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
   FROM (public.peminjaman_lab p
     LEFT JOIN public.admin a ON ((p.admin_id = a.id)));

ALTER VIEW public.view_jadwal_peminjaman OWNER TO postgres;

CREATE VIEW public.view_publikasi_lengkap AS
 SELECT pub.id AS publikasi_id,
    pub.judul,
    pub.tanggal,
    pub.file,
    pub.link,
    kat.nama AS kategori,
    string_agg(DISTINCT (d.nama)::text, ', '::text ORDER BY (d.nama)::text) AS daftar_dosen
   FROM ((((public.publikasi pub
     JOIN public.publikasi_kategori pk ON ((pk.publikasi_id = pub.id)))
     JOIN public.kategori kat ON ((kat.id = pk.kategori_id)))
     JOIN public.publikasi_dosen pd ON ((pd.publikasi_id = pub.id)))
     JOIN public.dosen d ON ((d.id = pd.dosen_id)))
  GROUP BY pub.id, pub.judul, pub.tanggal, pub.file, pub.link, kat.nama;

ALTER VIEW public.view_publikasi_lengkap OWNER TO postgres;

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
4	admin	$2y$10$hiH0SuChynMIA8tFFdA/K.JeBbrYfezXZFjcHN5Z37vyeRrzcZUvK	2025-11-17 22:19:57.329151	2025-11-20 18:56:35.61357	administrator
\.

COPY public.berita (id, judul, isi, gambar, tanggal, penulis, created_at, updated_at) FROM stdin;
1	Polinema Resmikan Laboratorium Business Analytics Terbaru	Politeknik Negeri Malang resmi meluncurkan Laboratorium Business Analytics sebagai ruang riset, pembelajaran, dan pengembangan inovasi data-driven untuk mahasiswa. \n  Laboratorium ini diharapkan mampu menjadi pusat kolaborasi antara akademisi dan industri dalam menghadapi tantangan analitik bisnis modern.\n\n  Dalam sambutannya, Ketua Jurusan Teknologi Informasi menyampaikan bahwa kebutuhan dunia industri terhadap data scientist, data engineer, dan analis bisnis terus meningkat setiap tahunnya. \n  Oleh karena itu, keberadaan lab ini menjadi langkah strategis dalam mempersiapkan lulusan yang mampu bersaing secara global.\n\n  Peresmian ini juga dihadiri oleh perwakilan industri sebagai mitra strategis yang siap memberikan dukungan dalam bentuk proyek riset dan pembinaan kompetensi mahasiswa.	berita1.jpg	2025-01-12	Tim Redaksi Lab BA	2025-11-26 21:13:30.068815	2025-11-26 21:13:30.068815
2	Workshop Power BI Tingkatkan Kemampuan Visualisasi Data Mahasiswa	Laboratorium Business Analytics kembali mengadakan workshop Power BI selama dua hari, dengan tujuan membekali mahasiswa kemampuan dalam membuat dashboard interaktif dan efektif. \n  Kegiatan ini dipandu oleh instruktur bersertifikasi yang memiliki pengalaman dalam implementasi Business Intelligence di perusahaan nasional.\n\n  Peserta belajar memahami proses ETL, menghubungkan dataset dari berbagai sumber, hingga merancang visualisasi yang dapat membantu pengambilan keputusan. \n  Banyak mahasiswa menyatakan bahwa pelatihan ini memberikan wawasan praktis yang belum diperoleh di dalam kelas.\n\n  Ke depan, lab berencana memperluas pelatihan serupa untuk Tableau, Looker Studio, dan Apache Superset guna memperkaya pilihan tools analitik.	berita2.jpg	2025-02-03	Laboratorium Business Analytics	2025-11-26 21:13:30.068815	2025-11-26 21:13:30.068815
3	Kolaborasi Riset Analisis Sentimen Media Sosial Dimulai	Tim riset Laboratorium Business Analytics bersama dosen dan mahasiswa memulai proyek penelitian mengenai analisis sentimen media sosial terkait perilaku konsumen di Indonesia. \n  Proyek ini akan memanfaatkan teknik Natural Language Processing dan machine learning untuk memetakan pola opini publik terhadap berbagai produk digital.\n\n  Penelitian ini diharapkan mampu memberikan kontribusi nyata bagi perusahaan dalam merancang strategi pemasaran yang lebih tepat sasaran. \n  Selain itu, mahasiswa juga mendapat kesempatan mengembangkan kemampuan riset menggunakan Python, Jupyter Notebook, dan pustaka NLP modern seperti SpaCy dan HuggingFace.\n\n  Hasil riset direncanakan dipublikasikan dalam jurnal nasional dan konferensi ilmiah teknologi informasi.	berita3.jpg	2025-03-18	Divisi Penelitian Lab BA	2025-11-26 21:13:30.068815	2025-11-26 21:13:30.068815
4	Pelatihan Data Cleaning untuk Mahasiswa Baru Informatika	Untuk memperkuat dasar analisis data sejak awal studi, Laboratorium Business Analytics menyelenggarakan pelatihan Data Cleaning khusus mahasiswa baru. \n  Pelatihan ini menekankan pentingnya integritas data, teknik penanganan missing value, duplikasi, outlier, dan inkonsistensi format.\n\n  Banyak peserta menyadari bahwa tahapan pembersihan data justru membutuhkan waktu lebih panjang dibanding analisisnya sendiri. \n  Instruktur menekankan bahwa model machine learning yang baik tidak akan tercapai tanpa dataset yang bersih dan valid.\n\n  Kegiatan ini akan menjadi agenda tahunan sebagai fondasi pembelajaran analitik di Polinema.	berita4.jpg	2025-04-02	Bidang Pengembangan Kompetensi	2025-11-26 21:13:30.068815	2025-11-26 21:13:30.068815
\.

COPY public.dosen (id, nama, keahlian, foto, created_at, updated_at) FROM stdin;
5	Dr. Farid Angga Pribadi	Business Analytics, Machine Learning	farid.jpg	2025-11-17 22:15:29.71911	2025-11-17 22:15:29.71911
11	Dr. Budi Santoso	Statistika Terapan	person.jpg	2025-11-19 22:08:21.526891	2025-11-19 22:08:21.526891
10	Prof. Siti Rahma	Big Data Analytics	person.jpg	2025-11-19 22:08:21.526891	2025-11-19 22:08:21.526891
9	Dr. Andi Wijaya	Machine Learning	person.jpg	2025-11-19 22:08:21.526891	2025-11-19 22:08:21.526891
12	Dr. Lina Kusuma	Sistem Informasi	person.jpg	2025-11-19 22:08:21.526891	2025-11-19 22:08:21.526891
15	testing	testing	logo.png	2025-12-02 17:09:53.037556	2025-12-02 17:09:53.037556
16	testing 6	testing 6	Gemini_Generated_Image_ebcj9bebcj9bebcj.png	2025-12-02 17:39:28.003435	2025-12-02 17:39:28.003435
17	testing sp view	testing sp view	person.jpg	2025-12-02 22:18:26.622954	2025-12-02 22:18:26.622954
\.

COPY public.galeri (id, judul, deskripsi, gambar, tanggal, created_at, updated_at) FROM stdin;
10	Workshop Data Analytics	Pelatihan analisis data bersama mahasiswa TI.	pexels-divinetechygirl-1181396.jpg	2025-01-10	2025-11-17 22:15:29.71911	2025-11-17 22:15:29.71911
13	Kuliah Tamu: Business Intelligence Modern	Kegiatan kuliah tamu bersama praktisi industri mengenai penerapan Business Intelligence dalam perusahaan modern.	pexels-fauxels-3183186.jpg	2025-02-05	2025-11-17 22:31:52.771979	2025-11-17 22:31:52.771979
14	Pelatihan Dashboard Menggunakan Power BI	Mahasiswa belajar membuat dashboard interaktif menggunakan Microsoft Power BI.	pexels-icsa-833425-1709003.jpg	2025-03-12	2025-11-17 22:31:52.771979	2025-11-17 22:31:52.771979
15	Kegiatan Riset Analitik Data Sosial Media	Tim lab melakukan penelitian mengenai analisis sentimen media sosial menggunakan teknik NLP.	pexels-pixabay-416405.jpg	2025-04-14	2025-11-17 22:31:52.771979	2025-11-17 22:31:52.771979
12	Workshop Pengolahan Data dengan Python	Pelatihan intensif mengenai penggunaan Python untuk analisis data dasar hingga menengah.	1763577286_pexels-fauxels-3183183.jpg	2025-01-10	2025-11-17 22:31:52.771979	2025-11-17 22:31:52.771979
\.

COPY public.jam_tidak_tersedia (id, tanggal, waktu_mulai, waktu_selesai, alasan, created_at) FROM stdin;
6	2025-11-22	08:00:00	10:00:00	-	2025-11-22 00:10:48.37451
11	2025-11-26	14:00:00	18:00:00	-	2025-11-25 21:24:08.822904
13	2025-12-03	08:00:00	15:00:00	-	2025-12-02 22:20:28.15202
\.

COPY public.kategori (id, nama) FROM stdin;
1	Data Science
2	Artificial Intelligence
3	Statistika
4	Sistem Informasi
\.

COPY public.kontak_lab (id, alamat, email, telepon, website, maps_embed, updated_at) FROM stdin;
2	Jl. Soekarno Hatta No. 9 Malang, Politeknik Negeri Malang	lab.ba@polinema.ac.id	081234567890	https://polinema.ac.id	<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d246.97072187996525!2d112.6146365458301!3d-7.943892236221397!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x2dd629dfd58aaf95%3A0xe72a182dfd18e01c!2sCivil%20Engineering%20and%20Information%20Technology%20Building%2C%20POLINEMA!5e0!3m2!1sen!2sid!4v1763392281012!5m2!1sen!2sid" width="600" height="450" style="border:0;" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>	2025-11-20 21:14:05.861099
\.

COPY public.peminjaman_lab (id, nama_peminjam, nip, tanggal_mulai, tanggal_selesai, waktu_mulai, waktu_selesai, keperluan, status, admin_id, created_at, updated_at) FROM stdin;
51	Testing 2	244000000002	2025-11-25	2025-11-25	12:00:00	15:00:00	-	ditolak	4	2025-11-25 21:13:08.772804	2025-11-25 21:19:51.010855
49	Testing 1	244000000001	2025-11-25	2025-11-25	08:00:00	11:00:00	-	disetujui	4	2025-11-25 21:11:14.834147	2025-11-25 21:19:51.521639
55	Testing 4	244000000004	2025-11-25	2025-11-25	11:00:00	11:00:00	-	menunggu	\N	2025-11-25 21:20:40.030975	2025-11-25 21:20:40.030975
56	Testing 5	244000000005	2025-11-28	2025-11-28	08:00:00	12:00:00	-	menunggu	\N	2025-11-25 21:49:20.568185	2025-11-25 21:49:20.568185
57	Testing 6	244000000006	2025-11-27	2025-11-27	08:00:00	15:00:00	-	disetujui	4	2025-11-25 23:33:59.852074	2025-11-25 23:34:42.525704
59	rahman hanif	283476234	2025-12-02	\N	08:00:00	15:00:00	adadeh	disetujui	4	2025-12-02 22:13:32.240938	2025-12-02 22:19:11.800014
58	Rahman Hanif	938423234	2025-12-02	\N	08:00:00	12:00:00	Adadeh	ditolak	4	2025-12-02 22:13:13.687131	2025-12-02 22:19:15.495799
53	Testing 3	244000000003	2025-11-26	2025-11-26	08:00:00	13:00:00	-	disetujui	4	2025-11-25 21:14:58.964306	2025-11-25 21:19:48.321613
\.

COPY public.profil_lab (id, kategori, judul, isi, created_at, updated_at) FROM stdin;
5	visi	Visi Laboratorium Business Analytics	Menjadi pusat unggulan pengembangan analitik bisnis di Polinema.	2025-11-17 22:15:29.71911	2025-11-17 22:15:29.71911
7	tujuan	Tujuan Pendirian Lab	Menjadi sarana pelatihan, penelitian, dan pengembangan kompetensi mahasiswa terkait data analytics.	2025-11-17 22:15:29.71911	2025-11-17 22:15:29.71911
8	latar belakang	Latar Belakang	Laboratorium Business Analytics didirikan berdasarkan kebutuhan akan kompetensi analitik bisnis yang meningkat di era digital.	2025-11-17 22:15:29.71911	2025-11-17 22:15:29.71911
6	misi	Misi Laboratorium Business Analytics	Mendukung kegiatan pembelajaran dan penelitian. Mengintegrasikan teknologi analitik bisnis dalam dunia industri.	2025-11-17 22:15:29.71911	2025-11-17 22:15:29.71911
\.

COPY public.publikasi (id, judul, tanggal, file, link, deskripsi, created_at) FROM stdin;
1	Analisis Prediksi Penjualan Menggunakan Random Forest	2024-05-10	\N	https://sinta.kemdiktisaintek.go.id/publication/12345	Model prediksi berbasis machine learning pada data retail.	2025-11-26 00:20:30.515256
3	Evaluasi Dashboard Business Intelligence untuk Instansi Pemerintah	2023-12-21	dashboard-bi.pdf	https://sinta.kemdiktisaintek.go.id/publication/54321	Studi usability dashboard BI berbasis Power BI.	2025-11-26 00:20:30.515256
4	Optimasi Sistem Rekomendasi Menggunakan Collaborative Filtering	2024-01-15	\N	https://sinta.kemdiktisaintek.go.id/publication/11223	Model rekomendasi untuk platform e-commerce Indonesia.	2025-11-26 00:20:30.515256
2	Implementasi Deep Learning untuk Klasifikasi Citra Medis	2024-06-02	\N	https://sinta.kemdiktisaintek.go.id/publication/98765	Penelitian klasifikasi citra CT-scan menggunakan CNN.	2025-11-26 00:20:30.515256
5	Pemodelan Regresi dalam Analisis Data Sosial	2023-11-08	regresi-sosial.pdf	https://sinta.kemdiktisaintek.go.id/publication/99887	Eksplorasi regresi multivariat pada data sosial.	2025-11-26 00:20:30.515256
\.

COPY public.publikasi_dosen (id, publikasi_id, dosen_id) FROM stdin;
10	1	9
11	1	5
13	3	11
14	4	12
15	4	9
16	2	10
17	5	9
\.

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

COPY public.settings (id, key, value, updated_at) FROM stdin;
\.

COPY public.site_settings (id, site_name, logo, footer_text, updated_at, copyright_text, logo_jti, logo_polinema, social_instagram, social_facebook, social_youtube) FROM stdin;
3	Laboratorium Business Analytics	logo.png	Transforming Data into Decisions - Laboratorium Business Analytics Politeknik Negeri Malang	2025-12-03 09:37:39.642581		Jti_polinema.svg.png	logo_polinema.png	https://www.instagram.com/	https://www.facebook.com	https://www.youtube.com
\.

SELECT pg_catalog.setval('public.admin_id_seq', 8, true);
SELECT pg_catalog.setval('public.berita_id_seq', 5, true);
SELECT pg_catalog.setval('public.dosen_id_seq', 17, true);
SELECT pg_catalog.setval('public.galeri_id_seq', 18, true);
SELECT pg_catalog.setval('public.jam_tidak_tersedia_id_seq', 13, true);
SELECT pg_catalog.setval('public.kategori_id_seq', 6, true);
SELECT pg_catalog.setval('public.kontak_lab_id_seq', 2, true);
SELECT pg_catalog.setval('public.log_aktivitas_admin_id_seq', 286, true);
SELECT pg_catalog.setval('public.peminjaman_lab_id_seq', 59, true);
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