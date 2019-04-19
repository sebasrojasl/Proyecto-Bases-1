--Se crea la tabla delito con sus atributo, pk y fk respectivas.
Create table Delito(
    id_Delito number(10),
    afectado number(10),
    Tipo_Arma varchar2(15),    
    id_Nota number(10),
    id_Tipo_Delito number(10),
    id_Clasif number(10),
    constraint pk_delito primary key (id_delito)
      using index
      tablespace ge_ind pctfree 20
      storage (initial 10K NEXT 10K pctincrease 0),
    --A partir de aquí es auditoría
    fec_creacion DATE constraint delito_fec_creacion_nn not null,
	usuario_creacion VARCHAR2(10) constraint delito_usuario_creacion_nn not null, 
	fec_ultima_modificacion DATE,
	usuario_ultima_modificacion VARCHAR2(10)
);

--Se le agrega la fk de id_usuario a delito
ALTER TABLE delito
    ADD CONSTRAINT fk_delito_1 foreign key (afectado)
    REFERENCES usuario(id_usuario);

--Se le agrega la fk de id_Nota a delito
ALTER TABLE delito
    ADD CONSTRAINT fk_delito_2 foreign key (id_Nota)
    REFERENCES Nota(id_Nota);
  
--Se le agrega la fk de id_Tipo a delito
ALTER TABLE delito
    ADD CONSTRAINT fk_delito_3 foreign key (id_Tipo_Delito)
    REFERENCES Tipo_Delito(id_Tipo_Delito);
    
--Se le agrega la fk de id_Clasif a delito
ALTER TABLE delito
    ADD CONSTRAINT fk_delito_4 foreign key (id_Clasif)
    REFERENCES Clasificacion_delito(id_Clasif_delito);

--Se crea secuencia para el id de delito
CREATE SEQUENCE s_delito
  MINVALUE 0
  MAXVALUE 100000000
  START WITH 1
  INCREMENT BY 1
  NOCACHE
  NOCYCLE;