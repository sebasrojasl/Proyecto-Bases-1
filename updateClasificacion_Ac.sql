create or replace PROCEDURE updateClasificacion_Ac
(vcnombre in clasificacion_accidente.nombre_clasificacion%type,
vcnombre_old in clasificacion_accidente.nombre_clasificacion%type) AS
--- Procedimiento que ingresa al catalogo un tipo de delito  nuevo
BEGIN
   SAVEPOINT sp_safe;
  UPDATE clasificacion_accidente SET 
  nombre_clasificacion = vcnombre
  where nombre_clasificacion = vcnombre_old;
   commit;
   EXCEPTION 
WHEN STORAGE_ERROR THEN 
       DBMS_OUTPUT.PUT_LINE('An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
    ROLLBACK to sp_safe;
WHEN SUBSCRIPT_BEYOND_COUNT THEN
       DBMS_OUTPUT.PUT_LINE('An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
    ROLLBACK to sp_safe;
WHEN OTHERS THEN 
        DBMS_OUTPUT.PUT_LINE('An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
    ROLLBACK to sp_safe; 
     --maneja cualquier otro error      
END;
