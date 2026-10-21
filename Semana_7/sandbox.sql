CREATE OR REPLACE PROCEDURE SP_PLANTILLA_OPERACION (
    p_id_entrada IN NUMBER,       -- Dato que ingresa el usuario
    p_nombre_salida OUT VARCHAR2  -- Dato que el procedimiento devuelve
) IS
    -- 1. Declaración de variables y excepciones
    v_contador NUMBER := 0;
    EX_ERROR_NEGOCIO EXCEPTION;   -- Excepción personalizada
BEGIN
    DBMS_OUTPUT.PUT_LINE('--- INICIO DEL PROCEDIMIENTO ---');

    -- 2. Lógica principal (Ej: Buscar un dato)
    SELECT columna_nombre INTO p_nombre_salida
    FROM NOMBRE_TABLA
    WHERE id_tabla = p_id_entrada;

    -- 3. Validaciones de negocio (Ej: Lanzar error si algo no cuadra)
    IF p_nombre_salida IS NULL THEN
        RAISE EX_ERROR_NEGOCIO;
    END IF;

    -- 4. Confirmar transacción (si hiciste INSERT/UPDATE)
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Proceso ejecutado correctamente para el ID: ' || p_id_entrada);

EXCEPTION
    -- 5. Manejo de errores
    WHEN NO_DATA_FOUND THEN
        p_nombre_salida := 'No existe';
        DBMS_OUTPUT.PUT_LINE('Error: El ID ingresado no existe en la base de datos.');
    WHEN EX_ERROR_NEGOCIO THEN
        DBMS_OUTPUT.PUT_LINE('Error: No se cumplió la regla de negocio.');
    WHEN OTHERS THEN
        ROLLBACK; -- Deshacer cambios si hay un error grave
        DBMS_OUTPUT.PUT_LINE('Error inesperado: ' || SQLERRM);
END SP_PLANTILLA_OPERACION;
/