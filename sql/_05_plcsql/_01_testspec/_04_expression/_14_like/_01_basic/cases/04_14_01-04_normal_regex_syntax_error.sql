--+ server-message on

-- normal: a pattern that is not a valid Java regular expression makes LIKE in
-- a PL/CSQL expression raise program_error, while the same pattern in SQL is
-- an ordinary literal that simply does not match

create or replace procedure t as
    s varchar(20);
begin
    select case when '(x' like '(' then 'match' else 'no match' end into s from db_root;
    dbms_output.put_line('SQL ''(x'' like ''('' : ' || s);
    dbms_output.put_line('PL  ''(x'' like ''('' : ' || case when '(x' like '(' then 'match' else 'no match' end);
exception
when others then
    dbms_output.put_line('PL  ''(x'' like ''('' raised sqlcode=' || sqlcode || ' sqlerrm=' || sqlerrm);
end;

call t();

drop procedure t;

--+ server-message off
