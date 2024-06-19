create table demo(algo varchar(100));
go

begin tran;
go

select @@TRANCOUNT;
go


insert into demo  values('quiero estudiar linux, con la fe de cuto');
go

select * from demo;
go