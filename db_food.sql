-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 28, 2021 at 03:09 AM
-- Server version: 10.4.20-MariaDB
-- PHP Version: 8.0.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_food`
--

-- --------------------------------------------------------

--
-- Table structure for table `addresses`
--

CREATE TABLE `addresses` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `status_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `street` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `area` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `note` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `latitude` double NOT NULL,
  `longitude` double NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `addresses`
--

INSERT INTO `addresses` (`id`, `status_id`, `user_id`, `street`, `area`, `note`, `type`, `latitude`, `longitude`, `created_at`, `updated_at`) VALUES
(1, 2, 1, 'Cagayan de Oro National Hwy CDO', 'Misamis Oriental Northern Mindanao PH', '', 'Office', 8.494798, 124.631058, '2021-09-17 15:10:50', '2021-09-17 15:11:45');

-- --------------------------------------------------------

--
-- Table structure for table `address_status`
--

CREATE TABLE `address_status` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `address_status`
--

INSERT INTO `address_status` (`id`, `name`, `created_at`, `updated_at`) VALUES
(1, 'Unused', '2021-06-15 23:16:19', '2021-06-15 23:16:19'),
(2, 'Used', '2021-06-15 23:16:19', '2021-06-15 23:16:19');

-- --------------------------------------------------------

--
-- Table structure for table `admins`
--

CREATE TABLE `admins` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `username` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `admins`
--

INSERT INTO `admins` (`id`, `username`, `password`, `created_at`, `updated_at`) VALUES
(1, 'admin', '$2y$12$m.lzO1smItLyrBe0zuUjWOQ3yqP6IIuQCvewlaYwAxF3FGOKNwxR6', '2021-07-12 21:16:27', '2021-07-12 21:16:27');

-- --------------------------------------------------------

--
-- Table structure for table `carts`
--

CREATE TABLE `carts` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `selected_choices` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `quantity` int(11) NOT NULL,
  `instruction` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `availability` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `carts`
--

INSERT INTO `carts` (`id`, `user_id`, `product_id`, `selected_choices`, `quantity`, `instruction`, `availability`, `created_at`, `updated_at`) VALUES
(73, 1, 3, '[{\"title\":\"Drinks\",\"mode\":\"radio\",\"status\":\"Required\",\"choices\":[{\"name\":\"Regular Iced Tea\",\"price\":0,\"checked\":\"false\"},{\"name\":\"Large Iced Tea\",\"price\":33,\"checked\":\"false\"},{\"name\":\"Large Pineapple Juice\",\"price\":33,\"checked\":\"false\"},{\"name\":\"Choco Caramel Float\",\"price\":33,\"checked\":\"false\"},{\"name\":\"Coffee Caramel Float\",\"price\":33,\"checked\":\"false\"},{\"name\":\"Iced Coffee\",\"price\":33,\"checked\":\"true\"}]},{\"title\":\"Extras\",\"mode\":\"checkbox\",\"status\":\"Optional\",\"choices\":[{\"name\":\"Extra Burger Steak Patty and Gravy\",\"price\":52,\"checked\":\"false\"},{\"name\":\"Extra Burger Steak Gravy Only\",\"price\":37,\"checked\":\"false\"},{\"name\":\"Extra Rice\",\"price\":33,\"checked\":\"false\"}]},{\"title\":\"Sides\",\"id\":\"radiosides\",\"mode\":\"radio\",\"status\":\"Optional\",\"choices\":[{\"name\":\"Regular Jolly Crispy Fries\",\"price\":47,\"checked\":\"true\"},{\"name\":\"Large Jolly Crispy Fries\",\"price\":66,\"checked\":\"false\"},{\"name\":\"Jumbo Jolly Crispy Fries\",\"price\":85,\"checked\":\"false\"},{\"name\":\"Creamy Macaroni Soup\",\"price\":44,\"checked\":\"false\"}]},{\"title\":\"Desserts\",\"id\":\"checkboxdesserts\",\"mode\":\"checkbox\",\"status\":\"Optional\",\"choices\":[{\"name\":\"Peach Mango Pie\",\"price\":33,\"checked\":\"true\"},{\"name\":\"Chocolate Sundae Twirl\",\"price\":33,\"checked\":\"false\"},{\"name\":\"Buko Pie\",\"price\":33,\"checked\":\"false\"},{\"name\":\"Ube Macapuno Pie\",\"price\":33,\"checked\":\"false\"}]}]', 1, '', 'Remove it from my order if none', '2021-09-17 15:18:23', '2021-09-17 15:18:23'),
(74, 1, 1, '[{\"title\":\"Extras\",\"mode\":\"checkbox\",\"status\":\"Optional\",\"choices\":[{\"name\":\"Extra Burger Steak Patty and Gravy\",\"price\":52,\"checked\":\"false\"},{\"name\":\"Extra Burger Steak Gravy Only\",\"price\":37,\"checked\":\"false\"},{\"name\":\"Extra Rice\",\"price\":33,\"checked\":\"true\"}]},{\"title\":\"Sides\",\"mode\":\"radio\",\"status\":\"Optional\",\"choices\":[{\"name\":\"Regular Jolly Crispy Fries\",\"price\":47,\"checked\":\"true\"},{\"name\":\"Large Jolly Crispy Fries\",\"price\":66,\"checked\":\"false\"},{\"name\":\"Jumbo Jolly Crispy Fries\",\"price\":85,\"checked\":\"false\"},{\"name\":\"Creamy Macaroni Soup\",\"price\":44,\"checked\":\"false\"}]},{\"title\":\"Desserts\",\"mode\":\"checkbox\",\"status\":\"Optional\",\"choices\":[{\"name\":\"Peach Mango Pie\",\"price\":33,\"checked\":\"true\"},{\"name\":\"Chocolate Sundae Twirl\",\"price\":33,\"checked\":\"false\"},{\"name\":\"Buko Pie\",\"price\":33,\"checked\":\"false\"},{\"name\":\"Ube Macapuno Pie\",\"price\":33,\"checked\":\"false\"}]}]', 1, '', 'Remove it from my order if none', '2021-09-17 15:18:23', '2021-09-17 15:18:23');

-- --------------------------------------------------------

