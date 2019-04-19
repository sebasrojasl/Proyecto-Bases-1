--Se crea la tabla Nota con sus atributos y pk respectiva.
Create table Nota(
    id_nota number(10),
    Descripcion varchar2(300),    
    constraint pk_nota primary key (id_nota)
      using index
      tablespace ge_ind pctfree 20
      storage (initial 10K NEXT 10K pctincrease 0),
    --A partir de aquí es auditoría
    fec_creacion DATE constraint nota_fec_creacion_nn not null,
	usuario_creacion VARCHAR2(10) constraint nota_usuario_creacion_nn not null, 
	fec_ultima_modificacion DATE,
	usuario_ultima_modificacion VARCHAR2(10)
);

--Se crea secuencia para el id de nota
CREATE SEQUENCE s_nota
  MINVALUE 0
  MAXVALUE 100000000
  START WITH 1
  INCREMENT BY 1
  NOCACHE
  NOCYCLE;