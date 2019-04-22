--Procedimiento que inserta un dato en la tabla Telefono por primera vez, con todos los datos necesarios
create or replace procedure insertTelefono(vcNumero in telefono.numero%type, vcPersona in telefono.id_persona%type)is 
    BEGIN
        SAVEPOINT sp_safe;
        --Punto de seguridad por si pasa un error
        insert into telefono(id_telefono, numero, id_persona)
        VALUES(s_telefono.nextval, vcNumero, vcPersona);
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
    
--Procedimiento que se encarga de actualizar cierto dato de la tabla Telefono dependiendo del id_Persona ingresado
create or replace procedure updateTelefono(vcId_telefono in telefono.id_telefono%type, vcNumero in telefono.numero%type, vcPersona in telefono.id_persona%type)is 
    BEGIN
        savepoint sp_safe;
        --Punto de seguridad por si pasa un error
        update telefono
        set  numero = NVL(vcNumero, numero),
            id_persona = NVL(vcPersona, id_persona)
        where id_telefono = vcId_telefono;
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
    
--Procedimiento que se encarga de eliminar cierto dato de la tabla Telefono dependiendo del id_persona ingresado
create or replace procedure deleteTelefono(vcId_Persona in telefono.id_persona%type)is 
    BEGIN
        savepoint sp_safe;
        --Punto de seguridad por si pasa un error
        delete
        from telefono
        where id_persona = vcId_Persona;
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