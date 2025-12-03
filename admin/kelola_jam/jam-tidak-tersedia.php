<?php
require_once "../../app/utils/session.php";
checkAdminLogin();
require_once "../../app/models/JamTidakTersedia.php";
require_once "../../app/utils/log.php";

// Handle insert/delete (PRG harus sebelum output apapun)
$alert = null;
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    if (isset($_POST['action']) && $_POST['action'] === 'add') {
        $tanggal = $_POST['tanggal'] ?? '';
        $mulai = $_POST['mulai'] ?? '';
        $selesai = $_POST['selesai'] ?? '';
        $alasan = $_POST['alasan'] ?? '';
        if ($tanggal && $mulai && $selesai && $alasan) {
            $validTimes = ["08:00", "09:00", "10:00", "11:00", "12:00", "13:00", "14:00", "15:00", "16:00", "17:00", "18:00"];
            // Validasi tanggal minimal hari ini
            if (strtotime($tanggal) < strtotime(date('Y-m-d'))) {
                $alert = ['type' => 'danger', 'msg' => 'Tanggal tidak boleh sebelum hari ini!'];
            }
            // Validasi backend waktu mulai dan selesai
            elseif (!in_array($mulai, $validTimes) || !in_array($selesai, $validTimes)) {
                $alert = ['type' => 'danger', 'msg' => 'Waktu hanya boleh antara 08:00 sampai 18:00 dan kelipatan 1 jam!'];
            } else {
                // Cek bentrok dengan jadwal disetujui
                require_once '../../app/models/Peminjaman.php';
                if (!Peminjaman::isSlotAvailable($tanggal, $mulai, $selesai)) {
                    $alert = ['type' => 'danger', 'msg' => 'Jam tidak tersedia karena sudah ada peminjaman disetujui pada waktu tersebut!'];
                } else {
                    JamTidakTersedia::insertSP($tanggal, $mulai, $selesai, $alasan);
                    logActivity("Tambah jam tidak tersedia: $tanggal $mulai-$selesai ($alasan)");
                    header('Location: jam-tidak-tersedia.php?success=1');
                    exit;
                }
            }
        } else {
            $alert = ['type' => 'danger', 'msg' => 'Semua field wajib diisi!'];
        }
    } elseif (isset($_POST['action']) && $_POST['action'] === 'delete' && isset($_POST['id'])) {
        JamTidakTersedia::delete($_POST['id']);
        logActivity("Hapus jam tidak tersedia ID: " . $_POST['id']);
        $alert = ['type' => 'success', 'msg' => 'Jam tidak tersedia berhasil dihapus.'];
    }
}

$data = JamTidakTersedia::allByRange(date('Y-m-d', strtotime('-30 days')), date('Y-m-d', strtotime('+30 days')));
include "../../views/layouts/header.php";
?>
<section class="bg-white py-5 min-vh-100">
    <div class="container">
        <div class="text-center mb-5">
            <h2 class="fw-bold mb-1 text-primary-custom">Kelola Jam Tidak Tersedia</h2>
            <div class="text-muted">Admin dapat menambah/menghapus jam tidak tersedia</div>
        </div>
        <?php if ($alert): ?>
            <div class="alert alert-<?= $alert['type'] ?>"><?= $alert['msg'] ?></div>
        <?php endif; ?>
        <div class="card shadow-lg border-0 rounded-4 mb-4">
            <div class="card-body p-4">
                <form method="POST" class="row g-3 align-items-end">
                    <input type="hidden" name="action" value="add">
                    <div class="col-md-3">
                        <label class="form-label">Tanggal</label>
                        <input type="date" name="tanggal" class="form-control" required>
                    </div>
                    <div class="col-md-2">
                        <label class="form-label">Mulai</label>
                        <select name="mulai" class="form-control" required>
                            <option value="">Pilih jam mulai</option>
                            <option value="08:00">08:00</option>
                            <option value="09:00">09:00</option>
                            <option value="10:00">10:00</option>
                            <option value="11:00">11:00</option>
                            <option value="12:00">12:00</option>
                            <option value="13:00">13:00</option>
                            <option value="14:00">14:00</option>
                            <option value="15:00">15:00</option>
                            <option value="16:00">16:00</option>
                            <option value="17:00">17:00</option>
                            <option value="18:00">18:00</option>
                        </select>
                    </div>
                    <div class="col-md-2">
                        <label class="form-label">Selesai</label>
                        <select name="selesai" class="form-control" required>
                            <option value="">Pilih jam selesai</option>
                            <option value="08:00">08:00</option>
                            <option value="09:00">09:00</option>
                            <option value="10:00">10:00</option>
                            <option value="11:00">11:00</option>
                            <option value="12:00">12:00</option>
                            <option value="13:00">13:00</option>
                            <option value="14:00">14:00</option>
                            <option value="15:00">15:00</option>
                            <option value="16:00">16:00</option>
                            <option value="17:00">17:00</option>
                            <option value="18:00">18:00</option>
                        </select>
                    </div>
                    <div class="col-md-3">
                        <label class="form-label">Alasan</label>
                        <input type="text" name="alasan" class="form-control" required>
                    </div>
                    <div class="col-md-2">
                        <button type="submit" class="btn btn-primary w-100">Tambah</button>
                    </div>
                </form>
            </div>
        </div>
        <div class="card shadow-lg border-0 rounded-4">
            <div class="card-body p-4">
                <div class="table-responsive">
                    <table class="table table-hover align-middle mb-0">
                        <thead class="table-light">
                            <tr>
                                <th>Tanggal</th>
                                <th>Mulai</th>
                                <th>Selesai</th>
                                <th>Alasan</th>
                                <th>Aksi</th>
                            </tr>
                        </thead>
                        <tbody>
                            <?php foreach ($data as $d): ?>
                                <tr>
                                    <td><?= htmlspecialchars($d['tanggal']) ?></td>
                                    <td><?= htmlspecialchars($d['waktu_mulai']) ?></td>
                                    <td><?= htmlspecialchars($d['waktu_selesai']) ?></td>
                                    <td><?= htmlspecialchars($d['alasan']) ?></td>
                                    <td>
                                        <form method="POST" style="display:inline-block">
                                            <input type="hidden" name="action" value="delete">
                                            <input type="hidden" name="id" value="<?= $d['id'] ?>">
                                            <button type="submit" class="btn btn-danger btn-sm" onclick="return confirm('Hapus jam tidak tersedia ini?')">Hapus</button>
                                        </form>
                                    </td>
                                </tr>
                            <?php endforeach; ?>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        <div class="container mb-5">
            <div class="d-grid mt-4">
                <a href="../dashboard.php" class="btn btn-secondary btn-lg rounded-pill fw-bold shadow-sm">Kembali</a>
            </div>
        </div>
    </div>
</section>
<style>
    .text-primary-custom {
        color: #0A2A43 !important;
    }
</style>
<?php include "../../views/layouts/footer.php"; ?>