/*Inspeccionar tablas, nos sirve cliente, transaccion_pago y reserva_temporal*/
SELECT * FROM CLIENTE;
SELECT * FROM TRANSACCION_PAGO;
SELECT * FROM RESERVA_TEMPORAL;

/*Realizado junto al profesor*/

DECLARE
    TYPE boleta_cliente IS RECORD(
        nombre_cliente CLIENTE.NOMBRE%TYPE,
        estado_reserva RESERVA_TEMPORAL.ESTADO%TYPE,
        monto_bruto TRANSACCION_PAGO.MONTO_BRUTO%TYPE,
        descuento_transaccion TRANSACCION_PAGO.DESCUENTO%TYPE,
        monto_final TRANSACCION_PAGO.MONTO_FINAL%TYPE,
        estado_transaccion TRANSACCION_PAGO.ESTADO%TYPE
    );
BEGIN
    SELECT C.NOMBRE, RT.ESTADO AS ESTADO_RESERVA, TP.MONTO_BRUTO, TP.DESCUENTO, TP.MONTO_FINAL, TP.ESTADO AS ESTADO_TRANSACCION
    INTO  v_boleta.nombre_cliente, v_boleta.estado_reserva, v_boleta.monto_bruto, v_boleta.descuento_transaccion, v_boleta.monto_final,v_boleta.estado_transaccion
    FROM CLIENTE C
    INNER JOIN RESERVA_TEMPORAL RT ON C.CLIENTE_ID = RT.CLIENTE_ID
    INNER JOIN TRANSACCION_PAGO RT ON TP.RESERVA_ID = RT.RESERVA_ID
    WHERE C.CLIENTE_ID = 1;

    DBMS_OUTPUT.PUT_LINE('************BOLETA PUNTO TICKET************');
    DBMS_OUTPUT.PUT_LINE('Nombre Cliente: '|| v_boleta.nombre_cliente);
    DBMS_OUTPUT.PUT_LINE('');
    DBMS_OUTPUT.PUT_LINE('');
    DBMS_OUTPUT.PUT_LINE('');
    DBMS_OUTPUT.PUT_LINE('');
    DBMS_OUTPUT.PUT_LINE('');

    null;
END;

/*Lo que hice yo
SELECT C.NOMBRE, TP.MONTO_BRUTO, TP.DESCUENTO, TP.MONTO_FINAL, TP.ESTADO
FROM CLIENTE C, TRANSACCION_PAGO TP
INNER JOIN RESERVA_TEMPORAL RT ON RT.RESERVA_ID = TP.RESERVA_ID
ORDER BY;
*/