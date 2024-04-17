create database db1;
go

use db1;
go

create table articulo(
	id int not null identity,
	nombre varchar(100) not null,
	precio numeric (10, 2) not null,
	stock int not null,
	constraint PK_articulo PRIMARY KEY (id),
	constraint UQ_articulo_nombre UNIQUE (nombre),
	constraint CK_articulo_precio CHECK (precio > 0),
	constraint CK_articulo_stock CHECK (stock >= 0)
);
go	

insert into articulo (nombre,precio,stock)
values ('borrador',2,20);
go

select * from  articulo;
go