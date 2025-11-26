<?php
require_once "../app/models/Profil.php";
require_once "../app/models/Galeri.php";
require_once "../app/models/Dosen.php";
require_once "../app/models/KontakLab.php";
include "../views/layouts/header.php";
?>

<!-- HERO SECTION MODERN -->
<section id="hero" class="text-white py-5 mb-0 position-relative" style="background: linear-gradient(120deg, #0A2A43 60%, #3FA2F7 100%); min-height: 80vh; display: flex; align-items: center; overflow:hidden;">
    <!-- SVG Shape Background -->
    <svg viewBox="0 0 1440 320" style="position:absolute;bottom:0;left:0;width:100%;z-index:0;opacity:0.12;pointer-events:none;">
        <path fill="#fff" fill-opacity="1" d="M0,224L60,202.7C120,181,240,139,360,144C480,149,600,203,720,197.3C840,192,960,128,1080,117.3C1200,107,1320,149,1380,170.7L1440,192L1440,320L1380,320C1320,320,1200,320,1080,320C960,320,840,320,720,320C600,320,480,320,360,320C240,320,120,320,60,320L0,320Z"></path>
    </svg>
    <div class="container position-relative" style="z-index:1;">
        <div class="row align-items-center justify-content-center">
            <div class="col-lg-6 mb-4 mb-lg-0 text-lg-start text-center">
                <h1 class="display-3 fw-bold mb-3" style="letter-spacing:1px;line-height:1.1;">Transforming Data<br><span class="text-accent">into Decisions</span></h1>
                <p class="lead mb-4">Laboratorium Business Analytics<br>Politeknik Negeri Malang</p>
                <div class="d-flex flex-column flex-sm-row gap-3 justify-content-lg-start justify-content-center align-items-center">
                    <a href="/lab-ba/public/peminjaman.php" class="btn btn-lg px-5 py-3 fw-bold shadow btn-accent rounded-pill">Ajukan Peminjaman Lab <i class="bi bi-arrow-right ms-2"></i></a>
                </div>
            </div>
            <div class="col-lg-5 d-flex align-items-center justify-content-lg-end justify-content-center ps-lg-5" style="min-height:340px;">
                <div class="w-100 d-flex flex-column align-items-center align-items-lg-end justify-content-center">
                    <img src="/lab-ba/public/assets/img/maskot.png" alt="Maskot Lab BA" class="img-fluid mb-3 shadow-lg animate__animated animate__fadeInRight hero-maskot-img" style="max-width:530px; width:100%; height:auto;">
                </div>
            </div>
</section>

<style>
    /* Responsive maskot size and spacing */

    .hero-maskot-img {
        max-width: 530px;
        width: 100%;
        height: auto;
        box-shadow: 0 8px 32px 0 rgba(10, 42, 67, 0.18), 0 1.5px 8px 0 rgba(63, 162, 247, 0.10);
        border-radius: 24px;
        background: transparent;
        margin-bottom: 0.5rem;
        margin-right: 0;
        margin-left: 0;
        transition: transform 0.3s cubic-bezier(.4, 2, .6, 1);
    }

    @media (min-width: 1200px) {
        .hero-maskot-img {
            margin-right: 32px;
        }
    }

    .hero-maskot-img:hover {
        transform: scale(1.04) rotate(-2deg);
        box-shadow: 0 12px 40px 0 rgba(10, 42, 67, 0.22), 0 2px 12px 0 rgba(63, 162, 247, 0.13);
    }


    @media (min-width: 992px) {
        .hero-maskot-img {
            max-width: 530px;
            margin-right: 0;
        }
    }

    @media (max-width: 991.98px) {
        .hero-maskot-img {
            max-width: 220px;
        }
    }

    @media (max-width: 575.98px) {
        .hero-maskot-img {
            max-width: 160px;
        }
    }
</style>
</div>
</div>
</section>

<!-- SEKILAS PROFIL -->
<section id="profile" class="bg-white py-5">
    <div class="container">
        <h2 class="section-title">Profil Laboratorium</h2>
        <?php foreach (Profil::all() as $p): ?>
            <div class="mb-4">
                <h5 class="fw-semibold mb-1 text-primary-custom"><?= $p['judul']; ?> <span class="badge bg-accent ms-2"><?= $p['kategori']; ?></span></h5>
                <p><?= nl2br($p['isi']); ?></p>
            </div>
        <?php endforeach; ?>
    </div>
