CREATE TABLE OFICINA(
COD_OFICINA NUMBER(3) NOT NULL,
DIRECCION VARCHAR(30) NOT NULL,
TELEFONO NUMBER(9) NOT NULL,
DNI_DIR VARCHAR(9) NOT NULL,
DNI_COM VARCHAR(9) NOT NULL,
CONSTRAINT PK_OFICINA PRIMARY KEY(OFICINA),
CONSTRAINT FK_DIRECTOR FOREIGN KEY (DNI_DIR) REFERENCES DIRECTOR(DNI) ON DELETE CASCADE,
CONSTRAINT CK_TEL CHECK(LENGTH(TELEFONO)=9)
);

CREATE TABLE COMERCIAL(
DNI_COMERCIAL VARCHAR(9) NOT NULL,
COMISION NUMBER(3) NOT NULL,
COD_OFICINA NUMBER(3) NOT NULL,
CONSTRAINT PK_COMERCIAL PRIMARY KEY (DNI_COMERCIAL),
CONSTRAINT FK_DNI_COMERCIAL FOREIGN KEY (DNI_COMERCIAL) REFERENCES DATOSPERSONALES(DNI) ON DELETE CASCADE,
CONSTRAINT CK_COMISION CHECK(COMISION > 0 AND COMISION <100)
);

ALTER TABLE OFICINA ADD CONSTRAINT FK_DNI_COM FOREIGN KEY (DNI_COM) REFERENCES COMERCIAL(DNI_COMERCIAL) ON DELETE CASCADE;
ALTER TABLE COMERCIAL ADD CONSTRAINT FK_COD_OFICINA FOREIGN KEY (COD_OFICINA) REFERENCES OFICINA(COD_OFICINA) ON DELETE CASCADE;

CREATE TABLE VENDEDOR(
DNI_VENDEDOR VARCHAR(9) NOT NULL,
TURNO VARCHAR(10) NOT NULL,
COD_OFICINA NUMBER(2) NOT NULL,
CONSTRAINT PK_VENDEDOR PRIMARY KEY(DNI_VENDEDOR),
CONSTRAINT FK_DNI_VENDEDOR FOREIGN KEY (DNI_VENDEDOR) REFERENCES DATOSPERSONALES(DNI) ON DELETE CASCADE,
CONSTRAINT FK_COD_OFICINA FOREIGN KEY (COD_OFICINA) REFERENCES OFICINA(COD_OFICINA) ON DELETE CASCADE,
CONSTRAINT CK_TURNO CHECK ((TURNO) IN('MAÑANA','TARDE','NOCHE'))
);

