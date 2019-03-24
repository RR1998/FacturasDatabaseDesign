USE FacturasDatabase;

CREATE FUNCTION GetUser()
  RETURNS VARCHAR(200)
  LANGUAGE SQL
BEGIN
  DECLARE @SystemUser VARCHAR(100);
  DECLARE @LocalUser VARCHAR(100);
  SET @SystemUser = (SELECT SYSTEM_USER);
  SET @LocalUser = (SELECT USER);
  SET @Usuario = (SELECT CONCAT(@SystemUser, ' ', @LocalUser));
  RETURN @Usuario;
END

CREATE TRIGGER FacturasDatabase.UpdatedUserTrigger
  ON FacturasDatabase.USUARIO
  AFTER UPDATE AS
  BEGIN
    DECLARE @Changedby VARCHAR(200);
    DECLARE @ID INT;
    DECLARE @UserBefore VARCHAR(20);
    DECLARE @UserAfter VARCHAR(20);
    DECLARE @PasswordBefore VARCHAR(16);
    DECLARE @PasswordAfter VARCHAR(16);
    DECLARE @RolBefore VARCHAR(20);
    DECLARE @RolAfter VARCHAR(20);
    DECLARE @PersonaBefore INT;
    DECLARE @PersonaAfter INT;
    DECLARE @FechaCambio DATE;
    DECLARE @Cambio VARCHAR(30)
    SET @FechaCambio = (SELECT GETDATE());
    SET @Changedby = GetUser();
    SET @Cambio = 'Se ha actualizado un registro';
    DECLARE @Before TABLE(
      IDUsuario INT UNIQUE          NOT NULL,
      Usuario   VARCHAR(20) UNIQUE  NOT NULL,
      Password  VARCHAR(16)         NOT NULL,
      Rol       VARCHAR(20)         NOT NULL,
      IDPersona INT                 NOT NULL,
    );
    DECLARE @After TABLE(
      IDUsuario INT UNIQUE          NOT NULL,
      Usuario   VARCHAR(20) UNIQUE  NOT NULL,
      Password  VARCHAR(16)         NOT NULL,
      Rol       VARCHAR(20)         NOT NULL,
      IDPersona INT                 NOT NULL,
    );
    INSERT INTO @Before SELECT *
                        FROM deleted;
    INSERT INTO @After SELECT *
                       FROM inserted;
    SELECT
      @ID = IDUsuario,
      @UserBefore = Usuario,
      @PasswordBefore = Password,
      @RolBefore = Rol,
      @PersonaBefore = IDPersona
    FROM @Before;
    SELECT
      @UserAfter = Usuario,
      @PasswordAfter = Password,
      @RolAfter = Rol,
      @PersonaAfter = IDPersona
    FROM @After;
    INSERT INTO FacturasDatabase.UsuarioUpdate (UpdatedBy, IDUsuario, UsuarioBefore, UsuarioAfter, PasswordBefore, PasswordAfter, RolBefore, RolAfter, IDPersonaBefore, IDPersonaAfert, FechaCambio, Cambio)
    VALUES
      (@Changedby, @ID, @UserBefore, @UserAfter, @PasswordBefore, @PasswordAfter, @RolBefore, @RolAfter, @PersonaBefore,
                   @PersonaAfter, @FechaCambio, @Cambio);
  END

CREATE TRIGGER FacturasDatabase.DeleteUserTrigger
  ON FacturasDatabase.USUARIO
  AFTER DELETE AS
  BEGIN
    DECLARE @Changedby VARCHAR(200);
    DECLARE @ID INT;
    DECLARE @UserBefore VARCHAR(20);
    DECLARE @PasswordBefore VARCHAR(16);
    DECLARE @RolBefore VARCHAR(20);
    DECLARE @PersonaBefore INT;
    DECLARE @FechaCambio DATE;
    DECLARE @Cambio VARCHAR(30)
    SET @FechaCambio = (SELECT GETDATE());
    SET @Changedby = GetUser();
    SET @Cambio = 'Se ha eliminado un registro';
    DECLARE @Before TABLE(
      IDUsuario INT UNIQUE          NOT NULL,
      Usuario   VARCHAR(20) UNIQUE  NOT NULL,
      Password  VARCHAR(16)         NOT NULL,
      Rol       VARCHAR(20)         NOT NULL,
      IDPersona INT                 NOT NULL,
    );
    INSERT INTO @Before SELECT *
                        FROM deleted;
    SELECT
      @ID = IDUsuario,
      @UserBefore = Usuario,
      @PasswordBefore = Password,
      @RolBefore = Rol,
      @PersonaBefore = IDPersona
    FROM @Before;
    INSERT INTO FacturasDatabase.UsuarioDelete (DeletedBy, IDUsuario, UsuarioBefore, PasswordBefore, RolBefore, IDPersonaBefore, FechaCambio, Cambio)
    VALUES (@Changedby, @ID, @UserBefore, @PasswordBefore, @RolBefore, @PersonaBefore, @FechaCambio, @Cambio);
  END

