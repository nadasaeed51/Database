-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 09, 2022 at 05:35 PM
-- Server version: 10.4.22-MariaDB
-- PHP Version: 8.1.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `mm`
--

-- --------------------------------------------------------

--
-- Table structure for table `customer_t`
--

CREATE TABLE `customer_t` (
  `CustomerID` int(255) NOT NULL,
  `CustomerName` varchar(100) NOT NULL,
  `CustomerBirthdate` date DEFAULT NULL,
  `CustomerAddress` varchar(10000) DEFAULT NULL,
  `CustomerPhonenumber` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `inventory_t`
--

CREATE TABLE `inventory_t` (
  `InventoryQuantityavailable` int(255) NOT NULL,
  `InventoryExpirydate` date NOT NULL,
  `InventoryRecievedate` date NOT NULL,
  `ProductID` int(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `order_t`
--

CREATE TABLE `order_t` (
  `OrderID` int(255) NOT NULL,
  `OrderDate` date NOT NULL DEFAULT current_timestamp(),
  `CustomerID` int(255) NOT NULL,
  `ProductID` int(255) NOT NULL,
  `SalesrepID` int(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `product_t`
--

CREATE TABLE `product_t` (
  `ProductID` int(255) NOT NULL,
  `ProductName` varchar(100) NOT NULL,
  `ProductDesc` text NOT NULL,
  `ProductOrderedquantity` int(255) NOT NULL,
  `ProductPrice` int(100) NOT NULL,
  `ProductCategory_ID` int(255) NOT NULL,
  `ProductCategory_Name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `salesrep_t`
--

CREATE TABLE `salesrep_t` (
  `SalesrepID` int(255) NOT NULL,
  `SalesrepPhonenumber` int(11) NOT NULL,
  `SalesrepAddress` text NOT NULL,
  `SalesrepName` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `shipment_t`
--

CREATE TABLE `shipment_t` (
  `ShipmentNumber` int(255) NOT NULL,
  `ShipmentDate` date NOT NULL,
  `Product_ID` int(255) NOT NULL,
  `ShipmentUnitprice` int(255) NOT NULL,
  `ShipmentQuantity` int(255) NOT NULL,
  `ShipmentCost` int(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `supplier_t`
--

CREATE TABLE `supplier_t` (
  `SupplierID` int(255) NOT NULL,
  `SupplierName` varchar(100) NOT NULL,
  `SupplierPhonenumber` int(11) NOT NULL,
  `SupplierLocation` varchar(255) NOT NULL,
  `ShipmentNumber` int(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `customer_t`
--
ALTER TABLE `customer_t`
  ADD PRIMARY KEY (`CustomerID`);

--
-- Indexes for table `inventory_t`
--
ALTER TABLE `inventory_t`
  ADD KEY `ProdID` (`ProductID`);

--
-- Indexes for table `order_t`
--
ALTER TABLE `order_t`
  ADD PRIMARY KEY (`OrderID`),
  ADD KEY `CustID` (`CustomerID`),
  ADD KEY `ProdID` (`ProductID`),
  ADD KEY `repID` (`SalesrepID`);

--
-- Indexes for table `product_t`
--
ALTER TABLE `product_t`
  ADD PRIMARY KEY (`ProductID`);

--
-- Indexes for table `salesrep_t`
--
ALTER TABLE `salesrep_t`
  ADD PRIMARY KEY (`SalesrepID`),
  ADD UNIQUE KEY `SalesrepPhonenumber` (`SalesrepPhonenumber`);

--
-- Indexes for table `shipment_t`
--
ALTER TABLE `shipment_t`
  ADD PRIMARY KEY (`ShipmentNumber`),
  ADD KEY `prodID` (`Product_ID`);

--
-- Indexes for table `supplier_t`
--
ALTER TABLE `supplier_t`
  ADD PRIMARY KEY (`SupplierID`),
  ADD UNIQUE KEY `SupplierPhonenumber` (`SupplierPhonenumber`),
  ADD KEY `Shipnum` (`ShipmentNumber`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `inventory_t`
--
ALTER TABLE `inventory_t`
  ADD CONSTRAINT `inventory_t_ibfk_1` FOREIGN KEY (`ProductID`) REFERENCES `product_t` (`ProductID`);

--
-- Constraints for table `order_t`
--
ALTER TABLE `order_t`
  ADD CONSTRAINT `order_t_ibfk_1` FOREIGN KEY (`CustomerID`) REFERENCES `customer_t` (`CustomerID`),
  ADD CONSTRAINT `order_t_ibfk_2` FOREIGN KEY (`ProductID`) REFERENCES `product_t` (`ProductID`),
  ADD CONSTRAINT `order_t_ibfk_3` FOREIGN KEY (`SalesrepID`) REFERENCES `salesrep_t` (`SalesrepID`);

--
-- Constraints for table `shipment_t`
--
ALTER TABLE `shipment_t`
  ADD CONSTRAINT `shipment_t_ibfk_1` FOREIGN KEY (`Product_ID`) REFERENCES `product_t` (`ProductID`) ON DELETE NO ACTION;

--
-- Constraints for table `supplier_t`
--
ALTER TABLE `supplier_t`
  ADD CONSTRAINT `supplier_t_ibfk_1` FOREIGN KEY (`ShipmentNumber`) REFERENCES `shipment_t` (`ShipmentNumber`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
