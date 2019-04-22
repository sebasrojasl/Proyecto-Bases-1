create or replace PROCEDURE updateCorte_servicio(
	   vcid_corte_serv IN corte_servicio.id_corte_serv%TYPE,
       vctipo_corte_serv IN corte_servicio.id_tipo_corte_serv%type , 
       vcdescripcion in corte_servicio.descripcion%type
       )
IS
BEGIN
    SAVEPOINT sp_safe;

  UPDATE corte_servicio SET 
  id_tipo_corte_serv = vctipo_corte_serv,
  descripcion = vcdescripcion 

  where id_corte_serv = vcid_corte_serv; 

  commit;
EXCEPTION 
WHEN NO_DATA_FOUND THEN 
    raise_application_error(-20001,'An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
    ROLLBACK to sp_safe;
WHEN STORAGE_ERROR THEN
    raise_application_error(-20001,'An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
    ROLLBACK to sp_safe;
WHEN OTHERS THEN 
    ROLLBACK to sp_safe;     
     --maneja cualquier otro error 
END;
