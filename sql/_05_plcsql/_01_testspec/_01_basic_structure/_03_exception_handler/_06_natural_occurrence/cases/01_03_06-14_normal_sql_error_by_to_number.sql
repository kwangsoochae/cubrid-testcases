--+ server-message on

-- normal: a failing built-in call raises sql_error, whose sqlcode is 5 and not
-- the 6 the manual lists. 5 is storage_error's code, so inside a `when others`
-- handler the two exceptions cannot be told apart by sqlcode alone.

create or replace procedure t as
    n numeric;
begin
    n := to_number('abc');
    dbms_output.put_line('no exception, n=' || n);
exception
when sql_error then
    dbms_output.put_line('caught sql_error sqlcode=' || sqlcode);
end;

call t();

drop procedure t;

create or replace procedure t2 as
begin
    raise storage_error;
exception
when others then
    dbms_output.put_line('raise storage_error -> sqlcode=' || sqlcode || ' sqlerrm=' || sqlerrm);
end;

call t2();

drop procedure t2;

create or replace procedure t3 as
begin
    raise sql_error;
exception
when others then
    dbms_output.put_line('raise sql_error     -> sqlcode=' || sqlcode || ' sqlerrm=' || sqlerrm);
end;

call t3();

drop procedure t3;

--+ server-message off
