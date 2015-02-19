DROP DATABASE IF EXISTS Yritys;
CREATE DATABASE Yritys DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_swedish_ci;
USE Yritys
CREATE TABLE toimipiste (

osoite  VARCHAR(20) NOT NULL,
työntekijä VARCHAR(20) ,
puhnro INT(30) NOT NULL,
postitoimipaikka VARCHAR(20) ,
postinumero INT(20) ,
sposti VARCHAR(20) ,
lisatty TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
PRIMARY KEY (osoite)
)ENGINE=innoDB;


CREATE TABLE työntekijä(
henkilötunnus VARCHAR(20) NOT NULL,
toimipiste VARCHAR(20),
etunimi VARCHAR(30) NOT NULL,
sukunimi VARCHAR(30) NOT NULL,
sposti VARCHAR(30),
puhnro  INT(30) ,
postinumero VARCHAR(30) ,
postitoimipaikka VARCHAR(30) ,
palkka INT(8),
PRIMARY KEY (henkilötunnus),
FOREIGN KEY (toimipiste) REFERENCES toimipiste(osoite)
)ENGINE=innoDB;

CREATE TABLE palkkaerittely(
palkkaid INT(8) NOT NULL,
henkilö VARCHAR(20) ,
maksupvm VARCHAR(20) NOT NULL,
alkupvm VARCHAR(20),
loppupvm VARCHAR(20),
vuodenalusta INT(15),
palkka INT(30) , 
PRIMARY KEY (palkkaid),
FOREIGN KEY (henkilö) REFERENCES työntekijä(henkilötunnus)
)ENGINE=innoDB;

CREATE TABLE asiakas(
asiakastunnus INT(10) NOT NULL,
etunimi VARCHAR (20) NOT NULL,
sukunimi VARCHAR(20) NOT NULL,
puhnro INT(10) ,
sposti VARCHAR(20) ,
osoite VARCHAR(20) ,
postitoimipaikka VARCHAR(30) ,
postinumero VARCHAR(30) ,
PRIMARY KEY (asiakastunnus)
)ENGINE=innoDB;

CREATE TABLE tuote(
tuotenro VARCHAR(30)NOT NULL,
nimi VARCHAR(20) NOT NULL,
hinta INT (10) NOT NULL,
valmistaja VARCHAR (10),
takuu INT (5) NULL,
tuotekuvaus VARCHAR (50) NULL,
määrä INT(10) NULL,
PRIMARY KEY (tuotenro)
)ENGINE=innoDB;


CREATE TABLE ostotapahtuma(
tapahtumaid INT(10)NOT NULL,
tilausid INT(10)NOT NULL,
asiakas INT(10),
toimipiste VARCHAR(20)NOT NULL,
pvm VARCHAR(10) NULL,
PRIMARY KEY (tapahtumaid)
)ENGINE=innoDB;


CREATE TABLE tuotelista(
tilausid INT (10) NOT NULL,
tuote VARCHAR(30) NOT NULL,
yhteishinta INT (10) ,
CONSTRAINT PRIMARY KEY (tilausid,tuote),
FOREIGN KEY (tuote) REFERENCES tuote(tuotenro)
)ENGINE=innoDB;

ALTER TABLE ostotapahtuma
ADD FOREIGN KEY (asiakas) REFERENCES asiakas(asiakastunnus);
ALTER TABLE ostotapahtuma
add FOREIGN KEY(toimipiste) REFERENCES toimipiste(osoite);
ALTER TABLE ostotapahtuma
add FOREIGN KEY (tilausid) REFERENCES tuotelista(tilausid); 
ALTER TABLE toimipiste 
ADD FOREIGN KEY (työntekijä)
REFERENCES työntekijä(henkilötunnus);
ALTER TABLE työntekijä
ADD FOREIGN KEY (palkka)
REFERENCES palkkaerittely(palkkaid);

CREATE TABLE tunnisteet(
asiakastunnus INT(10) NOT NULL,
salasanatiiviste VARCHAR(40) ,
 PRIMARY KEY (asiakastunnus)
)ENGINE=innoDB; 

CREATE TRIGGER generoisalasana AFTER INSERT ON asiakas
FOR EACH ROW
INSERT INTO tunnisteet VALUES (NEW.asiakastunnus, SHA1(CONCAT(LEFT(NEW.etunimi, 3), RIGHT(NEW.sukunimi, 3))));
     
