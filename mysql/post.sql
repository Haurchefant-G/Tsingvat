SHOW DATABASES;
USE tsinghua;
DROP TABLE IF EXISTS post;
CREATE TABLE post(
  uuid varchar(40) NOT NULL PRIMARY KEY,
	username varchar(30) NOT NULL ,
  created timestamp NOT NULL,
  content tinytext
	);

DROP TABLE IF EXISTS imgs;
CREATE TABLE imgs(
  uuid varchar(40),
  img varchar(40)
  );

INSERT INTO post VALUES("1111222233334444","admin","2020-06-01:10:36:20","I am a post");
INSERT INTO post VALUES("1111222233334445","zxj","2020-06-01:10:36:20","I am a post");
INSERT INTO post VALUES("1111222233334446","zxj","2020-06-01:10:36:20","I am a post");
INSERT INTO post VALUES("1111222233334447","gac","2020-06-01:10:36:20","I am a post");

SELECT * FROM post;