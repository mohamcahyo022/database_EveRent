-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 07 Okt 2023 pada 22.49
-- Versi server: 10.4.27-MariaDB
-- Versi PHP: 8.2.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `eve_rent`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `acara`
--

CREATE TABLE `acara` (
  `id_acara` int(10) NOT NULL,
  `id_pembuatAcara` int(10) NOT NULL,
  `id_penyewa` int(10) NOT NULL,
  `id_tempat` int(10) NOT NULL,
  `id_pedagang` int(10) NOT NULL,
  `nama` varchar(100) NOT NULL,
  `jenis` varchar(60) NOT NULL,
  `jumlah_pedagang` int(20) NOT NULL,
  `waktu_acara` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `pedagang`
--

CREATE TABLE `pedagang` (
  `id_pedagang` int(10) NOT NULL,
  `id_acara` int(10) NOT NULL,
  `nama` varchar(80) NOT NULL,
  `jenis_dagangan` varchar(100) NOT NULL,
  `alamat` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `pembuat_acara`
--

CREATE TABLE `pembuat_acara` (
  `id_pembuatAcara` int(20) NOT NULL,
  `nama` varchar(100) NOT NULL,
  `alamat` text NOT NULL,
  `nomor_wa` int(20) NOT NULL,
  `waktu_dibuat` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `penyewaan_tempat`
--

CREATE TABLE `penyewaan_tempat` (
  `id_penyewa` int(10) NOT NULL,
  `id_acara` int(10) NOT NULL,
  `nama` varchar(100) NOT NULL,
  `nomor_hp` int(20) NOT NULL,
  `alamat` varchar(255) NOT NULL,
  `waktu_dibuat` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `tempat`
--

CREATE TABLE `tempat` (
  `id_tempat` int(10) NOT NULL,
  `id_penyewa` int(10) NOT NULL,
  `id_acara` int(10) NOT NULL,
  `nama` varchar(100) NOT NULL,
  `lokasi` text NOT NULL,
  `luas` int(40) NOT NULL,
  `kapasitas` int(20) NOT NULL,
  `fasilitas` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `acara`
--
ALTER TABLE `acara`
  ADD PRIMARY KEY (`id_acara`),
  ADD KEY `id_pembuatAcara` (`id_pembuatAcara`),
  ADD KEY `id_penyewa` (`id_penyewa`),
  ADD KEY `id_tempat` (`id_tempat`),
  ADD KEY `id_pedagang` (`id_pedagang`);

--
-- Indeks untuk tabel `pedagang`
--
ALTER TABLE `pedagang`
  ADD PRIMARY KEY (`id_pedagang`),
  ADD KEY `id_acara` (`id_acara`);

--
-- Indeks untuk tabel `pembuat_acara`
--
ALTER TABLE `pembuat_acara`
  ADD PRIMARY KEY (`id_pembuatAcara`);

--
-- Indeks untuk tabel `penyewaan_tempat`
--
ALTER TABLE `penyewaan_tempat`
  ADD PRIMARY KEY (`id_penyewa`),
  ADD KEY `id_acara` (`id_acara`);

--
-- Indeks untuk tabel `tempat`
--
ALTER TABLE `tempat`
  ADD PRIMARY KEY (`id_tempat`),
  ADD KEY `id_penyewa` (`id_penyewa`),
  ADD KEY `id_acara` (`id_acara`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `acara`
--
ALTER TABLE `acara`
  MODIFY `id_acara` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `pedagang`
--
ALTER TABLE `pedagang`
  MODIFY `id_pedagang` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `pembuat_acara`
--
ALTER TABLE `pembuat_acara`
  MODIFY `id_pembuatAcara` int(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `penyewaan_tempat`
--
ALTER TABLE `penyewaan_tempat`
  MODIFY `id_penyewa` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `tempat`
--
ALTER TABLE `tempat`
  MODIFY `id_tempat` int(10) NOT NULL AUTO_INCREMENT;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `acara`
--
ALTER TABLE `acara`
  ADD CONSTRAINT `acara_ibfk_1` FOREIGN KEY (`id_pembuatAcara`) REFERENCES `pembuat_acara` (`id_pembuatAcara`),
  ADD CONSTRAINT `acara_ibfk_2` FOREIGN KEY (`id_penyewa`) REFERENCES `penyewaan_tempat` (`id_penyewa`),
  ADD CONSTRAINT `acara_ibfk_3` FOREIGN KEY (`id_tempat`) REFERENCES `tempat` (`id_tempat`),
  ADD CONSTRAINT `acara_ibfk_4` FOREIGN KEY (`id_pedagang`) REFERENCES `pedagang` (`id_pedagang`);

--
-- Ketidakleluasaan untuk tabel `pedagang`
--
ALTER TABLE `pedagang`
  ADD CONSTRAINT `pedagang_ibfk_1` FOREIGN KEY (`id_acara`) REFERENCES `acara` (`id_acara`);

--
-- Ketidakleluasaan untuk tabel `penyewaan_tempat`
--
ALTER TABLE `penyewaan_tempat`
  ADD CONSTRAINT `penyewaan_tempat_ibfk_1` FOREIGN KEY (`id_acara`) REFERENCES `acara` (`id_acara`);

--
-- Ketidakleluasaan untuk tabel `tempat`
--
ALTER TABLE `tempat`
  ADD CONSTRAINT `tempat_ibfk_1` FOREIGN KEY (`id_penyewa`) REFERENCES `penyewaan_tempat` (`id_penyewa`),
  ADD CONSTRAINT `tempat_ibfk_2` FOREIGN KEY (`id_acara`) REFERENCES `acara` (`id_acara`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
