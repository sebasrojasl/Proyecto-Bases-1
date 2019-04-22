--Funcion que se encarga de obtener todos los datos de una comunidad favorita dependiendo de un id_usuario ingresado
-- Se introducen los datos en un cursor y se retornan dentro del mismo
CREATE OR REPLACE FUNCTION getComunidadFav(pId_Usuario in Number) RETURN SYS_REFCURSOR
AS
    curComunidadFav SYS_REFCURSOR;
    BEGIN
      SAVEPOINT sp_safe;
      --Punto de seguridad por si pasa un error
      OPEN curComunidadFav
      FOR SELECT * 
      FROM comunidad_favorita
      WHERE id_usuario = pId_Usuario;
      RETURN curComunidadFav;
      Close curComunidadFav;
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
END getComunidadFav;