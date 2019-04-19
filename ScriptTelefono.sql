--Se crea la tabla telefono con sus atributos y pk y fk respectivos.
Create table telefono(
    id_telefono number(10),
    Numero varchar2(20) constraint telefono_numero_nn not null,
    id_persona number(10),
    constraint pk_telefono primary key (id_telefono)
      using index
      tablespace ge_ind pctfree 20
      storage (initial 10K NEXT 10K pctincrease 0),
    --A partir de aquí es auditoría
    fec_creacion DATE constraint telef_fec_creacion_nn not null, 
	usuario_creacion VARCHAR2(10) constraint telef_usuario_creacion_nn not null, 
	fec_ultima_modificacion DATE, 
	usuario_ultima_modificacion VARCHAR2(10)
);

--Se agrega la fk de telefono
ALTER TABLE telefono
    ADD CONSTRAINT fk_telefono foreign key (id_persona)
    REFERENCES persona(id_persona);
    
--Se crea secuencia para el id de telefono
CREATE SEQUENCE s_telefono
  MINVALUE 0
  MAXVALUE 100000000
  START WITH 1
  INCREMENT BY 1
  NOCACHE
  NOCYCLE;