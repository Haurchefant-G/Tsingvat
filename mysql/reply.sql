use tsinghua;
SHOW DATABASES;
USE tsinghua;
DROP TABLE IF EXISTS reply;
# 继承自post，包含基本的内容，实际上等价于在post基础上添加一个母节点的uuid
CREATE TABLE reply(
    uuid varchar(40) NOT NULL PRIMARY KEY,
    uuid varchar(40) NOT NULL,
    username varchar(30) NOT NULL ,
    created timestamp NOT NULL,
    content tinytext
	);

SELECT * FROM post;