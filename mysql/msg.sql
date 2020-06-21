DROP TABLE IF EXISTS msg;
CREATE TABLE msg(
	uuid varchar(40) NOT NULL PRIMARY KEY,
    sender varchar(30) NOT NULL,
    receiver varchar(40) NOT NULL,
    content tinytext NOT NULL ,
    created timestamp NOT NULL,
    type int,
    sent boolean
	);

CREATE TABLE group_user(
	uuid varchar(40) NOT NULL PRIMARY KEY,
	member varchar(30) NOT NULL
);