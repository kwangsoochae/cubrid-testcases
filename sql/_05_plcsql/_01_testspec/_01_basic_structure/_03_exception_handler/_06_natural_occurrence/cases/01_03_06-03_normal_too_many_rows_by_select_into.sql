--+ server-message on

-- normal: too_many_rows raised by a select into that returns two rows

create or replace procedure t as
    v int;
begin
    select a into v from (select 1 as a from db_root union all select 2 as a from db_root) x;
    dbms_output.put_line('no exception, v=' || v);
exception
when too_many_rows then
    dbms_output.put_line('caught too_many_rows sqlcode=' || sqlcode);
end;

call t();

drop procedure t;

--+ server-message off
