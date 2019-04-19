--Se crea la tabla clasificacion_noticia con sus atributos y pk respectiva.
Create table Clasificacion_noticia(
    id_clasif_noticia number(10),
    Nombre varchar2(15) constraint clasif_noti_nombre_nn not null,    
    constraint pk_clasif_noticia primary key (id_clasif_noticia)
      using index
      tablespace ge_ind pctfree 20
      storage (initial 10K NEXT 10K pctincrease 0),
    --A partir de aquí es auditoría
    fec_creacion DATE constraint clas_noti_fec_creacion_nn not null,
	usuario_creacion VARCHAR2(10) constraint clas_noti_usuario_creacion_nn not null, 
	fec_ultima_modificacion DATE,
	usuario_ultima_modificacion VARCHAR2(10)
);
  
--Se crea secuencia para el id de clasificacion noticia
CREATE SEQUENCE s_clasif_noticia
  MINVALUE 0
  MAXVALUE 100000000
  START WITH 1
  INCREMENT BY 1
  NOCACHE
  NOCYCLE;