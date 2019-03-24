USE FacturasDatabase;

CREATE TABLE FacturasDatabase.UsuarioUpdate (
  ChangeID        INT IDENTITY PRIMARY KEY,
  UpdatedBy       VARCHAR(100) NOT NULL,
  IDUsuario       INT          NOT NULL,
  UsuarioBefore   VARCHAR(20)  NOT NULL,
  UsuarioAfter    VARCHAR(20)  NOT NULL,
  PasswordBefore  VARCHAR(16)  NOT NULL,
  PasswordAfter   VARCHAR(16)  NOT NULL,
  RolBefore       VARCHAR(20)  NOT NULL,
  RolAfter        VARCHAR(20)  NOT NULL,
  IDPersonaBefore INT          NOT NULL,
  IDPersonaAfert  INT          NOT NULL,
  FechaCambio     DATE,
  Cambio          VARCHAR(30),
);

CREATE TABLE FacturasDatabase.UsuarioDelete (
  ChangeID        INT IDENTITY PRIMARY KEY,
  DeletedBy       VARCHAR(200) NOT NULL,
  IDUsuario       INT          NOT NULL,
  UsuarioBefore   VARCHAR(20)  NOT NULL,
  PasswordBefore  VARCHAR(16)  NOT NULL,
  RolBefore       VARCHAR(20)  NOT NULL,
  IDPersonaBefore INT          NOT NULL,
  FechaCambio     DATE,
  Cambio          VARCHAR(30),
);

CREATE TABLE FacturasDatabase.UsuarioInsert (
  ChangeID       INT IDENTITY PRIMARY KEY,
  InsertedBy     VARCHAR(200) NOT NULL,
  IDUsuario      INT          NOT NULL,
  UsuarioAfter   VARCHAR(20)  NOT NULL,
  PasswordAfter  VARCHAR(16)  NOT NULL,
  RolAfter       VARCHAR(20)  NOT NULL,
  IDPersonaAfert INT          NOT NULL,
  FechaCambio    DATE,
  Cambio         VARCHAR(30),
);

CREATE TABLE FacturasDatabase.PersonaUpdate (
  ChangeID     INT IDENTITY PRIMARY KEY,
  UpdatedBy    VARCHAR(200) NOT NULL,
  IDPersona    INT          NOT NULL,
  NombreBefore VARCHAR(100),
  NombreAfter  VARCHAR(100),
  DUIBefore    CHAR(10),
  DUIAfter     CHAR(10),
  FechaCambio  DATE,
  Cambio       VARCHAR(30),
);

CREATE TABLE FacturasDatabase.PersonaDelete (
  ChangeID     INT IDENTITY PRIMARY KEY,
  DeletedBy    VARCHAR(200) NOT NULL,
  IDPersona    INT          NOT NULL,
  NombreBefore VARCHAR(100),
  DUIBefore    CHAR(10),
  FechaCambio  DATE,
  Cambio       VARCHAR(30),
);

CREATE TABLE FacturasDatabase.PersonaInsert (
  ChangeID    INT IDENTITY PRIMARY KEY,
  InsertedBy  VARCHAR(200) NOT NULL,
  IDPersona   INT          NOT NULL,
  NombreAfter VARCHAR(100),
  DUIAfter    CHAR(10),
  FechaCambio DATE,
  Cambio      VARCHAR(30),
);

CREATE TABLE FacturasDatabase.FacturaUpdate (
  ChangeID                 INT IDENTITY PRIMARY KEY,
  UpdatedBy                VARCHAR(200) NOT NULL,
  IDFactura                INT          NOT NULL,
  IDFacturaIngresadaBefore INT          NOT NULL,
  IDFacturaIngresadaAfter  INT          NOT NULL,
  IDUsuarioBefore          INT          NOT NULL,
  IDUsuarioAfter           INT          NOT NULL,
  IDClienteBefore          INT          NOT NULL,
  IDClienteAfter           INT          NOT NULL,
  IDTipoFacturaBefore      INT          NOT NULL,
  IDTipoFacturaAfter       INT          NOT NULL,
  FechaBefore              DATE         NOT NULL,
  FechaAfert               DATE         NOT NULL,
  IDProductoBefore         INT          NOT NULL,
  IDProductoAfter          INT          NOT NULL,
  CantidadBefore           DECIMAL      NOT NULL,
  CantidadAfter            DECIMAL      NOT NULL,
  FechaCambio              DATE,
  Cambio                   VARCHAR(30),
);

