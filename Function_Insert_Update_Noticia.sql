--Procedimiento que inserta un dato en la tabla Noticia por primera vez, con todos los datos necesarios
create or replace procedure insertNotica(vcDireccion in noticia.direccion%type, vcFecha in noticia.fecha%type, vcComunidad in noticia.id_comunidad%type,
vcClasif_Noticia in noticia.id_clasif_noticia%type, vcUsuario in noticia.id_usuario%type)is 
    BEGIN
        SAVEPOINT sp_safe;
        --Punto de seguridad por si pasa un error
        insert into Noticia(id_Noticia, direccion, Fecha, id_comunidad, id_clasif_noticia, id_usuario)
        VALUES(s_noticia.nextval, vcDireccion, vcFecha, vcComunidad, vcClasif_Noticia, vcUsuario);
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

--Procedimiento que se encarga de actualizar cierto dato de la tabla Noticia dependiendo del id_Noticia ingresado  
create or replace procedure updateNoticia(vcId_Noticia in noticia.id_noticia%type, vcDireccion in noticia.direccion%type, vcFecha in noticia.fecha%type, 
vcComunidad in noticia.id_comunidad%type, vcClasif_Noticia in noticia.id_clasif_noticia%type, vcUsuario in noticia.id_usuario%type)is 
    BEGIN
        savepoint sp_safe;
        --Punto de seguridad por si pasa un error
        update noticia
        set  direccion = NVL(vcDireccion, direccion),
            Fecha = NVL(vcFecha, Fecha),
            id_comunidad = NVL(vcComunidad, id_comunidad), 
            id_Clasif_Noticia = NVL(vcClasif_noticia, id_Clasif_noticia), 
            id_Usuario = NVL(vcUsuario, id_Usuario)
        where id_Noticia = vcId_Noticia;
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
    
--Procedimiento que se encarga de eliminar cierto dato de la tabla Noticia dependiendo del id_Noticia ingresado
create or replace procedure deleteNoticia(vcId_Noticia in Noticia.id_noticia%type)is 
    BEGIN
        savepoint sp_safe;
        --Punto de seguridad por si pasa un error
        delete
        from Noticia
        where id_noticia = vcId_Noticia;
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