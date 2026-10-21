/* PL/SQL es un lenguaje procedural declarativo para consultar y modificar
datos, pueden ejecutarse bloques que tengan variables, constantes, bucles,
estructuras de control, excepciones, tiene entrada y salida de datos */

CREATE OR REPLACE PROCEDURE INSERTAR_CLIENTE (
    P_RUT IN VARCHAR2,
    P_NOMBRE IN VARCHAR2,
    P_APELLIDO IN VARCHAR2,
    P_EMAIL IN VARCHAR2
)
IS /* Después del IS/AS viene la declaración de variables */
BEGIN
    -- Se usan las columnas reales del modelo
    INSERT INTO CLIENTE (RUT, PRIMER_NOMBRE, PRIMER_APELLIDO, EMAIL) 
    VALUES (P_RUT, P_NOMBRE, P_APELLIDO, P_EMAIL);
    
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Usuario registrado.');
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END INSERTAR_CLIENTE;
/

/* Se puede invocar en cualquier parte,
en otro procedimiento, funciones, bloques, etc. */

-- ACTIVIDAD --
-- Retornar los datos de un cliente según su id --
CREATE OR REPLACE PROCEDURE BUSCAR_CLIENTE_POR_ID (
    P_CLIENTE_ID IN NUMBER,
    P_NOMBRE OUT VARCHAR2,
    P_APELLIDO OUT VARCHAR2,
    P_EMAIL OUT VARCHAR2,
    P_TELEFONO OUT VARCHAR2
) IS
BEGIN
    SELECT PRIMER_NOMBRE, PRIMER_APELLIDO, EMAIL, TELEFONO 
    INTO P_NOMBRE, P_APELLIDO, P_EMAIL, P_TELEFONO
    FROM CLIENTE
    WHERE ID_CLIENTE = P_CLIENTE_ID;

EXCEPTION
    -- Controlamos el error si el ID ingresado no existe
    WHEN NO_DATA_FOUND THEN
        P_NOMBRE := 'No existe';
        P_APELLIDO := 'No existe';
        P_EMAIL := 'No existe';
        P_TELEFONO := 'No existe';
        DBMS_OUTPUT.PUT_LINE('Error: No se encontró ningún cliente con el ID ' || P_CLIENTE_ID);
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error inesperado: ' || SQLERRM);
END BUSCAR_CLIENTE_POR_ID;
/