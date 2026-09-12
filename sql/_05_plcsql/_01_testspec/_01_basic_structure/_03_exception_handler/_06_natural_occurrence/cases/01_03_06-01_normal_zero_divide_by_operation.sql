--+ server-message on

-- normal: zero_divide raised by an integer division, not by raise

create or replace procedure t as
    a int := 1;
    b int := 0;
    c int;
begin
    c := a / b;
    dbms_output.put_line('no exception, c=' || c);
exception
when zero_divide then
    dbms_output.put_line('caught zero_divide sqlcode=' || sqlcode);
end;

call t();

drop procedure t;

--+ server-message off
