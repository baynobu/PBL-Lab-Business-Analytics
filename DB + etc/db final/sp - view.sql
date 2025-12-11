-- View 1: Jadwal Peminjaman (kompatibel dengan skema: nip & nama_lengkap)
CREATE OR REPLACE VIEW public.view_jadwal_peminjaman AS
SELECT 
    p.id,
    p.nama_peminjam,
    p.nip, -- perbaikan: kolom yang benar di schema
    p.tanggal_mulai,
    p.tanggal_selesai,
    p.waktu_mulai,
    p.waktu_selesai,
    p.keperluan,
    p.status,
    COALESCE(a.nama_lengkap, a.username) AS admin_nama, -- perbaikan: admin.nama_lengkap/username
    p.created_at
FROM public.peminjaman_lab p
LEFT JOIN public.admin a ON p.admin_id = a.id;
-- Catatan: ORDER BY dihilangkan dari definisi view. Gunakan ORDER BY saat SELECT dari view sesuai kebutuhan.


-- View 2: Publikasi Lengkap (hindari duplikasi dosen dengan DISTINCT dan urutkan alfabetis)
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


-- Procedure 1: Tambah Pengajuan Peminjaman Dengan Validasi Bentrok
-- Perbaikan: pakai kolom nip, validasi waktu, cek bentrok dg jadwal 'disetujui', dan cek blokir di jam_tidak_tersedia
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
$$ LANGUAGE plpgsql;


-- Procedure 2: Set Jam Tidak Tersedia (opsional: bisa tambahkan validasi bentrok jika diinginkan)
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


-- Procedure 3: Tambah Publikasi beserta relasi Dosen & Kategori
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