--Se crea la tabla Pais con sus atributos y pk respectivos.
Create table Pais(
    id_Pais number(10),
    Nombre varchar2(40) constraint Pais_nombre_nn not null,    
    constraint pk_Pais primary key (id_Pais)
      using index
      tablespace ge_ind pctfree 20
      storage (initial 10K NEXT 10K pctincrease 0),
    --A partir de aquí es auditoría
    fec_creacion DATE constraint Pais_fec_creacion_nn not null,
	usuario_creacion VARCHAR2(10) constraint Pais_usuario_creacion_nn not null, 
	fec_ultima_modificacion DATE,
	usuario_ultima_modificacion VARCHAR2(10)
);

--Se crea secuencia para el id de Pais
CREATE SEQUENCE s_Pais
  MINVALUE 0
  MAXVALUE 100000000
  START WITH 1
  INCREMENT BY 1
  NOCACHE
  NOCYCLE;