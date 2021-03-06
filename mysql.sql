-- # 登录Mysql
mysql -u root -p 111111
-- #退出mysql数据库服务器
exit;

-- #基本语法
-- #显示所有的数据库
show databases;

-- #创建数据库
CREATE DATABASE test;

-- mysql> CREATE DATABASE test;
-- Query OK, 1 row affected (0.01 sec)
-- 切换数据库
use test;
-- mysql> use test;
-- Database changed

-- 显示数据库中的所有的表

show tables;

CREATE TABLE pet(
    name VARCHAR(20),
    owner VARCHAR(20),
    species VARCHAR(20),
    sex CHAR(1),
    birth DATE,
    death DATE
);
-- 查看数据表结构
-- describe pet;
desc pet;

-- 查询表
SELECT * from pet;

-- 插入数据

INSERT INTO pet values('puffball', 'Diane', 'hamster', 'f', '1990-03-30', NULL);
INSERT INTO pet values('Dayu', 'xzf', 'black', 'f', '1990-03-30', NULL);
INSERT INTO pet values('Dayu2', 'xzf', 'white', 'f', '1990-04-30', NULL);
INSERT INTO pet values('Dayu3', 'xzf', 'fat', 'f', '1990-03-30', NULL);
INSERT INTO pet values('Dayu3', 'xzf', 'short', 'f', '1990-03-30', NULL);

-- 修改数据
-- 将owner为'xzf'的 name改为Day4
UPDATE pet SET name = 'Day4' where owner = 'xzf'; 

DELETE FROM pet where name = 'puffball';

-- 删除表

drop TABLE pet;



-- MySQL支持多种类型，大致可以分为三类：数值、日期/时间和字符串(字符)类型
-- 1. 数值类型
-- 类型	        大小	        范围（有符号）	范围（无符号）	                用途
-- TINYINT	    1 byte	    (-128，127)	(0，255)	                    小整数值
-- SMALLINT	    2 bytes	    (-32 768，32 767)	(0，65 535)	            大整数值
-- MEDIUMINT	3 bytes	    (-8 388 608，8 388 607)	(0，16 777 215)	    大整数值
-- INT或INTEGER	4 bytes	    (-2 147 483 648，2 147 483 647)	(0，4 294 967 295)	大整数值
-- BIGINT	    8 bytes	    (-9,223,372,036,854,775,808，9 223 372 036 854 775 807)	(0，18 446 744 073 709 551 615)	极大整数值
-- FLOAT	    4 bytes	    -3.402 823 466 E+38，-1.175 494 351 E-38)，0，(1.175 494 351 E-38，3.402 823 466 351 E+38)	0，(1.175 494 351 E-38，3.402 823 466 E+38)	单精度
-- 浮点数值
-- DOUBLE	    8 bytes	(-1.797 693 134 862 315 7 E+308，-2.225 073 858 507 201 4 E-308)，0，(2.225 073 858 507 201 4 E-308，1.797 693 134 862 315 7 E+308)	0，(2.225 073 858 507 201 4 E-308，1.797 693 134 862 315 7 E+308)	双精度
-- 浮点数值
-- DECIMAL	对DECIMAL(M,D) ，如果M>D，为M+2否则为D+2	依赖于M和D的值	依赖于M和D的值	小数值

-- 2.日期和时间类型
-- 类型	        大小(bytes)         范围	                格式	        用途
-- DATE	        3	        1000-01-01/9999-12-31	    YYYY-MM-DD      日期值
-- TIME	        3	        '-838:59:59'/'838:59:59'    HH:MM:SS	    时间值或持续时间
-- YEAR	        1	        1901/2155	                YYYY	        年份值
-- DATETIME	    8	1000-01-01 00:00:00/9999-12-31 23:59:59	YYYY-MM-DD HH:MM:SS	混合日期和时间值
-- TIMESTAMP	4	-- 1970-01-01 00:00:00/2038-- 结束时间是第 2147483647 秒，北京时间 2038-1-19 11:14:07，格林尼治时间 2038年1月19日 凌晨 03:14:07
-- YYYYMMDD HHMMSS	混合日期和时间值，时间戳

-- 3. 字符串类型
-- 类型	            大小	                用途
-- CHAR	        0-255 bytes	            定长字符串
-- VARCHAR	    0-65535 bytes	        变长字符串
-- TINYBLOB	    0-255 bytes	            不超过 255 个字符的二进制字符串
-- TINYTEXT	    0-255 bytes	            短文本字符串
-- BLOB	        0-65 535 bytes	        二进制形式的长文本数据
-- TEXT	        0-65 535 bytes	        长文本数据
-- MEDIUMBLOB	0-16 777 215 bytes	    二进制形式的中等长度文本数据
-- MEDIUMTEXT	0-16 777 215 bytes      中等长度文本数据
-- LONGBLOB	    0-4 294 967 295 bytes	二进制形式的极大文本数据
-- LONGTEXT	    0-4 294 967 295 bytes	极大文本数据



-- 2. 建表约束
-- 2.1 主键约束
-- 主键约束:使某个字段不重复且不得为空,确保表内所有数据的唯一性

create table user(
    id int primary key,
    name varchar(20)
);

insert into user values(1, 'zhangsan');
-- 再次插入报错
-- mysql> insert into user values(1, 'zhangsan');
-- ERROR 1062 (23000): Duplicate entry '1' for key 'user.PRIMARY'

insert into user values(NULL, "zhangsan");
-- 主键不可为空
-- mysql> insert into user values(NULL, "zhangsan");
-- ERROR 1048 (23000): Column 'id' cannot be null
-- 2.2 联合主键
-- 只要两个主键值加起来不重复就可以
CREATE TABLE user2(
    id int,
    name VARCHAR(20),
    password VARCHAR(20),
    primary key(id, name)
);

INSERT INTO user2 VALUES(1, 'zhangsan', '123');

-- 再次插入报错
-- mysql> INSERT INTO user2 VALUES(1, 'zhangsan', '123');
-- ERROR 1062 (23000): Duplicate entry '1-zhangsan' for key 'user2.PRIMARY'

insert into user2 values(2, 'zhangsan', '345');
-- insert into user2 values(1, 'lisi', '456');

-- mysql> select * from user2;
-- +----+----------+----------+
-- | id | name     | password |
-- +----+----------+----------+
-- |  1 | zhangsan | 123      |
-- |  2 | zhangsan | 345      |
-- +----+----------+----------+

insert into user2 values(NULL, 'lisi', '123');
-- 联合主键任何一个字段都不能为空
-- mysql> insert into user2 values(NULL, 'lisi', '123');
-- ERROR 1048 (23000): Column 'id' cannot be null

-- 2.3 自增约束

create table user3(
    id int primary key auto_increment,
    name varchar(20)
);

insert into user3 (name) values('zhangsan');
insert into user3 (name) values('zhangsan');
-- +----+----------+
-- | id | name     |
-- +----+----------+
-- |  1 | zhangsan |
-- |  2 | zhangsan |
-- +----+----------+

-- 如果创建表的时候,忘记了创建主键约束,怎么办?
create table user4(
    id int,
    name varchar(20)
);


-- +-------+-------------+------+-----+---------+-------+
-- | Field | Type        | Null | Key | Default | Extra |
-- +-------+-------------+------+-----+---------+-------+
-- | id    | int         | YES  |     | NULL    |       |
-- | name  | varchar(20) | YES  |     | NULL    |       |
-- +-------+-------------+------+-----+---------+-------+
-- 修改表结构,添加主键
alter table user4 add primary key(id);
-- 如何删除?

alter table user4 drop primary key;
-- 注意:未添加主键的时候,null为yes,添加后然后再删除,null变为NO
-- +-------+-------------+------+-----+---------+-------+
-- | Field | Type        | Null | Key | Default | Extra |
-- +-------+-------------+------+-----+---------+-------+
-- | id    | int         | NO   |     | NULL    |       |
-- | name  | varchar(20) | YES  |     | NULL    |       |
-- +-------+-------------+------+-----+---------+-------+

alter table user4 modify id int primary key;


-- 唯一约束
-- 约束修饰的字段的值不可以重复

create table user5(
    id int,
    name varchar(20)
);

alter table user5 add unique(name);

insert into user5 values(1, 'zhangsan');
-- insert into user5 values(1, 'zhangsan'); //error
-- 以下三种方法也可以创建唯一约束
create table user6(
    id int,
    name varchar(20),
    unique(name)
);

create table user7(
    id int,
    name varchar(20) unique
);

-- 两者组合在一起不重复就可以
create table user8(
    id int,
    name varchar(20),
    unique(id, name)
);
insert into user8 values(1, 'zhangsan');
insert into user8 values(2, 'zhangsan');
insert into user8 values(1, 'lisi');

