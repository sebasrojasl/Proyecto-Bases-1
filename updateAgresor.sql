create or replace PROCEDURE updateAgresor(
	   vcid_agresor IN agresor.id_agresor%TYPE,
	   vcnombre IN Tipo_delito.nombre%TYPE,
       vcid_genero in genero.id_genero%type)
IS
BEGIN
    SAVEPOINT sp_safe;
  UPDATE agresor SET 
  nombre = vcnombre,
  id_genero = vcid_genero
  where id_agresor = vcid_agresor;
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
