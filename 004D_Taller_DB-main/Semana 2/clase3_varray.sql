--VARRAY: permite guardar una lista de datos del mismo tipo
--Rellenar un VARRAY de forma NO PROCEDURAL

DECLARE
    --Podemos crear nuetro propio tipo de dato personalizado
    TYPE numero_asiento IS VARRAY(6) OF VARCHAR2(3);
    --Se refiere a que puedo guardar hasta 6 datos
    
    --Los parentesis de abajo son el metodo constructor
    v_asiento numero_asiento := numero_asiento('A01', 'A02', 'A03', 'A04', 'A05', 'A06');

BEGIN
    --El VARRAY es especial, la 1ra posicion de los indices parte del 1, no del 0
    DBMS_OUTPUT.PUT_LINE('Se ha asignado el asiento N° '|| v_asiento(3));
    NULL;
END;
/

--Ejemplo del profesor donde se deben almacenar 3 rut
DECLARE
    TYPE rut IS VARRAY(3) OF VARCHAR2(12);

    v_rut rut := rut('22.222.222-2', '11.111.111-1', '33.333.333-3');
BEGIN
    DBMS_OUTPUT.PUT_LINE('Un rut cualquiera: '|| v_rut(1));
    DBMS_OUTPUT.PUT_LINE('Un rut cualquiera: '|| v_rut(2));
    DBMS_OUTPUT.PUT_LINE('Un rut cualquiera: '|| v_rut(3));
    NULL;
END;
/

--Como sería de manera procedural?
DECLARE
    TYPE rut_usuarios IS VARRAY(3) OF VARCHAR2(12);

    v_rut rut_usuarios := rut_usuarios();
BEGIN
    v_rut.EXTEND;
    v_rut(1) := '11.111.111-1';

    v_rut.EXTEND;
    v_rut(2) := '22.222.222-2';

    v_rut.EXTEND;
    v_rut(3) := '33.333.333-3';

    DBMS_OUTPUT.PUT_LINE('Un rut cualquiera: '|| v_rut(1));
    DBMS_OUTPUT.PUT_LINE('Un rut cualquiera: '|| v_rut(2));
    DBMS_OUTPUT.PUT_LINE('Un rut cualquiera: '|| v_rut(3));
    
    NULL;
END;
/