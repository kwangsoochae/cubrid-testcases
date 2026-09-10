--+ server-message on

-- normal: a negative BIGINT reaches TIME by two different routes in PL/CSQL.
-- An implicit assignment is converted in the PL engine and is rejected, while
-- CAST is a built-in call and is not.

create or replace procedure t as
    n bigint := -1;
    tm time;
begin
    tm := cast(n as time);
    dbms_output.put_line('cast     : ' || tm);
exception
when others then
    dbms_output.put_line('cast     raised sqlcode=' || sqlcode || ' sqlerrm=' || sqlerrm);
end;

create or replace procedure t2 as
    n bigint := -1;
    tm time;
begin
    tm := n;
    dbms_output.put_line('implicit : ' || tm);
exception
when others then
    dbms_output.put_line('implicit raised sqlcode=' || sqlcode || ' sqlerrm=' || sqlerrm);
end;

call t();
call t2();

drop procedure t;
drop procedure t2;

--+ server-message off
