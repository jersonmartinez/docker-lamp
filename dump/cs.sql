-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Servidor: db
-- Tiempo de generación: 23-12-2020 a las 21:08:35
-- Versión del servidor: 8.0.22
-- Versión de PHP: 7.4.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `cs`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cs_articles`
--

CREATE TABLE `cs_articles` (
  `id` int UNSIGNED NOT NULL,
  `title` varchar(700) NOT NULL,
  `content` mediumtext NOT NULL,
  `description` varchar(1000) NOT NULL,
  `username` varchar(50) NOT NULL,
  `created` varchar(30) NOT NULL,
  `publish_date` varchar(30) DEFAULT NULL,
  `modified_lastdate` varchar(30) DEFAULT NULL,
  `modified_by_username` varchar(50) DEFAULT NULL,
  `status` enum('saved','published') DEFAULT 'saved',
  `visible` enum('1','0') DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `cs_articles`
--

INSERT INTO `cs_articles` (`id`, `title`, `content`, `description`, `username`, `created`, `publish_date`, `modified_lastdate`, `modified_by_username`, `status`, `visible`) VALUES
(1, 'Securing Your GitHub Account with SSH Keys', '<div><p>Working with source control in your own public or private GitHub repository will be a common occurrence for most system administrators. Through the use of standard SSH tools, the student will learn how to generate a special SSH key that can be used to secure access to a private repository. At the end of this learning activity, the student will know how to generate, add, and use this SSH key to secure their access to private repositories.<br></p><div><h4>Using Docker Bench to Enhance Container Security<br></h4></div><div><p>This lab allows the student to explore the Docker Bench utility for hardening Docker installations. The student gains access to the lab server via SSH, and clones the Docker Bench repo from github.com. Then the student executes the bench utility, views the report, and then enables auditing of the Docker Daemon. After enabling auditing, the utility is run again and the new report is compared with the old.<br></p></div><div><div style=\"background:#eeeeee;border:1px solid #cccccc;padding:5px 10px;\">Deploy a Web Application with Terraform<br></div></div><div><p>In this lab, we will be deploying an Azure Application Service plan with a .NET Framework site with a Local Git content management setting. If you are working with a DevOps team, you may encounter many requests to either set up a Web app or provide the DevOps team with a way to deploy their own. By deploying the application with Terraform, you can set guidelines for naming conventions, code repo\'s, service plan levels, and deployment locations.<br></p></div><div><h3><span class=\"marker\">Building with Git in Jenkins</span><br></h3></div><div><p>In this lesson we will be leveraging Source Code Management to provide the code for our build. This means that we will add the step of cloning from Git, as well as installing a required build tool and archiving the artifact of the build<br></p></div><div><h3 style=\"color:#aaaaaa;font-style:italic;\">Using TensorFlow/Keras Basic Image Classifier (AWS SageMaker)<br></h3></div><div><p>TensorFlow is the biggest name in machine learning and artificial intelligence. In this activity, we will use TensorFlow and Keras to create an artificial neural network that performs a basic image classification task. In this lab, we use our own data set and again get one step closer to the dream of an automated Lego brick sorting machine. The files used in this lab can be found on GitHub.<br></p></div><div><h3>Using Scikit-learn Random Forest Classifier (AWS SageMaker)</h3></div><div><p>Scikit-learn is a great place to start working with machine learning and artificial intelligence. In this activity, we will use Scikit-learn to create a Random Forest Classifier that performs a basic classification of people to see if they are likely to prefer dogs or cats. In this lab, we use a fictitious data set that could easily be replaced with one of your own. The files used in this lab can be found on GitHub.</p></div><div><div><br></div></div><p><br></p></div>', 'Working with source control in your own public or private GitHub repository will be a common occurrence for most system administrators. Through the use of standard SSH tools.', 'Side Master', '1608756822', '1608756822', '-', '-', 'published', '1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cs_articles_cover_images`
--

