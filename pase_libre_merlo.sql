CREATE DATABASE IF NOT EXISTS pase_libre;
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
    precio_final DECIMAL(10,2),
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
    estado VARCHAR(20) NOT NULL CHECK (estado IN ('confirmada','cancelada','usada')),
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

CREATE OR REPLACE VIEW vw_socio_plan_activo AS
SELECT
    s.socio_id,
    s.nombre,
    s.apellido,
    s.email,
    sp.fecha_inicio,
    p.plan_id,
    p.nombre AS nombre_plan,
    p.precio_base
FROM SOCIO s
JOIN SOCIO_PLAN sp ON sp.socio_id = s.socio_id
JOIN PLAN p ON p.plan_id = sp.plan_id
WHERE sp.estado = 'activo';

CREATE OR REPLACE VIEW vw_reservas_detalle AS
SELECT
    r.reserva_id,
    r.socio_id,
    CONCAT(s.nombre,' ',s.apellido) AS socio,
    r.clase_id,
    a.nombre AS actividad,
    c.fecha,
    c.hora_inicio,
    c.hora_fin,
    r.estado AS estado_reserva,
    c.estado AS estado_clase
FROM RESERVA r
JOIN SOCIO s ON s.socio_id = r.socio_id
JOIN CLASE c ON c.clase_id = r.clase_id
JOIN ACTIVIDAD a ON a.actividad_id = c.actividad_id;

CREATE OR REPLACE VIEW vw_promedio_evaluacion_centro AS
SELECT
    cd.centro_id,
    cd.nombre AS centro,
    AVG(e.puntaje) AS puntaje_promedio,
    COUNT(*) AS cantidad_evaluaciones
FROM CENTRO_DEPORTIVO cd
JOIN EVALUACION e ON e.centro_id = cd.centro_id
GROUP BY cd.centro_id, cd.nombre;

CREATE OR REPLACE VIEW vw_convenios_empresa AS
SELECT
    e.empresa_id,
    e.nombre AS empresa,
    ce.convenio_id,
    ce.fecha_inicio,
    ce.fecha_fin,
    ce.porcentaje_descuento,
    ce.estado
FROM EMPRESA e
JOIN CONVENIO_EMPRESA_PASELIBRE ce ON ce.empresa_id = e.empresa_id;

CREATE OR REPLACE VIEW vw_clases_plan_minimo AS
SELECT
    c.clase_id,
    a.nombre AS actividad,
    c.fecha,
    c.hora_inicio,
    c.hora_fin,
    c.estado,
    c.plan_minimo_id,
    p.nombre AS plan_minimo_nombre
FROM CLASE c
JOIN ACTIVIDAD a ON a.actividad_id = c.actividad_id
LEFT JOIN PLAN p ON p.plan_id = c.plan_minimo_id;

DELIMITER //

CREATE FUNCTION fn_aplicar_descuento(precio DECIMAL(10,2), porcentaje DECIMAL(5,2))
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    RETURN ROUND(precio * (1 - (porcentaje / 100)), 2);
END //

CREATE FUNCTION fn_plan_activo_id(p_socio_id INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE v_plan_id INT;
    SELECT sp.plan_id INTO v_plan_id
    FROM SOCIO_PLAN sp
    WHERE sp.socio_id = p_socio_id AND sp.estado = 'activo'
    ORDER BY sp.fecha_inicio DESC
    LIMIT 1;
    RETURN v_plan_id;
END //

CREATE FUNCTION fn_descuento_activo_socio(p_socio_id INT)
RETURNS DECIMAL(5,2)
DETERMINISTIC
BEGIN
    DECLARE v_desc DECIMAL(5,2);
    SELECT ce.porcentaje_descuento INTO v_desc
    FROM CONVENIO_SOCIO cs
    JOIN CONVENIO_EMPRESA_PASELIBRE ce ON ce.convenio_id = cs.convenio_id
    WHERE cs.socio_id = p_socio_id
      AND cs.estado = 'activo'
      AND ce.estado = 'activo'
    ORDER BY cs.fecha_alta DESC
    LIMIT 1;

    RETURN IFNULL(v_desc, 0.00);
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE sp_registrar_reserva(
    IN p_socio_id INT,
    IN p_clase_id INT,
    IN p_fecha_reserva DATETIME,
    IN p_estado VARCHAR(20)
)
BEGIN
    IF p_estado NOT IN ('confirmada','cancelada','usada') THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Estado de reserva invalido';
    END IF;

    IF (SELECT COUNT(*) FROM SOCIO WHERE socio_id = p_socio_id) = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Socio inexistente';
    END IF;

    IF (SELECT COUNT(*) FROM CLASE WHERE clase_id = p_clase_id) = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Clase inexistente';
    END IF;

    INSERT INTO RESERVA (socio_id, clase_id, fecha_reserva, estado)
    VALUES (p_socio_id, p_clase_id, p_fecha_reserva, p_estado);
END //

CREATE PROCEDURE sp_cancelar_reserva(IN p_reserva_id INT)
BEGIN
    UPDATE RESERVA
    SET estado = 'cancelada'
    WHERE reserva_id = p_reserva_id;
END //

CREATE PROCEDURE sp_reporte_socios_por_empresa(IN p_empresa_id INT)
BEGIN
    SELECT
        e.empresa_id,
        e.nombre AS empresa,
        COUNT(DISTINCT cs.socio_id) AS cantidad_socios
    FROM EMPRESA e
    JOIN CONVENIO_EMPRESA_PASELIBRE ce ON ce.empresa_id = e.empresa_id
    JOIN CONVENIO_SOCIO cs ON cs.convenio_id = ce.convenio_id
    WHERE e.empresa_id = p_empresa_id
    GROUP BY e.empresa_id, e.nombre;
END //
    
DELIMITER ;

DELIMITER //

CREATE TRIGGER trg_validar_puntaje_evaluacion
BEFORE INSERT ON EVALUACION
FOR EACH ROW
BEGIN
    IF NEW.puntaje < 1 OR NEW.puntaje > 5 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El puntaje debe estar entre 1 y 5';
    END IF;
END //

DELIMITER ;

DELIMITER //

CREATE TRIGGER trg_clase_completa_actualiza_reservas
AFTER UPDATE ON CLASE
FOR EACH ROW
BEGIN
    IF NEW.estado = 'completa' AND OLD.estado <> 'completa' THEN
        UPDATE RESERVA
        SET estado = 'usada'
        WHERE clase_id = NEW.clase_id
          AND estado = 'confirmada';
    END IF;
END //

DELIMITER ;

DELIMITER //

CREATE TRIGGER trg_validar_plan_minimo_reserva
BEFORE INSERT ON RESERVA
FOR EACH ROW
BEGIN
    DECLARE v_plan_socio INT;
    DECLARE v_plan_minimo INT;

    SELECT sp.plan_id
    INTO v_plan_socio
    FROM SOCIO_PLAN sp
    WHERE sp.socio_id = NEW.socio_id
      AND sp.estado = 'activo'
    ORDER BY sp.fecha_inicio DESC
    LIMIT 1;

    IF v_plan_socio IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El socio no tiene un plan activo';
    END IF;

    SELECT c.plan_minimo_id
    INTO v_plan_minimo
    FROM CLASE c
    WHERE c.clase_id = NEW.clase_id;

    IF v_plan_minimo IS NOT NULL AND v_plan_socio < v_plan_minimo THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El plan del socio no cumple el plan minimo requerido para la clase';
    END IF;
END //

DELIMITER ;

