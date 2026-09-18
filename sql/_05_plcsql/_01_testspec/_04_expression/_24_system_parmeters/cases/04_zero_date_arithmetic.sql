--+ server-message on

-- normal: return_null_on_function_errors turns zero-date arithmetic into NULL,
-- and it reaches the same arithmetic in a PL/CSQL expression - the server obeys
-- it there too, so the body prints nothing under yes (DBMS_OUTPUT drops a line
-- concatenated from NULL) and raises under no. The PL engine computes that
-- arithmetic in Java and raises under either setting. The sql_side row below is
-- the control: it is what the answer is pinned against.

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
