--+ server-message on

-- normal: a PL/CSQL procedure runs with the owner's rights
-- The manual says PL/CSQL supports Owner's Rights only. If that holds, a caller
-- who may execute the procedure reaches data it cannot read directly.

create table t_secret (a int);
insert into t_secret values (7);
commit;

create or replace procedure p_read as
    v int;
begin
    select a into v from dba.t_secret;
    dbms_output.put_line('read=' || v);
exception
when others then
    dbms_output.put_line('sqlcode=' || sqlcode);
    dbms_output.put_line('sqlerrm=' || sqlerrm);
end;

create user u1;
grant execute on procedure p_read to u1;
commit;

call login('u1','') on class db_user;

-- direct read must fail
select count(*) from dba.t_secret;

-- through the procedure it must succeed if owner's rights apply
call dba.p_read();

call login('dba','') on class db_user;

drop procedure p_read;
drop table t_secret;
drop user u1;
commit;

--+ server-message off
