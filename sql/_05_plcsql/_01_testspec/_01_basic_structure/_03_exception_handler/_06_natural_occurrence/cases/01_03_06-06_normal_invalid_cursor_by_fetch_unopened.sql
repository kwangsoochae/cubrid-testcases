--+ server-message on

-- normal: invalid_cursor raised by fetching from a cursor that was never opened

create or replace procedure t as
    cursor c1 is select 1 as a from db_root;
    v int;
begin
    fetch c1 into v;
    dbms_output.put_line('no exception, v=' || v);
exception
when invalid_cursor then
    dbms_output.put_line('caught invalid_cursor sqlcode=' || sqlcode);
end;

call t();

drop procedure t;

--+ server-message off
