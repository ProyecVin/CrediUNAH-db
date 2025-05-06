
CREATE PROCEDURE linkage.spCrearUsuario
    @nombre NVARCHAR(100),
    @apellido NVARCHAR(100),
    @correo NVARCHAR(150),
    @telefono NVARCHAR(20),
    @rol_id INT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        INSERT INTO linkage.usuario (nombre, apellido, correo, telefono)
        VALUES (@nombre, @apellido, @correo, @telefono);

        DECLARE @usuario_id INT = SCOPE_IDENTITY();

        INSERT INTO linkage.usuarioRol (usuario_id, rol_id)
        VALUES (@usuario_id, @rol_id);

        COMMIT;
    END TRY
    BEGIN CATCH
        ROLLBACK;
        THROW;
    END CATCH
END;



CREATE PROCEDURE linkage.spObtenerUsuarioPorCorreo
    @correo NVARCHAR(150)
AS
BEGIN
    SELECT u.id, u.nombre, u.apellido, u.correo, u.telefono, u.fecha_registro, u.activo,
           r.id AS rol_id, r.nombre AS rol_nombre
    FROM linkage.usuario u
    JOIN linkage.usuarioRol ur ON u.id = ur.usuario_id
    JOIN linkage.rol r ON ur.rol_id = r.id
    WHERE u.correo = @correo;
END;


