drop table if exists account
create table account(username varchar(30) not null primary key,
	password varchar(30) not null,
	nickname varchar(40),
	signature varchar(100),
	avatar varchar(100)
	);
insert into account values("admin","admin",null,null,null);