CREATE TRIGGER FacturasDatabase.InsertUserTrigger
  ON FacturasDatabase.USUARIO
  AFTER INSERT AS
  BEGIN
    DECLARE @Changedby VARCHAR(200);
    DECLARE @ID INT;
    DECLARE @UserAfter VARCHAR(20);
    DECLARE @PasswordAfter VARCHAR(16);
    DECLARE @RolAfter VARCHAR(20);
    DECLARE @PersonaAfter INT;
    DECLARE @FechaCambio DATE;
    DECLARE @Cambio VARCHAR(30)
    SET @FechaCambio = (SELECT GETDATE());
    SET @Changedby = GetUser();
    SET @Cambio = 'Se ha insertado un registro';
    DECLARE @After TABLE(
      IDUsuario INT UNIQUE          NOT NULL,
      Usuario   VARCHAR(20) UNIQUE  NOT NULL,
      Password  VARCHAR(16)         NOT NULL,
      Rol       VARCHAR(20)         NOT NULL,
      IDPersona INT                 NOT NULL,
    );
    INSERT INTO @After SELECT *
                       FROM inserted;
    SELECT
      @ID = IDUsuario,
      @UserAfter = Usuario,
      @PasswordAfter = Password,
      @RolAfter = Rol,
      @PersonaAfter = IDPersona
    FROM @After;
    INSERT INTO FacturasDatabase.UsuarioInsert (InsertedBy, IDUsuario, UsuarioAfter, PasswordAfter, RolAfter, IDPersonaAfert, FechaCambio, Cambio)
    VALUES (@ID, @Changedby, @UserAfter, @PasswordAfter, @RolAfter, @PersonaAfter, @FechaCambio, @Cambio);
  END

CREATE TRIGGER FacturasDatabase.UpdatedPerson
  ON FacturasDatabase.PERSONA
  AFTER UPDATE AS
  BEGIN
    DECLARE @ChangedBy VARCHAR(200);
    DECLARE @ID INT;
    DECLARE @NombreBefore VARCHAR(100);
    DECLARE @NombreAfter VARCHAR(100);
    DECLARE @DUIBefore CHAR(10);
    DECLARE @DUIAfter CHAR(10);
    DECLARE @FechaCambio DATE;
    DECLARE @Cambio VARCHAR(30);
    SET @FechaCambio = (SELECT GETDATE());
    SET @Changedby = GetUser();
    SET @Cambio = 'Se ha actualizado un registro';
    DECLARE @Before TABLE(
      IDPersona INT UNIQUE          NOT NULL,
      Nombre    VARCHAR(100),
      DUI       CHAR(10) UNIQUE     NOT NULL,
    );
    DECLARE @After TABLE(
      IDPersona INT UNIQUE          NOT NULL,
      Nombre    VARCHAR(100),
      DUI       CHAR(10) UNIQUE     NOT NULL,
    );
    INSERT INTO @Before SELECT *
                        FROM deleted;
    INSERT INTO @After SELECT *
                       FROM inserted;
    SELECT
      @ID = IDPersona,
      @NombreBefore = Nombre,
      @DUIBefore = DUI
    FROM @Before
    SELECT
      @ID = IDPersona,
      @NombreAfter = Nombre,
      @DUIAfter = DUI
    FROM @After
    INSERT INTO FacturasDatabase.PersonaUpdate (UpdatedBy, IDPersona, NombreBefore, NombreAfter, DUIBefore, DUIAfter, FechaCambio, Cambio)
    VALUES (@ChangedBy, @ID, @NombreBefore, @NombreAfter, @DUIBefore, @DUIAfter, @FechaCambio, @Cambio)
  END

