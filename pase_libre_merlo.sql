CREATE DATABASE pase_libre;
USE pase_libre;

CREATE TABLE IF NOT EXISTS SOCIO (
    socio_id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(20) NOT NULL,
    apellido VARCHAR(20) NOT NULL,
    email VARCHAR(50) UNIQUE NOT NULL,
    telefono VARCHAR(20),
    fecha_alta DATE NOT NULL,
    estado_plan VARCHAR(20) NOT NULL
        CHECK (estado_plan IN ('activo','inactivo','suspendido'))
);

CREATE TABLE IF NOT EXISTS EMPRESA (
    empresa_id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(20) NOT NULL,
    tipo VARCHAR(20) NOT NULL,             
    rut VARCHAR(30) NOT NULL,
    rubro VARCHAR(20),
    email VARCHAR(50),
    telefono VARCHAR(20)
);

CREATE TABLE IF NOT EXISTS CONVENIO_EMPRESA_PASELIBRE (
    convenio_id INT PRIMARY KEY AUTO_INCREMENT,
    empresa_id INT NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE NOT NULL,
    porcentaje_descuento DECIMAL(5,2) NOT NULL,
    estado VARCHAR(20) NOT NULL CHECK (estado IN ('activo','vencido')),
    FOREIGN KEY (empresa_id) REFERENCES EMPRESA(empresa_id)
);

CREATE TABLE IF NOT EXISTS PLAN (
    plan_id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(20) NOT NULL,        
    descripcion VARCHAR(250),
    precio_base DECIMAL(10,2) NOT NULL
);

CREATE TABLE IF NOT EXISTS CONVENIO_SOCIO (
    socio_convenio_id INT PRIMARY KEY AUTO_INCREMENT,
    socio_id INT NOT NULL,
    convenio_id INT NOT NULL,
    fecha_alta DATE NOT NULL,
    fecha_baja DATE,
    estado VARCHAR(20) NOT NULL CHECK (estado IN ('activo','baja')),
    FOREIGN KEY (socio_id) REFERENCES SOCIO(socio_id),
    FOREIGN KEY (convenio_id) REFERENCES CONVENIO_EMPRESA_PASELIBRE(convenio_id)
);

CREATE TABLE IF NOT EXISTS SOCIO_PLAN (
    socio_plan_id INT PRIMARY KEY AUTO_INCREMENT,
    socio_id INT NOT NULL,
    plan_id INT NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE,
    estado VARCHAR(20) NOT NULL
        CHECK (estado IN ('activo','vencido','pausado')),
    FOREIGN KEY (socio_id) REFERENCES SOCIO(socio_id),
    FOREIGN KEY (plan_id) REFERENCES PLAN(plan_id)
);

CREATE TABLE IF NOT EXISTS CENTRO_DEPORTIVO (
    centro_id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(20) NOT NULL,
    razon_social VARCHAR(20) NOT NULL,
    rut VARCHAR(30) NOT NULL,
    email VARCHAR(50),
    telefono VARCHAR(20)
);

CREATE TABLE IF NOT EXISTS SEDE (
    sede_id INT PRIMARY KEY AUTO_INCREMENT,
    centro_id INT NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    direccion VARCHAR(50) NOT NULL,
    barrio VARCHAR(20),
    departamento VARCHAR(20) NOT NULL,
    FOREIGN KEY (centro_id) REFERENCES CENTRO_DEPORTIVO(centro_id)
);

CREATE TABLE IF NOT EXISTS ACTIVIDAD (
    actividad_id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(20) NOT NULL,
    descripcion TEXT
);

CREATE TABLE IF NOT EXISTS ENTRENADOR (
    entrenador_id INT PRIMARY KEY AUTO_INCREMENT,
    sede_id INT NOT NULL,
    nombre VARCHAR(20) NOT NULL,
    email VARCHAR(50),
    telefono VARCHAR(20),
    especialidad VARCHAR(30),
    activo BOOLEAN NOT NULL,
    FOREIGN KEY (sede_id) REFERENCES SEDE(sede_id)
);

