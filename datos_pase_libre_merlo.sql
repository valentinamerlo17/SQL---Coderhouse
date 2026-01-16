USE pase_libre;

INSERT INTO SOCIO (nombre, apellido, email, telefono, fecha_alta, estado_plan) VALUES
('Valentina','Merlo','valentina.merlo@mail.com','099100001','2024-01-10','activo'),
('Lucas','Perez','lucas.perez@mail.com','099100002','2024-01-15','activo'),
('Ana','Luna','ana.luna@mail.com','099100003','2024-02-01','activo'),
('Diego','Silva','diego.silva@mail.com','099100004','2024-02-10','activo'),
('Sofia','Ruiz','sofia.ruiz@mail.com','099100005','2024-02-20','activo'),
('Martin','Gomez','martin.gomez@mail.com','099100006','2024-03-01','activo'),
('Carla','Sosa','carla.sosa@mail.com','099100007','2024-03-10','activo'),
('Bruno','Fernandez','bruno.fernandez@mail.com','099100008','2024-03-15','activo'),
('Lucia','Rodriguez','lucia.rodriguez@mail.com','099100009','2024-03-20','activo'),
('Federico','Lopez','federico.lopez@mail.com','099100010','2024-03-25','activo');

INSERT INTO EMPRESA (nombre, tipo, rut, rubro, email, telefono) VALUES
('Banco Sur','banco','111111110019','finanzas','contacto@bancosur.com','29010001'),
('TechCorp','empresa','222222220019','tecnologia','rrhh@techcorp.com','29010002'),
('SaludPlus','empresa','333333330019','salud','beneficios@saludplus.com','29010003'),
('MegaBank','banco','444444440019','finanzas','contacto@megabank.com','29010004'),
('EduPlus','empresa','555555550019','educacion','beneficios@eduplus.com','29010005'),
('EnerSol','empresa','666666660019','energia','rrhh@enersol.com','29010006'),
('AgroSur','empresa','777777770019','agro','beneficios@agrosur.com','29010007'),
('RetailMax','empresa','888888880019','retail','rrhh@retailmax.com','29010008'),
('SafeLife','empresa','999999990019','seguros','beneficios@safelife.com','29010009'),
('UruTech','empresa','101010100019','software','rrhh@urutech.com','29010010');

INSERT INTO PLAN (nombre, descripcion, precio_base) VALUES
('Silver','Acceso basico',1200.00),
('Gold','Acceso intermedio',1800.00),
('Platinum','Acceso completo',2500.00),
('Black','Acceso premium',3200.00),
('Diamond','Acceso total',4000.00);

INSERT INTO CENTRO_DEPORTIVO (nombre, razon_social, rut, email, telefono) VALUES
('FitCenter','FitCenter SA','201111110019','info@fitcenter.com','23010001'),
('PowerGym','PowerGym SRL','202222220019','info@powergym.com','23010002'),
('UrbanFit','UrbanFit SA','203333330019','info@urbanfit.com','23010003'),
('AquaSport','AquaSport SA','204444440019','info@aquasport.com','23010004'),
('StrongBox','StrongBox SA','205555550019','info@strongbox.com','23010005'),
('ZenStudio','ZenStudio SA','206666660019','info@zenstudio.com','23010006'),
('CardioPlus','CardioPlus SA','207777770019','info@cardioplus.com','23010007'),
('BodyZone','BodyZone SA','208888880019','info@bodyzone.com','23010008'),
('MegaFit','MegaFit SRL','209999990019','info@megafit.com','23010009'),
('PulseCenter','PulseCenter SA','210101010019','info@pulsecenter.com','23010010');