CREATE TRIGGER FacturasDatabase.InsertPersonTrigger
  ON FacturasDatabase.PERSONA
  AFTER INSERT AS
  BEGIN
    DECLARE @ChangedBy VARCHAR(200);
    DECLARE @ID INT;
    DECLARE @NombreAfter VARCHAR(100);
    DECLARE @DUIAfter CHAR(10);
    DECLARE @FechaCambio DATE;
    DECLARE @Cambio VARCHAR(30);
    SET @FechaCambio = (SELECT GETDATE());
    SET @Changedby = GetUser();
    SET @Cambio = 'Se ha insertado un registro';
    DECLARE @After TABLE(
      IDPersona INT UNIQUE          NOT NULL,
      Nombre    VARCHAR(100),
      DUI       CHAR(10) UNIQUE     NOT NULL,
    );
    INSERT INTO @After SELECT *
                       FROM inserted;
    SELECT
      @ID = IDPersona,
      @NombreAfter = Nombre,
      @DUIAfter = DUI
    FROM @After
    INSERT INTO FacturasDatabase.PersonaInsert (UpdatedBy, IDPersona, NombreAfter, DUIAfter, FechaCambio, Cambio)
    VALUES (@ChangedBy, @ID, @NombreAfter, @DUIAfter, @FechaCambio, @Cambio)
  END

CREATE TRIGGER FacturasDatabase.DeletePersonTrigger
  ON FacturasDatabase.PERSONA
  AFTER DELETE AS
  BEGIN
    DECLARE @ChangedBy VARCHAR(200);
    DECLARE @ID INT;
    DECLARE @NombreBefore VARCHAR(100);
    DECLARE @DUIBefore CHAR(10);
    DECLARE @FechaCambio DATE;
    DECLARE @Cambio VARCHAR(30);
    SET @FechaCambio = (SELECT GETDATE());
    SET @Changedby = GetUser();
    SET @Cambio = 'Se ha eliminado un registro';
    DECLARE @Before TABLE(
      IDPersona INT UNIQUE          NOT NULL,
      Nombre    VARCHAR(100),
      DUI       CHAR(10) UNIQUE     NOT NULL,
    );
    INSERT INTO @Before SELECT *
                        FROM deleted;
    SELECT
      @ID = IDPersona,
      @NombreBefore = Nombre,
      @DUIBefore = DUI
    FROM @Before
    INSERT INTO FacturasDatabase.PersonaDelete (UpdatedBy, IDPersona, NombreBefore, DUIBefore, FechaCambio, Cambio)
    VALUES (@ChangedBy, @ID, @NombreBefore, @DUIBefore, @FechaCambio, @Cambio)
  END

