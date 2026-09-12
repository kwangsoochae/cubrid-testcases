--+ server-message on

-- normal: '=' in a PL/CSQL expression compares strings byte by byte, so a
-- case-insensitive collation that makes the same comparison match in SQL
-- does not make it match in PL/CSQL

create table t_coll (c varchar(10) collate iso88591_en_ci);
insert into t_coll values ('ABC');

create or replace procedure t as
    v varchar(10);
    n int;
begin
    select c into v from t_coll;
    dbms_output.put_line('PL  v = ''abc''         : ' || case when v = 'abc' then 'equal' else 'not equal' end);
    select count(*) into n from t_coll where c = 'abc';
    dbms_output.put_line('SQL c = ''abc'' matches : ' || n);
end;

call t();

drop procedure t;
drop table t_coll;

--+ server-message off
