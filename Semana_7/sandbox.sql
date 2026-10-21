--reporte masivo o un cruce de datos complejo (como listar torneos y sus asistentes)
CREATE OR REPLACE PROCEDURE SP_REPORTE_ANIDADO (p_fecha_filtro DATE) IS
    -- Cursor Principal (Maestro)
    CURSOR c_maestro IS
        SELECT id_maestro, nombre_maestro 
        FROM TABLA_MAESTRA 
        WHERE TRUNC(fecha) = p_fecha_filtro;
        
    -- Cursor Secundario (Detalle) que recibe el ID del maestro
    CURSOR c_detalle (p_id NUMBER) IS
        SELECT detalle_info 
        FROM TABLA_DETALLE 
        WHERE id_maestro = p_id;
        
    v_contador NUMBER := 0;
    EX_SIN_REGISTROS EXCEPTION; -- Excepción personalizada
BEGIN
    DBMS_OUTPUT.PUT_LINE('--- INICIO DEL REPORTE ---');

    FOR reg_m IN c_maestro LOOP
        DBMS_OUTPUT.PUT_LINE('Maestro: ' || reg_m.nombre_maestro);
        
        FOR reg_d IN c_detalle(reg_m.id_maestro) LOOP
            DBMS_OUTPUT.PUT_LINE(' - Detalle: ' || reg_d.detalle_info);
            v_contador := v_contador + 1;
        END LOOP;
    END LOOP;

    -- Disparar excepción si no hubo resultados en total
    IF v_contador = 0 THEN
        RAISE EX_SIN_REGISTROS;
    END IF;

EXCEPTION
    WHEN EX_SIN_REGISTROS THEN
        DBMS_OUTPUT.PUT_LINE('Alerta: No se encontraron registros para la fecha procesada.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END SP_REPORTE_ANIDADO;
/