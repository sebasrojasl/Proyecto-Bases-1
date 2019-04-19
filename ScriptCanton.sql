--Se crea la tabla Canton con sus atributos, fk y pk respectivos.
Create table Canton(
    id_Canton number(10),
    id_Provincia number(10),    
    Nombre varchar2(40) constraint Canton_nombre_nn not null,    
    constraint pk_Canton primary key (id_Canton)
      using index
      tablespace ge_ind pctfree 20
      storage (initial 10K NEXT 10K pctincrease 0),
    --A partir de aquí es auditoría
    fec_creacion DATE constraint Canton_fec_creacion_nn not null,
	usuario_creacion VARCHAR2(10) constraint Canton_usuario_creacion_nn not null, 
	fec_ultima_modificacion DATE,
	usuario_ultima_modificacion VARCHAR2(10)
);

--Se le agrega la fk de id_Provincia a Canton
ALTER TABLE Canton
    ADD CONSTRAINT fk_Canton_1 foreign key (id_Provincia)
    REFERENCES Provincia(id_Provincia);
    
--Se crea secuencia para el id de Canton
CREATE SEQUENCE s_Canton
  MINVALUE 0
  MAXVALUE 100000000
  START WITH 1
  INCREMENT BY 1
  NOCACHE
  NOCYCLE;