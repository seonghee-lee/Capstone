select * from owner;
select * from user;
select * from review;
select * from u_report;
select * from o_report;

ALTER TABLE review ADD w_time TIMESTAMP NOT NULL;

use JSPBookDB;
CREATE TABLE `u_report` (
  `num` varchar(45) NOT NULL,
  `title` varchar(45) NOT NULL,
  `user_id` varchar(45) NOT NULL,
  `owner_name` varchar(45) NOT NULL,
  `memo` varchar(45) NOT NULL,
  ur_time TIMESTAMP,
  PRIMARY KEY (`num`)
) DEFAULT CHARSET=utf8;

CREATE TABLE `o_report` (
  `num`varchar(45) NOT NULL,
  `title` varchar(45) NOT NULL,
  `owner_id` varchar(45) NOT NULL,
  `user_id` varchar(45) NOT NULL,
  `memo` varchar(45) NOT NULL,
  or_time TIMESTAMP,
  PRIMARY KEY (`num`)
) DEFAULT CHARSET=utf8;

CREATE TABLE `review` (
  `num` int(11) NOT NULL,
  `title` varchar(45) DEFAULT NULL,
  `user_id` varchar(45) DEFAULT NULL,
  `owner_name` varchar(45) DEFAULT NULL,
  `memo` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

drop table u_report, o_report;