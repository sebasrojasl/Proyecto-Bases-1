create or replace PROCEDURE update_Accidente_Trans(
	   vcid_accidente_transito IN accidente_transito.id_accidente_transito%TYPE,
       vclesion in accidente_transito.lesion%TYPE,
        vcfecha in accidente_transito.fecha%type,
        vcvehiculos accidente_transito.vehiculos%type,
        vcid_clasificacion in accidente_transito.id_clasificacion%type, 
        vcid_pais in accidente_transito.id_pais%type,
        vcid_provincia in accidente_transito.id_provincia%type,
        vcid_canton in accidente_transito.id_canton%type,
        vcid_distrito in accidente_transito.id_distrito%type,
        vcid_comunidad in accidente_transito.id_comunidad%type
       )
IS
BEGIN
    SAVEPOINT sp_safe;

  UPDATE Accidente_Transito SET 
  lesion = vclesion,
  fecha = vcfecha, 
  vehiculos = vcvehiculos,
  id_clasificacion = vcid_clasificacion,
  id_pais = vcid_pais,
  id_provincia = vcid_provincia,
  id_canton =  vcid_canton,
  id_distrito = vcid_distrito,
  id_comunidad = vcid_comunidad

  where id_accidente_transito = vcid_accidente_transito; 

  commit;
EXCEPTION 
WHEN NO_DATA_FOUND THEN 
    raise_application_error(-20001,'An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
    ROLLBACK to sp_safe;
WHEN STORAGE_ERROR THEN
    raise_application_error(-20001,'An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
    ROLLBACK to sp_safe;
WHEN OTHERS THEN 
    ROLLBACK to sp_safe;     
     --maneja cualquier otro error 
END;
