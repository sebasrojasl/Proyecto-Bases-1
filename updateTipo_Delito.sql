create or replace PROCEDURE updateTipo_Delito(
	   vcnombre_old IN tipo_delito.nombre%TYPE,
	   vcnombre IN Tipo_delito.nombre%TYPE)
IS
BEGIN
    SAVEPOINT sp_safe;
  UPDATE tipo_delito SET nombre = vcnombre 
  where nombre = vcnombre_old;
  commit;
EXCEPTION 
WHEN NO_DATA_FOUND THEN 
    DBMS_OUTPUT.PUT_LINE('An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
    ROLLBACK to sp_safe;
WHEN STORAGE_ERROR THEN
    DBMS_OUTPUT.PUT_LINE('An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
    ROLLBACK to sp_safe;
WHEN DUP_VAL_ON_INDEX THEN 
    ROLLBACK to sp_safe;
WHEN OTHERS THEN 
        DBMS_OUTPUT.PUT_LINE('An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
    ROLLBACK to sp_safe; 
     --maneja cualquier otro error  
END;
