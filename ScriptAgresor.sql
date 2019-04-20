--Se crea la tabla Agresor con sus atributos, pk y fk respectivas.
Create table Agresor(
    id_Agresor number(10),
    id_Genero number(10),
    id_nota number(10),
    Nombre varchar2(40) constraint agresor_nombre_nn not null,    
    constraint pk_agresor primary key (id_agresor)
      using index
      tablespace ge_ind pctfree 20
      storage (initial 10K NEXT 10K pctincrease 0),
    --A partir de aquí es auditoría
    fec_creacion DATE constraint agresor_fec_creacion_nn not null,
	usuario_creacion VARCHAR2(10) constraint agresor_usuario_creacion_nn not null, 
	fec_ultima_modificacion DATE,
	usuario_ultima_modificacion VARCHAR2(10)
);

--Se le agrega la fk de id_Genero a agresor
ALTER TABLE agresor
    ADD CONSTRAINT fk_agresor_1 foreign key (id_Genero)
    REFERENCES genero(id_Genero);
    
--Se le agrega la fk de id_Nota a agresor
ALTER TABLE agresor
    ADD CONSTRAINT fk_agresor_2 foreign key (id_nota)
    REFERENCES nota(id_nota);
    
--Se crea secuencia para el id de agresor
CREATE SEQUENCE s_agresor
  MINVALUE 0
  MAXVALUE 100000000
  START WITH 1
  INCREMENT BY 1
  NOCACHE
  NOCYCLE;
