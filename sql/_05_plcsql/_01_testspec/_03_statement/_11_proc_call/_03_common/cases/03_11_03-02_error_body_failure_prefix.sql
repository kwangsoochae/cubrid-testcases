--+ server-message on

-- error: a call whose body fails names the failure once, not twice
-- The sentence a failing statement raises is prefixed by whoever raises the error for
-- the client, and only there. A foreign key is what fails here because that sentence
-- reads the same whichever engine ran the body, and it is carried by an INSERT - the
-- one SQL statement a body can hold and still run where the call lands.

create table pc_par (id int primary key);
create table pc_chi (id int, pid int, foreign key (pid) references pc_par(id));

create or replace procedure p_fk as
begin
    insert into pc_chi values (1, 99);
end;

call p_fk();

drop procedure p_fk;

drop table pc_chi;
drop table pc_par;

--+ server-message off
