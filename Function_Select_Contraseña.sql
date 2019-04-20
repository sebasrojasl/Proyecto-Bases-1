--Función que se encarga de retornar la Clave de un Usuario dependiendo de su nombre de usuario
--Se retorna un Varchar2
create or replace function getClave (pNombre_Usuario in usuario.nombre_usuario%type) RETURN VARCHAR2 IS
    vcClave varchar(256);
    BEGIN
        savepoint sp_safe;
        --Punto de seguridad por si pasa un error
        select clave
        into vcClave
        from usuario
        where nombre_usuario = NVL(pNombre_Usuario, nombre_usuario);
        return(vcClave);
    EXCEPTION
    --En caso de algún error, aquí se hace un catch del mismo y se envía al dbms_output para desde ahí leerlo en Java
       WHEN NO_DATA_FOUND THEN 
            DBMS_OUTPUT.PUT_LINE('An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
            ROLLBACK to sp_safe;
        WHEN STORAGE_ERROR THEN
            DBMS_OUTPUT.PUT_LINE('An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
            ROLLBACK to sp_safe;
        WHEN OTHERS THEN
            dbms_output.put_line('An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
            ROLLBACK to sp_safe;     
             --maneja cualquier otro error 
    END getClave;