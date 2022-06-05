USE `essentialmode`;

CREATE TABLE `owned_vehicles` (
	`owner` varchar(22) NOT NULL,
	`plate` varchar(12) NOT NULL,
	`vehicle` longtext,
	`type` VARCHAR(20) NOT NULL DEFAULT 'car',
	`job` VARCHAR(20) NOT NULL,
	`state` TINYINT(1) NOT NULL DEFAULT '1',
	`mods` VARCHAR(50) NOT NULL,

	PRIMARY KEY (`plate`)
);

