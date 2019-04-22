--Funcion que se encarga de obtener todos los datos de un usuario dependiendo de un id_Usuario ingresado
-- Se introducen los datos en un cursor y se retornan dentro del mismo
CREATE OR REPLACE FUNCTION getUsuario(pId_Usuario in Number) RETURN SYS_REFCURSOR
AS
    curUsuario SYS_REFCURSOR;
    BEGIN
      SAVEPOINT sp_safe;
      --Punto de seguridad por si pasa un error
      OPEN curUsuario
      FOR SELECT * 
      FROM Usuario
      WHERE id_Usuario = pId_Usuario;
      RETURN curUsuario;
      CLOSE curUsuario;
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
END getUsuario;
