--+ server-message on

-- normal: a NaN travels through SQL arithmetic unharmed, but bringing the same
-- value into a PL/CSQL variable fails

create or replace procedure t as
    d double;
begin
    select cast(1.5 as double) into d from db_root;
    dbms_output.put_line('control 1.5 fetched : ' || d);
    select cast('nan' as double) into d from db_root;
    dbms_output.put_line('nan fetched         : ' || d);
exception
when others then
    dbms_output.put_line('nan fetch raised sqlcode=' || sqlcode || ' sqlerrm=' || sqlerrm);
end;

select cast('nan' as double) + 1 as sql_side from db_root;

call t();

drop procedure t;

--+ server-message off
