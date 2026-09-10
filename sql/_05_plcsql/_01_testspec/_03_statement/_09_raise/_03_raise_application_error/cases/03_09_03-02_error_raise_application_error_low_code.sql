--+ server-message on

-- error: raise_application_error rejects a code that is not above 1000

create or replace procedure t as
begin
    raise_application_error(999, 'too low');
exception
when others then
    dbms_output.put_line('sqlcode=' || sqlcode);
    dbms_output.put_line('sqlerrm=' || sqlerrm);
end;

call t();

drop procedure t;

--+ server-message off
