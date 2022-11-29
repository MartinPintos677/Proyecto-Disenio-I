use master
go

if exists(Select * FROM SysDataBases WHERE name='BiosMessenger')
BEGIN
	DROP DATABASE BiosMessenger
END
go

create login [IIS APPPOOL\DefaultAppPool] from windows
go

create database BiosMessenger
go

use BiosMessenger
go

create user [IIS APPPOOL\DefaultAppPool] for login [IIS APPPOOL\DefaultAppPool]
go

grant execute to [IIS APPPOOL\DefaultAppPool]
go

create table Usuario
(
	UsuarioLogueo char(8) primary key check(len(UsuarioLogueo) = 8),
	Contrasena char(6) not null check(Contrasena like '[A-Z][A-Z][A-Z][A-Z][A-Z][0-9]'),
	Nombre varchar(50) not null,
	Apellido varchar(50) not null,
	Mail varchar(50) not null check(Mail like '%@%.%' or Mail like '%@%.%.%'),
	Activo bit not null default 1
)
go

create table Mensaje
(
	Codigo int identity (1,1) primary key,
	TextoMensaje varchar(max) not null,
	Asunto varchar(30) not null,
	FechaHora datetime not null default getdate(),
	UsuarioLogueo char(8) not null foreign key references Usuario(UsuarioLogueo)
)
go

create table Privado
(
	Codigo int foreign key references Mensaje(Codigo),
	FechaCaducidad datetime not null check(datediff(hour, getdate(), FechaCaducidad) >= 24),
		primary key (Codigo)
)

create table TipodeMensaje
(
	Codigo char(3) primary key check(Codigo like '[A-Z][A-Z][A-Z]'),
	Nombre varchar(20) not null
)

create table Comun
(
	Codigo int foreign key references Mensaje(Codigo),
	TipoMensaje char(3) not null foreign key references TipodeMensaje(Codigo),
		primary key (Codigo)
)

create table Reciben
(
	UsuarioLogueo char(8) not null foreign key references Usuario(UsuarioLogueo),
	Codigo int not null foreign key references Mensaje(Codigo),
		primary key (UsuarioLogueo, Codigo)
)

------------------ DATOS USUARIO -------------------
insert into Usuario (UsuarioLogueo, Contrasena, Nombre, Apellido, Mail)
values ('UsuarioA', 'AAAAA1', 'Alberto','Gonzalez','albertico@gmail.com.uy'),
       ('UsuarioB', 'BBBBB2', 'Camila', 'Medina', 'cmedina@hotmail.com'),
	   ('UsuarioC', 'CCCCC3', 'Juan', 'Perez', 'juanp@yahoo.com'),
	   ('UsuarioD', 'DDDDD4', 'Leandro', 'Andrade', 'leandrade@gmail.com'),
	   ('UsuarioE', 'EEEEE5', 'Marcelo', 'Velazquez', 'mavelazquez@hotmail.com'),
	   ('UsuarioF', 'FFFFF6', 'Jose', 'Coimbra', 'josecoi@yahoo.com'),
	   ('UsuarioG', 'GGGGG7', 'Manuel', 'Mora', 'manum@gmail.com'),
	   ('UsuarioH', 'HHHHH8', 'Francisco', 'Morales', 'franmora@yahoo.com'),
	   ('UsuarioI', 'IIIII9', 'David', 'Moreno', 'dmoreno@yahoo.com'),
	   ('UsuarioJ', 'JJJJJ0', 'Daniel', 'Pereira', 'danipe@hotmail.com'),
	   ('UsuarioK', 'KKKKK1', 'Javier', 'Pineda', 'jpineda@yahoo.com'),
	   ('UsuarioL', 'LLLLL2', 'Antonio', 'Portillo', 'tonip@gmail.com'),
	   ('UsuarioM', 'MMMMM3', 'Isabel', 'Quispe', 'isaq@hotmail.com'),
	   ('UsuarioN', 'NNNNN4', 'Josefa', 'Reyes', 'joreyes@yahoo.com'),
	   ('UsuarioO', 'OOOOO5', 'Ana', 'Rivas', 'anarivas@gmail.com'),
	   ('UsuarioP', 'PPPPP6', 'Carmen', 'Rivera', 'carmenriv@yahoo.com'),
	   ('UsuarioQ', 'QQQQQ7', 'Maria', 'Rojas', 'mariarojas@hotmail.com'),
	   ('UsuarioR', 'RRRRR8', 'Paula', 'Salazar', 'pausalazar@yahoo.com'),
	   ('UsuarioS', 'SSSSS9', 'Valeria', 'Santana', 'valesantana@gmail.com'),
	   ('UsuarioT', 'TTTTT0', 'Julia', 'Santos', 'jullisantos@yahoo.com')

