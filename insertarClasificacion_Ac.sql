create or replace PROCEDURE insertarClasificacion_Ac
(vcnombre in varchar2) AS
--- Procedimiento que ingresa al catalogo un tipo de delito  nuevo
BEGIN
   SAVEPOINT sp_safe;
   INSERT INTO clasificacion_Accidente(id_clasif_accidente, nombre_clasificacion)
   VALUES(S_clasificacion_Ac.nextval, vcnombre);
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
