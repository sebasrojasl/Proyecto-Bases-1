--Se crea la tabla genero con sus atributos y pk respectiva.
Create table Genero(
    id_Genero number(10),
    Nombre varchar2(15) constraint genero_nombre_nn not null,    
    constraint pk_genero primary key (id_genero)
      using index
      tablespace ge_ind pctfree 20
      storage (initial 10K NEXT 10K pctincrease 0),
    --A partir de aquí es auditoría
    fec_creacion DATE constraint genero_fec_creacion_nn not null,
	usuario_creacion VARCHAR2(10) constraint genero_usuario_creacion_nn not null, 
	fec_ultima_modificacion DATE,
	usuario_ultima_modificacion VARCHAR2(10)
);

--Se crea secuencia para el id de genero
CREATE SEQUENCE s_genero
  MINVALUE 0
  MAXVALUE 100000000
  START WITH 1
  INCREMENT BY 1
  NOCACHE
  NOCYCLE;