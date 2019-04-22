--Procedimiento que inserta un dato en la tabla NivelAcceso por primera vez, con todos los datos necesarios
create or replace procedure insertNivelAcceso(vcNombre in Nivelacceso.nivelacceso_nombre%type)is 
    BEGIN
        SAVEPOINT sp_safe;
        --Punto de seguridad por si pasa un error
        insert into NivelAcceso(id_Nivel_Acceso, nivelacceso_nombre)
        VALUES(s_nivelacceso.nextval, vcNombre);
        COMMIT;
    EXCEPTION
    --En caso de algún error, aquí se hace un catch del mismo y se envía al dbms_output para desde ahí leerlo en Java
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
            ROLLBACK to sp_safe;
        WHEN STORAGE_ERROR THEN
            DBMS_OUTPUT.PUT_LINE('An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
            ROLLBACK to sp_safe;
        WHEN SUBSCRIPT_BEYOND_COUNT THEN
            DBMS_OUTPUT.PUT_LINE('An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
            ROLLBACK to sp_safe;
        WHEN OTHERS THEN 
            DBMS_OUTPUT.PUT_LINE('An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
            ROLLBACK to sp_safe;
            --Maneja cualquier otro error
        COMMIT;     
    END;
    
--Procedimiento que se encarga de actualizar cierto dato de la tabla NivelAcceso dependiendo del id_NivelAcceso ingresado
create or replace procedure updateNivelAcceso(vcId_NivelAcceso in NivelAcceso.id_Nivel_Acceso%type, vcNombre in Nivelacceso.nivelacceso_nombre%type)is 
    BEGIN
        savepoint sp_safe;
        --Punto de seguridad por si pasa un error
        update NivelAcceso
        set  nivelacceso_nombre = NVL(vcNombre, nivelacceso_nombre)
        where id_Nivel_Acceso = vcId_NivelAcceso;
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

--Procedimiento que se encarga de eliminar cierto dato de la tabla NivelAcceso dependiendo del nombre ingresado
create or replace procedure deleteNivelAcceso(vcNombre in Nivelacceso.nivelacceso_nombre%type)is 
    BEGIN
        savepoint sp_safe;
        --Punto de seguridad por si pasa un error
        delete
        from NivelAcceso
        where nivelacceso_nombre = vcNombre;
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