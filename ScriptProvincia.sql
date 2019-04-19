--Se crea la tabla Provincia con sus atributos, fk y pk respectivos.
Create table Provincia(
    id_Provincia number(10),
    id_Pais number(10),
    Nombre varchar2(40) constraint Provincia_nombre_nn not null,    
    constraint pk_Provincia primary key (id_Provincia)
      using index
      tablespace ge_ind pctfree 20
      storage (initial 10K NEXT 10K pctincrease 0),
    --A partir de aquí es auditoría
    fec_creacion DATE constraint Provincia_fec_creacion_nn not null,
	usuario_creacion VARCHAR2(10) constraint Provincia_usuario_creacion_nn not null, 
	fec_ultima_modificacion DATE,
	usuario_ultima_modificacion VARCHAR2(10)
);

--Se le agrega la fk de id_Pais a Provincia
ALTER TABLE Provincia
    ADD CONSTRAINT fk_provincia_1 foreign key (id_Pais)
    REFERENCES Pais(id_Pais);
    
--Se crea secuencia para el id de Provincia
CREATE SEQUENCE s_Provincia
  MINVALUE 0
  MAXVALUE 100000000
  START WITH 1
  INCREMENT BY 1
  NOCACHE
  NOCYCLE;