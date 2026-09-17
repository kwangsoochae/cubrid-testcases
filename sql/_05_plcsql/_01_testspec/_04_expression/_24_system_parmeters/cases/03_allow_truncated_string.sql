--+ server-message on

-- normal: whether allow_truncated_string reaches a non-static PL/CSQL expression
-- The manual limits which system parameters apply to non-static SQL, and CAST is
-- evaluated as SQL either way. What the two sides of that boundary do is not the
-- same in both engines: the server obeys the parameter in a plain assignment too,
-- while the PL engine computes that assignment in Java and never sees it. The
-- answer holds what the server does - plain SQL truncates to 'abc' under yes and
-- raises Data overflow on data type "character varying". under no.

create or replace procedure t as
    s varchar(3);
begin
    s := 'abcdef';
    dbms_output.put_line('assign: [' || s || ']');
exception
when others then
    dbms_output.put_line('assign sqlcode=' || sqlcode);
    dbms_output.put_line('assign sqlerrm=' || sqlerrm);
end;

create or replace procedure t_cast as
    s varchar(3);
begin
    s := cast('abcdef' as varchar(3));
    dbms_output.put_line('cast: [' || s || ']');
exception
when others then
    dbms_output.put_line('cast sqlcode=' || sqlcode);
    dbms_output.put_line('cast sqlerrm=' || sqlerrm);
end;

SET SYSTEM PARAMETERS 'allow_truncated_string=no';
call t();
call t_cast();

SET SYSTEM PARAMETERS 'allow_truncated_string=yes';
call t();
call t_cast();

SET SYSTEM PARAMETERS 'allow_truncated_string=no';

drop procedure t;
drop procedure t_cast;

--+ server-message off
