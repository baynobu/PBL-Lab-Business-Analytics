<?php
require_once "../app/models/Dosen.php";
include "../views/layouts/header.php";
$dosenList = Dosen::all();
?>

<section class="bg-white py-5 min-vh-100">
    <div class="container">
        <div class="text-center mb-5">
            <h2 class="fw-bold mb-1 text-primary-custom">Daftar Dosen Pengampu</h2>
            <div class="text-muted">Profil dosen pengampu Laboratorium Business Analytics</div>
        </div>
        <div class="row g-4">
            <?php foreach ($dosenList as $d): ?>
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

<style>
    .text-primary-custom {
        color: #0A2A43 !important;
    }

    .dosen-card:hover {
        box-shadow: 0 8px 32px 0 rgba(10, 42, 67, 0.13), 0 1.5px 8px 0 rgba(63, 162, 247, 0.10);
        transform: translateY(-2px) scale(1.01);
        transition: box-shadow .2s, transform .2s;
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