--
-- Table structure for table `chats`
--

CREATE TABLE `chats` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `ticket_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `store_id` bigint(20) UNSIGNED DEFAULT NULL,
  `rider_id` bigint(20) UNSIGNED DEFAULT NULL,
  `message` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fares`
--

CREATE TABLE `fares` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `minimum_distance` int(11) NOT NULL,
  `minimum_charge` double NOT NULL,
  `increment_amount` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `fares`
--

INSERT INTO `fares` (`id`, `minimum_distance`, `minimum_charge`, `increment_amount`, `created_at`, `updated_at`) VALUES
(1, 1, 20, 5, '2021-05-13 19:47:28', '2021-05-13 19:47:28');

-- --------------------------------------------------------

--
-- Table structure for table `favourites`
--

CREATE TABLE `favourites` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `store_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `favourites`
--

INSERT INTO `favourites` (`id`, `user_id`, `store_id`, `created_at`, `updated_at`) VALUES
(2, 1, 4, '2021-07-27 00:51:09', '2021-07-27 00:51:09'),
(3, 1, 1, '2021-08-02 14:27:16', '2021-08-02 14:27:16'),
(4, 1, 2, '2021-08-02 14:27:23', '2021-08-02 14:27:23'),
(5, 1, 3, '2021-08-11 08:24:39', '2021-08-11 08:24:39');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `payment_id` bigint(20) UNSIGNED NOT NULL,
  `status_id` bigint(20) UNSIGNED NOT NULL,
  `reason` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `note` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fare` double NOT NULL,
  `delivery` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `when` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ship_from` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ship_to` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `latitude` double NOT NULL,
  `longitude` double NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `token`, `user_id`, `payment_id`, `status_id`, `reason`, `note`, `fare`, `delivery`, `when`, `ship_from`, `ship_to`, `latitude`, `longitude`, `created_at`, `updated_at`) VALUES
(22, '202109170', 1, 1, 5, NULL, '', 25, 'Express', 'ASAP (20 Min)', 'CDO Jollibee Kauswagan', 'Cagayan de Oro National Hwy CDO Misamis Oriental Northern Mindanao PH', 8.494798, 124.631058, '2021-09-17 15:11:58', '2021-09-22 13:18:28');

-- --------------------------------------------------------

--
-- Table structure for table `order_status`
--

CREATE TABLE `order_status` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `order_status`
--

INSERT INTO `order_status` (`id`, `name`, `created_at`, `updated_at`) VALUES
(1, 'Pending', '2021-05-19 23:09:05', '2021-05-19 23:09:05'),
(2, 'Process', '2021-05-19 23:09:05', '2021-05-19 23:09:05'),
(3, 'To pick-up', '2021-05-19 23:09:05', '2021-05-19 23:09:05'),
(4, 'To deliver', '2021-06-03 18:21:52', '2021-06-03 18:21:52'),
(5, 'Delivered', '2021-05-19 23:09:05', '2021-05-19 23:09:05'),
(6, 'Cancelled', '2021-06-03 18:21:52', '2021-06-03 18:21:52');

-- --------------------------------------------------------

--
-- Table structure for table `payments`
--

CREATE TABLE `payments` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `disable` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `payments`
--

