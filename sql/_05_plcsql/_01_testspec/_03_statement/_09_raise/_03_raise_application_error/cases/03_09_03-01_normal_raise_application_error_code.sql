--+ server-message on

-- normal: raise_application_error carries its code and message to the handler
-- The manual requires the first argument to be greater than 1000.

create or replace procedure t as
begin
    raise_application_error(1001, 'custom failure');
exception
when others then
    dbms_output.put_line('sqlcode=' || sqlcode);
    dbms_output.put_line('sqlerrm=' || sqlerrm);
end;

call t();

drop procedure t;

--+ server-message off
