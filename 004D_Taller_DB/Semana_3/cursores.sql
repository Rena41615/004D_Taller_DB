--cursores simples

--como no es un varray no podemos trabajar con los indices
--una coleccion es como un diccionario

SELECT * FROM CLIENTES;

DECLARE
    CURSOR c_clientes IS 
        SELECT * FROM CLIENTE;

BEGIN
    FOR cada_cliente IN c_clientes LOOP 
        DBMS_OUTPUT.PUT_LINE('Nombre ' || cada_cliente.nombre);
    END LOOP;
    null;
END;
/

--cursores con where

SELECT * FROM CLIENTE
WHERE NOMBRE LIKE '%a%';

DECLARE
    CURSOR c_nombre_a IS
        SELECT * FROM CLIENTE
        WHERE NOMBRE LIKE '%a%';
    --No existe la posicion 0 aqui, es recomendable que los contadores
    --partan de la posicion 1
    v_contador number:= 1;
BEGIN
    FOR nombre_a IN c_nombre_a LOOP
        DBMS_OUTPUT.PUT_LINE('Vuelta: ' || v_contador);
        DBMS_OUTPUT.PUT_LINE('Nombre: ' || nombre_a.NOMBRE); 
        DBMS_OUTPUT.PUT_LINE('Nombre: ' || nombre_a.RUT);
        v_contador:= v_contador + 1;
    END LOOP;
    NULL;
END;
/

--cursos con JOIN
DECLARE
    CURSOR c_transacciones_aprobadas IS
        SELECT
        c.nombre, rt.estado AS ESTADO_DE_LA_RESERVA,
        tp.monto_bruto, tp.descuento, tp.monto_final, tp,estado AS ESTADO_DE_LA_TRANSACCION
        FROM CLIENTE c
        INNER JOIN RESERVA_TEMPORAL rt ON c.CLIENTE_ID= rt.CLIENTE_ID
        INNER JOIN TRANSACCION_PAGO tp ON tp.reserva_id = rt.cliente_id
        WHERE tp.estado = 'APROBADO';
BEGIN
    FOR por_cada_transaccion IN c_transacciones_aprobadas LOOP
    DBMS_OUTPUT.PUT_LINE('NOMBRE: ' || por_cada_transaccion.nombre);
    DBMS_OUTPUT.PUT_LINE('RUT: ' || por_cada_transaccion.RUT);
    DBMS_OUTPUT.PUT_LINE('Monto final: ' || por_cada_transaccion.monto_final);
    DBMS_OUTPUT.PUT_LINE('Estado transaccion' || por_cada_transaccion.ESTADO_DE_LA_TRANSACCION);
    END LOOP;
    NULL;
END;
/

--cursos con parametros - cursores complejos
--antes de, insertemos unos varguitas

INSERT INTO CLIENTE(RUT, NOMBRE, APELLIDO, EMAIL, TELEFONO, FECHA_REGISTRO) 
VALUES('11.111.111-1', 'Fernandito', 'Vargas', 'fvargas@gmail.com', '+56938468236', SYSTIMESTAMP);

INSERT INTO CLIENTE(RUT, NOMBRE, APELLIDO, EMAIL, TELEFONO, FECHA_REGISTRO) 
VALUES('22.111.111-1', 'Juanita', 'Del Solar', 'jdelsolar@gmail.com', '+56983679012', SYSTIMESTAMP);

INSERT INTO CLIENTE(RUT, NOMBRE, APELLIDO, EMAIL, TELEFONO, FECHA_REGISTRO) 
VALUES('11.341.111-1', 'Castaña', 'Rubio', 'crubio@gmail.com', '+56986768970', SYSTIMESTAMP);
SELECT * FROM CLIENTE;

declare
    cursor c_clientes_por_apellido(p_apellido varchar2) is
        select cliente_id, nombre, apellido, EMAIL
        from CLIENTE
        where apellido = p_apellido;
begin
    for un_cliente IN c_clientes_por_apellido('Vargas')
    loop
        DBMS_OUTPUT.PUT_LINE(
            un_cliente.nombre
        );
    END LOOP;
END;
/