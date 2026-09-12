--+ server-message on

-- normal: case_not_found raised by a case statement without an else clause

create or replace procedure t as
    a int := 9;
begin
    case a
      when 1 then dbms_output.put_line('one');
      when 2 then dbms_output.put_line('two');
    end case;
    dbms_output.put_line('no exception');
exception
when case_not_found then
    dbms_output.put_line('caught case_not_found sqlcode=' || sqlcode);
end;

call t();

drop procedure t;

--+ server-message off