-- +------+----------+
-- | id   | name     |
-- +------+----------+
-- |    1 | lisi     |
-- |    1 | zhangsan |
-- |    2 | zhangsan |
-- +------+----------+

-- 如何删除唯一约束

alter table user7 drop index name;
-- modify 添加
alter table user7 modify name varchar(20) unique;
alter table user7 add unique(name);

-- 总结

-- 1. 建表的时候就添加约束
-- 2. 可以使用alter table tableName add primary key/unique(字段)
-- 3. 可以使用alter table tableName modify 字段 类型 primary key/unique
-- 4. 删除 alter table tablename drop index 字段名

-- 2.4 非空约束
-- 修饰的字段不能为空 NULL
create table user9(
    id int,
    name varchar(20) not null
);

-- insert into user9 (id) values(1);
-- ERROR 1364 (HY000): Field 'name' doesn't have a default value
insert into user9 values(1, 'zhangsan');

insert into user9 (name) values('lisi');


-- 2.5 默认约束
-- 当我们插入字段的时候,如果没有传值,就会使用默认值

create table user10(
    id int,
    name varchar(20),
    age int default 10
);

-- +-------+-------------+------+-----+---------+-------+
-- | Field | Type        | Null | Key | Default | Extra |
-- +-------+-------------+------+-----+---------+-------+
-- | id    | int         | YES  |     | NULL    |       |
-- | name  | varchar(20) | YES  |     | NULL    |       |
-- | age   | int         | YES  |     | 10      |       |
-- +-------+-------------+------+-----+---------+-------+

insert into user10(id, name) values(1, 'zhangsan');
-- 传了值就不会使用默认值
insert into user10 values(1, 'zhangsan', 18);

-- 2.6 外键约束
-- 涉及到两个表: 父表,子表
-- 主表,副表
-- 1. 班级表
create table classes(
    id int primary key,
    name varchar(20)
);

-- 学生表

create table students(
    id int primary key,
    name varchar(20),
    class_id int,
    -- 表示class_id的值必须来自于classes中的id字段值
    foreign key(class_id) REFERENCES classes(id)
);

insert into classes values(1, 'class1');
insert into classes values(2, 'class2');
insert into classes values(3, 'class3');
insert into classes values(4, 'class4');
insert into classes values(5, 'class5');

insert into students values(1001, 'zhangsan', 1);
insert into students values(1002, 'zhangsan', 2);
insert into students values(1003, 'zhangsan', 3);
insert into students values(1004, 'zhangsan', 4);
insert into students values(1005, 'zhangsan', 5);

-- insert into students values(1006, 'lisi', 6); #主表里边的不存在则不能插入
-- ERROR 1452 (23000): Cannot add or update a child row: a foreign key constraint fails (`test`.`students`, CONSTRAINT `students_ibfk_1` FOREIGN KEY (`class_id`) REFERENCES `classes` (`id`))
-- 结论:
-- 主表classes中没有的数据值,在副表中是不可以使用的.
-- 主表中的记录被副表引用,是不可以删除的.

delete from classes where id = 4;

-- ERROR 1451 (23000): Cannot delete or update a parent row: a foreign key constraint fails (`test`.`students`, CONSTRAINT `students_ibfk_1` FOREIGN KEY (`class_id`) REFERENCES `classes` (`id`))

-- 数据库的三大设计范式
-- 1. 第一范式 1NF
-- 数据表中的所有字段都是不可分割的原子值
-- 只要字段值还可以继续拆分,就不满足第一范式

create table students2(
    id int,
    name varchar(10),
    address varchar(30)
);

insert into students2 values(1, '张三', '中国四川省成都市武侯区武侯大道100号');
insert into students2 values(2, '李四', '中国四川省成都市高新区京城大道100号');
insert into students2 values(3, '王五', '中国四川省成都市高新区天赋大道100号');


-- mysql> select * from students2;
-- +------+--------+-----------------------------------------------------+
-- | id   | name   | address                                             |
-- +------+--------+-----------------------------------------------------+
-- |    1 | 张三   | 中国四川省成都市武侯区武侯大道100号                 |
-- |    2 | 李四   | 中国四川省成都市高新区京城大道100号                 |
-- |    3 | 王五   | 中国四川省成都市高新区天赋大道100号                 |
-- +------+--------+-----------------------------------------------------+
create table students3(
    id int,
    name varchar(10),
    country varchar(10),
    privence varchar(20),
    city varchar(10),
    details varchar(20)
);

insert into students3 values(1, '张三', '中国', '四川省', '成都市', '武侯区武侯大道100号');
insert into students3 values(2, '李四', '中国', '四川省', '成都市', '高新区京城大道100号');
insert into students3 values(3, '王五', '中国', '四川省', '成都市', '高新区天赋大道100号');


-- mysql> select * from students3;
-- +------+--------+---------+-----------+-----------+-----------------------------+
-- | id   | name   | country | privence  | city      | details                     |
-- +------+--------+---------+-----------+-----------+-----------------------------+
-- |    1 | 张三   | 中国    | 四川省    | 成都市    | 武侯区武侯大道100号         |
-- |    2 | 李四   | 中国    | 四川省    | 成都市    | 高新区京城大道100号         |
-- |    3 | 王五   | 中国    | 四川省    | 成都市    | 高新区天赋大道100号         |
-- +------+--------+---------+-----------+-----------+-----------------------------+

--  第一范式,设计的越详细,对于某些实际的操作可能更好,但是不一定都是好处.
-- 2. 第二范式
--  必须是满足第一范式的前提下,第二范式要求,除主键外其他列,只依赖于主键的部分字段
create table order(
    product_id int,
    customer_id int,
    product_name varchar(20),
    customer_name varchar(20),
    primary key(product_id, customer_id)
);
-- 在这张订单表中,product_name只依赖于product_id, customer_name只依赖于customer_id.
-- 也就是说,product_name与customer_id是没有关系的, customer_name和product_id也是没有关系的.
-- 这就不满足第二范式,其他列都必须完全依赖于主键,此时就需要拆表
create table order(
    order_id int primary key,
    product_id int,
    customer_id int
);

create table product(
    id int primary key,
    name varchar(20)
);

create table customer(
    id int primary key,
    name varchar(20)
);

-- 拆分之后, order表中的product_id和customer_id完全依赖于order_id主键,而product和customer表中的其他字段又完全依赖于主键.满足了第二范式.

-- 3. 第三范式
-- 在满足第二范式的前提下,除了主键列之外,其他列之间不能有传递依赖关系.
create table order(
    order_id int primary key,
    product_id int,
    customer_id int,
    customer_phone varchar(15)
);

-- 表中的customer_phone有可能依赖于order_id,customer_id两列,也就不满足第三范式:其他列之间不能有传递依赖关系
-- 拆分

create table order(
    order_id int primary key,
    product_id int,
    customer_id int
);

create table customer(
    id int primary key,
    name varchar(20),
    phone varchar(15)
);

-- 修改后就不存在其他列之间的传递依赖关系，其他列都只依赖于主键列，满足了第三范式的设计！

-- 查询练习

-- 1.准备数据
-- 1.1 创建数据库
-- 学生表Student
-- 学号 sno
-- 姓名 sname
-- 性别 ssex
-- 出生年月日 sbirthday
-- 所在班级 sclass
create table Student(
    sno VARCHAR(20) primary key,
    sname varchar(20) not null,
    ssex varchar(10) not null,
    sbirthday DATE,
    sclass varchar(10)
);
-- 1.2 教师表Teacher
-- 教师编号 tno
-- 教师名字 tname
-- 教师性别 tsex
-- 出生年月日 tbirthday
-- 职称 tprof
-- 所在部门 tdepartment

create table Teacher(
    tno varchar(20) primary key,
    tname varchar(20) not null,
    tsex varchar(10) not null,
    tbirthday DATE,
    tprof varchar(20) not null,
    tdepartment varchar(20) not null
);
-- 1.2 课程表Course
-- 课程号 cno
-- 课程名称 cname
-- 教师编号 tno
create table Course(
    cno varchar(20) PRIMARY key,
    cname varchar(20) not null,
    --教师编号
    tno varchar(20)  not null, 
    -- cno来自于Teacher表中的tno字段
    foreign key(tno) references Teacher(tno)
);
-- 1.4 成绩表Score
-- 学号 sno
-- 课程号 cno
-- 成绩 sdegree
create table Score(
    sno varchar(20) not null,
    cno varchar(20) not null,
    sdegree DECIMAL, --成绩
    -- 该表中sno，cno分别来自于student表中的sno，Course表中的cno
    foreign key(sno) references Student(sno),
    foreign key(cno) references Course(cno),
    -- 设置sno，cno为联合主键
    primary key(sno, cno)
);

