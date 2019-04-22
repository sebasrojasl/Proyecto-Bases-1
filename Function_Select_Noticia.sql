--Funcion que se encarga de obtener todos los datos de una Noticia dependiendo de un id_usuario ingresado
-- Se introducen los datos en un cursor y se retornan dentro del mismo
CREATE OR REPLACE FUNCTION getNoticia(pId_Usuario in Number) RETURN SYS_REFCURSOR
AS
    curNoticia SYS_REFCURSOR;
    BEGIN
      SAVEPOINT sp_safe;
      --Punto de seguridad por si pasa un error
      OPEN curNoticia
      FOR SELECT * 
      FROM Noticia
      WHERE id_usuario = pId_Usuario;
      RETURN curNoticia;
      Close curNoticia;
  EXCEPTION
  --En caso de alg�n error, aqu� se hace un catch del mismo y se env�a al dbms_output para desde ah� leerlo en Java
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
END getNoticia;