------------------ TIPOS DE MENSAJE -------------------
insert into TipodeMensaje (Codigo, Nombre)
values ('URG', 'Urgente'),
('IVT', 'Invitación'), ('EVT', 'Eventos')

------------- MENSAJE COMUN -------------
DECLARE @idMensaje INT
-- 1 --
insert into Mensaje (TextoMensaje, Asunto, UsuarioLogueo)
values ('Primer Texto de Mensaje', 'Asunto de Mensaje 1', 'UsuarioA')
SELECT @idMensaje = @@IDENTITY
insert into Comun (Codigo, TipoMensaje)
values (@idMensaje, 'URG')
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioB', @idMensaje)
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioC', @idMensaje)

-- 2 --
insert into Mensaje (TextoMensaje, Asunto, UsuarioLogueo)
values ('Segundo Texto de Mensaje', 'Asunto de Mensaje 2', 'UsuarioA')
SELECT @idMensaje = @@IDENTITY
insert into Comun (Codigo, TipoMensaje)
values (@idMensaje, 'URG')
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioB', @idMensaje)

-- 3 --
insert into Mensaje (TextoMensaje, Asunto, UsuarioLogueo)
values ('Tercer Texto de Mensaje', 'Asunto de Mensaje', 'UsuarioA')
SELECT @idMensaje = @@IDENTITY
insert into Comun (Codigo, TipoMensaje)
values (@idMensaje, 'URG')
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioB', @idMensaje)

-- 4 --
insert into Mensaje (TextoMensaje, Asunto, UsuarioLogueo)
values ('Cuarto Texto de Mensaje', 'Asunto de Mensaje', 'UsuarioB')
SELECT @idMensaje = @@IDENTITY
insert into Comun (Codigo, TipoMensaje)
values (@idMensaje, 'IVT')
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioI', @idMensaje)
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioK', @idMensaje)
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioM', @idMensaje)

-- 5 --
insert into Mensaje (TextoMensaje, Asunto, UsuarioLogueo)
values ('Quinto Texto de Mensaje', 'Asunto de Mensaje', 'UsuarioB')
SELECT @idMensaje = @@IDENTITY
insert into Comun (Codigo, TipoMensaje)
values (@idMensaje, 'IVT')
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioB', @idMensaje)
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioN', @idMensaje)
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioQ', @idMensaje)

-- 6 --
insert into Mensaje (TextoMensaje, Asunto, UsuarioLogueo)
values ('Sexto Texto de Mensaje', 'Asunto de Mensaje', 'UsuarioB')
SELECT @idMensaje = @@IDENTITY
insert into Comun (Codigo, TipoMensaje)
values (@idMensaje, 'IVT')
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioC', @idMensaje)
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioD', @idMensaje)
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioE', @idMensaje)
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioI', @idMensaje)
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioJ', @idMensaje)

-- 7 --
insert into Mensaje (TextoMensaje, Asunto, UsuarioLogueo)
values ('Septimo Texto de Mensaje', 'Asunto de Mensaje', 'UsuarioC')
SELECT @idMensaje = @@IDENTITY
insert into Comun (Codigo, TipoMensaje)
values (@idMensaje, 'IVT')
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioL', @idMensaje)

-- 8 --
insert into Mensaje (TextoMensaje, Asunto, UsuarioLogueo)
values ('Primer Texto de Mensaje', 'Asunto de Mensaje', 'UsuarioC')
SELECT @idMensaje = @@IDENTITY
insert into Comun (Codigo, TipoMensaje)
values (@idMensaje, 'IVT')
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioA', @idMensaje)
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioD', @idMensaje)

-- 9 -- 
insert into Mensaje (TextoMensaje, Asunto, UsuarioLogueo)
values ('Noveno Texto de Mensaje', 'Asunto de Mensaje', 'UsuarioD')
SELECT @idMensaje = @@IDENTITY
insert into Comun (Codigo, TipoMensaje)
values (@idMensaje, 'URG')
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioB', @idMensaje)
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioA', @idMensaje)
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioC', @idMensaje)
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioG', @idMensaje)
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioF', @idMensaje)

