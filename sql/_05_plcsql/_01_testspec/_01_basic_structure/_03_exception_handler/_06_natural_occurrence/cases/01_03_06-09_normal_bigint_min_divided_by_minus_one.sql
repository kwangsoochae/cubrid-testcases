--+ server-message on

-- NOTE: this answer pins today's behavior, not the desired one.
-- The engine and the PL/CSQL runtime disagree here, so a native procedural
-- executor is expected to change this case. Re-blessing it is planned work,
-- not a regression.
-- normal: grade A candidate: the smallest bigint divided by minus one

create or replace procedure t as
    a bigint := -9223372036854775807;
    c bigint;
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
