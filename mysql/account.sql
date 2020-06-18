SHOW DATABASES;
USE tsinghua;
DROP TABLE IF EXISTS account;
CREATE TABLE account(
  username varchar(30) NOT NULL PRIMARY KEY,
	password varchar(30) NOT NULL,
  email varchar(30) NOT NULL,
	nickname varchar(40),
	signature varchar(100),
	avatar varchar(100)
	);
INSERT INTO account VALUES("admin","admin","",NULL,NULL,NULL);
INSERT INTO account VALUES("zxj","zxj","zxj@mails.tsinghua.edu.cn","LittleHealth","loser","http://img");
INSERT INTO account VALUES("gac","gac","gac@mails.tsinghua.edu.cn","H",NULL,NULL);

DROP TABLE IF EXISTS follow;
CREATE TABLE follow(
  username varchar(30) NOT NULL,
  follow varchar(30) NOT NULL,
  PRIMARY KEY(username,follow)
  );

INSERT INTO follow VALUES("zxj","gac");


SELECT * FROM account;

SELECT * FROM account JOIN follow ON account.username=follow.username;