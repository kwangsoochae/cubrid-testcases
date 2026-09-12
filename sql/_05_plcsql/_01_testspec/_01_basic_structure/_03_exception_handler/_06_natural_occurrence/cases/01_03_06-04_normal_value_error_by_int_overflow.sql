--+ server-message on

-- normal: value_error raised by an integer addition overflow

create or replace procedure t as
    a int := 2147483647;
    c int;
begin
    c := a + 1;
    dbms_output.put_line('no exception, c=' || c);
exception
when value_error then
    dbms_output.put_line('caught value_error sqlcode=' || sqlcode);
end;

call t();

drop procedure t;

--+ server-message off
