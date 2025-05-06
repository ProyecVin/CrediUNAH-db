-- Crear el esquema
CREATE SCHEMA linkage;
GO

-- Tabla: rol
CREATE TABLE linkage.rol (
    id INT PRIMARY KEY IDENTITY(1,1),
    nombre NVARCHAR(100) NOT NULL
);

-- Tabla: usuario
CREATE TABLE linkage.usuario (
    id INT PRIMARY KEY IDENTITY(1,1),
    nombre NVARCHAR(100) NOT NULL,
    apellido NVARCHAR(100) NOT NULL,
    correo NVARCHAR(150) NOT NULL UNIQUE,
    telefono NVARCHAR(20),
    fecha_registro DATETIME NOT NULL DEFAULT GETDATE(),
    activo BIT NOT NULL DEFAULT 1
);

-- Tabla: usuarioRol
CREATE TABLE linkage.usuarioRol (
    usuario_id INT NOT NULL,
    rol_id INT NOT NULL,
    PRIMARY KEY (usuario_id, rol_id),
    FOREIGN KEY (usuario_id) REFERENCES linkage.usuario(id),
    FOREIGN KEY (rol_id) REFERENCES linkage.rol(id)
);
