SET SERVEROUTPUT ON;
DECLARE
    V_VALOR_RARO NUMBER;
BEGIN
    -- 1. Intentamos forzar un error de DATO (Letras a números)
    -- V_VALOR_RARO := TO_NUMBER('TEXTO'); 
    
    -- 2. Intentamos insertar un PK repetido
    INSERT INTO TABLA_CUALQUIERA (ID_PK) VALUES (1); 

EXCEPTION
    WHEN VALUE_ERROR THEN
        DBMS_OUTPUT.PUT_LINE('Error: El tipo de dato es incorrecto o excede el tamaño.');
    WHEN DUP_VAL_ON_INDEX THEN
        DBMS_OUTPUT.PUT_LINE('Error: Rompiste la unicidad. El ID o el RUT ya existe.');
    WHEN ZERO_DIVIDE THEN
        DBMS_OUTPUT.PUT_LINE('Error: Intentaste dividir un número por cero.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error inesperado: ' || SQLERRM);
END;
/