</section>

<!-- GALERI SLIDER -->
<!-- SECTION PUBLIKASI -->
<section id="publikasi" class="bg-white py-5">
    <div class="container">
        <h2 class="section-title">Publikasi</h2>
        <?php
        require_once "../app/models/Publikasi.php";
        $publikasiList = Publikasi::all();
        if (count($publikasiList) === 0): ?>
            <div class="alert alert-info">Belum ada publikasi.</div>
        <?php else: ?>
            <div class="row g-4">
                <?php foreach (array_slice($publikasiList, 0, 4) as $pub): ?>
                    <div class="col-md-6 col-lg-3">
                        <div class="card h-100 shadow-sm border-0">
                            <div class="card-body d-flex flex-column">
                                <h5 class="card-title text-primary-custom mb-2"><?= htmlspecialchars($pub['judul']) ?></h5>
                                <div class="mb-1 text-muted small">
                                    Oleh:
                                    <?php $dosen = Publikasi::getDosen($pub['id']); ?>
                                    <?php if ($dosen): ?>
                                        <?php foreach ($dosen as $ds): ?>
                                            <span class="badge bg-info text-dark me-1 mb-1"> <?= htmlspecialchars($ds['nama']) ?> </span>
                                        <?php endforeach; ?>
                                    <?php else: ?>
                                        <span class="text-muted">Tidak ada peneliti</span>
                                    <?php endif; ?>
                                </div>
                                <div class="mb-2 text-muted small">Tanggal: <?= htmlspecialchars($pub['tanggal']) ?></div>
                                <div class="mb-2" style="min-height:48px;">
                                    <?= nl2br(htmlspecialchars(mb_strimwidth($pub['deskripsi'], 0, 80, '...'))) ?>
                                </div>
                                <?php if ($pub['file']): ?>
                                    <a href="/lab-ba/public/uploads/publikasi/<?= htmlspecialchars($pub['file']) ?>" target="_blank" class="btn btn-outline-accent btn-sm mb-1">Download File</a>
                                <?php endif; ?>
                                <?php if ($pub['link']): ?>
                                    <a href="<?= htmlspecialchars($pub['link']) ?>" target="_blank" class="btn btn-outline-accent btn-sm mb-1">Lihat Link</a>
                                <?php endif; ?>
                            </div>
                        </div>
                    </div>
                <?php endforeach; ?>
            </div>
            <div class="text-end mt-3">
                <a href="publikasi.php" class="btn btn-outline-accent btn-sm">Lihat Semua Publikasi</a>
            </div>
        <?php endif; ?>
    </div>
