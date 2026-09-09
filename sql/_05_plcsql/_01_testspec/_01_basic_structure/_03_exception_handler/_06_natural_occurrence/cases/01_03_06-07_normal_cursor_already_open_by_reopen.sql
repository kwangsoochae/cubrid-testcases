--+ server-message on

-- normal: cursor_already_open raised by opening a cursor twice

create or replace procedure t as
    cursor c1 is select 1 as a from db_root;
begin
    open c1;
    open c1;
    close c1;
    dbms_output.put_line('no exception');
exception
when cursor_already_open then
    dbms_output.put_line('caught cursor_already_open sqlcode=' || sqlcode);
    close c1;
end;

call t();

drop procedure t;

--+ server-message off
