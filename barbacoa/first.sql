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

-- Compañeros

-- 3. INSERTS DE TIPOS
INSERT INTO Tipo (id, nombre) VALUES 
(1,'Vacuno'), (2,'Pollo'), (3,'Cerdo'), (4,'Cordero'), (5,'Embutido'), 
(6,'Vegetales'), (7,'Bebida'), (8,'Salsa'), (9,'Lácteo'), (10,'Especias'), (11,'Otros');

-- 4. INSERTS DE PROVEEDORES (Unificados de todos los mensajes)
INSERT INTO Proveedor (id, nombre, url_web) VALUES
(1, 'Bonarea', 'https://www.bonarea-online.com'),
(2, 'Mercadona', 'https://www.mercadona.es'),
(3, 'MÓN DE LA CARN', 'https://micharcuteria.com'),
(4, 'Qualittat', 'https://qualittat.com'),
(5, 'Cecarn', 'https://cecarn.com'),
(6, 'Bebidas Barcelona', 'https://bebidasbarcelona.com'),
(7, 'Espucarn', 'https://www.espucarn.com'),
(8, 'Carnicería J. Roca', 'https://www.carniceriajroca.com'),
(9, 'Cervezas Artesanas Barcelona', 'https://www.cervezasartesanasbcn.com'),
(10, 'Frutas y Verduras La Boqueria', 'https://www.laboqueria.barcelona'),
(11, 'Campofrío', 'https://www.campofrio.es'),
(12, 'Carrefour', 'https://www.carrefour.es'),
(13, 'El Corte Inglés', 'https://www.elcorteingles.es'),
(14, 'Cárnicas El Corte Selecto', 'https://www.elcorteselecto.com'),
(15, 'Premium Meat Co.', 'https://premiummeat.com'),
(16, 'Supermercados Origen', 'https://superorigen.com');

-- 5. TODOS LOS INSERTS DE SUMINISTROS (SIN EXCEPCIÓN)

-- Bloque Ronald, Víctor y Sorin
INSERT INTO Suministro (nombre, precio, cantidad, proveedor_id, tipo_id) VALUES
('Chorizo', 12.50, 20, 3, 5), ('Brocoli', 3.20, 15, 2, 6), ('Refresco', 1.80, 50, 3, 7),
('chorizo victor', 11.00, 1, 8, 5), ('panceta victor', 3.80, 1, 8, 3), ('hamburguesa victor', 10.50, 1, 8, 1),
('chistorra sorin', 10.50, 1, 8, 5), ('panceta sorin', 3.15, 1, 8, 3), ('hamburguesa tern sorin', 11.17, 1, 8, 1), ('pack de barbacoa clasica', 50.95, 3, 8, 11);

-- Bloque Asier (Detallado)
INSERT INTO Suministro (nombre, precio, cantidad, proveedor_id, tipo_id) VALUES
('Entrecot bajo de ternera ecológica', 24.90, 12, 4, 1), ('Entrecot alto de Angus Argentina', 28.50, 10, 4, 1),
('Entrecot Angus bajo Argentina', 26.90, 14, 4, 1), ('Ternera ecológica entrecot alto 30 días', 22.50, 11, 4, 1),
('Ternera ecológica entrecot bajo 30 días', 21.50, 13, 4, 1), ('Chuletón de vaca vieja madurado', 34.90, 8, 4, 1),
('Solomillo premium de ternera', 29.00, 9, 4, 1), ('Hamburguesa ecológica Vedella', 9.80, 20, 4, 1),
('Cortes argentinos de carne', 18.90, 16, 4, 1), ('Burguers eco de proximidad', 8.90, 24, 4, 11),
('Aceitunas verdes Qualittat', 5.50, 30, 4, 6), ('Pan artesano para barbacoa', 3.20, 35, 4, 11),
('Entrecot de ternera bonarea', 19.50, 18, 1, 1), ('Chuletas de cerdo bonarea', 12.00, 22, 1, 3),
('Pollo entero bonarea', 10.20, 25, 1, 2), ('Jamón serrano bonarea', 15.00, 14, 1, 5),
('Chorizo fresco bonarea', 7.80, 28, 1, 5), ('Lomo de cerdo bonarea', 13.20, 16, 1, 3),
('Costillas de cerdo bonarea', 11.90, 20, 1, 3), ('Alitas de pollo bonarea', 9.10, 24, 1, 2),
('Hamburguesa ternera 100% bonarea', 8.40, 30, 1, 1), ('Presa ibérica bonarea', 17.50, 12, 1, 3),
('Patatas fritas bonarea', 3.00, 40, 1, 6), ('Salsa barbacoa bonarea', 2.10, 45, 1, 8),
('Agua mineral natural 1.5L', 1.10, 120, 6, 7), ('Refresco cola 2L', 2.20, 90, 6, 7),
('Zumo naranja natural 1L', 2.60, 55, 6, 7), ('Tónica premium 1L', 2.30, 50, 6, 7), ('Cerveza sin alcohol 33cl', 2.60, 34, 6, 7);

-- Bloque Gerard (Espucarn)
INSERT INTO Suministro (nombre, precio, cantidad, proveedor_id, tipo_id) VALUES
('Panceta adobada de Cerdo DUROC', 9.10, 10, 7, 3), ('Lacon canario sin hueso', 7.10, 25, 7, 3),
('Flamenquines de Cerdo', 2.89, 10, 7, 3), ('Morro de cerdo bandeja', 3.10, 10, 7, 3);

