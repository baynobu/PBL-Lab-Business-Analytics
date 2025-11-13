<?php
require_once "../app/utils/session.php";
checkAdminLogin();
require_once "../app/models/Admin.php";
require_once "../app/utils/log.php";

$data = Admin::all();
include "../views/layouts/header.php";
?>


<section class="py-4 min-vh-100 bg-white">
    <div class="container">
        <div class="d-flex flex-wrap align-items-center justify-content-between mb-4 gap-2">
            <h3 class="fw-bold text-primary-custom mb-0">Manajemen Admin</h3>
            <a href="admin_tambah.php" class="btn btn-accent rounded-pill fw-semibold"><i class="bi bi-person-plus me-1"></i>Tambah Admin</a>
        </div>
        <div class="card shadow-lg border-0 rounded-4">
            <div class="card-body p-4">
                <div class="table-responsive">
                    <table class="table table-hover align-middle mb-0">
                        <thead class="table-light">
                            <tr>
                                <th>Nama</th>
                                <th>Username</th>
                                <th>Aksi</th>
                            </tr>
                        </thead>
                        <tbody>
                            <?php foreach ($data as $a): ?>
                                <tr>
                                    <td><?= htmlspecialchars($a['nama_lengkap']) ?></td>
                                    <td><?= htmlspecialchars($a['username']) ?></td>
                                    <td>
                                        <a href="admin_edit.php?id=<?= $a['id']; ?>" class="btn btn-warning btn-sm rounded-pill px-3"><i class="bi bi-pencil-square"></i> Edit</a>
                                        <?php if ($a['id'] != $_SESSION['admin_id']): ?>
                                            <a href="admin_hapus.php?id=<?= $a['id']; ?>" class="btn btn-danger btn-sm rounded-pill px-3 ms-1" onclick="return confirm('Hapus admin ini?')"><i class="bi bi-trash"></i> Hapus</a>
                                        <?php endif; ?>
                                    </td>
                                </tr>
                            <?php endforeach; ?>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</section>

<style>
    .text-primary-custom {
        color: #0A2A43 !important;
    }

    .btn-accent {
        background-color: #3FA2F7;
        color: #fff;
        border: none;
    }

    .btn-accent:hover,
    .btn-accent:focus {
        background: #2196f3;
        color: #fff;
    }
</style>

<?php include "../views/layouts/footer.php"; ?>