/* PL/SQL es un lenguaje procedural declarativo para consultar y modificar
datos, pueden ejecutarse bloques que tengan variables, constantes, bucles,
estructuras de control, excepciones, tiene entrada y salida de datos */

CREATE OR REPLACE PROCEDURE SP_INSERTAR_REGISTRO(
    P_RUT IN VARCHAR2,
    P_NOMBRE IN VARCHAR2,
    P_APELLIDO IN VARCHAR2,
    P_EMAIL IN VARCHAR2
)
IS /* Después de IS/AS viene la declaración de variables */

BEGIN
    -- Cambiar NOMBRE_TABLA y sus columnas por las del caso de prueba
    INSERT INTO NOMBRE_TABLA (COLUMNA_RUT, COLUMNA_NOMBRE, COLUMNA_APELLIDO, COLUMNA_EMAIL) 
    VALUES (P_RUT, P_NOMBRE, P_APELLIDO, P_EMAIL);
    
    COMMIT;
    -- Ojo: En PL/SQL los textos van con comilla simple (''), NUNCA con comilla doble ("")
    DBMS_OUTPUT.PUT_LINE('Usuario registrado con éxito.');

EXCEPTION
    -- Si el insert falla (ej: RUT repetido), deshacemos y avisamos
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error al intentar registrar: ' || SQLERRM);
END SP_INSERTAR_REGISTRO;
/

/* Se puede invocar en cualquier parte,
en otro procedimiento, funciones, bloques, etc. */

-- ACTIVIDAD --
-- Retornar los datos de un registro según su ID (Parámetros OUT) --
CREATE OR REPLACE PROCEDURE SP_BUSCAR_POR_ID(
    P_ID_ENTRADA IN NUMBER,
    P_NOMBRE OUT VARCHAR2,
    P_APELLIDO OUT VARCHAR2,
    P_EMAIL OUT VARCHAR2,
    P_TELEFONO OUT VARCHAR2
) IS
BEGIN
    -- Extraemos los datos de la tabla y los inyectamos en las variables OUT
    SELECT COLUMNA_NOMBRE, COLUMNA_APELLIDO, COLUMNA_EMAIL, COLUMNA_TELEFONO 
    INTO P_NOMBRE, P_APELLIDO, P_EMAIL, P_TELEFONO
    FROM NOMBRE_TABLA
    WHERE ID_PK = P_ID_ENTRADA; -- Igualamos la Llave Primaria con el ID que entró

EXCEPTION
    -- Manejo obligatorio por si el profesor busca un ID que no existe
    WHEN NO_DATA_FOUND THEN
        P_NOMBRE := 'Sin datos';
        P_APELLIDO := 'Sin datos';
        P_EMAIL := 'Sin datos';
        P_TELEFONO := 'Sin datos';
        DBMS_OUTPUT.PUT_LINE('Alerta: No se encontró ningún registro con el ID ' || P_ID_ENTRADA);
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error inesperado: ' || SQLERRM);
END SP_BUSCAR_POR_ID;
/

/* Estudiar funciones para el miércoles 23-09 */