</section>
<section id="galeri" class="bg-accent bg-opacity-10 py-5">
    <div class="container">
        <h2 class="section-title">Galeri Kegiatan</h2>
        <div id="carouselGaleri" class="carousel slide mb-3" data-bs-ride="carousel">
            <div class="carousel-inner">
                <?php $i = 0;
                $galeriList = Galeri::all();
                foreach ($galeriList as $g): ?>
                    <div class="carousel-item <?= $i == 0 ? 'active' : '' ?>">
                        <img src="/lab-ba/public/uploads/galeri/<?= $g['gambar']; ?>" class="d-block w-100 rounded galeri-img" style="max-height: 400px; object-fit: cover; cursor:pointer;" data-bs-toggle="modal" data-bs-target="#galeriModal<?= $g['id'] ?>">
                        <div class="carousel-caption d-none d-md-block bg-dark bg-opacity-50 rounded">
                            <h5><?= $g['judul']; ?></h5>
                        </div>
                    </div>
                <?php $i++;
                endforeach; ?>
            </div>
            <button class="carousel-control-prev" type="button" data-bs-target="#carouselGaleri" data-bs-slide="prev">
                <span class="carousel-control-prev-icon"></span>
            </button>
            <button class="carousel-control-next" type="button" data-bs-target="#carouselGaleri" data-bs-slide="next">
                <span class="carousel-control-next-icon"></span>
            </button>
        </div>
        <div class="text-end">
            <a href="/lab-ba/public/galeri.php" class="btn btn-outline-accent btn-sm">Lihat Semua Galeri</a>
        </div>

        <!-- Galeri Modals -->
        <?php foreach ($galeriList as $g): ?>
            <div class="modal fade" id="galeriModal<?= $g['id'] ?>" tabindex="-1" aria-labelledby="galeriModalLabel<?= $g['id'] ?>" aria-hidden="true">
                <div class="modal-dialog modal-lg modal-dialog-centered">
                    <div class="modal-content rounded-4 overflow-hidden shadow-lg border-0" style="background:rgba(255,255,255,0.98);">
                        <div class="position-relative">
                            <img src="/lab-ba/public/uploads/galeri/<?= htmlspecialchars($g['gambar']) ?>" class="w-100" style="max-height:340px;object-fit:cover;object-position:center;">
                            <button type="button" class="btn-close position-absolute top-0 end-0 m-3 bg-white rounded-circle p-2" data-bs-dismiss="modal" aria-label="Close" style="z-index:2;"></button>
                        </div>
                        <div class="p-4 p-md-5 text-center">
                            <h3 class="fw-bold mb-2 text-primary-custom" id="galeriModalLabel<?= $g['id'] ?>">
                                <i class="bi bi-image me-2 text-accent"></i><?= htmlspecialchars($g['judul']) ?>
                            </h3>
                            <div class="mb-3 text-muted small"><i class="bi bi-calendar-event me-1"></i> <?= htmlspecialchars($g['tanggal'] ?? '-') ?></div>
                            <div class="mb-3 fs-5 px-2 py-3 rounded-3" style="background:rgba(63,162,247,0.07);display:inline-block;min-width:180px;">
                                <i class="bi bi-chat-left-text me-2 text-accent"></i><?= nl2br(htmlspecialchars($g['deskripsi'] ?? '')) ?>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        <?php endforeach; ?>
    </div>
</section>


<!-- SECTION DOSEN -->
<section id="dosen" class="bg-white py-5">
    <div class="container">
        <h2 class="section-title">Dosen Pengampu</h2>
        <div class="row g-4">
            <?php $dosenList = Dosen::all();
            foreach ($dosenList as $d): ?>
                <div class="col-md-4 col-lg-3">
                    <div class="card h-100 shadow-sm border-0 dosen-card" style="cursor:pointer;" data-bs-toggle="modal" data-bs-target="#dosenModal<?= $d['id'] ?>">
                        <?php if (!empty($d['foto'])): ?>
                            <img src="/lab-ba/public/uploads/dosen/<?= htmlspecialchars($d['foto']) ?>" class="card-img-top" alt="<?= htmlspecialchars($d['nama']) ?>" style="object-fit:cover;max-height:220px;">
                        <?php endif; ?>
                        <div class="card-body">
                            <h5 class="card-title mb-1 text-primary-custom"><?= htmlspecialchars($d['nama']) ?></h5>
                            <div class="text-muted small mb-2"><?= htmlspecialchars($d['keahlian']) ?></div>
                        </div>
                    </div>
                </div>
            <?php endforeach; ?>
        </div>

        <!-- Dosen Modals -->
        <?php foreach ($dosenList as $d): ?>
            <div class="modal fade" id="dosenModal<?= $d['id'] ?>" tabindex="-1" aria-labelledby="dosenModalLabel<?= $d['id'] ?>" aria-hidden="true">
                <div class="modal-dialog modal-lg modal-dialog-centered">
                    <div class="modal-content rounded-4 overflow-hidden shadow-lg border-0" style="background:rgba(255,255,255,0.98);">
                        <div class="position-relative">
                            <?php if (!empty($d['foto'])): ?>
                                <img src="/lab-ba/public/uploads/dosen/<?= htmlspecialchars($d['foto']) ?>" class="w-100" style="max-height:320px;object-fit:cover;object-position:center;">
                            <?php endif; ?>
                            <button type="button" class="btn-close position-absolute top-0 end-0 m-3 bg-white rounded-circle p-2" data-bs-dismiss="modal" aria-label="Close" style="z-index:2;"></button>
                        </div>
                        <div class="p-4 p-md-5 text-center">
                            <h3 class="fw-bold mb-2 text-primary-custom" id="dosenModalLabel<?= $d['id'] ?>">
                                <i class="bi bi-person-badge me-2 text-accent"></i><?= htmlspecialchars($d['nama']) ?>
                            </h3>
                            <div class="mb-3 text-muted small"><i class="bi bi-award me-1"></i> <?= htmlspecialchars($d['keahlian']) ?></div>
                            <?php if (!empty($d['deskripsi'])): ?>
                                <div class="mb-3 fs-5 px-2 py-3 rounded-3" style="background:rgba(63,162,247,0.07);display:inline-block;min-width:180px;">
                                    <i class="bi bi-chat-left-text me-2 text-accent"></i><?= nl2br(htmlspecialchars($d['deskripsi'])) ?>
                                </div>
                            <?php endif; ?>
                        </div>
                    </div>
                </div>
            </div>
        <?php endforeach; ?>
    </div>