CREATE TABLE FacturasDatabase.FacturaInsert (
  ChangeID                INT IDENTITY PRIMARY KEY,
  InsertedBy              VARCHAR(200) NOT NULL,
  IDFactura               INT          NOT NULL,
  IDFacturaIngresadaAfter INT          NOT NULL,
  IDUsuarioAfter          INT          NOT NULL,
  IDClienteAfter          INT          NOT NULL,
  IDTipoFacturaAfter      INT          NOT NULL,
  FechaAfter              DATE         NOT NULL,
  IDProductoAfter         INT          NOT NULL,
  CantidadAfter           DECIMAL      NOT NULL,
  FechaCambio             DATE,
  Cambio       VARCHAR(30),
);

CREATE TABLE FacturasDatabase.FacturaDelete (
  ChangeID                 INT IDENTITY PRIMARY KEY,
  DeletedBy                VARCHAR(200) NOT NULL,
  IDFactura                INT          NOT NULL,
  IDFacturaIngresadaBefore INT          NOT NULL,
  IDUsuarioBefore          INT          NOT NULL,
  IDClienteBefore          INT          NOT NULL,
  IDTipoFacturaBefore      INT          NOT NULL,
  FechaBefore              DATE         NOT NULL,
  IDProductoBefore         INT          NOT NULL,
  CantidadBefore           DECIMAL      NOT NULL,
  FechaCambio              DATE,
  Cambio                   VARCHAR(30),
);

CREATE TABLE FacturasDatabase.TipoFacturaUpdate (
  ChangeID             INT IDENTITY PRIMARY KEY,
  UpdatedBy            VARCHAR(200) NOT NULL,
  IDTIPO               INT          NOT NULL,
  FACTURACREDITOBEFORE VARCHAR(100) NOT NULL,
  FACTURACREDITOAFTER  VARCHAR(100) NOT NULL,
  IDDetalleBefore      INT          NOT NULL,
  IDDetalleAfter       INT          NOT NULL,
  FechaCambio          DATE,
  Cambio               VARCHAR(30),
);

CREATE TABLE FacturasDatabase.TipoFacturaInsert (
  ChangeID            INT IDENTITY PRIMARY KEY,
  InsertedBy          VARCHAR(200) NOT NULL,
  IDTIPO              INT          NOT NULL,
  FACTURACREDITOAFTER VARCHAR(100) NOT NULL,
  IDDetalleAfter      INT          NOT NULL,
  FechaCambio         DATE,
  Cambio              VARCHAR(30),
);

CREATE TABLE FacturasDatabase.TipoFacturaDelete (
  ChangeID             INT IDENTITY PRIMARY KEY,
  DeletedBy            VARCHAR(100) NOT NULL,
  IDTIPO               INT          NOT NULL,
  FACTURACREDITOBEFORE VARCHAR(100) NOT NULL,
  IDDetalleBefore      INT          NOT NULL,
  FechaCambio          DATE,
  Cambio               VARCHAR(30),
);

CREATE TABLE FacturasDatabase.DETALLEUpdate (
  ChangeID             INT IDENTITY PRIMARY KEY,
  UpdatedBy            VARCHAR(200)        NOT NULL,
  IDFacturaCredito     INT                 NOT NULL,
  ClienteBefore        VARCHAR(100)        NOT NULL,
  ClienteAfter         VARCHAR(100)        NOT NULL,
  DIRECCIONBefore      VARCHAR(100)        NOT NULL,
  DIRECCIONAfter       VARCHAR(100)        NOT NULL,
  FECHABefore          DATE                NOT NULL,
  FECHAAfter           DATE                NOT NULL,
  VentaACuentadeBefore VARCHAR(100)        NOT NULL,
  VentaACuentadeAfeter VARCHAR(100)        NOT NULL,
  NITODUIBefore        CHAR(10) UNIQUE     NOT NULL,
  NITODUIAfter         CHAR(10) UNIQUE     NOT NULL,
  IDMUNSVBefore        INT                 NOT NULL,
  IDMUNSVAfter         INT                 NOT NULL,
  FechaCambio          DATE,
  Cambio               VARCHAR(30),
);