-- 注意：建表的代码中不能由以上注释内容，不然会报错。
-- 添加学生表的数据
INSERT INTO Student VALUES('101', '曾华', '男', '1977-09-01', '95033');
INSERT INTO Student VALUES('102', '匡明', '男', '1975-10-02', '95031');
INSERT INTO Student VALUES('103', '王丽', '女', '1976-01-23', '95033');
INSERT INTO Student VALUES('104', '李军', '男', '1976-02-20', '95033');
INSERT INTO Student VALUES('105', '王芳', '女', '1975-02-10', '95031');
INSERT INTO Student VALUES('106', '陆军', '男', '1974-06-03', '95031');
INSERT INTO Student VALUES('107', '王尼玛', '男', '1976-02-20', '95033');
INSERT INTO Student VALUES('108', '张全蛋', '男', '1975-02-10', '95031');
INSERT INTO Student VALUES('109', '赵铁柱', '男', '1974-06-03', '95031');

-- 添加教师数据
INSERT INTO Teacher VALUES('804', '李诚', '男', '1958-12-02', '副教授', '计算机系');
INSERT INTO Teacher VALUES('856', '张旭', '男', '1969-03-12', '讲师', '电子工程系');
INSERT INTO Teacher VALUES('825', '王萍', '女', '1972-05-05', '助教', '计算机系');
INSERT INTO Teacher VALUES('831', '刘冰', '女', '1977-08-14', '助教', '电子工程系');

-- 添加课程表数据
INSERT INTO Course VALUES('3-105', '计算机导论', '825');
INSERT INTO Course VALUES('3-245', '操作系统', '804');
INSERT INTO Course VALUES('6-166', '数字电路', '856');
INSERT INTO Course VALUES('9-888', '高等数学', '831');

-- 添加添加成绩表数据
INSERT INTO Score VALUES('103', '3-105', '92');
INSERT INTO Score VALUES('103', '3-245', '86');
INSERT INTO Score VALUES('103', '6-166', '85');
INSERT INTO Score VALUES('105', '3-105', '88');
INSERT INTO Score VALUES('105', '3-245', '75');
INSERT INTO Score VALUES('105', '6-166', '79');
INSERT INTO Score VALUES('109', '3-105', '76');
INSERT INTO Score VALUES('109', '3-245', '68');
INSERT INTO Score VALUES('109', '6-166', '81');

-- 查询练习
-- 1、查询Student表中所有的记录
select * from Student;
-- 2、查询Student表中所有记录的sname、ssex、和sclass列
select sname, ssex, sclass from Student;

-- +-----------+------+--------+
-- | sname     | ssex | sclass |
-- +-----------+------+--------+
-- | 曾华      | 男   | 95033  |
-- | 匡明      | 男   | 95031  |
-- | 王丽      | 女   | 95033  |
-- | 李军      | 男   | 95033  |
-- | 王芳      | 女   | 95031  |
-- | 陆军      | 男   | 95031  |
-- | 王尼玛    | 男   | 95033  |
-- | 张全蛋    | 男   | 95031  |
-- | 赵铁柱    | 男   | 95031  |
-- +-----------+------+--------+
-- 9 rows in set (0.00 sec)

-- 3. 查询 Teacher 表中不重复的 tdepartment 列
select tdepartment from Teacher; --有重复
-- tdepartment 去重查询
select distinct tdepartment from Teacher;

--4. 查询 Score 表中成绩在60-80之间的所有行（区间查询和运算符查询）
select * from Score where sdegree between 60 and 80;
select * from Score where sdegree > 60 and sdegree < 80;
select * from Score where sdegree > 60 && sdegree < 80;
-- 5. 查询 score 表中成绩为 85, 86 或 88 的行
-- in 查询规定中的多个值
select * from Score where sdegree in (85, 86, 88);

--6.  查询 student 表中 '95031' 班或性别为 '女' 的所有行
-- or 表示或者的关系
select * from Student where sclass='95031' or ssex = '女';
select * from Student where sclass='95031' || ssex = '女';

-- 7. 以 class 降序的方式查询 student 表的所有行
-- Desc:降序 ASC（默认）：升序
select * from Student order by sclass desc;
select * from Student order by sclass asc;
select * from Student order by sclass;

-- 8. 以 c_no 升序、degree 降序查询 score 表的所有行
select * from Score order by cno asc, sdegree desc;

-- 9. 查询 "95031" 班的学生人数
-- COUNT: 统计
select count(*) from Student where sclass = '95031';

-- 10. 查询 score 表中的最高分的学生学号和课程编号（子查询或排序查询）。
-- (SELECT MAX(degree) FROM score): 子查询，算出最高分
select sno, cno from Score where sdegree = (select max(sdegree) from Score);
-- 分两步
-- 1. 找到最高分
select max(sdegree) from Score;
-- 2. 找到最高分的sno和cno
select sno, cno from Score where sdegree=(select max(sdegree) from Score);

-- 排序做法
select sno, cno, sdegree from Score order by sdegree;
select sno, cno, sdegree from Score order by sdegree desc limit 0, 1;
-- limit表示从左闭右开的区间
-- +-----+-------+---------+
-- | sno | cno   | sdegree |
-- +-----+-------+---------+
-- | 103 | 3-105 |      92 |
-- +-----+-------+---------+
-- 1 row in set (0.00 sec)
select sno, cno, sdegree from Score order by sdegree desc limit 0, 2;
-- +-----+-------+---------+
-- | sno | cno   | sdegree |
-- +-----+-------+---------+
-- | 103 | 3-105 |      92 |
-- | 105 | 3-105 |      88 |
-- +-----+-------+---------+
-- 2 rows in set (0.00 sec)

select sno, cno, sdegree from Score order by sdegree desc limit 1, 2;
-- +-----+-------+---------+
-- | sno | cno   | sdegree |
-- +-----+-------+---------+
-- | 105 | 3-105 |      88 |
-- | 103 | 3-245 |      86 |
-- +-----+-------+---------+
-- 11. 查询每门课的平均成绩
-- avg: 平均值
select avg(sdegree) from Score where cno = '3-105';
select avg(sdegree) from Score where cno = '3-245';
select avg(sdegree) from Score where cno = '6-166';
-- select avg(sdegree) from Score where cno = '7-109'; --NULL
select sdegree from Score where cno = '3-105';
-- group by 分组查询
select cno, avg(sdegree) from Score group by cno;
select sno, avg(sdegree) from Score group by sno;

-- 12. 分组条件与模糊查询
-- 查询 `score` 表中至少有 2 名学生选修，并以 3 开头的课程的平均分数。

select * from Score;
-- +-----+-------+---------+
-- | sno | cno   | sdegree |
-- +-----+-------+---------+
-- | 103 | 3-105 |      92 |
-- | 103 | 3-245 |      86 |
-- | 103 | 6-166 |      85 |
-- | 105 | 3-105 |      88 |
-- | 105 | 3-245 |      75 |
-- | 105 | 6-166 |      79 |
-- | 109 | 3-105 |      76 |
-- | 109 | 3-245 |      68 |
-- | 109 | 6-166 |      81 |
-- +-----+-------+---------+

-- 分析表发现，至少有 2 名学生选修的课程是 `3-105` 、`3-245` 、`6-166` ，以 3 开头的课程是 `3-105` 、`3-245` 。
-- 也就是说，我们要查询所有 `3-105` 和 `3-245` 的 `degree` 平均分。

-- 先把cno, avg(sdegree)通过分组查询出来
select cno, avg(sdegree) from Score group by cno;

-- +-------+--------------+
-- | cno   | avg(sdegree) |
-- +-------+--------------+
-- | 3-105 |      85.3333 |
-- | 3-245 |      76.3333 |
-- | 6-166 |      81.6667 |
-- +-------+--------------+
-- 再查询至少由两名学生选修的课程
select cno, avg(sdegree) from Score group by cno
having count(cno) >= 2;
-- 以3开头的课程
-- like表示模糊查询,'%'是通配符,表示后面是任意字符

-- +-------+--------------+
-- | cno   | avg(sdegree) |
-- +-------+--------------+
-- | 3-105 |      85.3333 |
-- | 3-245 |      76.3333 |
-- | 6-166 |      81.6667 |
-- +-------+--------------+
select cno, avg(sdegree) from Score group by cno
having count(cno) >= 2 and cno like '3%';
-- +-------+--------------+
-- | cno   | avg(sdegree) |
-- +-------+--------------+
-- | 3-105 |      85.3333 |
-- | 3-245 |      76.3333 |
-- +-------+--------------+
-- 加上一个 COUNT(*)，表示将每个分组的个数也查询出来。

