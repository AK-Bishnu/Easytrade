-- MySQL dump 10.13  Distrib 8.0.45, for Win64 (x86_64)
--
-- Host: localhost    Database: easytrade_db
-- ------------------------------------------------------
-- Server version	8.0.45

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',3,'add_permission'),(6,'Can change permission',3,'change_permission'),(7,'Can delete permission',3,'delete_permission'),(8,'Can view permission',3,'view_permission'),(9,'Can add group',2,'add_group'),(10,'Can change group',2,'change_group'),(11,'Can delete group',2,'delete_group'),(12,'Can view group',2,'view_group'),(13,'Can add user',4,'add_user'),(14,'Can change user',4,'change_user'),(15,'Can delete user',4,'delete_user'),(16,'Can view user',4,'view_user'),(17,'Can add content type',5,'add_contenttype'),(18,'Can change content type',5,'change_contenttype'),(19,'Can delete content type',5,'delete_contenttype'),(20,'Can view content type',5,'view_contenttype'),(21,'Can add session',6,'add_session'),(22,'Can change session',6,'change_session'),(23,'Can delete session',6,'delete_session'),(24,'Can view session',6,'view_session'),(25,'Can add category',7,'add_category'),(26,'Can change category',7,'change_category'),(27,'Can delete category',7,'delete_category'),(28,'Can view category',7,'view_category'),(29,'Can add product',8,'add_product'),(30,'Can change product',8,'change_product'),(31,'Can delete product',8,'delete_product'),(32,'Can view product',8,'view_product'),(33,'Can add product image',9,'add_productimage'),(34,'Can change product image',9,'change_productimage'),(35,'Can delete product image',9,'delete_productimage'),(36,'Can view product image',9,'view_productimage'),(37,'Can add user profile',10,'add_userprofile'),(38,'Can change user profile',10,'change_userprofile'),(39,'Can delete user profile',10,'delete_userprofile'),(40,'Can view user profile',10,'view_userprofile'),(41,'Can add favourite',11,'add_favourite'),(42,'Can change favourite',11,'change_favourite'),(43,'Can delete favourite',11,'delete_favourite'),(44,'Can view favourite',11,'view_favourite');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (1,'pbkdf2_sha256$1200000$x3rQJuYNuG3CoiLZBk2Reg$83iXvGCExYo3EwwMX1cg+pZR67qnn/8PYKKxzptM06M=','2026-03-07 17:22:11.110233',1,'ak','','','',1,1,'2026-03-07 17:21:40.798267'),(29,'pbkdf2_sha256$1200000$cCMAtmJ2UExu34dpzAefve$AAoBkHNfy3DfcYZkpWZa1+BSDXDa1ifjYvof+kDOMfE=',NULL,0,'Bishnu','','','akbishnu006@gmail.com',0,1,'2026-03-14 06:22:25.056086');
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_groups` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `django_admin_log_chk_1` CHECK ((`action_flag` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2026-03-07 17:54:49.389958','1','ak',1,'[{\"added\": {}}]',10,1),(2,'2026-03-07 17:55:06.265403','1','Books',1,'[{\"added\": {}}]',7,1),(3,'2026-03-07 17:55:46.749581','1','Physics 1st paper',1,'[{\"added\": {}}]',8,1),(4,'2026-03-07 17:58:56.795731','2','Math',1,'[{\"added\": {}}]',8,1),(5,'2026-03-08 05:51:54.654458','2','Bishnu',3,'',4,1),(6,'2026-03-08 05:58:08.299914','3','Bishnu',3,'',4,1),(7,'2026-03-08 06:39:17.178932','4','Bishnu',3,'',4,1),(8,'2026-03-08 06:52:30.891665','5','Bishnu',3,'',4,1),(9,'2026-03-08 06:53:26.530025','6','Bishnu',3,'',4,1),(10,'2026-03-08 06:58:49.222210','7','Bishnu',3,'',4,1),(11,'2026-03-08 12:58:18.103899','2','Phone',1,'[{\"added\": {}}]',7,1),(12,'2026-03-08 12:58:41.410264','3','infinix note 12',1,'[{\"added\": {}}]',8,1),(13,'2026-03-08 13:44:47.010685','3','infinix note 12',2,'[{\"added\": {\"name\": \"product image\", \"object\": \"Image for infinix note 12\"}}]',8,1),(14,'2026-03-09 07:21:55.005069','1','Physics 1st paper',2,'[{\"added\": {\"name\": \"product image\", \"object\": \"Image for Physics 1st paper\"}}]',8,1),(15,'2026-03-09 07:23:43.444724','1','Physics 1st paper',2,'[{\"added\": {\"name\": \"product image\", \"object\": \"Image for Physics 1st paper\"}}]',8,1),(16,'2026-03-10 05:20:14.041122','8','Bishnu',3,'',4,1),(17,'2026-03-10 05:48:12.895907','9','Bishnu',3,'',4,1),(18,'2026-03-10 06:02:15.634177','10','Bishnu',3,'',4,1),(19,'2026-03-10 06:14:52.838433','11','Bishnu',3,'',4,1),(20,'2026-03-10 06:49:47.057211','12','Bishnu',3,'',4,1),(21,'2026-03-10 06:54:11.085367','13','Bishnu',3,'',4,1),(22,'2026-03-10 06:59:21.057456','14','Bishnu',3,'',4,1),(23,'2026-03-10 07:02:24.587957','15','Bishnu',3,'',4,1),(24,'2026-03-10 07:09:32.264850','16','Bishnu',3,'',4,1),(25,'2026-03-10 07:19:00.204538','17','Bishnu',3,'',4,1),(26,'2026-03-10 07:22:18.876038','18','Bishnu',3,'',4,1),(27,'2026-03-10 07:30:58.236975','19','Bishnu',3,'',4,1),(28,'2026-03-10 12:22:02.807962','20','Bishnu',3,'',4,1),(29,'2026-03-10 19:38:06.696636','4','Infinix',1,'[{\"added\": {}}]',8,1),(30,'2026-03-14 05:46:41.664372','21','Bishnu',3,'',4,1),(31,'2026-03-14 05:49:06.744743','22','Bishnu',3,'',4,1),(32,'2026-03-14 05:53:14.220036','23','Bishnu',3,'',4,1),(33,'2026-03-14 05:57:51.119210','24','Bishnu',3,'',4,1),(34,'2026-03-14 05:59:38.649035','25','Bishnu',3,'',4,1),(35,'2026-03-14 06:07:28.006222','26','bishnu',3,'',4,1),(36,'2026-03-14 06:11:06.382486','27','bishnu',3,'',4,1),(37,'2026-03-14 06:22:00.171041','28','bishnu',3,'',4,1),(38,'2026-03-14 13:09:24.598623','2','Device',2,'[{\"changed\": {\"fields\": [\"Name\", \"Slug\"]}}]',7,1),(39,'2026-03-14 13:09:57.186716','1','Books & Notes',2,'[{\"changed\": {\"fields\": [\"Name\"]}}]',7,1),(40,'2026-03-14 13:10:20.651235','3','Lab Equipment',1,'[{\"added\": {}}]',7,1),(41,'2026-03-14 13:10:33.087557','4','Stationery',1,'[{\"added\": {}}]',7,1),(42,'2026-03-14 13:10:57.247928','5','Electronics',1,'[{\"added\": {}}]',7,1),(43,'2026-03-14 13:11:09.500215','6','Furniture',1,'[{\"added\": {}}]',7,1),(44,'2026-03-14 13:11:21.109429','7','Clothing',1,'[{\"added\": {}}]',7,1),(45,'2026-03-14 13:11:37.263577','8','Others',1,'[{\"added\": {}}]',7,1),(46,'2026-03-14 13:13:00.490839','9','Vehicle',1,'[{\"added\": {}}]',7,1),(47,'2026-03-14 13:13:09.807023','10','Food',1,'[{\"added\": {}}]',7,1),(48,'2026-03-14 13:15:07.280532','11','Sports',1,'[{\"added\": {}}]',7,1),(49,'2026-03-15 05:30:43.399624','8','Others',3,'',7,1),(50,'2026-03-15 05:31:23.063066','12','Others',1,'[{\"added\": {}}]',7,1);
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(2,'auth','group'),(3,'auth','permission'),(4,'auth','user'),(5,'contenttypes','contenttype'),(7,'myapp','category'),(11,'myapp','favourite'),(8,'myapp','product'),(9,'myapp','productimage'),(10,'myapp','userprofile'),(6,'sessions','session');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_migrations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2026-03-07 13:29:22.483973'),(2,'auth','0001_initial','2026-03-07 13:29:22.999389'),(3,'admin','0001_initial','2026-03-07 13:29:23.132626'),(4,'admin','0002_logentry_remove_auto_add','2026-03-07 13:29:23.139943'),(5,'admin','0003_logentry_add_action_flag_choices','2026-03-07 13:29:23.145692'),(6,'contenttypes','0002_remove_content_type_name','2026-03-07 13:29:23.254708'),(7,'auth','0002_alter_permission_name_max_length','2026-03-07 13:29:23.338192'),(8,'auth','0003_alter_user_email_max_length','2026-03-07 13:29:23.363847'),(9,'auth','0004_alter_user_username_opts','2026-03-07 13:29:23.374057'),(10,'auth','0005_alter_user_last_login_null','2026-03-07 13:29:23.433464'),(11,'auth','0006_require_contenttypes_0002','2026-03-07 13:29:23.436076'),(12,'auth','0007_alter_validators_add_error_messages','2026-03-07 13:29:23.441884'),(13,'auth','0008_alter_user_username_max_length','2026-03-07 13:29:23.508771'),(14,'auth','0009_alter_user_last_name_max_length','2026-03-07 13:29:23.577174'),(15,'auth','0010_alter_group_name_max_length','2026-03-07 13:29:23.598437'),(16,'auth','0011_update_proxy_permissions','2026-03-07 13:29:23.608289'),(17,'auth','0012_alter_user_first_name_max_length','2026-03-07 13:29:23.674410'),(18,'myapp','0001_initial','2026-03-07 13:29:24.053612'),(19,'sessions','0001_initial','2026-03-07 13:29:24.091171'),(20,'myapp','0002_alter_product_category_alter_product_created_at_and_more','2026-03-07 17:25:33.275389'),(21,'myapp','0003_userprofile_is_verified_and_more','2026-03-08 05:22:49.976162'),(22,'myapp','0004_alter_productimage_image','2026-03-08 12:33:19.448619'),(23,'myapp','0005_alter_userprofile_facebook_and_more','2026-03-12 07:44:34.553888');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('yqegdyhywv0zuc2nswf47dto6l3hdh0k','.eJxVjDsOwjAQBe_iGln-ZeOlpM8ZrLW9JgEUS3FSIe5OIqWA9s3Me4tA2zqGrfESpiyuQovL7xYpPXk-QH7QfK8y1XldpigPRZ60yaFmft1O9-9gpDbuNUdjENEVVAVARUAP2pGFbByXrrfeEvbKGAWplMTaeOhSsXoHSJnF5wvAozcr:1vyvLv:n8Pyp7pWeXoshT6K-A91VL6LIc-S5rf6Zdir2I6uPUk','2026-03-21 17:22:11.114051');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `myapp_category`
--

DROP TABLE IF EXISTS `myapp_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `myapp_category` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `slug` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `slug` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `myapp_category`
--

