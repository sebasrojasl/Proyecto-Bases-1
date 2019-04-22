create or replace PROCEDURE delete_delito
(vcid_delito in delito.id_delito%type) AS
--- Procedimiento que ingresa al catalogo un tipo de delito  nuevo
        vcid_nota number(10);
        vid_agresor number(10);
BEGIN
    SAVEPOINT sp_safe;
        
        select id_agresor
        into vid_agresor
        from delito
        where id_agresor = vid_agresor;
        delete_agresor(vid_agresor);
        ---Elimina el agresor asociado
        
        
        select id_nota
        into vcid_nota
        from delito
        where id_delito = vcid_delito;
        delete_nota(vcid_nota);
        
        ---Elimina la nota asociada
        
        -----------------------
        DELETE
        FROM
            delito
        WHERE
            id_delito = vcid_delito;
            
        ----Elimina el reporte delictivo    
                 
   commit;
   EXCEPTION 
   ---Manejo de errores
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
