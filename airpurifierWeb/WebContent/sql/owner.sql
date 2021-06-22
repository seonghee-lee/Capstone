USE JSPBookDB;

create table OWNER ( 
    owner_id varchar(45) not null,
    owner_pw varchar(45) not null,   
    owner_name varchar(45) not null,   
    owner_add varchar(50) not null,   
    owner_phone varchar(50) not null,
    primary key(owner_id) 
) default CHARSET=utf8;

ALTER TABLE owner add owner_phone varchar(50) not null
INSERT INTO owner(owner_id,  owner_pw, owner_name, owner_phone, owner_add) VALUES ('domino', '1234', '도미노', '010-1234-1234','경기도 시흥시 산기대학로 237' );

select * from owner;
drop table owner;