insert into toimipiste (osoite, puhnro, postitoimipaikka, postinumero, sposti) values ('5 Pennsylvania Circle', '4-(558)605-5064', 'Hartford', '80712', 'cgrant0@list-manage.com');
insert into toimipiste (osoite, puhnro, postitoimipaikka, postinumero, sposti) values ('0 Eastlawn Plaza', '7-(551)262-1426', 'Takaka', '80712', 'cstone1@vk.com');
insert into toimipiste (osoite, puhnro, postitoimipaikka, postinumero, sposti) values ('6902 Sloan Parkway', '4-(389)908-1810', 'Zlín', '80712', 'pcastillo2@illinois.edu');
insert into toimipiste (osoite, puhnro, postitoimipaikka, postinumero, sposti) values ('4535 Gale Plaza', '2-(288)266-1215', 'Marte', '8073312', 'wfields3@slideshare.net');
insert into toimipiste (osoite, puhnro, postitoimipaikka, postinumero, sposti) values ('8048 Grim Court', '8-(231)333-0935', 'Ajax', '80712', 'rduncan4@feedburner.com');
insert into toimipiste (osoite, puhnro, postitoimipaikka, postinumero, sposti) values ('967 Vermont Park', '7-(766)150-7798', 'Jiangtou', '80712', 'dholmes5@unesco.org');
insert into toimipiste (osoite, puhnro, postitoimipaikka, postinumero, sposti) values ('60221 Rockefeller Place', '0-(699)096-0725', 'Cruzeiro', '4640-324', 'kshaw6@delicious.com');
insert into toimipiste (osoite, puhnro, postitoimipaikka, postinumero, sposti) values ('7709 Pleasure Road', '4-(942)282-3954', 'Yanqul', '343612', 'pferguson7@fema.gov');
insert into toimipiste (osoite, puhnro, postitoimipaikka, postinumero, sposti) values ('00633 Maple Road', '5-(542)019-9833', 'Brusy', '80462', 'jdiaz8@digg.com');
insert into toimipiste (osoite, puhnro, postitoimipaikka, postinumero, sposti) values ('8 Russell Terrace', '9-(530)080-8620', 'Jiaoxiyakou', '803462', 'csmith9@elegantthemes.com');

insert into työntekijä (henkilötunnus,toimipiste, etunimi, sukunimi) values ('743-33-8258','5 Pennsylvania Circle' ,'Noëlla', 'Grant');
insert into työntekijä (henkilötunnus,toimipiste, etunimi, sukunimi)values ('960-72-3146','5 Pennsylvania Circle', 'Annotés', 'Johnson');
insert into työntekijä (henkilötunnus,toimipiste, etunimi, sukunimi) values ('356-86-8606', '5 Pennsylvania Circle','Kallisté', 'Thomas');
insert into työntekijä (henkilötunnus,toimipiste, etunimi, sukunimi) values ('964-77-4439', '5 Pennsylvania Circle','Märta', 'Lopez');
insert into työntekijä (henkilötunnus,toimipiste, etunimi, sukunimi) values ('763-99-5055', '5 Pennsylvania Circle','Märta', 'Williamson');
insert into työntekijä (henkilötunnus,toimipiste, etunimi, sukunimi) values ('306-98-2182', '0 Eastlawn Plaza','Edmée', 'Tucker');
insert into työntekijä (henkilötunnus,toimipiste, etunimi, sukunimi) values ('280-44-9984', '0 Eastlawn Plaza','Mégane', 'Watson');
insert into työntekijä (henkilötunnus,toimipiste, etunimi, sukunimi) values ('456-67-8530', '0 Eastlawn Plaza','Gösta', 'Lane');
insert into työntekijä (henkilötunnus,toimipiste, etunimi, sukunimi) values ('773-10-2761','967 Vermont Park', 'Sélène', 'Montgomery');
insert into työntekijä (henkilötunnus,toimipiste, etunimi, sukunimi) values ('913-50-4509','967 Vermont Park','Naëlle', 'Bennett');