INSERT INTO `payments` (`id`, `type`, `disable`, `created_at`, `updated_at`) VALUES
(1, 'Cash on Delivery', 'false', '2021-05-16 18:41:48', '2021-05-16 18:41:48'),
(2, 'Credit/Debit Card', 'true', '2021-05-16 18:41:48', '2021-05-16 18:41:48'),
(3, 'Gcash', 'true', '2021-05-16 18:41:48', '2021-05-16 18:41:48');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `price` double NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `choices` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `category` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `store_id` bigint(20) UNSIGNED NOT NULL,
  `status_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `name`, `price`, `description`, `choices`, `category`, `image`, `store_id`, `status_id`, `created_at`, `updated_at`) VALUES
(1, '2pcs Burger Steak Solo', 96, '', '[ { \"title\": \"Extras\", \"mode\": \"checkbox\", \"status\": \"Optional\", \"choices\": [ { \"name\": \"Extra Burger Steak Patty and Gravy\", \"price\": 52, \"checked\": \"false\" }, { \"name\": \"Extra Burger Steak Gravy Only\", \"price\": 37, \"checked\": \"false\" }, { \"name\": \"Extra Rice\", \"price\": 33, \"checked\": \"false\" } ] }, { \"title\": \"Sides\", \"mode\": \"radio\", \"status\": \"Optional\", \"choices\": [ { \"name\": \"Regular Jolly Crispy Fries\", \"price\": 47, \"checked\": \"false\" }, { \"name\": \"Large Jolly Crispy Fries\", \"price\": 66, \"checked\": \"false\" }, { \"name\": \"Jumbo Jolly Crispy Fries\", \"price\": 85, \"checked\": \"false\" }, { \"name\": \"Creamy Macaroni Soup\", \"price\": 44, \"checked\": \"false\" } ] }, { \"title\": \"Desserts\", \"mode\": \"checkbox\", \"status\": \"Optional\", \"choices\": [ { \"name\": \"Peach Mango Pie\", \"price\": 33, \"checked\": \"false\" }, { \"name\": \"Chocolate Sundae Twirl\", \"price\": 33, \"checked\": \"false\" }, { \"name\": \"Buko Pie\", \"price\": 33, \"checked\": \"false\" }, { \"name\": \"Ube Macapuno Pie\", \"price\": 33, \"checked\": \"false\" } ] } ]', 'Burger Steak', 'https://foodlephotos.s3.ap-southeast-1.amazonaws.com/product_image/2pc+Burger+Steak+Solo.png', 1, 1, '2021-05-07 16:46:54', '2021-05-07 16:46:54'),
(2, 'McFloat', 39, 'Floating ice cream inside in coke', '[ { \"title\": \"Sizes\", \"mode\": \"radio\", \"status\": \"Required\", \"choices\": [ { \"name\": \"Regular\", \"price\": 0, \"checked\": \"true\" }, { \"name\": \"Medium\", \"price\": 15, \"checked\": \"false\" }, { \"name\": \"Large\", \"price\": 20, \"checked\": \"false\" } ] }, { \"title\": \"Flavour\", \"mode\": \"radio\", \"status\": \"Required\", \"choices\": [ { \"name\": \"Coke\", \"price\": 0, \"checked\": \"true\" }, { \"name\": \"Strawberry\", \"price\": 0, \"checked\": \"false\" }, { \"name\": \"Green Apple\", \"price\": 0, \"checked\": \"false\" }, { \"name\": \"Lychee\", \"price\": 0, \"checked\": \"false\" }, { \"name\": \"Melon\", \"price\": 0, \"checked\": \"false\" }, { \"name\": \"Blueberry\", \"price\": 0, \"checked\": \"false\" } ] } ]', 'Dessert', 'https://foodlephotos.s3.ap-southeast-1.amazonaws.com/product_image/Mcfloat.png', 2, 1, '2021-05-07 16:51:58', '2021-05-07 16:51:58'),
(3, '2pc Burger Steak w/ Drink', 99, '', '[ { \"title\": \"Drinks\", \"mode\": \"radio\", \"status\": \"Required\", \"choices\": [ { \"name\": \"Regular Iced Tea\", \"price\": 0, \"checked\": \"true\" }, { \"name\": \"Large Iced Tea\", \"price\": 33, \"checked\": \"false\" }, { \"name\": \"Large Pineapple Juice\", \"price\": 33, \"checked\": \"false\" }, { \"name\": \"Choco Caramel Float\", \"price\": 33, \"checked\": \"false\" }, { \"name\": \"Coffee Caramel Float\", \"price\": 33, \"checked\": \"false\" }, { \"name\": \"Iced Coffee\", \"price\": 33, \"checked\": \"false\" } ] }, { \"title\": \"Extras\", \"mode\": \"checkbox\", \"status\": \"Optional\", \"choices\": [ { \"name\": \"Extra Burger Steak Patty and Gravy\", \"price\": 52, \"checked\": \"false\" }, { \"name\": \"Extra Burger Steak Gravy Only\", \"price\": 37, \"checked\": \"false\" }, { \"name\": \"Extra Rice\", \"price\": 33, \"checked\": \"false\" } ] }, { \"title\": \"Sides\", \"id\": \"radiosides\", \"mode\": \"radio\", \"status\": \"Optional\", \"choices\": [ { \"name\": \"Regular Jolly Crispy Fries\", \"price\": 47, \"checked\": \"false\" }, { \"name\": \"Large Jolly Crispy Fries\", \"price\": 66, \"checked\": \"false\" }, { \"name\": \"Jumbo Jolly Crispy Fries\", \"price\": 85, \"checked\": \"false\" }, { \"name\": \"Creamy Macaroni Soup\", \"price\": 44, \"checked\": \"false\" } ] }, { \"title\": \"Desserts\", \"id\": \"checkboxdesserts\", \"mode\": \"checkbox\", \"status\": \"Optional\", \"choices\": [ { \"name\": \"Peach Mango Pie\", \"price\": 33, \"checked\": \"false\" }, { \"name\": \"Chocolate Sundae Twirl\", \"price\": 33, \"checked\": \"false\" }, { \"name\": \"Buko Pie\", \"price\": 33, \"checked\": \"false\" }, { \"name\": \"Ube Macapuno Pie\", \"price\": 33, \"checked\": \"false\" } ] } ]', 'Burger Steak', 'https://foodlephotos.s3.ap-southeast-1.amazonaws.com/product_image/2pc+Burger+Steak+with+Drink.png', 1, 1, '2021-05-08 00:56:58', '2021-05-08 00:57:10'),
(5, '1pc Burger Steak Solo', 55, '', '[ { \"title\": \"Extras\", \"mode\": \"checkbox\", \"status\": \"Optional\", \"choices\": [ { \"name\": \"Extra Burger Steak Patty and Gravy\", \"price\": 52, \"checked\": \"false\" }, { \"name\": \"Extra Burger Steak Gravy Only\", \"price\": 37, \"checked\": \"false\" }, { \"name\": \"Extra Rice\", \"price\": 33, \"checked\": \"false\" } ] }, { \"title\": \"Sides\", \"mode\": \"radio\", \"status\": \"Optional\", \"choices\": [ { \"name\": \"Regular Jolly Crispy Fries\", \"price\": 47, \"checked\": \"false\" }, { \"name\": \"Large Jolly Crispy Fries\", \"price\": 66, \"checked\": \"false\" }, { \"name\": \"Jumbo Jolly Crispy Fries\", \"price\": 85, \"checked\": \"false\" }, { \"name\": \"Creamy Macaroni Soup\", \"price\": 44, \"checked\": \"false\" } ] }, { \"title\": \"Desserts\", \"mode\": \"checkbox\", \"status\": \"Optional\", \"choices\": [ { \"name\": \"Peach Mango Pie\", \"price\": 33, \"checked\": \"false\" }, { \"name\": \"Chocolate Sundae Twirl\", \"price\": 33, \"checked\": \"false\" }, { \"name\": \"Buko Pie\", \"price\": 33, \"checked\": \"false\" }, { \"name\": \"Ube Macapuno Pie\", \"price\": 33, \"checked\": \"false\" } ] } ]', 'Burger Steak', 'https://foodlephotos.s3.ap-southeast-1.amazonaws.com/product_image/1pc+Burger+Steak+Solo.png', 1, 1, '2021-05-08 00:59:13', '2021-05-08 00:59:13'),
(6, '1pc Burger Steak w/ Drink', 76, '', '[ { \"title\": \"Drinks\", \"mode\": \"radio\", \"status\": \"Required\", \"choices\": [ { \"name\": \"Regular Iced Tea\", \"price\": 0, \"checked\": \"true\" }, { \"name\": \"Large Iced Tea\", \"price\": 33, \"checked\": \"false\" }, { \"name\": \"Large Pineapple Juice\", \"price\": 33, \"checked\": \"false\" }, { \"name\": \"Choco Caramel Float\", \"price\": 33, \"checked\": \"false\" }, { \"name\": \"Coffee Caramel Float\", \"price\": 33, \"checked\": \"false\" }, { \"name\": \"Iced Coffee\", \"price\": 33, \"checked\": \"false\" } ] }, { \"title\": \"Extras\", \"mode\": \"checkbox\", \"status\": \"Optional\", \"choices\": [ { \"name\": \"Extra Burger Steak Patty and Gravy\", \"price\": 52, \"checked\": \"false\" }, { \"name\": \"Extra Burger Steak Gravy Only\", \"price\": 37, \"checked\": \"false\" }, { \"name\": \"Extra Rice\", \"price\": 33, \"checked\": \"false\" } ] }, { \"title\": \"Sides\", \"mode\": \"radio\", \"status\": \"Optional\", \"choices\": [ { \"name\": \"Regular Jolly Crispy Fries\", \"price\": 47, \"checked\": \"false\" }, { \"name\": \"Large Jolly Crispy Fries\", \"price\": 66, \"checked\": \"false\" }, { \"name\": \"Jumbo Jolly Crispy Fries\", \"price\": 85, \"checked\": \"false\" }, { \"name\": \"Creamy Macaroni Soup\", \"price\": 44, \"checked\": \"false\" } ] }, { \"title\": \"Desserts\", \"mode\": \"checkbox\", \"status\": \"Optional\", \"choices\": [ { \"name\": \"Peach Mango Pie\", \"price\": 33, \"checked\": \"false\" }, { \"name\": \"Chocolate Sundae Twirl\", \"price\": 33, \"checked\": \"false\" }, { \"name\": \"Buko Pie\", \"price\": 33, \"checked\": \"false\" }, { \"name\": \"Ube Macapuno Pie\", \"price\": 33, \"checked\": \"false\" } ] } ]', 'Burger Steak', 'https://foodlephotos.s3.ap-southeast-1.amazonaws.com/product_image/1pc+Burger+Steak+with+Drink.png', 1, 2, '2021-05-08 00:59:41', '2021-09-16 14:35:35'),
(7, '1pc Chickenjoy Solo', 89, '', '[{\"title\":\"Choice of Flavor (A)\",\"mode\":\"radio\",\"status\":\"required\",\"choices\":[{\"name\":\"Original\",\"price\":\"0\",\"checked\":\"true\"},{\"name\":\"Spicy\",\"price\":\"4\",\"checked\":\"false\"}]},{\"title\":\"Add-on Desserts\",\"mode\":\"checkbox\",\"status\":\"optional\",\"choices\":[{\"name\":\"Peach Mango Pie\",\"price\":\"36\",\"checked\":\"false\"},{\"name\":\"Buko Pie\",\"price\":\"36\",\"checked\":\"false\"},{\"name\":\"Ube Cheese Pie\",\"price\":\"39\",\"checked\":\"false\"}]}]', 'Chickenjoy', 'https://foodlephotos.s3.ap-southeast-1.amazonaws.com/product_image/1pc+Chickenjoy+Solo.png', 1, 2, '2021-07-25 18:25:46', '2021-09-16 14:35:34'),
(9, 'M.Y San Grahams Honey Crushed', 39, 'M.Y San Grahams Honey Crushed 200g', '', 'Snacks', 'https://foodlephotos.s3.ap-southeast-1.amazonaws.com/product_image/M.Y+San+Grahams+Honey+Crushed.png', 4, 1, '2021-07-26 16:49:05', '2021-08-03 13:06:42'),
(10, 'All-In Overload', 279, '', '[{\"title\":\"Variation\",\"mode\":\"radio\",\"status\":\"optional\",\"choices\":[{\"name\":\"9-inches, 6 slices\",\"price\":\"0\",\"checked\":\"true\"},{\"name\":\"12-inch, 8 slices\",\"price\":\"147\",\"checked\":\"false\"}]},{\"title\":\"Add-On\",\"mode\":\"checkbox\",\"status\":\"optional\",\"choices\":[{\"name\":\"Medium Potato Waves\",\"price\":\"90\",\"checked\":\"false\"},{\"name\":\"3pc. Crunchy Chicken\",\"price\":\"143\",\"checked\":\"false\"},{\"name\":\"Lasagna Supreme Small Pan\",\"price\":\"258\",\"checked\":\"false\"},{\"name\":\"Hot Sauce\",\"price\":\"6\",\"checked\":\"false\"}]}]', 'Overload Pizzas', 'https://foodlephotos.s3.ap-southeast-1.amazonaws.com/product_image/All-In+Overload.png', 3, 2, '2021-07-26 19:44:35', '2021-08-03 13:39:01'),
(11, 'Yumburger, Fries & Drink', 95, 'Combination of yumberger, fries with drinks', '', 'Burgers', 'https://foodlephotos.s3.ap-southeast-1.amazonaws.com/product_image/Yumburger%2C+Fries+%26+Drink.png', 1, 2, '2021-08-02 05:48:11', '2021-09-16 14:35:32'),
(12, 'Cheesy Yumburger, Fries & Drink', 109, 'Cheesy yumburger, fries with drinks', '', 'Burgers', 'https://foodlephotos.s3.ap-southeast-1.amazonaws.com/product_image/Cheesy+Yumburger%2C+Fries+%26+Drink.png', 1, 2, '2021-08-02 05:49:56', '2021-09-16 14:35:30'),
(13, '6pc Chickenjoy Solo', 440, '', '', 'Chickenjoy', 'https://foodlephotos.s3.ap-southeast-1.amazonaws.com/product_image/6pc+Chickenjoy+Solo.png', 1, 2, '2021-08-03 09:57:36', '2021-09-16 14:35:13');

-- --------------------------------------------------------

--
-- Table structure for table `product_status`
--

CREATE TABLE `product_status` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `product_status`
--

INSERT INTO `product_status` (`id`, `name`, `created_at`, `updated_at`) VALUES
(1, 'Available', '2021-08-02 19:15:51', '2021-08-02 19:15:51'),
(2, 'Unavailable', '2021-08-02 19:15:51', '2021-08-02 19:15:51');

-- --------------------------------------------------------

--
-- Table structure for table `purchases`
--

CREATE TABLE `purchases` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `order_id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `price` double NOT NULL,
  `selected_choices` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `quantity` int(11) NOT NULL,
  `instruction` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `availability` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `purchases`
