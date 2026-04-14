drop database if EXISTS GestionEventos;
CREATE DATABASE IF NOT EXISTS GestionEventos;
USE GestionEventos;

-- ==========================================
-- 1. TABLAS MAESTRAS (Nivel 0 - Sin dependencias)
-- ==========================================

CREATE TABLE Unidad (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL
);

CREATE TABLE TipoPago (
    id INT AUTO_INCREMENT PRIMARY KEY,
    tipo VARCHAR(50) NOT NULL
);

CREATE TABLE Rol (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    tarea TEXT
);

CREATE TABLE Utensilio (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    cantidad INT DEFAULT 0
);

CREATE TABLE GrupoClase (
    id INT AUTO_INCREMENT PRIMARY KEY,
    letra CHAR(1) NOT NULL
);

-- ==========================================
-- 2. TABLAS RELACIONADAS CON PROVEEDORES
-- ==========================================

CREATE TABLE Proveedor (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    url VARCHAR(255)
);

CREATE TABLE Pack (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    id_proveedor INT,
    CONSTRAINT fk_pack_proveedor FOREIGN KEY (id_proveedor) REFERENCES Proveedor(id)
);

-- ==========================================
-- 3. ENTIDADES DE PERSONAS
-- ==========================================

CREATE TABLE Alumno (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido1 VARCHAR(100) NOT NULL,
    apellido2 VARCHAR(100),
    dni VARCHAR(20) UNIQUE,
    halal BOOLEAN DEFAULT FALSE,
    id_grupo INT,
    id_proveedor_responsable INT, -- El alumno responsable del proveedor (Imagen 2)
    CONSTRAINT fk_alumno_grupo FOREIGN KEY (id_grupo) REFERENCES GrupoClase(id),
    CONSTRAINT fk_alumno_responsable FOREIGN KEY (id_proveedor_responsable) REFERENCES Proveedor(id)
);

-- ==========================================
-- 4. LOGÍSTICA Y EVENTOS
-- ==========================================

CREATE TABLE Parrilla (
    id INT AUTO_INCREMENT PRIMARY KEY,
    reservada BOOLEAN DEFAULT FALSE,
    id_grupo INT,
    CONSTRAINT fk_parrilla_grupo FOREIGN KEY (id_grupo) REFERENCES GrupoClase(id)
);

CREATE TABLE Actividad (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    hora_inicio TIME,
    hora_fin TIME,
    descripcion TEXT,
    lugar VARCHAR(100),
    id_grupo INT,
    CONSTRAINT fk_actividad_grupo FOREIGN KEY (id_grupo) REFERENCES GrupoClase(id)
);

CREATE TABLE Pago (
    id INT AUTO_INCREMENT PRIMARY KEY,
    importe DECIMAL(10, 2) NOT NULL,
    id_alumno INT,
    id_tipo_pago INT,
    CONSTRAINT fk_pago_alumno FOREIGN KEY (id_alumno) REFERENCES Alumno(id),
    CONSTRAINT fk_pago_tipo FOREIGN KEY (id_tipo_pago) REFERENCES TipoPago(id)
);

-- ==========================================
-- 5. SUMINISTROS Y MENÚS
-- ==========================================

CREATE TABLE Suministro (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    precio DECIMAL(10, 2),
    cantidad INT,
    id_unidad INT,
    id_proveedor INT, -- Relación directa con proveedor
    id_pack INT,      -- O relación a través de un pack
    CONSTRAINT fk_sum_unidad FOREIGN KEY (id_unidad) REFERENCES Unidad(id),
    CONSTRAINT fk_sum_prov FOREIGN KEY (id_proveedor) REFERENCES Proveedor(id),
    CONSTRAINT fk_sum_pack FOREIGN KEY (id_pack) REFERENCES Pack(id)
);

-- Especializaciones de Suministro
CREATE TABLE Carne (
    id_suministro INT PRIMARY KEY,
    halal BOOLEAN DEFAULT FALSE,
    CONSTRAINT fk_carne_sum FOREIGN KEY (id_suministro) REFERENCES Suministro(id)
);

CREATE TABLE Bebida (
    id_suministro INT PRIMARY KEY,
    CONSTRAINT fk_bebida_sum FOREIGN KEY (id_suministro) REFERENCES Suministro(id)
);

CREATE TABLE Vegetales (
    id_suministro INT PRIMARY KEY,
    CONSTRAINT fk_vegetales_sum FOREIGN KEY (id_suministro) REFERENCES Suministro(id)
);

-- Menú final
CREATE TABLE Menu (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    precio DECIMAL(10, 2),
    halal BOOLEAN DEFAULT FALSE,
    vegano BOOLEAN DEFAULT FALSE
);

-- Relación muchos a muchos entre Menú y Suministros
CREATE TABLE Menu_Suministro (
    id_menu INT,
    id_suministro INT,
    PRIMARY KEY (id_menu, id_suministro),
    CONSTRAINT fk_ms_menu FOREIGN KEY (id_menu) REFERENCES Menu(id),
    CONSTRAINT fk_ms_sum FOREIGN KEY (id_suministro) REFERENCES Suministro(id)
);