CREATE OR REPLACE FUNCTION fn_calcular_algo (p_parametro NUMBER) 
RETURN NUMBER IS
    v_resultado NUMBER;
BEGIN
    -- Tu lógica matemática o SELECT aquí
    v_resultado := p_parametro * 1.19; 
    RETURN v_resultado;
EXCEPTION
    WHEN OTHERS THEN
        RETURN 0;
END fn_calcular_algo;
/