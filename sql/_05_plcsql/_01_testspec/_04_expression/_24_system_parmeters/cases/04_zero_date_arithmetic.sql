--+ server-message on

-- normal: return_null_on_function_errors turns zero-date arithmetic into NULL
-- in SQL but does not reach the same arithmetic in a PL/CSQL expression, which
-- raises value_error under either setting

create or replace procedure t as
    d date;
    r date;
begin
    select date'0000-00-00' into d from db_root;
    r := d + 1;
    dbms_output.put_line('PL  zero date + 1 : ' || r);
exception
when others then
    dbms_output.put_line('PL  zero date + 1 raised sqlcode=' || sqlcode || ' sqlerrm=' || sqlerrm);
end;

SET SYSTEM PARAMETERS 'return_null_on_function_errors=no';
call t();

SET SYSTEM PARAMETERS 'return_null_on_function_errors=yes';
call t();
select date'0000-00-00' + 1 as sql_side from db_root;

SET SYSTEM PARAMETERS 'return_null_on_function_errors=no';

drop procedure t;

--+ server-message off
