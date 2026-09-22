/*PL/SQL es un lenguaje procedural declarativo para consultar y modificar
datos, pueden ejecutarse bloques que tengan variables, constantes, bucles,
estructuras de control, excepciones, tiene entrada y salida de datos*/

CREATE OR REPLACE PROCEDURE insertar_cliente(
    p_rut IN VARCHAR2,
    p_nombre IN VARCHAR2,
    p_apellido IN VARCHAR2,
    p_email IN VARCHAR2
)
AS /*Despues de el AS viene la declaracion de variables*/

BEGIN
    INSERT INTO CLIENTE(RUT, NOMBRE, APELLIDO, EMAIL) /*van los nombres de las columnas*/
    VALUES (p_rut, p_nombre, p_apellido, p_email);
    COMMIT;
    DBMS_OUTPUT.PUT_LINE("Usuario registrado.");
END insertar_cliente;
/

/*se puede invocar en cualquier parte,
en otro procedimiento, funciones, bloques, etc.*/

-- ACTIVIDAD--
--retornar los datos de un cliente segun su id--
CREATE OR REPLACE PROCEDURE buscarClientePorId(
    p_cliente_id IN NUMBER,
    p_nombre OUT VARCHAR2,
    p_apellido OUT VARCHAR2,
    p_email OUT VARCHAR2,
    p_telefono OUT VARCHAR2
)IS
BEGIN
    SELECT nombre, apellido, email, telefono INTO p_nombre,
    p_apellido, p_email, p_telefono
    FROM
    WHERE

END buscarClientePorId;
/

/*estudiar funciones para el miercoles 23-09*/