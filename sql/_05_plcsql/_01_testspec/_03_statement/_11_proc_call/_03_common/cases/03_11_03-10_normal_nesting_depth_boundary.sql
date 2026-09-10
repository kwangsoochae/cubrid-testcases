--+ server-message on

-- normal: where nesting through a query stops, and that direct recursion does not
-- The manual limits nesting that goes through a query but not pure recursion.
--
-- A function that calls itself inside static SQL cannot be created in one step:
-- the reference is resolved at compile time and the function does not exist yet.
-- So it is created as a stub first and then replaced with the recursive body.

create or replace function f_q(n int) return int as
begin
    return 0;
end;

create or replace function f_q(n int) return int as
    v int;
begin
    if n <= 0 then return 0; end if;
    select f_q(n - 1) into v from db_root;
    return v + 1;
end;

create or replace function f_d(n int) return int as
begin
    if n <= 0 then return 0; end if;
    return f_d(n - 1) + 1;
end;

-- through a query
select f_q(1) as q1 from db_root;
select f_q(5) as q5 from db_root;
select f_q(13) as q13 from db_root;
select f_q(14) as q14 from db_root;
select f_q(15) as q15 from db_root;
select f_q(16) as q16 from db_root;
select f_q(17) as q17 from db_root;
select f_q(18) as q18 from db_root;
select f_q(20) as q20 from db_root;

-- direct recursion, no query in between
select f_d(20) as d20 from db_root;
select f_d(100) as d100 from db_root;

drop function f_q;
drop function f_d;

--+ server-message off