CREATE TABLE `cs_articles_cover_images` (
  `id` int UNSIGNED NOT NULL,
  `id_article` int UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `created` varchar(30) NOT NULL,
  `modified_lastdate` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `cs_articles_cover_images`
--

INSERT INTO `cs_articles_cover_images` (`id`, `id_article`, `name`, `created`, `modified_lastdate`) VALUES
(1, 1, 'Screenshot_1.png', '1608756822', '-');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cs_articles_tags`
--

CREATE TABLE `cs_articles_tags` (
  `id` int UNSIGNED NOT NULL,
  `id_sub_tag` int UNSIGNED NOT NULL,
  `id_article` int UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `cs_articles_tags`
--

INSERT INTO `cs_articles_tags` (`id`, `id_sub_tag`, `id_article`) VALUES
(1, 9, 1),
(2, 6, 1),
(3, 4, 1),
(4, 8, 1),
(5, 7, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cs_articles_url`
--

CREATE TABLE `cs_articles_url` (
  `id` int UNSIGNED NOT NULL,
  `id_article` int UNSIGNED NOT NULL,
  `current_url` varchar(500) NOT NULL,
  `before_url` varchar(500) DEFAULT NULL,
  `modified_lastdate` varchar(30) DEFAULT NULL,
  `modified_by_username` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `cs_articles_url`
--

INSERT INTO `cs_articles_url` (`id`, `id_article`, `current_url`, `before_url`, `modified_lastdate`, `modified_by_username`) VALUES
(1, 1, 'securing_your_github_account_with_ssh_keys', '-', '1608756822', 'Side Master');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cs_batch_course`
--

CREATE TABLE `cs_batch_course` (
  `id` int UNSIGNED NOT NULL,
  `video_id` varchar(20) NOT NULL,
  `title` varchar(100) NOT NULL,
  `duration` varchar(10) NOT NULL,
  `unit_id` int UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `cs_batch_course`
--

INSERT INTO `cs_batch_course` (`id`, `video_id`, `title`, `duration`, `unit_id`) VALUES
(1, 'X18jJBXK8jM', 'Presentación', '04:48', 0),
(2, '_t-p2mcE7SM', 'Comandos básicos', '10:16', 1),
(3, 'P7fDSRl2V-I', 'Rutas de acceso', '08:22', 1),
(4, 'wdpOx-evxWs', 'Gestión de directorios', '10:22', 2),
(5, 'WVoe_xtSyUs', 'Gestión de ficheros', '11:08', 2),
(6, 'mQgjiaEd0b0', 'Árbol de directorios', '05:43', 2),
(7, '_nv6hr0-trA', 'Copiar, mover archivos y directorios', '12:08', 2),
(8, 'qCSFDkwzLEo', 'Cambiar y guardar rutas', '04:07', 3),
(9, 'BJ39yF2LcMI', 'Instancias', '08:26', 3),
(10, 'wfGxWz3NYV4', 'Máscaras y comodines', '17:40', 4),
(11, 'q71bisp9q4c', 'Gestión del PROMPT', '15:18', 5),
(12, 'uLjg19Z61ik', 'Teclas de funciones', '06:54', 5),
(13, 'swsfoRCiK4E', 'Documentación oficial', '07:21', 6),
(14, 'QxZ1Q35G-tI', 'Manipulación de fecha y hora', '15:54', 7);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cs_subscriptions`
--

CREATE TABLE `cs_subscriptions` (
  `id` int UNSIGNED NOT NULL,
  `email` varchar(256) NOT NULL,
  `date_unix` varchar(30) NOT NULL,
  `notified` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `cs_subscriptions`
--

INSERT INTO `cs_subscriptions` (`id`, `email`, `date_unix`, `notified`) VALUES
(4, 'jersonmartinezsm@gmail.com', '1608756101', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cs_sub_tags`
--

CREATE TABLE `cs_sub_tags` (
  `id` int UNSIGNED NOT NULL,
  `id_tag` int UNSIGNED NOT NULL,
  `sub_tag_name` varchar(255) NOT NULL,
  `username` varchar(50) NOT NULL,
  `date_unix` varchar(30) NOT NULL,
  `del` int DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `cs_sub_tags`
--

INSERT INTO `cs_sub_tags` (`id`, `id_tag`, `sub_tag_name`, `username`, `date_unix`, `del`) VALUES
(1, 2, 'MySQL', 'Side Master', '1608756187', 0),
(2, 2, 'NoSQL', 'Side Master', '1608756189', 0),
(3, 2, 'SQL Server', 'Side Master', '1608756192', 0),
(4, 2, 'MariaDB', 'Side Master', '1608756194', 0),
(5, 2, 'MongoDB', 'Side Master', '1608756196', 1),
(6, 2, 'PostgreSQL', 'Side Master', '1608756203', 0),
(7, 1, 'Development', 'Side Master', '1608756212', 0),
(8, 1, 'Operations', 'Side Master', '1608756217', 0),
(9, 2, 'MongoDB', 'Side Master', '1608756244', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cs_tags`
--

CREATE TABLE `cs_tags` (
  `id` int UNSIGNED NOT NULL,
  `tag_name` varchar(255) NOT NULL,
  `color` varchar(10) DEFAULT NULL,
  `username` varchar(50) NOT NULL,
  `date_unix` varchar(30) NOT NULL,
  `del` int DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `cs_tags`
--

INSERT INTO `cs_tags` (`id`, `tag_name`, `color`, `username`, `date_unix`, `del`) VALUES
(1, 'DevOps', NULL, 'Side Master', '1608756169', 0),
(2, 'Databases', NULL, 'Side Master', '1608756180', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cs_units_batch_course`
--

CREATE TABLE `cs_units_batch_course` (
  `unit_id` int UNSIGNED NOT NULL,
  `title` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `cs_units_batch_course`
--

INSERT INTO `cs_units_batch_course` (`unit_id`, `title`) VALUES
(0, 'Introducción'),
(1, 'Fundamentos sobre el uso de la consola'),
(2, 'Gestión de directorios y ficheros'),
(3, 'Rutas e instancias'),
(4, 'Máscaras y comodines'),
(5, 'PROMT y teclas de funciones'),
(6, 'Documentación'),
(7, 'Manipulación de fecha y hora');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cs_unsubscriptions`
--

CREATE TABLE `cs_unsubscriptions` (
  `id` int UNSIGNED NOT NULL,
  `email` varchar(256) NOT NULL,
  `date_unix_subscription` varchar(30) NOT NULL,
  `date_unix_unsubscription` varchar(30) NOT NULL,
  `notified` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cs_user`
--

CREATE TABLE `cs_user` (
  `id` int UNSIGNED NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(60) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `cs_user`
--

INSERT INTO `cs_user` (`id`, `username`, `password`) VALUES
(1, 'Side Master', '$2y$10$AtD0K3rsypviqAioySivgex7Dhfo0skhwZsLK1FHfP2tnMXIjXzae'),
(2, 'Frankenstein', '$2y$10$AtD0K3rsypviqAioySivgex7Dhfo0skhwZsLK1FHfP2tnMXIjXzae');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cs_user_info`
--

CREATE TABLE `cs_user_info` (
  `username` varchar(50) NOT NULL,
  `firstname` varchar(50) DEFAULT NULL,
  `lastname` varchar(50) DEFAULT NULL,
  `date_unix` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `cs_user_info`
--

INSERT INTO `cs_user_info` (`username`, `firstname`, `lastname`, `date_unix`) VALUES
('Frankenstein', 'Frankier', 'Flores', '1608663017'),
('Side Master', 'Antonio', 'Moreno', '1608663017');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `cs_articles`
--
ALTER TABLE `cs_articles`
  ADD PRIMARY KEY (`id`),
  ADD KEY `username` (`username`);

--
-- Indices de la tabla `cs_articles_cover_images`
--
ALTER TABLE `cs_articles_cover_images`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_article` (`id_article`);

--
-- Indices de la tabla `cs_articles_tags`
--
ALTER TABLE `cs_articles_tags`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_sub_tag` (`id_sub_tag`),
  ADD KEY `id_article` (`id_article`);

--
-- Indices de la tabla `cs_articles_url`
--
ALTER TABLE `cs_articles_url`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_article` (`id_article`);

--
-- Indices de la tabla `cs_batch_course`
--
ALTER TABLE `cs_batch_course`
  ADD PRIMARY KEY (`id`),
  ADD KEY `unit_id` (`unit_id`);

--
-- Indices de la tabla `cs_subscriptions`
--
ALTER TABLE `cs_subscriptions`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `cs_sub_tags`
--
ALTER TABLE `cs_sub_tags`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_tag` (`id_tag`),
  ADD KEY `username` (`username`);

--
-- Indices de la tabla `cs_tags`
--
ALTER TABLE `cs_tags`
  ADD PRIMARY KEY (`id`),
  ADD KEY `username` (`username`);

--
-- Indices de la tabla `cs_units_batch_course`
--
ALTER TABLE `cs_units_batch_course`
  ADD PRIMARY KEY (`unit_id`);

--
-- Indices de la tabla `cs_unsubscriptions`
--
ALTER TABLE `cs_unsubscriptions`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `cs_user`
--
ALTER TABLE `cs_user`
  ADD PRIMARY KEY (`id`),
  ADD KEY `username` (`username`);

--
-- Indices de la tabla `cs_user_info`
--
ALTER TABLE `cs_user_info`
  ADD PRIMARY KEY (`username`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `cs_articles`
--
ALTER TABLE `cs_articles`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `cs_articles_cover_images`
--
ALTER TABLE `cs_articles_cover_images`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `cs_articles_tags`
--
ALTER TABLE `cs_articles_tags`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `cs_articles_url`
--
ALTER TABLE `cs_articles_url`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `cs_batch_course`
--
ALTER TABLE `cs_batch_course`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT de la tabla `cs_subscriptions`
--
ALTER TABLE `cs_subscriptions`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `cs_sub_tags`
--
ALTER TABLE `cs_sub_tags`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `cs_tags`
--
ALTER TABLE `cs_tags`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `cs_unsubscriptions`
--
ALTER TABLE `cs_unsubscriptions`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `cs_user`
--
ALTER TABLE `cs_user`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `cs_articles`
--
ALTER TABLE `cs_articles`
  ADD CONSTRAINT `cs_articles_ibfk_1` FOREIGN KEY (`username`) REFERENCES `cs_user_info` (`username`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `cs_articles_cover_images`
--
ALTER TABLE `cs_articles_cover_images`
  ADD CONSTRAINT `cs_articles_cover_images_ibfk_1` FOREIGN KEY (`id_article`) REFERENCES `cs_articles` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `cs_articles_tags`
--
ALTER TABLE `cs_articles_tags`
  ADD CONSTRAINT `cs_articles_tags_ibfk_1` FOREIGN KEY (`id_sub_tag`) REFERENCES `cs_sub_tags` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `cs_articles_tags_ibfk_2` FOREIGN KEY (`id_article`) REFERENCES `cs_articles` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `cs_articles_url`
--
ALTER TABLE `cs_articles_url`
  ADD CONSTRAINT `cs_articles_url_ibfk_1` FOREIGN KEY (`id_article`) REFERENCES `cs_articles` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `cs_batch_course`
--
ALTER TABLE `cs_batch_course`
  ADD CONSTRAINT `cs_batch_course_ibfk_1` FOREIGN KEY (`unit_id`) REFERENCES `cs_units_batch_course` (`unit_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `cs_sub_tags`
--
ALTER TABLE `cs_sub_tags`
  ADD CONSTRAINT `cs_sub_tags_ibfk_1` FOREIGN KEY (`id_tag`) REFERENCES `cs_tags` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `cs_sub_tags_ibfk_2` FOREIGN KEY (`username`) REFERENCES `cs_user_info` (`username`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `cs_tags`
--
ALTER TABLE `cs_tags`
  ADD CONSTRAINT `cs_tags_ibfk_1` FOREIGN KEY (`username`) REFERENCES `cs_user_info` (`username`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `cs_user`
--
ALTER TABLE `cs_user`
  ADD CONSTRAINT `cs_user_ibfk_1` FOREIGN KEY (`username`) REFERENCES `cs_user_info` (`username`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
