  V_STOCK LOCALIDAD_EVENTO.STOCK_DISPONIBLE%TYPE;
BEGIN
  SELECT STOCK_DISPONIBLE INTO V_STOCK
  FROM LOCALIDAD_EVENTO
  WHERE LOCALIDAD_EVENTO_ID = 1;
  IF V_STOCK <= THEN
    RAISE_APPLICATION_ERROR(
      -20001,
      'Sin Stock: Entradas agotadas'
    );
  END IF;
  DBMS_OUTPUT.PUT_LINE('Stock disponible: ' || STOCK_DISPONIBLE);
END;
/

--pragma exception
DECLARE
  E_FK_VIOLADA EXCEPTION;
  PRAGMA EXCEPTION_INIT(E_FK_VIOLADA, -2292);
  -- ORA-02292: integrity constraint violated - child record found
BEGIN
  DELETE FROM RECINTO
  WHERE NOMBRE = 'Movistar Arena';

  --Falla porque hay sectores y eventos asociados
EXCEPTION
  WHEN E_FK_VIOLADA THEN
    DBMS_OUTPUT.PUT_LINE('No se puede eliminar, hay datos asociados');
