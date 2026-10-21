SET SERVEROUTPUT ON; 
DECLARE 
    -- 1. Definir la estructura del RECORD (La "ficha" a llenar)
    TYPE tr_ficha IS RECORD ( 
        campo_str VARCHAR2(100), 
        campo_num NUMBER
    ); 
    v_registro tr_ficha; 
     
    -- 2. Variable de búsqueda (Lo que ingresa el usuario/sistema)
    v_busqueda_id NUMBER := 1;  
BEGIN 
    DBMS_OUTPUT.PUT_LINE('--- INICIO DE BÚSQUEDA ---'); 
     
    -- 3. Llenado del RECORD (Reemplaza con los JOINs del quiz)
    SELECT t1.nombre, t2.cantidad 
    INTO v_registro.campo_str, v_registro.campo_num 
    FROM TABLA_PRINCIPAL t1 
    JOIN TABLA_SECUNDARIA t2 ON t1.id_fk = t2.id_pk
    WHERE t1.id_pk = v_busqueda_id; 
     
    -- 4. Imprimir resultados
    DBMS_OUTPUT.PUT_LINE('Nombre: ' || v_registro.campo_str); 
    DBMS_OUTPUT.PUT_LINE('Cantidad: ' || v_registro.campo_num); 
     
EXCEPTION 
    -- 5. Manejo de error si el ID no existe en la base de datos
    WHEN NO_DATA_FOUND THEN  
        DBMS_OUTPUT.PUT_LINE('Error: El registro buscado no existe.'); 
    WHEN OTHERS THEN 
        DBMS_OUTPUT.PUT_LINE('Error inesperado: ' || SQLERRM); 
END; 
/