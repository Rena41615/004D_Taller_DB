SET SERVEROUTPUT ON; 
DECLARE 
    v_filtro DATE := TO_DATE('15-09-2026', 'DD-MM-YYYY'); 
    
    -- 1. Cursor Externo (Maestro) con parámetro
    CURSOR c_maestro (p_filtro DATE) IS 
        SELECT id_maestro, nombre_maestro 
        FROM TABLA_MAESTRA 
        WHERE TRUNC(fecha_columna) = p_filtro; 
        
    -- 2. Cursor Interno (Detalle) que recibe el ID del maestro
    CURSOR c_detalle (p_id_maestro NUMBER) IS 
        SELECT detalle_info 
        FROM TABLA_DETALLE 
        WHERE id_maestro = p_id_maestro; 
        
    -- 3. Declaración de Excepción Personalizada
    ex_sin_detalles EXCEPTION; 
    v_contador NUMBER; 
    
BEGIN 
    DBMS_OUTPUT.PUT_LINE('--- REPORTE ANIDADO ---'); 
    
    -- 4. Primer Loop (Recorre los maestros)
    FOR reg_maestro IN c_maestro(v_filtro) LOOP 
        DBMS_OUTPUT.PUT_LINE('Maestro: ' || reg_maestro.nombre_maestro); 
        
        v_contador := 0; 
        
        -- 5. Segundo Loop (Recorre los detalles de ese maestro)
        FOR reg_detalle IN c_detalle(reg_maestro.id_maestro) LOOP 
            DBMS_OUTPUT.PUT_LINE('- Detalle: ' || reg_detalle.detalle_info); 
            v_contador := v_contador + 1; 
        END LOOP; 
        
        -- 6. Disparar excepción si un maestro no tiene detalles
        IF v_contador = 0 THEN 
            RAISE ex_sin_detalles; 
        END IF; 
        
    END LOOP; 
    
EXCEPTION 
    WHEN ex_sin_detalles THEN 
        DBMS_OUTPUT.PUT_LINE('Excepción activada: Un registro maestro no tiene detalles asociados.'); 
    WHEN OTHERS THEN 
        DBMS_OUTPUT.PUT_LINE('Error inesperado: ' || SQLERRM); 
END; 
/