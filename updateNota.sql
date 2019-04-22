create or replace PROCEDURE updateNota(
	   vcid_nota IN Nota.id_nota%TYPE,
	   vcdescripcion IN Nota.descripcion%TYPE)
IS
BEGIN
    SAVEPOINT sp_safe;

  UPDATE Nota SET descripcion = vcdescripcion where id_nota = vcid_nota;
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
    ----Maneja cualquier otro error
END;
