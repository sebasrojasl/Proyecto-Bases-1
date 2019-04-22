create or replace PROCEDURE insertarTipoDelito
(vcnombre in Tipo_delito.nombre%type) AS
--- Procedimiento que ingresa al catalogo un tipo de delito  nuevo
BEGIN
    SAVEPOINT sp_safe;
   INSERT INTO Tipo_Delito(id_tipo_delito, nombre) 
   VALUES(S_TIPO_DELITO.nextval, vcnombre);
   commit;
   EXCEPTION
   
WHEN OTHERS THEN 
        DBMS_OUTPUT.PUT_LINE('An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
    ROLLBACK to sp_safe; 
     --maneja cualquier otro error      
END;