-- 10 --
insert into Mensaje (TextoMensaje, Asunto, UsuarioLogueo)
values ('Décimo Texto de Mensaje', 'Asunto de Mensaje', 'UsuarioF')
SELECT @idMensaje = @@IDENTITY
insert into Comun (Codigo, TipoMensaje)
values (@idMensaje, 'URG')
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioK', @idMensaje)
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioM', @idMensaje)
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioN', @idMensaje)

-- 11 --
insert into Mensaje (TextoMensaje, Asunto, UsuarioLogueo)
values ('Decimoprimero de Mensaje', 'Asunto de Mensaje', 'UsuarioD')
SELECT @idMensaje = @@IDENTITY
insert into Comun (Codigo, TipoMensaje)
values (@idMensaje, 'EVT')
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioH', @idMensaje)

-- 12 --
insert into Mensaje (TextoMensaje, Asunto, UsuarioLogueo)
values ('Decimosegundo Texto de Mensaje', 'Asunto de Mensaje', 'UsuarioE')
SELECT @idMensaje = @@IDENTITY
insert into Comun (Codigo, TipoMensaje)
values (@idMensaje, 'EVT')
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioB', @idMensaje)
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioA', @idMensaje)
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioC', @idMensaje)
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioD', @idMensaje)
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioF', @idMensaje)


-- 13 --
insert into Mensaje (TextoMensaje, Asunto, UsuarioLogueo)
values ('Decimotercero Texto de Mensaje', 'Asunto de Mensaje', 'UsuarioI')
SELECT @idMensaje = @@IDENTITY
insert into Comun (Codigo, TipoMensaje)
values (@idMensaje, 'EVT')
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioM', @idMensaje)

-- 14 --
insert into Mensaje (TextoMensaje, Asunto, UsuarioLogueo)
values ('Decimocuarto Texto de Mensaje', 'Asunto de Mensaje', 'UsuarioI')
SELECT @idMensaje = @@IDENTITY
insert into Comun (Codigo, TipoMensaje)
values (@idMensaje, 'EVT')
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioG', @idMensaje)
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioB', @idMensaje)
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioE', @idMensaje)

-- 15 --
insert into Mensaje (TextoMensaje, Asunto, UsuarioLogueo)
values ('Decimoquinto Texto de Mensaje', 'Asunto de Mensaje', 'UsuarioJ')
SELECT @idMensaje = @@IDENTITY
insert into Comun (Codigo, TipoMensaje)
values (@idMensaje, 'URG')
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioA', @idMensaje)

-- 16 --
insert into Mensaje (TextoMensaje, Asunto, UsuarioLogueo)
values ('Decimosexto Texto de Mensaje', 'Asunto de Mensaje', 'UsuarioJ')
SELECT @idMensaje = @@IDENTITY
insert into Comun (Codigo, TipoMensaje)
values (@idMensaje, 'URG')
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioI', @idMensaje)
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioB', @idMensaje)
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioC', @idMensaje)
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioD', @idMensaje)
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioE', @idMensaje)
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioF', @idMensaje)

-- 17 --
insert into Mensaje (TextoMensaje, Asunto, UsuarioLogueo)
values ('Decimoséptimo Texto de Mensaje', 'Asunto de Mensaje', 'UsuarioK')
SELECT @idMensaje = @@IDENTITY
insert into Comun (Codigo, TipoMensaje)
values (@idMensaje, 'EVT')
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioC', @idMensaje)
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioD', @idMensaje)

-- 18 --
insert into Mensaje (TextoMensaje, Asunto, UsuarioLogueo)
values ('Decimoctavo Texto de Mensaje', 'Asunto de Mensaje', 'UsuarioK')
SELECT @idMensaje = @@IDENTITY
insert into Comun (Codigo, TipoMensaje)
values (@idMensaje, 'EVT')
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioG', @idMensaje)

-- 19 --
insert into Mensaje (TextoMensaje, Asunto, UsuarioLogueo)
values ('Decimonoveno Texto de Mensaje', 'Asunto de Mensaje', 'UsuarioL')
SELECT @idMensaje = @@IDENTITY
insert into Comun (Codigo, TipoMensaje)
values (@idMensaje, 'URG')
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioA', @idMensaje)
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioB', @idMensaje)
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioC', @idMensaje)
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioD', @idMensaje)
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioE', @idMensaje)
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioF', @idMensaje)
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioG', @idMensaje)