insert into palkkaerittely (palkkaid,henkilö, maksupvm, palkka) values (1,'913-50-4509','16.11.2014', 1903);
insert into palkkaerittely (palkkaid,henkilö, maksupvm, palkka) values (2, '913-50-4509','23.7.2014', 2228);
insert into palkkaerittely (palkkaid,henkilö, maksupvm, palkka) values (3, '913-50-4509','30.10.2014', 1931);
insert into palkkaerittely (palkkaid,henkilö, maksupvm, palkka) values (4, '913-50-4509','4.11.2014', 3067);
insert into palkkaerittely (palkkaid,henkilö, maksupvm, palkka) values (5, '913-50-4509','15.3.2014', 2171);
insert into palkkaerittely (palkkaid,henkilö, maksupvm, palkka) values (6, '773-10-2761','22.1.2015', 3135);
insert into palkkaerittely (palkkaid,henkilö, maksupvm, palkka) values (7, '773-10-2761','5.7.2014', 3116);
insert into palkkaerittely (palkkaid,henkilö, maksupvm, palkka) values (8, '306-98-2182','21.11.2014', 2857);
insert into palkkaerittely (palkkaid,henkilö, maksupvm, palkka) values (9, '306-98-2182','20.10.2014', 3525);
insert into palkkaerittely (palkkaid,henkilö, maksupvm, palkka) values (10, '306-98-2182','26.4.2014', 2624);

insert into asiakas (asiakastunnus, etunimi, sukunimi, puhnro) values (1, 'Craig', 'Nichols', '3-(575)340-4435');
insert into asiakas (asiakastunnus, etunimi, sukunimi, puhnro) values (2, 'Kimberly', 'Carter', '1-(399)628-6740');
insert into asiakas (asiakastunnus, etunimi, sukunimi, puhnro) values (3, 'Lawrence', 'Turner', '7-(867)571-7970');
insert into asiakas (asiakastunnus, etunimi, sukunimi, puhnro) values (4, 'Michael', 'Boyd', '3-(771)715-5891');
insert into asiakas (asiakastunnus, etunimi, sukunimi, puhnro) values (5, 'Gloria', 'Baker', '4-(305)995-5488');
insert into asiakas (asiakastunnus, etunimi, sukunimi, puhnro) values (6, 'Jeremy', 'Ross', '9-(836)086-1785');
insert into asiakas (asiakastunnus, etunimi, sukunimi, puhnro) values (7, 'Victor', 'Perry', '0-(683)400-5949');
insert into asiakas (asiakastunnus, etunimi, sukunimi, puhnro) values (8, 'Henry', 'Simpson', '4-(602)137-6793');
insert into asiakas (asiakastunnus, etunimi, sukunimi, puhnro) values (9, 'Martha', 'Reyes', '5-(651)829-8736');
insert into asiakas (asiakastunnus, etunimi, sukunimi, puhnro) values (10, 'Julia', 'Owens', '7-(886)610-8784');

insert into tuote (tuotenro,nimi, hinta) values ('adc44ea0-e375-4c59-8dc6-4fcb60edb95f','kultainenperuna',604);
insert into tuote (tuotenro,nimi, hinta) values ('3de9c7f5-cb6c-4978-970e-1b51e6d4717f','tomaatti', 67);
insert into tuote (tuotenro,nimi, hinta) values ('2ed8967d-0b1a-4dec-8664-716602366e17','smaragdimansikka',826);
insert into tuote (tuotenro,nimi, hinta) values ('91678567-c05a-4121-a097-f6ca46cabbd9','äitin vanhat tohvelit', 610);
insert into tuote (tuotenro,nimi, hinta) values ('63e0a420-6bbc-4c6f-bc30-174f9aca95fd','puuro', 618);
insert into tuote (tuotenro,nimi, hinta) values ('07ad0773-fa2e-4706-ad77-957b3362a768','omena', 619);
insert into tuote (tuotenro,nimi,hinta) values ('82567a3a-9342-4f79-9222-ce97716e8050', 'kirsikka',116);
insert into tuote (tuotenro,nimi, hinta) values ('38b29d79-68a1-4fbb-9531-9ba9bc3d9bd9','virtahepo(lelu)', 954);
insert into tuote (tuotenro,nimi,hinta) values ('1e6fbae5-7a2f-4b25-bf1f-4baa1e886ff4', 'kameli(lelu)',597);
insert into tuote (tuotenro,nimi, hinta) values ('c079c975-0ae4-4c73-9f0e-144af105848a', 'keppiheppa',631);

