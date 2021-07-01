-- MySQL dump 10.17  Distrib 10.3.21-MariaDB, for Linux (x86_64)
--
-- Host: bigservicedb-stag1.cgit7qfnncrf.us-east-1.rds.amazonaws.com    Database: globalconfig
-- ------------------------------------------------------
-- Server version	5.7.26-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Dumping data for table `exams`
--

LOCK TABLES `exams` WRITE;
/*!40000 ALTER TABLE `exams` DISABLE KEYS */;
INSERT INTO `exams` VALUES ('IBPS পোঃ, কেরানি, RRB, এসবিআই, আরবিআই, বীমা','ব্যাংক','BANKING','BENGALI',101,'0000-00-00 00:00:00','0000-00-00 00:00:00');
INSERT INTO `exams` VALUES ('IBPS PO, CLERK, RRB, SBI, RBI, Insurance','BANKING','BANKING','ENGLISH',102,'0000-00-00 00:00:00','0000-00-00 00:00:00');
INSERT INTO `exams` VALUES ('आईबीपीएस पीओ, क्लर्क, आरआरबी, एसबीआई, भारतीय रिजर्व बैंक, बीमा','बैंकिंग','BANKING','HINDI',103,'0000-00-00 00:00:00','0000-00-00 00:00:00');
INSERT INTO `exams` VALUES ('IBPS ಪಿಒ ಗುಮಾಸ್ತ, RRB, ಎಸ್ಬಿಐ, ಆರ್ಬಿಐ, ವಿಮೆ','ബാങ്കിംഗ്','BANKING','KANNADA',104,'0000-00-00 00:00:00','0000-00-00 00:00:00');
INSERT INTO `exams` VALUES ('ഐബിപിഎസ് പി.ഒ., ക്ലാർക്ക്, .മഹാരാഷ്ട്ര, എസ്ബിഐ, റിസർവ്, ഇൻഷുറൻസ്','ബാങ്കിംഗ്','BANKING','MALYALAM',105,'0000-00-00 00:00:00','0000-00-00 00:00:00');
INSERT INTO `exams` VALUES ('IBPS पीओ, लिपिक, रेल्वे भरती महामंडळ,, स्टेट बँक, रिझर्व्ह बँक ऑफ इंडिया, विमा','बँकिंग','BANKING','MARATHI',106,'0000-00-00 00:00:00','0000-00-00 00:00:00');
INSERT INTO `exams` VALUES ('IBPS அஞ்சல், கிளர்க், ஆர்ஆர்பி, எஸ்பிஐ, ஆர்பிஐ, காப்பீடு','வங்கி','BANKING','TAMIL',107,'0000-00-00 00:00:00','0000-00-00 00:00:00');
INSERT INTO `exams` VALUES ('ఐబీపీస్ పిఒ(PO), క్లర్క్, ఆర్ఆర్బీ, ఎస్బిఐ, ఆర్బిఐ, ఇన్సూరెన్స్','బ్యాంకింగ్','BANKING','TELUGU',108,'0000-00-00 00:00:00','0000-00-00 00:00:00');
INSERT INTO `exams` VALUES ('CTET (পত্র আমি & দ্বিতীয়), KVS, NVS, স্ট্যান্ড','শিক্ষাদান','CTET','BENGALI',301,'0000-00-00 00:00:00','0000-00-00 00:00:00');
INSERT INTO `exams` VALUES ('CTET (Paper I & II), KVS, NVS, STET','TEACHING','CTET','ENGLISH',302,'0000-00-00 00:00:00','0000-00-00 00:00:00');
INSERT INTO `exams` VALUES ('CTET (कागज मैं और द्वितीय), केवीएस, एनवीएस, STET','टीचिंग','CTET','HINDI',303,'0000-00-00 00:00:00','0000-00-00 00:00:00');
INSERT INTO `exams` VALUES ('ಸಿಟಿಇಟಿ (ಪೇಪರ್ ನಾನು & II), KVs, NVS, STET','ಶಿಕ್ಷಕರ ನೇಮಕಾತಿ ಪರೀಕ್ಷೆಯಲ್ಲಿ','CTET','KANNADA',304,'0000-00-00 00:00:00','0000-00-00 00:00:00');
INSERT INTO `exams` VALUES ('സി ടി ഇ ടി (പേപ്പർ I & പേപ്പർ II), കെവിഎസ്, എൻ‌വി‌എസ്, ഡി‌എസ്‌എസ്‌എസ്ബി','അധ്യാപക നിയമന പരീക്ഷ','CTET','MALYALAM',305,'0000-00-00 00:00:00','0000-00-00 00:00:00');
INSERT INTO `exams` VALUES ('CTET (पेपर दोन), केवीएस, NVS, वाक्ये','अध्यापन','CTET','MARATHI',306,'0000-00-00 00:00:00','0000-00-00 00:00:00');
INSERT INTO `exams` VALUES ('CTET (காகிதம் நான் & II) KVS, NVS, STET','போதனை','CTET','TAMIL',307,'0000-00-00 00:00:00','0000-00-00 00:00:00');
INSERT INTO `exams` VALUES ('CTET (పేపర్ I & II),కేవీఎస్( KVS), ఎన్విఎస్(NVS), ఎస్టెట్(STET)','రక్షణ శాఖ ','CTET','TELUGU',308,'0000-00-00 00:00:00','0000-00-00 00:00:00');
INSERT INTO `exams` VALUES ('এনডিএ, CDS গুলি ও AFCAT','প্রতিরক্ষা','DEFENCE','BENGALI',401,'0000-00-00 00:00:00','0000-00-00 00:00:00');
INSERT INTO `exams` VALUES ('NDA, CDS & AFCAT','DEFENCE','DEFENCE','ENGLISH',402,'0000-00-00 00:00:00','0000-00-00 00:00:00');
INSERT INTO `exams` VALUES ('एनडीए, सीडीएस और AFCAT','डिफेंस','DEFENCE','HINDI',403,'0000-00-00 00:00:00','0000-00-00 00:00:00');
INSERT INTO `exams` VALUES ('ಎನ್ಡಿಎ, ಸಿಡಿಎಸ್ & AFCAT','പ്രതിരോധ','DEFENCE','KANNADA',404,'0000-00-00 00:00:00','0000-00-00 00:00:00');
INSERT INTO `exams` VALUES ('എൻഡിഎ, സി.ഡി.എസ് & എ ഫ് സി എ ടി ','പ്രതിരോധം','DEFENCE','MALYALAM',405,'0000-00-00 00:00:00','0000-00-00 00:00:00');
INSERT INTO `exams` VALUES ('एनडीए, CDs आणि AFCAT','संरक्षण','DEFENCE','MARATHI',406,'0000-00-00 00:00:00','0000-00-00 00:00:00');
INSERT INTO `exams` VALUES ('என்டிஏ, சிடிஎஸ் & AFCAT','பாதுகாப்பு','DEFENCE','TAMIL',407,'0000-00-00 00:00:00','0000-00-00 00:00:00');
INSERT INTO `exams` VALUES ('ఎన్డిఎ, సిడిఎస్(CDS) &ఎఫ్కాట్ (AFCAT)','రక్షణ','DEFENCE','TELUGU',408,'0000-00-00 00:00:00','0000-00-00 00:00:00');
INSERT INTO `exams` VALUES ('RRB জে এসএসসি জে, ইসরো, DMRC ও অন্যান্য','Engg পরীক্ষা','ENGINEERING','BENGALI',601,'0000-00-00 00:00:00','0000-00-00 00:00:00');
INSERT INTO `exams` VALUES ('RRB JE, SSC JE, ISRO, DMRC & Others','ENGG EXAM','ENGINEERING','ENGLISH',602,'0000-00-00 00:00:00','0000-00-00 00:00:00');
INSERT INTO `exams` VALUES ('आरआरबी जेई, एसएससी जेई, इसरो, डीएमआरसी और अन्य','इंजीनियरिंग परीक्षा','ENGINEERING','HINDI',603,'0000-00-00 00:00:00','0000-00-00 00:00:00');
INSERT INTO `exams` VALUES ('RRB ಜೆಇ, ಎಸ್ಎಸ್ಸಿ ಜೆಇ, ಇಸ್ರೋ, DMRC & ಇತರೆ','ಇಂಜಿನಿಯರಿಂಗ್ ಪರೀಕ್ಷೆ','ENGINEERING','KANNADA',604,'0000-00-00 00:00:00','0000-00-00 00:00:00');
INSERT INTO `exams` VALUES ('.മഹാരാഷ്ട്ര JE, എസ്.എസ്.സി. JE, ഐഎസ്ആർഒ, മെട്രോ, മറ്റുള്ളവ','എൻജിനീയറിങ് പരീക്ഷ','ENGINEERING','MALYALAM',605,'0000-00-00 00:00:00','0000-00-00 00:00:00');
INSERT INTO `exams` VALUES ('रेल्वे भरती महामंडळ, जेरॉम दहावीचा जेरॉम, इस्रो, .प्रकल्प आणि इतर','अभियांत्रिकी परीक्षा','ENGINEERING','MARATHI',606,'0000-00-00 00:00:00','0000-00-00 00:00:00');
INSERT INTO `exams` VALUES ('ஆர்ஆர்பி ஜெஇ, எஸ்எஸ்சி ஜெஇ, இஸ்ரோ, மெட்ரோ ரயில் & பலர்','Engg தேர்வு','ENGINEERING','TAMIL',607,'0000-00-00 00:00:00','0000-00-00 00:00:00');
INSERT INTO `exams` VALUES ('ఆర్ఆర్బీ JE, ఎస్ఎస్సి JE, ఇస్రో, DMRC & ఇతరులు','ఇంజనీరింగు పరీక్షలో','ENGINEERING','TELUGU',608,'0000-00-00 00:00:00','0000-00-00 00:00:00');
INSERT INTO `exams` VALUES ('RRB জে, ALP / প্রযুক্তিবিদ, গ্রুপ ডি, এনটিপিসি, DMRC','রেল','RAILWAYS','BENGALI',501,'0000-00-00 00:00:00','0000-00-00 00:00:00');
INSERT INTO `exams` VALUES ('RRB JE, ALP/Technician, Group D, NTPC, DMRC','RAILWAYS','RAILWAYS','ENGLISH',502,'0000-00-00 00:00:00','0000-00-00 00:00:00');
INSERT INTO `exams` VALUES ('आरआरबी जेई, एएलपी / तकनीशियन, ग्रुप डी, एनटीपीसी, डीएमआरसी','रेलवे','RAILWAYS','HINDI',503,'0000-00-00 00:00:00','0000-00-00 00:00:00');
INSERT INTO `exams` VALUES ('RRB ಜೆಇ, ಎಎಲ್ಪಿ / ತಂತ್ರಜ್ಞ, ಗುಂಪು ಡಿ, ಎನ್ಟಿಪಿಸಿ, DMRC','ರೈಲ್ವೇಸ್','RAILWAYS','KANNADA',504,'0000-00-00 00:00:00','0000-00-00 00:00:00');
INSERT INTO `exams` VALUES ('ആർ‌ആർ‌ബി ജെ‌ഇ, എ‌എൽ‌പി / ടെക്നീഷ്യൻ, ഗ്രൂപ്പ് ഡി, എൻ‌ടി‌പി‌സി, ഡി‌എം‌ആർ‌സി','റെയിൽവേ','RAILWAYS','MALYALAM',505,'0000-00-00 00:00:00','0000-00-00 00:00:00');
INSERT INTO `exams` VALUES ('रेल्वे भरती महामंडळ, जेरॉम, डोंगर / तंत्रज्ञ, गट D, एनटीपीसी, .प्रकल्प','रेल्वे','RAILWAYS','MARATHI',506,'0000-00-00 00:00:00','0000-00-00 00:00:00');
INSERT INTO `exams` VALUES ('ஆர்ஆர்பி ஜெஇ, ஆஸ்திரேலிய தொழிற்கட்சி / தொழில்நுட்பவியலாளர் குழு டி, என்.டி.பி.சி, மெட்ரோ ரயில்','ரயில்','RAILWAYS','TAMIL',507,'0000-00-00 00:00:00','0000-00-00 00:00:00');
INSERT INTO `exams` VALUES ('ఆర్ఆర్బీ జెఈ (JE), ఏఎల్పి (ALP), టెక్నీషియన్, గ్రూప్ డి, ఎన్టిపిసి,డిఎంఆర్ సి(DMRC)','రైల్వే','RAILWAYS','TELUGU',508,'0000-00-00 00:00:00','0000-00-00 00:00:00');
INSERT INTO `exams` VALUES ('CGL (টিয়ার আমি & দ্বিতীয়), সিপিও এলডিসি','এসএসসি','SSC','BENGALI',201,'0000-00-00 00:00:00','0000-00-00 00:00:00');
INSERT INTO `exams` VALUES ('CGL (Tier I & II), CPO, LDC','SSC','SSC','ENGLISH',202,'0000-00-00 00:00:00','0000-00-00 00:00:00');
INSERT INTO `exams` VALUES ('CGL (टीयर I & II), सीपीओ, एलडीसी','एसएससी','SSC','HINDI',203,'0000-00-00 00:00:00','0000-00-00 00:00:00');
INSERT INTO `exams` VALUES ('CGL (ಶ್ರೇಣಿ I ಮತ್ತು II), CPO, LDC','എസ്.എസ്.സി.','SSC','KANNADA',204,'0000-00-00 00:00:00','0000-00-00 00:00:00');
INSERT INTO `exams` VALUES ('ച്ഗ്ല് (ടയർ ഞാൻ & രണ്ടാം), ച്പൊ, ല്ദ്ച്','എസ്.എസ്.സി.','SSC','MALYALAM',205,'0000-00-00 00:00:00','0000-00-00 00:00:00');
INSERT INTO `exams` VALUES ('CGL (टायर मी दोन), CPO, LDC','एसएससी','SSC','MARATHI',206,'0000-00-00 00:00:00','0000-00-00 00:00:00');
INSERT INTO `exams` VALUES ('CGL (அடுக்கு நான் & II) சி.பி.ஒ, LDC','எஸ்எஸ்சி','SSC','TAMIL',207,'0000-00-00 00:00:00','0000-00-00 00:00:00');
INSERT INTO `exams` VALUES ('సిజిఎల్ (CGL) (టైర్ I & II), సిపిఒ (CPO), ఎల్డీసీ','ఎస్ ఎస్ సి ','SSC','TELUGU',208,'0000-00-00 00:00:00','0000-00-00 00:00:00');
/*!40000 ALTER TABLE `exams` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-03-18  0:26:37