--

INSERT INTO `purchases` (`id`, `order_id`, `product_id`, `price`, `selected_choices`, `quantity`, `instruction`, `availability`, `status_id`, `created_at`, `updated_at`) VALUES
(27, 22, 3, 99, '[{\"title\":\"Drinks\",\"mode\":\"radio\",\"status\":\"Required\",\"choices\":[{\"name\":\"Regular Iced Tea\",\"price\":0,\"checked\":\"false\"},{\"name\":\"Large Iced Tea\",\"price\":33,\"checked\":\"false\"},{\"name\":\"Large Pineapple Juice\",\"price\":33,\"checked\":\"false\"},{\"name\":\"Choco Caramel Float\",\"price\":33,\"checked\":\"false\"},{\"name\":\"Coffee Caramel Float\",\"price\":33,\"checked\":\"false\"},{\"name\":\"Iced Coffee\",\"price\":33,\"checked\":\"true\"}]},{\"title\":\"Extras\",\"mode\":\"checkbox\",\"status\":\"Optional\",\"choices\":[{\"name\":\"Extra Burger Steak Patty and Gravy\",\"price\":52,\"checked\":\"false\"},{\"name\":\"Extra Burger Steak Gravy Only\",\"price\":37,\"checked\":\"false\"},{\"name\":\"Extra Rice\",\"price\":33,\"checked\":\"false\"}]},{\"title\":\"Sides\",\"id\":\"radiosides\",\"mode\":\"radio\",\"status\":\"Optional\",\"choices\":[{\"name\":\"Regular Jolly Crispy Fries\",\"price\":47,\"checked\":\"true\"},{\"name\":\"Large Jolly Crispy Fries\",\"price\":66,\"checked\":\"false\"},{\"name\":\"Jumbo Jolly Crispy Fries\",\"price\":85,\"checked\":\"false\"},{\"name\":\"Creamy Macaroni Soup\",\"price\":44,\"checked\":\"false\"}]},{\"title\":\"Desserts\",\"id\":\"checkboxdesserts\",\"mode\":\"checkbox\",\"status\":\"Optional\",\"choices\":[{\"name\":\"Peach Mango Pie\",\"price\":33,\"checked\":\"true\"},{\"name\":\"Chocolate Sundae Twirl\",\"price\":33,\"checked\":\"false\"},{\"name\":\"Buko Pie\",\"price\":33,\"checked\":\"false\"},{\"name\":\"Ube Macapuno Pie\",\"price\":33,\"checked\":\"false\"}]}]', 1, '', 'Remove it from my order if none', 1, '2021-09-17 15:11:58', '2021-09-17 15:18:02'),
(28, 22, 1, 96, '[{\"title\":\"Extras\",\"mode\":\"checkbox\",\"status\":\"Optional\",\"choices\":[{\"name\":\"Extra Burger Steak Patty and Gravy\",\"price\":52,\"checked\":\"false\"},{\"name\":\"Extra Burger Steak Gravy Only\",\"price\":37,\"checked\":\"false\"},{\"name\":\"Extra Rice\",\"price\":33,\"checked\":\"true\"}]},{\"title\":\"Sides\",\"mode\":\"radio\",\"status\":\"Optional\",\"choices\":[{\"name\":\"Regular Jolly Crispy Fries\",\"price\":47,\"checked\":\"true\"},{\"name\":\"Large Jolly Crispy Fries\",\"price\":66,\"checked\":\"false\"},{\"name\":\"Jumbo Jolly Crispy Fries\",\"price\":85,\"checked\":\"false\"},{\"name\":\"Creamy Macaroni Soup\",\"price\":44,\"checked\":\"false\"}]},{\"title\":\"Desserts\",\"mode\":\"checkbox\",\"status\":\"Optional\",\"choices\":[{\"name\":\"Peach Mango Pie\",\"price\":33,\"checked\":\"true\"},{\"name\":\"Chocolate Sundae Twirl\",\"price\":33,\"checked\":\"false\"},{\"name\":\"Buko Pie\",\"price\":33,\"checked\":\"false\"},{\"name\":\"Ube Macapuno Pie\",\"price\":33,\"checked\":\"false\"}]}]', 1, '', 'Remove it from my order if none', 1, '2021-09-17 15:11:58', '2021-09-17 15:18:02');

