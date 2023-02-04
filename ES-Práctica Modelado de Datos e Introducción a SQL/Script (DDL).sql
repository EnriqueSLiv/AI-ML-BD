
--/Esquema

create schema kcfleetcontrol authorization neoxzwaz;

--//Tablas

---Tabla Color

create table kcfleetcontrol.color(
idcolor varchar (20) not null,					--PK
nombrecolor varchar (40) not null,
constraint color_PK primary key(idcolor)
);

---Tabla Moneda

create table kcfleetcontrol.moneda(
idmoneda varchar (20) not null,					--PK
nombremoneda varchar (40) not null,
constraint moneda_PK primary key(idmoneda)
);


---Tabla Compañía Aseguradora

create table kcfleetcontrol.coaseguradora(
idcoaseguradora varchar (20) not null,			--PK
nombrecoaseguradora varchar (40) not null,
constraint coaseguradora_PK primary key(idcoaseguradora)
);

---Tabla Grupo Empresarial

create table kcfleetcontrol.grupoempresarial(
idgrupoempresarial varchar (20) not null, 		--PK
nombregrupoempresarial varchar(40) not null,
constraint grupoempresarial_PK primary key(idgrupoempresarial)
);

---Tabla Marca

create table kcfleetcontrol.marca(
idmarca varchar (20) not null,					--PK
nombremarca varchar (40) not null,
grupoempresarial varchar (40) not null,			--FK
constraint marca_PK primary key(idmarca),
constraint marca_grupoempresarial_FK foreign key(grupoempresarial)
references kcfleetcontrol.grupoempresarial(idgrupoempresarial)
);

---Tabla Modelo

create table kcfleetcontrol.modelo(
idmodelo varchar (20) not null,					--PK
nombremodelo varchar (40) not null,
marca varchar (40) not null,					--FK
constraint modelo_PK primary key(idmodelo),
constraint modelo_marca_FK foreign key(marca)
references kcfleetcontrol.marca(idmarca)
);

---Tabla Coches

create table kcfleetcontrol.coche(
idcoche varchar (20) not null,					--PK
modelo varchar (40) not null,					--FK
matricula varchar (40) not null,
color varchar (40) not null,					--FK
coaseguradora varchar (40) not null,			--FK
fechacompra date not null,
fechabaja date not null default '4000-01-01',
npoliza varchar (40) not null,
totalkms int not null,				
constraint coche_PK primary key(idcoche),
constraint coche_modelo_FK foreign key (modelo)
references kcfleetcontrol.modelo(idmodelo),
constraint coche_color_FK foreign key (color)
references kcfleetcontrol.color(idcolor),
constraint coche_coaseguradora_FK foreign key (coaseguradora)
references kcfleetcontrol.coaseguradora(idcoaseguradora)
);

---Tabla Revisiones

create table kcfleetcontrol.revision(
idrevision varchar (20) not null,				--PK
coche varchar (20) not null,					--FK
ordinal int not null,
fecharevision date not null,
importe varchar (20) not null,
kmsrevision int not null,
moneda varchar (20) not null,					--FK
constraint revision_PK primary key(idrevision, coche, ordinal),
constraint revision_coche_FK foreign key(coche)
references kcfleetcontrol.coche(idcoche),
constraint revision_moneda_FK foreign key(moneda)
references kcfleetcontrol.moneda(idmoneda)
);

--//Carga de Datos

---Datos Tabla Color

insert into kcfleetcontrol.color(idcolor, nombrecolor)values('CL-01', 'Gris');
insert into kcfleetcontrol.color(idcolor, nombrecolor)values('CL-02', 'Negro');
insert into kcfleetcontrol.color(idcolor, nombrecolor)values('CL-03', 'Azul');
insert into kcfleetcontrol.color(idcolor, nombrecolor)values('CL-04', 'Blanco');

---Datos Tabla Moneda

insert into kcfleetcontrol.moneda(idmoneda, nombremoneda) values('MO-01', 'Euro');

---Datos Tabla Compañías Aseguradora

insert into kcfleetcontrol.coaseguradora(idcoaseguradora, nombrecoaseguradora)values('AS-01','Mapfre');
insert into kcfleetcontrol.coaseguradora(idcoaseguradora, nombrecoaseguradora)values('AS-02','MMT');
insert into kcfleetcontrol.coaseguradora(idcoaseguradora, nombrecoaseguradora)values('AS-03','AXA');
insert into kcfleetcontrol.coaseguradora(idcoaseguradora, nombrecoaseguradora)values('AS-04','Allianz');

---Datos Tabla Grupo Empresarial

insert into kcfleetcontrol.grupoempresarial(idgrupoempresarial, nombregrupoempresarial)values('GE-01', 'FCA');
insert into kcfleetcontrol.grupoempresarial(idgrupoempresarial, nombregrupoempresarial)values('GE-02', 'PSA');
insert into kcfleetcontrol.grupoempresarial(idgrupoempresarial, nombregrupoempresarial)values('GE-03', 'Hyundai');
insert into kcfleetcontrol.grupoempresarial(idgrupoempresarial, nombregrupoempresarial)values('GE-04', 'Toyota');

---Datos Tabla Marca

