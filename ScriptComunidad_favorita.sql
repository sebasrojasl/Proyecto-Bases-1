--Se crea la tabla comunidad_favorita con su pk y fk respectivas.
Create table Comunidad_favorita(
    id_comunidad number(10),
    id_usuario number(10),
    constraint pk_comu_fav primary key (id_usuario, id_comunidad)
      using index
      tablespace ge_ind pctfree 20
      storage (initial 10K NEXT 10K pctincrease 0),
    --A partir de aquí es auditoría
    fec_creacion DATE constraint comu_fav_fec_creacion_nn not null,
	usuario_creacion VARCHAR2(10) constraint comu_fav_usuario_creacion_nn not null, 
	fec_ultima_modificacion DATE,
	usuario_ultima_modificacion VARCHAR2(10)
);

--Se le agrega la fk de id_usuario a comunidad_favorita
ALTER TABLE comunidad_favorita
    ADD CONSTRAINT fk_comu_fav_1 foreign key (id_usuario)
    REFERENCES usuario(id_usuario);

--Se le agrega la fk de id_comunidad a comunidad_favorita
ALTER TABLE comunidad_favorita
    ADD CONSTRAINT fk_comu_fav_2 foreign key (id_comunidad)
    REFERENCES comunidad(id_comunidad);