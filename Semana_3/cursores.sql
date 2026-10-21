SET SERVEROUTPUT ON;
DECLARE
    -- 1. Cursor Maestro (Ej: Categorías, Clientes, Médicos)
    CURSOR C_MAESTRO IS
        SELECT ID_MAESTRO, NOMBRE_MAESTRO 
        FROM TABLA_MAESTRA;
        
    -- 2. Cursor Detalle parametrizado (Depende del ID del maestro)
    CURSOR C_DETALLE (P_ID_MAESTRO NUMBER) IS
        SELECT DATO_DETALLE 
        FROM TABLA_DETALLE 
        WHERE ID_MAESTRO_FK = P_ID_MAESTRO;
        
    V_CONTADOR NUMBER;
    EX_SIN_DETALLES EXCEPTION; -- Excepción personalizada
BEGIN
    DBMS_OUTPUT.PUT_LINE('--- INICIO DEL REPORTE MASIVO ---');
    
    -- Recorremos a los maestros
    FOR REG_M IN C_MAESTRO LOOP
        DBMS_OUTPUT.PUT_LINE('===================================');
        DBMS_OUTPUT.PUT_LINE('MAESTRO: ' || REG_M.NOMBRE_MAESTRO);
        
        V_CONTADOR := 0;
        
        -- Recorremos los detalles de ese maestro en particular
        FOR REG_D IN C_DETALLE(REG_M.ID_MAESTRO) LOOP
            DBMS_OUTPUT.PUT_LINE('  - Detalle: ' || REG_D.DATO_DETALLE);
            V_CONTADOR := V_CONTADOR + 1;
        END LOOP;
        
        -- Si el maestro no tiene detalles, disparamos alerta
        IF V_CONTADOR = 0 THEN
            RAISE EX_SIN_DETALLES;
        END IF;
    END LOOP;
    
EXCEPTION
    WHEN EX_SIN_DETALLES THEN
        DBMS_OUTPUT.PUT_LINE('Alerta: Un registro principal no tiene información detallada asociada.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error inesperado: ' || SQLERRM);
END;
/