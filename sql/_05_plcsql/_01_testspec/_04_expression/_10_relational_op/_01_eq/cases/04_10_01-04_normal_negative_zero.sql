--+ server-message on

-- normal: '=' in a PL/CSQL expression tells -0.0 apart from 0.0 while the
-- same comparison in SQL treats them as equal

create or replace procedure t as
    a float := 0.0;
    b float;
    da double := 0.0;
    db double;
    s varchar(20);
begin
    b := -1.0 * a;
    db := -1.0 * da;
    dbms_output.put_line('PL  float  0.0 = -0.0 : ' || case when a = b then 'equal' else 'not equal' end);
    dbms_output.put_line('PL  double 0.0 = -0.0 : ' || case when da = db then 'equal' else 'not equal' end);
    select case when cast(0.0 as float) = cast(-1.0 * cast(0.0 as float) as float) then 'equal' else 'not equal' end into s from db_root;
    dbms_output.put_line('SQL float  0.0 = -0.0 : ' || s);
end;

call t();

drop procedure t;

--+ server-message off
