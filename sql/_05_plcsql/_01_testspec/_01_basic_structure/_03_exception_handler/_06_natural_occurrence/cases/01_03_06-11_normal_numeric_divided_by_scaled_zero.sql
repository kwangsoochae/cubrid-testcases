--+ server-message on

-- NOTE: this answer pins today's behavior, not the desired one.
-- The engine and the PL/CSQL runtime disagree here, so a native procedural
-- executor is expected to change this case. Re-blessing it is planned work,
-- not a regression.
-- normal: grade A candidate: a numeric divided by a zero whose scale is not zero

create or replace procedure t as
    a numeric(10,2) := 1.00;
    b numeric(10,2) := 0.00;
    c numeric(10,2);
begin
    c := a / b;
    dbms_output.put_line('no exception, c=' || c);
exception
when others then
    dbms_output.put_line('sqlcode=' || sqlcode);
    dbms_output.put_line('sqlerrm=' || sqlerrm);
end;

call t();

drop procedure t;

--+ server-message off