select cno, avg(sdegree), count(cno) from Score group by cno
having count(cno) >= 2 and cno like '3%';

-- 多表查询
-- 14. 查询所有学生的 `name`，以及该学生在 `score` 表中对应的 `cno` 和 `sdegree`
-- 1.先从Student表中查询处sno及sname
select sno, sname from Student;

-- +-----+-----------+
-- | sno | sname     |
-- +-----+-----------+
-- | 101 | 曾华      |
-- | 102 | 匡明      |
-- | 103 | 王丽      |
-- | 104 | 李军      |
-- | 105 | 王芳      |
-- | 106 | 陆军      |
-- | 107 | 王尼玛    |
-- | 108 | 张全蛋    |
-- | 109 | 赵铁柱    |
-- +-----+-----------+

-- 2. 从Score表中查询sno, cno及sdegree
select sno, cno, sdegree from Score;

-- +-----+-------+---------+
-- | sno | cno   | sdegree |
-- +-----+-------+---------+
-- | 103 | 3-105 |      92 |
-- | 103 | 3-245 |      86 |
-- | 103 | 6-166 |      85 |
-- | 105 | 3-105 |      88 |
-- | 105 | 3-245 |      75 |
-- | 105 | 6-166 |      79 |
-- | 109 | 3-105 |      76 |
-- | 109 | 3-245 |      68 |
-- | 109 | 6-166 |      81 |
-- +-----+-------+---------+
-- 3. 对比发现,1中查询的sno与sname有对应关系, 假如将2中查询的sno对应成1中查询的sname即可
select sname, cno, sdegree from Student, Score where Student.sno = Score.sno;

-- +-----------+-------+---------+
-- | sname     | cno   | sdegree |
-- +-----------+-------+---------+
-- | 王丽      | 3-105 |      92 |
-- | 王丽      | 3-245 |      86 |
-- | 王丽      | 6-166 |      85 |
-- | 王芳      | 3-105 |      88 |
-- | 王芳      | 3-245 |      75 |
-- | 王芳      | 6-166 |      79 |
-- | 赵铁柱    | 3-105 |      76 |
-- | 赵铁柱    | 3-245 |      68 |
-- | 赵铁柱    | 6-166 |      81 |
-- +-----------+-------+---------+
-- 15. 查询所有学生的sno,cname和sdegree列
-- 15.1 查询Course表中的cno和cname
select cno, cname from Course;

-- +-------+-----------------+
-- | cno   | cname           |
-- +-------+-----------------+
-- | 3-105 | 计算机导论      |
-- | 3-245 | 操作系统        |
-- | 6-166 | 数字电路        |
-- | 9-888 | 高等数学        |
-- +-------+-----------------+
-- 15.2 查询Score表中的sno与Sdegree
select sno, cno, sdegree from Score;
-- +-----+-------+---------+
-- | sno | cno   | sdegree |
-- +-----+-------+---------+
-- | 103 | 3-105 |      92 |
-- | 103 | 3-245 |      86 |
-- | 103 | 6-166 |      85 |
-- | 105 | 3-105 |      88 |
-- | 105 | 3-245 |      75 |
-- | 105 | 6-166 |      79 |
-- | 109 | 3-105 |      76 |
-- | 109 | 3-245 |      68 |
-- | 109 | 6-166 |      81 |
-- +-----+-------+---------+
-- 15.3 只要将Score表中的cno替换为Course表中对应的cname即可
select sno, cname, sdegree from Course, Score
where Score.cno = Course.cno;

-- +-----+-----------------+---------+
-- | sno | cname           | sdegree |
-- +-----+-----------------+---------+
-- | 103 | 计算机导论      |      92 |
-- | 105 | 计算机导论      |      88 |
-- | 109 | 计算机导论      |      76 |
-- | 103 | 操作系统        |      86 |
-- | 105 | 操作系统        |      75 |
-- | 109 | 操作系统        |      68 |
-- | 103 | 数字电路        |      85 |
-- | 105 | 数字电路        |      79 |
-- | 109 | 数字电路        |      81 |
-- +-----+-----------------+---------+

-- 16. 查询所有学生的sname, cname, sdegree列
-- sname->Student表
-- cname->Course表
-- sdegree->Score表
select sname, cname, sdegree from Student, Course, Score
where Student.sno = Score.sno and Course.cno = Score.cno;

-- +-----------+-----------------+---------+
-- | sname     | cname           | sdegree |
-- +-----------+-----------------+---------+
-- | 王丽      | 计算机导论      |      92 |
-- | 王丽      | 操作系统        |      86 |
-- | 王丽      | 数字电路        |      85 |
-- | 王芳      | 计算机导论      |      88 |
-- | 王芳      | 操作系统        |      75 |
-- | 王芳      | 数字电路        |      79 |
-- | 赵铁柱    | 计算机导论      |      76 |
-- | 赵铁柱    | 操作系统        |      68 |
-- | 赵铁柱    | 数字电路        |      81 |
-- +-----------+-----------------+---------+

select sname, cname, sdegree, Student.sno, Course.cno from Student, Course, Score
where Student.sno = Score.sno and Course.cno = Score.cno;


-- +-----------+-----------------+---------+-----+-------+
-- | sname     | cname           | sdegree | sno | cno   |
-- +-----------+-----------------+---------+-----+-------+
-- | 王丽      | 计算机导论      |      92 | 103 | 3-105 |
-- | 王丽      | 操作系统        |      86 | 103 | 3-245 |
-- | 王丽      | 数字电路        |      85 | 103 | 6-166 |
-- | 王芳      | 计算机导论      |      88 | 105 | 3-105 |
-- | 王芳      | 操作系统        |      75 | 105 | 3-245 |
-- | 王芳      | 数字电路        |      79 | 105 | 6-166 |
-- | 赵铁柱    | 计算机导论      |      76 | 109 | 3-105 |
-- | 赵铁柱    | 操作系统        |      68 | 109 | 3-245 |
-- | 赵铁柱    | 数字电路        |      81 | 109 | 6-166 |
-- +-----------+-----------------+---------+-----+-------+

-- 17. 查询"95031"班学生每门课程的平均分
select * from Student where sclass = '95031';
-- +-----+-----------+------+------------+--------+
-- | sno | sname     | ssex | sbirthday  | sclass |
-- +-----+-----------+------+------------+--------+
-- | 102 | 匡明      | 男   | 1975-10-02 | 95031  |
-- | 105 | 王芳      | 女   | 1975-02-10 | 95031  |
-- | 106 | 陆军      | 男   | 1974-06-03 | 95031  |
-- | 108 | 张全蛋    | 男   | 1975-02-10 | 95031  |
-- | 109 | 赵铁柱    | 男   | 1974-06-03 | 95031  |
-- +-----+-----------+------+------------+--------+
select sno from Student where sclass ='95031';

-- +-----+
-- | sno |
-- +-----+
-- | 102 |
-- | 105 |
-- | 106 |
-- | 108 |
-- | 109 |
-- +-----+
-- 查到了该班级所有学生的分数
select * from Score where sno in(select sno from Student where sclass ='95031');

-- +-----+-------+---------+
-- | sno | cno   | sdegree |
-- +-----+-------+---------+
-- | 105 | 3-105 |      88 |
-- | 105 | 3-245 |      75 |
-- | 105 | 6-166 |      79 |
-- | 109 | 3-105 |      76 |
-- | 109 | 3-245 |      68 |
-- | 109 | 6-166 |      81 |
-- +-----+-------+---------+
select cno, avg(sdegree) from Score
where sno in (select sno from Student where sclass = '95031')
group by cno;

-- +-------+--------------+
-- | cno   | avg(sdegree) |
-- +-------+--------------+
-- | 3-105 |      82.0000 |
-- | 3-245 |      71.5000 |
-- | 6-166 |      80.0000 |
-- +-------+--------------+

--18. 查询在 `3-105` 课程中，所有成绩高于 `109` 号同学的记录
select sdegree from Score where cno = '3-105' and sno = '109';
-- +---------+
-- | sdegree |
-- +---------+
-- |      76 |
-- +---------+
select *from Score where cno = '3-105' and sdegree > (select sdegree from Score where cno = '3-105' and sno = '109');
-- +-----+-------+---------+
-- | sno | cno   | sdegree |
-- +-----+-------+---------+
-- | 103 | 3-105 |      92 |
-- | 105 | 3-105 |      88 |
-- +-----+-------+---------+

-- 19. 查询成绩高于学号为'109', 课程号为'3-105'的成绩的所有记录.
select * from Score where sdegree >(select sdegree from Score where cno = '3-105' and sno = '109');

