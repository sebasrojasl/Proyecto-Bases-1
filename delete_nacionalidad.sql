create or replace procedure deleteNacionalidad(vcNombre in Nacionalidad.nombre%type)is 
    BEGIN
        savepoint sp_safe;
        --Punto de seguridad por si pasa un error
        delete
        from Nacionalidad
        where nombre = vcNombre;
        COMMIT;
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
        COMMIT;
    END;