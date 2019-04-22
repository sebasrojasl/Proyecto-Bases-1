create or replace PROCEDURE update_canton
(vcnombreOld in canton.nombre%type,
vcnombre in canton.nombre%type) AS
--- Procedimiento que ingresa al catalogo un tipo de delito  nuevo
BEGIN
    SAVEPOINT sp_safe;

  UPDATE canton SET 
  nombre = vcnombre
  where nombre = vcnombreOld;

   commit;
   EXCEPTION 

WHEN STORAGE_ERROR THEN 
       DBMS_OUTPUT.PUT_LINE('An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
    ROLLBACK to sp_safe;
WHEN SUBSCRIPT_BEYOND_COUNT THEN
       DBMS_OUTPUT.PUT_LINE('An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
    ROLLBACK to sp_safe;
WHEN OTHERS THEN 
        DBMS_OUTPUT.PUT_LINE('An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
    ROLLBACK to sp_safe; 
     --maneja cualquier otro error      
END;