CREATE TABLE IF NOT EXISTS CLASE (
    clase_id INT PRIMARY KEY AUTO_INCREMENT,
    actividad_id INT NOT NULL,
    entrenador_id INT NOT NULL,
    plan_minimo_id INT,              
    fecha DATE NOT NULL,
    hora_inicio TIME NOT NULL,
    hora_fin TIME NOT NULL,
    estado VARCHAR(20) NOT NULL
        CHECK (estado IN ('activa','cancelada','completa')),
    FOREIGN KEY (actividad_id) REFERENCES ACTIVIDAD(actividad_id),
    FOREIGN KEY (entrenador_id) REFERENCES ENTRENADOR(entrenador_id),
    FOREIGN KEY (plan_minimo_id) REFERENCES PLAN(plan_id)
);

CREATE TABLE IF NOT EXISTS RESERVA (
    reserva_id INT PRIMARY KEY AUTO_INCREMENT,
    socio_id INT NOT NULL,
    clase_id INT NOT NULL,
    fecha_reserva DATETIME NOT NULL,
    estado VARCHAR(20) NOT NULL CHECK (estado IN ('confirmada','cancelada','finalizada')),
    FOREIGN KEY (socio_id) REFERENCES SOCIO(socio_id),
    FOREIGN KEY (clase_id) REFERENCES CLASE(clase_id)
);

CREATE TABLE IF NOT EXISTS EVALUACION (
    evaluacion_id INT PRIMARY KEY AUTO_INCREMENT,
    socio_id INT NOT NULL,
    centro_id INT NOT NULL,
    clase_id INT NOT NULL,
    puntaje INT NOT NULL,
    comentario TEXT,
    fecha DATETIME NOT NULL,
    FOREIGN KEY (socio_id) REFERENCES SOCIO(socio_id),
    FOREIGN KEY (centro_id) REFERENCES CENTRO_DEPORTIVO(centro_id),
    FOREIGN KEY (clase_id) REFERENCES CLASE(clase_id)
);

INSERT INTO SOCIO (nombre, apellido, email, telefono, fecha_alta, estado_plan) VALUES
('Valentina','Merlo','valen.merlo@example.com','098111111','2024-01-10','activo'),
('Lucas','Perez','lucas.perez@example.com','098222222','2024-02-05','activo'),
('Ana','Luna','ana.luna@example.com','098333333','2024-03-01','inactivo'),
('Diego','Silva','diego.silva@example.com','098444444','2024-03-15','activo'),
('Sofia','Ruiz','sofia.ruiz@example.com','098555555','2024-04-01','suspendido'),
('Martín','Gomez','martin.gomez@example.com','098666666','2024-04-10','activo'),
('Carla','Sosa','carla.sosa@example.com','098777777','2024-04-15','activo'),
('Bruno','Fernandez','bruno.fernandez@example.com','098888888','2024-04-20','activo'),
('Lucia','Rodriguez','lucia.rodriguez@example.com','098999999','2024-04-22','activo'),
('Federico','Lopez','fede.lopez@example.com','097111111','2024-04-25','inactivo');

INSERT INTO EMPRESA (nombre, tipo, rut, rubro, email, telefono) VALUES
('BancoSur','banco','123456780019','finanzas','info@bancosur.com','29010001'),
('TecnoCorp','empresa','201122330019','tecnologia','rrhh@tecnocorp.com','29010002'),
('SaludPlus','empresa','301122330019','salud','beneficios@saludplus.com','29010003'),
('MegaBank','banco','123123123019','finanzas','contact@megabank.com','29010004'),
('UruTech','empresa','202202020019','software','info@urutech.com','29010005'),
('AgroSur','empresa','909090900019','agro','contacto@agrosur.com','29010006'),
('SafeLife','empresa','787878780019','seguros','beneficios@safelife.com','29010007'),
('EduPlus','empresa','676767670019','educacion','contact@eduplus.com','29010008'),
('EnerSol','empresa','505050500019','energia','info@enersol.com','29010009'),
('RetailMax','empresa','404040400019','retail','rrhh@retailmax.com','29010010');

