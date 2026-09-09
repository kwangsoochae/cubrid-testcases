--+ server-message on

-- NOTE: this answer pins today's behavior, not the desired one.
-- The engine and the PL/CSQL runtime disagree here, so a native procedural
-- executor is expected to change this case. Re-blessing it is planned work,
-- not a regression.
-- normal: grade A candidate: the smallest int divided by minus one

create or replace procedure t as
    a int := -2147483647;
    c int;
begin
    a := a - 1;
    c := a / -1;
    dbms_output.put_line('no exception, c=' || c);
exception
when others then
    dbms_output.put_line('sqlcode=' || sqlcode);
    dbms_output.put_line('sqlerrm=' || sqlerrm);
end;

call t();

drop procedure t;

--+ server-message off
