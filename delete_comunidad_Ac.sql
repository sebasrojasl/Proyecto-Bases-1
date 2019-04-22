create or replace PROCEDURE delete_comunidad_Ac
(
vcid_accidente in comunidad_de_accidente.id_accidente%type) AS
--- Procedimiento que elimina una comunidad asociada a un accidente
BEGIN
    SAVEPOINT sp_safe;
        DELETE
        FROM
            comunidad_de_accidente
        WHERE
            id_accidente = vcid_accidente;

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