-- --------------------------------------------------------

--
-- Table structure for table `purchase_status`
--

CREATE TABLE `purchase_status` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `purchase_status`
--

INSERT INTO `purchase_status` (`id`, `name`, `created_at`, `updated_at`) VALUES
(1, 'Process', '2021-06-04 21:11:10', '2021-06-04 21:11:10'),
(2, 'Remove', '2021-06-04 21:11:10', '2021-06-04 21:11:10');

-- --------------------------------------------------------

--
-- Table structure for table `riders`
--

CREATE TABLE `riders` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `rider_code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `username` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status_id` bigint(20) UNSIGNED NOT NULL,
  `latitude` double NOT NULL,
  `longitude` double NOT NULL,
  `firstname` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `middlename` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `lastname` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `gender` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `dateofbirth` date NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `cellphone` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `birthofplace` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `civilstatus` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `citizenship` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `height` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `weight` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `religion` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `cityaddress` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `provincialaddress` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `elementary` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `highschool` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `college` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tin` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nbiclearance` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `resume` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `riders`
--

INSERT INTO `riders` (`id`, `rider_code`, `username`, `password`, `status_id`, `latitude`, `longitude`, `firstname`, `middlename`, `lastname`, `gender`, `dateofbirth`, `email`, `cellphone`, `birthofplace`, `civilstatus`, `citizenship`, `height`, `weight`, `religion`, `cityaddress`, `provincialaddress`, `elementary`, `highschool`, `college`, `tin`, `nbiclearance`, `resume`, `created_at`, `updated_at`) VALUES
(1, 'MLA-0001', 'marky', '$2y$10$9Eg4kiDmbIrtwvhyTYdv..sl6aP1rVVFU4ocj1ApPUS560iBpTPKu', 2, 12.879721, 121.774017, 'Mark Lee', 'Pacana', 'Abanite', 'Male', '1999-05-18', 'markleeabanite@gmail.com', '09750446548', 'Mariana Trench', 'Single', 'Filipino', '168cm', '60kg', 'Roman Catholic', 'Zayas, Cagayan De Oro City', 'Misamis Oriental, 9000', 'Bugo Central School;2005-2006', 'Bugo National High School;2010-2011', 'Cagayan De Oro College;2015-2016', '765-581-813', 'https://foodlephotos.s3.ap-southeast-1.amazonaws.com/rider_image/Mark+Lee+Abanitenbiclearance.png', 'https://foodlephotos.s3.ap-southeast-1.amazonaws.com/rider_image/Mark+Lee+Abaniteresume.png', '2021-07-27 17:57:25', '2021-09-22 06:32:53');

