--Se crea la tabla Corte_Servicio con sus pk y fk respectivas.
Create table Corte_Servicio(
    id_Corte_Serv number(10),
    id_Tipo_Corte_Serv number(10),
    id_Usuario number(10),
    Descripcion varchar2(300),
    constraint pk_Corte_Serv primary key (id_Corte_Serv)
      using index
      tablespace ge_ind pctfree 20
      storage (initial 10K NEXT 10K pctincrease 0),
    --A partir de aquí es auditoría
    fec_creacion DATE constraint Corte_Serv_fec_creacion_nn not null,
	usuario_creacion VARCHAR2(10) constraint Corte_Serv_usuario_creacion_nn not null, 
	fec_ultima_modificacion DATE,
	usuario_ultima_modificacion VARCHAR2(10)
);


CREATE SEQUENCE  S_Corte_Servicio
MINVALUE 1 
MAXVALUE 1000000 
INCREMENT BY 1 
START WITH 1 
NOCACHE
NOCYCLE;

--Se le agrega la fk de id_Tipo_Corte_Serv a Corte_Servicio
ALTER TABLE Corte_Servicio
    ADD CONSTRAINT fk_Corte_Serv_1 foreign key (id_Tipo_Corte_Serv)
    REFERENCES Tipo_Corte_Servicio(id_Tipo_Corte_Serv);

--Se le agrega la fk de id_Usuario Corte_Servicio
ALTER TABLE Corte_Servicio
    ADD CONSTRAINT fk_Corte_Serv_2 foreign key (id_Usuario)
    REFERENCES Usuario(id_Usuario);
