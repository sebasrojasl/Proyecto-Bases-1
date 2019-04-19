--Se crea la tabla Clasificacion_Delito con sus atributos, pk respectivos.
Create table Clasificacion_Delito(
    id_Clasif_Delito number(10),
    Nombre varchar2(40) constraint Clasif_Del_nombre_nn not null,    
    constraint pk_Clasif_Delito primary key (id_Clasif_Delito)
      using index
      tablespace ge_ind pctfree 20
      storage (initial 10K NEXT 10K pctincrease 0),
    --A partir de aquí es auditoría
    fec_creacion DATE constraint Clasif_Del_fec_creacion_nn not null,
	usuario_creacion VARCHAR2(10) constraint Clasif_Del_usuario_creacion_nn not null, 
	fec_ultima_modificacion DATE,
	usuario_ultima_modificacion VARCHAR2(10)
);

--Se crea secuencia para el id de Clasificacion_Delito
CREATE SEQUENCE s_Clasif_Delito
  MINVALUE 0
  MAXVALUE 100000000
  START WITH 1
  INCREMENT BY 1
  NOCACHE
  NOCYCLE;