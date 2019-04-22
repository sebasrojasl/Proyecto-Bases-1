create or replace PROCEDURE insertarClasif_Delito
(vcnombre in clasificacion_delito.nombre%type) AS
--- Procedimiento que ingresa al catalogo un tipo de delito  nuevo
BEGIN
    SAVEPOINT sp_safe;
   INSERT INTO clasificacion_delito(id_clasif_delito, nombre) 
   VALUES(S_clasif_delito.nextval, vcnombre);
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

