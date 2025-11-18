CREATE DATABASE pase_libre;
USE pase_libre;

CREATE TABLE IF NOT EXISTS SOCIO (
    socio_id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(20),
    apellido VARCHAR(20),
    email VARCHAR(50) UNIQUE,
    telefono VARCHAR(20),
    fecha_alta DATE,
    estado_plan VARCHAR(20)
);

CREATE TABLE IF NOT EXISTS EMPRESA (
    empresa_id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(20),
    tipo VARCHAR(20),             
    rut VARCHAR(30),
    rubro VARCHAR(20),
    email VARCHAR(50),
    telefono VARCHAR(20)
);

CREATE TABLE IF NOT EXISTS CONVENIO_EMPRESA_PASELIBRE (
    convenio_id INT PRIMARY KEY AUTO_INCREMENT,
    empresa_id INT,
    fecha_inicio DATE,
    fecha_fin DATE,
    porcentaje_descuento DECIMAL(5,2),
    estado VARCHAR(20), 
    FOREIGN KEY (empresa_id) REFERENCES EMPRESA(empresa_id)
);

CREATE TABLE IF NOT EXISTS PLAN (
    plan_id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(20),        
    descripcion VARCHAR(250),
    precio_base DECIMAL(10,2)
);

CREATE TABLE IF NOT EXISTS CONVENIO_SOCIO (
    socio_convenio_id INT PRIMARY KEY AUTO_INCREMENT,
    socio_id INT,
    convenio_id INT,
    fecha_alta DATE,
    fecha_baja DATE,
    estado VARCHAR(20), 
    FOREIGN KEY (socio_id) REFERENCES SOCIO(socio_id),
    FOREIGN KEY (convenio_id) REFERENCES CONVENIO_EMPRESA_PASELIBRE(convenio_id)
);

CREATE TABLE IF NOT EXISTS SOCIO_PLAN (
    socio_plan_id INT PRIMARY KEY AUTO_INCREMENT,
    socio_id INT,
    plan_id INT,
    fecha_inicio DATE,
    fecha_fin DATE,
    estado VARCHAR(20),   
    FOREIGN KEY (socio_id) REFERENCES SOCIO(socio_id),
    FOREIGN KEY (plan_id) REFERENCES PLAN(plan_id)
);

CREATE TABLE IF NOT EXISTS CENTRO_DEPORTIVO (
    centro_id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(20),
    razon_social VARCHAR(20),
    rut VARCHAR(30),
    email VARCHAR(50),
    telefono VARCHAR(20)
);

CREATE TABLE IF NOT EXISTS SEDE (
    sede_id INT PRIMARY KEY AUTO_INCREMENT,
    centro_id INT,
    nombre VARCHAR(20),
    direccion VARCHAR(50),
    barrio VARCHAR(20),
    departamento VARCHAR(20),
    FOREIGN KEY (centro_id) REFERENCES CENTRO_DEPORTIVO(centro_id)
);

CREATE TABLE IF NOT EXISTS ACTIVIDAD (
    actividad_id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(20),
    descripcion TEXT
);

CREATE TABLE IF NOT EXISTS ENTRENADOR (
    entrenador_id INT PRIMARY KEY AUTO_INCREMENT,
    sede_id INT,
    nombre VARCHAR(20),
    email VARCHAR(50),
    telefono VARCHAR(02),
    especialidad VARCHAR(30),
    activo BOOLEAN,
    FOREIGN KEY (sede_id) REFERENCES SEDE(sede_id)
);

CREATE TABLE IF NOT EXISTS CLASE (
    clase_id INT PRIMARY KEY AUTO_INCREMENT,
    actividad_id INT,
    entrenador_id INT,
    plan_minimo_id INT,
    fecha DATE,
    hora_inicio TIME,
    hora_fin TIME,
    estado VARCHAR(20),     
    FOREIGN KEY (actividad_id) REFERENCES ACTIVIDAD(actividad_id),
    FOREIGN KEY (entrenador_id) REFERENCES ENTRENADOR(entrenador_id),
    FOREIGN KEY (plan_minimo_id) REFERENCES PLAN(plan_id)
);

CREATE TABLE IF NOT EXISTS RESERVA (
    reserva_id INT PRIMARY KEY AUTO_INCREMENT,
    socio_id INT,
    clase_id INT,
    fecha_reserva DATETIME,
    estado VARCHAR(20),    
    FOREIGN KEY (socio_id) REFERENCES SOCIO(socio_id),
    FOREIGN KEY (clase_id) REFERENCES CLASE(clase_id)
);

CREATE TABLE IF NOT EXISTS EVALUACION (
    evaluacion_id INT PRIMARY KEY AUTO_INCREMENT,
    socio_id INT,
    centro_id INT,
    clase_id INT,
    puntaje INT,
    comentario TEXT,
    fecha DATETIME,
    FOREIGN KEY (socio_id) REFERENCES SOCIO(socio_id),
    FOREIGN KEY (centro_id) REFERENCES CENTRO_DEPORTIVO(centro_id),
    FOREIGN KEY (clase_id) REFERENCES CLASE(clase_id)
);
