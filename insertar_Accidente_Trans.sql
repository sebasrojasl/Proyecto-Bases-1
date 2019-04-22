create or replace PROCEDURE insertar_Accidente_Trans
(vclesion in accidente_transito.lesion%TYPE,
vcfecha in accidente_transito.fecha%type,
vcvehiculos accidente_transito.vehiculos%type,
vcid_clasificacion in accidente_transito.id_clasificacion%type, 
vcid_pais in accidente_transito.id_pais%type,
vcid_provincia in accidente_transito.id_provincia%type,
vcid_canton in accidente_transito.id_canton%type,
vcid_distrito in accidente_transito.id_distrito%type,
vcid_comunidad in accidente_transito.id_comunidad%type,
vcid_usuario in accidente_transito.id_usuario%type) AS
--- Funcion que se encarga de crear un nuevo reporte de delito
BEGIN
    SAVEPOINT sp_safe;
   INSERT INTO Accidente_transito(id_accidente_transito, lesion, fecha, vehiculos, id_clasificacion, id_pais, id_provincia, id_canton, id_distrito, id_comunidad, id_usuario) 
   VALUES(S_accidentetransito.nextval, vclesion, vcfecha, vcvehiculos, vcid_clasificacion, vcid_pais,vcid_provincia,vcid_canton,vcid_distrito,vcid_comunidad, vcid_usuario);
   commit;
EXCEPTION 
WHEN DUP_VAL_ON_INDEX THEN 
    ROLLBACK to sp_safe;
WHEN OTHERS THEN 
    DBMS_OUTPUT.PUT_LINE('An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
    ROLLBACK to sp_safe; 
     --maneja cualquier otro error  
END;
