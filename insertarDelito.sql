create or replace PROCEDURE insertarDelito
(vcafectado IN NUMBER, vctipo in varchar2, vcid_nota in NUMBER, vcid_tipo_delito in number, vcid_clasif in number) AS
--- Funcion que se encarga de crear un nuevo reporte de delito
BEGIN
    SAVEPOINT sp_safe;
   INSERT INTO Delito(id_delito, afectado, tipo_arma, id_nota, id_tipo_delito, id_clasif) 
   VALUES(S_DELITO.nextval, vcafectado, vctipo, vcid_nota, vcid_tipo_delito, vcid_clasif);
   commit;
EXCEPTION 
WHEN DUP_VAL_ON_INDEX THEN 
    ROLLBACK to sp_safe;
WHEN OTHERS THEN 
    DBMS_OUTPUT.PUT_LINE('An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
    ROLLBACK to sp_safe; 
     --maneja cualquier otro error  
END;
