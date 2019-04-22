create or replace PROCEDURE insertarProvincia
(vcnombre in Provincia.nombre%type,
vcid_pais in provincia.id_pais%type) AS
--- Procedimiento que ingresa al catalogo un tipo de delito  nuevo
BEGIN
    SAVEPOINT sp_safe;
   INSERT INTO Provincia(id_Provincia, id_pais, nombre) 
   VALUES(S_Provincia.nextVal, vcid_pais, vcnombre);
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
