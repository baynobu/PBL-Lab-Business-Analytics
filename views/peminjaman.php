<?php
// $week, $slots, $jadwal, $alert, $riwayat sudah tersedia dari controller
function slotState($slot, $tanggal, $jadwal, $jamTidakTersedia = [])
{
    // Cek slot tidak tersedia dari jam_tidak_tersedia
    foreach ($jamTidakTersedia as $jtt) {
        if ($jtt['tanggal'] == $tanggal) {
            $mulai = substr($jtt['waktu_mulai'], 0, 5);
            $selesai = substr($jtt['waktu_selesai'], 0, 5);
            // Perbaiki: blokir slot jika $slot >= $mulai dan $slot < $selesai
            if ($slot >= $mulai && $slot < $selesai) {
                return 'secondary'; // abu-abu
            }
            // Jika $slot == $selesai, blokir juga slot selesai
            if ($slot == $selesai) {
                return 'secondary';
            }
        }
    }
    // Cek jadwal peminjaman
    foreach ($jadwal as $b) {
        if ($b['tanggal_mulai'] == $tanggal) {
            $mulai = substr($b['waktu_mulai'], 0, 5);
            $selesai = substr($b['waktu_selesai'], 0, 5);
            if ($slot >= $mulai && $slot < $selesai) {
                if ($b['status'] == 'disetujui') return 'danger'; // merah
                if ($b['status'] == 'menunggu') return 'warning'; // kuning
                if ($b['status'] == 'ditolak') return 'outline-primary'; // biru
                if ($b['status'] == 'tidak tersedia') return 'secondary'; // abu-abu
            }
        }
    }
    return 'outline-primary'; // default biru
}
?>
<!DOCTYPE html>
<html lang="id">

<head>
    <title>Peminjaman Lab</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
    <style>
        .slot-btn {
            width: 100%;
            margin-bottom: 6px;
        }

        .slot-btn.danger {
            background: #f87171;
            color: #fff;
        }

        .slot-btn.success {
            background: #4ade80;
            color: #fff;
        }

        .slot-btn.warning {
            border: 2px solid #facc15;
            background: #fffbe6;
            color: #b45309;
        }

        .slot-btn.secondary {
            background: #e5e7eb;
            color: #6b7280;
        }

        .slot-btn.outline-primary {
            background: #fff;
            border: 1px solid #60a5fa;
            color: #2563eb;
        }
    </style>
</head>

