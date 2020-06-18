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

DROP TABLE IF EXISTS reply;
# 继承自post，包含基本的内容，实际上等价于在post基础上添加一个母节点的uuid
CREATE TABLE reply(
    uuid varchar(40) NOT NULL PRIMARY KEY,
    parent varchar(40) NOT NULL,
    username varchar(30) NOT NULL ,
    created timestamp NOT NULL,
    content tinytext
	);

DROP TABLE IF EXISTS errand;
CREATE TABLE errand(
  uuid varchar(40) NOT NULL PRIMARY KEY,
	username varchar(30) NOT NULL ,
  created timestamp NOT NULL,
  content tinytext,
  fromAddr varchar(100),
  toAddr varchar(100),
  ddl timestamp,
  taker varchar(30),
  takeTime timestamp

);

INSERT INTO post VALUES("5ad6e47a-02b7-4cb4-b7d6-cd13a2e783e6","admin","2020-06-01 10:36:20","I am a post");
INSERT INTO post VALUES("7fc417d3-352a-4a4d-9f55-803c667e18d8","zxj","2020-06-16 13:52:36","FisrtPost");
INSERT INTO post VALUES("ed39849c-c7b1-47f0-883f-d9a927aba409","zxj","2020-06-16 14:05:06","SecondPost");

SELECT * FROM post;