-- +-----+-------+---------+
-- | sno | cno   | sdegree |
-- +-----+-------+---------+
-- | 103 | 3-105 |      92 |
-- | 103 | 3-245 |      86 |
-- | 103 | 6-166 |      85 |
-- | 105 | 3-105 |      88 |
-- | 105 | 6-166 |      79 |
-- | 109 | 6-166 |      81 |
-- +-----+-------+---------+
-- 20. 查询所有和 `101` 、`108` 号学生同年出生的 `sno` 、`sname` 、`sbirthday` 列。
-- step1: 从Student表中查询出学号为101和108的记录
select * from Student where sno in(108, 101);

-- +-----+-----------+------+------------+--------+
-- | sno | sname     | ssex | sbirthday  | sclass |
-- +-----+-----------+------+------------+--------+
-- | 101 | 曾华      | 男   | 1977-09-01 | 95033  |
-- | 108 | 张全蛋    | 男   | 1975-02-10 | 95031  |
-- +-----+-----------+------+------------+--------+
-- step2: 取出记录中的年份
select year(sbirthday) from Student where sno in(101, 108);
-- +-----------------+
-- | year(sbirthday) |
-- +-----------------+
-- |            1977 |
-- |            1975 |
-- +-----------------+
select * from Student where year(sbirthday) in (select year(sbirthday) from Student where sno in(101, 108));

-- +-----+-----------+------+------------+--------+
-- | sno | sname     | ssex | sbirthday  | sclass |
-- +-----+-----------+------+------------+--------+
-- | 101 | 曾华      | 男   | 1977-09-01 | 95033  |
-- | 102 | 匡明      | 男   | 1975-10-02 | 95031  |
-- | 105 | 王芳      | 女   | 1975-02-10 | 95031  |
-- | 108 | 张全蛋    | 男   | 1975-02-10 | 95031  |
-- +-----+-----------+------+------------+--------+


-- 21. 查询 `'张旭'` 教师任课的学生成绩表
-- step1: 先找到教师编号
select tno from Teacher where tname = '张旭';
-- step2: 找到教师对应的课程
select * from Course where tno in(
    select tno from Teacher where tname = '张旭'
);
select cno from Course where tno in(select tno from Teacher where tname = '张旭');
-- setp3: 找到该课程对应的成绩
select * from Score where cno in(
    select cno from Course where tno in(select tno from Teacher where tname = '张旭')
);

-- 21. 查询某选修课程多于5个同学的教师姓名
-- mysql> select * from Score;
-- +-----+-------+---------+
-- | sno | cno   | sdegree |
-- +-----+-------+---------+
-- | 103 | 3-105 |      92 |
-- | 103 | 3-245 |      86 |
-- | 103 | 6-166 |      85 |
-- | 105 | 3-105 |      88 |
-- | 105 | 3-245 |      75 |
-- | 105 | 6-166 |      79 |
-- | 109 | 3-105 |      76 |
-- | 109 | 3-245 |      68 |
-- | 109 | 6-166 |      81 |
-- +-----+-------+---------+
-- mysql> select * from Teacher;
-- +-----+--------+------+------------+-----------+-----------------+
-- | tno | tname  | tsex | tbirthday  | tprof     | tdepartment     |
-- +-----+--------+------+------------+-----------+-----------------+
-- | 804 | 李诚   | 男   | 1958-12-02 | 副教授    | 计算机系        |
-- | 825 | 王萍   | 女   | 1972-05-05 | 助教      | 计算机系        |
-- | 831 | 刘冰   | 女   | 1977-08-14 | 助教      | 电子工程系      |
-- | 856 | 张旭   | 男   | 1969-03-12 | 讲师      | 电子工程系      |
-- +-----+--------+------+------------+-----------+-----------------+

-- mysql> select * from Course;
-- +-------+-----------------+-----+
-- | cno   | cname           | tno |
-- +-------+-----------------+-----+
-- | 3-105 | 计算机导论      | 825 |
-- | 3-245 | 操作系统        | 804 |
-- | 6-166 | 数字电路        | 856 |
-- | 9-888 | 高等数学        | 831 |
-- +-------+-----------------+-----+
INSERT INTO Score VALUES('101', '3-105', '92');
INSERT INTO Score VALUES('102', '3-105', '90');
INSERT INTO Score VALUES('104', '3-105', '85');

-- +-----+-------+---------+
-- | sno | cno   | sdegree |
-- +-----+-------+---------+
-- | 101 | 3-105 |      92 |
-- | 102 | 3-105 |      90 |
-- | 103 | 3-105 |      92 |
-- | 103 | 3-245 |      86 |
-- | 103 | 6-166 |      85 |
-- | 104 | 3-105 |      85 |
-- | 105 | 3-105 |      88 |
-- | 105 | 3-245 |      75 |
-- | 105 | 6-166 |      79 |
-- | 109 | 3-105 |      76 |
-- | 109 | 3-245 |      68 |
-- | 109 | 6-166 |      81 |
-- +-----+-------+---------+
-- step1: 查找所有的课程号
select cno from Score group by cno;
-- +-------+
-- | cno   |
-- +-------+
-- | 3-105 |
-- | 3-245 |
-- | 6-166 |
-- +-------+
select cno from Score group by cno having count(cno) > 5;
-- +-------+
-- | cno   |
-- +-------+
-- | 3-105 |
-- +-------+
-- step2: 通过cno在Course表中找到对应的tno
select tno from Course where cno in(select cno from Score group by cno having count(cno) > 5);
-- +-----+
-- | tno |
-- +-----+
-- | 825 |
-- +-----+

-- step3: 通过tno在表Teacher找到tname
select tname from Teacher where tno in(select tno from Course where cno in(select cno from Score group by cno having count(cno) > 5));
-- +--------+
-- | tname  |
-- +--------+
-- | 王萍   |
-- +--------+

select * from Teacher where tno in(select tno from Course where cno in(select cno from Score group by cno having count(cno) > 5));

-- +-----+--------+------+------------+--------+--------------+
-- | tno | tname  | tsex | tbirthday  | tprof  | tdepartment  |
-- +-----+--------+------+------------+--------+--------------+
-- | 825 | 王萍   | 女   | 1972-05-05 | 助教   | 计算机系     |
-- +-----+--------+------+------------+--------+--------------+
-- 23. 查询95033班和95031班全体学生的记录
INSERT INTO Student VALUES('110', '张飞', '男', '1977-09-01', '95038');
select * from Student where sclass in ('95033', '95031');

-- 24. 查询存在有85分以上成绩的课程cno
select * from Score;
select cno from Score where sdegree > 85;
-- +-------+
-- | cno   |
-- +-------+
-- | 3-105 |
-- | 3-105 |
-- | 3-105 |
-- | 3-245 |
-- | 3-105 |
-- +-------+

-- 25. 查询'计算机系'教师所教课程的成绩表
-- step1: 从Teacher表中找到计算机系的记录
select * from Teacher where tdepartment = '计算机系';
select tno from Teacher where tdepartment = '计算机系';
-- +-----+
-- | tno |
-- +-----+
-- | 804 |
-- | 825 |
-- +-----+
-- step2: 从Course表中找到tno对应的cno
select cno from Course where tno in (select tno from Teacher where tdepartment = '计算机系');
-- +-------+
-- | cno   |
-- +-------+
-- | 3-245 |
-- | 3-105 |
-- +-------+
-- step3: 从Score表中找到cno对应的成绩记录
select * from Score where cno in (select cno from Course where tno in (select tno from Teacher where tdepartment = '计算机系'));
-- +-----+-------+---------+
-- | sno | cno   | sdegree |
-- +-----+-------+---------+
-- | 103 | 3-245 |      86 |
-- | 105 | 3-245 |      75 |
-- | 109 | 3-245 |      68 |
-- | 101 | 3-105 |      92 |
-- | 102 | 3-105 |      90 |
-- | 103 | 3-105 |      92 |
-- | 104 | 3-105 |      85 |
-- | 105 | 3-105 |      88 |
-- | 109 | 3-105 |      76 |
-- +-----+-------+---------+