-- 20 --
insert into Mensaje (TextoMensaje, Asunto, UsuarioLogueo)
values ('Vigésimo Texto de Mensaje', 'Asunto de Mensaje', 'UsuarioL')
SELECT @idMensaje = @@IDENTITY
insert into Comun (Codigo, TipoMensaje)
values (@idMensaje, 'IVT')
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioH', @idMensaje)
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioI', @idMensaje)

-- 21 --
insert into Mensaje (TextoMensaje, Asunto, UsuarioLogueo)
values ('Vigesimoprimero Texto de Mensaje', 'Asunto de Mensaje', 'UsuarioL')
SELECT @idMensaje = @@IDENTITY
insert into Comun (Codigo, TipoMensaje)
values (@idMensaje, 'URG')
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioB', @idMensaje)

-- 22 --
insert into Mensaje (TextoMensaje, Asunto, UsuarioLogueo)
values ('Vigesimosegundo Texto de Mensaje', 'Asunto de Mensaje', 'UsuarioM')
SELECT @idMensaje = @@IDENTITY
insert into Comun (Codigo, TipoMensaje)
values (@idMensaje, 'IVT')
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioB', @idMensaje)
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioK', @idMensaje)

-- 23 --
insert into Mensaje (TextoMensaje, Asunto, UsuarioLogueo)
values ('Vigesimotercero Texto de Mensaje', 'Asunto de Mensaje', 'UsuarioM')
SELECT @idMensaje = @@IDENTITY
insert into Comun (Codigo, TipoMensaje)
values (@idMensaje, 'IVT')
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioN', @idMensaje)
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioO', @idMensaje)
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioM', @idMensaje)
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioD', @idMensaje)

-- 24 --
insert into Mensaje (TextoMensaje, Asunto, UsuarioLogueo)
values ('Primer Texto de Mensaje', 'Asunto de Mensaje', 'UsuarioN')
SELECT @idMensaje = @@IDENTITY
insert into Comun (Codigo, TipoMensaje)
values (@idMensaje, 'IVT')
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioA', @idMensaje)

-- 25 --
insert into Mensaje (TextoMensaje, Asunto, UsuarioLogueo)
values ('Primer Texto de Mensaje', 'Asunto de Mensaje', 'UsuarioN')
SELECT @idMensaje = @@IDENTITY
insert into Comun (Codigo, TipoMensaje)
values (@idMensaje, 'IVT')
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioH', @idMensaje)



------------- MENSAJE PRIVADO -------------
--DECLARE @idMensaje INT

-- 26 --
insert into Mensaje (TextoMensaje, Asunto, UsuarioLogueo)
values ('Texto de Mensaje Privado 1', 'Asunto de Mensaje Privado', 'UsuarioA')
SELECT @idMensaje = @@IDENTITY
insert into Privado (Codigo, FechaCaducidad)
values (@idMensaje, '2022/09/10 21:00')
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioB', @idMensaje)
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioC', @idMensaje)
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioD', @idMensaje)

-- 27 --
insert into Mensaje (TextoMensaje, Asunto, UsuarioLogueo)
values ('Texto de Mensaje Privado 2', 'Asunto de Mensaje Privado', 'UsuarioA')
SELECT @idMensaje = @@IDENTITY
insert into Privado (Codigo, FechaCaducidad)
values (@idMensaje, '2022/09/11 20:00')
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioF', @idMensaje)
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioG', @idMensaje)

-- 28 --
insert into Mensaje (TextoMensaje, Asunto, UsuarioLogueo)
values ('Texto de Mensaje Privado 3', 'Asunto de Mensaje Privado', 'UsuarioA')
SELECT @idMensaje = @@IDENTITY
insert into Privado (Codigo, FechaCaducidad)
values (@idMensaje, '2022/09/12 22:00')
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioH', @idMensaje)

-- 29 --
insert into Mensaje (TextoMensaje, Asunto, UsuarioLogueo)
values ('Texto de Mensaje Privado 4', 'Asunto de Mensaje Privado', 'UsuarioB')
SELECT @idMensaje = @@IDENTITY
insert into Privado (Codigo, FechaCaducidad)
values (@idMensaje, '2022/09/13 21:00')
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioA', @idMensaje)
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioI', @idMensaje)
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioJ', @idMensaje)
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioL', @idMensaje)

