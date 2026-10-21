--ejemplo de funcion para el cuadrado de un numero

CREATE OR REPLACE FUNCTION calcular_cuadrado(
    p_numero IN NUMBER
) RETURN NUMBER
AS
    v_resultado NUMBER;
BEGIN
    v_resultado := p_numero * p_numero;
    RETURN v_resultado;
END;
/

SELECT * FROM DUAL; 

--actividad
--agarrar de transaccion pago el monto bruto y aplicarle le descuento de lo que esta
--en la tabla convenio banco
--solucion que estaba haciendo
CREATE OR REPLACE FUNCTION calcular_descuento(
    p_descuento IN NUMBER,
    p_monto_bruto IN NUMBER
) RETURN NUMBER
AS
    v_monto_bruto NUMBER;
    v_descuento_aplicado NUMBER;
BEGIN
    v_descuento_aplicado := v_monto_bruto * p_descuento / 100;
    RETURN v_monto_bruto - v_descuento_aplicado;
END;
/

--solucion del profesor
--revisar primero las tablas

SELECT * FROM CONVENIO_BANCO WHERE CONVENIO_BANCO_ID = 1 AND ACTIVO = 'S';
CREATE OR REPLACE FUNCTION aplicar_descuento(
    p_id_banco IN NUMBER,
    p_monto_bruto IN NUMBER
) RETURN NUMBER
IS     
    v_descuento_banco NUMBER;
    v_precio final NUMBER;
BEGIN
    SELECT DESCUENTO_PORCENTAJE INTO v_descuento_banco FROM
    CONVENIO_BANCO WHERE CONVENIO_BANCO_ID = p_id_banco AND ACTIVO = 'S';

    v_precio_final := p_monto_bruto - (p_monto_bruto * v_descuento_banco) / 100;
    return v_precio_final;
END;
/

SELECT aplicar_descuento(1, 10000) AS TOTAL_A_PAGAR FROM DUAL;

DECLARE
    v_monto_a_pagar NUMBER;
BEGIN
    v_monto_a_pagar := aplicar_descuento(1,10000);
    DBMS_OUTPUT.PUT_LINE('El monto a pagar: ' || v_monto_a_pagar);
END;
/

--Úsala cuando te pidan calcular multas, días de atraso o promedios para poder
--utilizarla dentro de un SELECT tradicional

CREATE OR REPLACE FUNCTION FN_CALCULAR_DIAS (p_fecha_inicio DATE, p_fecha_fin DATE) 
RETURN NUMBER IS
    v_dias NUMBER;
BEGIN
    -- Validamos nulos para evitar errores
    IF p_fecha_inicio IS NULL OR p_fecha_fin IS NULL THEN
        RETURN 0;
    END IF;

    -- Lógica matemática (Ejemplo: diferencia de días)
    v_dias := TRUNC(p_fecha_fin) - TRUNC(p_fecha_inicio);
    
    RETURN v_dias;
EXCEPTION
    WHEN OTHERS THEN
        RETURN -1; -- Código de error estándar
END FN_CALCULAR_DIAS;
/