insert into kcfleetcontrol.marca(idmarca, nombremarca, grupoempresarial)values('MC-01','Dodge','GE-01');
insert into kcfleetcontrol.marca(idmarca, nombremarca, grupoempresarial)values('MC-02','Fiat','GE-01');
insert into kcfleetcontrol.marca(idmarca, nombremarca, grupoempresarial)values('MC-03','Citroen','GE-02');
insert into kcfleetcontrol.marca(idmarca, nombremarca, grupoempresarial)values('MC-04','Peugeot','GE-02');
insert into kcfleetcontrol.marca(idmarca, nombremarca, grupoempresarial)values('MC-05','Kia','GE-03');
insert into kcfleetcontrol.marca(idmarca, nombremarca, grupoempresarial)values('MC-06','Hyundai','GE-03');
insert into kcfleetcontrol.marca(idmarca, nombremarca, grupoempresarial)values('MC-07','Lexus','GE-04');
insert into kcfleetcontrol.marca(idmarca, nombremarca, grupoempresarial)values('MC-08','Toyota','GE-04');

---Datos Tabla Modelo

insert into kcfleetcontrol.modelo(idmodelo, nombremodelo, marca)values('ML-01','Dodge-Journey','MC-01');
insert into kcfleetcontrol.modelo(idmodelo, nombremodelo, marca)values('ML-02','Fiat-Cronos','MC-02');
insert into kcfleetcontrol.modelo(idmodelo, nombremodelo, marca)values('ML-03','Fiat-Argo','MC-02');
insert into kcfleetcontrol.modelo(idmodelo, nombremodelo, marca)values('ML-04','Citroen-C3.','MC-03');
insert into kcfleetcontrol.modelo(idmodelo, nombremodelo, marca)values('ML-05','Gt-Line.','MC-04');
insert into kcfleetcontrol.modelo(idmodelo, nombremodelo, marca)values('ML-06','Kia-Stonic','MC-05');
insert into kcfleetcontrol.modelo(idmodelo, nombremodelo, marca)values('ML-07','Kia-Soluto','MC-05');
insert into kcfleetcontrol.modelo(idmodelo, nombremodelo, marca)values('ML-08','Hyundai-Kona','MC-06');
insert into kcfleetcontrol.modelo(idmodelo, nombremodelo, marca)values('ML-09','ES-300h','MC-07');
insert into kcfleetcontrol.modelo(idmodelo, nombremodelo, marca)values('ML-10','Harrier','MC-08');

---Datos Tabla Coches

insert into kcfleetcontrol.coche values('CO-01','ML-08','1324 DBC','CL-03','AS-04','2020-02-15',default,'585-11-4752','45000');
insert into kcfleetcontrol.coche values('CO-02','ML-05','1928 SSG','CL-01','AS-01','2019-05-11',default,'257-18-8458','58000');
insert into kcfleetcontrol.coche values('CO-03','ML-07','7826 DGN','CL-04','AS-03','2018-09-18',default,'485-17-7784','59000');
insert into kcfleetcontrol.coche values('CO-04','ML-10','5827 LDK','CL-03','AS-02','2017-02-12',default,'855-71-7232','62000');
insert into kcfleetcontrol.coche values('CO-05','ML-01','3294 PSS','CL-02','AS-01','2019-04-08',default,'483-22-4129','48000');
insert into kcfleetcontrol.coche values('CO-06','ML-03','8324 IYD','CL-01','AS-04','2017-08-08',default,'879-18-187','59800');
insert into kcfleetcontrol.coche values('CO-07','ML-09','1930 PSD','CL-02','AS-02','2020-07-19',default,'874-45-5874','42000');
insert into kcfleetcontrol.coche values('CO-08','ML-01','8833 PSG','CL-01','AS-04','2018-03-25',default,'874-87-6984','55200');
insert into kcfleetcontrol.coche values('CO-09','ML-06','3284 OPA','CL-02','AS-03','2019-12-05',default,'251-18-1872','44000');
insert into kcfleetcontrol.coche values('CO-10','ML-04','1842 OUD','CL-04','AS-01','2017-02-07',default,'874-54-3128','64000');
insert into kcfleetcontrol.coche values('CO-11','ML-02','5537 VVB','CL-02','AS-04','2021-06-30',default,'126-83-8436','30500');
insert into kcfleetcontrol.coche values('CO-12','ML-07','1584 PSI','CL-01','AS-02','2019-09-19',default,'843-61-9812','32000');

---Datos Tabla Revisión

insert into kcfleetcontrol.revision values('RV-01','CO-01','1','2021-05-18','800','10000','MO-01');
insert into kcfleetcontrol.revision values('RV-02','CO-02','2','2019-05-11','1200','15000','MO-01');
insert into kcfleetcontrol.revision values('RV-03','CO-03','3','2018-09-18','1350','25000','MO-01');
insert into kcfleetcontrol.revision values('RV-04','CO-04','4','2017-02-12','1500','30000','MO-01');
insert into kcfleetcontrol.revision values('RV-05','CO-05','5','2019-04-08','1800','35000','MO-01');
insert into kcfleetcontrol.revision values('RV-06','CO-06','6','2017-08-08','1750','45000','MO-01');
insert into kcfleetcontrol.revision values('RV-07','CO-07','7','2020-07-19','1000','20000','MO-01');
insert into kcfleetcontrol.revision values('RV-08','CO-08','8','2018-03-25','1850','30000','MO-01');
insert into kcfleetcontrol.revision values('RV-09','CO-09','9','2019-12-05','1700','35000','MO-01');
insert into kcfleetcontrol.revision values('RV-10','CO-10','10','2017-02-07','1900','40000','MO-01');
insert into kcfleetcontrol.revision values('RV-11','CO-11','11','2021-06-30','950','20000','MO-01');
insert into kcfleetcontrol.revision values('RV-12','CO-12','12','2019-09-19','1650','35000','MO-01');


----Validar en Scritp (AccesoDatos)


