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

--==================================================--
--Los packages son contenedores que agrupan lógicamente tu código. En el quiz te pedirán distinguir
--entre lo que el usuario puede ejecutar (público) y lo que está oculto (privado)
--==================================================--

-- 1. ESPECIFICACIÓN (Lo público: Solo se declaran los nombres)
CREATE OR REPLACE PACKAGE PKG_NOMBRE_NEGOCIO IS
    -- Declaración de variables globales o procedimientos/funciones públicas
    PROCEDURE SP_ACTUALIZACION_MASIVA (p_parametro_id NUMBER);
    FUNCTION FN_CALCULO_ESPECIFICO (p_valor NUMBER) RETURN NUMBER;
END PKG_NOMBRE_NEGOCIO;
/

-- 2. CUERPO (Lo privado y la lógica interna)
CREATE OR REPLACE PACKAGE BODY PKG_NOMBRE_NEGOCIO IS
    -- Variable/Constante privada (No se puede ver ni modificar desde afuera)
    C_IMPUESTO CONSTANT NUMBER := 0.19;

    -- Desarrollo de la Función (Retorna un valor)
    FUNCTION FN_CALCULO_ESPECIFICO (p_valor NUMBER) RETURN NUMBER IS
        v_resultado NUMBER;
    BEGIN
        v_resultado := p_valor + (p_valor * C_IMPUESTO);
        RETURN v_resultado;
    EXCEPTION
        WHEN OTHERS THEN
            RETURN 0; -- Valor seguro en caso de error
    END FN_CALCULO_ESPECIFICO;

    -- Desarrollo del Procedimiento (Ejecuta una acción)
    PROCEDURE SP_ACTUALIZACION_MASIVA (p_parametro_id NUMBER) IS
        v_total NUMBER;
    BEGIN
        -- El procedimiento puede consumir la función privada de arriba
        v_total := FN_CALCULO_ESPECIFICO(1000);
        
        UPDATE NOMBRE_TABLA 
        SET columna_total = v_total 
        WHERE id_tabla = p_parametro_id;
        
        DBMS_OUTPUT.PUT_LINE('Actualización exitosa para el ID: ' || p_parametro_id);
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error inesperado: ' || SQLERRM);
    END SP_ACTUALIZACION_MASIVA;

END PKG_NOMBRE_NEGOCIO;
/