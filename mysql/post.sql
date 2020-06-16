#source C:/code/android/project/Tsingvat/mysql/post.sql
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

INSERT INTO post VALUES("5ad6e47a-02b7-4cb4-b7d6-cd13a2e783e6","admin","2020-06-01 10:36:20","I am a post");

SELECT * FROM post;