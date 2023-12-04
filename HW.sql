DELIMITER ;
create table time ( Days int, Clocks int, Minutes int, Seconds int);

DELIMITER //
DROP PROCEDURE IF EXISTS set_x//
CREATE PROCEDURE set_x (in value int)
BEGIN
set @sec_day = "86400";
set @sec_min = "60";
set @sec_clo = "3600";
set @d = CEILING(value / @sec_day * -1) * -1;
set @c = CEILING((value - @d * @sec_day)/@sec_clo * -1) * -1;
set @m = CEILING((value - (@c * @sec_clo + @d * @sec_day)) / @sec_min * -1) * -1;
set @s = value - (@c * @sec_clo + @m * @sec_min + @d * @sec_day); 
insert into time (Days , Clocks , Minutes , Seconds  )
values(@d, @c, @m, @s);
END//
DELIMITER ;

call set_x(86400);

select * from time;

drop table time;
DROP PROCEDURE IF EXISTS set_x;