-- --------------------------------------------------------

--
-- Table structure for table `rider_orders`
--

CREATE TABLE `rider_orders` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `order_id` bigint(20) UNSIGNED NOT NULL,
  `rider_id` bigint(20) UNSIGNED NOT NULL,
  `status_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `rider_orders`
--

INSERT INTO `rider_orders` (`id`, `order_id`, `rider_id`, `status_id`, `created_at`, `updated_at`) VALUES
(2, 22, 1, 4, '2021-09-20 22:50:01', '2021-09-22 13:18:28');

-- --------------------------------------------------------

--
-- Table structure for table `rider_order_status`
--

CREATE TABLE `rider_order_status` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `rider_order_status`
--

INSERT INTO `rider_order_status` (`id`, `name`, `created_at`, `updated_at`) VALUES
(1, 'Pending', '2021-06-07 19:46:09', '2021-06-07 19:46:09'),
(2, 'Accepted', '2021-06-07 19:46:09', '2021-06-07 19:46:09'),
(3, 'Declined', '2021-06-07 19:50:32', '2021-06-07 19:50:32'),
(4, 'Completed', '2021-06-07 21:14:00', '2021-06-07 21:14:00');

-- --------------------------------------------------------

--
-- Table structure for table `rider_rooms`
--

CREATE TABLE `rider_rooms` (
  `id` bigint(20) NOT NULL,
  `rider_id` bigint(20) UNSIGNED NOT NULL,
  `store_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `rider_sessions`
--

CREATE TABLE `rider_sessions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `session_id` bigint(20) UNSIGNED NOT NULL,
  `rider_id` bigint(20) UNSIGNED NOT NULL,
  `remitted` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `rider_sessions`
--

INSERT INTO `rider_sessions` (`id`, `session_id`, `rider_id`, `remitted`, `created_at`, `updated_at`) VALUES
(3, 2, 1, '', '2021-09-22 06:02:46', '2021-09-22 06:02:46');

-- --------------------------------------------------------

--
-- Table structure for table `rider_status`
--

CREATE TABLE `rider_status` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `rider_status`
--

INSERT INTO `rider_status` (`id`, `name`, `created_at`, `updated_at`) VALUES
(1, 'Offline', '2021-06-07 17:11:01', '2021-06-07 17:11:01'),
(2, 'Online', '2021-06-07 17:11:01', '2021-06-07 17:11:01'),
(3, 'Busy', '2021-06-07 17:20:31', '2021-06-07 17:20:31'),
(4, 'Hold', '2021-09-20 23:55:33', '2021-09-20 23:55:33');

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE `sessions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `time_a` time NOT NULL,
  `time_b` time NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `update_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `sessions`
--

INSERT INTO `sessions` (`id`, `name`, `time_a`, `time_b`, `created_at`, `update_at`) VALUES
(1, 'Batch 1', '08:00:00', '11:59:59', '2021-09-20 22:12:15', '2021-09-20 22:12:15'),
(2, 'Batch 2', '12:00:00', '15:59:59', '2021-09-20 22:12:15', '2021-09-20 22:12:15'),
(3, 'Batch 3', '16:00:00', '19:59:59', '2021-09-20 22:12:15', '2021-09-20 22:12:15'),
(4, 'Batch 4', '20:00:00', '23:59:59', '2021-09-20 22:12:15', '2021-09-20 22:12:15'),
(5, 'Batch 5', '00:00:00', '03:59:59', '2021-09-20 22:12:15', '2021-09-20 22:12:15'),
(6, 'Batch 6', '04:00:00', '07:59:59', '2021-09-20 22:12:15', '2021-09-20 22:12:15');

-- --------------------------------------------------------

--
-- Table structure for table `stores`
--

CREATE TABLE `stores` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `username` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `streets` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `preparing_time` int(11) NOT NULL,
  `delivery_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `latitude` double NOT NULL,
  `longitude` double NOT NULL,
  `close_day` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `open_time_a` time NOT NULL,
  `open_time_b` time NOT NULL,
  `tin` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `storebanner` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `orderbanner` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `storethumbnail` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `stores`
--