CREATE TRIGGER FacturasDatabase.UpdatedFacturasTrigger
  ON FacturasDatabase.FACTURA
  AFTER UPDATE AS
  BEGIN
    DECLARE @ChangedBy VARCHAR(200);
    DECLARE @ID INT;
    DECLARE @IDFacturaIngresadaBefore INT;
    DECLARE @IDFacturaIngresadaAfter INT;
    DECLARE @IDUsuarioBefore INT;
    DECLARE @IDUsuarioAfter INT;
    DECLARE @IDClienteBefore INT;
    DECLARE @IDClienteAfter INT;
    DECLARE @IDTipoFacturaBefore INT;
    DECLARE @IDTipoFacturaAfter INT;
    DECLARE @FechaBefore DATE;
    DECLARE @FechaAfert DATE;
    DECLARE @IDProductoBefore INT;
    DECLARE @IDProductoAfter INT;
    DECLARE @CantidadBefore DECIMAL;
    DECLARE @CantidadAfter DECIMAL;
    DECLARE @FechaCambio DATE;
    DECLARE @Cambio VARCHAR(30);
    SET @FechaCambio = (SELECT GETDATE());
    SET @Changedby = GetUser();
    SET @Cambio = 'Se ha actualizado un registro';
    DECLARE @Before TABLE(
      IDFactura          INT IDENTITY UNIQUE NOT NULL,
      IDFacturaIngresada INT UNIQUE          NOT NULL,
      IDUsuario          INT                 NOT NULL,
      IDCliente          INT                 NOT NULL,
      IDTipoFactura      INT                 NOT NULL,
      Fecha              DATE,
      IDProducto         INT                 NOT NULL,
      Cantidad           DECIMAL             NOT NULL,
    );
    DECLARE @After TABLE(
      IDFactura          INT IDENTITY UNIQUE NOT NULL,
      IDFacturaIngresada INT UNIQUE          NOT NULL,
      IDUsuario          INT                 NOT NULL,
      IDCliente          INT                 NOT NULL,
      IDTipoFactura      INT                 NOT NULL,
      Fecha              DATE,
      IDProducto         INT                 NOT NULL,
      Cantidad           DECIMAL             NOT NULL,
    );
    INSERT INTO @Before SELECT *
                        FROM deleted;
    INSERT INTO @After SELECT *
                       FROM inserted;
    SELECT
      @ID = IDFactura,
      @IDFacturaIngresadaBefore = IDFacturaIngresada,
      @IDUsuarioBefore = IDUsuario,
      @IDClienteBefore = IDCliente,
      @IDTipoFacturaBefore = IDTipoFactura,
      @FechaBefore = Fecha,
      @IDProductoBefore = IDProducto,
      @CantidadBefore = Cantidad
    FROM @Before
    SELECT
      @ID = IDFactura,
      @IDFacturaIngresadaAfter = IDFacturaIngresada,
      @IDUsuarioAfter = IDUsuario,
      @IDClienteAfter = IDCliente,
      @IDTipoFacturaAfter = IDTipoFactura,
      @FechaAfert = Fecha,
      @IDProductoAfter = IDProducto,
      @CantidadAfter = Cantidad
    FROM @After
    INSERT INTO FacturasDatabase.FacturaUpdate (UpdatedBy, IDFactura, IDFacturaIngresadaBefore, IDFacturaIngresadaAfter, IDUsuarioBefore, IDUsuarioAfter, IDClienteBefore,
                                                IDClienteAfter, IDTipoFacturaBefore, IDTipoFacturaAfter, FechaBefore, FechaAfert, IDProductoBefore, IDProductoAfter, CantidadBefore,
                                                CantidadAfter, FechaCambio, Cambio)
    VALUES (@ChangedBy, @ID, @IDFacturaIngresadaBefore, @IDFacturaIngresadaAfter, @IDUsuarioBefore, @IDUsuarioAfter,
                        @IDClienteBefore, @IDClienteAfter, @IDTipoFacturaBefore,
                        @IDTipoFacturaAfter, @FechaBefore, @FechaAfert, @IDProductoBefore, @IDProductoAfter,
            @CantidadBefore, @CantidadAfter, @FechaCambio, @Cambio);
  END

CREATE TRIGGER FacturasDatabase.InsertFacturaTrigger
  ON FacturasDatabase.FACTURA
  AFTER INSERT AS
  BEGIN
    DECLARE @ChangedBy VARCHAR(200);
    DECLARE @ID INT;
    DECLARE @IDFacturaIngresadaAfter INT;
    DECLARE @IDUsuarioAfter INT;
    DECLARE @IDClienteAfter INT;
    DECLARE @IDTipoFacturaAfter INT;
    DECLARE @FechaAfert DATE;
    DECLARE @IDProductoAfter INT;
    DECLARE @CantidadAfter DECIMAL;
    DECLARE @FechaCambio DATE;
    DECLARE @Cambio VARCHAR(30);
    SET @FechaCambio = (SELECT GETDATE());
    SET @Changedby = GetUser();
    SET @Cambio = 'Se ha insertado un registro';
    DECLARE @After TABLE(
      IDFactura          INT IDENTITY UNIQUE NOT NULL,
      IDFacturaIngresada INT UNIQUE          NOT NULL,
      IDUsuario          INT                 NOT NULL,
      IDCliente          INT                 NOT NULL,
      IDTipoFactura      INT                 NOT NULL,
      Fecha              DATE,
      IDProducto         INT                 NOT NULL,
      Cantidad           DECIMAL             NOT NULL,
    );
    INSERT INTO @After SELECT *
                       FROM inserted;
    SELECT
      @ID = IDFactura,
      @IDFacturaIngresadaAfter = IDFacturaIngresada,
      @IDUsuarioAfter = IDUsuario,
      @IDClienteAfter = IDCliente,
      @IDTipoFacturaAfter = IDTipoFactura,
      @FechaAfert = Fecha,
      @IDProductoAfter = IDProducto,
      @CantidadAfter = Cantidad
    FROM @After
    INSERT INTO FacturasDatabase.FacturaInsert (InsertedBy, IDFactura, IDFacturaIngresadaAfter, IDUsuarioAfter, IDClienteAfter, IDTipoFacturaAfter, FechaAfter, IDProductoAfter, CantidadAfter, FechaCambio, Cambio)
    VALUES
      (@ChangedBy, @ID, @IDFacturaIngresadaAfter, @IDUsuarioAfter, @IDClienteAfter, @IDTipoFacturaAfter, @FechaAfert,
        @IDProductoAfter, @CantidadAfter, @FechaCambio, @Cambio)
  END