insert into tuotelista (tilausid,tuote) values (11111,'adc44ea0-e375-4c59-8dc6-4fcb60edb95f');
insert into tuotelista (tilausid,tuote) values (11111,'2ed8967d-0b1a-4dec-8664-716602366e17');
insert into tuotelista (tilausid,tuote) values (21111,'3de9c7f5-cb6c-4978-970e-1b51e6d4717f');
insert into tuotelista (tilausid,tuote) values (33333,'63e0a420-6bbc-4c6f-bc30-174f9aca95fd');
insert into tuotelista (tilausid,tuote) values (33333,'adc44ea0-e375-4c59-8dc6-4fcb60edb95f');
insert into tuotelista (tilausid,tuote) values (55555,'07ad0773-fa2e-4706-ad77-957b3362a768');
insert into tuotelista (tilausid,tuote) values (44444,'91678567-c05a-4121-a097-f6ca46cabbd9');
insert into tuotelista (tilausid,tuote) values (55555,'3de9c7f5-cb6c-4978-970e-1b51e6d4717f');
insert into tuotelista (tilausid,tuote) values (21111,'adc44ea0-e375-4c59-8dc6-4fcb60edb95f');
insert into tuotelista (tilausid,tuote) values (96222,'c079c975-0ae4-4c73-9f0e-144af105848a');
insert into tuotelista (tilausid,tuote) values (15444,'38b29d79-68a1-4fbb-9531-9ba9bc3d9bd9');

insert into ostotapahtuma (tapahtumaid,tilausid,asiakas,toimipiste,pvm) values (2,11111,2,'5 Pennsylvania Circle','23.3.2014');
insert into ostotapahtuma (tapahtumaid,tilausid,asiakas,toimipiste,pvm) values (3,44444,3,'5 Pennsylvania Circle','23.3.2014');
insert into ostotapahtuma (tapahtumaid,tilausid,asiakas,toimipiste,pvm) values (4,33333,3,'5 Pennsylvania Circle','4.11.2014');
insert into ostotapahtuma (tapahtumaid,tilausid,asiakas,toimipiste,pvm) values (5,33333,5,'5 Pennsylvania Circle','4.11.2014');
insert into ostotapahtuma (tapahtumaid,tilausid,asiakas,toimipiste,pvm) values (6,21111,6,'8 Russell Terrace','4.11.2014');
insert into ostotapahtuma (tapahtumaid,tilausid,asiakas,toimipiste,pvm) values (7,15444,8,'8 Russell Terrace','4.11.2014');
insert into ostotapahtuma (tapahtumaid,tilausid,asiakas,toimipiste,pvm) values (8,96222,8,'8 Russell Terrace','4.11.2014');
insert into ostotapahtuma (tapahtumaid,tilausid,asiakas,toimipiste,pvm) values (9,21111,10,'7709 Pleasure Road','4.11.2014');
insert into ostotapahtuma (tapahtumaid,tilausid,asiakas,toimipiste,pvm) values (10,55555,10,'7709 Pleasure Road','4.11.2014');

SELECT ostotapahtuma.tilausid, asiakas.etunimi, ostotapahtuma.pvm
FROM ostotapahtuma
INNER JOIN asiakas
ON ostotapahtuma.asiakas=asiakas.asiakastunnus;

SELECT palkkaerittely.palkkaid,työntekijä.etunimi,palkkaerittely.palkka
from palkkaerittely
inner join työntekijä
on palkkaerittely.henkilö=työntekijä.henkilötunnus;

SELECT tuotelista.tilausid,tuote.nimi,tuote.hinta
from tuotelista
inner join tuote
on tuotelista.tuote =tuote.tuotenro;

CREATE VIEW Palkka AS
SELECT palkkaerittely.palkkaid,työntekijä.etunimi,palkkaerittely.palkka
FROM palkkaerittely,työntekijä
WHERE palkkaerittely.henkilö=työntekijä.henkilötunnus AND palkkaerittely.palkka>2800;

CREATE VIEW Asiointi AS
SELECT tuotelista.tilausid,tuote.nimi,tuote.hinta
FROM tuotelista,tuote
WHERE tuotelista.tuote =tuote.tuotenro; 

CREATE VIEW Osto AS
SELECT ostotapahtuma.tilausid, asiakas.etunimi, ostotapahtuma.pvm
FROM ostotapahtuma,asiakas
WHERE ostotapahtuma.asiakas=asiakas.asiakastunnus AND ostotapahtuma.pvm ='4.11.2014';