SELECT  EMAIL FROM CLIENTE where RUT = '11.111.111-1';
SELECT EMAIL FROM CLIENTE WHERE RUT = '19.232.456-1';

DECLARE
    v_email CLIENTE.EMAIL%TYPE;
BEGIN
    SELECT EMAIL INTO v_email FROM CLIENTE where RUT = '11.111.111-1';
    DBMS_OUTPUT.PUT_LINE('El email es: ' || v_email);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Datos inexistentes para la consulta');
    WHEN TOO_MANY_ROWS THEN
        DBMS_OUTPUT.PUT_LINE('Muchas filas');
END;
/

--division por cero
DECLARE
    V_RESULTADO NUMBER;
    V_DESCUENTO NUMBER := 0;
BEGIN
    V_RESULTADO := 100 / V_DESCUENTO;
    DBMS_OUTPUT.PUT_LINE(V_RESULTADO);
EXCEPTION
    WHEN ZERO_DIVIDE THEN
    DBMS_OUTPUT.PUT_LINE('Error: no se puede dividir por cero');
END;
/

SET SERVEROUTPUT ON;

-- Cuando un valor rompe un criterio de unicidad
DECLARE
    -- Simulamos un ID que ya existe en tu tabla CLIENTE
    V_ID_CLIENTE NUMBER := 1; 
BEGIN
    DBMS_OUTPUT.PUT_LINE('--- INTENTANDO REGISTRAR CLIENTE ---');
    
    -- Si el id_cliente = 1 ya existe, esto va a fallar y saltará a la excepción
    INSERT INTO CLIENTE (id_cliente, primer_nombre, primer_apellido, rut, email, telefono, direccion) 
    VALUES (V_ID_CLIENTE, 'Renata', 'Gomez', '12345678-9', 'renata@mail.com', '987654321', 'Puerto Montt');
    
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Cliente registrado con éxito.');

EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        -- Aquí atrapamos el error de unicidad
        DBMS_OUTPUT.PUT_LINE('Error: Ya existe un registro con ese ID. Criterio de unicidad roto.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error inesperado: ' || SQLERRM);
END;
/

SET SERVEROUTPUT ON;

-- Error de valor
DECLARE
    V_NUM NUMBER;
BEGIN
    DBMS_OUTPUT.PUT_LINE('--- INICIO DE VALIDACIÓN DE DATOS ---');
    
    -- Forzamos el error intentando convertir letras en un número
    V_NUM := TO_NUMBER('ABC'); 
    
    DBMS_OUTPUT.PUT_LINE('El número es: ' || V_NUM);

EXCEPTION
    WHEN VALUE_ERROR THEN
        -- Aquí atrapamos el error de tipo de dato
        DBMS_OUTPUT.PUT_LINE('Error de Valor: Intentaste asignar un texto a un número o superaste el límite de caracteres.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error inesperado: ' || SQLERRM);
END;
/