INSERT INTO CONVENIO_EMPRESA_PASELIBRE (empresa_id, fecha_inicio, fecha_fin, porcentaje_descuento, estado) VALUES
(1,'2024-01-01','2024-12-31',50,'activo'),
(2,'2024-02-01','2024-09-30',30,'vencido'),
(3,'2024-03-01','2024-12-31',40,'activo'),
(4,'2024-01-15','2024-12-31',35,'activo'),
(5,'2024-03-10','2024-10-10',20,'activo'),
(6,'2024-04-01','2024-12-31',25,'activo'),
(7,'2024-05-01','2024-11-01',15,'activo'),
(8,'2024-06-01','2025-06-01',50,'activo'),
(9,'2024-02-20','2024-12-20',10,'vencido'),
(10,'2024-01-05','2024-12-05',45,'activo');

INSERT INTO PLAN (nombre, descripcion, precio_base) VALUES
('Silver','Acceso básico a centros seleccionados',1200),
('Gold','Más centros y más visitas mensuales',1900),
('Platinum','Acceso ampliado y clases premium',2600),
('Black','Acceso ilimitado y clases especiales',3200),
('Diamond','Full Access sin restricciones',4000),
('Student','Plan preferencial estudiantil',900),
('Corporate Basic','Acceso básico vía empresas',1000),
('Corporate Plus','Acceso ampliado vía empresas',1800),
('Weekend','Acceso solo fines de semana',800),
('FitSenior','Plan para mayores de 60',700);

INSERT INTO CONVENIO_SOCIO (socio_id, convenio_id, fecha_alta, fecha_baja, estado) VALUES
(1,1,'2024-01-10',NULL,'activo'),
(2,1,'2024-02-05',NULL,'activo'),
(3,2,'2024-03-01','2024-09-30','baja'),
(4,3,'2024-03-15',NULL,'activo'),
(5,4,'2024-04-01',NULL,'activo'),
(6,5,'2024-04-10',NULL,'activo'),
(7,6,'2024-04-15',NULL,'activo'),
(8,7,'2024-04-20',NULL,'activo'),
(9,8,'2024-04-22','2024-10-22','baja'),
(10,9,'2024-04-25',NULL,'activo');

INSERT INTO SOCIO_PLAN (socio_id, plan_id, fecha_inicio, fecha_fin, estado) VALUES
(1,2,'2024-01-10',NULL,'activo'),
(2,1,'2024-02-05',NULL,'activo'),
(3,1,'2024-03-01','2024-09-30','vencido'),
(4,3,'2024-03-15',NULL,'activo'),
(5,4,'2024-04-01',NULL,'activo'),
(6,2,'2024-04-10',NULL,'pausado'),
(7,1,'2024-04-15',NULL,'activo'),
(8,3,'2024-04-20',NULL,'activo'),
(9,2,'2024-04-22',NULL,'activo'),
(10,5,'2024-04-25',NULL,'activo');

INSERT INTO CENTRO_DEPORTIVO (nombre, razon_social, rut, email, telefono) VALUES
('FitClub','FitClub SA','111111110019','info@fitclub.com','23010001'),
('PowerGym','PowerGym SRL','222222220019','info@powergym.com','23010002'),
('AquaSport','AquaSport SA','333333330019','info@aquasport.com','23010003'),
('StrongBox','StrongBox SA','444444440019','contact@strongbox.com','23010004'),
('EliteFitness','EliteFitness SA','555555550019','info@elitefit.com','23010005'),
('CardioPlus','CardioPlus SA','666666660019','info@cardioplus.com','23010006'),
('MegaFit','MegaFit SRL','777777770019','info@megafit.com','23010007'),
('BodyZone','BodyZone SA','888888880019','contact@bodyzone.com','23010008'),
('UrbanGym','UrbanGym SA','999999990019','info@urbangym.com','23010009'),
('PulseCenter','PulseCenter SA','101010100019','info@pulsecenter.com','23010010');