-- Bloque Nahuel (BonArea y Mercadona completo)
INSERT INTO Suministro (nombre, precio, cantidad, proveedor_id, tipo_id) VALUES
('Churrasco de añojo', 6.25, 418, 1, 1), ('Chuletón de ternera Angus', 14.89, 649, 1, 1),
('Tira de añojo', 45.29, 3400, 1, 1), ('Lagarto de lomo de cerdo', 4.46, 638, 1, 3),
('Panceta de cerdo fileteada', 4.19, 616, 1, 3), ('Alas de pollo amarillo', 4.43, 1000, 1, 2),
('Alas partidas de pollo blanco', 2.72, 539, 1, 2), ('Contramuslos de pollo amarillo', 2.46, 594, 1, 2),
('Alas de pollo amarillas partidas', 2.89, 572, 1, 2), ('Pollo amarillo 65% cereales', 8.01, 2200, 1, 2),
('Lomo bajo de añojo', 29.40, 1400, 1, 1), ('Patata malla', 4.20, 3000, 1, 6),
('Alcachofa', 2.06, 748, 1, 6), ('Combinado de pimientos', 4.00, 825, 1, 6),
('Cebolla tierna', 2.45, 400, 1, 6), ('Patata malla grande', 5.50, 5000, 1, 6),
('Tomate maduro', 4.82, 1200, 1, 6), ('Tomate pera', 2.91, 583, 1, 6),
('Limón malla', 1.49, 500, 1, 6), ('Arroz largo Arrullo', 6.76, 5000, 1, 11),
('Entrecot vacuno añojo fino', 12.85, 500, 2, 1), ('Entrecot vacuno añojo grueso', 9.77, 380, 2, 1),
('Filetes vacuno añojo', 10.01, 550, 2, 1), ('Filetes vacuno marinado', 8.85, 500, 2, 1),
('Churrasco de ternera', 6.24, 390, 2, 1), ('Costilla de cerdo churrasco', 5.13, 900, 2, 3),
('Chuletas lomo de cerdo', 3.11, 450, 2, 3), ('Solomillo de cerdo', 4.84, 620, 2, 3),
('Burger vacuno y cerdo', 4.20, 540, 2, 7), ('Burger vacuno', 6.20, 540, 2, 1),
('Burger cerdo', 2.70, 540, 2, 3), ('Alas de pollo', 4.07, 980, 2, 2),
('Butifarra fresca', 3.46, 640, 2, 5), ('Longaniza de pollo', 4.13, 550, 2, 5),
('Longaniza magro fresca', 3.21, 535, 2, 5), ('Longaniza sin tripa', 3.30, 560, 2, 5),
('Queso tierno de vaca', 6.50, 1050, 2, 9), ('Queso lonchas fundido', 1.25, 200, 2, 9),
('Lechugas corazón romana', 1.75, 20, 2, 6), ('Mayonesa Hellmanns', 2.95, 450, 2, 8),
('Ketchup', 1.15, 600, 2, 8), ('Mostaza clásica', 1.35, 388, 2, 8);

-- Bloque Aleix y Max (Estructura Similar)
INSERT INTO Suministro (nombre, precio, cantidad, proveedor_id, tipo_id) VALUES
('Butifarra catalana barbacoa', 8.90, 30, 8, 5), ('Costillas de cerdo ibérico', 14.50, 20, 8, 3),
('Entrecot de ternera ecológica', 24.90, 15, 8, 1), ('Chuletón de vaca vieja', 34.90, 10, 8, 1),
('Pechuga de pollo marinada', 9.20, 25, 8, 2), ('Chorizo criollo para barbacoa', 12.50, 18, 8, 5),
('Morcilla de Burgos', 7.80, 22, 8, 5), ('Solomillo de cerdo ibérico', 18.90, 12, 8, 3),
('Longaniza de payés artesana', 9.25, 35, 14, 5), ('Secreto ibérico de bellota', 16.80, 18, 14, 3),
('Vacío de ternera nacional', 22.40, 12, 14, 1), ('Tomahawk de vaca madurada', 38.50, 8, 14, 1),
('Alitas picantes adobadas', 8.75, 30, 14, 2), ('Chorizo parrillero argentino', 11.90, 20, 14, 5),
('Morcilla de cebolla', 6.50, 25, 14, 5), ('Presa de cerdo Duroc', 19.10, 10, 14, 3),
('Picanha de Black Angus', 31.20, 10, 15, 1), ('Chuletón de buey gallego', 42.00, 6, 15, 1),
('Hamburguesa de Wagyu', 14.50, 25, 15, 1), ('Pluma ibérica premium', 21.30, 12, 15, 3),
('Cerveza Lager artesanal', 2.50, 100, 9, 7), ('Cerveza Stout negra', 3.80, 60, 9, 7),
('Espárragos trigueros', 4.80, 30, 10, 6), ('Tomates de colgar', 3.95, 40, 10, 6),
('Salsa Chimichurri casera', 3.20, 35, 10, 8), ('Salsa Romesco artesana', 3.50, 30, 10, 8);

-- Bloque Raul y Elian
INSERT INTO Suministro (nombre, precio, cantidad, proveedor_id, tipo_id) VALUES
('Lomo de Res Bon Àrea', 52.99, 150, 1, 1), ('Entrecot Bon Àrea', 48.50, 80, 1, 1),
('Jamón Serrano Campofrío', 34.99, 60, 11, 5), ('Carne Picada Campofrío', 18.75, 200, 11, 1),
('Pechuga de Pollo Fresca Carrefour', 12.99, 300, 12, 2), ('Sal de Guérande El Corte Inglés', 5.99, 500, 13, 10),
('Salsa BBQ American Style', 15.75, 200, 12, 8), ('Chuletón de Ternera Elian', 24.90, 10, 14, 1),
('Lomo de Cerdo Elian', 8.75, 25, 14, 3), ('Costillas de Cordero Elian', 18.20, 15, 14, 4);