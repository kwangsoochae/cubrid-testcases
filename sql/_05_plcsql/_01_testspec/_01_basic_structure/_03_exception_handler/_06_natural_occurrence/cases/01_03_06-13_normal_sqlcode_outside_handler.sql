--+ server-message on

-- normal: sqlcode and sqlerrm outside an exception handler

create or replace procedure t as
begin
    dbms_output.put_line('sqlcode=' || sqlcode);
    dbms_output.put_line('sqlerrm=' || sqlerrm);
exception
when others then
    dbms_output.put_line('sqlcode=' || sqlcode);
    dbms_output.put_line('sqlerrm=' || sqlerrm);
end;

call t();

drop procedure t;

--+ server-message off
