create or replace PROCEDURE delete_Servicio_X_C
(vcid_servicio in servicio_x_comunidad.id_servicio%type,
 vid_comunidad in  servicio_x_comunidad.id_comunidad%type ) AS
--- Procedimiento que elimina un servicio de una comunidad
BEGIN
    SAVEPOINT sp_safe;
        DELETE
        FROM
            servicio_x_comunidad
        WHERE
            id_servicio = vcid_servicio
            and id_comunidad = vid_comunidad;
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
