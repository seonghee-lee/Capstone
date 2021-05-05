#명령문
SELECT * FROM testdb.test_table;
desc testdb.test_table;

alter table test_table add id int(10) not null;
alter table test_table add spot int(10) not null;
alter table test_table add pmsdata int(10) not null;
alter table test_table add date datetime not null; 

drop table test_table;

#테이블 생성 
Create table test_table(
		id int(10) not null auto_increment,
		spot int(10) not null,
		pmsdata int(10) not null,
		date datetime not null,
    primary key(id));
    
#test용 데이터 추가   
  
INSERT INTO test_table(spot,pmsdata,date) VALUES(1,14,NOW());
INSERT INTO test_table(spot,pmsdata,date) VALUES(3,25,NOW());
INSERT INTO test_table(spot,pmsdata,date) VALUES(2,39,NOW());
INSERT INTO test_table(spot,pmsdata,date) VALUES(1,69,NOW());
INSERT INTO test_table(spot,pmsdata,date) VALUES(2,100,NOW());
    
#잡동사니
select @ROWNUM := @ROWNUM + 1 AS id,
		T.*
	FROM test_table T,(SELECT @ROWNUM :=0) TMP
ORDER BY date ASC
    
    
    