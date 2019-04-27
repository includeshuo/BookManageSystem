-- 创建数据库

create database book_managesystem;


drop table usertable;
-- 创建用户数据表
CREATE TABLE usertable (
    user_id VARCHAR(20),
    password VARCHAR(20),
    user_name VARCHAR(40),
    profession VARCHAR(40),
    status int
);

-- 创建管理员账号,管理权限为2，学生为1.
insert into usertable values('admin',123456,'管理员','管理',2);
-- 建立书籍数据表

CREATE TABLE book (
    book_id INT,
    book_name VARCHAR(20),
    book_author VARCHAR(40),
    book_pub VARCHAR(40),
    book_type VARCHAR(20),
    book_count INT
);
-- 建立借书表
drop table borrowhistory;
CREATE TABLE borrowhistory (
	hid int,
    user_id VARCHAR(20),
    user_name VARCHAR(20),
    book_name VARCHAR(40),
    book_id INT,
    begin_time varchar(40),
    end_time varchar(40),
    status INT
);
