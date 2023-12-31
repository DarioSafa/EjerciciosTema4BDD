CREATE TABLE PROFESOR(
DNI VARCHAR(9) NOT NULL,
NOMBRE VARCHAR(30) NOT NULL,
APELLIDO1 VARCHAR(30) NOT NULL,
APELLIDO2 VARCHAR(30) NULL,
DIRECCION VARCHAR(50) NOT NULL,
CUENTA VARCHAR(20) NOT NULL,
TELEFONO NUMBER(9) NOT NULL,
CONSTRAINT PK_PROFESOR PRIMARY KEY (DNI)
);

CREATE TABLE CICLOFORM(
CODCICLO VARCHAR (3) NOT NULL,
NOMBRE VARCHAR (30) NOT NULL,
TIPO VARCHAR (10) NOT NULL,
CONSTRAINT PK_CICLOFORM PRIMARY KEY (CODCICLO)
);

CREATE TABLE ASIGNATURA(
CODASIG VARCHAR (3) NOT NULL,
NOMBRE VARCHAR (30) NOT NULL,
NUMHORAS NUMBER(3) NOT NULL,
DNI_PROFESOR VARCHAR (9) NOT NULL,
CODCICLO_CICLOFORM VARCHAR (3) NOT NULL,
CONSTRAINT PK_ASIGNATURA PRIMARY KEY (CODASIG),
CONSTRAINT FK_ASIGNATURA_DNI FOREIGN KEY (DNI_PROFESOR) REFERENCES PROFESOR(DNI),
CONSTRAINT FK_ASIGNATURA_CODCICLO FOREIGN KEY (CODCICLO_CICLOFORM) REFERENCES CICLOFORM(CODCICLO)
);

CREATE TABLE IDIOMA(
CODIDIOMA VARCHAR(2) NOT NULL,
DESCRIPCION VARCHAR(100) NOT NULL,
CONSTRAINT PK_IDIOMA PRIMARY KEY (CODIDIOMA)
);

CREATE TABLE ALUMNO(
DNI VARCHAR(9) NOT NULL,
NOMBRE VARCHAR(30) NOT NULL,
APELLIDO1 VARCHAR(30) NOT NULL,
APELLIDO2 VARCHAR(30) NULL,
DIRECCION VARCHAR(50) NOT NULL,
EMAIL VARCHAR (40) NOT NULL,
TELEFONO NUMBER(9) NOT NULL,
CODIDIOMA_IDIOMA VARCHAR(2) NULL,
CONSTRAINT PK_ALUMNO PRIMARY KEY (DNI),
CONSTRAINT FK_ALUMNO_CODIDIOMA FOREIGN KEY (CODIDIOMA_IDIOMA) REFERENCES IDIOMA(CODIDIOMA)
);

CREATE TABLE MATRICULA(
DNI_ALUMNO VARCHAR(9) NOT NULL,
CODASIG_ASIGNATURA VARCHAR(3) NOT NULL,
CONSTRAINT PK_MATRICULA PRIMARY KEY (DNI_ALUMNO,CODASIG_ASIGNATURA),
CONSTRAINT FK_MATRICULA_DNI FOREIGN KEY (DNI_ALUMNO) REFERENCES ALUMNO(DNI),
CONSTRAINT FK_MATRICULA_CODASIG FOREIGN KEY (CODASIG_ASIGNATURA) REFERENCES ASIGNATURA(CODASIG)
);

CREATE TABLE IDIOMASPROF(
CODIDIOMA_IDIOMA VARCHAR(2) NOT NULL,
DNI_PROFESOR VARCHAR(9) NOT NULL,
CONSTRAINT PK_IDIOMASPROF PRIMARY KEY (DNI_PROFESOR,CODIDIOMA_IDIOMA),
CONSTRAINT FK_IDIOMASPROF_DNI FOREIGN KEY (DNI_PROFESOR) REFERENCES PROFESOR(DNI),
CONSTRAINT FK_IDIOMASPROF_CODIDIOMA FOREIGN KEY (CODIDIOMA_IDIOMA) REFERENCES IDIOMA(CODIDIOMA)
);

-- Se crea la nueva tabla supertipo
CREATE TABLE DATOSPERSONALES(
DNI VARCHAR(9) NOT NULL,
NOMBRE VARCHAR(30) NOT NULL,
APELLIDO1 VARCHAR(30) NOT NULL,
APELLIDO2 VARCHAR(30) NOT NULL,
DIRECCION VARCHAR(20) NOT NULL,
TELEFONO NUMBER(9) NOT NULL,
CONSTRAINT PK_DATOSPERSONALES PRIMARY KEY (DNI)
);

-- para borrar los datos de profesor que hemos creado en el supertipo
ALTER TABLE PROFESOR DROP (NOMBRE);
ALTER TABLE PROFESOR DROP (APELLIDO1);
ALTER TABLE PROFESOR DROP (APELLIDO2);
ALTER TABLE PROFESOR DROP (DIRECCION);
ALTER TABLE PROFESOR DROP (TELEFONO);

-- para borrar los datos de alumno que hemos creado en el supertipo
ALTER TABLE ALUMNO DROP (NOMBRE);
ALTER TABLE ALUMNO DROP (APELLIDO1);
ALTER TABLE ALUMNO DROP (APELLIDO2);
ALTER TABLE ALUMNO DROP (DIRECCION);
ALTER TABLE ALUMNO DROP (TELEFONO);

--Ahora vamos a crear las constraints para referenciar profesor y alumno a su supertipo
ALTER TABLE PROFESOR ADD CONSTRAINT FK_DNI_PROFESOR FOREIGN KEY(DNI) REFERENCES DATOSPERSONALES(DNI) ON DELETE CASCADE;
ALTER TABLE ALUMNO ADD CONSTRAINT FK_DNI_ALUMNO FOREIGN KEY(DNI) REFERENCES DATOSPERSONALES(DNI) ON DELETE CASCADE;

--Creamos el atributo discriminante tipo
ALTER TABLE DATOSPERSONALES ADD TIPO VARCHAR(8);
ALTER TABLE DATOSPERSONALES ADD CONSTRAINT CK_TIPO CHECK(TIPO IN ('profesor','alumno'));