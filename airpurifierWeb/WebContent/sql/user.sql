USE testdb;

create table user ( 
    user_id varchar(45) not null,
    user_pw varchar(45) not null,   
    user_name varchar(45) not null,   
    user_phone varchar(50) not null,   
    primary key(user_id) 
    
) default CHARSET=utf8;

INSERT INTO user(user_id,  user_pw, user_name, user_phone) VALUES ('user1', '1234', '홍길', '010-1234-1000');

select * from user;

ALTER DATABASE JSPBookDB DEFAULT CHARACTER SET utf8;