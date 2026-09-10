--+ server-message on

-- normal: rand() and drand() are drawn once per statement, so two statements in
-- one procedure body see different values while one statement sees a single value

create or replace procedure t as
    a int;
    b int;
    c int;
    d double;
    e double;
    f double;
begin
    select rand(), rand() into a, b from db_root;
    dbms_output.put_line('rand  one statement  : ' || case when a = b then 'same' else 'differs' end);

    a := rand();
    c := rand();
    dbms_output.put_line('rand  two statements : ' || case when a = c then 'same' else 'differs' end);

    select drand(), drand() into d, e from db_root;
    dbms_output.put_line('drand one statement  : ' || case when d = e then 'same' else 'differs' end);

    d := drand();
    f := drand();
    dbms_output.put_line('drand two statements : ' || case when d = f then 'same' else 'differs' end);
end;

call t();

drop procedure t;

--+ server-message off