LOCK TABLES `myapp_category` WRITE;
/*!40000 ALTER TABLE `myapp_category` DISABLE KEYS */;
INSERT INTO `myapp_category` VALUES (1,'Books & Notes','books'),(2,'Device','device'),(3,'Lab Equipment','labEquipment'),(4,'Stationery','stationery'),(5,'Electronics','electronics'),(6,'Furniture','furniture'),(7,'Clothing','clothing'),(9,'Vehicle','vehicle'),(10,'Food','food'),(11,'Sports','sports'),(12,'Others','ot');
/*!40000 ALTER TABLE `myapp_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `myapp_favourite`
--

DROP TABLE IF EXISTS `myapp_favourite`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `myapp_favourite` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) NOT NULL,
  `product_id` bigint NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `myapp_favourite_user_id_product_id_d761297e_uniq` (`user_id`,`product_id`),
  KEY `myapp_favourite_product_id_89c6e450_fk_myapp_product_id` (`product_id`),
  CONSTRAINT `myapp_favourite_product_id_89c6e450_fk_myapp_product_id` FOREIGN KEY (`product_id`) REFERENCES `myapp_product` (`id`),
  CONSTRAINT `myapp_favourite_user_id_039b5077_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `myapp_favourite`
--

LOCK TABLES `myapp_favourite` WRITE;
/*!40000 ALTER TABLE `myapp_favourite` DISABLE KEYS */;
INSERT INTO `myapp_favourite` VALUES (28,'2026-03-14 07:33:31.300554',1,29),(30,'2026-03-14 16:13:44.223761',12,29),(32,'2026-03-14 16:13:57.102822',10,29);
/*!40000 ALTER TABLE `myapp_favourite` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `myapp_product`
--

DROP TABLE IF EXISTS `myapp_product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `myapp_product` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `title` varchar(200) NOT NULL,
  `description` longtext NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `location` varchar(150) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `category_id` bigint NOT NULL,
  `seller_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `myapp_product_category_id_f672ddc0_fk_myapp_category_id` (`category_id`),
  KEY `myapp_product_created_at_5c3853ef` (`created_at`),
  KEY `myapp_product_seller_id_7a14a5cb_fk_auth_user_id` (`seller_id`),
  CONSTRAINT `myapp_product_category_id_f672ddc0_fk_myapp_category_id` FOREIGN KEY (`category_id`) REFERENCES `myapp_category` (`id`),
  CONSTRAINT `myapp_product_seller_id_7a14a5cb_fk_auth_user_id` FOREIGN KEY (`seller_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `myapp_product`
--

LOCK TABLES `myapp_product` WRITE;
/*!40000 ALTER TABLE `myapp_product` DISABLE KEYS */;
INSERT INTO `myapp_product` VALUES (1,'Physics 1st paper','adgkgkdsgladsjgkldsj',200.00,'ruet','2026-03-07 17:55:46.748222',1,1),(10,'Infinix note 12','itsjgjsg  dkful it skgj jgmgkjgkjgm jvk;lkjfk;gkjg fl',1000.00,'Hamid Hall, Ruet','2026-03-14 11:53:03.900439',2,29),(11,'Book 1','Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.',900.00,'sirajganj','2026-03-14 16:00:40.555344',1,29),(12,'Book 2','Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.',1200.00,'shahjadpur','2026-03-14 16:03:32.827162',1,29),(13,'Musical Books','Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.',700.00,'zia hall, ruet','2026-03-14 16:08:59.836441',1,29),(14,'music books 2','It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using \'Content here, content here\', making it look',1400.00,'porjana','2026-03-14 17:36:35.914056',1,29);
/*!40000 ALTER TABLE `myapp_product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `myapp_productimage`
--

DROP TABLE IF EXISTS `myapp_productimage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `myapp_productimage` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `image` varchar(255) NOT NULL,
  `product_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `myapp_productimage_product_id_debc49cd_fk_myapp_product_id` (`product_id`),
  CONSTRAINT `myapp_productimage_product_id_debc49cd_fk_myapp_product_id` FOREIGN KEY (`product_id`) REFERENCES `myapp_product` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `myapp_productimage`
--

LOCK TABLES `myapp_productimage` WRITE;
/*!40000 ALTER TABLE `myapp_productimage` DISABLE KEYS */;
INSERT INTO `myapp_productimage` VALUES (2,'image/upload/v1773040914/nozhwx0tzvddgp5bu1vp.png',1),(3,'image/upload/v1773041022/ntxpxyqqrhpin4jg8tgs.jpg',1),(6,'image/upload/v1773489187/cz9tp0ed1rrpt2310mgs.jpg',10),(7,'image/upload/v1773489188/vb32ujid5hfktrgwd519.jpg',10),(8,'image/upload/v1773504044/so4nlzugkijd6vfavybu.jpg',11),(9,'image/upload/v1773504046/eru9o9vv8xns0vj3h6zf.jpg',11),(10,'image/upload/v1773504214/nakeh8algw0kkwolkny7.jpg',12),(11,'image/upload/v1773504216/arew4fcezcvrp9peuwlv.jpg',12),(12,'image/upload/v1773504541/ed8nr5collxsoabiqomr.jpg',13),(13,'image/upload/v1773504543/unxrxlfl9q0mual6iyvp.jpg',13),(14,'image/upload/v1773509799/vs7t53cjnocueftkn1h6.jpg',14),(15,'image/upload/v1773509800/ocsxflhwlmtx55vpc8um.jpg',14);
/*!40000 ALTER TABLE `myapp_productimage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `myapp_userprofile`
--

DROP TABLE IF EXISTS `myapp_userprofile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `myapp_userprofile` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `whatsapp` varchar(200) DEFAULT NULL,
  `telegram` varchar(200) DEFAULT NULL,
  `facebook` varchar(200) DEFAULT NULL,
  `user_id` int NOT NULL,
  `is_verified` tinyint(1) NOT NULL,
  `verification_token` char(32) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`),
  UNIQUE KEY `myapp_userprofile_facebook_eab9cbbb_uniq` (`facebook`),
  UNIQUE KEY `myapp_userprofile_telegram_e7b38927_uniq` (`telegram`),
  UNIQUE KEY `myapp_userprofile_whatsapp_c35f4fe3_uniq` (`whatsapp`),
  CONSTRAINT `myapp_userprofile_user_id_8f877d36_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `myapp_userprofile`
--

LOCK TABLES `myapp_userprofile` WRITE;
/*!40000 ALTER TABLE `myapp_userprofile` DISABLE KEYS */;
INSERT INTO `myapp_userprofile` VALUES (1,NULL,NULL,'https://www.facebook.com/aronnokumar.bishnu.5',1,0,'11a33c1b005246bbbe2983dec6efab79'),(30,'','','https://www.facebook.com/arnob.ghosh.238769',29,1,'cb6bc3860c404aeb950d2da3a0e7c859');
/*!40000 ALTER TABLE `myapp_userprofile` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-03-17 19:23:20
