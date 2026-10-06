--se sigue trabajando con punto ticket
--validación previa
--ver si quedan entradas (obtener stock de entradas) > 0 vendo, ! no puedo vender
--tener una función que me devuelva la cantidad de entradas de una función en concreto ()
--tener la localidad y el stock de entradas, se debe vender
--se descuenta el stock (UPDATE STOCK_DISPONIBLE = STOCK_DISPONIBLE - Entradas_que_Compre)

--1. Determina el SPEC, que funciones o procedimientos estan en este pkg

CREATE OR REPLACE PACKAGE pkg_boleteria
AS
    g_total_entradas_vendidas NUMBER;
    --El spec o la firma de mi funcion
    FUNCTION fn_verificar_stock(p_localidad_evento_id IN NUMBER) RETURN NUMBER;
    PROCEDURE sp_actualizar_stock(p_localidad_evento_id IN NUMBER, p_entradas_vendidas IN NUMBER);
END pkg_boleteria;
/

--Ya tenemos delcaro el spec, ahora vamos con el body
CREATE OR REPLACE PACKAGE BODY pkg_boleteria
    AS
        --Declarando el body de mi funcion, es decir la lógica
        FUNCTION fn_verificar_stock(p_localidad_evento_id IN NUMBER) RETURN NUMBER
        AS
            v_stock NUMBER;
        BEGIN
            SELECT STOCK_DISPONIBLE INTO v_stock FROM LOCALIDAD_EVENTO WHERE LOCALIDAD_EVENTO_ID = p_localidad_evento_id;
            RETURN v_stock;
        END fn_verificar_stock;
        --Declarar el body de mi PROCEDURE
        PROCEDURE sp_actualizar_stock(p_localidad_evento_id IN NUMBER, p_entradas_vendidas IN NUMBER)
        AS
            v_stock NUMBER;
        BEGIN
        v_stock := fn_verificar_stock(p_localidad_evento_id);

        IF v_stock <0 THEN
            RAISE_APPLICATION_ERROR(-20001, 'Sin entradas disponibles para el evento solicitado');
        END IF;

        UPDATE LOCALIDAD_EVENTO SET STOCK_DISPONIBLE = STOCK_DISPONIBLE - p_entradas_vendidas
        WHERE LOCALIDAD_EVENTO_ID = p_localidad_evento_id;

        g_total_entradas_vendidas := g_total_entradas_vendidas + p_entradas_vendidas;
    END sp_actualizar_stock;
END pkg_boleteria;
/