-- 30 --
insert into Mensaje (TextoMensaje, Asunto, UsuarioLogueo)
values ('Texto de Mensaje Privado 5', 'Asunto de Mensaje Privado', 'UsuarioB')
SELECT @idMensaje = @@IDENTITY
insert into Privado (Codigo, FechaCaducidad)
values (@idMensaje, '2022/09/16 16:00')
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioJ', @idMensaje)
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioK', @idMensaje)

-- 31 --
insert into Mensaje (TextoMensaje, Asunto, UsuarioLogueo)
values ('Texto de Mensaje Privado 6', 'Asunto de Mensaje Privado', 'UsuarioC')
SELECT @idMensaje = @@IDENTITY
insert into Privado (Codigo, FechaCaducidad)
values (@idMensaje, '2022/09/15 14:00')
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioB', @idMensaje)

-- 32 --
insert into Mensaje (TextoMensaje, Asunto, UsuarioLogueo)
values ('Texto de Mensaje Privado 7', 'Asunto de Mensaje Privado', 'UsuarioC')
SELECT @idMensaje = @@IDENTITY
insert into Privado (Codigo, FechaCaducidad)
values (@idMensaje, '2022/09/17 18:00')
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioK', @idMensaje)

-- 33 --
insert into Mensaje (TextoMensaje, Asunto, UsuarioLogueo)
values ('Texto de Mensaje Privado 8', 'Asunto de Mensaje Privado', 'UsuarioD')
SELECT @idMensaje = @@IDENTITY
insert into Privado (Codigo, FechaCaducidad)
values (@idMensaje, '2022/09/18 21:00')
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioH', @idMensaje)
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioG', @idMensaje)

-- 34 --
insert into Mensaje (TextoMensaje, Asunto, UsuarioLogueo)
values ('Texto de Mensaje Privado 9', 'Asunto de Mensaje Privado', 'UsuarioD')
SELECT @idMensaje = @@IDENTITY
insert into Privado (Codigo, FechaCaducidad)
values (@idMensaje, '2022/10/02 23:00')
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioB', @idMensaje)
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioA', @idMensaje)
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioC', @idMensaje)
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioE', @idMensaje)

-- 35 --
insert into Mensaje (TextoMensaje, Asunto, UsuarioLogueo)
values ('Texto de Mensaje Privado 10', 'Asunto de Mensaje Privado', 'UsuarioE')
SELECT @idMensaje = @@IDENTITY
insert into Privado (Codigo, FechaCaducidad)
values (@idMensaje, '2022/10/04 13:00')
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioJ', @idMensaje)
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioM', @idMensaje)

-- 36 --
insert into Mensaje (TextoMensaje, Asunto, UsuarioLogueo)
values ('Texto de Mensaje Privado 11', 'Asunto de Mensaje Privado', 'UsuarioE')
SELECT @idMensaje = @@IDENTITY
insert into Privado (Codigo, FechaCaducidad)
values (@idMensaje, '2022/10/03 21:00')
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioN', @idMensaje)

-- 37 --
insert into Mensaje (TextoMensaje, Asunto, UsuarioLogueo)
values ('Texto de Mensaje Privado 12', 'Asunto de Mensaje Privado', 'UsuarioE')
SELECT @idMensaje = @@IDENTITY
insert into Privado (Codigo, FechaCaducidad)
values (@idMensaje, '2022/09/24 20:00')
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioM', @idMensaje)
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioN', @idMensaje)

-- 38 --
insert into Mensaje (TextoMensaje, Asunto, UsuarioLogueo)
values ('Texto de Mensaje Privado 13', 'Asunto de Mensaje Privado', 'UsuarioF')
SELECT @idMensaje = @@IDENTITY
insert into Privado (Codigo, FechaCaducidad)
values (@idMensaje, '2022/09/25 19:00')
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioG', @idMensaje)

-- 39 --
insert into Mensaje (TextoMensaje, Asunto, UsuarioLogueo)
values ('Texto de Mensaje Privado 14', 'Asunto de Mensaje Privado', 'UsuarioF')
SELECT @idMensaje = @@IDENTITY
insert into Privado (Codigo, FechaCaducidad)
values (@idMensaje, '2022/09/20 09:00')
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioJ', @idMensaje)

