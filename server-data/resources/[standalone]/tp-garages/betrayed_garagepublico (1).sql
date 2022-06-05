# Host: 192.99.244.211  (Version 5.5.5-10.3.16-MariaDB-1:10.3.16+maria~xenial-log)
# Date: 2020-02-13 12:37:34
# Generator: MySQL-Front 6.1  (Build 1.26)


#
# Structure for table "betrayed_garagepublico"
#

DROP TABLE IF EXISTS `betrayed_garagepublico`;
CREATE TABLE `betrayed_garagepublico` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `steamid` varchar(255) NOT NULL DEFAULT '',
  `disponible` varchar(255) DEFAULT '[{"slot": "1"},{"slot": "2"}]',
  `slot1` longtext DEFAULT NULL,
  `slot2` longtext DEFAULT NULL,
  `slot3` longtext DEFAULT NULL,
  `slot4` longtext DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=294 DEFAULT CHARSET=latin1;
