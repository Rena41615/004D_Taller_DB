-- ==========================================
-- PARTE 1: ESPECIFICACIÓN (Lo público)
-- ==========================================
CREATE OR REPLACE PACKAGE PKG_PLANTILLA_NEGOCIO IS
    -- Solo declaramos los nombres, no la lógica
    PROCEDURE SP_ACTUALIZAR_ESTADO (p_id NUMBER);
    FUNCTION FN_OBTENER_TOTAL (p_cantidad NUMBER) RETURN NUMBER;
END PKG_PLANTILLA_NEGOCIO;
/

-- ==========================================
-- PARTE 2: CUERPO (Lo privado y el desarrollo)
-- ==========================================
CREATE OR REPLACE PACKAGE BODY PKG_PLANTILLA_NEGOCIO IS
    
    -- Elemento Privado: Nadie fuera del package puede ver o usar esta constante
    C_IMPUESTO CONSTANT NUMBER := 0.19;

    -- Desarrollo de la Función Pública
    FUNCTION FN_OBTENER_TOTAL (p_cantidad NUMBER) RETURN NUMBER IS
        v_calculo NUMBER;
    BEGIN
        v_calculo := p_cantidad + (p_cantidad * C_IMPUESTO);
        RETURN v_calculo;
    EXCEPTION
        WHEN OTHERS THEN
            RETURN 0;
    END FN_OBTENER_TOTAL;

    -- Desarrollo del Procedimiento Público
    PROCEDURE SP_ACTUALIZAR_ESTADO (p_id NUMBER) IS
    BEGIN
        UPDATE NOMBRE_TABLA 
        SET estado = 'ACTUALIZADO' 
        WHERE id_columna = p_id;
        
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Se actualizó el ID: ' || p_id);
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
    END SP_ACTUALIZAR_ESTADO;

END PKG_PLANTILLA_NEGOCIO;
/