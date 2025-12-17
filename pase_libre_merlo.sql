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
