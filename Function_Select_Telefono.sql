--Funcion que se encarga de obtener todos los datos de un Telefono dependiendo de un id_usuario ingresado
-- Se introducen los datos en un cursor y se retornan dentro del mismo
CREATE OR REPLACE FUNCTION getTelefono(pId_Usuario in Number) RETURN SYS_REFCURSOR
AS
    curTelefono SYS_REFCURSOR;
    vcPersona number(10);
    BEGIN
      SAVEPOINT sp_safe;
      --Punto de seguridad por si pasa un error
      select id_persona
      into vcPersona
      from usuario
      where id_usuario = pId_usuario;
      --Se busca y guarda el id_persona respectivo a el id_usuario ingresado
      
      OPEN curTelefono
      FOR SELECT * 
      FROM telefono
      WHERE id_persona = vcPersona;
      RETURN curTelefono;
      Close curTelefono;
      --Se guarda en el cursor los datos de los telefonos correspondientes a esa id_persona
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
END getTelefono;