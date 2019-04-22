alter table agresor
    add constraint uk_agresor_1 unique(nombre);
    
alter table canton
    add constraint uk_canton_1 unique(nombre);
    
alter table clasificacion_accidente
    add constraint uk_clasif_accidente_1 unique(nombre_clasificacion);
    
alter table clasificacion_delito
    add constraint uk_clasif_delito_1 unique(nombre);
    
alter table clasificacion_noticia
    add constraint uk_clasif_noticia_1 unique(nombre);
    
alter table comunidad
    add constraint uk_comunidad_1 unique(comunidad_nombre);
    
alter table distrito
    add constraint uk_distrito_1 unique(nombre);
    
alter table nivelacceso
    add constraint uk_nivelacceso_1 unique(nivelacceso_nombre);
    
alter table pais
    add constraint uk_pais_1 unique(nombre);
    
alter table provincia
    add constraint uk_provincia_1 unique(nombre);
    
alter table servicio
    add constraint uk_servicio_1 unique(nombre);
    
alter table tipo_corte_servicio
    add constraint uk_tipo_corte_serv_1 unique(nombre);
    
alter table tipo_delito
    add constraint uk_tipo_delito_1 unique(nombre);
    
    

    