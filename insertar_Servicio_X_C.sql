create or replace PROCEDURE insertar_Servicio_X_C
(vcid_servicio in servicio_x_comunidad.id_servicio%type,
vcid_comunidad in servicio_x_comunidad.id_comunidad%type,
vcpagina_web in servicio_x_comunidad.pagina_web%type,
vctelefono in servicio_x_comunidad.telefono%type,
vcdireccion in servicio_x_comunidad.direccion%type) AS
--- Procedimiento que ingresa un nuevo servicio para una comunidad
BEGIN
    SAVEPOINT sp_safe;
   INSERT INTO Servicio_X_Comunidad(id_servicio, id_comunidad,pagina_web, telefono,direccion) 
   VALUES(vcid_servicio, vcid_comunidad,vcpagina_web,vctelefono,vcdireccion);
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