INSERT INTO SEDE (centro_id, nombre, direccion, barrio, departamento) VALUES
(1,'FitClub Centro','18 de Julio 1234','Centro','Montevideo'),
(1,'FitClub Pocitos','Bvar España 567','Pocitos','Montevideo'),
(2,'PowerGym Prado','Av Millán 999','Prado','Montevideo'),
(3,'AquaSport Cdla','Rambla 123','Ciudadela','Montevideo'),
(4,'StrongBox Centro','Colonia 1500','Centro','Montevideo'),
(5,'EliteFitness Pocitos','Chucarro 800','Pocitos','Montevideo'),
(6,'CardioPlus Tres Cruces','Av Italia 2200','Tres Cruces','Montevideo'),
(7,'MegaFit Buceo','Av Rivera 3200','Buceo','Montevideo'),
(8,'BodyZone Carrasco','Arocena 1600','Carrasco','Montevideo'),
(9,'UrbanGym Cordón','Gonzalo Ramirez 950','Cordón','Montevideo');

INSERT INTO ENTRENADOR (sede_id, nombre, email, telefono, especialidad, activo) VALUES
(1,'Marcos','marcos@fitclub.com','091111111','Yoga',TRUE),
(1,'Lucia','lucia@fitclub.com','091222222','Spinning',TRUE),
(2,'Jose','jose@fitclub.com','091333333','Funcional',TRUE),
(3,'Carla','carla@aquasport.com','091444444','Natación',TRUE),
(4,'Pedro','pedro@strongbox.com','091555555','Crossfit',TRUE),
(5,'Sofia','sofia@elitefit.com','091666666','Pilates',TRUE),
(6,'Martin','martin@cardioplus.com','091777777','Cardio',FALSE),
(7,'Paula','paula@megafit.com','091888888','Funcional',TRUE),
(8,'Diego','diego@bodyzone.com','091999999','Stretching',TRUE),
(9,'Bruno','bruno@urbangym.com','092111111','HIIT',TRUE);

INSERT INTO CLASE (actividad_id, entrenador_id, plan_minimo_id, fecha, hora_inicio, hora_fin, estado) VALUES
(1,1,1,'2024-05-10','08:00:00','09:00:00','activa'),
(2,2,1,'2024-05-10','18:00:00','19:00:00','activa'),
(3,3,2,'2024-05-11','19:00:00','20:00:00','activa'),
(4,4,2,'2024-05-12','07:00:00','08:00:00','completa'),
(1,5,1,'2024-05-13','09:00:00','10:00:00','cancelada'),
(2,6,2,'2024-05-14','20:00:00','21:00:00','activa'),
(3,7,1,'2024-05-15','08:00:00','09:00:00','activa'),
(4,8,3,'2024-05-16','18:00:00','19:00:00','activa'),
(1,9,3,'2024-05-17','19:00:00','20:00:00','activa'),
(2,10,2,'2024-05-18','17:00:00','18:00:00','activa');

INSERT INTO RESERVA (socio_id, clase_id, fecha_reserva, estado) VALUES
(1,1,'2024-05-01 10:00:00','confirmada'),
(2,2,'2024-05-02 11:00:00','usada'),
(3,3,'2024-05-03 12:00:00','cancelada'),
(4,4,'2024-05-04 13:00:00','usada'),
(5,5,'2024-05-05 14:00:00','confirmada'),
(6,6,'2024-05-06 15:00:00','confirmada'),
(7,7,'2024-05-07 16:00:00','usada'),
(8,8,'2024-05-08 17:00:00','usada'),
(9,9,'2024-05-09 18:00:00','cancelada'),
(10,10,'2024-05-10 19:00:00','confirmada');

INSERT INTO EVALUACION (socio_id, centro_id, clase_id, puntaje, comentario, fecha) VALUES
(1,1,1,5,'Excelente clase','2024-05-10 10:00:00'),
(2,1,2,4,'Muy buena','2024-05-10 20:00:00'),
(3,2,3,3,'Normal','2024-05-11 09:00:00'),
(4,2,4,5,'Intensa pero buena','2024-05-12 11:00:00'),
(5,3,5,2,'No me gustó','2024-05-13 08:00:00'),
(6,4,6,5,'Entrenador excelente','2024-05-14 12:00:00'),
(7,5,7,4,'Me gustó el estilo','2024-05-15 09:00:00'),
(8,6,8,5,'Muy recomendable','2024-05-16 10:00:00'),
(9,7,9,3,'Podría mejorar','2024-05-17 18:00:00'),
(10,8,10,4,'Buen ambiente y clase','2024-05-18 19:30:00');