INSERT INTO `stores` (`id`, `username`, `password`, `name`, `streets`, `preparing_time`, `delivery_type`, `latitude`, `longitude`, `close_day`, `open_time_a`, `open_time_b`, `tin`, `storebanner`, `orderbanner`, `storethumbnail`, `status_id`, `created_at`, `updated_at`) VALUES
(1, 'jollibee', '$2y$10$gbmLuODHPCMB91JJuyA3Ue/r9UNNNGzbx11WNNt33HtCmtz2u5Jge', 'CDO Jollibee Kauswagan', 'Kauswagan National Highway', 20, 'Express', 8.496886, 124.630626, 'No Close', '09:00:00', '21:00:00', '543-790-120', 'https://foodlephotos.s3.ap-southeast-1.amazonaws.com/store_image/jollibee-store.png', 'https://foodlephotos.s3.ap-southeast-1.amazonaws.com/store_image/jollibee-order.png', 'https://foodlephotos.s3.ap-southeast-1.amazonaws.com/store_image/jollibee-thumbnail.png', 2, '2021-05-06 22:26:22', '2021-09-17 14:39:28'),
(2, 'mcdo', '$2y$10$WlMoRGPTfyXJvmuIWo/M0u.knMrnplILvfrSjVqQldyaLp2nXmU02', 'McDonald Kauswagan', 'Kauswagan National Highway', 20, 'Express', 8.498205, 124.62976, 'Sunday', '00:00:00', '23:59:59', '459-921-672', 'https://foodlephotos.s3.ap-southeast-1.amazonaws.com/store_image/mcdonald-store.png', 'https://foodlephotos.s3.ap-southeast-1.amazonaws.com/store_image/mcdonald-order.png', 'https://foodlephotos.s3.ap-southeast-1.amazonaws.com/store_image/mcdonald-thumbnail.png', 1, '2021-05-06 23:42:38', '2021-08-31 16:40:16'),
(3, 'greeny', '$2y$10$Z7Fozwmn3adJ8W0kbDNec.NdeIn.Smom56ZzZqQ0Uo1NerRMvCTlG', 'Greenwich - Centrio Ayala CDO', 'Claro M. Recto Avenue, corner Corrales Ave', 35, 'Express', 8.485384, 124.650716, 'Wednesday', '00:00:00', '23:59:59', '347-765-521', 'https://foodlephotos.s3.ap-southeast-1.amazonaws.com/store_image/Greenwich-CentrioAyalaCDOstorebanner.png', 'https://foodlephotos.s3.ap-southeast-1.amazonaws.com/store_image/Greenwich-CentrioAyalaCDOorderbanner.png', 'https://foodlephotos.s3.ap-southeast-1.amazonaws.com/store_image/Greenwich-CentrioAyalaCDO.png', 1, '2021-07-25 23:50:58', '2021-08-12 10:43:54'),
(4, 'blueb', '$2y$10$HX217HNE7X6/pRGGNvStm.76lHPqyo0RFdPrgMD75oENcCcXnr03.', 'Bluebasket', 'St. Ignatius St, Kauswagan', 20, 'Regular', 8.493497, 124.638518, 'No Close', '09:00:00', '21:00:00', '984-237-780', 'https://foodlephotos.s3.ap-southeast-1.amazonaws.com/store_image/Bluebasketstorebanner.png', 'https://foodlephotos.s3.ap-southeast-1.amazonaws.com/store_image/Bluebasketorderbanner.png', 'https://foodlephotos.s3.ap-southeast-1.amazonaws.com/store_image/Bluebasket.png', 1, '2021-07-26 16:45:59', '2021-08-10 22:35:00');

-- --------------------------------------------------------

--
-- Table structure for table `store_status`
--

CREATE TABLE `store_status` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `store_status`
--

INSERT INTO `store_status` (`id`, `name`, `created_at`, `updated_at`) VALUES
(1, 'Offline', '2021-06-09 16:44:15', '2021-06-09 16:44:15'),
(2, 'Online', '2021-06-09 16:00:00', '2021-06-09 16:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `tickets`
--

CREATE TABLE `tickets` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `store_id` bigint(20) UNSIGNED DEFAULT NULL,
  `rider_id` bigint(20) UNSIGNED DEFAULT NULL,
  `ticket_number` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ticket_status`
--

CREATE TABLE `ticket_status` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `ticket_status`
--

INSERT INTO `ticket_status` (`id`, `name`, `created_at`, `updated_at`) VALUES
(1, 'Open', '2021-08-10 17:20:45', '2021-08-10 17:20:45'),
(2, 'Close', '2021-08-10 17:20:45', '2021-08-10 17:20:45');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `firstname` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `lastname` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone_number` bigint(20) NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `type`, `firstname`, `lastname`, `phone_number`, `password`, `created_at`, `updated_at`) VALUES
(1, 'local', 'Reuel Dave', 'Cardines', 639262397184, '$2y$10$mjwflpOIpOqx4F.FyEVK6OXidn7tRsL6QZbChVS0T92LAqyhTDL3K', '2021-05-28 03:50:48', '2021-08-31 08:58:57'),
(2, 'local', 'Maria Nita', 'Calvo', 639263989364, '$2y$10$OdWnmfoRvo/W7NJ6YmVQ8OIMnEfCWxhdy9MZ/hiikDbZqsX5S2wvi', '2021-09-13 15:34:21', '2021-09-13 15:34:21'),
(3, 'local', 'BENJAMIN', 'Unalan', 639064805545, '$2y$10$BeuVj8kf/5fnDbMW4Jsz0.Rb/0.GCkiPNRh8gWwzfCDWdUYA.u7de', '2021-09-17 16:48:10', '2021-09-17 16:48:10');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `addresses`
--
ALTER TABLE `addresses`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `status_id` (`status_id`);

