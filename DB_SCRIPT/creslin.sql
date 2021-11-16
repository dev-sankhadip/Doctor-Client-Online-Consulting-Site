-- MySQL dump 10.13  Distrib 8.0.26, for macos11 (arm64)
--
-- Host: localhost    Database: creslin
-- ------------------------------------------------------
-- Server version	8.0.26

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
-- Table structure for table `tbl_Api_Log`
--

DROP TABLE IF EXISTS `tbl_Api_Log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_Api_Log` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `Process_Name` varchar(50) NOT NULL,
  `Process_Type_Id` varchar(50) NOT NULL,
  `Process_Type_Value` varchar(100) DEFAULT NULL,
  `Response` text,
  `Created_On` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Updated_On` datetime DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_Api_Log`
--

LOCK TABLES `tbl_Api_Log` WRITE;
/*!40000 ALTER TABLE `tbl_Api_Log` DISABLE KEYS */;
INSERT INTO `tbl_Api_Log` VALUES (18,'APPOINMENT_REMINDER','Event ID','7mb8jcdpaaagrd8kkto32utkg4','[[{\"statusCode\":202,\"body\":\"\",\"headers\":{\"server\":\"nginx\",\"date\":\"Tue, 02 Nov 2021 04:41:45 GMT\",\"content-length\":\"0\",\"connection\":\"close\",\"x-message-id\":\"5zb25H2LSi-7P4Jq5y35gg\",\"access-control-allow-origin\":\"https://sendgrid.api-docs.io\",\"access-control-allow-methods\":\"POST\",\"access-control-allow-headers\":\"Authorization, Content-Type, On-behalf-of, x-sg-elas-acl\",\"access-control-max-age\":\"600\",\"x-no-cors-reason\":\"https://sendgrid.com/docs/Classroom/Basics/API/cors.html\",\"strict-transport-security\":\"max-age=600; includeSubDomains\"}},\"\"]]','2021-11-02 10:11:49',NULL);
/*!40000 ALTER TABLE `tbl_Api_Log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_Client`
--

DROP TABLE IF EXISTS `tbl_Client`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_Client` (
  `Client_Id` varchar(40) NOT NULL,
  `Meeting_Id` varchar(100) NOT NULL,
  `Member_Id` varchar(40) NOT NULL,
  `Seeker_Id` varchar(40) DEFAULT NULL,
  `Client_Iden` varchar(100) NOT NULL,
  `Name` varchar(50) DEFAULT NULL,
  `Ph` varchar(12) DEFAULT NULL,
  `DOB` date DEFAULT NULL,
  `Gender` varchar(1) DEFAULT NULL,
  `Is_Cres_Client` varchar(1) NOT NULL DEFAULT 'N',
  `Created_On` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Updated_On` datetime DEFAULT NULL,
  `Is_Active` varchar(1) NOT NULL DEFAULT 'Y'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_Client`
--

LOCK TABLES `tbl_Client` WRITE;
/*!40000 ALTER TABLE `tbl_Client` DISABLE KEYS */;
INSERT INTO `tbl_Client` VALUES ('fc6a1eae-d2d2-4294-9214-8d98ad989846','552653ce-23b1-4690-9f50-233688aafa44','497f416b-e2c8-4818-b144-ce8392ff27a1',NULL,'sankhadip.2000@gmail.com',NULL,NULL,NULL,NULL,'N','2021-11-02 09:23:39',NULL,'Y'),('fc6a1eae-d2d2-4294-9214-8d98ad989846','0aac5365-fb75-4628-ba92-4cd42e4757b3','497f416b-e2c8-4818-b144-ce8392ff27a1',NULL,'sankhadip.2000@gmail.com',NULL,NULL,NULL,NULL,'N','2021-11-02 09:27:45',NULL,'Y');
/*!40000 ALTER TABLE `tbl_Client` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_File`
--

DROP TABLE IF EXISTS `tbl_File`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_File` (
  `File_Id` varchar(40) NOT NULL,
  `Client_Id` varchar(40) NOT NULL,
  `Member_Id` varchar(40) NOT NULL,
  `Meeting_Id` varchar(40) DEFAULT NULL,
  `File_Path` varchar(500) NOT NULL,
  `Created_On` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Updated_On` datetime DEFAULT NULL,
  `Is_Active` varchar(1) NOT NULL DEFAULT 'Y',
  PRIMARY KEY (`File_Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_File`
--

LOCK TABLES `tbl_File` WRITE;
/*!40000 ALTER TABLE `tbl_File` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_File` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_Holiday_List`
--

DROP TABLE IF EXISTS `tbl_Holiday_List`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_Holiday_List` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `Meeting_Id` varchar(40) NOT NULL,
  `Event_Id` text NOT NULL,
  `Start_TS` datetime NOT NULL,
  `End_TS` datetime NOT NULL,
  `Description` varchar(500) DEFAULT NULL,
  `Summary` varchar(500) DEFAULT NULL,
  `Status` varchar(50) DEFAULT NULL,
  `Created_On` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UNIQUE KEY `Id` (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=177 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_Holiday_List`
--

LOCK TABLES `tbl_Holiday_List` WRITE;
/*!40000 ALTER TABLE `tbl_Holiday_List` DISABLE KEYS */;
INSERT INTO `tbl_Holiday_List` VALUES (1,'8f5fcdc8-9421-466b-a2fb-0ede9e583833','20200114_u2itdad1sreaktrjdsnln06mbc','2020-01-14 00:00:00','2020-01-15 00:00:00','Public holiday','Lohri','confirmed','2021-10-14 13:23:57'),(2,'923005f8-4672-4c5c-a19f-9eedba9cf091','20200209_5sppi8j3l36tpjq53jd55svtjc','2020-02-09 00:00:00','2020-02-10 00:00:00','Public holiday','Guru Ravidas Jayanti','confirmed','2021-10-14 13:23:57'),(3,'623a5c84-7834-4df4-89ff-be90a6b2f427','20200309_a2bgtfuve3dj9n9h71mkgc8gtc','2020-03-09 00:00:00','2020-03-10 00:00:00','Public holiday','Dolyatra','confirmed','2021-10-14 13:23:57'),(4,'ba6402d0-07e1-4368-baab-ee2bafc8be02','20200414_qggojbjilfdpljh5bqv7sjpe64','2020-04-14 00:00:00','2020-04-15 00:00:00','Public holiday','Mesadi / Vaisakhadi','confirmed','2021-10-14 13:23:57'),(5,'16e54c4a-aaf6-4696-a462-1a9cb6c7d5f7','20200811_l0jr10g3cf7rst2h0u6fkm9jbg','2020-08-11 00:00:00','2020-08-12 00:00:00','Public holiday','Janmashtami (Smarta)','confirmed','2021-10-14 13:23:57'),(6,'16429393-a1f4-4726-9fbd-9ee6a0722731','20201017_8th80cu4i4i0ko8htn153056bo','2020-10-17 00:00:00','2020-10-18 00:00:00','Observance\nTo hide observances, go to Google Calendar Settings > Holidays in India','First Day of Sharad Navratri','confirmed','2021-10-14 13:23:57'),(7,'b67d553a-758d-42a9-b5e9-10368a208a74','20210219_v2ekgtp4509ashjs9ih2m73ghs','2021-02-19 00:00:00','2021-02-20 00:00:00','Public holiday','Shivaji Jayanti','confirmed','2021-10-14 13:23:57'),(8,'9fdf4bb1-551f-4a7a-afb6-e05375e87b65','20210413_ltcdvuol0j22tht35q2g8ve2go','2021-04-13 00:00:00','2021-04-14 00:00:00','Public holiday','Gudi Padwa','confirmed','2021-10-14 13:23:57'),(9,'63496364-b3bd-43b0-b01e-e15e692a31fb','20211119_6cl69m396kj947jseinmo31v0o','2021-11-19 00:00:00','2021-11-20 00:00:00','Public holiday','Guru Nanak Jayanti','confirmed','2021-10-14 13:23:57'),(10,'d655b7f2-86b0-4a16-ab03-75f2a1bc9673','20220414_s465qeqls7epibotpm88vklmcg','2022-04-14 00:00:00','2022-04-15 00:00:00','Observance\nTo hide observances, go to Google Calendar Settings > Holidays in India','Ambedkar Jayanti','confirmed','2021-10-14 13:23:57'),(11,'a04f633c-c5be-46d7-a6ae-14b2551e359a','20220417_k8rd3csu8e1scll1fsl72t5sl8','2022-04-17 00:00:00','2022-04-18 00:00:00','Public holiday','Easter Day','confirmed','2021-10-14 13:23:57'),(12,'f954bca7-5bd4-4b22-bed7-f531b3dd83a1','20220819_0va86dckv04kqe7ijdahr7h7pc','2022-08-19 00:00:00','2022-08-20 00:00:00','Public holiday','Janmashtami','confirmed','2021-10-14 13:23:57'),(13,'91622f07-bec7-47e9-bf2b-f5673a80e4c0','20221003_ona4o2s7vi3psngn3bp1673beg','2022-10-03 00:00:00','2022-10-04 00:00:00','Public holiday','Maha Ashtami','confirmed','2021-10-14 13:23:57'),(14,'d8812dea-4b09-4e07-9103-17ffdc9fe879','20221005_roo4jse4gcdo2uc1f7si7hl25s','2022-10-05 00:00:00','2022-10-06 00:00:00','Public holiday','Dussehra','confirmed','2021-10-14 13:23:57'),(15,'5951888a-150d-4828-a976-4424ff85c753','20221225_apfbln527i1qpgefsv8lh81uug','2022-12-25 00:00:00','2022-12-26 00:00:00','Public holiday','Christmas','confirmed','2021-10-14 13:23:57'),(16,'b78372be-4c0f-4080-bf15-c146a4a5b562','20200218_84gq3v3af3p6beoabur71tjvm4','2020-02-18 00:00:00','2020-02-19 00:00:00','Public holiday','Maharishi Dayanand Saraswati Jayanti','confirmed','2021-10-14 13:23:57'),(17,'4021553f-4aa3-492c-9f77-76a140f62ef9','20200309_cvcj6o74uugkb29kf1qffcpqrk','2020-03-09 00:00:00','2020-03-10 00:00:00','Public holiday','Hazarat Ali\'s Birthday','confirmed','2021-10-14 13:23:57'),(18,'d1b57905-bd42-4a5d-96f5-10df3b40b40c','20200507_nobe80qk0ocajcps5mi19qidlo','2020-05-07 00:00:00','2020-05-08 00:00:00','Public holiday','Birthday of Ravindranath','confirmed','2021-10-14 13:23:57'),(19,'c4457b49-2b71-4de8-b185-9e23fdd7d72d','20200822_4qmsv5keetr3m6vftq8c4lfc4c','2020-08-22 00:00:00','2020-08-23 00:00:00','Public holiday','Ganesh Chaturthi/Vinayaka Chaturthi','confirmed','2021-10-14 13:23:57'),(20,'efd0da04-70d5-4a70-a407-5388626c5c11','20210113_eicm6e09pderpudv1u2dqpb0fk','2021-01-13 00:00:00','2021-01-14 00:00:00','Public holiday','Lohri','confirmed','2021-10-14 13:23:57'),(21,'0f970435-2ae2-46bf-83a7-14d160a8f948','20210329_gss72oadctdhtij1v32ce8id9g','2021-03-29 00:00:00','2021-03-30 00:00:00','Public holiday','Holi','confirmed','2021-10-14 13:23:57'),(22,'5ab42fad-b84a-47ae-8cde-e13901fe18d3','20210910_9jjookn665rbev1luggh5fq19g','2021-09-10 00:00:00','2021-09-11 00:00:00','Public holiday','Ganesh Chaturthi/Vinayaka Chaturthi','confirmed','2021-10-14 13:23:57'),(23,'e7d5a772-cad1-4238-9721-0e48fb6cc9ca','20211002_06tc7es1bu8gq8r88d65h3tjms','2021-10-02 00:00:00','2021-10-03 00:00:00','Public holiday','Mahatma Gandhi Jayanti','confirmed','2021-10-14 13:23:57'),(24,'0155fece-3dc8-447e-bf34-ace0aa5803fb','20211106_ts9kmltug6ahm9t7vkj79g86so','2021-11-06 00:00:00','2021-11-07 00:00:00','Public holiday','Bhai Duj','confirmed','2021-10-14 13:23:57'),(25,'5c673e3d-9edf-431c-b06d-d5eb53baa191','20211224_0rcmj7kj8smtd38uv4kfu46e9o','2021-12-24 00:00:00','2021-12-25 00:00:00','Public holiday','Christmas Eve','confirmed','2021-10-14 13:23:57'),(26,'3320e600-f14c-4c74-bc99-703ebe985758','20220114_k3ejbt6sk5h6m9q7t05c3legbg','2022-01-14 00:00:00','2022-01-15 00:00:00','Public holiday','Pongal','confirmed','2021-10-14 13:23:57'),(27,'c4ea6437-a11c-400b-942e-d05b082d4df3','20220318_psntc0tm3gvo8vi8rtsas66o08','2022-03-18 00:00:00','2022-03-19 00:00:00','Public holiday','Holi','confirmed','2021-10-14 13:23:57'),(28,'3bd1788a-9492-467c-9cb2-a10d954871e2','20220410_82u8rlbn27q0a32gdneufd5e2g','2022-04-10 00:00:00','2022-04-11 00:00:00','Public holiday','Rama Navami','confirmed','2021-10-14 13:23:57'),(29,'ff0feab3-66af-402d-8466-1998d683b6c2','20220908_6bp6c6ahuhalv53iivjih7hbns','2022-09-08 00:00:00','2022-09-09 00:00:00','Public holiday','Onam','confirmed','2021-10-14 13:23:57'),(30,'505615b9-ac77-4490-8325-4cb2883fb6bc','20221002_j334b8p70ev3939f7kc93pa3jo','2022-10-02 00:00:00','2022-10-03 00:00:00','Public holiday','Maha Saptami','confirmed','2021-10-14 13:23:57'),(31,'0776b2f3-f250-4c89-8799-ca99b21c89a4','20221030_3qo6uqqudpqitdek1olo948e1k','2022-10-30 00:00:00','2022-10-31 00:00:00','Public holiday','Chhat Puja (Pratihar Sashthi/Surya Sashthi)','confirmed','2021-10-14 13:23:57'),(32,'6f2cf18a-afcf-408a-ac76-348abc850465','20200101_qr9ul0epmft35ni7pg71udj5kc','2020-01-01 00:00:00','2020-01-02 00:00:00','Public holiday','New Year\'s Day','confirmed','2021-10-14 13:23:57'),(33,'504079b3-7fa7-401c-9125-eaafca38cfbf','20200126_vtdp3g3j1dkmur7toal43bhlu8','2020-01-26 00:00:00','2020-01-27 00:00:00','Public holiday','Republic Day','confirmed','2021-10-14 13:23:57'),(34,'4446f26d-05e8-4bbe-af01-feb594f672ed','20200310_uqqkaemb0d92tgq27brtp24gbc','2020-03-10 00:00:00','2020-03-11 00:00:00','Public holiday','Holi','confirmed','2021-10-14 13:23:57'),(35,'c6cae47b-dbf0-4f0d-83ef-7e63ae40363a','20200406_v4m646vdmgepos5g86cf3pcr04','2020-04-06 00:00:00','2020-04-07 00:00:00','Public holiday','Mahavir Jayanti','confirmed','2021-10-14 13:23:57'),(36,'c3a7f910-1caa-4854-b4db-40e9e875bc75','20200413_e4jpqen87rhfhb75apc92odau4','2020-04-13 00:00:00','2020-04-14 00:00:00','Public holiday','Vaisakhi','confirmed','2021-10-14 13:23:57'),(37,'70737935-5754-42ef-b203-ebba2f800331','20201115_mloabqu7v3dbuasq4qvps37v8o','2020-11-15 00:00:00','2020-11-16 00:00:00','Public holiday','Govardhan Puja','confirmed','2021-10-14 13:23:57'),(38,'5f48114f-69a9-4c71-95f8-e34ddf258403','20210414_q44qolv2vk28ua2tpshtr5qlgc','2021-04-14 00:00:00','2021-04-15 00:00:00','Public holiday','Vaisakhi','confirmed','2021-10-14 13:23:57'),(39,'ef452760-cac3-4b2c-bac8-9220322ba206','20210712_o3q8kl0pnkrtda2dupgv5dpe0k','2021-07-12 00:00:00','2021-07-13 00:00:00','Public holiday','Rath Yatra','confirmed','2021-10-14 13:23:57'),(40,'3caab149-762e-49ed-9863-b2f23fbad1de','20210821_q4lqo6u947emjefk6cotm4qhsc','2021-08-21 00:00:00','2021-08-22 00:00:00','Public holiday','Onam','confirmed','2021-10-14 13:23:57'),(41,'44c6e143-dee0-44cb-b96f-94b4ee73e22e','20211124_bj7l44p72nj8ofb65vo5eu25jc','2021-11-24 00:00:00','2021-11-25 00:00:00','Public holiday','Guru Tegh Bahadur\'s Martyrdom Day','confirmed','2021-10-14 13:23:57'),(42,'e580e760-5f25-44cc-b72f-ecc61fbefd15','20220402_5t9gre9q1ur7r71ghohhp75oo8','2022-04-02 00:00:00','2022-04-03 00:00:00','Public holiday','Chaitra Sukhladi','confirmed','2021-10-14 13:23:57'),(43,'0f917b18-67de-48bb-94a0-c9291a03dbee','20221026_it8enrcffkmcumfdjldn2bqjbo','2022-10-26 00:00:00','2022-10-27 00:00:00','Public holiday','Bhai Duj','confirmed','2021-10-14 13:23:57'),(44,'c6bc70b0-608f-41c4-89a9-b284e087f53e','20200129_6ro83746fure4fbo6qidkdjl2s','2020-01-29 00:00:00','2020-01-30 00:00:00','Public holiday','Vasant Panchami','confirmed','2021-10-14 13:23:57'),(45,'a2dd7f63-b157-4417-85f9-b20e830b8cbd','20201225_uk2j447p0lo9inj2ttmqa6durg','2020-12-25 00:00:00','2020-12-26 00:00:00','Public holiday','Christmas','confirmed','2021-10-14 13:23:57'),(46,'abbd9aa7-7016-429a-90d6-250c19fc58b6','20210114_5k446skqnc5tgmgvh0gnfknqv4','2021-01-14 00:00:00','2021-01-15 00:00:00','Public holiday','Pongal','confirmed','2021-10-14 13:23:57'),(47,'52a84554-7031-4a0e-87eb-abc6309c0973','20210413_hr86s3afjhn4ranohfa8eunag4','2021-04-13 00:00:00','2021-04-14 00:00:00','Public holiday','Ugadi','confirmed','2021-10-14 13:23:57'),(48,'bc43256a-951c-4005-8013-3926ed6cad51','20210415_id5itt4o4m7hl939jm2p58d9q8','2021-04-15 00:00:00','2021-04-16 00:00:00','Public holiday','Bahag Bihu/Vaisakhadi','confirmed','2021-10-14 13:23:57'),(49,'28c6e183-24b3-4b7c-927c-081ecda61456','20210816_vmk8f214i2n56an0kplr05eong','2021-08-16 00:00:00','2021-08-17 00:00:00','Public holiday','Parsi New Year','confirmed','2021-10-14 13:23:57'),(50,'3bafabcb-9a8d-40e2-8cfc-4680ca440a28','20211013_lph4srbtted8423j3dtsjn2r6s','2021-10-13 00:00:00','2021-10-14 00:00:00','Public holiday','Maha Ashtami','confirmed','2021-10-14 13:23:57'),(51,'0c884414-12a7-49b0-bd99-ea49ef5f351e','20220101_risgjahoj7j4iq6s7ggumlcsg4','2022-01-01 00:00:00','2022-01-02 00:00:00','Public holiday','New Year\'s Day','confirmed','2021-10-14 13:23:57'),(52,'79c11054-70ea-4910-8d27-483eaa4a36ef','20220226_1o3b8dikvo9bpo5p1o5av5msp4','2022-02-26 00:00:00','2022-02-27 00:00:00','Public holiday','Maharishi Dayanand Saraswati Jayanti','confirmed','2021-10-14 13:23:57'),(53,'faeaa087-a963-44b3-aeb4-2b24bcf3d4d3','20220301_89jn8v0gq583ak7j76u2v6u2o8','2022-03-01 00:00:00','2022-03-02 00:00:00','Public holiday','Maha Shivaratri/Shivaratri','confirmed','2021-10-14 13:23:57'),(54,'286d9eb3-f981-400a-b9fb-e826ee379f82','20220318_3n64pd6a2blvdehacfktd3s340','2022-03-18 00:00:00','2022-03-19 00:00:00','Public holiday','Dolyatra','confirmed','2021-10-14 13:23:57'),(55,'6dd12ab1-7cb1-45c9-8c6e-4ef07c1f5d54','20220701_csmai99n5k4qurb9vapj36iqt8','2022-07-01 00:00:00','2022-07-02 00:00:00','Public holiday','Rath Yatra','confirmed','2021-10-14 13:23:57'),(56,'da86579c-389d-4bf6-a8c5-4aced4c6081b','20200325_hajhf3u2krb1vdblcnu7111jj8','2020-03-25 00:00:00','2020-03-26 00:00:00','Public holiday','Gudi Padwa','confirmed','2021-10-14 13:23:57'),(57,'bf738683-1c51-4c7c-840e-b66bac0c3a3b','20200525_95jpd7jv56vqpg0o7m6ldo66rc','2020-05-25 00:00:00','2020-05-26 00:00:00','Public holiday','Ramzan Id/Eid-ul-Fitar','confirmed','2021-10-14 13:23:57'),(58,'8f175687-c187-494f-b175-bdc372269511','20200816_png0healogdfsjdgmnia9pdsds','2020-08-16 00:00:00','2020-08-17 00:00:00','Public holiday','Parsi New Year','confirmed','2021-10-14 13:23:57'),(59,'92747cab-5872-44be-bc5a-9c00c6551337','20200830_losu2vdcccqpom5rnp03mkeitk','2020-08-30 00:00:00','2020-08-31 00:00:00','Public holiday','Muharram/Ashura','confirmed','2021-10-14 13:23:57'),(60,'0f67478c-cbce-47cc-a76c-1532ef745bb1','20200831_qbnhq0oosmqorcf1e3en1gduj4','2020-08-31 00:00:00','2020-09-01 00:00:00','Public holiday','Onam','confirmed','2021-10-14 13:23:57'),(61,'58cd487d-53a4-41c7-8df5-18d2c2c706f5','20210226_ogtps50oj4mu2ugv8k71mtn4qo','2021-02-26 00:00:00','2021-02-27 00:00:00','Public holiday','Hazarat Ali\'s Birthday','confirmed','2021-10-14 13:23:57'),(62,'b99f1ad4-5c72-472e-a25d-e99301e8e913','20210404_mt3e00d6pvju5puj42c595iqh4','2021-04-04 00:00:00','2021-04-05 00:00:00','Public holiday','Easter Day','confirmed','2021-10-14 13:23:57'),(63,'188facce-1d12-426b-bcc8-0efaf9296406','20210421_kvnkn09neuqgq2be8vmhfrphsc','2021-04-21 00:00:00','2021-04-22 00:00:00','Public holiday','Rama Navami','confirmed','2021-10-14 13:23:57'),(64,'fd812eff-c3bf-4dca-9543-2175cca2e8b0','20210509_hpl916v54stt1gt25f5h68r7k0','2021-05-09 00:00:00','2021-05-10 00:00:00','Public holiday','Birthday of Ravindranath','confirmed','2021-10-14 13:23:57'),(65,'8ce007e4-d64d-47c0-b6aa-96dfa74df88f','20210815_f9tfkdhc4qs7k93vkcgm0lvuhs','2021-08-15 00:00:00','2021-08-16 00:00:00','Public holiday','Independence Day','confirmed','2021-10-14 13:23:57'),(66,'5b58e999-a400-4349-9e41-0be8132a4f8f','20210830_69hi2ehk6gf09ijnpr2iuklai0','2021-08-30 00:00:00','2021-08-31 00:00:00','Public holiday','Janmashtami','confirmed','2021-10-14 13:23:57'),(67,'8154fd5b-f3ec-4ece-ac5d-a2b195ea4624','20211024_1dfolan638gu4485bhigqb14dk','2021-10-24 00:00:00','2021-10-25 00:00:00','Public holiday','Karaka Chaturthi (Karva Chauth)','confirmed','2021-10-14 13:23:57'),(68,'245966ff-12db-41a4-a6e4-5fa4d99f7044','20220109_lleoqageok61nkvq7p8fu8ecqk','2022-01-09 00:00:00','2022-01-10 00:00:00','Observance\nTo hide observances, go to Google Calendar Settings > Holidays in India','Guru Govind Singh Jayanti','confirmed','2021-10-14 13:23:57'),(69,'e05852e5-09a9-44e6-b952-acf9123a9366','20220216_dqbqgjmtibl1nvna48qjvnccks','2022-02-16 00:00:00','2022-02-17 00:00:00','Public holiday','Guru Ravidas Jayanti','confirmed','2021-10-14 13:23:57'),(70,'8d852aee-a3e2-48c6-9f85-e12001c26939','20220317_umtthrtc3d8erfdootp3lgml3k','2022-03-17 00:00:00','2022-03-18 00:00:00','Public holiday','Holika Dahana','confirmed','2021-10-14 13:23:57'),(71,'26478220-6e17-4094-9bb3-dcf566fdcffe','20220516_ig56fm2g1p8n0jo31i49blpgqs','2022-05-16 00:00:00','2022-05-17 00:00:00','Public holiday','Buddha Purnima/Vesak','confirmed','2021-10-14 13:23:57'),(72,'64d7f8a3-1573-4186-84f9-7343d5e9d422','20221013_ero68ng3m5p86khn7imt34q924','2022-10-13 00:00:00','2022-10-14 00:00:00','Public holiday','Karaka Chaturthi (Karva Chauth)','confirmed','2021-10-14 13:23:57'),(73,'29fcda4b-8d88-41c7-bff7-2d5851a528b2','20221124_bk320g1aj1o00je77ke987hk6o','2022-11-24 00:00:00','2022-11-25 00:00:00','Public holiday','Guru Tegh Bahadur\'s Martyrdom Day','confirmed','2021-10-14 13:23:57'),(74,'02db924f-12c0-474b-95c9-c1715f281cb5','20200522_ccok0jrcdtkmf6ot1carjpe1f4','2020-05-22 00:00:00','2020-05-23 00:00:00','Public holiday','Jamat Ul-Vida','confirmed','2021-10-14 13:23:57'),(75,'7e3927ff-9518-4467-b531-74aea94864dc','20200815_ivnh33r8j9sa4e580nf4tcncso','2020-08-15 00:00:00','2020-08-16 00:00:00','Public holiday','Independence Day','confirmed','2021-10-14 13:23:57'),(76,'2a22d919-90ff-47e4-a6fc-5818970e3a8d','20201023_o1939aep94b2rb4l6g2ernj6s8','2020-10-23 00:00:00','2020-10-24 00:00:00','Public holiday','Maha Ashtami','confirmed','2021-10-14 13:23:57'),(77,'c4235cc2-d3f5-4f57-a7c2-8cac3041ab29','20201104_i2kr6iq9bhisjh8kv4oi2770d0','2020-11-04 00:00:00','2020-11-05 00:00:00','Public holiday','Karaka Chaturthi (Karva Chauth)','confirmed','2021-10-14 13:23:57'),(78,'5b1b3ff4-3bfd-4cab-a6ca-76db7274f881','20211019_se5fkngarfa57712dmd7490kqc','2021-10-19 00:00:00','2021-10-20 00:00:00','Public holiday','Milad un-Nabi/Id-e-Milad','confirmed','2021-10-14 13:23:57'),(79,'9b050099-5f01-4461-8fbe-3c4e74ee7e1f','20211110_hf8ibb3vjomg3kq45h68jc05jo','2021-11-10 00:00:00','2021-11-11 00:00:00','Public holiday','Chhat Puja (Pratihar Sashthi/Surya Sashthi)','confirmed','2021-10-14 13:23:57'),(80,'4474e656-d423-4124-82af-5b3e7cc6877a','20220126_61vvf5epd10r951h92dae910a8','2022-01-26 00:00:00','2022-01-27 00:00:00','Public holiday','Republic Day','confirmed','2021-10-14 13:23:57'),(81,'10cedd00-05c2-406f-b870-8c397d95e557','20220509_n21gcv6cir1m90nskd0jv891l4','2022-05-09 00:00:00','2022-05-10 00:00:00','Public holiday','Birthday of Ravindranath','confirmed','2021-10-14 13:23:57'),(82,'9fee4f16-9ce6-49fb-aa24-b51b70b0cf90','20220811_3ut0grckljm9juk16m83g6aq20','2022-08-11 00:00:00','2022-08-12 00:00:00','Public holiday','Raksha Bandhan (Rakhi)','confirmed','2021-10-14 13:23:57'),(83,'affff23e-a442-4065-b60d-e60ba27086a4','20220818_fgtvaoti4ou0dnus7ntu61ugbs','2022-08-18 00:00:00','2022-08-19 00:00:00','Public holiday','Janmashtami (Smarta)','confirmed','2021-10-14 13:23:57'),(84,'968f9e57-3958-4d29-8680-01dd8ea1b1b3','20221024_t47jelhfh3qm4ifq6sba82qltg','2022-10-24 00:00:00','2022-10-25 00:00:00','Public holiday','Diwali/Deepavali','confirmed','2021-10-14 13:23:57'),(85,'3d36a646-3b45-4af4-8d51-3211ac55fb54','20221108_bnn7ahc9qr0lh2afqjpb9veuj0','2022-11-08 00:00:00','2022-11-09 00:00:00','Public holiday','Guru Nanak Jayanti','confirmed','2021-10-14 13:23:57'),(86,'0aab50ac-4c85-4b82-acbb-00f450c8ed5f','20200102_2s2kbe8s7udsk36sgeauk3qokg','2020-01-02 00:00:00','2020-01-03 00:00:00','Observance\nTo hide observances, go to Google Calendar Settings > Holidays in India','Guru Govind Singh Jayanti','confirmed','2021-10-14 13:23:57'),(87,'8e3f3524-a668-4575-bffe-49c331eb2492','20200325_ntid3f0glk1cah6elojkrbd1uk','2020-03-25 00:00:00','2020-03-26 00:00:00','Public holiday','Ugadi','confirmed','2021-10-14 13:23:57'),(88,'1b882fe0-dee5-42e3-a15d-6135adb595f8','20200507_25v40q9smk9apbsb43gek2ne2k','2020-05-07 00:00:00','2020-05-08 00:00:00','Public holiday','Buddha Purnima/Vesak','confirmed','2021-10-14 13:23:57'),(89,'25929ea4-40eb-4647-9281-fb5b08d039b7','20200812_n5ioktgrmumlvvu9cj6rq9v6f0','2020-08-12 00:00:00','2020-08-13 00:00:00','Public holiday','Janmashtami','confirmed','2021-10-14 13:23:57'),(90,'e47ac05e-3ea8-4687-9984-8d0a3d012310','20201114_ba6n5dg1fh1eofrondl0h8o6o4','2020-11-14 00:00:00','2020-11-15 00:00:00','Public holiday','Diwali/Deepavali','confirmed','2021-10-14 13:23:57'),(91,'5280ca7c-8747-450f-a78c-9b5ff0d34498','20201130_hrtnlkg4csu0ihld7lee5fv7t8','2020-11-30 00:00:00','2020-12-01 00:00:00','Public holiday','Guru Nanak Jayanti','confirmed','2021-10-14 13:23:57'),(92,'571ffa55-88c6-4174-aa16-a6dcc2f29df7','20210820_uo9godietj71om32rsgb7cdl3g','2021-08-20 00:00:00','2021-08-21 00:00:00','Public holiday','Muharram/Ashura','confirmed','2021-10-14 13:23:57'),(93,'41507df8-37f0-4704-a27e-b882ca5d10ee','20211015_unupg2i9atdnu1ihv2216r8co8','2021-10-15 00:00:00','2021-10-16 00:00:00','Public holiday','Dussehra','confirmed','2021-10-14 13:23:57'),(94,'a0320aa1-6c2c-475c-8703-bd0fd329121a','20211104_f1ik6r8f7j0fma0uqlr534cnt0','2021-11-04 00:00:00','2021-11-05 00:00:00','Public holiday','Diwali/Deepavali','confirmed','2021-10-14 13:23:57'),(95,'f387a447-d2c7-47ec-9d42-ae9e2024148b','20220205_r5dcqv3998eiiigp7pj8pn5gj8','2022-02-05 00:00:00','2022-02-06 00:00:00','Public holiday','Vasant Panchami','confirmed','2021-10-14 13:23:57'),(96,'295e8c0b-c87e-42f7-a6e7-dce07d4ad1fb','20221009_4d7bv1ogp93k0bk075sjcredb0','2022-10-09 00:00:00','2022-10-10 00:00:00','Public holiday','Maharishi Valmiki Jayanti','confirmed','2021-10-14 13:23:57'),(97,'0c693199-ff73-48fb-8842-68601cf4c98c','20221024_8s56pko5sn47fi9o9bl7bu43ds','2022-10-24 00:00:00','2022-10-25 00:00:00','Public holiday','Naraka Chaturdasi','confirmed','2021-10-14 13:23:57'),(98,'5130b030-3e5f-4b8b-9f27-8bb1e96ffead','20221224_1mbkqmsliveagblqr40q364phg','2022-12-24 00:00:00','2022-12-25 00:00:00','Public holiday','Christmas Eve','confirmed','2021-10-14 13:23:57'),(99,'6032e03a-fe11-450e-b4a5-463d81cde894','20200402_fi5cug29c5qnk22bobh3bf8j78','2020-04-02 00:00:00','2020-04-03 00:00:00','Public holiday','Rama Navami','confirmed','2021-10-14 13:23:57'),(100,'d8d40ffd-00e2-4068-bf62-93fb2701d53d','20201025_ls8403t8qhabeh0u6gguovig2c','2020-10-25 00:00:00','2020-10-26 00:00:00','Public holiday','Dussehra','confirmed','2021-10-14 13:23:57'),(101,'8ee97e98-538b-446a-bbcd-07e0b9e57595','20201114_ltjnb7iju67g7mtmbngau5iur0','2020-11-14 00:00:00','2020-11-15 00:00:00','Public holiday','Naraka Chaturdasi','confirmed','2021-10-14 13:23:57'),(102,'b86256fc-e668-465d-a174-3621432636ee','20201224_r1nup4p2bp5haeu16csrkff58c','2020-12-24 00:00:00','2020-12-25 00:00:00','Public holiday','Christmas Eve','confirmed','2021-10-14 13:23:57'),(103,'93c15236-c296-4365-a63b-d6926addaacf','20210120_apb5ltb5913ed5dvo101gd9pk4','2021-01-20 00:00:00','2021-01-21 00:00:00','Observance\nTo hide observances, go to Google Calendar Settings > Holidays in India','Guru Govind Singh Jayanti','confirmed','2021-10-14 13:23:57'),(104,'72948061-50fd-4928-a186-06f129997ba5','20210328_rrc2fkjicivcef932gajc2vtcs','2021-03-28 00:00:00','2021-03-29 00:00:00','Public holiday','Dolyatra','confirmed','2021-10-14 13:23:57'),(105,'d0bd3612-43e7-4c2d-aae9-ec15a31a49e3','20210413_5pdla7p179l9hpuva4j2c5m30s','2021-04-13 00:00:00','2021-04-14 00:00:00','Public holiday','Chaitra Sukhladi','confirmed','2021-10-14 13:23:57'),(106,'9055569e-a69e-46fa-a94a-e1edc13ff5b0','20211104_dk5pvlltpvbpu8vaepkji8sl7o','2021-11-04 00:00:00','2021-11-05 00:00:00','Public holiday','Naraka Chaturdasi','confirmed','2021-10-14 13:23:57'),(107,'70429ddd-07d0-4af9-9139-f5fd9d1a6798','20211225_n5mm8g2k4laua937i4400filvs','2021-12-25 00:00:00','2021-12-26 00:00:00','Public holiday','Christmas','confirmed','2021-10-14 13:23:57'),(108,'b4741d6b-8a69-4c1c-be56-a76d1365aab4','20220114_di97h7t22ica43a9s726sbrrfk','2022-01-14 00:00:00','2022-01-15 00:00:00','Public holiday','Makar Sankranti','confirmed','2021-10-14 13:23:57'),(109,'733ace48-b9cc-45a4-ac01-892248647e20','20220402_qafbem65vsctqhn71970eaje54','2022-04-02 00:00:00','2022-04-03 00:00:00','Public holiday','Gudi Padwa','confirmed','2021-10-14 13:23:57'),(110,'ceb7f2da-9960-4565-a471-4b0ec2b52d57','20221009_u48u3ujtg0g708r5mchpcidujc','2022-10-09 00:00:00','2022-10-10 00:00:00','Public holiday','Milad un-Nabi/Id-e-Milad','confirmed','2021-10-14 13:23:57'),(111,'2ebb8639-5b81-473b-af1a-b237803040f8','20200115_vneeinlrane8jr2045rchotu1c','2020-01-15 00:00:00','2020-01-16 00:00:00','Public holiday','Makar Sankranti','confirmed','2021-10-14 13:23:57'),(112,'630f50d2-16a2-457a-b446-660e14e5d4c5','20200221_da0j6q5rtkddvuua2debnn6rco','2020-02-21 00:00:00','2020-02-22 00:00:00','Public holiday','Maha Shivaratri/Shivaratri','confirmed','2021-10-14 13:23:57'),(113,'b94d0df2-6934-42b8-90e1-e78da29641b3','20200623_fjs0f206macdpf4lujt0is8nuo','2020-06-23 00:00:00','2020-06-24 00:00:00','Public holiday','Rath Yatra','confirmed','2021-10-14 13:23:57'),(114,'0b7dd270-748c-4fa2-9d35-e3d9e5158d00','20201120_03c8b10h7tlmsojm285h8oe4kg','2020-11-20 00:00:00','2020-11-21 00:00:00','Public holiday','Chhat Puja (Pratihar Sashthi/Surya Sashthi)','confirmed','2021-10-14 13:23:57'),(115,'1aa8fcb6-22ae-4d53-af1b-b752f8330044','20210308_3v7clb6e4p86jcec7spu9onfqk','2021-03-08 00:00:00','2021-03-09 00:00:00','Public holiday','Maharishi Dayanand Saraswati Jayanti','confirmed','2021-10-14 13:23:57'),(116,'63f71c93-5270-4fc0-ae2d-e3af9a66566a','20210425_9ek8tgvolv436ea8anru6joqhs','2021-04-25 00:00:00','2021-04-26 00:00:00','Public holiday','Mahavir Jayanti','confirmed','2021-10-14 13:23:57'),(117,'bc2d5b5e-54d9-47b9-bd75-2b3fc51d4f9d','20220113_acng6ntadkt582gd6m4dgftlis','2022-01-13 00:00:00','2022-01-14 00:00:00','Public holiday','Lohri','confirmed','2021-10-14 13:23:57'),(118,'747c0ff2-e4a9-4549-b90b-7149bc6be0a4','20220402_s2n2k0ihcicbq94sd1ev7u2els','2022-04-02 00:00:00','2022-04-03 00:00:00','Public holiday','Ugadi','confirmed','2021-10-14 13:23:57'),(119,'7f8b6d95-b636-46a6-a473-0d919f6fe0e2','20220816_rr2hpjbl2ne8vibh30vbl1qjig','2022-08-16 00:00:00','2022-08-17 00:00:00','Public holiday','Parsi New Year','confirmed','2021-10-14 13:23:57'),(120,'81a68e27-752d-4180-8a35-50b305b7479b','20200219_eds5v67km9ul53q21q70iqapq4','2020-02-19 00:00:00','2020-02-20 00:00:00','Public holiday','Shivaji Jayanti','confirmed','2021-10-14 13:23:57'),(121,'3065041f-9a8b-4fb2-b53b-ec0c1a65f5db','20200412_3jianjiogkd41njiitno0s3g7g','2020-04-12 00:00:00','2020-04-13 00:00:00','Public holiday','Easter Day','confirmed','2021-10-14 13:23:57'),(122,'55dd305d-9986-4159-809b-e3f48fcc0de8','20200801_81u2jpfu5jer3o7q4orjij8bdc','2020-08-01 00:00:00','2020-08-02 00:00:00','Public holiday','Bakr Id/Eid ul-Adha','confirmed','2021-10-14 13:23:57'),(123,'3ab25593-c617-42dc-b176-4fb0fd9118ff','20201002_78adsd9ra72bveig97v95njj98','2020-10-02 00:00:00','2020-10-03 00:00:00','Public holiday','Mahatma Gandhi Jayanti','confirmed','2021-10-14 13:23:57'),(124,'fd306b46-5b32-44ee-9056-a0a3edc5e621','20201024_g9pel6tis8j2ag8aneinu8ji0c','2020-10-24 00:00:00','2020-10-25 00:00:00','Public holiday','Maha Navami','confirmed','2021-10-14 13:23:57'),(125,'313b2175-cb70-4b00-a089-ca941d66f537','20201116_pb25k7hg9c8g6r42214519hdkg','2020-11-16 00:00:00','2020-11-17 00:00:00','Public holiday','Bhai Duj','confirmed','2021-10-14 13:23:57'),(126,'1576ba79-4dbc-4e5c-b744-9c05f5cf5327','20210227_fv7ok2vl4h3a4sfvm93c78o73s','2021-02-27 00:00:00','2021-02-28 00:00:00','Public holiday','Guru Ravidas Jayanti','confirmed','2021-10-14 13:23:57'),(127,'4c03e4b4-6ff1-4a2a-8cf0-04aae64a71bc','20210311_ff44d56b7ifa7nh33peokm2to8','2021-03-11 00:00:00','2021-03-12 00:00:00','Public holiday','Maha Shivaratri/Shivaratri','confirmed','2021-10-14 13:23:57'),(128,'ebad9627-b6be-4104-b436-7633723b8b40','20210414_il6frin01atami1htfqd6cnch4','2021-04-14 00:00:00','2021-04-15 00:00:00','Public holiday','Ambedkar Jayanti','confirmed','2021-10-14 13:23:57'),(129,'3c561333-db2a-443d-b064-fa850b16adcb','20210507_tdnk8pnvvr73r2juedpk9g9iqo','2021-05-07 00:00:00','2021-05-08 00:00:00','Public holiday','Jamat Ul-Vida','confirmed','2021-10-14 13:23:57'),(130,'30802738-4e15-4dd3-baa7-0b2e82619721','20210822_jkqnc927fk3s5cq5o9h92gjadc','2021-08-22 00:00:00','2021-08-23 00:00:00','Public holiday','Raksha Bandhan (Rakhi)','confirmed','2021-10-14 13:23:57'),(131,'aba0f43a-8901-45f7-ae0e-8442098d62a6','20210830_n5gr3l3qtm13mj4tnid6396ui8','2021-08-30 00:00:00','2021-08-31 00:00:00','Public holiday','Janmashtami (Smarta)','confirmed','2021-10-14 13:23:57'),(132,'b7d796ee-a571-4b1a-9fa9-56686f193dc4','20220215_11fecl9rlku00cufscinoqaqqk','2022-02-15 00:00:00','2022-02-16 00:00:00','Public holiday','Hazarat Ali\'s Birthday','confirmed','2021-10-14 13:23:57'),(133,'e85fb12a-68a9-4692-b203-f965524d2b8d','20220414_p53627l5r01ardvanaa4pqn3ec','2022-04-14 00:00:00','2022-04-15 00:00:00','Public holiday','Mahavir Jayanti','confirmed','2021-10-14 13:23:57'),(134,'ceec71cb-aecf-47b2-a26a-279d53d4a645','20220415_mqecjs2reg96b1g6eft6sgb5a8','2022-04-15 00:00:00','2022-04-16 00:00:00','Public holiday','Good Friday','confirmed','2021-10-14 13:23:57'),(135,'3ee255f2-1dac-4314-8049-e04849cb2d27','20220503_19gkkie1hub1a4ajulcku03he0','2022-05-03 00:00:00','2022-05-04 00:00:00','Public holiday','Ramzan Id/Eid-ul-Fitar','confirmed','2021-10-14 13:23:57'),(136,'3755629c-3fd1-4129-9c7e-f0244f940867','20220808_kld26ald5j65gh2cl7e6g6pp58','2022-08-08 00:00:00','2022-08-09 00:00:00','Public holiday','Muharram/Ashura','confirmed','2021-10-14 13:23:57'),(137,'17fe9be9-0d4c-4a49-bbf1-7003cd8a625b','20220815_5qifn9idp1endkelhuk7kt3cfo','2022-08-15 00:00:00','2022-08-16 00:00:00','Public holiday','Independence Day','confirmed','2021-10-14 13:23:57'),(138,'ea0d8492-8990-4fc5-8c44-ad86b8249799','20220926_q4cgvj6agl66mr6uoli0fidb2s','2022-09-26 00:00:00','2022-09-27 00:00:00','Observance\nTo hide observances, go to Google Calendar Settings > Holidays in India','First Day of Sharad Navratri','confirmed','2021-10-14 13:23:57'),(139,'f0e67019-6b69-4c5d-ab17-ed9f118f6568','20200414_6rhbd6ctajdv9252g5jpi983tg','2020-04-14 00:00:00','2020-04-15 00:00:00','Public holiday','Ambedkar Jayanti','confirmed','2021-10-14 13:23:57'),(140,'c8f85908-4e23-4f53-9d42-e5bf5ce40df6','20200803_pogq56q5a4uqnhcoq1s7d72kmc','2020-08-03 00:00:00','2020-08-04 00:00:00','Public holiday','Raksha Bandhan (Rakhi)','confirmed','2021-10-14 13:23:57'),(141,'98fba682-ce00-4cca-8600-b44f515f12f6','20201022_p6r46bekv6o1sjn15avr42pork','2020-10-22 00:00:00','2020-10-23 00:00:00','Public holiday','Maha Saptami','confirmed','2021-10-14 13:23:57'),(142,'6573f04b-ef8b-4902-a030-7293e609949e','20201030_hjujtqjgigmpuvsr06ro4pi688','2020-10-30 00:00:00','2020-10-31 00:00:00','Public holiday','Milad un-Nabi/Id-e-Milad','confirmed','2021-10-14 13:23:57'),(143,'550a19c6-f8f9-4e67-b796-797c6cc21bbd','20201124_lujnbqbupv21jenh40rjh4pefk','2020-11-24 00:00:00','2020-11-25 00:00:00','Public holiday','Guru Tegh Bahadur\'s Martyrdom Day','confirmed','2021-10-14 13:23:57'),(144,'56301c17-82e1-4513-8e63-6ee129f1c008','20210101_2qu4ka3crvilq9ce04nn0h2vf8','2021-01-01 00:00:00','2021-01-02 00:00:00','Public holiday','New Year\'s Day','confirmed','2021-10-14 13:23:57'),(145,'0d7494bd-9e4f-4170-8fdd-6dafe1b30335','20210126_r96alqqadv2dtsqvvfk48th58c','2021-01-26 00:00:00','2021-01-27 00:00:00','Public holiday','Republic Day','confirmed','2021-10-14 13:23:57'),(146,'0962bd97-c446-4020-ae1f-1a71d8bf2ec0','20210402_4k51bcna76h0pirb2911bi8qp0','2021-04-02 00:00:00','2021-04-03 00:00:00','Public holiday','Good Friday','confirmed','2021-10-14 13:23:57'),(147,'44dace55-9746-49f5-a4f6-5d012cb0dbac','20210514_vavk77jm07uftvff0jt53732p0','2021-05-14 00:00:00','2021-05-15 00:00:00','Public holiday','Ramzan Id/Eid-ul-Fitar','confirmed','2021-10-14 13:23:57'),(148,'155947a0-c082-42ec-bb97-9a7180d66e63','20210526_vnc9p6bae3bd20dtmcsodam714','2021-05-26 00:00:00','2021-05-27 00:00:00','Public holiday','Buddha Purnima/Vesak','confirmed','2021-10-14 13:23:57'),(149,'c047768d-30a7-4397-87b7-04c58b7b6963','20211007_napmjnkovfp95vn9n47gj8p47c','2021-10-07 00:00:00','2021-10-08 00:00:00','Observance\nTo hide observances, go to Google Calendar Settings > Holidays in India','First Day of Sharad Navratri','confirmed','2021-10-14 13:23:57'),(150,'cbae0651-67dc-41f2-8f0d-b0c971464548','20211012_bth5n1dap26um4o4fm2g75vuic','2021-10-12 00:00:00','2021-10-13 00:00:00','Public holiday','Maha Saptami','confirmed','2021-10-14 13:23:57'),(151,'1862b4d4-7329-4f89-8968-f7d9a209f50a','20211014_i3d6mue8gjoqgf9gir68iq294k','2021-10-14 00:00:00','2021-10-15 00:00:00','Public holiday','Maha Navami','confirmed','2021-10-14 13:23:57'),(152,'a733c161-c24e-4c37-8980-83586ce57860','20220710_7qf3oo8nd0hou763ufvpn8fb8o','2022-07-10 00:00:00','2022-07-11 00:00:00','Public holiday','Bakr Id/Eid ul-Adha','confirmed','2021-10-14 13:23:57'),(153,'28de5414-b8d1-4531-864f-975b0cc0fbb7','20220831_o1ebq280uhvbmvn7795ueb8vlg','2022-08-31 00:00:00','2022-09-01 00:00:00','Public holiday','Ganesh Chaturthi/Vinayaka Chaturthi','confirmed','2021-10-14 13:23:57'),(154,'38074dfb-76fb-4863-9221-da4ffe220b1b','20221001_5bs6mo9bfnhkm1to8o7vshu5oc','2022-10-01 00:00:00','2022-10-02 00:00:00','Observance\nTo hide observances, go to Google Calendar Settings > Holidays in India','First Day of Durga Puja Festivities','confirmed','2021-10-14 13:23:57'),(155,'d04407ae-4137-4a25-87f4-2180f859c423','20221004_shbc8rnqlm67oo88prd4olb94s','2022-10-04 00:00:00','2022-10-05 00:00:00','Public holiday','Maha Navami','confirmed','2021-10-14 13:23:57'),(156,'61620545-8a9e-4330-829e-98ad21237690','20221025_ckhndp8p3igi9grmoi224ioc88','2022-10-25 00:00:00','2022-10-26 00:00:00','Public holiday','Govardhan Puja','confirmed','2021-10-14 13:23:57'),(157,'9efe8cfe-f618-41e8-9afd-524dd9c907ad','20221229_ueqrermmn8re3h4unpof3k6fs4','2022-12-29 00:00:00','2022-12-30 00:00:00','Observance\nTo hide observances, go to Google Calendar Settings > Holidays in India','Guru Govind Singh Jayanti','confirmed','2021-10-14 13:23:57'),(158,'6bee2e47-86c2-4f28-b1c4-3afc376a9d0a','20200115_6rc1og2iichi81c82u400a2irk','2020-01-15 00:00:00','2020-01-16 00:00:00','Public holiday','Pongal','confirmed','2021-10-14 13:23:57'),(159,'5ae189b1-9963-473e-89cb-13a3796a5d1c','20200309_81m2vt1q4eltrvj9hs28q0auck','2020-03-09 00:00:00','2020-03-10 00:00:00','Public holiday','Holika Dahana','confirmed','2021-10-14 13:23:57'),(160,'f75a37f2-e635-4e33-8f29-6b0d9d208420','20200325_50g73jcv0i3ic3tbbst2n2kmu4','2020-03-25 00:00:00','2020-03-26 00:00:00','Public holiday','Chaitra Sukhladi','confirmed','2021-10-14 13:23:57'),(161,'34ceee19-a8e1-4e6e-8082-3ff1e2e5ee79','20201022_174dkofd6pd2gle36g3bnt5tjg','2020-10-22 00:00:00','2020-10-23 00:00:00','Observance\nTo hide observances, go to Google Calendar Settings > Holidays in India','First Day of Durga Puja Festivities','confirmed','2021-10-14 13:23:57'),(162,'c89f3a44-7f8a-438e-ba96-8c234788d789','20201031_rjdlu876o791i6i23j4eb2kcck','2020-10-31 00:00:00','2020-11-01 00:00:00','Public holiday','Maharishi Valmiki Jayanti','confirmed','2021-10-14 13:23:57'),(163,'df846227-1f57-43d0-9734-4a96106e9d62','20210114_891k4gpt7f3t4e7tg1trtv8en4','2021-01-14 00:00:00','2021-01-15 00:00:00','Public holiday','Makar Sankranti','confirmed','2021-10-14 13:23:57'),(164,'3a90a912-2e12-4f68-87b2-00b322107db5','20210328_naadltedqf7ebc3pud6imd7s8o','2021-03-28 00:00:00','2021-03-29 00:00:00','Public holiday','Holika Dahana','confirmed','2021-10-14 13:23:57'),(165,'180c2cac-70dc-46d7-864b-db0237a5a405','20210414_9b9ka0apgp6mr62fmuaoop7hsc','2021-04-14 00:00:00','2021-04-15 00:00:00','Public holiday','Mesadi','confirmed','2021-10-14 13:23:57'),(166,'3232b475-9a20-41ef-afad-408360ef3bbb','20211011_5dlsd5c5q5q5vmed3rpd9vvsno','2021-10-11 00:00:00','2021-10-12 00:00:00','Observance\nTo hide observances, go to Google Calendar Settings > Holidays in India','First Day of Durga Puja Festivities','confirmed','2021-10-14 13:23:57'),(167,'d878c422-189a-41f8-a207-14dfcf5cfaa3','20211020_hjlh2p53j0tjr9eujkvrkehufg','2021-10-20 00:00:00','2021-10-21 00:00:00','Public holiday','Maharishi Valmiki Jayanti','confirmed','2021-10-14 13:23:57'),(168,'45865158-fa73-4827-a6c7-9089bdcc3e9b','20211105_l0qi5p5c2jih7qjl4co80j8od8','2021-11-05 00:00:00','2021-11-06 00:00:00','Public holiday','Govardhan Puja','confirmed','2021-10-14 13:23:57'),(169,'18d0f13f-a6b8-481b-9e7b-658d173d6999','20220414_90a70el7dqtjns47j38ilbbbbk','2022-04-14 00:00:00','2022-04-15 00:00:00','Public holiday','Vaisakhi','confirmed','2021-10-14 13:23:57'),(170,'1a0ebac4-29d3-4da7-bd36-aa4758471959','20220414_me0g00gp47e7o04guh6f8ca7h0','2022-04-14 00:00:00','2022-04-15 00:00:00','Public holiday','Mesadi / Vaisakhadi','confirmed','2021-10-14 13:23:57'),(171,'465e8a53-215e-40b1-a547-f3da08f15be3','20220429_35641ua1guvdkljg24p7n33kgc','2022-04-29 00:00:00','2022-04-30 00:00:00','Public holiday','Jamat Ul-Vida','confirmed','2021-10-14 13:23:57'),(172,'21e50e27-b224-4fcc-86dd-ccfdc02668f7','20221002_ane7fo0k4fd3obgm92sv0m9uns','2022-10-02 00:00:00','2022-10-03 00:00:00','Public holiday','Mahatma Gandhi Jayanti','confirmed','2021-10-14 13:23:57'),(173,'4f488131-5cf1-42d3-a218-46cfa7f7219e','20200410_o9mtt8a0j3e8s8feoa765i31q0','2020-04-10 00:00:00','2020-04-11 00:00:00','Public holiday','Good Friday','confirmed','2021-10-14 13:23:57'),(174,'3ac10a9c-d4b3-4d80-9a44-4c0a7e4aa262','20210216_1d4oancgait9ad9l6lb35atpik','2021-02-16 00:00:00','2021-02-17 00:00:00','Public holiday','Vasant Panchami','confirmed','2021-10-14 13:23:57'),(175,'47906939-c61b-4cb4-9e24-fc4f95821caf','20210721_jsuff4pevpgb8tr8jjfmqcp6oc','2021-07-21 00:00:00','2021-07-22 00:00:00','Public holiday','Bakr Id/Eid ul-Adha','confirmed','2021-10-14 13:23:57'),(176,'76d87fac-5147-4dfa-a811-9b4f8ae14155','20220219_vdkp1n6pv8chjgcfuk03rs7pe0','2022-02-19 00:00:00','2022-02-20 00:00:00','Public holiday','Shivaji Jayanti','confirmed','2021-10-14 13:23:57');
/*!40000 ALTER TABLE `tbl_Holiday_List` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_Job`
--

DROP TABLE IF EXISTS `tbl_Job`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_Job` (
  `Job_Name` varchar(50) NOT NULL,
  `Job_Id` varchar(40) NOT NULL,
  `Start_TS` datetime NOT NULL,
  `End_TS` datetime DEFAULT NULL,
  `Run_Status` varchar(1) NOT NULL,
  `Scheduled_TS` datetime DEFAULT NULL,
  `Created_On` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Updated_On` datetime DEFAULT NULL,
  PRIMARY KEY (`Job_Name`,`Start_TS`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_Job`
--

LOCK TABLES `tbl_Job` WRITE;
/*!40000 ALTER TABLE `tbl_Job` DISABLE KEYS */;
INSERT INTO `tbl_Job` VALUES ('APPOINMENT_REMINDER','3677ced6-9410-482b-ac4e-3807fda07e84','2021-11-02 10:11:48','2021-11-02 10:11:48','C',NULL,'2021-11-02 10:11:48','2021-11-02 10:11:48');
/*!40000 ALTER TABLE `tbl_Job` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_Log`
--

DROP TABLE IF EXISTS `tbl_Log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_Log` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `Process_Name` varchar(50) NOT NULL,
  `Process_Type` varchar(50) NOT NULL,
  `User_Id` varchar(40) DEFAULT NULL,
  `Job_Id` varchar(40) DEFAULT NULL,
  `Event_Id` varchar(40) DEFAULT NULL,
  `Meeting_Id` varchar(40) DEFAULT NULL,
  `Error_Message` text,
  `Created_On` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Updated_On` datetime DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_Log`
--

LOCK TABLES `tbl_Log` WRITE;
/*!40000 ALTER TABLE `tbl_Log` DISABLE KEYS */;
INSERT INTO `tbl_Log` VALUES (21,'APPOINMENT_REMINDER','PROGRAM_LOG','497f416b-e2c8-4818-b144-ce8392ff27a1','3677ced6-9410-482b-ac4e-3807fda07e84','7mb8jcdpaaagrd8kkto32utkg4','0aac5365-fb75-4628-ba92-4cd42e4757b3',NULL,'2021-11-02 10:11:49',NULL);
/*!40000 ALTER TABLE `tbl_Log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_Lookup`
--

DROP TABLE IF EXISTS `tbl_Lookup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_Lookup` (
  `Lookup_Cat` varchar(10) NOT NULL,
  `Lookup_Val` varchar(10) NOT NULL,
  `Lookup_Desc` varchar(50) NOT NULL,
  `Is_Active` varchar(1) NOT NULL DEFAULT 'Y',
  PRIMARY KEY (`Lookup_Cat`,`Lookup_Val`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_Lookup`
--

LOCK TABLES `tbl_Lookup` WRITE;
/*!40000 ALTER TABLE `tbl_Lookup` DISABLE KEYS */;
INSERT INTO `tbl_Lookup` VALUES ('Is_Active','B','Blocked','Y'),('Is_Active','D','Deactivated','Y'),('Is_Active','N','No','Y'),('Is_Active','NR','Not Refered','Y'),('Is_Active','Y','Yes','Y'),('Notes_Type','DN','Doctor Notes','Y'),('Notes_Type','DPN','Doctor Private Notes','N'),('Notes_Type','PN','Patient Notes','Y'),('Prac_Major','CCC','Career Counsellor','Y'),('Prac_Major','CCP','Counselling Psychologist','Y'),('Prac_Major','CLP','Clinical Psychologist','Y'),('Prac_Major','EAT','Expressive Art Therapist','Y'),('Prac_Major','LFC','Life Coach','Y'),('Prac_Major','OTH','Others','Y'),('Prac_Major','PPY','Psychotherapist','Y'),('Prac_Major','PST','Psychiatrist','Y'),('Prac_Major','RTP','Relationship Therapist','Y'),('Prac_Spec','AD','Addictions','Y'),('Prac_Spec','ADHD','ADHD','Y'),('Prac_Spec','AM','Anger Management','Y'),('Prac_Spec','BD','Bipolar Disorder','Y'),('Prac_Spec','CC','Career Counseller','Y'),('User_Type','P','Practitioner','Y'),('User_Type','S','Seeker','Y');
/*!40000 ALTER TABLE `tbl_Lookup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_Meeting`
--

DROP TABLE IF EXISTS `tbl_Meeting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_Meeting` (
  `Meeting_Id` varchar(100) NOT NULL,
  `Event_Id` text NOT NULL,
  `Start_TS` datetime NOT NULL,
  `End_TS` datetime NOT NULL,
  `Member_Id` varchar(40) NOT NULL,
  `Description` varchar(500) DEFAULT NULL,
  `Summary` varchar(500) DEFAULT NULL,
  `Status` varchar(50) DEFAULT NULL,
  `Platform` varchar(20) DEFAULT NULL,
  `Platform_Meeting_Id` varchar(50) DEFAULT NULL,
  `Reminder_Count` int NOT NULL DEFAULT '0',
  `Created_On` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Updated_On` datetime DEFAULT NULL,
  `Is_Active` varchar(1) NOT NULL DEFAULT 'Y',
  PRIMARY KEY (`Meeting_Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_Meeting`
--

LOCK TABLES `tbl_Meeting` WRITE;
/*!40000 ALTER TABLE `tbl_Meeting` DISABLE KEYS */;
INSERT INTO `tbl_Meeting` VALUES ('066ffce7-515d-4cc3-88ac-259467ddad6f','42r955n7vhu3baaq1c1specffp_20220326T143000Z','2022-03-26 20:00:00','2022-03-26 21:00:00','497f416b-e2c8-4818-b144-ce8392ff27a1',NULL,'test with recurrence','confirmed','Google Meet','https://meet.google.com/gao-cjzm-afg',0,'2021-11-02 09:23:39','2021-11-02 09:27:45','Y'),('09d4d314-6ada-4dfb-acf9-ad20632786b2','42r955n7vhu3baaq1c1specffp_20220625T143000Z','2022-06-25 20:00:00','2022-06-25 21:00:00','497f416b-e2c8-4818-b144-ce8392ff27a1',NULL,'test with recurrence','confirmed','Google Meet','https://meet.google.com/gao-cjzm-afg',0,'2021-11-02 09:23:39','2021-11-02 09:27:45','Y'),('0aac5365-fb75-4628-ba92-4cd42e4757b3','7mb8jcdpaaagrd8kkto32utkg4','2021-11-03 21:30:00','2021-11-03 22:30:00','497f416b-e2c8-4818-b144-ce8392ff27a1',NULL,'Sprint Plan Test ','confirmed','Google Meet','https://meet.google.com/amk-cwmr-bki',0,'2021-11-02 09:27:45',NULL,'Y'),('13c15910-f634-4056-8a9d-d84e4bd07682','42r955n7vhu3baaq1c1specffp_20220305T143000Z','2022-03-05 20:00:00','2022-03-05 21:00:00','497f416b-e2c8-4818-b144-ce8392ff27a1',NULL,'test with recurrence','confirmed','Google Meet','https://meet.google.com/gao-cjzm-afg',0,'2021-11-02 09:23:39','2021-11-02 09:27:45','Y'),('183f6148-ae64-41e2-90cd-312ac1a52859','42r955n7vhu3baaq1c1specffp_20220122T143000Z','2022-01-22 20:00:00','2022-01-22 21:00:00','497f416b-e2c8-4818-b144-ce8392ff27a1',NULL,'test with recurrence','confirmed','Google Meet','https://meet.google.com/gao-cjzm-afg',0,'2021-11-02 09:23:39','2021-11-02 09:27:45','Y'),('20ae5b93-39ac-4626-9081-98067769c832','42r955n7vhu3baaq1c1specffp_20211204T143000Z','2021-12-04 20:00:00','2021-12-04 21:00:00','497f416b-e2c8-4818-b144-ce8392ff27a1',NULL,'test with recurrence','confirmed','Google Meet','https://meet.google.com/gao-cjzm-afg',0,'2021-11-02 09:23:39','2021-11-02 09:27:45','Y'),('22657b67-515b-450c-baf7-b0ebd98ee8c3','42r955n7vhu3baaq1c1specffp_20220813T143000Z','2022-08-13 20:00:00','2022-08-13 21:00:00','497f416b-e2c8-4818-b144-ce8392ff27a1',NULL,'test with recurrence','confirmed','Google Meet','https://meet.google.com/gao-cjzm-afg',0,'2021-11-02 09:23:39','2021-11-02 09:27:45','Y'),('24371c83-a882-495b-94a9-3661cf926ed3','42r955n7vhu3baaq1c1specffp_20220423T143000Z','2022-04-23 20:00:00','2022-04-23 21:00:00','497f416b-e2c8-4818-b144-ce8392ff27a1',NULL,'test with recurrence','confirmed','Google Meet','https://meet.google.com/gao-cjzm-afg',0,'2021-11-02 09:23:39','2021-11-02 09:27:45','Y'),('2edea178-8378-4933-9997-f010715c3b44','42r955n7vhu3baaq1c1specffp_20211211T143000Z','2021-12-11 20:00:00','2021-12-11 21:00:00','497f416b-e2c8-4818-b144-ce8392ff27a1',NULL,'test with recurrence','confirmed','Google Meet','https://meet.google.com/gao-cjzm-afg',0,'2021-11-02 09:23:39','2021-11-02 09:27:45','Y'),('317431c5-a6b6-4f18-baec-e32c099f7ad9','42r955n7vhu3baaq1c1specffp_20220806T143000Z','2022-08-06 20:00:00','2022-08-06 21:00:00','497f416b-e2c8-4818-b144-ce8392ff27a1',NULL,'test with recurrence','confirmed','Google Meet','https://meet.google.com/gao-cjzm-afg',0,'2021-11-02 09:23:39','2021-11-02 09:27:45','Y'),('32f49259-be54-4dfd-b77a-a024de7c2cea','42r955n7vhu3baaq1c1specffp_20211225T143000Z','2021-12-25 20:00:00','2021-12-25 21:00:00','497f416b-e2c8-4818-b144-ce8392ff27a1',NULL,'test with recurrence','confirmed','Google Meet','https://meet.google.com/gao-cjzm-afg',0,'2021-11-02 09:23:39','2021-11-02 09:27:45','Y'),('3fd017ee-2d84-430f-8a1c-931e8d8ee7df','42r955n7vhu3baaq1c1specffp_20220910T143000Z','2022-09-10 20:00:00','2022-09-10 21:00:00','497f416b-e2c8-4818-b144-ce8392ff27a1',NULL,'test with recurrence','confirmed','Google Meet','https://meet.google.com/gao-cjzm-afg',0,'2021-11-02 09:23:39','2021-11-02 09:27:45','Y'),('4810765d-3028-408d-ba21-209c3771e5e3','42r955n7vhu3baaq1c1specffp_20220702T143000Z','2022-07-02 20:00:00','2022-07-02 21:00:00','497f416b-e2c8-4818-b144-ce8392ff27a1',NULL,'test with recurrence','confirmed','Google Meet','https://meet.google.com/gao-cjzm-afg',0,'2021-11-02 09:23:39','2021-11-02 09:27:45','Y'),('4cdec84b-3649-453f-8125-ee9fc05ddfdd','42r955n7vhu3baaq1c1specffp_20220212T143000Z','2022-02-12 20:00:00','2022-02-12 21:00:00','497f416b-e2c8-4818-b144-ce8392ff27a1',NULL,'test with recurrence','confirmed','Google Meet','https://meet.google.com/gao-cjzm-afg',0,'2021-11-02 09:23:39','2021-11-02 09:27:45','Y'),('4f2d8c2e-524d-47ef-989c-4c4049128926','42r955n7vhu3baaq1c1specffp_20220903T143000Z','2022-09-03 20:00:00','2022-09-03 21:00:00','497f416b-e2c8-4818-b144-ce8392ff27a1',NULL,'test with recurrence','confirmed','Google Meet','https://meet.google.com/gao-cjzm-afg',0,'2021-11-02 09:23:39','2021-11-02 09:27:45','Y'),('52e374f1-f9cc-4917-a41a-08886e32bf23','42r955n7vhu3baaq1c1specffp_20220219T143000Z','2022-02-19 20:00:00','2022-02-19 21:00:00','497f416b-e2c8-4818-b144-ce8392ff27a1',NULL,'test with recurrence','confirmed','Google Meet','https://meet.google.com/gao-cjzm-afg',0,'2021-11-02 09:23:39','2021-11-02 09:27:45','Y'),('552653ce-23b1-4690-9f50-233688aafa44','66989aaaec1uapqpc0prng7n7f_20221023T083000Z','2022-10-23 14:00:00','2022-10-23 15:00:00','497f416b-e2c8-4818-b144-ce8392ff27a1',NULL,'test long event','confirmed','Google Meet','https://meet.google.com/mwi-ghia-htz',0,'2021-11-02 09:23:39','2021-11-02 09:27:45','Y'),('5c78173b-3110-4763-b36b-428244193fa3','42r955n7vhu3baaq1c1specffp_20221015T143000Z','2022-10-15 20:00:00','2022-10-15 21:00:00','497f416b-e2c8-4818-b144-ce8392ff27a1',NULL,'test with recurrence','confirmed','Google Meet','https://meet.google.com/gao-cjzm-afg',0,'2021-11-02 09:23:39','2021-11-02 09:27:45','Y'),('63811b93-5f6b-4f33-8e46-3946de99a5cc','42r955n7vhu3baaq1c1specffp_20221029T143000Z','2022-10-29 20:00:00','2022-10-29 21:00:00','497f416b-e2c8-4818-b144-ce8392ff27a1',NULL,'test with recurrence','confirmed','Google Meet','https://meet.google.com/gao-cjzm-afg',0,'2021-11-02 09:23:39','2021-11-02 09:27:45','Y'),('644201bc-5a5d-42fc-a037-5912f685f7e8','42r955n7vhu3baaq1c1specffp_20220226T143000Z','2022-02-26 20:00:00','2022-02-26 21:00:00','497f416b-e2c8-4818-b144-ce8392ff27a1',NULL,'test with recurrence','confirmed','Google Meet','https://meet.google.com/gao-cjzm-afg',0,'2021-11-02 09:23:39','2021-11-02 09:27:45','Y'),('767b80c5-791a-4f3e-b24f-c862a8b941a2','42r955n7vhu3baaq1c1specffp_20211113T143000Z','2021-11-13 20:00:00','2021-11-13 21:00:00','497f416b-e2c8-4818-b144-ce8392ff27a1',NULL,'test with recurrence','confirmed','Google Meet','https://meet.google.com/gao-cjzm-afg',0,'2021-11-02 09:23:39','2021-11-02 09:27:45','Y'),('7a3d4591-6483-40d0-9b3e-3bc6e2c61d72','42r955n7vhu3baaq1c1specffp_20211218T143000Z','2021-12-18 20:00:00','2021-12-18 21:00:00','497f416b-e2c8-4818-b144-ce8392ff27a1',NULL,'test with recurrence','confirmed','Google Meet','https://meet.google.com/gao-cjzm-afg',0,'2021-11-02 09:23:39','2021-11-02 09:27:45','Y'),('7ffe0c0e-f3d6-41b0-990d-5a972c37ddef','42r955n7vhu3baaq1c1specffp_20220409T143000Z','2022-04-09 20:00:00','2022-04-09 21:00:00','497f416b-e2c8-4818-b144-ce8392ff27a1',NULL,'test with recurrence','confirmed','Google Meet','https://meet.google.com/gao-cjzm-afg',0,'2021-11-02 09:23:39','2021-11-02 09:27:45','Y'),('80f2e379-338d-4cc9-849a-76342ba3d357','42r955n7vhu3baaq1c1specffp_20221008T143000Z','2022-10-08 20:00:00','2022-10-08 21:00:00','497f416b-e2c8-4818-b144-ce8392ff27a1',NULL,'test with recurrence','confirmed','Google Meet','https://meet.google.com/gao-cjzm-afg',0,'2021-11-02 09:23:39','2021-11-02 09:27:45','Y'),('81db0c3b-09f2-4b03-a591-f3dde8a8a605','42r955n7vhu3baaq1c1specffp_20220402T143000Z','2022-04-02 20:00:00','2022-04-02 21:00:00','497f416b-e2c8-4818-b144-ce8392ff27a1',NULL,'test with recurrence','confirmed','Google Meet','https://meet.google.com/gao-cjzm-afg',0,'2021-11-02 09:23:39','2021-11-02 09:27:45','Y'),('88ba60f3-1dbb-4135-97f8-112235c865bc','42r955n7vhu3baaq1c1specffp_20220205T143000Z','2022-02-05 20:00:00','2022-02-05 21:00:00','497f416b-e2c8-4818-b144-ce8392ff27a1',NULL,'test with recurrence','confirmed','Google Meet','https://meet.google.com/gao-cjzm-afg',0,'2021-11-02 09:23:39','2021-11-02 09:27:45','Y'),('91201214-2c55-4163-ae98-20c70e62e0a8','42r955n7vhu3baaq1c1specffp_20220730T143000Z','2022-07-30 20:00:00','2022-07-30 21:00:00','497f416b-e2c8-4818-b144-ce8392ff27a1',NULL,'test with recurrence','confirmed','Google Meet','https://meet.google.com/gao-cjzm-afg',0,'2021-11-02 09:23:39','2021-11-02 09:27:45','Y'),('92c70781-46f9-45c2-b9df-7e86a32b08ab','42r955n7vhu3baaq1c1specffp_20220604T143000Z','2022-06-04 20:00:00','2022-06-04 21:00:00','497f416b-e2c8-4818-b144-ce8392ff27a1',NULL,'test with recurrence','confirmed','Google Meet','https://meet.google.com/gao-cjzm-afg',0,'2021-11-02 09:23:39','2021-11-02 09:27:45','Y'),('965899c0-5d9e-4c90-b3ab-2b135c9c20b3','42r955n7vhu3baaq1c1specffp_20220514T143000Z','2022-05-14 20:00:00','2022-05-14 21:00:00','497f416b-e2c8-4818-b144-ce8392ff27a1',NULL,'test with recurrence','confirmed','Google Meet','https://meet.google.com/gao-cjzm-afg',0,'2021-11-02 09:23:39','2021-11-02 09:27:45','Y'),('998060a6-402a-4c53-a0a0-84edeef0b078','42r955n7vhu3baaq1c1specffp_20211106T143000Z','2021-11-06 20:00:00','2021-11-06 21:00:00','497f416b-e2c8-4818-b144-ce8392ff27a1',NULL,'test with recurrence','confirmed','Google Meet','https://meet.google.com/gao-cjzm-afg',0,'2021-11-02 09:23:39','2021-11-02 09:27:45','Y'),('a209ba01-eb27-4224-b7f6-cde6bf11e647','42r955n7vhu3baaq1c1specffp_20220723T143000Z','2022-07-23 20:00:00','2022-07-23 21:00:00','497f416b-e2c8-4818-b144-ce8392ff27a1',NULL,'test with recurrence','confirmed','Google Meet','https://meet.google.com/gao-cjzm-afg',0,'2021-11-02 09:23:39','2021-11-02 09:27:45','Y'),('a3210717-4f03-459b-8f53-360f0fe12b09','42r955n7vhu3baaq1c1specffp_20220709T143000Z','2022-07-09 20:00:00','2022-07-09 21:00:00','497f416b-e2c8-4818-b144-ce8392ff27a1',NULL,'test with recurrence','confirmed','Google Meet','https://meet.google.com/gao-cjzm-afg',0,'2021-11-02 09:23:39','2021-11-02 09:27:45','Y'),('a4d5cb4b-39ce-4b77-970d-eb0767e1fc14','42r955n7vhu3baaq1c1specffp_20220115T143000Z','2022-01-15 20:00:00','2022-01-15 21:00:00','497f416b-e2c8-4818-b144-ce8392ff27a1',NULL,'test with recurrence','confirmed','Google Meet','https://meet.google.com/gao-cjzm-afg',0,'2021-11-02 09:23:39','2021-11-02 09:27:45','Y'),('a752a1c8-e629-4359-bd6a-4223725e6997','42r955n7vhu3baaq1c1specffp_20220716T143000Z','2022-07-16 20:00:00','2022-07-16 21:00:00','497f416b-e2c8-4818-b144-ce8392ff27a1',NULL,'test with recurrence','confirmed','Google Meet','https://meet.google.com/gao-cjzm-afg',0,'2021-11-02 09:23:39','2021-11-02 09:27:45','Y'),('aab5d94e-698d-43b7-b48f-9c8a01492347','42r955n7vhu3baaq1c1specffp_20220611T143000Z','2022-06-11 20:00:00','2022-06-11 21:00:00','497f416b-e2c8-4818-b144-ce8392ff27a1',NULL,'test with recurrence','confirmed','Google Meet','https://meet.google.com/gao-cjzm-afg',0,'2021-11-02 09:23:39','2021-11-02 09:27:45','Y'),('ad5ae575-086b-4bb4-b97c-c4296b4cec14','42r955n7vhu3baaq1c1specffp_20220319T143000Z','2022-03-19 20:00:00','2022-03-19 21:00:00','497f416b-e2c8-4818-b144-ce8392ff27a1',NULL,'test with recurrence','confirmed','Google Meet','https://meet.google.com/gao-cjzm-afg',0,'2021-11-02 09:23:39','2021-11-02 09:27:45','Y'),('b6b9bdd2-ff41-4047-8c6c-81cc31ea85d0','42r955n7vhu3baaq1c1specffp_20220312T143000Z','2022-03-12 20:00:00','2022-03-12 21:00:00','497f416b-e2c8-4818-b144-ce8392ff27a1',NULL,'test with recurrence','confirmed','Google Meet','https://meet.google.com/gao-cjzm-afg',0,'2021-11-02 09:23:39','2021-11-02 09:27:45','Y'),('beaa9b39-6cf2-4205-b6f0-77168421f1c0','42r955n7vhu3baaq1c1specffp_20220108T143000Z','2022-01-08 20:00:00','2022-01-08 21:00:00','497f416b-e2c8-4818-b144-ce8392ff27a1',NULL,'test with recurrence','confirmed','Google Meet','https://meet.google.com/gao-cjzm-afg',0,'2021-11-02 09:23:39','2021-11-02 09:27:45','Y'),('c2d0ed26-4e1a-4d3b-9c75-62c44405007c','42r955n7vhu3baaq1c1specffp_20220917T143000Z','2022-09-17 20:00:00','2022-09-17 21:00:00','497f416b-e2c8-4818-b144-ce8392ff27a1',NULL,'test with recurrence','confirmed','Google Meet','https://meet.google.com/gao-cjzm-afg',0,'2021-11-02 09:23:39','2021-11-02 09:27:45','Y'),('c47e7297-64d9-49fb-8fd0-086cc2987aec','42r955n7vhu3baaq1c1specffp_20220827T143000Z','2022-08-27 20:00:00','2022-08-27 21:00:00','497f416b-e2c8-4818-b144-ce8392ff27a1',NULL,'test with recurrence','confirmed','Google Meet','https://meet.google.com/gao-cjzm-afg',0,'2021-11-02 09:23:39','2021-11-02 09:27:45','Y'),('c6b671d2-7c61-495f-9763-aa53ea55298f','42r955n7vhu3baaq1c1specffp_20220924T143000Z','2022-09-24 20:00:00','2022-09-24 21:00:00','497f416b-e2c8-4818-b144-ce8392ff27a1',NULL,'test with recurrence','confirmed','Google Meet','https://meet.google.com/gao-cjzm-afg',0,'2021-11-02 09:23:39','2021-11-02 09:27:45','Y'),('c8f6a824-5eaa-44c0-93a5-e6e3f092695b','42r955n7vhu3baaq1c1specffp_20220528T143000Z','2022-05-28 20:00:00','2022-05-28 21:00:00','497f416b-e2c8-4818-b144-ce8392ff27a1',NULL,'test with recurrence','confirmed','Google Meet','https://meet.google.com/gao-cjzm-afg',0,'2021-11-02 09:23:39','2021-11-02 09:27:45','Y'),('d17bd8be-9e16-4d0f-98f7-2e8d51cc4c97','42r955n7vhu3baaq1c1specffp_20220101T143000Z','2022-01-01 20:00:00','2022-01-01 21:00:00','497f416b-e2c8-4818-b144-ce8392ff27a1',NULL,'test with recurrence','confirmed','Google Meet','https://meet.google.com/gao-cjzm-afg',0,'2021-11-02 09:23:39','2021-11-02 09:27:45','Y'),('d238aa4d-a791-43fb-abe1-5baca9f520eb','42r955n7vhu3baaq1c1specffp_20211120T143000Z','2021-11-20 20:00:00','2021-11-20 21:00:00','497f416b-e2c8-4818-b144-ce8392ff27a1',NULL,'test with recurrence','confirmed','Google Meet','https://meet.google.com/gao-cjzm-afg',0,'2021-11-02 09:23:39','2021-11-02 09:27:45','Y'),('d28752e2-20e2-436e-a879-7a11b2fb7baf','42r955n7vhu3baaq1c1specffp_20220416T143000Z','2022-04-16 20:00:00','2022-04-16 21:00:00','497f416b-e2c8-4818-b144-ce8392ff27a1',NULL,'test with recurrence','confirmed','Google Meet','https://meet.google.com/gao-cjzm-afg',0,'2021-11-02 09:23:39','2021-11-02 09:27:45','Y'),('d294aba0-2b05-421d-a172-f18b22bee0f8','42r955n7vhu3baaq1c1specffp_20220430T143000Z','2022-04-30 20:00:00','2022-04-30 21:00:00','497f416b-e2c8-4818-b144-ce8392ff27a1',NULL,'test with recurrence','confirmed','Google Meet','https://meet.google.com/gao-cjzm-afg',0,'2021-11-02 09:23:39','2021-11-02 09:27:45','Y'),('d9cdc83f-5286-4c7d-98f8-0fa3c0f4e273','42r955n7vhu3baaq1c1specffp_20221022T143000Z','2022-10-22 20:00:00','2022-10-22 21:00:00','497f416b-e2c8-4818-b144-ce8392ff27a1',NULL,'test with recurrence','confirmed','Google Meet','https://meet.google.com/gao-cjzm-afg',0,'2021-11-02 09:23:39','2021-11-02 09:27:45','Y'),('dbdf2fbe-0776-4dea-9084-d46e9648e279','42r955n7vhu3baaq1c1specffp_20220507T143000Z','2022-05-07 20:00:00','2022-05-07 21:00:00','497f416b-e2c8-4818-b144-ce8392ff27a1',NULL,'test with recurrence','confirmed','Google Meet','https://meet.google.com/gao-cjzm-afg',0,'2021-11-02 09:23:39','2021-11-02 09:27:45','Y'),('dc07e6b4-b172-4504-b4c8-f2f474802140','42r955n7vhu3baaq1c1specffp_20221001T143000Z','2022-10-01 20:00:00','2022-10-01 21:00:00','497f416b-e2c8-4818-b144-ce8392ff27a1',NULL,'test with recurrence','confirmed','Google Meet','https://meet.google.com/gao-cjzm-afg',0,'2021-11-02 09:23:39','2021-11-02 09:27:45','Y'),('e5f6ee40-c014-411d-adf3-e8587420cd1b','42r955n7vhu3baaq1c1specffp_20211127T143000Z','2021-11-27 20:00:00','2021-11-27 21:00:00','497f416b-e2c8-4818-b144-ce8392ff27a1',NULL,'test with recurrence','confirmed','Google Meet','https://meet.google.com/gao-cjzm-afg',0,'2021-11-02 09:23:39','2021-11-02 09:27:45','Y'),('e830e6a4-a6d0-452c-990f-77670e742bc9','42r955n7vhu3baaq1c1specffp_20220129T143000Z','2022-01-29 20:00:00','2022-01-29 21:00:00','497f416b-e2c8-4818-b144-ce8392ff27a1',NULL,'test with recurrence','confirmed','Google Meet','https://meet.google.com/gao-cjzm-afg',0,'2021-11-02 09:23:39','2021-11-02 09:27:45','Y'),('edfcc21b-befe-4637-a135-4c213e78bbf9','42r955n7vhu3baaq1c1specffp_20220521T143000Z','2022-05-21 20:00:00','2022-05-21 21:00:00','497f416b-e2c8-4818-b144-ce8392ff27a1',NULL,'test with recurrence','confirmed','Google Meet','https://meet.google.com/gao-cjzm-afg',0,'2021-11-02 09:23:39','2021-11-02 09:27:45','Y'),('f65802b8-c818-4302-9b31-c5654821b5ba','42r955n7vhu3baaq1c1specffp_20220618T143000Z','2022-06-18 20:00:00','2022-06-18 21:00:00','497f416b-e2c8-4818-b144-ce8392ff27a1',NULL,'test with recurrence','confirmed','Google Meet','https://meet.google.com/gao-cjzm-afg',0,'2021-11-02 09:23:39','2021-11-02 09:27:45','Y'),('f67c921a-890f-4593-95f6-01e160c06cfb','42r955n7vhu3baaq1c1specffp_20220820T143000Z','2022-08-20 20:00:00','2022-08-20 21:00:00','497f416b-e2c8-4818-b144-ce8392ff27a1',NULL,'test with recurrence','confirmed','Google Meet','https://meet.google.com/gao-cjzm-afg',0,'2021-11-02 09:23:39','2021-11-02 09:27:45','Y');
/*!40000 ALTER TABLE `tbl_Meeting` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_Member`
--

DROP TABLE IF EXISTS `tbl_Member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_Member` (
  `Member_Id` varchar(40) NOT NULL,
  `Pay_Cat` varchar(50) DEFAULT NULL,
  `Reg_Num` varchar(50) DEFAULT NULL,
  `Backgrnd_Ver` varchar(1) DEFAULT NULL,
  `Doc_Flag` varchar(1) DEFAULT NULL,
  `Major` varchar(5) DEFAULT NULL,
  `Specification` varchar(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `Experience` varchar(100) DEFAULT NULL,
  `Description` varchar(100) DEFAULT NULL,
  `Photo_URL` varchar(500) DEFAULT NULL,
  `Resume_URL` varchar(500) DEFAULT NULL,
  `Pricing` varchar(10) DEFAULT NULL,
  `SlotId` varchar(10) DEFAULT NULL,
  `Addr` varchar(50) DEFAULT NULL,
  `Reminder_Time` int NOT NULL DEFAULT '1',
  `Is_Cres_Member` varchar(1) NOT NULL DEFAULT 'Y',
  `Created_On` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Updated_ON` datetime DEFAULT NULL,
  PRIMARY KEY (`Member_Id`),
  CONSTRAINT `tbl_member_chk_1` CHECK ((`Reminder_Time` >= 1))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_Member`
--

LOCK TABLES `tbl_Member` WRITE;
/*!40000 ALTER TABLE `tbl_Member` DISABLE KEYS */;
INSERT INTO `tbl_Member` VALUES ('497f416b-e2c8-4818-b144-ce8392ff27a1',NULL,NULL,NULL,NULL,'LC','AM','Having Broad Experience',NULL,NULL,NULL,NULL,NULL,NULL,1,'Y','2021-10-28 10:58:11','2021-10-28 10:58:13'),('dde7af37-cf90-4bc7-97ea-a6d2fc2a8ea0',NULL,NULL,NULL,NULL,'CLP','ADHD','Huge Experience',NULL,NULL,NULL,NULL,NULL,NULL,1,'Y','2021-10-29 11:11:06','2021-10-29 11:23:43');
/*!40000 ALTER TABLE `tbl_Member` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_Note`
--

DROP TABLE IF EXISTS `tbl_Note`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_Note` (
  `Note_Id` varchar(40) NOT NULL,
  `Member_Id` varchar(40) DEFAULT NULL,
  `Client_Id` varchar(40) DEFAULT NULL,
  `Meeting_Id` varchar(40) DEFAULT NULL,
  `Resource_Type` varchar(3) NOT NULL,
  `Resource` text NOT NULL,
  `Created_On` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Updated_On` datetime DEFAULT NULL,
  UNIQUE KEY `Note_Id` (`Note_Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_Note`
--

LOCK TABLES `tbl_Note` WRITE;
/*!40000 ALTER TABLE `tbl_Note` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_Note` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_Refer`
--

DROP TABLE IF EXISTS `tbl_Refer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_Refer` (
  `Refer_Id` varchar(40) NOT NULL,
  `Code` varchar(40) NOT NULL,
  `Refered_By` varchar(40) DEFAULT NULL,
  `Role` varchar(2) NOT NULL,
  `Created_On` datetime DEFAULT CURRENT_TIMESTAMP,
  `Is_Active` varchar(1) NOT NULL DEFAULT 'Y',
  PRIMARY KEY (`Code`),
  UNIQUE KEY `Refer_Id` (`Refer_Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_Refer`
--

LOCK TABLES `tbl_Refer` WRITE;
/*!40000 ALTER TABLE `tbl_Refer` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_Refer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_Refer_Det`
--

DROP TABLE IF EXISTS `tbl_Refer_Det`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_Refer_Det` (
  `Refer_Id` varchar(40) NOT NULL,
  `Refered_To` varchar(50) NOT NULL,
  `User_Id` varchar(40) DEFAULT NULL,
  `Refered_On` datetime DEFAULT CURRENT_TIMESTAMP,
  `Requested_By` varchar(3) NOT NULL,
  PRIMARY KEY (`Refer_Id`,`Refered_To`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_Refer_Det`
--

LOCK TABLES `tbl_Refer_Det` WRITE;
/*!40000 ALTER TABLE `tbl_Refer_Det` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_Refer_Det` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_Seeker`
--

DROP TABLE IF EXISTS `tbl_Seeker`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_Seeker` (
  `Seeker_Id` varchar(40) NOT NULL,
  `Org_Id` varchar(50) DEFAULT NULL,
  `DOB` datetime DEFAULT NULL,
  `Gender` varchar(1) DEFAULT NULL,
  `Created_On` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Updated_ON` datetime DEFAULT NULL,
  PRIMARY KEY (`Seeker_Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_Seeker`
--

LOCK TABLES `tbl_Seeker` WRITE;
/*!40000 ALTER TABLE `tbl_Seeker` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_Seeker` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_Token`
--

DROP TABLE IF EXISTS `tbl_Token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_Token` (
  `Member_Id` varchar(40) NOT NULL,
  `Email` varchar(100) NOT NULL,
  `Access_Token` varchar(300) NOT NULL,
  `Refresh_Token` varchar(300) NOT NULL,
  `Created_On` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Updated_On` datetime DEFAULT NULL,
  `Is_Active` varchar(1) NOT NULL DEFAULT 'Y',
  PRIMARY KEY (`Member_Id`,`Is_Active`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_Token`
--

LOCK TABLES `tbl_Token` WRITE;
/*!40000 ALTER TABLE `tbl_Token` DISABLE KEYS */;
INSERT INTO `tbl_Token` VALUES ('497f416b-e2c8-4818-b144-ce8392ff27a1','samantaraja627@gmail.com','ya29.a0ARrdaM_dm0AfMUfJH5PFBKt_eBw85wp_vNJQ9iQLVxmbGUpR2ilwnhTlJsTsUKQr7XXiZG8RvvNG_TY8G5pbf6CWtIsUegOVerrIVTnLyTlBuMoi_QSGvLQBEilnGpOfqzzqOG9_A48EqMCDpnE_i8FSTojC','1//0geCpAczRuZUwCgYIARAAGBASNwF-L9IrGy5Mhhsl9P58UCnSGLIIfQEFUCZe4sHE6Vmoi9UJWekOtXnl6swG_hs97Znw1PvyMkI','2021-11-01 12:48:02',NULL,'Y');
/*!40000 ALTER TABLE `tbl_Token` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_User`
--

DROP TABLE IF EXISTS `tbl_User`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_User` (
  `Firebase_Id` varchar(50) NOT NULL,
  `Identification` varchar(100) NOT NULL,
  `User_Id` varchar(40) NOT NULL,
  `User_Type` varchar(1) NOT NULL,
  `Frst_Name` varchar(30) NOT NULL,
  `Last_Name` varchar(30) NOT NULL,
  `Email` varchar(100) NOT NULL,
  `Refresh_Token` varchar(300) DEFAULT NULL,
  `Created_On` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Updated_ON` datetime DEFAULT NULL,
  `Is_Active` varchar(1) NOT NULL DEFAULT 'Y',
  PRIMARY KEY (`User_Id`),
  UNIQUE KEY `Firebase_Id` (`Firebase_Id`),
  UNIQUE KEY `Identification` (`Identification`),
  UNIQUE KEY `Email` (`Email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_User`
--

LOCK TABLES `tbl_User` WRITE;
/*!40000 ALTER TABLE `tbl_User` DISABLE KEYS */;
INSERT INTO `tbl_User` VALUES ('KIKUaJFaSEhjnW5D7ewCP3bv5vi1','918967998601','497f416b-e2c8-4818-b144-ce8392ff27a1','P','Raja','Samanta','samantaraja627@gmail.com','AFxQ4_oqe4kbbiC0u-kIe0pvRcFfiiqid3yszmjH2sdPq2l42gBChJMc7qiX_b9UUxMvEPbLGyxVDL29iSZ2jibjK3wXbdRa7MCR6LnzaYgX-JwubTuYKmYy-D-1YuuPwYXdnS-tz1rvZ3vT4Wj9mXtEEE44iMwpdHDA0M8wIw6akTff8HeOy3tqD1ym73DsSWf6qoxBA9Ko','2021-10-28 10:58:11','2021-11-01 09:29:44','Y'),('1j1gr00xQbbyNAznk2HrZcIEhpi1','917407878778','dde7af37-cf90-4bc7-97ea-a6d2fc2a8ea0','P','Raja','Samanta','sankhadipsamanta59@gmail.com','AFxQ4_qhV_DJUCBfTAHSOWJFk2UkauCuvBR8bwhV3qMfh6cXjMYY-hXSJc9Vr6VZuTUPH94BqPg1VvCjPqBlQ4J7wzmM7z5ue1qelbwy6pjPzga3QxT4DIsYd50DekI7MngpwpoUk8eBGuldToGTzL1Z-p3dhTX6BvsY8RiT2tm_Tyvgdd_jq3bzBSQIbB42HgOoLP4bboHO','2021-10-29 11:11:06','2021-10-29 12:52:46','Y');
/*!40000 ALTER TABLE `tbl_User` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-11-02 10:17:12