INSERT INTO SEDE (centro_id, nombre, direccion, barrio, departamento) VALUES
(1,'FitCenter Centro','18 de Julio 1200','Centro','Montevideo'),
(1,'FitCenter Pocitos','Av Brasil 2400','Pocitos','Montevideo'),
(2,'PowerGym Prado','Av Millan 1500','Prado','Montevideo'),
(3,'UrbanFit Cordon','Av Rivera 1900','Cordon','Montevideo'),
(4,'AquaSport Rambla','Rambla 500','Ciudadela','Montevideo'),
(5,'StrongBox Centro','Colonia 1500','Centro','Montevideo'),
(6,'ZenStudio Punta','Bulevar Artigas 3000','Punta Carretas','Montevideo'),
(7,'CardioPlus Tres Cruces','Av Italia 2200','Tres Cruces','Montevideo'),
(8,'BodyZone Carrasco','Arocena 1600','Carrasco','Montevideo'),
(9,'MegaFit Buceo','Av Rivera 3200','Buceo','Montevideo');

INSERT INTO ACTIVIDAD (nombre, descripcion) VALUES
('Yoga','Clase de yoga'),
('Spinning','Bicicleta fija'),
('Funcional','Entrenamiento funcional'),
('Crossfit','Alta intensidad'),
('Pilates','Trabajo de core'),
('Natacion','Entrenamiento en piscina'),
('Boxeo','Tecnica y cardio'),
('Zumba','Baile aerobico'),
('HIIT','Intervalos alta intensidad'),
('Stretching','Movilidad y elongacion');

INSERT INTO ENTRENADOR (sede_id, nombre, email, telefono, especialidad, activo) VALUES
(1,'Marcos','marcos@fitcenter.com','091000001','Yoga',TRUE),
(2,'Lucia','lucia@fitcenter.com','091000002','Spinning',TRUE),
(3,'Pedro','pedro@powergym.com','091000003','Funcional',TRUE),
(4,'Sofia','sofia@urbanfit.com','091000004','Crossfit',TRUE),
(5,'Bruno','bruno@aquasport.com','091000005','Natacion',TRUE),
(6,'Carla','carla@strongbox.com','091000006','Boxeo',TRUE),
(7,'Ana','ana@zenstudio.com','091000007','Pilates',TRUE),
(8,'Diego','diego@cardioplus.com','091000008','HIIT',TRUE),
(9,'Paula','paula@bodyzone.com','091000009','Zumba',TRUE),
(10,'Jose','jose@megafit.com','091000010','Stretching',TRUE);

INSERT INTO CONVENIO_EMPRESA_PASELIBRE (empresa_id, fecha_inicio, fecha_fin, porcentaje_descuento, estado) VALUES
(1,'2024-01-01','2024-12-31',50.00,'activo'),
(2,'2024-02-01','2024-12-31',30.00,'activo'),
(3,'2024-03-01','2024-12-31',40.00,'activo'),
(4,'2024-01-15','2024-12-31',35.00,'activo'),
(5,'2024-04-01','2024-12-31',20.00,'activo'),
(6,'2024-04-15','2024-12-31',25.00,'activo'),
(7,'2024-05-01','2024-11-30',15.00,'activo'),
(8,'2024-06-01','2025-06-01',45.00,'activo'),
(9,'2024-02-20','2024-10-20',10.00,'vencido'),
(10,'2024-01-05','2024-12-05',28.00,'activo');

INSERT INTO CONVENIO_SOCIO (socio_id, convenio_id, fecha_alta, fecha_baja, estado) VALUES
(1,1,'2024-01-10',NULL,'activo'),
(2,2,'2024-01-15',NULL,'activo'),
(3,3,'2024-02-01',NULL,'activo'),
(4,4,'2024-02-10',NULL,'activo'),
(5,5,'2024-02-20',NULL,'activo'),
(6,6,'2024-03-01',NULL,'activo'),
(7,7,'2024-03-10',NULL,'activo'),
(8,8,'2024-03-15',NULL,'activo'),
(9,9,'2024-03-20','2024-10-20','baja'),
(10,10,'2024-03-25',NULL,'activo');

