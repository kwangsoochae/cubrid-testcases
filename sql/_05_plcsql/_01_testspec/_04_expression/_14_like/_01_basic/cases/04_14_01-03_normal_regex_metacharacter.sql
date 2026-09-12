--+ server-message on

-- normal: LIKE in a PL/CSQL expression is translated into a Java regular
-- expression, so a regex metacharacter in the pattern keeps its regex meaning
-- and '%' does not span a newline. The same patterns in SQL behave the other
-- way round on both counts.

create or replace procedure t as
    s varchar(20);
    nl varchar(20);
begin
    dbms_output.put_line('PL  ''abc'' like ''a.c''  : ' || case when 'abc' like 'a.c' then 'match' else 'no match' end);
    select case when 'abc' like 'a.c' then 'match' else 'no match' end into s from db_root;
    dbms_output.put_line('SQL ''abc'' like ''a.c''  : ' || s);

    select 'a' || chr(10) || 'b' into nl from db_root;
    dbms_output.put_line('PL  newline like ''a%b'': ' || case when nl like 'a%b' then 'match' else 'no match' end);
    select case when 'a' || chr(10) || 'b' like 'a%b' then 'match' else 'no match' end into s from db_root;
    dbms_output.put_line('SQL newline like ''a%b'': ' || s);
end;

call t();

drop procedure t;

--+ server-message off
