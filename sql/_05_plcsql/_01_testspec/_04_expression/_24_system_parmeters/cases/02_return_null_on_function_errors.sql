--+ server-message on

-- normal: whether return_null_on_function_errors reaches a non-static PL/CSQL expression
-- The manual limits which system parameters apply to non-static SQL, so this
-- case runs the same procedure under both settings and pins both outputs.

create or replace procedure t as
    s varchar(10) := 'abc';
    v int;
begin
    v := to_number(s);
    dbms_output.put_line('to_number: ' || v);
exception
when others then
    dbms_output.put_line('sqlcode=' || sqlcode);
    dbms_output.put_line('sqlerrm=' || sqlerrm);
end;

SET SYSTEM PARAMETERS 'return_null_on_function_errors=no';
call t();

SET SYSTEM PARAMETERS 'return_null_on_function_errors=yes';
call t();

SET SYSTEM PARAMETERS 'return_null_on_function_errors=no';

drop procedure t;

--+ server-message off
