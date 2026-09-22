--declarar cursor
DECLARE
    CURSOR c_reservas_vencidas IS
        --seleccion y union de tablas
        SELECT
            c.nombre || ' ' || c.apellido AS nombre_cliente,
            e.nombre AS nombre_evento,
            COUNT(r.reserva_id) AS stock_retenido
        FROM RESERVA_TEMPORAL r
        --se unen las tablas cliente y reserva temporal
        JOIN CLIENTE c ON r.cliente_id = c.cliente_id
        --se unen las tablas localidad evento y reserva temporal
        JOIN LOCALIDAD_EVENTO le ON r.localidad_evento_id = le.localidad_evento_id
        JOIN EVENTO e ON le.evento_id = e.evento_id
        WHERE r.estado = 'ACTIVA'
        AND r.fecha_expiracion < SYSDATE
        GROUP BY c.nombre, c.apellido, e.nombre;
    v_contador_registros NUMBER := 0;
    ex_sin_reservas_ven EXCEPTION;

BEGIN
    DBMS_OUTPUT.PUT_LINE('Reservas vencidas no liberadas');
    FOR reg IN c_reservas_vencidas LOOP
        v_contador_registros := v_contador_registros + 1;
    
    DBMS_OUTPUT.PUT_LINE('Cliente: '||reg.nombre_cliente);
    DBMS_OUTPUT.PUT_LINE('Evento: '||reg.nombre_evento);
    DBMS_OUTPUT.PUT_LINE('Stock a liberar: '||reg.stock_retenido);

    END LOOP;

    IF v_contador_registros = 0 THEN
        RAISE ex_sin_reservas_ven;
    ELSE
        DBMS_OUTPUT.PUT_LINE('Total de reservas retenidas: ' || v_contador_registros);
    END IF;

EXCEPTION
    WHEN ex_sin_reservas_ven THEN
        DBMS_OUTPUT.PUT_LINE('Sin reservas retenidas y activas a la vez');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: '||SQLERRM);
END;
/    