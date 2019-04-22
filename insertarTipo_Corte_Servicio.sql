create or replace PROCEDURE insertarTipo_Corte_Servicio
(vcnombre in Tipo_Corte_Servicio.nombre%type) AS
--- Procedimiento que ingresa al catalogo un tipo de delito  nuevo
BEGIN
   SAVEPOINT sp_safe;
   INSERT INTO Tipo_Corte_Servicio(id_Tipo_Corte_Serv, nombre) 
   VALUES(S_Tipo_Corte_serv.nextval, vcnombre);
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

