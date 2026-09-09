--+ server-message on

-- normal: no_data_found raised by a select into that returns zero rows

create or replace procedure t as
    v int;
begin
    select 1 into v from db_root where 1 = 0;
    dbms_output.put_line('no exception, v=' || v);
exception
when no_data_found then
    dbms_output.put_line('caught no_data_found sqlcode=' || sqlcode);
end;

call t();

drop procedure t;

--+ server-message off