-- 26. 查询'计算机系'与'电子工程系'不同职称的教师的tname和tprof 即去掉职称相同的中间两条
-- +-----+--------+------+------------+-----------+-----------------+
-- | tno | tname  | tsex | tbirthday  | tprof     | tdepartment     |
-- +-----+--------+------+------------+-----------+-----------------+
-- | 804 | 李诚   | 男   | 1958-12-02 | 副教授    | 计算机系        |
-- | 825 | 王萍   | 女   | 1972-05-05 | 助教      | 计算机系        |
-- | 831 | 刘冰   | 女   | 1977-08-14 | 助教      | 电子工程系      |
-- | 856 | 张旭   | 男   | 1969-03-12 | 讲师      | 电子工程系      |
-- +-----+--------+------+------------+-----------+-----------------+
-- step1: 分别查找Teacher表中'计算机系'与'电子工程系'的tprof
select tprof from Teacher where tdepartment = '计算机系';
-- +-----------+
-- | tprof     |
-- +-----------+
-- | 副教授    |
-- | 助教      |
-- +-----------+
-- step2: 找到在计算机系但是职称不在电子工程系的记录
select * from Teacher where tdepartment = '计算机系' and tprof not in(select tprof from Teacher where tdepartment = '电子工程系');
-- step3: 找到在电子工程系但是职称不在计算机系的记录

select * from Teacher where tdepartment = '电子工程系' and tprof not in(select tprof from Teacher where tdepartment = '计算机系');
-- +-----+--------+------+------------+--------+-----------------+
-- | tno | tname  | tsex | tbirthday  | tprof  | tdepartment     |
-- +-----+--------+------+------------+--------+-----------------+
-- | 856 | 张旭   | 男   | 1969-03-12 | 讲师   | 电子工程系      |
-- +-----+--------+------+------------+--------+-----------------+
-- step4: 用union将两者结合起来
select * from Teacher where tdepartment = '计算机系' and tprof not in(select tprof from Teacher where tdepartment = '电子工程系')
union
select * from Teacher where tdepartment = '电子工程系' and tprof not in(select tprof from Teacher where tdepartment = '计算机系');
-- +-----+--------+------+------------+-----------+-----------------+
-- | tno | tname  | tsex | tbirthday  | tprof     | tdepartment     |
-- +-----+--------+------+------------+-----------+-----------------+
-- | 804 | 李诚   | 男   | 1958-12-02 | 副教授    | 计算机系        |
-- | 856 | 张旭   | 男   | 1969-03-12 | 讲师      | 电子工程系      |
-- +-----+--------+------+------------+-----------+-----------------+

-- 27. 查询课程编号为'3-105' 课程且成绩至少高于课程编号为'3-245'的同学的cno,sno和sdegree,并且按照sdegree从高到低排序.
select * from Score where cno = '3-245';
-- +-----+-------+---------+
-- | sno | cno   | sdegree |
-- +-----+-------+---------+
-- | 103 | 3-245 |      86 |
-- | 105 | 3-245 |      75 |
-- | 109 | 3-245 |      68 |
-- +-----+-------+---------+
select * from Score where cno = '3-105';
-- +-----+-------+---------+
-- | sno | cno   | sdegree |
-- +-----+-------+---------+
-- | 101 | 3-105 |      92 |
-- | 102 | 3-105 |      90 |
-- | 103 | 3-105 |      92 |
-- | 104 | 3-105 |      85 |
-- | 105 | 3-105 |      88 |
-- | 109 | 3-105 |      76 |
-- +-----+-------+---------+
-- 至少?大于其中至少一个,用any
select * from Score where cno = '3-105' and sdegree >any(select sdegree from Score where cno = '3-245');
-- 最小值为76, 大于上表中的其中一个即可
-- +-----+-------+---------+
-- | sno | cno   | sdegree |
-- +-----+-------+---------+
-- | 101 | 3-105 |      92 |
-- | 102 | 3-105 |      90 |
-- | 103 | 3-105 |      92 |
-- | 104 | 3-105 |      85 |
-- | 105 | 3-105 |      88 |
-- | 109 | 3-105 |      76 |
-- +-----+-------+---------+
select * from Score where cno = '3-105' and sdegree >any(select sdegree from Score where cno = '3-245')
order by sdegree desc;

-- +-----+-------+---------+
-- | sno | cno   | sdegree |
-- +-----+-------+---------+
-- | 101 | 3-105 |      92 |
-- | 103 | 3-105 |      92 |
-- | 102 | 3-105 |      90 |
-- | 105 | 3-105 |      88 |
-- | 104 | 3-105 |      85 |
-- | 109 | 3-105 |      76 |
-- +-----+-------+---------+

-- 34. 查询Student表中不姓王的同学记录
select * from Student where sname not like '王%';

-- +-----+-----------+------+------------+--------+
-- | sno | sname     | ssex | sbirthday  | sclass |
-- +-----+-----------+------+------------+--------+
-- | 101 | 曾华      | 男   | 1977-09-01 | 95033  |
-- | 102 | 匡明      | 男   | 1975-10-02 | 95031  |
-- | 104 | 李军      | 男   | 1976-02-20 | 95033  |
-- | 106 | 陆军      | 男   | 1974-06-03 | 95031  |
-- | 108 | 张全蛋    | 男   | 1975-02-10 | 95031  |
-- | 109 | 赵铁柱    | 男   | 1974-06-03 | 95031  |
-- | 110 | 张飞      | 男   | 1977-09-01 | 95038  |
-- +-----+-----------+------+------------+--------+

-- 35. 查询Student表中每个学生的姓名和年龄
select year(now());
-- +-------------+
-- | year(now()) |
-- +-------------+
-- |        2020 |
-- +-------------+
select year(sbirthday) from Student;
select sname, year(now()) - year(sbirthday) as Age from Student;

-- 36. 查询Student表中最大和最小的是sbirthday日期值
select sbirthday from Student;
select max(sbirthday) as '最小年龄', min(sbirthday) as '最大年龄' from Student;

-- 37, 以班号和年龄从大到小顺序查询Student表中的全部记录
select * from Student order by sclass desc, sbirthday;

-- 39. 查询最高分同学的sno,cno和sdegree列
select max(sdegree) from Score;
select sno, cno, sdegree from Score where sdegree = (select max(sdegree) from Score);


-- 按等级查询

-- 建立一个grade表代表学生的成绩等级,并插入数据:
CREATE table grade(
    low int,
    up int,
    grade char(1)
);
INSERT INTO grade VALUES (90, 100, 'A');
INSERT INTO grade VALUES (80, 89, 'B');
INSERT INTO grade VALUES (70, 79, 'C');
INSERT INTO grade VALUES (60, 69, 'D');
INSERT INTO grade VALUES (0, 59, 'E');

-- 查询所有学生的sno,cno和grade列

select sno, cno, sdegree, grade from Score, grade where sdegree between low and up;



-- 事务
-- ==============================================================================
-- 在mysql中,事务是一个最小的不可分割的工作单元.事务能够保证一个业务的完整性,
-- 比如,银行转账
-- a -> -100
update user set money = money - 100 where name = 'a';
-- b -> +100
update user set money = money + 100 where name = 'b';
-- 在实际项目中,假设只有一条sql语句执行成功,而另一条失败了,就会出现数据前后的不一致
-- 因此,在执行多条有关sql语句时,事务可能会要求这些sql语句要么同事执行成功,要么都执行失败.
-- 如何控制事务-commit/rollback
-- 在mysql中,事务的自动提交状态默认是开启的
-- 查询事务自动提交状态
select @@autocommit;

-- +--------------+
-- | @@autocommit |
-- +--------------+
-- |            1 |
-- +--------------+

-- 自动提交的作用: 当我们执行一条sql语句的时候, 其产生的效果会立即体现出来, 且不能回滚.
-- 回滚例子:
create database bank;
use bank;
create table user(
    id int primary key,
    name varchar(20),
    money int
);

insert into user values(1, 'a', 1000);

-- +----+------+-------+
-- | id | name | money |
-- +----+------+-------+
-- |  1 | a    |  1000 |
-- +----+------+-------+

-- 可以看到，在执行插入语句后数据立刻生效，原因是 MySQL 中的事务自动将它**提交**到了数据库中。
-- 那么所谓**回滚**的意思就是，撤销执行过的所有 SQL 语句，使其回滚到**最后一次提交**数据时的状态。
-- 在mysql中使用rollback执行回滚

-- 回滚到最后一次提交
rollback;
-- 由于所执行的sql语句已经被commit过了,所以数据并没有发生回滚.
-- +----+------+-------+
-- | id | name | money |
-- +----+------+-------+
-- |  1 | a    |  1000 |
-- +----+------+-------+

-- 如何让数据可以发生回滚? 关闭自动提交
-- 关闭自动提交
set autocommit = 0;
-- 查询自动提交状态

select @@autocommit;
INSERT INTO user VALUES (2, 'b', 1000);
select * from user;
-- +----+------+-------+
-- | id | name | money |
-- +----+------+-------+
-- |  1 | a    |  1000 |
-- |  2 | b    |  1000 |
-- +----+------+-------+

-- 然后执行rollback之后又回到了原来的状态
rollback;
-- +----+------+-------+
-- | id | name | money |
-- +----+------+-------+
-- |  1 | a    |  1000 |
-- +----+------+-------+