CREATE TRIGGER FacturasDatabase.DeleteFacturaTrigger
  ON FacturasDatabase.FACTURA
  AFTER DELETE AS
  BEGIN
    DECLARE @ChangedBy VARCHAR(200);
    DECLARE @ID INT;
    DECLARE @IDFacturaIngresadaBefore INT;
    DECLARE @IDUsuarioBefore INT;
    DECLARE @IDClienteBefore INT;
    DECLARE @IDTipoFacturaBefore INT;
    DECLARE @FechaBefore DATE;
    DECLARE @IDProductoBefore INT;
    DECLARE @CantidadBefore DECIMAL;
    DECLARE @FechaCambio DATE;
    DECLARE @Cambio VARCHAR(30);
    SET @FechaCambio = (SELECT GETDATE());
    SET @Changedby = GetUser();
    SET @Cambio = 'Se ha delete un registro';
    DECLARE @Before TABLE(
      IDFactura          INT IDENTITY UNIQUE NOT NULL,
      IDFacturaIngresada INT UNIQUE          NOT NULL,
      IDUsuario          INT                 NOT NULL,
      IDCliente          INT                 NOT NULL,
      IDTipoFactura      INT                 NOT NULL,
      Fecha              DATE,
      IDProducto         INT                 NOT NULL,
      Cantidad           DECIMAL             NOT NULL,
    );
    INSERT INTO @Before SELECT *
                        FROM deleted;
    SELECT
      @ID = IDFactura,
      @IDFacturaIngresadaBefore = IDFacturaIngresada,
      @IDUsuarioBefore = IDUsuario,
      @IDClienteBefore = IDCliente,
      @IDTipoFacturaBefore = IDTipoFactura,
      @FechaBefore = Fecha,
      @IDProductoBefore = IDProducto,
      @CantidadBefore = Cantidad
    FROM @Before
    INSERT INTO FacturasDatabase.FacturaDelete (DeletedBy, IDFactura, IDFacturaIngresadaBefore, IDUsuarioBefore, IDClienteBefore, IDTipoFacturaBefore, FechaBefore, IDProductoBefore, CantidadBefore, FechaCambio, Cambio)
    VALUES (@ChangedBy, @ID, @IDFacturaIngresadaBefore, @IDUsuarioBefore, @IDClienteBefore, @IDTipoFacturaBefore,
      @FechaBefore, @IDProductoBefore, @CantidadBefore, @FechaCambio, @Cambio)
  END