CREATE TABLE FacturasDatabase.DETALLEInsert (
  ChangeID             INT IDENTITY PRIMARY KEY,
  InsertedBy           VARCHAR(200)        NOT NULL,
  IDFacturaCredito     INT                 NOT NULL,
  ClienteAfter         VARCHAR(100)        NOT NULL,
  DIRECCIONAfter       VARCHAR(100)        NOT NULL,
  FECHAAfter           DATE                NOT NULL,
  VentaACuentadeAfeter VARCHAR(100)        NOT NULL,
  NITODUIAfter         CHAR(10) UNIQUE     NOT NULL,
  IDMUNSVAfter         INT                 NOT NULL,
  FechaCambio          DATE,
  Cambio               VARCHAR(30),
);

CREATE TABLE FacturasDatabase.DETALLEDelete (
  ChangeID             INT IDENTITY PRIMARY KEY,
  DeletedBy            VARCHAR(200)        NOT NULL,
  IDFacturaCredito     INT                 NOT NULL,
  ClienteBefore        VARCHAR(100)        NOT NULL,
  DIRECCIONBefore      VARCHAR(100)        NOT NULL,
  FECHABefore          DATE                NOT NULL,
  VentaACuentadeBefore VARCHAR(100)        NOT NULL,
  NITODUIBefore        CHAR(10) UNIQUE     NOT NULL,
  IDMUNSVBefore        INT                 NOT NULL,
  FechaCambio          DATE,
  Cambio               VARCHAR(30),
);

CREATE TABLE FacturasDatabase.ProductoUpdate (
  ChangeID       INT IDENTITY PRIMARY KEY,
  UpdatedBy      VARCHAR(200) NOT NULL,
  IDProducto     INT          NOT NULL,
  ProductoBefore VARCHAR(100),
  ProductoAfter  VARCHAR(100),
  PrecioBefore   DECIMAL,
  PrecioAfter    DECIMAL,
  FechaCambio    DATE,
  Cambio         VARCHAR(30),
);

CREATE TABLE FacturasDatabase.ProductoInsert (
  ChangeID      INT IDENTITY PRIMARY KEY,
  InsertedBy    VARCHAR(200) NOT NULL,
  IDProducto    INT          NOT NULL,
  ProductoAfter VARCHAR(100),
  PrecioAfter   DECIMAL,
  FechaCambio   DATE,
  Cambio        VARCHAR(30),
);

CREATE TABLE FacturasDatabase.ProductoDelete (
  ChangeID       INT IDENTITY PRIMARY KEY,
  DeletedBy      VARCHAR(200) NOT NULL,
  IDProducto     INT          NOT NULL,
  ProductoBefore VARCHAR(100),
  PrecioBefore   DECIMAL,
  FechaCambio    DATE,
  Cambio         VARCHAR(30),
);

CREATE TABLE FacturasDatabase.ClienteUpdate (
  ChangeID            INT IDENTITY PRIMARY KEY,
  UpdatedBy           VARCHAR(200) NOT NULL,
  IDCliente           INT,
  NombreClienteBefore VARCHAR(100),
  NombreClienteAfter  VARCHAR(100),
  FechaCambio         DATE,
  Cambio              VARCHAR(30),
);

CREATE TABLE FacturasDatabase.ClienteDelete (
  ChangeID            INT IDENTITY PRIMARY KEY,
  DeletedBy           VARCHAR(200) NOT NULL,
  IDCliente           INT,
  NombreClienteBefore VARCHAR(100),
  FechaCambio         DATE,
  Cambio              VARCHAR(30),
);

CREATE TABLE FacturasDatabase.ClienteInsert (
  ChangeID           INT IDENTITY PRIMARY KEY,
  InsertedBy         VARCHAR(200) NOT NULL,
  IDCliente          INT,
  NombreClienteAfter VARCHAR(100),
  FechaCambio        DATE,
  Cambio             VARCHAR(30),
);