</section>




<!-- SECTION KONTAK LAB -->

<section id="kontak" class="bg-accent text-white py-5">
    <div class="container">
        <h2 class="section-title text-white">Kontak Lab</h2>
        <?php $kontak = KontakLab::get(); ?>
        <div class="row">
            <div class="col-md-6 mb-4 mb-md-0">
                <div class="mb-2"><strong>Alamat:</strong><br><?= nl2br(htmlspecialchars($kontak['alamat'] ?? '-')) ?></div>
                <div class="mb-2"><strong>Email:</strong> <a href="mailto:<?= htmlspecialchars($kontak['email'] ?? '') ?>" class="text-white text-decoration-underline"><?= htmlspecialchars($kontak['email'] ?? '-') ?></a></div>
                <div class="mb-2"><strong>Telepon:</strong> <?= htmlspecialchars($kontak['telepon'] ?? '-') ?></div>
                <?php if (!empty($kontak['website'])): ?>
                    <div class="mb-2"><strong>Website:</strong> <a href="<?= htmlspecialchars($kontak['website']) ?>" class="text-white text-decoration-underline" target="_blank"><?= htmlspecialchars($kontak['website']) ?></a></div>
                <?php endif; ?>
            </div>
            <div class="col-md-6">
                <?php if (!empty($kontak['maps_embed'])): ?>
                    <div class="ratio ratio-4x3"> <?= $kontak['maps_embed'] ?> </div>
                <?php endif; ?>
            </div>
        </div>
    </div>
</section>

<style>
    .text-accent {
        color: #3FA2F7 !important;
    }

    .border-accent {
        border-color: #3FA2F7 !important;
    }

    .link-kontak {
        text-decoration: underline;
        transition: color 0.2s;
    }

    .link-kontak:hover,
    .link-kontak:focus {
        color: #3FA2F7 !important;
        text-decoration: none;
    }

    .backdrop-blur {
        backdrop-filter: blur(6px);
        -webkit-backdrop-filter: blur(6px);
    }

    .modal-content.rounded-4 {
        border-radius: 1.5rem !important;
        box-shadow: 0 8px 40px 0 rgba(10, 42, 67, 0.18), 0 1.5px 8px 0 rgba(63, 162, 247, 0.10);
        animation: galeriPop .4s cubic-bezier(.4, 2, .6, 1) both;
    }

    .modal-content img.w-100 {
        border-bottom-left-radius: 1.5rem;
        border-bottom-right-radius: 1.5rem;
    }

    @media (max-width: 767.98px) {
        .modal-content.rounded-4 {
            border-radius: 1rem !important;
        }

        .modal-content img.w-100 {
            border-bottom-left-radius: 1rem;
            border-bottom-right-radius: 1rem;
            max-height: 180px;
        }

        .p-md-5 {
            padding: 1.5rem !important;
        }
    }

    @keyframes galeriPop {
        0% {
            transform: scale(.85) translateY(40px);
            opacity: 0;
        }

        100% {
            transform: scale(1) translateY(0);
            opacity: 1;
        }
    }
</style>

<?php include "../views/layouts/footer.php"; ?>