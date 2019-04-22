create or replace PROCEDURE insertarAgresor(       
	   vcnombre    IN agresor.nombre%TYPE,
       vcid_genero in genero.id_genero%type,
       vcid_nota   in nota.id_nota%type) AS
--- Funcion que se encarga de crear un nuevo reporte de delito
BEGIN
   SAVEPOINT sp_safe;
   INSERT INTO Agresor(id_agresor, id_genero, nombre, id_nota) 
   VALUES(S_Agresor.nextval, vcid_genero, vcnombre, vcid_nota);
   commit;
EXCEPTION 
WHEN DUP_VAL_ON_INDEX THEN 
    DBMS_OUTPUT.PUT_LINE('An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
    ROLLBACK to sp_safe;
WHEN OTHERS THEN 
        DBMS_OUTPUT.PUT_LINE('An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
    ROLLBACK to sp_safe; 
     --maneja cualquier otro error  
END;
