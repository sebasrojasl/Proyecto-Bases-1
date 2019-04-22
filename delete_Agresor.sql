create or replace PROCEDURE delete_Agresor
(vcid_agresor in agresor.id_agresor%type) AS
--- Procedimiento que ingresa al catalogo un tipo de delito  nuevo
BEGIN
    SAVEPOINT sp_safe;
        DELETE
        FROM
            agresor
        WHERE
            id_agresor = vcid_agresor;
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
     
     ---LA3190DNW76L4KWGFCSL7PANC
END;
