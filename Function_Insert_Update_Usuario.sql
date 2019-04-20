--Procedimiento que inserta un dato en la tabla usuario por primera vez, con todos los datos necesarios
create or replace procedure insertUsuario(vcNombre_Usuario in usuario.nombre_usuario%type, vcPersona in usuario.id_persona%type, 
vcNivelAcceso in usuario.id_nivel_acceso%type, vcClave in usuario.clave%type)is 
    BEGIN
        savepoint sp_safe;
        --Punto de seguridad por si pasa un error
        insert into usuario(id_usuario, nombre_usuario, id_persona, id_nivel_acceso, clave)
        VALUES(s_Usuario.nextval, vcNombre_Usuario, vcPersona, vcNivelAcceso, vcClave);
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
    
    
--Procedimiento que se encarga de actualizar cierto dato de la tabla usuario dependiendo del nombre de usuario ingresado
create or replace procedure updateUsuario(vcNombre_Usuario in usuario.nombre_usuario%type,vcPersona in usuario.id_persona%type, 
vcNivelAcceso in usuario.id_nivel_acceso%type,  vcClave in usuario.clave%type)is 
    BEGIN
        savepoint sp_safe;
        --Punto de seguridad por si pasa un error
        update usuario 
        set id_persona = NVL(vcPersona, id_persona),
            id_nivel_acceso = NVL(vcNivelAcceso, id_nivel_acceso),
            clave = NVL(vcClave, clave),
            nombre_usuario = NVL(vcNombre_Usuario, nombre_usuario)
        where nombre_usuario = vcNombre_Usuario;
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
            dbms_output.put_line('Unexpected error');
            ROLLBACK to sp_safe;
        COMMIT;
    END;
    