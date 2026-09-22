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

--cuando un valor rompe un criterio de unicidad
DECLARE
    V_
BEGIN
EXCEPTION
WHEN THEN
    DBMS_OUTPUT.PUT_LINE('There are');
END;
/

--Error de valor
DECLARE
    V_NUM NUMBER;
BEGIN
    