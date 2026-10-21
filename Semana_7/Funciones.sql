CREATE OR REPLACE FUNCTION FN_PLANTILLA_CALCULO (
    p_valor_base NUMBER,
    p_porcentaje NUMBER
) RETURN NUMBER IS
    -- 1. Variable para guardar el resultado que vamos a retornar
    v_resultado NUMBER;
BEGIN
    -- 2. Validar que no nos pasen datos nulos (Evita que el programa se caiga)
    IF p_valor_base IS NULL OR p_porcentaje IS NULL THEN
        RETURN 0; 
    END IF;

    -- 3. Cálculo matemático
    v_resultado := p_valor_base + (p_valor_base * (p_porcentaje / 100));

    -- 4. Retornar el valor final
    RETURN v_resultado;

EXCEPTION
    -- 5. Retorno de seguridad si algo falla
    WHEN OTHERS THEN
        RETURN -1; 
END FN_PLANTILLA_CALCULO;
/