-- 40 --
insert into Mensaje (TextoMensaje, Asunto, UsuarioLogueo)
values ('Texto de Mensaje Privado 15', 'Asunto de Mensaje Privado', 'UsuarioG')
SELECT @idMensaje = @@IDENTITY
insert into Privado (Codigo, FechaCaducidad)
values (@idMensaje, '2022/09/18 21:00')
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioH', @idMensaje)

-- 41 --
insert into Mensaje (TextoMensaje, Asunto, UsuarioLogueo)
values ('Texto de Mensaje Privado 16', 'Asunto de Mensaje Privado', 'UsuarioH')
SELECT @idMensaje = @@IDENTITY
insert into Privado (Codigo, FechaCaducidad)
values (@idMensaje, '2022/09/19 15:00')
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioB', @idMensaje)

-- 42 --
insert into Mensaje (TextoMensaje, Asunto, UsuarioLogueo)
values ('Texto de Mensaje Privado 17', 'Asunto de Mensaje Privado', 'UsuarioH')
SELECT @idMensaje = @@IDENTITY
insert into Privado (Codigo, FechaCaducidad)
values (@idMensaje, '2022/09/20 21:00')
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioM', @idMensaje)

-- 43 --
insert into Mensaje (TextoMensaje, Asunto, UsuarioLogueo)
values ('Texto de Mensaje Privado 18', 'Asunto de Mensaje Privado', 'UsuarioI')
SELECT @idMensaje = @@IDENTITY
insert into Privado (Codigo, FechaCaducidad)
values (@idMensaje, '2022/09/21 23:00')
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioM', @idMensaje)
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioN', @idMensaje)
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioO', @idMensaje)
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioP', @idMensaje)
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioQ', @idMensaje)
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioB', @idMensaje)
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioC', @idMensaje)
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioD', @idMensaje)
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioE', @idMensaje)

-- 44 --
insert into Mensaje (TextoMensaje, Asunto, UsuarioLogueo)
values ('Texto de Mensaje Privado 19', 'Asunto de Mensaje Privado', 'UsuarioJ')
SELECT @idMensaje = @@IDENTITY
insert into Privado (Codigo, FechaCaducidad)
values (@idMensaje, '2022/09/28 13:00')
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioK', @idMensaje)
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioL', @idMensaje)

-- 45 --
insert into Mensaje (TextoMensaje, Asunto, UsuarioLogueo)
values ('Texto de Mensaje Privado 20', 'Asunto de Mensaje Privado', 'UsuarioJ')
SELECT @idMensaje = @@IDENTITY
insert into Privado (Codigo, FechaCaducidad)
values (@idMensaje, '2022/10/01 21:00')
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioO', @idMensaje)

-- 46 --
insert into Mensaje (TextoMensaje, Asunto, UsuarioLogueo)
values ('Texto de Mensaje Privado 21', 'Asunto de Mensaje Privado', 'UsuarioK')
SELECT @idMensaje = @@IDENTITY
insert into Privado (Codigo, FechaCaducidad)
values (@idMensaje, '2022/11/01 14:00')
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioN', @idMensaje)

-- 47 --
insert into Mensaje (TextoMensaje, Asunto, UsuarioLogueo)
values ('Texto de Mensaje Privado 22', 'Asunto de Mensaje Privado', 'UsuarioL')
SELECT @idMensaje = @@IDENTITY
insert into Privado (Codigo, FechaCaducidad)
values (@idMensaje, '2022/10/09 12:00')
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioJ', @idMensaje)
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioK', @idMensaje)
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioI', @idMensaje)
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioO', @idMensaje)

-- 48 --
insert into Mensaje (TextoMensaje, Asunto, UsuarioLogueo)
values ('Texto de Mensaje Privado 23', 'Asunto de Mensaje Privado', 'UsuarioM')
SELECT @idMensaje = @@IDENTITY
insert into Privado (Codigo, FechaCaducidad)
values (@idMensaje, '2022/10/16 21:00')
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioN', @idMensaje)

-- 49 --
insert into Mensaje (TextoMensaje, Asunto, UsuarioLogueo)
values ('Texto de Mensaje Privado 24', 'Asunto de Mensaje Privado', 'UsuarioN')
SELECT @idMensaje = @@IDENTITY
insert into Privado (Codigo, FechaCaducidad)
values (@idMensaje, '2022/10/10 21:00')
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioM', @idMensaje)
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioO', @idMensaje)