CREATE TRIGGER FacturasDatabase.UpdateTipoFacturaTrigger
  ON FacturasDatabase.TipoFactura
  AFTER UPDATE AS
  BEGIN
    DECLARE @ChangedBy VARCHAR(200);
    DECLARE @ID INT;
    DECLARE @FACTURACREDITOBEFORE VARCHAR(100);
    DECLARE @FACTURACREDITOAFTER VARCHAR(100);
    DECLARE @IDDetalleBefore INT;
    DECLARE @IDDetalleAfter INT;
    DECLARE @FechaCambio DATE;
    DECLARE @Cambio VARCHAR(30);
    SET @FechaCambio = (SELECT GETDATE());
    SET @Changedby = GetUser();
    SET @Cambio = 'Se ha actualizado un registro';
    DECLARE @Before TABLE(
      IDTipo         INT          NOT NULL,
      FacturaCredito VARCHAR(100) NOT NULL,
      IDDetalle      INT          NOT NULL,
    );
    DECLARE @After TABLE(
      IDTipo         INT          NOT NULL,
      FacturaCredito VARCHAR(100) NOT NULL,
      IDDetalle      INT          NOT NULL,
    );
    INSERT INTO @Before SELECT *
                        FROM deleted;
    INSERT INTO @After SELECT *
                       FROM inserted;
    SELECT
      @ID = IDTipo,
      @FACTURACREDITOBEFORE = FacturaCredito,
      @IDDetalleBefore = IDDetalle
    FROM @Before
    SELECT
      @ID = IDTIPO,
      @FACTURACREDITOAFTER = FacturaCredito,
      @IDDetalleAfter = IDDetalle
    FROM @After
    INSERT INTO FacturasDatabase.TipoFacturaUpdate (UpdatedBy, IDTIPO, FACTURACREDITOBEFORE, FACTURACREDITOAFTER, IDDetalleBefore, IDDetalleAfter, FechaCambio, Cambio)
    VALUES
      (@ChangedBy, @ID, @FACTURACREDITOBEFORE, @FACTURACREDITOAFTER, @IDDetalleBefore, @IDDetalleAfter, @FechaCambio,
       @Cambio);
  END

CREATE TRIGGER FacturasDatabase.InsertTipoFacturaTrigger
  ON FacturasDatabase.TipoFactura
  AFTER INSERT AS
  BEGIN
    DECLARE @ChangedBy VARCHAR(200);
    DECLARE @ID INT;
    DECLARE @FACTURACREDITOAFTER VARCHAR(100);
    DECLARE @IDDetalleAfter INT;
    DECLARE @FechaCambio DATE;
    DECLARE @Cambio VARCHAR(30);
    SET @FechaCambio = (SELECT GETDATE());
    SET @Changedby = GetUser();
    SET @Cambio = 'Se ha insertado un registro';
    DECLARE @After TABLE(
      IDTipo         INT          NOT NULL,
      FacturaCredito VARCHAR(100) NOT NULL,
      IDDetalle      INT          NOT NULL,
    );
    INSERT INTO @After SELECT *
                       FROM inserted;
    SELECT
      @ID = IDTipo,
      @FACTURACREDITOAFTER = FacturaCredito,
      @IDDetalleAfter = IDDetalle
    FROM @After
    INSERT INTO FacturasDatabase.TipoFacturaInsert (InsertedBy, IDTIPO, FACTURACREDITOAFTER, IDDetalleAfter, FechaCambio, Cambio)
    VALUES (@ChangedBy, @ID, @FACTURACREDITOAFTER, @IDDetalleAfter, @FechaCambio, @Cambio)
  END

CREATE TRIGGER FacturasDatabase.DeleteTipoFacturaTrigger
  ON FacturasDatabase.TipoFactura
  AFTER INSERT AS
  BEGIN
    DECLARE @ChangedBy VARCHAR(200);
    DECLARE @ID INT;
    DECLARE @FACTURACREDITOBEFORE VARCHAR(100);
    DECLARE @IDDetalleBefore INT;
    DECLARE @FechaCambio DATE;
    DECLARE @Cambio VARCHAR(30);
    SET @FechaCambio = (SELECT GETDATE());
    SET @Changedby = GetUser();
    SET @Cambio = 'Se ha eliminado un registro';
    DECLARE @Before TABLE(
      IDTipo         INT          NOT NULL,
      FacturaCredito VARCHAR(100) NOT NULL,
      IDDetalle      INT          NOT NULL,
    );
    INSERT INTO @Before SELECT *
                        FROM deleted;
    SELECT
      @ID = IDTipo,
      @FACTURACREDITOBEFORE = FacturaCredito,
      @IDDetalleBefore = IDDetalle
    FROM @Before
    INSERT INTO FacturasDatabase.TipoFacturaDelete (DeletedBy, IDTIPO, FACTURACREDITOBEFORE, IDDetalleBefore, FechaCambio, Cambio)
    VALUES (@ChangedBy, @ID, @FACTURACREDITOBEFORE, @IDDetalleBefore, @FechaCambio, @Cambio)
  END

