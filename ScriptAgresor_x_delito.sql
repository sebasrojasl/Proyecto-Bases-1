--Se crea la tabla Agresor_X_Delito con sus pk y fk respectivas.
Create table Agresor_X_Delito(
    id_Agresor number(10),
    id_Delito number(10),
    constraint pk_agresor_X_delito primary key (id_Agresor, id_Delito)
      using index
      tablespace ge_ind pctfree 20
      storage (initial 10K NEXT 10K pctincrease 0),
    --A partir de aquí es auditoría
    fec_creacion DATE constraint agre_x_del_fec_creacion_nn not null,
	usuario_creacion VARCHAR2(10) constraint agre_x_del_usuario_creacion_nn not null, 
	fec_ultima_modificacion DATE,
	usuario_ultima_modificacion VARCHAR2(10)
);

--Se le agrega la fk de id_Agresor a agresor_x_delito
ALTER TABLE Agresor_X_Delito
    ADD CONSTRAINT fk_agresor_X_delito_1 foreign key (id_Agresor)
    REFERENCES Agresor(id_Agresor);

--Se le agrega la fk de id_Delito agresor_x_delito
ALTER TABLE Agresor_X_Delito
    ADD CONSTRAINT fk_agresor_X_delito_2 foreign key (id_Delito)
    REFERENCES Delito(id_Delito);