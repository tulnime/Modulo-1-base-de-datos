CREATE DATABASE AndesLtda;
USE AndesLtda;

-- Tabla Clientes
CREATE TABLE Clientes (
    Rut VARCHAR(15) PRIMARY KEY,
    Nombre VARCHAR(55) NOT NULL,
    Apellido VARCHAR(55) NOT NULL,
    Email VARCHAR(55)  UNIQUE,
    Direccion VARCHAR(255)
);

-- Índice compuesto solicitado
CREATE INDEX IDX_Clientes_NombreApellido
ON Clientes (Nombre, Apellido);

-- Tabla Categoría
CREATE TABLE Categoria (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    Titulo VARCHAR(55) NOT NULL
);

-- Tabla Producto
CREATE TABLE Producto (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(55) ,
    Id_Categoria INT not null,
    FOREIGN KEY (Id_Categoria)
        REFERENCES Categoria(Id)
);

-- Tabla Ventas
CREATE TABLE Ventas (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    Rut_C VARCHAR(15) NOT NULL,
    Id_Articulo INT NOT NULL,
    Fecha DATE,
    Monto DECIMAL(10,2) NOT NULL CHECK (Monto > 0),

    FOREIGN KEY (Rut_C)
        REFERENCES Clientes(Rut),

    FOREIGN KEY (Id_Articulo)
        REFERENCES Producto(Id)
);

-- Datos Clientes
INSERT INTO Clientes
VALUES
('26.060.219-k','Angel','Alizo','Angelalizo@alizo.com','La Florida 1123, Santiago'),
('19.050.129-4','Estevan','Guerra','EstevanGuerra@Estevan.com','Machali 0123, Santiago'),
('16.012.129-1','Mar','Guerra','MarGuerra@correo.com','Machali 0123, Santiago'),
('16.020.219-2','Camila','Nieves','Cami@Nieves.com','La Florida 742, Santiago');

-- Datos Categorías
INSERT INTO Categoria (Titulo)
VALUES
('Ropa'),
('Hogar'),
('Electronica');

-- Datos Productos
INSERT INTO Producto (Nombre, Id_Categoria)
VALUES
('Pantalon',1),
('Cama',2),
('Telefono',3);

-- Datos Ventas
INSERT INTO Ventas (Rut_C, Id_Articulo, Fecha, Monto)
VALUES
('26.060.219-k',1,'2025-01-01',99.99),
('19.050.129-4',1,'2025-03-31',991.99),
('26.060.219-k',2,'2025-02-14',99.99),
('16.020.219-2',3,'2025-02-14',500.99),
('16.020.219-2',3,'2025-01-14',24000.00);



SELECT *
FROM Ventas
WHERE Fecha BETWEEN '2025-01-01' AND '2025-03-31';


SELECT *
FROM Clientes
WHERE Nombre LIKE 'Mar%';




SELECT
    p.Nombre AS Producto,
    c.Titulo AS Categoria,
    v.Fecha,
    v.Monto
FROM Ventas v
INNER JOIN Producto p
    ON v.Id_Articulo = p.Id
INNER JOIN Categoria c
    ON p.Id_Categoria = c.Id
WHERE c.Titulo IN ('Electronica', 'Hogar', 'Ropa');