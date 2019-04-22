create table accidenteTransito
(
    ---Crea la tabla Accidente Transito

    id_accidenteTransito  number(10),
    lesion             varchar2(20) constraint accidenteTransito_lesion_nn not null,
    fecha               date         constraint accidenteTransito_fecha_nn not null,
    vehiculos          varchar2(30) constraint accidente_vehiculos_nn not null,
    id_Clasificacion       number(10)   constraint accidente_clasificacion_nn not null,
    id_Pais               number(10)   constraint accidente_pais_nn not null,
    id_Provincia      number(10)   constraint accidente_provincia_nn not null,
    id_Canton             number(10)   constraint accidente_canton_nn not null,
    id_Distrito          number(10)   constraint accidente_distrito_nn not null,
    id_Comunidad      number(10)   constraint accidente_comunidad_nn not null,

    ---Campos de Auditoria
    Fec_creacion                       DATE CONSTRAINT accidente_Fec_creacion_nn NOT NULL,
    Usuario_creacion                   VARCHAR2(10) CONSTRAINT accidente_Usuario_creacion_nn NOT NULL,
    Fec_ultima_modificacion            DATE,
    Usuario_ultima_modificacion        VARCHAR2(10)
);
CREATE SEQUENCE  S_AccidenteTransito
MINVALUE 1 
MAXVALUE 1000000 
INCREMENT BY 1 
START WITH 1 
NOCACHE
NOCYCLE;
---Crea la secuencia de id_accidenteTransito

alter table accidenteTransito
    add constraint pk_accidenteTransito primary key (id_accidenteTransito)
          using index
          tablespace ge_ind pctfree 20
          storage (initial 10K NEXT 10K pctincrease 0);

---Crea la llave primaria de la tabla accidenteTransito

ALTER TABLE accidenteTransito
    ADD CONSTRAINT fk_clasificacion_accidente FOREIGN KEY (id_Clasificacion)
    REFERENCES clasificacion_accidente(id_clasif_accidente);

---Crea la llave foranea entre la tabla accidenteTransito y la Clasificacion

ALTER TABLE accidenteTransito
    ADD CONSTRAINT fk_clasificacion_accidente FOREIGN KEY (id_Clasificacion)
    REFERENCES clasificacion_accidente(id_clasif_accidente);

---Crea la llave foranea entre la tabla accidenteTransito y la Clasificacion