-- 50 --
insert into Mensaje (TextoMensaje, Asunto, UsuarioLogueo)
values ('Texto de Mensaje Privado 25', 'Asunto de Mensaje Privado', 'UsuarioO')
SELECT @idMensaje = @@IDENTITY
insert into Privado (Codigo, FechaCaducidad)
values (@idMensaje, '2022/10/01 17:00')
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioA', @idMensaje)
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioB', @idMensaje)
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioC', @idMensaje)
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioD', @idMensaje)
go

-- SP --
-- ALTA MENSAJE COMUN --
create proc AltaMensajeComun @texto varchar(max), @asunto varchar(30), @tipoMensaje char(3), @usuarioEnvia char(8)
AS
Begin
	if not exists (select * from Usuario where UsuarioLogueo = @usuarioEnvia and Activo = 1)
		return -1
	
	if not exists (select * from TipodeMensaje where Codigo = @tipoMensaje)
		return -2
			
			DECLARE @idMensaje INT

			INSERT INTO Mensaje (Asunto, TextoMensaje, UsuarioLogueo)
			VALUES (@asunto, @texto, @usuarioEnvia)

			SET @idMensaje = @@IDENTITY

			INSERT INTO Comun(Codigo, TipoMensaje)
			VALUES(@idMensaje, @tipoMensaje)
	
		if (@@ERROR <> 0)				
			return -3		
		else
			return @idMensaje
End
go

-- BUSCAR TIPO DE MENSAJE --
create proc BuscarTipodeMensaje @codigo char(3) AS
Begin	
	select * from TipodeMensaje where Codigo = @codigo
End
go

-- LISTADO DE TIPOS DE MENSAJE --
create proc ListadoTiposdeMensaje AS
Begin
	select * from TipodeMensaje
End
go

-- ALTA MENSAJE PRIVADO --
create proc AltaMensajePrivado 
   @texto varchar(max), @asunto varchar(30), @fechaCaducidad datetime, @usuarioEnvia char(8)
AS
Begin
	if not exists (select * from Usuario where UsuarioLogueo = @usuarioEnvia and Activo = 1)
		return -1		
   
	     declare @idMensaje int

		 insert into Mensaje (TextoMensaje, Asunto, UsuarioLogueo)
		 VALUES (@texto, @asunto, @usuarioEnvia)

		 set @idMensaje = @@IDENTITY

		 insert into Privado (Codigo, FechaCaducidad)
		 VALUES (@idMensaje, @fechaCaducidad)

    if (@@ERROR <> 0)		
		return -2
	else
		return @idMensaje
End
go

-- AGREGAR RECEPTOR PARA MENSAJE --
create proc AgregarReceptorParaMensaje @usuarioReceptor char(8), @codMensaje int AS
Begin
	if not exists (select * from Usuario where UsuarioLogueo = @usuarioReceptor and Activo = 1)
		return -1

	if not exists (select * from Mensaje where Codigo = @codMensaje)
		return -2

	if exists (select * from Reciben where UsuarioLogueo = @usuarioReceptor and Codigo = @codMensaje)
		return -3

	insert into Reciben (UsuarioLogueo, Codigo)
		values (@usuarioReceptor, @codMensaje)

	if @@ERROR = 0
		return 1
	else
		return 0
End
go

-- LISTADO DE RECEPTORES PARA MENSAJE --
create proc ListadoReceptoresParaMensaje @codigo int AS
Begin	
	select * from Reciben where Codigo = @codigo
End
go

-- LISTADO DE TODOS LOS MENSAJES PRIVADOS ENVIADOS POR UN USUARIO ACTUALMENTE LOGUEADO --
create proc ListadoMPrivadosEnviadosPorUsuario @usuario char(8) AS
Begin	
	select * from Mensaje inner join
	Privado on Privado.Codigo = Mensaje.Codigo
	where UsuarioLogueo = @usuario
End
go

-- LISTADO DE TODOS LOS MENSAJES COMUNES ENVIADOS POR UN USUARIO ACTUALMENTE LOGUEADO --
create proc ListadoMComunesEnviadosPorUsuario @usuario char(8) AS
Begin	
	select * from Mensaje inner join
	Comun on Comun.Codigo = Mensaje.Codigo
	where UsuarioLogueo = @usuario
End
go

