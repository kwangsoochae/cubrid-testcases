--+ server-message on

-- normal: whether allow_truncated_string reaches a non-static PL/CSQL expression
-- The manual limits which system parameters apply to non-static SQL. A plain
-- assignment is such an expression, while CAST is evaluated as SQL and therefore
-- sees every parameter. This case pins both sides of that boundary.

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
