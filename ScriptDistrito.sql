--Se crea la tabla Distrito con sus atributos, fk y pk respectivos.
Create table Distrito(
    id_Distrito number(10),
    id_Canton number(10),
    Nombre varchar2(40) constraint Distrito_nombre_nn not null,    
    constraint pk_Distrito primary key (id_Distrito)
      using index
      tablespace ge_ind pctfree 20
      storage (initial 10K NEXT 10K pctincrease 0),
    --A partir de aquí es auditoría
    fec_creacion DATE constraint Distrito_fec_creacion_nn not null,
	usuario_creacion VARCHAR2(10) constraint Distrito_usuario_creacion_nn not null, 
	fec_ultima_modificacion DATE,
	usuario_ultima_modificacion VARCHAR2(10)
);

--Se le agrega la fk de id_Canton a Distrito
ALTER TABLE Distrito
    ADD CONSTRAINT fk_Distrito_1 foreign key (id_Canton)
    REFERENCES Canton(id_Canton);
    
--Se crea secuencia para el id de Canton
CREATE SEQUENCE s_Distrito
  MINVALUE 0
  MAXVALUE 100000000
  START WITH 1
  INCREMENT BY 1
  NOCACHE
  NOCYCLE;