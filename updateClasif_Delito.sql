create or replace PROCEDURE updateClasif_Delito(
	   vcnombre_Old IN clasificacion_delito.nombre%TYPE,
	   vcnombre IN clasificacion_delito.nombre%TYPE)
IS
BEGIN
    SAVEPOINT sp_safe;
  UPDATE clasificacion_delito 
  
SET nombre = vcnombre 
  where nombre = vcnombre_Old;
  commit;
EXCEPTION 
WHEN NO_DATA_FOUND THEN 
    DBMS_OUTPUT.PUT_LINE('An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
    ROLLBACK to sp_safe;
WHEN STORAGE_ERROR THEN
    DBMS_OUTPUT.PUT_LINE('An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
    ROLLBACK to sp_safe;
WHEN DUP_VAL_ON_INDEX THEN 
    DBMS_OUTPUT.PUT_LINE('An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
    ROLLBACK to sp_safe;
WHEN OTHERS THEN 
        DBMS_OUTPUT.PUT_LINE('An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
    ROLLBACK to sp_safe; 
     --maneja cualquier otro error  
END;
