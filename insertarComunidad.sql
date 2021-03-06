create or replace PROCEDURE insertarComunidad
(vcnombre in comunidad.comunidad_nombre%type) AS
--- Procedimiento que ingresa al catalogo un tipo de delito  nuevo
BEGIN
    SAVEPOINT sp_safe;
   INSERT INTO Comunidad(id_comunidad, comunidad_nombre) 
   VALUES(S_COMUNIDAD.nextval, vcnombre);
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
