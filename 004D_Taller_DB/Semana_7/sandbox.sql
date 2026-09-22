BEGIN 
    insertar_cliente('19.949.132.3', NULL, 'Sanhueza', 'msangueza@gmail.com', '973846578');
END;
/

--Buscar clientes por id. REGRESA!!! parametros de salida
DECLARE
    v_nombre CLIENTE.NOMBRE%TYPE;
    v_apellido CLIENTE.APELLIDO%TYPE;
    v_email CLIENTE.EMAIL%TYPE;
    v_telefono CLIENTE.TELEFONO%TYPE;
BEGIN
    buscarClientePorId(2, v_nombre, v_apellido, v_email, v_telefono);
    DBMS_OUTPUT.PUT_LINE('Cliente' || v_nombre || ' ' || v_apellido || ' ' || v_email || ' ' || v_telefono);
END;
/