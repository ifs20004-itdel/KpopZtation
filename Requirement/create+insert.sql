-- phpMyAdmin SQL Dump
-- version 5.1.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 12 Bulan Mei 2022 pada 10.07
-- Versi server: 10.4.24-MariaDB
-- Versi PHP: 7.4.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `kpopztation`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `albums`
--

CREATE TABLE `albums` (
  `AlbumID` char(5) NOT NULL,
  `AlbumName` varchar(50) NOT NULL,
  `AlbumPrice` int(11) NOT NULL,
  `AlbumStock` int(11) NOT NULL,
  `ArtistID` char(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `albums`
--

INSERT INTO `albums` (`AlbumID`, `AlbumName`, `AlbumPrice`, `AlbumStock`, `ArtistID`) VALUES
('AL398', 'Twicetagram', 500000, 350, 'AR355'),
('AL833', 'CHAT-SHIRE', 250000, 100, 'AR702'),
('AL846', 'LILAC', 300000, 500, 'AR702');

-- --------------------------------------------------------

--
-- Struktur dari tabel `artists`
--

CREATE TABLE `artists` (
  `ArtistID` char(5) NOT NULL,
  `ArtistName` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `artists`
--

INSERT INTO `artists` (`ArtistID`, `ArtistName`) VALUES
('AR355', 'Twice'),
('AR483', 'Aespa'),
('AR521', 'Treasure'),
('AR702', 'IU');

-- --------------------------------------------------------

--
-- Struktur dari tabel `carts`
--

CREATE TABLE `carts` (
  `UserID` char(5) NOT NULL,
  `AlbumID` char(5) NOT NULL,
  `Qty` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktur dari tabel `detailtransactions`
--

CREATE TABLE `detailtransactions` (
  `TransactionID` char(5) NOT NULL,
  `AlbumID` char(5) NOT NULL,
  `Qty` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `detailtransactions`
--

INSERT INTO `detailtransactions` (`TransactionID`, `AlbumID`, `Qty`) VALUES
('TR122', 'AL846', 5),
('TR459', 'AL833', 6),
('TR459', 'AL846', 2),
('TR676', 'AL833', 2),
('TR736', 'AL398', 2),
('TR862', 'AL398', 2),
('TR862', 'AL833', 2),
('TR862', 'AL846', 4);

-- --------------------------------------------------------

--
-- Struktur dari tabel `headertransactions`
--

CREATE TABLE `headertransactions` (
  `TransactionID` char(5) NOT NULL,
  `UserID` char(5) NOT NULL,
  `TransactionDate` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `headertransactions`
--

INSERT INTO `headertransactions` (`TransactionID`, `UserID`, `TransactionDate`) VALUES
('TR122', 'US977', '2022-05-12'),
('TR459', 'US977', '2022-05-12'),
('TR676', 'US977', '2022-05-12'),
('TR736', 'US977', '2022-05-12'),
('TR862', 'US977', '2022-05-12');

-- --------------------------------------------------------

--
-- Struktur dari tabel `users`
--

CREATE TABLE `users` (
  `UserID` char(5) NOT NULL,
  `UserName` varchar(50) NOT NULL,
  `UserPassword` varchar(50) NOT NULL,
  `UserEmail` varchar(50) NOT NULL,
  `UserAddress` varchar(255) NOT NULL,
  `UserGender` varchar(50) NOT NULL,
  `UserRole` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `users`
--

INSERT INTO `users` (`UserID`, `UserName`, `UserPassword`, `UserEmail`, `UserAddress`, `UserGender`, `UserRole`) VALUES
('US030', 'Admin', 'admin123', 'admin@admin.com', 'admin home Street', 'Male', 'Admin'),
('US977', 'keziaa', 'kezia123', 'kez@mail.com', 'apple Street', 'Female', 'User');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `albums`
--
ALTER TABLE `albums`
  ADD PRIMARY KEY (`AlbumID`),
  ADD KEY `Constraint_Artist_Album` (`ArtistID`);

--
-- Indeks untuk tabel `artists`
--
ALTER TABLE `artists`
  ADD PRIMARY KEY (`ArtistID`);

--
-- Indeks untuk tabel `carts`
--
ALTER TABLE `carts`
  ADD PRIMARY KEY (`UserID`,`AlbumID`),
  ADD KEY `Constraint_Cart_Product` (`AlbumID`);

--
-- Indeks untuk tabel `detailtransactions`
--
ALTER TABLE `detailtransactions`
  ADD PRIMARY KEY (`TransactionID`,`AlbumID`),
  ADD KEY `Constraint_DetailTransaction_Album` (`AlbumID`);

--
-- Indeks untuk tabel `headertransactions`
--
ALTER TABLE `headertransactions`
  ADD PRIMARY KEY (`TransactionID`),
  ADD KEY `Constraint_User_Transaction` (`UserID`);

--
-- Indeks untuk tabel `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`UserID`);

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `albums`
--
ALTER TABLE `albums`
  ADD CONSTRAINT `Constraint_Artist_Album` FOREIGN KEY (`ArtistID`) REFERENCES `artists` (`ArtistID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `carts`
--
ALTER TABLE `carts`
  ADD CONSTRAINT `Constraint_Cart_Product` FOREIGN KEY (`AlbumID`) REFERENCES `albums` (`AlbumID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `Constraint_Cart_User` FOREIGN KEY (`UserID`) REFERENCES `users` (`UserID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `detailtransactions`
--
ALTER TABLE `detailtransactions`
  ADD CONSTRAINT `Constraint_DetailTransaction_Album` FOREIGN KEY (`AlbumID`) REFERENCES `albums` (`AlbumID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `Constraint_Transactions` FOREIGN KEY (`TransactionID`) REFERENCES `headertransactions` (`TransactionID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `headertransactions`
--
ALTER TABLE `headertransactions`
  ADD CONSTRAINT `Constraint_User_Transaction` FOREIGN KEY (`UserID`) REFERENCES `users` (`UserID`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
