create or replace PROCEDURE updateDelito(
	   vcid_delito IN Delito.id_delito%TYPE,
       vcid_id_tipo_delito IN Delito.id_tipo_delito%TYPE,
       vcid_tipo_arma in Delito.tipo_arma%TYPE,
       vcid_clasif in Delito.id_clasif%TYPE,
       vcid_agresor in Delito.id_agresor%TYPE
       )
IS
BEGIN
    SAVEPOINT sp_safe;
    
  UPDATE Delito SET 
  Tipo_arma = vcid_tipo_arma,
  id_tipo_delito = vcid_id_tipo_delito,
  id_clasif = vcid_clasif,
  id_agresor = vcid_agresor 
  
  where id_delito = vcid_delito; 

  commit;
EXCEPTION 
WHEN NO_DATA_FOUND THEN 
    DBMS_OUTPUT.PUT_LINE('An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
    ROLLBACK to sp_safe;
WHEN STORAGE_ERROR THEN
    DBMS_OUTPUT.PUT_LINE('An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
    ROLLBACK to sp_safe;
WHEN OTHERS THEN 
    DBMS_OUTPUT.PUT_LINE('An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
    ROLLBACK to sp_safe;
END;