<body class="bg-light">
    <main class="container py-5">
        <div class="row g-4 align-items-start">
            <div class="col-lg-5 col-md-6 mb-4">
                <?php if (!empty($alert)): ?>
                    <div class="alert alert-<?= $alert['type'] ?>"><?= $alert['msg'] ?></div>
                <?php endif; ?>
                <form method="POST" id="formPeminjaman" class="card p-4 shadow-sm mb-4">
                    <h5 class="mb-3">Form Peminjaman</h5>
                    <div class="mb-2">
                        <input type="text" name="nama" class="form-control" placeholder="Nama peminjam" required>
                    </div>
                    <div class="mb-2">
                        <input type="text" name="nip" class="form-control" placeholder="NIP">
                    </div>
                    <div class="mb-2">
                        <input type="date" name="tanggal" class="form-control" required>
                    </div>
                    <div class="mb-2">
                        <select name="mulai" class="form-control" required>
                            <option value="">Pilih jam mulai</option>
                            <?php foreach ($slots as $s): ?>
                                <option value="<?= $s ?>"><?= $s ?></option>
                            <?php endforeach; ?>
                        </select>
                    </div>
                    <div class="mb-2">
                        <select name="selesai" class="form-control" required>
                            <option value="">Pilih jam selesai</option>
                            <?php foreach ($slots as $s): ?>
                                <option value="<?= $s ?>"><?= $s ?></option>
                            <?php endforeach; ?>
                        </select>
                    </div>
                    <div class="mb-2">
                        <input type="text" name="keperluan" class="form-control" placeholder="Keperluan" required>
                    </div>
                    <button type="submit" class="btn btn-primary w-100">Pinjam Lab</button>
                    <small class="text-muted d-block mt-2">Setelah submit Anda akan melihat jadwal; slot yang terisi akan berwarna.</small>
                </form>
                <div class="mt-5">
                    <h6 class="mb-3">Riwayat Peminjaman</h6>
                    <div class="card p-3 shadow-sm mb-4">
                        <div class="table-responsive">
                            <table class="table table-hover align-middle mb-0">
                                <thead class="table-light">
                                    <tr>
                                        <th>Nama Peminjam</th>
                                        <th>Tanggal</th>
                                        <th>Waktu</th>
                                        <th>Status Pengajuan</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <?php foreach ($riwayat as $r): ?>
                                        <tr>
                                            <td class="fw-semibold text-primary-custom"><?= htmlspecialchars($r['nama_peminjam']) ?></td>
                                            <td>
                                                <?= htmlspecialchars($r['tanggal_mulai']) ?>
                                                <?php if ($r['tanggal_selesai']): ?>
                                                    <span class="mx-1">→</span> <?= htmlspecialchars($r['tanggal_selesai']) ?>
                                                <?php endif; ?>
                                            </td>
                                            <td><?= htmlspecialchars($r['waktu_mulai']) ?> - <?= htmlspecialchars($r['waktu_selesai']) ?></td>
                                            <td>
                                                <?php
                                                $status = strtolower($r['status']);
                                                $badge = 'secondary';
                                                if ($status === 'disetujui' || $status === 'approved') $badge = 'danger';
                                                elseif ($status === 'ditolak' || $status === 'rejected') $badge = 'secondary';
                                                elseif ($status === 'menunggu' || $status === 'pending') $badge = 'warning';
                                                elseif ($status === 'tidak tersedia') $badge = 'secondary';
                                                ?>
                                                <span class="badge bg-<?= $badge ?>"><?= htmlspecialchars($r['status']) ?></span>
                                            </td>
                                        </tr>
                                    <?php endforeach; ?>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-lg-7 col-md-6">
                <div class="card p-3 shadow-sm mb-4">
                    <div class="d-flex justify-content-between align-items-center mb-2">
                        <h5 class="mb-0">Jadwal Peminjaman</h5>
                        <button class="btn btn-outline-primary btn-sm" onclick="document.getElementById('formPeminjaman').submit();">Refresh Jadwal</button>
                    </div>
                    <div class="d-flex mb-2">
                        <span class="badge bg-primary me-2">Tersedia</span>
                        <span class="badge bg-danger me-2">Terisi</span>
                        <span class="badge bg-warning text-dark me-2">Menunggu</span>
                        <span class="badge bg-secondary me-2">Tidak Tersedia</span>
                    </div>
                    <div class="row">
                        <?php foreach ($week as $i => $day): ?>
                            <div class="col">
                                <div class="text-center fw-bold mb-1" style="font-size:1rem;"><?= $day->format('l') ?></div>
                                <div class="text-center small mb-2" style="font-size:0.9rem;"><?= $day->format('d F Y') ?></div>
                                <?php foreach ($slots as $slot):
                                    $state = slotState($slot, $day->format('Y-m-d'), $jadwal, isset($jamTidakTersedia) ? $jamTidakTersedia : []);
                                ?>
                                    <div class="slot-btn <?= $state ?> rounded text-center mb-1" style="font-size:0.95rem;">
                                        <?= $slot ?>
                                    </div>
                                <?php endforeach; ?>
                            </div>
                        <?php endforeach; ?>
                    </div>
                </div>
            </div>
        </div>
        <div class="d-grid mt-3 mb-5">
            <a href="index.php" class="btn btn-secondary btn-lg rounded-pill fw-bold shadow-sm">Kembali</a>
        </div>
    </main>
</body>

</html>