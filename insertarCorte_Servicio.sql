create or replace PROCEDURE insertarCorte_Servicio
(vctipo_corte_serv IN corte_servicio.id_tipo_corte_serv%type , vcid_usuario in corte_servicio.id_usuario%type, vcdescripcion in corte_servicio.descripcion%type) AS
--- Funcion que se encarga de crear un nuevo reporte de delito
BEGIN
    SAVEPOINT sp_safe;
   INSERT INTO corte_servicio(id_corte_serv, id_tipo_corte_serv, id_usuario, descripcion) 
   VALUES(S_Corte_Servicio.nextval, vctipo_corte_serv, vcid_usuario, vcdescripcion);
   commit;
EXCEPTION 
WHEN DUP_VAL_ON_INDEX THEN 
    ROLLBACK to sp_safe;
WHEN OTHERS THEN 
        DBMS_OUTPUT.PUT_LINE('An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
    ROLLBACK to sp_safe; 
     --maneja cualquier otro error  

END;
