--+ server-message on

-- NOTE: this answer pins today's behavior, not the desired one.
-- The engine and the PL/CSQL runtime disagree here, so a native procedural
-- executor is expected to change this case. Re-blessing it is planned work,
-- not a regression.
-- normal: grade A candidate: a double divided by a very small value built by operation

create or replace procedure t as
    a double := 1.0;
    b double := 1e-300;
    c double;
begin
    b := b / 1e20;
    dbms_output.put_line('divisor=' || b);
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
