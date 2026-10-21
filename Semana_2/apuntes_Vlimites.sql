SET SERVEROUTPUT ON; 
DECLARE 
    -- 1. Definir el VARRAY con su límite máximo
    TYPE t_arreglo IS VARRAY(5) OF VARCHAR2(30); 
    v_lista t_arreglo; 
BEGIN 
    -- 2. Llenar los compartimentos
    v_lista := t_arreglo('Dato 1', 'Dato 2', 'Dato 3', 'Dato 4', 'Dato 5'); 
     
    DBMS_OUTPUT.PUT_LINE('--- RECORRIENDO ARREGLO ---'); 
     
    -- 3. Iterar (Ojo: se piden forzar error, pon un número mayor al límite)
    FOR i IN 1..6 LOOP 
        DBMS_OUTPUT.PUT_LINE(i || '. ' || v_lista(i)); 
    END LOOP; 
     
EXCEPTION 
    -- 4. Atrapa el error si intentas leer una posición que no existe
    WHEN SUBSCRIPT_OUTSIDE_LIMIT THEN  
        DBMS_OUTPUT.PUT_LINE('¡Alarma! Intentaste acceder a una posición fuera del VARRAY.'); 
    WHEN OTHERS THEN 
        DBMS_OUTPUT.PUT_LINE('Error inesperado: ' || SQLERRM); 
END; 
/