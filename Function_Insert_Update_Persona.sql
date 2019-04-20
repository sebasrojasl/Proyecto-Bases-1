--Procedimiento que inserta un dato en la tabla persona por primera vez, con todos los datos necesarios
create or replace procedure insertPersona(vcNombre in persona.nombre%type, vcApellidos in persona.apellidos%type, vcNacimiento in persona.nacimiento%type, 
vcFoto in persona.foto%type, vcDireccion in persona.direccion%type, vcCorreo in persona.correo%type, vcGenero in persona.id_genero%type, 
vcComunidad in persona.id_comunidad%type)is 
    BEGIN
        SAVEPOINT sp_safe;
        --Punto de seguridad por si pasa un error
        insert into persona(id_persona, nombre, apellidos, nacimiento, foto, direccion, correo, id_genero, id_comunidad)
        VALUES(s_persona.nextval, vcNombre, vcApellidos, vcNacimiento, vcFoto, vcDireccion, vcCorreo, vcGenero, vcComunidad);
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
    
--Procedimiento que se encarga de actualizar cierto dato de la tabla persona dependiendo del id_Persona ingresado
create or replace procedure updatePersona(vcId_persona in persona.id_persona%type, vcNombre in persona.nombre%type, 
vcApellidos in persona.apellidos%type, vcNacimiento in persona.nacimiento%type, vcFoto in persona.foto%type, vcDireccion in persona.direccion%type,
vcCorreo in persona.correo%type, vcGenero in persona.id_genero%type, vcComunidad in persona.id_comunidad%type)is 
    BEGIN
        savepoint sp_safe;
        --Punto de seguridad por si pasa un error
        update persona
        set  nombre = NVL(vcNombre, nombre),
            apellidos = NVL(vcApellidos, apellidos),
            nacimiento = NVL(vcNacimiento, nacimiento), 
            foto = NVL(vcFoto, foto), 
            direccion = NVL(vcDireccion, direccion), 
            correo =  NVL(vcCorreo, correo), 
            id_genero = NVL(vcGenero, id_genero), 
            id_comunidad = NVL(vcComunidad, id_comunidad)
        where id_persona = vcId_persona;
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
    