INSERT INTO SOCIO_PLAN (socio_id, plan_id, fecha_inicio, fecha_fin, precio_final, estado) VALUES
(1,3,'2024-01-10',NULL,1500.00,'activo'),
(2,2,'2024-01-15',NULL,1260.00,'activo'),
(3,1,'2024-02-01',NULL,720.00,'activo'),
(4,4,'2024-02-10',NULL,2080.00,'activo'),
(5,5,'2024-02-20',NULL,3200.00,'activo'),
(6,2,'2024-03-01',NULL,3375.00,'activo'),
(7,5,'2024-03-10',NULL,4250.00,'activo'),
(8,2,'2024-03-15',NULL,3025.00,'activo'),
(9,4,'2024-03-20','2024-10-20',1620.00,'vencido'),
(10,3,'2024-03-25',NULL,4680.00,'activo');

INSERT INTO CLASE (actividad_id, entrenador_id, plan_minimo_id, fecha, hora_inicio, hora_fin, estado) VALUES
(1,1,1,'2024-05-10','08:00:00','09:00:00','activa'),
(2,2,1,'2024-05-10','18:00:00','19:00:00','activa'),
(3,3,2,'2024-05-11','19:00:00','20:00:00','activa'),
(4,4,3,'2024-05-12','07:00:00','08:00:00','activa'),
(5,7,1,'2024-05-13','09:00:00','10:00:00','activa'),
(6,5,2,'2024-05-14','20:00:00','21:00:00','activa'),
(7,6,3,'2024-05-15','08:00:00','09:00:00','activa'),
(8,9,1,'2024-05-16','18:00:00','19:00:00','activa'),
(9,8,2,'2024-05-17','19:00:00','20:00:00','activa'),
(10,10,1,'2024-05-18','17:00:00','18:00:00','activa');

INSERT INTO RESERVA (socio_id, clase_id, fecha_reserva, estado) VALUES
(1,4,'2024-05-01 10:00:00','confirmada'), -- socio plan 3 >= clase min 3
(2,3,'2024-05-01 11:00:00','usada'),       -- socio plan 2 >= clase min 2
(3,1,'2024-05-02 12:00:00','confirmada'),  -- socio plan 1 >= clase min 1
(4,7,'2024-05-03 13:00:00','usada'),       -- socio plan 4 >= clase min 3
(5,9,'2024-05-04 14:00:00','cancelada'),   -- socio plan 5 >= clase min 2
(6,6,'2024-05-05 15:00:00','confirmada'),  -- socio plan 6 >= clase min 2
(7,4,'2024-05-06 16:00:00','usada'),       -- socio plan 7 >= clase min 3
(8,8,'2024-05-07 17:00:00','confirmada'),  -- socio plan 8 >= clase min 1
(10,10,'2024-05-08 18:00:00','confirmada'),-- socio plan 9 >= clase min 1
(1,2,'2024-05-09 19:00:00','usada');       -- socio plan 3 >= clase min 1

INSERT INTO EVALUACION (socio_id, centro_id, clase_id, puntaje, comentario, fecha) VALUES
(1,3,4,5,'Excelente clase','2024-05-12 08:30:00'),
(2,1,3,4,'Muy buena','2024-05-11 20:30:00'),
(3,1,1,3,'Correcta','2024-05-10 09:15:00'),
(4,5,7,5,'Intensa y efectiva','2024-05-15 09:15:00'),
(5,7,9,2,'Podria mejorar','2024-05-17 20:15:00'),
(6,4,6,4,'Buen entrenamiento','2024-05-14 21:15:00'),
(7,3,4,5,'Me encanto','2024-05-12 08:40:00'),
(8,8,8,4,'Buen ambiente','2024-05-16 19:10:00'),
(9,2,2,3,'Bien','2024-05-10 19:10:00'),
(10,9,10,5,'Excelente','2024-05-18 18:10:00');