--
-- Indexes for table `address_status`
--
ALTER TABLE `address_status`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `admins`
--
ALTER TABLE `admins`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `carts`
--
ALTER TABLE `carts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_id` (`product_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `chats`
--
ALTER TABLE `chats`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ticket_id` (`ticket_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `store_id` (`store_id`),
  ADD KEY `rider_id` (`rider_id`);

--
-- Indexes for table `fares`
--
ALTER TABLE `fares`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `favourites`
--
ALTER TABLE `favourites`
  ADD PRIMARY KEY (`id`),
  ADD KEY `store_id` (`store_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `payment_id` (`payment_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `status_id` (`status_id`);

--
-- Indexes for table `order_status`
--
ALTER TABLE `order_status`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD KEY `store_id` (`store_id`),
  ADD KEY `status_id` (`status_id`);

--
-- Indexes for table `product_status`
--
ALTER TABLE `product_status`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `purchases`
--
ALTER TABLE `purchases`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_id` (`order_id`),
  ADD KEY `product_id` (`product_id`),
  ADD KEY `purchases_ibfk_3` (`status_id`);

--
-- Indexes for table `purchase_status`
--
ALTER TABLE `purchase_status`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `riders`
--
ALTER TABLE `riders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `status_id` (`status_id`);

--
-- Indexes for table `rider_orders`
--
ALTER TABLE `rider_orders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `rider_id` (`rider_id`),
  ADD KEY `status_id` (`status_id`),
  ADD KEY `rider_orders_ibfk_2` (`order_id`);

--
-- Indexes for table `rider_order_status`
--
ALTER TABLE `rider_order_status`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `rider_rooms`
--
ALTER TABLE `rider_rooms`
  ADD PRIMARY KEY (`id`),
  ADD KEY `rider_id` (`rider_id`),
  ADD KEY `store_id` (`store_id`);

--
-- Indexes for table `rider_sessions`
--
ALTER TABLE `rider_sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `rider_id` (`rider_id`),
  ADD KEY `session_id` (`session_id`);

--
-- Indexes for table `rider_status`
--
ALTER TABLE `rider_status`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `stores`
--
ALTER TABLE `stores`
  ADD PRIMARY KEY (`id`),
  ADD KEY `status_id` (`status_id`);

--
-- Indexes for table `store_status`
--
ALTER TABLE `store_status`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tickets`
--
ALTER TABLE `tickets`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `store_id` (`store_id`),
  ADD KEY `rider_id` (`rider_id`),
  ADD KEY `status_id` (`status_id`);

--
-- Indexes for table `ticket_status`
--
ALTER TABLE `ticket_status`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `addresses`
--
ALTER TABLE `addresses`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `address_status`
--
ALTER TABLE `address_status`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `admins`
--
ALTER TABLE `admins`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `carts`
--
ALTER TABLE `carts`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=75;

--
-- AUTO_INCREMENT for table `chats`
--
ALTER TABLE `chats`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fares`
--
ALTER TABLE `fares`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `favourites`
--
ALTER TABLE `favourites`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `order_status`
--
ALTER TABLE `order_status`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `payments`
--
ALTER TABLE `payments`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `product_status`
--
ALTER TABLE `product_status`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `purchases`
--
ALTER TABLE `purchases`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT for table `purchase_status`
--
ALTER TABLE `purchase_status`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `riders`
--
ALTER TABLE `riders`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `rider_orders`
--
ALTER TABLE `rider_orders`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `rider_order_status`
--
ALTER TABLE `rider_order_status`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `rider_rooms`
--
ALTER TABLE `rider_rooms`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `rider_sessions`
--
ALTER TABLE `rider_sessions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `rider_status`
--
ALTER TABLE `rider_status`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `sessions`
--
ALTER TABLE `sessions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `stores`
--
ALTER TABLE `stores`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `store_status`
--
ALTER TABLE `store_status`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `tickets`
--
ALTER TABLE `tickets`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `ticket_status`
--
ALTER TABLE `ticket_status`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `addresses`
--
ALTER TABLE `addresses`
  ADD CONSTRAINT `addresses_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `addresses_ibfk_2` FOREIGN KEY (`status_id`) REFERENCES `address_status` (`id`);

--
-- Constraints for table `carts`
--
ALTER TABLE `carts`
  ADD CONSTRAINT `carts_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`),
  ADD CONSTRAINT `carts_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `chats`
--
ALTER TABLE `chats`
  ADD CONSTRAINT `chats_ibfk_1` FOREIGN KEY (`ticket_id`) REFERENCES `tickets` (`id`),
  ADD CONSTRAINT `chats_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `chats_ibfk_3` FOREIGN KEY (`store_id`) REFERENCES `stores` (`id`),
  ADD CONSTRAINT `chats_ibfk_4` FOREIGN KEY (`rider_id`) REFERENCES `riders` (`id`);

--
-- Constraints for table `favourites`
--
ALTER TABLE `favourites`
  ADD CONSTRAINT `favourites_ibfk_1` FOREIGN KEY (`store_id`) REFERENCES `stores` (`id`),
  ADD CONSTRAINT `favourites_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`payment_id`) REFERENCES `payments` (`id`),
  ADD CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `orders_ibfk_3` FOREIGN KEY (`status_id`) REFERENCES `order_status` (`id`);

--
-- Constraints for table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_ibfk_1` FOREIGN KEY (`store_id`) REFERENCES `stores` (`id`),
  ADD CONSTRAINT `products_ibfk_2` FOREIGN KEY (`status_id`) REFERENCES `product_status` (`id`);

--
-- Constraints for table `purchases`
--
ALTER TABLE `purchases`
  ADD CONSTRAINT `purchases_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`),
  ADD CONSTRAINT `purchases_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`),
  ADD CONSTRAINT `purchases_ibfk_3` FOREIGN KEY (`status_id`) REFERENCES `purchase_status` (`id`);

--
-- Constraints for table `riders`
--
ALTER TABLE `riders`
  ADD CONSTRAINT `riders_ibfk_1` FOREIGN KEY (`status_id`) REFERENCES `rider_status` (`id`);

--
-- Constraints for table `rider_orders`
--
ALTER TABLE `rider_orders`
  ADD CONSTRAINT `rider_orders_ibfk_1` FOREIGN KEY (`rider_id`) REFERENCES `riders` (`id`),
  ADD CONSTRAINT `rider_orders_ibfk_2` FOREIGN KEY (`order_id`) REFERENCES `purchases` (`order_id`),
  ADD CONSTRAINT `rider_orders_ibfk_3` FOREIGN KEY (`status_id`) REFERENCES `rider_order_status` (`id`);

--
-- Constraints for table `rider_rooms`
--
ALTER TABLE `rider_rooms`
  ADD CONSTRAINT `rider_rooms_ibfk_1` FOREIGN KEY (`rider_id`) REFERENCES `riders` (`id`),
  ADD CONSTRAINT `rider_rooms_ibfk_2` FOREIGN KEY (`store_id`) REFERENCES `stores` (`id`);

--
-- Constraints for table `rider_sessions`
--
ALTER TABLE `rider_sessions`
  ADD CONSTRAINT `rider_sessions_ibfk_1` FOREIGN KEY (`rider_id`) REFERENCES `riders` (`id`),
  ADD CONSTRAINT `rider_sessions_ibfk_2` FOREIGN KEY (`session_id`) REFERENCES `sessions` (`id`);

--
-- Constraints for table `stores`
--
ALTER TABLE `stores`
  ADD CONSTRAINT `stores_ibfk_1` FOREIGN KEY (`status_id`) REFERENCES `store_status` (`id`);

--
-- Constraints for table `tickets`
--
ALTER TABLE `tickets`
  ADD CONSTRAINT `tickets_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `tickets_ibfk_2` FOREIGN KEY (`store_id`) REFERENCES `stores` (`id`),
  ADD CONSTRAINT `tickets_ibfk_3` FOREIGN KEY (`rider_id`) REFERENCES `riders` (`id`),
  ADD CONSTRAINT `tickets_ibfk_4` FOREIGN KEY (`status_id`) REFERENCES `ticket_status` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
