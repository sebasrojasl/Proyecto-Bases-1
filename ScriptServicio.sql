--Se crea la tabla Servicio con sus atributos y pk respectiva.
Create table Servicio(
    id_Servicio number(10),
    Nombre varchar2(15) constraint servicio_nombre_nn not null,    
    constraint pk_servicio primary key (id_servicio)
      using index
      tablespace ge_ind pctfree 20
      storage (initial 10K NEXT 10K pctincrease 0),
    --A partir de aquí es auditoría
    fec_creacion DATE constraint servicio_fec_creacion_nn not null,
	usuario_creacion VARCHAR2(10) constraint servicio_usuario_creacion_nn not null, 
	fec_ultima_modificacion DATE,
	usuario_ultima_modificacion VARCHAR2(10)
);
  
--Se crea secuencia para el id de servicio
CREATE SEQUENCE s_servicio
  MINVALUE 0
  MAXVALUE 100000000
  START WITH 1
  INCREMENT BY 1
  NOCACHE
  NOCYCLE;