-- 如何将虚拟的数据真正的提交到数据库中? 使用commit:
insert into user values(2, 'b', 1000);
commit;
-- 提交后回滚
rollback;
-- 再次查询(回滚无效)

-- +----+------+-------+
-- | id | name | money |
-- +----+------+-------+
-- |  1 | a    |  1000 |
-- |  2 | b    |  1000 |
-- +----+------+-------+
-- 事务的实际应用

-- 转账
UPDATE user set money = money - 100 WHERE name = 'a';

-- 到账
UPDATE user set money = money + 100 WHERE name = 'b';

-- mysql> select *from user;
-- +----+------+-------+
-- | id | name | money |
-- +----+------+-------+
-- |  1 | a    |   900 |
-- |  2 | b    |  1100 |
-- +----+------+-------+
-- 2 rows in set (0.00 sec)

-- mysql> rollback;
-- Query OK, 0 rows affected (0.00 sec)

-- mysql> select *from user;
-- +----+------+-------+
-- | id | name | money |
-- +----+------+-------+
-- |  1 | a    |  1000 |
-- |  2 | b    |  1000 |
-- +----+------+-------+

-- 手动开启事务: begin/start transaction
-- 事务的默认提交被开启 ( `@@AUTOCOMMIT = 1` ) 后，此时就不能使用事务回滚了。但是我们还可以手动开启一个事务处理事件，使其可以发生回滚：

-- 使用 BEGIN 或者 START TRANSACTION 手动开启一个事务
-- START TRANSACTION;
start transaction;
UPDATE user set money = money - 100 WHERE name = 'a';
UPDATE user set money = money + 100 WHERE name = 'b';
-- 由于手动开启的事务没有开启自动提交，
-- 此时发生变化的数据仍然是被保存在一张临时表中。
-- 测试回滚
rollback;
-- +----+------+-------+
-- | id | name | money |
-- +----+------+-------+
-- |  1 | a    |  1000 |
-- |  2 | b    |  1000 |
-- +----+------+-------+
-- 仍然使用commit提交数据,提交后无法再次发生本次事务的回滚

start transaction;
UPDATE user set money = money - 100 WHERE name = 'a';
UPDATE user set money = money + 100 WHERE name = 'b';
commit;
-- 测试无法回滚

-- 事务的ACID特征与使用
-- 事务的四大特性:
-- 1: A 原子性: 事务是最小的单位,不可以再分割
-- 2. B 一致性: 要求同一事务中的sql语句,必须保证同时成功或者失败
-- 3. I 隔离性: 事务1和事务2之间是具有隔离性的.
-- 4. D 持久性: 事务一旦结束(commit), 就不可以再返回了(rollback)


-- 事务的隔离性:
-- 事务的隔离性可分为四中(性能从高到低):
-- 1. read uncommitted(读取未提交)
--  如果有多个事务, 那么任意事务都可以看见其他事务的未提交数据.
-- 2. read committed(读取已提交)
-- 只能读取到其他事务**已经提交的数据
-- 3. repeatable read(可被重复读)
-- 如果有多个连接都开启了事务，那么事务之间不能共享数据记录，否则只能共享已提交的记录
-- 4. serializable(串行化)
-- 所有的事务都会按照固定的顺序执行，执行完毕一个事务后再继续执行下一个事务的写入操作。

-- 查看当前数据库默认的隔离级别
-- GLOBAL 表示系统级别，不加表示会话级别。
select @@global.transaction_isolation;
select @@transaction_isolation;
-- +--------------------------------+
-- | @@global.transaction_isolation |
-- +--------------------------------+
-- | REPEATABLE-READ                |
-- +--------------------------------+
-- 修改系统隔离级别(大写有效)
SET GLOBAL TRANSACTION ISOLATION LEVEL READ UNCOMMITTED; 
select @@global.TRANSACTION_ISOLATION;


-- 脏读

INSERT INTO user VALUES (3, '小明', 1000);
INSERT INTO user VALUES (4, '淘宝店', 1000);

-- +----+-----------+-------+
-- | id | name      | money |
-- +----+-----------+-------+
-- |  1 | a         |  1000 |
-- |  2 | b         |  1000 |
-- |  3 | 小明      |  1000 |
-- |  4 | 淘宝店    |  1000 |
-- +----+-----------+-------+

-- 开启一个事务操作数据
-- 假设小明在淘宝店买了一双800块钱的鞋子：
start TRANSACTION;
UPDATE user SET money = money - 800 WHERE name = '小明';
UPDATE user SET money = money + 800 WHERE name = '淘宝店';

-- 在小明未执行commit之前，在淘宝的另一方查询结果，发现钱已经到账
select * from user;
-- +----+-----------+-------+
-- | id | name      | money |
-- +----+-----------+-------+
-- |  1 | a         |  1000 |
-- |  2 | b         |  1000 |
-- |  3 | 小明      |   200 |
-- |  4 | 淘宝店    |  1800 |
-- +----+-----------+-------+

-- 由于小明的转账是在新开启的事务上进行操作的，而该操作的结果是可以被其他事务（另一方的淘宝店）看见的，
-- 因此淘宝店的查询结果是正确的，淘宝店确认到账。但就在这时，如果小明在它所处的事务上又执行了 `ROLLBACK` 命令，会发生什么？

-- 小明所处的事务执行：
rollback;
-- 此时无论是淘宝还是小明，查询的结果都恢复到了原来。

-- +----+-----------+-------+
-- | id | name      | money |
-- +----+-----------+-------+
-- |  1 | a         |  1000 |
-- |  2 | b         |  1000 |
-- |  3 | 小明      |  1000 |
-- |  4 | 淘宝店    |  1000 |
-- +----+-----------+-------+
-- 此种现象就被称为脏读，一个事务读取到了另外一个事务还未提交的数据。这在实际开发中是不允许出现的。

-- 读取已经提交的.
-- 把隔离级别设置为read committed;
SET GLOBAL TRANSACTION ISOLATION LEVEL READ COMMITTED;


-- mysql> select @@global.TRANSACTION_ISOLATION;
-- +--------------------------------+
-- | @@global.TRANSACTION_ISOLATION |
-- +--------------------------------+
-- | READ-COMMITTED                 |
-- +--------------------------------+


-- 这样，再有新的事务连接进来时，它们就只能查询到已经提交过的事务数据了。
-- 但是对于当前事务来说，它们看到的还是未提交的数据，例如：
--  正在操作数据事务（当前事务）
start TRANSACTION;
UPDATE user SET money = money - 800 WHERE name = '小明';
UPDATE user SET money = money + 800 WHERE name = '淘宝店';
-- 虽然隔离级别被设置了READ COMMITTED,但在当前事务中,它看到的仍然是数据表中历史改变的数据,而不是真正提交过的数据
-- mysql> select * from user;
-- +----+-----------+-------+
-- | id | name      | money |
-- +----+-----------+-------+
-- |  1 | a         |  1000 |
-- |  2 | b         |  1000 |
-- |  3 | 小明      |   200 |
-- |  4 | 淘宝店    |  1800 |
-- +----+-----------+-------+

-- 假设此时在远程开启了一个新事务，连接到数据库。

-- 此时远程连接查询到的数据只能是已经提交过的
-- mysql> select * from user;
-- +----+-----------+-------+
-- | id | name      | money |
-- +----+-----------+-------+
-- |  1 | a         |  1000 |
-- |  2 | b         |  1000 |
-- |  3 | 小明      |  1000 |
-- |  4 | 淘宝店    |  1000 |
-- +----+-----------+-------+

-- 但是这样还有问题，那就是假设一个事务在操作数据时，其他事务干扰了这个事务的数据。例如：

-- 小张在查询数据的时候发现：
SELECT * FROM user;
-- +----+-----------+-------+
-- | id | name      | money |
-- +----+-----------+-------+
-- |  1 | a         |   900 |
-- |  2 | b         |  1100 |
-- |  3 | 小明      |   200 |
-- |  4 | 淘宝店    |  1800 |
-- +----+-----------+-------+

-- 在小张求表的 money 平均值之前，小王做了一个操作：
START TRANSACTION;
INSERT INTO user VALUES (5, 'c', 100);
COMMIT;

-- 此时表的真实数据是：
SELECT * FROM user;
-- +----+-----------+-------+
-- | id | name      | money |
-- +----+-----------+-------+
-- |  1 | a         |   900 |
-- |  2 | b         |  1100 |
-- |  3 | 小明      |  1000 |
-- |  4 | 淘宝店    |  1000 |
-- |  5 | c         |   100 |
-- +----+-----------+-------+