CREATE TRIGGER FacturasDatabase.UpdateDetalleTrigger
  ON FacturasDatabase.DETALLE
  AFTER INSERT AS
  BEGIN
    DECLARE @Changedby VARCHAR(200);
    DECLARE @IDFacturaCredito INT;
    DECLARE @ClienteBefore VARCHAR(100);
    DECLARE @ClienteAfter VARCHAR(100);
    DECLARE @DIRECCIONBefore VARCHAR(100);
    DECLARE @DIRECCIONAfter VARCHAR(100);
    DECLARE @FECHABefore DATE;
    DECLARE @FECHAAfter DATE;
    DECLARE @VentaACuentadeBefore VARCHAR(100);
    DECLARE @VentaACuentadeAfeter VARCHAR(100);
    DECLARE @NITODUIBefore CHAR(10);
    DECLARE @NITODUIAfter CHAR(10);
    DECLARE @IDMUNSVBefore INT;
    DECLARE @IDMUNSVAfter INT;
    DECLARE @FechaCambio DATE;
    DECLARE @Cambio VARCHAR(30);
    SET @FechaCambio = (SELECT GETDATE());
    SET @Changedby = GetUser();
    SET @Cambio = 'Se ha actualizado un registro';
    DECLARE @Before TABLE(
      IDFacturaCredito INT IDENTITY UNIQUE NOT NULL,
      Cliente          VARCHAR(100)        NOT NULL,
      DIRECCION        VARCHAR(100)        NOT NULL,
      FECHA            DATE                NOT NULL,
      VentaACuentade   VARCHAR(100)        NOT NULL,
      NITODUI          CHAR(10) UNIQUE     NOT NULL,
      IDMUNSV          INT                 NOT NULL,
    );
    DECLARE @After TABLE(
      IDFacturaCredito INT IDENTITY UNIQUE NOT NULL,
      Cliente          VARCHAR(100)        NOT NULL,
      DIRECCION        VARCHAR(100)        NOT NULL,
      FECHA            DATE                NOT NULL,
      VentaACuentade   VARCHAR(100)        NOT NULL,
      NITODUI          CHAR(10) UNIQUE     NOT NULL,
      IDMUNSV          INT                 NOT NULL,
    );
    INSERT INTO @Before SELECT *
                        FROM deleted;
    INSERT INTO @After SELECT *
                       FROM inserted;
    SELECT
      @IDFacturaCredito = IDFacturaCredito,
      @ClienteBefore = Cliente,
      @DIRECCIONBefore = DIRECCION,
      @FECHABefore = FECHA,
      @VentaACuentadeBefore = VentaACuentade,
      @NITODUIBefore = NITODUI,
      @IDMUNSVBefore = IDMUNSV
    FROM @Before
    SELECT
      @IDFacturaCredito = IDFacturaCredito,
      @ClienteAfter = Cliente,
      @DIRECCIONAfter = DIRECCION,
      @FECHAAfter = FECHA,
      @VentaACuentadeAfeter = VentaACuentade,
      @NITODUIAfter = NITODUI,
      @IDMUNSVAfter = IDMUNSV
    FROM @After
    INSERT INTO FacturasDatabase.DETALLEUpdate (UpdatedBy, IDFacturaCredito, ClienteBefore, ClienteAfter, DIRECCIONBefore, DIRECCIONAfter, FECHABefore, FECHAAfter, VentaACuentadeBefore, VentaACuentadeAfeter, NITODUIBefore, NITODUIAfter, IDMUNSVBefore, IDMUNSVAfter, FechaCambio, Cambio)
    VALUES
      (@Changedby, @IDFacturaCredito, @ClienteBefore, @ClienteAfter, @DIRECCIONBefore, @DIRECCIONAfter, @FECHABefore,
                   @FECHAAfter, @VentaACuentadeBefore, @VentaACuentadeBefore, @NITODUIBefore, @NITODUIAfter,
       @IDMUNSVBefore, @IDMUNSVAfter, @FechaCambio, @Cambio)
  END

