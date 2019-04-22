--Procedimiento que inserta un dato en la tabla Comunidad de Accidente por primera vez, con todos los datos necesarios
create or replace procedure insertComu_Accidente(vcComunidad in comunidad_de_accidente.id_comunidad%type, vcAccidente in comunidad_de_accidente.id_accidente%type)is 
    BEGIN
        SAVEPOINT sp_safe;
        --Punto de seguridad por si pasa un error
        insert into comunidad_de_accidente(id_comunidad, id_accidente)
        VALUES(vcComunidad, vcAccidente);
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
    
--Procedimiento que se encarga de actualizar cierto dato de la tabla genero dependiendo del id_Genero ingresado
create or replace procedure updateGenero(vcId_genero in genero.id_genero%type, vcNombre in genero.nombre%type)is 
    BEGIN
        savepoint sp_safe;
        --Punto de seguridad por si pasa un error
        update genero
        set  nombre = NVL(vcNombre, nombre)
        where id_genero = vcId_Genero;
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
    
--Procedimiento que se encarga de eliminar cierto dato de la tabla Genero dependiendo del nombre ingresado
create or replace procedure deleteGenero(vcNombre in Genero.nombre%type)is 
    BEGIN
        savepoint sp_safe;
        --Punto de seguridad por si pasa un error
        delete
        from Genero
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