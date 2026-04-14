Drop database if exists GestionProveedores;
CREATE DATABASE IF NOT EXISTS GestionProveedores;
USE GestionProveedores;

-- 1. Tabla Tipo (Carne, Bebida, etc.)
CREATE TABLE Tipo (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL
);

-- 2. Tabla Proveedor
CREATE TABLE Proveedor (
    id INT AUTO_INCREMENT PRIMARY KEY,
    url_web VARCHAR(255),
    nombre VARCHAR(100) NOT NULL
);

-- 3. Tabla Suministro
CREATE TABLE Suministro (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    precio DECIMAL(10, 2),
    cantidad INT,
    proveedor_id INT,
    tipo_id INT,
    CONSTRAINT fk_suministro_proveedor 
        FOREIGN KEY (proveedor_id) REFERENCES Proveedor(id),
    CONSTRAINT fk_suministro_tipo 
        FOREIGN KEY (tipo_id) REFERENCES Tipo(id)
);


insert into tipo (id,nombre)
VALUES
(1,"Vacuno"),
(2,"Pollo"),
(3,"Cerdo"),
(4,"Cerdo_halal"),
(5,"Embutido"),
(6,"Vegetales"),
(7,"vacuno y cerdo");

create table Proveedor (id, url_web, nombre)
VALUES
(1,"https://www.bonarea-online.com/ca/shop/find?searchWords=butifarra","bonarea"),
(2,"https://tienda.mercadona.es/","Mercadona");

insert into Suministro (id,nombre,precio,cantidad,proveedor_id,tipo_id)

(1,"Botifarra fresca de porc",5.54,1,1,5),
(2,"Chuletas aguja de cerdo",3.92,1,2,3),
(3,"Burger de vacuno y cerdo",4.20,1,2,7),
(4,"Cebollas",2.40,1,2,6);