-- 这时小张再求平均值的时候，就会出现计算不相符合的情况：
SELECT AVG(money) FROM user;
-- +------------+
-- | AVG(money) |
-- +------------+
-- |  820.0000  |
-- +------------+

-- 虽然 **READ COMMITTED** 让我们只能读取到其他事务已经提交的数据，但还是会出现问题，
-- 就是**在读取同一个表的数据时，可能会发生前后不一致的情况。这被称为不可重复读现象 (READ COMMITTED ) 。


-- 幻读(Ver 8.0.21没有幻读现象)
-- 将隔离级别设置为 REPEATABLE READ(可被重复读)
SET GLOBAL TRANSACTION ISOLATION LEVEL REPEATABLE READ;

-- +--------------------------------+
-- | @@global.transaction_isolation |
-- +--------------------------------+
-- | REPEATABLE-READ                |
-- +--------------------------------+

-- 测试 **REPEATABLE READ** ，假设在两个不同的连接上分别执行 `START TRANSACTION` :
-- A --- 成都
START TRANSACTION;
INSERT into user VALUES(6, 'd', 1000);
INSERT into user VALUES(7, 'e', 50);
INSERT into user VALUES(8, 'f', 60);
INSERT into user VALUES(9, 'f', 100);
INSERT into user VALUES(10, 'fg', 80);
INSERT into user VALUES(11, 'h', 80);
INSERT into user VALUES(12, 'g', 80);
INSERT into user VALUES(13, 'fff', 80);
INSERT into user VALUES(13, 'ggf', 80);








-- B --- 北京
START TRANSACTION;

-- A
COMMIT;
-- 在A提交之前, 假如B执行与A有冲突的动作, B会阻塞, 直到A执行COMMIT, B会报错,  Duplicate entry '13' for key 'user.PRIMARY'
-- 但假如是与A不同的动作, 则不会阻塞, 执行成功,
-- 且通过查询只能查询到自己当前事务未提交的数据, 对方未提交的数据是看不到的.
-- B                            A
-- +----+-----------+-------+   +----+-----------+-------+
-- | id | name      | money |   | id | name      | money |
-- +----+-----------+-------+   +----+-----------+-------+
-- |  1 | a         |  1000 |   |  1 | a         |  1000 |
-- |  2 | b         |  1000 |   |  2 | b         |  1000 |
-- |  3 | 小明      |   200 |   |  3 | 小明      |   200 |
-- |  4 | 淘宝店    |  1800 |   |  4 | 淘宝店    |  1800 |
-- |  6 | d         |  1000 |   |  6 | d         |  1000 |
-- |  7 | e         |    50 |   |  7 | e         |    50 |
-- |  8 | f         |    60 |   |  8 | f         |    60 |
-- |  9 | f         |   100 |   |  9 | f         |   100 |
-- | 10 | fg        |    80 |   | 10 | fg        |    80 |
-- | 12 | g         |    80 |   | 11 | h         |    80 |
-- +----+-----------+-------+   +----+-----------+-------+


-- 串行化
-- 顾名思义，就是所有事务的**写入操作**全都是串行化的。什么意思？把隔离级别修改成 **SERIALIZABLE** :

SET GLOBAL TRANSACTION ISOLATION LEVEL SERIALIZABLE;
SELECT @@GLOBAL.TRANSACTION_ISOLATION;
-- +--------------------------------+
-- | @@GLOBAL.TRANSACTION_ISOLATION |
-- +--------------------------------+
-- | SERIALIZABLE                   |
-- +--------------------------------+
-- 两个事务都在执行操作,

--  A 开启事务
START TRANSACTION;
-- B 开启事务

--  A 执行
INSERT INTO user VALUES (15, '王小花', 1000);
INSERT INTO user VALUES (17, '王小花', 1000);

-- B 执行

INSERT INTO user VALUES (16, '王小花', 1000);
INSERT INTO user VALUES (18, '王小花', 1000);

-- 当前版本在执行不同的操作时，不会发生阻塞现象，可能是内部做了优化。


-- 连接查询
-- 准备数据
create DATABASE testjoin;

CREATE TABLE person (
    id INT,
    name VARCHAR(20),
    cardId INT
);

CREATE TABLE card (
    id INT,
    name VARCHAR(20)
);

INSERT INTO person VALUES (1, '张三', 1), (2, '李四', 3), (3, '王五', 6);

INSERT INTO card VALUES (1, '饭卡'), (2, '建行卡'), (3, '农行卡'), (4, '工商卡'), (5, '邮政卡');


SELECT * FROM card;
-- +------+-----------+
-- | id   | name      |
-- +------+-----------+
-- |    1 | 饭卡      |
-- |    2 | 建行卡    |
-- |    3 | 农行卡    |
-- |    4 | 工商卡    |
-- |    5 | 邮政卡    |
-- +------+-----------+
select * from person
-- +------+--------+--------+
-- | id   | name   | cardId |
-- +------+--------+--------+
-- |    1 | 张三   |      1 |
-- |    2 | 李四   |      3 |
-- |    3 | 王五   |      6 |
-- +------+--------+--------+
-- `person` 表并没有为 `cardId` 字段设置一个在 `card` 表中对应的 `id` 外键。
-- 如果设置了的话，`person` 中 `cardId` 字段值为 `6` 的行就插不进去，因为该 `cardId` 值在 `card` 表中并没有

-- 内连接
-- 要查询这两张表中有关系的数据，可以使用 `INNER JOIN` ( 内连接 ) 将它们连接在一起

-- INNER JOIN: 表示为内连接，将两张表拼接在一起。
-- on: 表示要执行某个条件。
select * from person inner join card on person.cardid = card.id;

-- +------+--------+--------+------+-----------+
-- | id   | name   | cardId | id   | name      |
-- +------+--------+--------+------+-----------+
-- |    1 | 张三   |      1 |    1 | 饭卡      |
-- |    2 | 李四   |      3 |    3 | 农行卡    |
-- +------+--------+--------+------+-----------+

-- 左外连接
-- +------+--------+--------+------+-----------+
-- | id   | name   | cardId | id   | name      |
-- +------+--------+--------+------+-----------+
-- |    1 | 张三   |      1 |    1 | 饭卡      |
-- |    2 | 李四   |      3 |    3 | 农行卡    |
-- +------+--------+--------+------+-----------+
-- LEFT JOIN 也叫做 LEFT OUTER JOIN，用这两种方式的查询结果是一样的。
select * from person left join card on person.cardid = card.id;

-- +------+--------+--------+------+-----------+
-- | id   | name   | cardId | id   | name      |
-- +------+--------+--------+------+-----------+
-- |    1 | 张三   |      1 |    1 | 饭卡      |
-- |    2 | 李四   |      3 |    3 | 农行卡    |
-- |    3 | 王五   |      6 | NULL | NULL      |
-- +------+--------+--------+------+-----------+


-- 右外链接
-- 完整显示右边的表 ( `card` ) ，左边的表如果符合条件就显示，不符合则补 `NULL`
select * from person RIGHT JOIN card on person.cardid = card.id;

-- +------+--------+--------+------+-----------+
-- | id   | name   | cardId | id   | name      |
-- +------+--------+--------+------+-----------+
-- |    1 | 张三   |      1 |    1 | 饭卡      |
-- | NULL | NULL   |   NULL |    2 | 建行卡    |
-- |    2 | 李四   |      3 |    3 | 农行卡    |
-- | NULL | NULL   |   NULL |    4 | 工商卡    |
-- | NULL | NULL   |   NULL |    5 | 邮政卡    |
-- +------+--------+--------+------+-----------+

-- 全外连接
-- 完整显示两张的全部数据
-- MySQL 不支持这种语法的全外连接
-- SELECT * FROM person FULL JOIN card on person.cardId = card.id;
-- 出现错误：
-- ERROR 1054 (42S22): Unknown column 'person.cardId' in 'on clause'
-- MySQL全连接语法，使用 UNION 将两张表合并在一起。

SELECT * FROM person LEFT JOIN card on person.cardId = card.id
UNION
SELECT * FROM person RIGHT JOIN card on person.cardId = card.id;

-- +------+--------+--------+------+-----------+
-- | id   | name   | cardId | id   | name      |
-- +------+--------+--------+------+-----------+
-- |    1 | 张三   |      1 |    1 | 饭卡      |
-- |    2 | 李四   |      3 |    3 | 农行卡    |
-- |    3 | 王五   |      6 | NULL | NULL      |
-- | NULL | NULL   |   NULL |    2 | 建行卡    |
-- | NULL | NULL   |   NULL |    4 | 工商卡    |
-- | NULL | NULL   |   NULL |    5 | 邮政卡    |
-- +------+--------+--------+------+-----------+