-- LISTADO DE TODOS LOS MENSAJES PRIVADOS RECIBIDOS POR UN USUARIO ACTUALMENTE LOGUEADO --
create proc ListadoMPrivadosRecibidosPorUsuario @usuario char(8) AS
Begin	
	select * from Mensaje inner join
	Privado on Privado.Codigo = Mensaje.Codigo 
	where Mensaje.Codigo in (select Codigo from Reciben where Reciben.UsuarioLogueo = @usuario) and
	Privado.FechaCaducidad >= getdate()
End
go

-- LISTADO DE TODOS LOS MENSAJES COMUNES RECIBIDOS POR UN USUARIO ACTUALMENTE LOGUEADO --
create proc ListadoMComunesRecibidosPorUsuario @usuario char(8) AS
Begin	
	select * from Mensaje inner join
	Comun on Comun.Codigo = Mensaje.Codigo	
	where Mensaje.Codigo in (select Codigo from Reciben where Reciben.UsuarioLogueo = @usuario)
End
go

-- ALTA USUARIO --
Create Procedure AltaUsuario @logueo char(8), @contrasena char(6), @nombre varchar(50), 
								@apellido varchar(50), @mail varchar(50) AS
Begin		
		if exists (select * from Usuario where UsuarioLogueo = @logueo and Activo = 0)
			begin 				
				update Usuario
				set Contrasena = @contrasena, Nombre = @nombre, Apellido = @apellido, 
				Mail = @mail, Activo = 1
				where UsuarioLogueo = @logueo
				return 1
			end		
		
		if exists (select * from Usuario where UsuarioLogueo = @logueo and Activo = 1)
			return -1

		Insert Usuario (UsuarioLogueo, Contrasena, Nombre, Apellido, Mail) 
				values (@logueo, @contrasena, @nombre, @apellido, @mail)
			return 1
End
go

-- BUSCAR USUARIO --
create proc BuscarUsuario @logueo char(8) AS
Begin
	select * from Usuario where UsuarioLogueo = @logueo
End
go

-- BUSCAR USUARIO ACTIVO --
create proc BuscarUsuarioActivo @logueo char(8) AS
Begin
	select * from Usuario where UsuarioLogueo = @logueo and Activo = 1
End
go

-- LOGUEO DE USUARIO (USUARIO Y CONTRASEÑA) --
create proc LogueodeUsuario @logueo char(8), @contrasena char(6) AS
Begin
	select * from Usuario where UsuarioLogueo = @logueo and Activo = 1 and Contrasena = @contrasena
End
go

-- MODIFICAR USUARIO --
create Procedure ModificarUsuario @logueo char(8), @contrasena char(6), @nombre varchar(50),
								@apellido varchar(50), @mail varchar(50) AS
Begin
	if not exists(Select * From Usuario Where UsuarioLogueo = @logueo and Activo = 1)			
		return -1
			
	else
		Begin
			Update Usuario set Contrasena = @contrasena, Nombre = @nombre, Apellido = @apellido,
			Mail = @mail where UsuarioLogueo = @logueo
				if (@@ERROR = 0)
					return 1
				else
					return -2
		End
End
go

-- ELIMINAR USUARIO --
create procedure BajaUsuario @logueo char(8) AS
Begin		
		if not exists(select * from Usuario where UsuarioLogueo = @logueo)			
			return -1					
		
		if exists (select * from Mensaje where Mensaje.UsuarioLogueo = @logueo or 
		   exists (select * from Reciben where Reciben.UsuarioLogueo = @logueo))
			begin				
				update Usuario set Activo = 0 where UsuarioLogueo = @logueo
				return 1 
			End
		else
			delete from Usuario where UsuarioLogueo = @logueo
				if (@@ERROR = 0)
					return 1
				else
					return -2		
end
go

-- ESTADÍSTICAS --
create proc Estadisticas @usuActivos int output, @mComunes int output, @mPrivados int output AS
Begin
	set @usuActivos = (select count(*) from Usuario where Activo = 1)

	set @mComunes =  (select count(*) from Comun)

	set @mPrivados =  (select count(*) from Privado)	
End
go

create proc Estadisticas2 @mTiposMensaje int output, @tipoMensaje char(3) as
Begin
	set @mTiposMensaje = (select count(*) from Comun	
	where Comun.TipoMensaje = @tipoMensaje)	
End
go


-- Prueba Cantidad de Mensajes por tipo para el Obligatorio II --
select Comun.TipoMensaje as 'Tipos', count(*) as 'Cantidad' from Comun group by TipoMensaje