CREATE TRIGGER FacturasDatabase.InsertDetalleTrigger ON FacturasDatabase.DETALLE
  AFTER INSERT AS
  BEGIN
    DECLARE @Changedby VARCHAR(200);
    DECLARE @IDFacturaCredito INT;
    DECLARE @ClienteAfter VARCHAR(100);
    DECLARE @DIRECCIONAfter VARCHAR(100);
    DECLARE @FECHAAfter DATE;
    DECLARE @VentaACuentadeAfeter VARCHAR(100);
    DECLARE @NITODUIAfter CHAR(10);
    DECLARE @IDMUNSVAfter INT;
    DECLARE @FechaCambio DATE;
    DECLARE @Cambio VARCHAR(30);
    SET @FechaCambio = (SELECT GETDATE());
    SET @Changedby = GetUser();
    SET @Cambio = 'Se ha insertado un registro';
    DECLARE @After TABLE(
      IDFacturaCredito INT IDENTITY UNIQUE NOT NULL,
      Cliente          VARCHAR(100)        NOT NULL,
      DIRECCION        VARCHAR(100)        NOT NULL,
      FECHA            DATE                NOT NULL,
      VentaACuentade   VARCHAR(100)        NOT NULL,
      NITODUI          CHAR(10) UNIQUE     NOT NULL,
      IDMUNSV          INT                 NOT NULL,
    );
    INSERT INTO @After SELECT *
                   FROM inserted;
    SELECT
      @IDFacturaCredito = IDFacturaCredito,
      @ClienteAfter = Cliente,
      @DIRECCIONAfter = DIRECCION,
      @FECHAAfter = FECHA,
      @VentaACuentadeAfeter = VentaACuentade,
      @NITODUIAfter = NITODUI,
      @IDMUNSVAfter = IDMUNSV
    FROM @After
    INSERT INTO FacturasDatabase.DETALLEInsert(InsertedBy, IDFacturaCredito, ClienteAfter, DIRECCIONAfter, FECHAAfter, VentaACuentadeAfeter, NITODUIAfter, IDMUNSVAfter, FechaCambio, Cambio)
    VALUES(@ChangedBy, @IDFacturaCredito, @ClienteAfter, @DIRECCIONAfter, @FECHAAfter, @VentaACuentadeAfeter, @NITODUIAfter, @IDMUNSVAfter, @FechaCambio, @Cambio)
  END

CREATE TRIGGER FacturasDatabase.DeleteDetalleTrigger ON FacturasDatabase.DETALLE
  AFTER INSERT AS
  BEGIN
    DECLARE @Changedby VARCHAR(200);
    DECLARE @IDFacturaCredito INT;
    DECLARE @ClienteBefore VARCHAR(100);
    DECLARE @DIRECCIONBefore VARCHAR(100);
    DECLARE @FECHABefore DATE;
    DECLARE @VentaACuentadeBefore VARCHAR(100);
    DECLARE @NITODUIBefore CHAR(10);
    DECLARE @IDMUNSVBefore INT;
    DECLARE @FechaCambio DATE;
    DECLARE @Cambio VARCHAR(30);
    SET @FechaCambio = (SELECT GETDATE());
    SET @Changedby = GetUser();
    SET @Cambio = 'Se ha actualizado un registro';
    DECLARE @Before TABLE(
      IDFacturaCredito INT IDENTITY UNIQUE NOT NULL,
      Cliente          VARCHAR(100)        NOT NULL,
      DIRECCION        VARCHAR(100)        NOT NULL,
      FECHA            DATE                NOT NULL,
      VentaACuentade   VARCHAR(100)        NOT NULL,
      NITODUI          CHAR(10) UNIQUE     NOT NULL,
      IDMUNSV          INT                 NOT NULL,
    );
    INSERT INTO @Before SELECT *
                    FROM deleted;
    SELECT
      @IDFacturaCredito = IDFacturaCredito,
      @ClienteBefore = Cliente,
      @DIRECCIONBefore = DIRECCION,
      @FECHABefore = FECHA,
      @VentaACuentadeBefore = VentaACuentade,
      @NITODUIBefore = NITODUI,
      @IDMUNSVBefore = IDMUNSV
    FROM @Before
    INSERT INTO FacturasDatabase.DETALLEDelete(DeletedBy, IDFacturaCredito, ClienteBefore, DIRECCIONBefore, FECHABefore, VentaACuentadeBefore, NITODUIBefore, IDMUNSVBefore, FechaCambio, Cambio)
      VALUES(@Changedby, @IDFacturaCredito, @ClienteBefore, @DIRECCIONBefore, @FECHABefore, @VentaACuentadeBefore, @NITODUIBefore, @IDMUNSVBefore, @FechaCambio, @Cambio)
  END