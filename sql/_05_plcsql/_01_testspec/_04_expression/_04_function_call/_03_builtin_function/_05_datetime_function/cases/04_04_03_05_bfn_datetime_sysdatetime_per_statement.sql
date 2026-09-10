--+ server-message on

-- normal: sys_datetime is drawn once per statement, so two statements in one
-- procedure body see different times while one statement sees a single time.
-- sleep() keeps the gap far above the millisecond resolution of DATETIME.

create or replace procedure t as
    a datetime;
    b datetime;
    c datetime;
    s int;
begin
    select sys_datetime, sys_datetime into a, b from db_root;
    dbms_output.put_line('one statement  : ' || case when a = b then 'same' else 'differs' end);

    a := sys_datetime;
    s := sleep(0.3);
    c := sys_datetime;
    dbms_output.put_line('two statements : ' || case when a = c then 'same' else 'differs' end);
end;

call t();

drop procedure t;

--+ server-message off
