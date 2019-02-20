-- MySQL dump 10.13  Distrib 5.7.18, for Win64 (x86_64)
--
-- Host: localhost    Database: seam
-- ------------------------------------------------------
-- Server version	5.7.18-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `album`
--

DROP TABLE IF EXISTS `album`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `album` (
  `album_no` varchar(10) NOT NULL,
  `nation_no` varchar(3) NOT NULL,
  `name` text NOT NULL,
  `artist_no` text NOT NULL,
  `release_date` date NOT NULL,
  `release_com` text NOT NULL,
  `agency` text,
  `albumart` text,
  `intro` text,
  PRIMARY KEY (`album_no`),
  KEY `nation_no` (`nation_no`),
  CONSTRAINT `album_ibfk_1` FOREIGN KEY (`nation_no`) REFERENCES `nation` (`nation_no`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `album`
--

LOCK TABLES `album` WRITE;
/*!40000 ALTER TABLE `album` DISABLE KEYS */;
INSERT INTO `album` VALUES ('0000000001','001','I am A Dreamer','000002','2016-10-03','(주)로엔엔터테인먼트','(주)글러브엔터테인먼트,젤리피쉬엔터테인먼트(주)','image/album_image/0000000001.jpg',NULL),('0000000002','001','The 3rd Digital Single \'그대라는 사치\'','000005','2016-08-24','(주)로엔엔터테인먼트','플레디스엔터테인먼트','image/album_image/0000000002.jpg',NULL),('0000000003','001','Full Album RED PLANET','000003','2016-08-29','벅스','쇼파르뮤직','image/album_image/0000000003.jpg',NULL),('0000000004','001','I\'M','000004','2016-09-06','(주)인터파크','NH EMG','image/album_image/0000000004.jpg',NULL),('0000000005','001','The 1st Digital Single `이 소설의 끝을 다시 써보려 해`','000005','2014-09-30','(주)로엔엔터테인먼트','플레디스','image/album_image/0000000005.jpg',NULL),('0000000006','001','Russian Roulette - The 3rd Mini Album','000006','2016-09-07','(주)KT뮤직','(주)SM엔터테인먼트','image/album_image/0000000006.jpg',NULL),('0000000007','001','Dancing King','000007,000008','2016-09-17','(주)KT뮤직','(주)SM엔터테인먼트','image/album_image/0000000007.jpg',NULL),('0000000008','001','구르미 그린 달빛 OST Part.3','000009','2016-09-06','벅스','오우엔터테인먼트','image/album_image/0000000008.jpg',NULL),('0000000009','001','목요일 밤','000010','2016-08-25','(주)로엔엔터테인먼트','(주)메이크어스엔터테인먼트','image/album_image/0000000009.jpg','\'어반자카파\'와 \'빈지노\'의 스페셜 콜라보레이션\n평범한 일상에 지친 목요일 밤을 위한 경쾌/상쾌/달콤한 위로와 희망의 노래\n\n대한민국 감성 음악의 대표 주자 \'어반자카파(URBAN ZAKAPA)\'가 지루한 일상에 상쾌한 활력소가 되어줄 경쾌한 싱글 [목요일 밤]을 깜짝 발표한다.\n\n지난 5월, 1년여만에 발표한 EP [STILL]의 발라드 타이틀 \'널 사랑하지 않아\'가 발표와 동시에 음악차트 \'올킬\'을 기록하고, 이후 3달여가 지난 지금까지 10위권안에 랭크되고 있는 등 \'믿고듣는\' 국민 감성 그룹으로 거듭난 \'어반자카파\'가 싱글 \'목요일 밤\'을 발표하며, 어느 때보다 뜨거운 올 여름의 끝을 장식한다. \'목요일 밤\'은 \'어반자카파\'의 홍일점이자 천부적인 음악적 재능을 펼치고 있는 \'조현아\'가 작사, 작곡, 편곡까지 총프로듀싱한 곡으로, \'어반자카파\'의 오랜 음악적 동료이자 절친인 래퍼 \'빈지노(Beenzino)\'가 랩피쳐링으로 참여해 리스너들에게 반가운 선물이 될 스페셜 트랙이다. \'어반자카파\'와 \'빈지노\'의 스페셜 콜라보레이션\n평범한 일상에 지친 목요일 밤을 위한 경쾌/상쾌/달콤한 위로와 희망의 노래\n\n대한민국 감성 음악의 대표 주자 \'어반자카파(URBAN ZAKAPA)\'가 지루한 일상에 상쾌한 활력소가 되어줄 경쾌한 싱글 [목요일 밤]을 깜짝 발표한다.\n\n지난 5월, 1년여만에 발표한 EP [STILL]의 발라드 타이틀 \'널 사랑하지 않아\'가 발표와 동시에 음악차트 \'올킬\'을 기록하고, 이후 3달여가 지난 지금까지 10위권안에 랭크되고 있는 등 \'믿고듣는\' 국민 감성 그룹으로 거듭난 \'어반자카파\'가 싱글 \'목요일 밤\'을 발표하며, 어느 때보다 뜨거운 올 여름의 끝을 장식한다. \'목요일 밤\'은 \'어반자카파\'의 홍일점이자 천부적인 음악적 재능을 펼치고 있는 \'조현아\'가 작사, 작곡, 편곡까지 총프로듀싱한 곡으로, \'어반자카파\'의 오랜 음악적 동료이자 절친인 래퍼 \'빈지노(Beenzino)\'가 랩피쳐링으로 참여해 리스너들에게 반가운 선물이 될 스페셜 트랙이다.'),('0000000010','001','구르미 그린 달빛 OST Part.5','000011','2016-09-14','벅스','오우엔터테인먼트','image/album_image/0000000010.jpg',NULL),('0000000011','001','구르미 그린 달빛 OST Part.8','000042','2016-09-27','벅스','오우엔터테인먼트','image/album_image/0000000011.jpg',NULL),('0000000012','001','또 다시 사랑','000004','2015-09-22','CJ E&M MUSIC','엔에이취이엠쥐','image/album_image/0000000012.jpg',NULL),('0000000013','001','Pink Revolution','000012','2016-09-26','(주)로엔엔터테인먼트','플랜에이 엔터테인먼트','image/album_image/0000000013.jpg',NULL),('0000000014','001','130 mood : TRBL','000041','2016-03-24','Universal Music','Joombas Co Ltd. & Universal Music Ltd.','image/album_image/0000000014.jpg',NULL),('0000000015','001','If You','000013','2016-08-23','(주)로엔엔터테인먼트','YMC엔터테인먼트','image/album_image/0000000015.jpg',NULL),('0000000016','001','또 오해영 OST Part.5','000040','2016-05-31','CJ E&M MUSIC','CJ E&M','image/album_image/0000000016.jpg',NULL),('0000000017','001','함부로 애틋하게 OST Part.9','000039','2016-08-04','(주)로엔엔터테인먼트','삼화네트웍스, iHQ, (주)가지컨텐츠','image/album_image/0000000017.jpg',NULL),('0000000018','001','SQUARE ONE','000014','2016-08-08','(주)KT뮤직','(주)YG엔터테인먼트','image/album_image/0000000018.jpg',NULL),('0000000019','001','여름밤엔 우리','000038','2016-08-03','(주)로엔엔터테인먼트','본(born)','image/album_image/0000000019.jpg',NULL),('0000000020','001','INFINITE ONLY','000015','2016-09-19','(주)로엔엔터테인먼트','울림 엔터테인먼트','image/album_image/0000000020.jpg',NULL),('0000000021','001','NEW YORK','000037','2016-09-21','CJ E&M MUSIC','(주)RBW,CJ E&M MUSIC','image/album_image/0000000021.jpg',NULL),('0000000022','001','Why So Lonely','000036','2016-07-05','(주)KT뮤직','(주)JYP엔터테인먼트','image/album_image/0000000022.jpg',NULL),('0000000023','001','돌아오지마','000016','2016-04-14','CJ E&M MUSIC','CJ E&M','image/album_image/0000000023.jpg',NULL),('0000000024','001','And July','000016','2016-07-18','CJ E&M MUSIC','CJ E&M','image/album_image/0000000024.jpg',NULL),('0000000025','001','Puzzle','000017,000022','2016-08-11','(주)로엔엔터테인먼트','린치핀뮤직(주)','image/album_image/0000000025.jpg',NULL),('0000000026','001','쇼미더머니 5 Episode 3','000022,000050','2016-07-02','CJ E&M MUSIC','CJ E&M','image/album_image/0000000026.jpg',NULL),('0000000027','001','네 생각','000018','2016-07-15','(주)로엔엔터테인먼트','뮤직팜','image/album_image/0000000027.jpg',NULL),('0000000028','001','구르미 그린 달빛 OST Part.4','000035','2016-09-13','벅스','오우엔터테인먼트','image/album_image/0000000028.jpg',NULL),('0000000029','001','LOTTO - The 3rd Album Repackage','000008','2016-08-18','(주)KT뮤직','(주)SM엔터테인먼트','image/album_image/0000000029.jpg',NULL),('0000000030','001','PAGE TWO','000034','2016-04-24','(주)KT뮤직','(주)JYP엔터테인먼트','image/album_image/0000000030.jpg',NULL),('0000000031','001','구르미 그린 달빛 OST Part.1','000033,000027','2016-08-23','벅스','오우엔터테인먼트','image/album_image/0000000031.jpg',NULL),('0000000032','001','달의 연인 - 보보경심 려 OST Part.1','000021,000024,000025','2016-08-25','CJ E&M','CJ E&M Music, 냠냠 Ent, SM Ent','image/album_image/0000000032.jpg',NULL),('0000000033','001','여자친구 The 1st Album \'LOL\'','000030','2016-07-11','(주)로엔엔터테인먼트','쏘스뮤직','image/album_image/0000000033.jpg',NULL),('0000000034','001','8','000029','2016-09-29','Universal Music','호기심엔터테인먼트','image/album_image/0000000034.jpg',NULL),('0000000035','001','스틸','000010','2016-05-27','(주)로엔엔터테인먼트','(주)메이크어스엔터테인먼트','image/album_image/0000000035.jpg',NULL),('0000000036','001','쇼미더머니 5 Episode 4','000108,000022','2016-07-09','CJ E&M MUSIC','CJ E&M','image/album_image/0000000036.jpg',NULL),('0000000037','001','구르미 그린 달빛 OST Part.9','000026','2016-09-28','벅스','오우엔터테인먼트','image/album_image/0000000037.jpg',NULL),('0000000038','001','빈티지박스 Vol.1','000028,000031','2016-09-23','(주)로엔엔터테인먼트','스타쉽 엔터테인먼트','image/album_image/0000000038.jpg',NULL),('0000000039','001','너만이','000027','2016-09-27','(주)로엔엔터테인먼트','스타쉽 엔터테인먼트','image/album_image/0000000039.jpg',NULL);
/*!40000 ALTER TABLE `album` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `artist`
--

DROP TABLE IF EXISTS `artist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `artist` (
  `artist_no` varchar(6) NOT NULL,
  `nation_no` varchar(3) NOT NULL,
  `name` text NOT NULL,
  `group_name` text,
  `debut_year` varchar(4) DEFAULT NULL,
  `profile_image` text,
  `job` text NOT NULL,
  `gender` enum('남','여','혼성') DEFAULT NULL,
  `agency` text,
  `position` text,
  PRIMARY KEY (`artist_no`),
  KEY `nation_no` (`nation_no`),
  CONSTRAINT `artist_ibfk_1` FOREIGN KEY (`nation_no`) REFERENCES `nation` (`nation_no`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `artist`
--

LOCK TABLES `artist` WRITE;
/*!40000 ALTER TABLE `artist` DISABLE KEYS */;
INSERT INTO `artist` VALUES ('000001','001','빅뱅 (BigBang)','','2006','image/artist/000001.jpg','가수','남','YG 엔터테인먼트','-'),('000002','001','박효신','','1999','image/artist/000002.jpg','가수','남','글러브엔터테인먼트',''),('000003','001','볼빨간사춘기','','2016','image/artist/000003.jpg','가수','여','쇼파르뮤직','-'),('000004','001','임창정','','1995','image/artist/000004.jpg','영화배우,가수','남','NH EMG',''),('000005','001','한동근','','2014','image/artist/000005.jpg','가수','남','플레디스',''),('000006','001','레드벨벳 (Red Velvet)','','2014','image/artist/000006.jpg','가수','여','SM엔터테인먼트','-'),('000007','001','유재석','','2006','image/artist/000007.jpg','MC,개그맨','남','FNC엔터테인먼트',''),('000008','001','EXO','','2012','image/artist/000008.jpg','가수','남','SM엔터테인먼트','-'),('000009','001','거미','','2003','image/artist/000009.jpg','가수','여','씨제스 엔터테인먼트',''),('000010','001','어반자카파 (URBAN ZAKAPA)','','2009','image/artist/000010.jpg','가수','혼성','메이크어스엔터테인먼트','-'),('000011','001','성시경','','2000','image/artist/000011.jpg','가수','남','젤리피쉬엔터테인먼트',''),('000012','001','에이핑크 (Apink)','','2011','image/artist/000012.jpg','가수','여','플랜에이엔터테인먼트','-'),('000013','001','에일리 (Ailee)','','2012','image/artist/000013.jpg','가수','여','YMC엔터테인먼트',''),('000014','001','블랙핑크 (BLACKPINK)','','2016','image/artist/000014.jpg','가수','여','YG 엔터테인먼트','-'),('000015','001','인피니트 (INFINITE)','','2010','image/artist/000015.jpg','가수','남','울림엔터테인먼트','-'),('000016','001','헤이즈 (Heize)','','2014','image/artist/000016.jpg','가수','여','',''),('000017','001','씨잼 (C Jamm)','','2013','image/artist/000017.jpg','가수','남','Just Music Ent',''),('000018','001','존 박 (John Park)','','2010','image/artist/000018.jpg','가수','남','뮤직팜',''),('000019','001','EXO-M','','2012','image/artist/000019.jpg','가수','남','SM엔터테인먼트','-'),('000020','001','EXO-CBX','','2016','image/artist/000020.jpg','가수','남','SM엔터테인먼트','-'),('000021','001','첸 (CHEN)','000008,000019,000020','2012','image/artist/000021.jpg','가수,뮤지컬배우','남','SM엔터테인먼트','메인보컬'),('000022','001','비와이 (BewhY)','','2014','image/artist/000022.jpg','가수','남','',''),('000023','001','EXO-K','','2012','image/artist/000023.jpg','가수','남','SM엔터테인먼트','-'),('000024','001','백현 (HAEK HYUN)','000008,000023,000020','2012','image/artist/000024.jpg','가수,탤런트','남','SM엔터테인먼트','메인보컬'),('000025','001','시우민 (XIUMIN)','000008,000019,000020','2012','image/artist/000025.jpg','가수,탤런트','남','SM엔터테인먼트','서브보컬,서브래퍼'),('000026','001','백지영','','1999','image/artist/000026.jpg','가수','여','뮤직웍스',''),('000027','001','유승우','','2012','image/artist/000027.jpg','가수','남','스타쉽엔터테인먼트',''),('000028','001','케이윌 (K. will)','','2005','image/artist/000028.jpg','가수','남','스타쉽 엔터테인먼트',''),('000029','001','화요비','','2000','image/artist/000029.jpg','가수','여','호기심엔터테인먼트',''),('000030','001','여자친구','','2015','image/artist/000030.jpg','가수','여','쏘스뮤직','-'),('000031','001','매드클라운 (Mad Clown)','','2008','image/artist/000031.jpg','가수','남','스타쉽 엑스',''),('000032','001','씨스타 (SISTAR)','','2010','image/artist/000032.jpg','가수','여','스타쉽 엔터테인먼트','-'),('000033','001','소유','000032','2010','image/artist/000033.jpg','가수','여','스타쉽 엔터테인먼트','서브보컬'),('000034','001','트와이스 (TWICE)','','2015','image/artist/000034.jpg','가수','여','JYP엔터테인먼트','-'),('000035','001','벤','','2010','image/artist/000035.jpg','가수','여','더바이브',''),('000036','001','원더걸스 (Wonder Girls)','','2007','image/artist/000036.jpg','가수','여','JYP엔터테인먼트','-'),('000037','001','마마무 (MAMAMOO)','','2014','image/artist/000037.jpg','가수','여','RBW','-'),('000038','001','스탠딩 에그','','2010','image/artist/000038.png','가수','남','본엔터테인먼트','-'),('000039','001','김범수','','1999','image/artist/000039.jpg','가수','남','일광폴라리스 엔터테인먼트',''),('000040','001','정승환','','2014','image/artist/000040.jpg','가수','남','안테나',''),('000041','001','딘 (DEAN)','','2015','image/artist/000041.jpg','가수','남','줌바스뮤직그룹,유니버설뮤직',''),('000042','001','베이지 (Beige)','','2007','image/artist/000042.jpg','가수','여','',''),('000043','001','다비치 (Davichi)','','2008','image/artist/000043.jpg','가수','여','CJ E&M(CJ E&M MUSIC),B2M 엔터테인먼트','-'),('000044','001','엠씨 더 맥스 (M.C The Max)','','2000','image/artist/000044.jpg','가수','남','','-'),('000045','001','정준일','','2011','image/artist/000045.jpg','가수','남','엠와이뮤직',''),('000046','001','에픽하이 (Epik High)','','2003','image/artist/000046.jpg','가수','남','YG 엔터테인먼트','-'),('000047','001','김영근','','0000','image/artist/000047.png','화제의 인물','남','',''),('000048','001','정준영','','2010','image/artist/000048.jpg','가수','남','C9엔터테인먼트',''),('000049','001','리듬파워 (방사능)','','2009','image/artist/000049.jpg','가수','남','아메바컬쳐','-'),('000050','001','보이 비 (Boi B)','000049','2009','image/artist/000050.jpg','가수','남','아메바컬쳐','래퍼'),('000051','001','김이나','','9999','image/artist/000051.jpg','작사가','여','미스틱엔터테인먼트',''),('000052','001','정재일','','1999','image/artist/000052.jpg','가수','남','',''),('000053','001','안지영','000003','2016','image/artist/000053.jpg','가수','여','쇼파르뮤직','보컬'),('000054','001','바닐라 어쿠스틱 (Vanilla Acoustic)','','2008','image/artist/000054.jpg','가수','혼성','쇼파르뮤직','-'),('000055','001','바닐라맨','000054','2008','image/artist/000055.jpg','가수,작곡가','남','쇼파르뮤직','리더,작곡가,작사가'),('000056','001','우지윤','000003','2016','image/artist/000056.jpg','가수','여','쇼파르뮤직','기타,베이스,서브보컬,랩'),('000057','001','멧돼지','','9999','image/artist/000057.jpg','작곡가','남','',''),('000058','001','제피 (Xepy)','','9999','image/artist/000058.png','작사가,작곡가,프로듀서','남','브랜뉴뮤직',''),('000059','001','BNR (Brand New Radio)','','2010','image/artist/000059.jpg','가수','남','','-'),('000060','001','마스터키 (MasterKey)','000059','9999','image/artist/000060.jpg','작곡가','남','',''),('000061','001','조윤경','','9999','image/artist/000061.png','작사가','여','',''),('000062','001','SAFARI M','','9999','image/artist/000062.png','작곡가','남','',''),('000063','001','Cien','','9999','image/artist/000063.png','작곡가,편곡가','남','',''),('000064','001','라이머 (Rhymer)','','1996','image/artist/000064.jpg','음악PD,가수','남','브랜뉴뮤직(대표)',''),('000065','001','제이큐 (JQ)','','2007','image/artist/000065.jpg','가수,작곡가','남','',''),('000066','001','장여진','','9999','image/artist/000066.jpg','작사가','여','',''),('000067','001','개미','','9999','image/artist/000067.jpg','작곡가,음악감독','남','오우엔터테인먼트',''),('000068','001','재니팩트 (Jazzyfact)','','2010','image/artist/000068.png','가수','남','','-'),('000069','001','빈지노 (Beenzino)','000068','2009','image/artist/000069.jpg','가수','남','일리네어 레코즈',''),('000070','001','조현아','000010','2009','image/artist/000070.jpg','가수,음악PD','여','메이크어스엔터테인먼트',''),('000071','001','아이콘 (iKON)','','2015','image/artist/000071.jpg','가수','남','YG엔터테인먼트','-'),('000072','001','MOBB','','2016','image/artist/000072.jpg','가수','남','YG엔터테인먼트','-'),('000073','001','바비 (BOBBY)','000071,000072','2015','image/artist/000073.jpg','가수','남','YG엔터테인먼트','랩'),('000074','001','비투비-블루 (BTOB)','','2016','image/artist/000074.jpg','가수','남','큐브엔터테인먼트','-'),('000075','001','양다일','','2015','image/artist/000075.jpg','가수','남','브랜뉴뮤직',''),('000076','001','권진아','','2014','image/artist/000076.jpg','가수','여','안테나',''),('000077','001','효린','000032','2010','image/artist/000077.jpg','가수','여','스타쉽 엔터테인먼트','리더,메인보컬'),('000078','001','플라이 투 더 스카이 (FLY TO THE SKY)','','1999','image/artist/000078.jpg','가수','남','에이치투미디어','-'),('000079','001','슈프림팀 (Supreme Team)','','2009','image/artist/000079.jpg','가수','남','','-'),('000080','001','사이먼 도미닉 (Simon Dominic)','000079','2009','image/artist/000080.jpg','가수','남','AOMG','랩'),('000081','001','환희','000078','1999','image/artist/000081.jpg','가수','남','에이치투미디어','보컬'),('000082','001','원펀치 (1PUNCH)','','2015','image/artist/000082.jpg','가수','남','브레이브 엔터테인먼트','-'),('000083','001','1','000082','2015','image/artist/000083.jpg','가수','남','YG엔터테인먼트','리더,랩'),('000084','001','슈퍼비 (Superbee)','','2015','image/artist/000084.jpg','가수','남','',''),('000085','001','지투','','2014','image/artist/000085.jpg','가수','남','하이라이트레코즈',''),('000086','001','허각','','2010','image/artist/000086.jpg','가수','남','플랜에이엔터테인먼트',''),('000087','001','형돈이와 대준이','','2012','image/artist/000087.jpg','가수','남','','-'),('000088','001','GOT7','','2014','image/artist/000088.jpg','가수','남','JYP엔터테인먼트','-'),('000089','001','정은지','000012','2011','image/artist/000089.jpg','가수,탤런트','여','플랜에이엔터테인먼트','메인보컬'),('000090','001','백아연 (A Yeon Baek)','','2012','image/artist/000090.jpg','가수','여','JYP엔터테인먼트',''),('000091','001','십센치 (10CM)','','2010','image/artist/000091.jpg','가수','남','매직스트로베리사운드','-'),('000092','001','브라운 아이드 걸스 (Brown Eyed Girls)','','2006','image/artist/000092.jpg','가수','여','미스틱엔터테인먼트(에이팝엔터테인먼트)','-'),('000093','001','가인','000092','2006','image/artist/000093.jpg','가수','여','미스틱엔터테인먼트(에이팝엔터테인먼트)','보컬'),('000094','001','패닉 (Panic)','','1995','image/artist/000094.jpg','가수','남','','-'),('000095','001','위너 (WINNER)','','2014','image/artist/000095.jpg','가수','남','YG엔터테인먼트','-'),('000096','001','긱스 (Gigs)','','1999','image/artist/000096.png','가수','남','','-'),('000097','001','카니발 (Carnival)','','1997','image/artist/000097.jpg','가수','남','','-'),('000098','001','송민호 (MINO)','000095,000072','2011','image/artist/000098.jpg','가수','남','YG엔터테인먼트','래퍼'),('000099','001','이적','000094,000096,000097','1995','image/artist/000099.jpg','가수','남','뮤직팜','보컬'),('000100','001','방탄소년단','','2013','image/artist/000100.jpg','가수','남','빅히트 엔터테인먼트','-'),('000101','001','크러쉬 (Crush)','','2012','image/artist/000101.jpg','가수','남','아메바컬쳐',''),('000102','001','피프틴앤드 (15&)','','2012','image/artist/000102.jpg','가수','여','JYP엔터테인먼트','-'),('000103','001','그레이 (Gray)','','2012','image/artist/000103.jpg','가수,음악PD','남','AOMG',''),('000104','001','백예린','000102','2012','image/artist/000104.jpg','가수','여','JYP엔터테인먼트',''),('000105','001','엄지','000030','2015','image/artist/000105.jpg','가수','여','쏘스뮤직','서브보컬'),('000106','001','아이오아이 (I.O.I)','','2016','image/artist/000106.jpg','가수','여','YMC엔터테인먼트','-'),('000107','001','펀치 (PUNCH)','','2014','image/artist/000107.jpg','가수','여','냠냠 엔터테인먼트',''),('000108','001','샵건','','2016','image/artist/000108.jpg','가수','남','스타쉽 엔터테인먼트',''),('000109','001','로꼬 (Loco)','','2012','image/artist/000109.jpg','가수','남','AOMG',''),('000110','001','블락비 (Block B)','','2011','image/artist/000110.jpg','가수','남','세븐시즌스','-'),('000111','001','박경 (Kyung Park)','000110','2011','image/artist/000111.jpg','가수,작사가','남','세븐시즌스','리드래퍼'),('000112','002','저스틴 비버 (Justin Bieber)','','2009','image/artist/000112.jpg','가수','남','아일랜드레코드',''),('000113','001','소녀시대','','2007','image/artist/000113.jpg','가수','여','SM엔터테인먼트','-'),('000114','001','비스트 (BEAST)','','2009','image/artist/000114.jpg','가수 ','남','큐브엔터테인먼트','-'),('000115','001','소녀시대-태티서','','2012','image/artist/000115.jpg','가수','여','SM엔터테인먼트','-'),('000116','001','에스엠 더 발라드 (S.M. THE BALLAD)','','2010','image/artist/000116.jpg','가수','혼성','SM엔터테인먼트','-'),('000117','001','SG워너비 (SG WANNABE)','','2004','image/artist/000117.jpg','가수','남','CJ E&M(CJ E&M MUSIC),B2M 엔터테인먼트','-'),('000118','001','태연','000113,000115,000116','2007','image/artist/000118.jpg','가수,뮤지컬배우','여','SM엔터테인먼트','리더,메인보컬'),('000119','001','이하이','','2012','image/artist/000119.jpg','가수','여','YG엔터테인먼트',''),('000120','003','샘 스미스 (Sam Smith)','','2013','image/artist/000120.jpg','가수','남','','');
/*!40000 ALTER TABLE `artist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `member`
--

DROP TABLE IF EXISTS `member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `member` (
  `id` varchar(20) NOT NULL,
  `passwd` varchar(20) NOT NULL,
  `name` text NOT NULL,
  `nickname` varchar(10) NOT NULL,
  `email` varchar(50) NOT NULL,
  `phone` varchar(13) NOT NULL,
  `profile_image` text,
  `birth` varchar(8) DEFAULT NULL,
  `gender` enum('남','여') DEFAULT NULL,
  `job` text,
  `hometown` varchar(15) DEFAULT NULL,
  `interest` text,
  `intro` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `phone` (`phone`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `member`
--

LOCK TABLES `member` WRITE;
/*!40000 ALTER TABLE `member` DISABLE KEYS */;
INSERT INTO `member` VALUES ('root','rootpass','관리자','관리자','root@seam.co.kr','010-0000-0000',NULL,NULL,NULL,NULL,NULL,NULL,'관리자입니다.'),('testid','testpass','박문수','박명수','abc@naver.com','010-1234-5678','image/member/testid.jpg','16910815','남','암행어사','경상북도 고령군','비',NULL),('testid2','testpass','이순신','충무공','abc@google.com','010-1234-8888','image/member/testid2.jpg','15450418','남','장군','서울특별시 중구 인현동','바다',NULL);
/*!40000 ALTER TABLE `member` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `music`
--

DROP TABLE IF EXISTS `music`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `music` (
  `music_no` varchar(11) NOT NULL,
  `nation_no` varchar(3) NOT NULL,
  `name` text NOT NULL,
  `artist_no` text NOT NULL,
  `song_writer` text,
  `lyric_writer` text,
  `album_no` varchar(10) DEFAULT NULL,
  `albumart` text,
  `lyrics` text,
  `genre` varchar(50) DEFAULT NULL,
  `release_date` date DEFAULT NULL,
  `track` int(3) NOT NULL,
  `tag` text,
  `time` int(4) NOT NULL,
  `isTitle` enum('true','false') DEFAULT NULL,
  `isAdult` enum('true','false') DEFAULT NULL,
  PRIMARY KEY (`music_no`),
  KEY `nation_no` (`nation_no`),
  KEY `album_no` (`album_no`),
  CONSTRAINT `music_ibfk_1` FOREIGN KEY (`nation_no`) REFERENCES `nation` (`nation_no`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `music_ibfk_2` FOREIGN KEY (`album_no`) REFERENCES `album` (`album_no`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `music`
--

LOCK TABLES `music` WRITE;
/*!40000 ALTER TABLE `music` DISABLE KEYS */;
INSERT INTO `music` VALUES ('201409_0001','001','이 소설의 끝을 다시 써보려 해','000005','000058,000060','000058','0000000005','image/albumart/201409_0001.jpg','시계가 반대로 돌아가고 있어\nTV속 영화가 되감아지고 있어\n내렸던 빗물이 올라가고 있어\n잊었던 기억이 돌아오고 있어\n도로 위에 차들이 반대로 달리고\n온 세상의 모든 게 다 거꾸로 움직여\n지금 나는 계속 반대로 뒷걸음질 치며\n그날의 너에게 돌아가고 있어\n\n운명 같은 만남 너무 아픈 결말\n난 이 소설의 끝을 다시 써보려 해\n내 한 권의 사랑 마지막 장면엔\n니가 있어야 해 그래야 말이 되니까\n\n한 장씩 한 장씩 뒤로 넘겨 지며\n아팠던 일기가 지워지고 있어\n가루 낸 사진이 모여들고 있어\n버렸던 미련이 돌아오고 있어\n삼켰던 내 눈물이 다시 뱉어지고\n뱉었던 그 모진 말은 다시 삼켜지고\n지금 나는 계속 반대로 뒷걸음질 치며\n그날의 너에게 돌아가고 있어\n\n운명 같은 만남 너무 아픈 결말\n난 이 소설의 끝을 다시 써보려 해\n내 한 권의 사랑 마지막 장면엔\n니가 있어야 해 그래야 말이 돼\n여기야, 우리가 이별한 슬픈 페이지\n내 앞에서 니가 서서 울고 있어\n\n너에게 묻고 싶어 너만 괜찮다면\n난 이 소설의 끝을 다시 써보려 해\n내 한 권의 사랑 마지막 장면엔\n니가 있어야 해 그래야 말이 되니까','Ballad','2014-09-30',1,'',262,'true','false'),('201608_0001','001','우주를 줄게','000003','000053,000055','000053,000056','0000000003','image/albumart/201608_0001.jpg','커피를 너무 많이 마셨나 봐요 \n심장이 막 두근대고 잠은 잘 수가 없어요\n한참 뒤에 별빛이 내리면 \n난 다시 잠들 순 없겠죠\n\n지나간 새벽을 다 새면 \n다시 네 곁에 잠들겠죠\n너의 품에 잠든 난 마치 \n천사가 된 것만 같아요\n난 그대 품에 별빛을 쏟아 내리고 \n은하수를 만들어 어디든 날아가게 할거야\n\nCause I’m a pilot anywhere \nCause I’m a pilot anywhere \nlighting star shooting star 줄게 내 Galaxy\nCause I’m a pilot anywhere \nCause I’m your pilot 네 곁에 \n저 별을 따 네게만 줄게 my Galaxy\n\nLike a star 내리는 비처럼\n반짝이는 널 가지고 싶어\nGet ma mind\n엄지와 검지만 해도 내 마음을 너무 잘 표현해\n붙어 안달 나니까\n마냥 떨리기만 한 게 아냐\n준비가 되면 쏘아 올린 인공위성처럼\n네 주윌 마구 맴돌려 해\n더 가까워진다면 네가 가져줄래\n이 떨림을\n\n어제는 내가 기분이 참 좋아서 \n지나간 행성에다가 그대 이름 새겨 놓았죠\n한참 뒤에 별빛이 내리면 \n그 별이 가장 밝게 빛나요\n\n지나간 새벽을 다 새면 \n다시 네 곁에 잠들겠죠\n별빛 아래 잠든 난 \n마치 온 우주를 가진 것만 같아\n난 그대 품에 별빛을 쏟아 내리고 \n은하수를 만들어 어디든 날아가게 할거야\n\nCause I’m a pilot anywhere \nCause I’m a pilot anywhere \nLighting star Shooting star \n줄게 내 Galaxy\nCause I’m a pilot anywhere \nCause I’m your pilot 네 곁에 \n저 별을 따 네게만 줄게 my Galaxy\n\nCause I’m a pilot anywhere \nCause I’m a pilot anywhere \nLighting star Shooting star 줄게 내 Galaxy\nCause I’m a pilot I’m your pilot\nLighting star Shooting star 줄게 my Galaxy\n\n라라라라라 라라라라라','Folk','2016-08-29',1,'',213,'true','false'),('201608_0002','001','그대라는 사치','000005','000058,000060,000062','000058,000064,000063','0000000002','image/albumart/201608_0002.jpg','그림 같은 집이 뭐 별거겠어요 \n어느 곳이든 그대가 있다면 그게 그림이죠\n\n빛나는 하루가 뭐 별거겠어요\n어떤 하루던 그대 함께라면 뭐가 필요하죠\n\n나 그대가 있지만 힘든 세상이 아니라\n힘든 세상 이지만 곁에 그대가 있음을 깨닫고 \n또 감사해요 또 기도해요 \n내 곁에서 변치 않고 영원하길 기도 드리죠\n\n무려 우리 함께 눈뜨는 아침과\n매일 그댈 만나 돌아오는 집 앞\n나 만의 그대, 나의 그대, 내겐 사치라는걸\n\n과분한 입맞춤에 취해 잠이 드는 일\n그래 사치, 그댄 사치, 내겐 사치\n\n행복이란 말이 뭐 별거겠어요\n그저 그대의 잠꼬대 마저 날\n기쁘게 하는데\n\n사랑이란 말이 뭐 별거겠어요\n그저 이렇게 보고만 있어도\n입에서 맴돌죠\n\n나 그대가 있지만 거친 세상이 아니라\n거친 세상 이지만 내겐 그대가 있음을 깨닫고 \n또 다짐하죠 또 약속하죠 \n그대 곁에 변치않고 영원하길 약속할게요\n\n무려 우리 함께 눈뜨는 아침과\n매일 그댈 만나 돌아오는 집 앞\n나 만의 그대, 나의 그대, 내겐 사치 라는걸\n\n과분한 입맞춤에 취해 잠이 드는 일\n그래 사치, 그댄 사치, 내겐 사치\n\n내가 상상하고 꿈꾸던 사람 그대\n정말 사랑하고 있다고 나 말 할 수 있어서\n믿을 수 없어, 정말 믿을 수 없어\n내가 어떻게 내가 감히 사랑할 수 있는지 말야 \n\n무려 우리 함께 잠드는 이 밤과\n매일 나를 위해 차려진 이 식탁\n나 만의 그대, 나의 그대, 내겐 사치 라는걸\n\n과분한 입맞춤에 취해 잠이 드는 일\n그래 사치, 그댄 사치, 내겐 사치','Ballad','2016-08-24',1,'',296,'true','false'),('201608_0003','001','목요일 밤 (Feat. 빈지노)','000010','000070','000070,000069','0000000009','image/albumart/201608_0003.jpg','평범한 목요일 밤 널 데려 갈게 어디든\n일주일 중에 네가 제일 지쳐 있을 오늘\nWanna drive? If you don’t mind?\n둘이서 갈래 어디든\n밤을 가득 채울 너와 나 그 곳을 향해 향해\nWherever you want\n\n이리 저리 치이다 정해진 모든 걸 해내도 \n하나도 웃음 안 나고 또 올 내일이 두렵고 \n밤은 좀 남았는데 어떻게 써야할지 모르고\n너와 함께 밤공기를 느끼고 파 \n\n지금 데리러 갈게\n집에 가지 말고 있어줘 \nbaby I’m on my way \nMaybe I’ll be there by 8 \n왜 너가 차빌 내야해\n좋은 음악이 있는 \n오빠 차가 있잖아\n물론 내일 일찍 일 나가야해 \n이런 실랑이 할 시간에 \n조금이라도 널 봐야해 난\n호흡이 딸리는 목요일 밤 \n널 생각하면서 달려가 난\n\n평범한 목요일 밤 널 데려 갈게 어디든 \n일주일 중에 네가 제일 지쳐 있을 오늘 \nWanna drive? If you don’t mind? \n둘이서 갈래 어디든 \n밤을 가득 채울 너와 나 그 곳을 향해 향해\nWherever you want \n\n어디든 데려다 줄게\n건반처럼 가로등을 가로지르며,\n너의 하룰 들으며, \n\'그랬어?\' 그러면서\n너를 괴롭혔던 \n바깥 세상의 밤 공기를 밀며 \n창 밖에 내던진 음악처럼\n한강엔 별과 달이 \n시간과 똑같이 흐르고 있어\n우린 느낄 수 있어 둘이서\n앞으로 더 많은 목요일에 \n도착할 거란 걸\n\n평범한 목요일 밤 널 데려갈게 어디든 \n(Wherever you want \n어디가 됐건 \nWhatever you want \n그 무엇이 됐건 \nLet’s go Let’s go)\nWanna drive? \nIf you don’t mind? \n둘이서 갈래 어디든 \n(Wherever you want \nWherever we want \nWherever I want \nWherever you want \nwe’re going to yo)\n\n바람을 더 느끼게 \n창문을 더 활짝 열어줘 \n(we’re going to yo \nwe’re going to yo)\n아무 말 필요 없어 \n그냥 나를 믿어 \n(Give it up Baby)\n\nWanna drive? \nIf you don’t mind? \n둘이서 갈래 어디든 \n밤을 가득 채울 \n너와 나 그 곳을 향해 향해\nWherever you want \n\n(Wherever you want \nWherever we want \nWherever I want \nWherever you want \nwe’re going to yo)\n\n(Wherever you want \nWherever we want \nWherever I want \nWherever you want \nwe’re going to yo))','R&B / Soul','2016-08-25',1,'',210,'true','false'),('201608_0004','001','나만 안되는 연애','000003','000053','000053','0000000003','image/albumart/201608_0004.jpg','왠지 오늘따라 마음이 아픈지 했더니\n오늘은 그대가 날 떠나가는 날이래요\n왜 항상 나는 이렇게 외로운 사랑을 하는지\n도무지 이해가 안가는 이상한 날이에요\n\n왜 그랬는지 묻고 싶죠 날 사랑하긴 했는지\n그랬다면 왜 날 안아줬는지 그렇게 예뻐했는지\n\n나만 이런 세상을 살고 있는 것 같아요\n바라보기만 하다 포기할 수는 없겠죠\n근데도 이렇게 아픈 마음만 가지고 사는 건\n도무지 불공평해서 견딜 수가 없어요\n\nPlease come back to me\nYeah yeah umm yeah\n\n왠지 오늘만은 그렇게 보내기 싫은지\n오늘은 그대와 나 마지막인가 봐요\n왜 항상 나는 이렇게 아무 말도 못하는지\n도무지 이해가 안가는 이상한 날이에요\n\n시작부터 사랑하지 않았다고 내게 말했었다면\n그랬다면 나의 마음은 이렇게 굳게 닫혔을까요\n\n나만 이런 세상을 살고 있는 것 같아요\n바라보기만 하다 포기할 수는 없겠죠\n근데도 이렇게 아픈 마음만 가지고 사는 건\n도무지 불공평해서 견딜 수가 없어요\n\nPlease come back to me \n(그대는 아무렇지 않겠죠)\nPlease come back to me \n(내 눈물로 더 이상 붙잡을 수는 없겠죠)\nYeah~~~ Oh \n(근데도 이렇게 아픈 마음만 가지고 사는 건)\n(도무지 불공평해서 견딜 수가 없어요)\n\nPlease come back to me\nYeah yeah umm yeah\n\nPlease come back to me\nYeah yeah umm yeah\n\n나는 사실 이성적인 게 참 싫어요\n그래서 우린 헤어져야만 했으니까\n아무렇지 않게 살아가도\n매일 밤이 고통스럽겠죠\n그대가 정이 많은 사람이었다면\n날 안아주진 않았을까요?','Folk','2016-08-29',5,'',219,'true','false'),('201609_0001','001','숨','000002','000002,000052','000002,000051','0000000001','image/albumart/201609_0001.jpg','오늘 하루 쉴 숨이 \n오늘 하루 쉴 곳이\n오늘만큼 이렇게 또 한번 살아가\n\n침대 밑에 놓아둔\n지난 밤에 꾼 꿈이\n지친 맘을 덮으며 \n눈을 감는다 괜찮아 \n\n남들과는 조금은 다른 모양 속에\n나 홀로 잠들어 \n다시 오는 아침에 \n눈을 뜨면 웃고프다 \n\n오늘 같은 밤 \n이대로 머물러도 될 꿈이라면 \n바랄 수 없는걸 바라도 된다면 \n두렵지 않다면 너처럼 \n\n오늘 같은 날 \n마른 줄 알았던 \n오래된 눈물이 흐르면 \n잠들지 않는 내 작은 가슴이 \n숨을 쉰다 \n\n끝도 없이 먼 하늘 \n날아가는 새처럼\n뒤돌아 보지 않을래 \n이 길 너머 어딘가 봄이 \n힘없이 멈춰있던\n세상에 비가 내리고\n다시 자라난 오늘\n그 하루를 살아\n\n오늘 같은 밤\n이대로 머물러도 될 꿈이라면\n바랄 수 없는걸 바라도 된다면\n두렵지 않다면 너처럼\n\n오늘 같은 날\n마른 줄 알았던 \n오래된 눈물이 흐르면\n잠들지 않는 \n이 어린 가슴이 숨을 쉰다\n고단했던 내 하루가 \n숨을 쉰다','Ballad','2016-09-29',1,'',282,'false','false'),('201609_0002','001','내가 저지른 사랑','000004','000004,000057','000004','0000000004','image/albumart/201609_0002.jpg','떠나거든 내 소식이 들려오면\n이제는 모른다고 해줘 \n언제나 내 맘속에서 \n커져만 갔던 너를 \n조금씩 나도 지우려 해 \n\n사랑해 라고 말하고 싶었지만\n늘 미안하다고만 했던 나\n\n잊고 잊혀지고 지우고\n처음 만난 그때가 그리워진 사람\n다시 못 올 몇 번의 그 계절\n떠나버린 너의 모습을 \n지우고 버리고 비워도\n어느 새 가득 차버린 내사랑\n\n안 된다고 사랑하면 안 된다고 \n하지만 우린 함께했지 \n언제나 내 마음이라 \n사랑하던 맘이라 \n그리 아파할 줄 몰랐어\n\n미안해 라고 안아주고 싶지만\n점이 돼버린 그 뒷모습 \n\n잊고 잊혀지고 지우고\n처음 만난 그때가 \n그리워진 사람\n다시 못 올 몇 번의 그 계절\n떠나버린 너의 모습을 \n지우고 버리고 비워도\n어느 새 가득 차버린 내사랑\n\n모든 게 나 때문인데 \n왜 네가 더 힘들어\n네가 왜 내 맘을 위로해 \n\n잊고 잊혀지고 지우고\n처음 만난 그때가 그리워진 사람\n다시 못 올 몇 번의 그 계절\n떠나버린 너의 모습을 \n지우고 버리고 비워도\n어느 새 가득 차버린 내사랑','Ballad','2016-09-06',11,'',238,'true','false'),('201609_0003','001','러시안 룰렛 (Russian Roulette)','000006','외국인작곡가들','000061','0000000006','image/albumart/201609_0003.jpg','La-La-La-La-La--\n\n날카로운 Secret 둘러싼 \n얘긴 베일 속에 \n점점 더 깊은 H-H-Hush \n맘을 겨눠 이제\n여긴 온통 어두운 밤 하늘색 \n그림자조차 길을 잃게 해\n\nOh 넌 항상 Love is game \n쉽게 즐기는 가벼움일 뿐이라고\n뭐 이렇게 못된 얘기로 자꾸 \n피해 가려고만 하니 왜\n\n커지는 Heart B-B-Beat \n빨라지는데\n너답지 않게 Heart B-B-B-Beat \n거려 나를 볼 때 \n마지막 남은 순간까지 \n점점 다가오지 Crazy\n아찔하게 겨눈 러시안 룰렛 \nAh-Ah-Ah-Yeah \nLa-La-La-La-La-- \nHeart B-B-B-Beat\n넌 이미 마지막 남은 순간까지 \n내게 맡기게 될 거야 넌\n달콤한 너의 러시안 룰렛\n\n반짝인 Secret \n더 이상 외면하진 못 해 \n버튼은 내가 P-P-Push \n받아들여 이제\n네 맘 온통 내 모습 채워지게 \n꿈 꿀 때조차 나를 찾게 돼\n\nOh 아직 넌 Love is game \n내게 말해도 흔들려 네 목소리도 \n장난스레 스친 눈빛 너머로 \n어쩔 줄 모르는 네 모습\n\n커지는 Heart B-B-Beat \n빨라지는데\n너답지 않게 Heart B-B-B-Beat \n거려 나를 볼 때 \n마지막 남은 순간까지 \n점점 다가오지 Crazy\n아찔하게 겨눈 러시안 룰렛 \nAh-Ah-Ah-Yeah \nLa-La-La-La-La-- \nHeart B-B-B-Beat\n넌 이미 마지막 남은 순간까지 \n내게 맡기게 될 거야 넌\n달콤한 너의 러시안 룰렛\n\n이토록 깊은 꿈이 넌 처음일 걸\n내 맘이 이 밤이 아른거리는 Game \nYou can’t control\n\n커지는 Heart B-B-Beat \n빨라지는데\n터질듯한 Heart B-B-B-Beat \nKey는 내가 쥘게\n마지막 남은 순간까지 \n점점 다가오지 Crazy\n아찔하게 겨눈 러시안 룰렛 \nAh-Ah-Ah-Yeah \nLa-La-La-La-La-- \nHeart B-B-B-Beat\n넌 이미 마침내 빼낼 수도 없게 박혀 \n네 심장 더 깊은 곳\n달콤한 너의 러시안 룰렛\n\n커지는 Heart B-B-Beat \n빨라지는데\nLa-La-La-La-La-- \n커지는 Heart B-B-Beat \n빨라지는데\nLa-La-La-La-La-- \nHeart B-B-B-Beat','Dance','2016-09-07',1,'',211,'true','false'),('201609_0004','001','Dancing King','000007,000008','외국인작곡가들','000065,000066','0000000007','image/albumart/201609_0004.jpg','Hey hey hey hey\nHey hey hey hey\nHey hey hey hey\n\n뜨거운 리듬에 가슴이 뛰잖아\n달아올라 지금 내 심장이\nCome on shake it \n너의 본능을 깨워\n이 시간이 지나가기 전에\n\nA-ya-ya \n오늘 밤 나는 Dancing King\n나에게 빠져들어\nA-ya-ya \n오늘 밤 나와 Dance all night\n\nOh \n지루했던 하룰 벗어 던져 버리고\n내 안에 잠들어 있던 흥은 챙기고\n올라타 봐 여기 리듬이란 마법에\nSenorita! \n깜짝 놀랄 밤을 선물해 줄게\n\n서툰 몸짓에 너를 맡겨 그냥 미쳐 \n(Ooh ah ah ah ah ah)\n지친 가슴에 불을 당겨 함께 춤을 춰\nCuz tonight\n\n뜨거운 리듬에 가슴이 뛰잖아\n달아올라 지금 내 심장이\nCome on shake it \n너의 본능을 깨워\n이 시간이 지나가기 전에\n\nA-ya-ya \n오늘 밤 나는 Dancing King\n나에게 빠져들어\nA-ya-ya \n오늘 밤 나와 Dance all night\n\nAh \n짜증나는 일들 모두 잊고 싶을 때\n고민 말고 그냥 나를 찾아오면 돼\nYeah \n맘보 탱고 룸바 삼바 뭐든 말만 해\nBuona sera! \n멋진 세상으로 초대해 줄게\n\n서툰 몸짓에 너를 맡겨 그냥 미쳐 \n(Ooh ah ah ah ah ah)\n이 시간만은 모두 잊어 함께 춤을 춰\nCuz tonight\n\n뜨거운 리듬에 가슴이 뛰잖아 \n(망설이지마)\n달아올라 지금 내 심장이 \n(달아올라)\nCome on shake it 너의 본능을 깨워 \n(함께 흔들어)\n이 시간이 지나가기 전에 \n(Oh yeah)\n\nA-ya-ya \n오늘 밤 나는 Dancing King\n나에게 빠져들어\nA-ya-ya \n오늘 밤 나와 Dance all night\n\nShake it to the left\nNow shake it to the right\n달이 질 때까지 널 멈추지는 마\n\nShake your body oh my\nDancing all night\n네게 눈이 먼 난 널 보낼 수 없어 \nAwoooo\n\n어차피 한 번 사는 인생이잖아\n달려 볼까 오늘 저 끝까지\nCome on shake it \n너의 본능을 깨워\n지금 우린 이대로 행복해\n\nA-ya-ya \n오늘 밤 나는 Dancing King\n나에게 빠져들어\nA-ya-ya \n오늘 밤 나와 Dance all night\n\nHey hey\nHey hey\nHey hey\nHey','Dance','2016-09-17',1,'',244,'true','false'),('201609_0005','001','구르미 그린 달빛','000009','000067','000067','0000000008','image/albumart/201609_0005.jpg','말하지 않아도 난 알아요\n그대 안에 오직 한사람\n바로 나란걸\n\n떨리는 내 맘을 들킬까봐\n숨조차 크게 쉬지 못한 \n그런 나였죠\n\n겁이 많아 숨기만 했지만\n\n내 사랑을 그대가 부르면 \n용기 내 볼게요\n얼어있던 꽃잎에 \n그대를 담아서\n불어오는 바람에 \n그대 내게 오는 날\n나를 스쳐 지나치지 않도록\n그대만 보며 살아요\n\n아무도 모르게 키워왔죠\n혹시 그대가 눈치챌까\n내 맘을 졸이고\n\n겁이 많아 숨기만 했지만\n\n내 사랑을 그대가 부르면 \n용기 내 볼게요\n얼어있던 꽃잎에 \n그대를 담아서\n불어오는 바람에 \n그대 내게 오는 날\n나를 스쳐 지나치지 않도록\n기도 할게요\n\n더 이상 망설이지 않을게요\n그대라면 어디든 난 괜찮아요\n하찮은 나를 믿어준 사람\n그대 곁에서 이 사랑을\n지킬게요\n\n내 사랑이 그대를 부르면 용기 내 줄래요\n얼어있던 꽃잎에 그대를 담아서\n불어오는 바람에 그대 내게 오는 날\n나를 스쳐 지나치지 않도록\n그대만보며 살아요.','Drama','2016-09-06',1,'',238,'true','false');
/*!40000 ALTER TABLE `music` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nation`
--

DROP TABLE IF EXISTS `nation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nation` (
  `nation_no` varchar(3) NOT NULL DEFAULT '',
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`nation_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nation`
--

LOCK TABLES `nation` WRITE;
/*!40000 ALTER TABLE `nation` DISABLE KEYS */;
INSERT INTO `nation` VALUES ('001','대한민국'),('002','미국'),('003','영국'),('004','일본'),('005','중국');
/*!40000 ALTER TABLE `nation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `playhistory`
--

DROP TABLE IF EXISTS `playhistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `playhistory` (
  `music_no` varchar(11) NOT NULL,
  `id` varchar(20) DEFAULT NULL,
  `date` datetime NOT NULL,
  `playtime` int(3) NOT NULL,
  KEY `music_no` (`music_no`),
  KEY `id` (`id`),
  CONSTRAINT `playhistory_ibfk_1` FOREIGN KEY (`music_no`) REFERENCES `music` (`music_no`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `playhistory_ibfk_2` FOREIGN KEY (`id`) REFERENCES `member` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `playhistory`
--

LOCK TABLES `playhistory` WRITE;
/*!40000 ALTER TABLE `playhistory` DISABLE KEYS */;
INSERT INTO `playhistory` VALUES ('201608_0001',NULL,'2017-03-05 15:34:38',18),('201409_0001','testid','2017-04-09 21:52:49',13),('201608_0002','testid','2017-04-09 21:53:25',36),('201608_0002','testid','2017-04-09 21:53:35',3),('201608_0001','testid','2017-04-09 21:58:23',213),('201608_0002','testid','2017-04-09 22:03:20',296),('201409_0001',NULL,'2017-04-11 23:09:35',39),('201409_0001',NULL,'2017-09-22 04:28:08',19),('201409_0001',NULL,'2018-01-30 12:14:36',43),('201409_0001','testid','2018-01-30 12:22:04',262);
/*!40000 ALTER TABLE `playhistory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `playlist`
--

DROP TABLE IF EXISTS `playlist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `playlist` (
  `playlist_no` varchar(15) NOT NULL,
  `id` varchar(20) NOT NULL,
  `genre` varchar(50) DEFAULT NULL,
  `tag` text,
  `date` datetime DEFAULT NULL,
  `title` text,
  `content` text,
  `isRadio` enum('true','false') DEFAULT NULL,
  `isShared` enum('true','false') DEFAULT NULL,
  `image` text,
  PRIMARY KEY (`playlist_no`),
  KEY `id` (`id`),
  CONSTRAINT `playlist_ibfk_1` FOREIGN KEY (`id`) REFERENCES `member` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `playlist`
--

LOCK TABLES `playlist` WRITE;
/*!40000 ALTER TABLE `playlist` DISABLE KEYS */;
/*!40000 ALTER TABLE `playlist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `playmusiclist`
--

DROP TABLE IF EXISTS `playmusiclist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `playmusiclist` (
  `playlist_no` varchar(15) NOT NULL,
  `music_no` varchar(11) NOT NULL,
  KEY `playlist_no` (`playlist_no`),
  KEY `music_no` (`music_no`),
  CONSTRAINT `playmusiclist_ibfk_1` FOREIGN KEY (`playlist_no`) REFERENCES `playlist` (`playlist_no`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `playmusiclist_ibfk_2` FOREIGN KEY (`music_no`) REFERENCES `music` (`music_no`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `playmusiclist`
--

LOCK TABLES `playmusiclist` WRITE;
/*!40000 ALTER TABLE `playmusiclist` DISABLE KEYS */;
/*!40000 ALTER TABLE `playmusiclist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `preference`
--

DROP TABLE IF EXISTS `preference`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `preference` (
  `kind` enum('artist','music','album','member','playlist') DEFAULT NULL,
  `item_no` varchar(20) NOT NULL,
  `id` varchar(20) NOT NULL,
  KEY `id` (`id`),
  CONSTRAINT `preference_ibfk_1` FOREIGN KEY (`id`) REFERENCES `member` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `preference`
--

LOCK TABLES `preference` WRITE;
/*!40000 ALTER TABLE `preference` DISABLE KEYS */;
INSERT INTO `preference` VALUES ('playlist','000000000000008','testid'),('playlist','000000000000008','testid2'),('music','201608_0001','testid2'),('music','201608_0001','testid'),('playlist','000000000000013','testid');
/*!40000 ALTER TABLE `preference` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-02-21  5:03:30
