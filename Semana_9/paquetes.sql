-- ==========================================
-- 1. ESPECIFICACIÓN (Lo público: Solo declaras qué existe)
-- ==========================================
CREATE OR REPLACE PACKAGE PKG_PLANTILLA_GENERAL IS
    -- Declaración de variables globales o constantes
    V_GLOBAL_TASA NUMBER := 1.19;
    
    -- Declaración de firmas de Procedimientos y Funciones
    PROCEDURE SP_PROCESAR_DATO (P_ID_ENTRADA IN NUMBER);
    FUNCTION FN_CALCULAR_VALOR (P_MONTO IN NUMBER) RETURN NUMBER;
END PKG_PLANTILLA_GENERAL;
/

-- ==========================================
-- 2. CUERPO (Lo privado: Aquí va la lógica real)
-- ==========================================
CREATE OR REPLACE PACKAGE BODY PKG_PLANTILLA_GENERAL IS

    -- Función pública (Desarrollo)
    FUNCTION FN_CALCULAR_VALOR (P_MONTO IN NUMBER) RETURN NUMBER IS
        V_RESULTADO NUMBER;
    BEGIN
        IF P_MONTO IS NULL OR P_MONTO <= 0 THEN
            RETURN 0;
        END IF;
        
        V_RESULTADO := P_MONTO * V_GLOBAL_TASA;
        RETURN V_RESULTADO;
    EXCEPTION
        WHEN OTHERS THEN
            RETURN -1;
    END FN_CALCULAR_VALOR;

    -- Procedimiento público (Desarrollo)
    PROCEDURE SP_PROCESAR_DATO (P_ID_ENTRADA IN NUMBER) IS
        V_CALCULO_TEMP NUMBER;
    BEGIN
        -- Puedes usar la función dentro del mismo paquete
        V_CALCULO_TEMP := FN_CALCULAR_VALOR(1000);
        
        UPDATE TABLA_GENERICA 
        SET COLUMNA_VALOR = V_CALCULO_TEMP 
        WHERE ID_PK = P_ID_ENTRADA;
        
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Proceso exitoso para el ID: ' || P_ID_ENTRADA);
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('Error: El dato no existe.');
        WHEN OTHERS THEN
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE('Error grave: ' || SQLERRM);
    END SP_PROCESAR_DATO;

END PKG_PLANTILLA_GENERAL;
/