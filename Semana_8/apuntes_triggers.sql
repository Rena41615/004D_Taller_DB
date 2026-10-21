/*
Triggers -> DML
            ->INSERT -> :NEW
            ->UPDATE -> :OLD
                     -> :NEW
            ->DELETE -> :OLD
*/

CREATE OR REPLACE TRIGGER trg_auditoria_tabla
AFTER INSERT OR UPDATE ON NOMBRE_TABLA
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        DBMS_OUTPUT.PUT_LINE('Se insertó un nuevo registro: ' || :NEW.id_columna);
    ELSIF UPDATING THEN
        DBMS_OUTPUT.PUT_LINE('Se actualizó el registro de: ' || :OLD.id_columna || ' a ' || :NEW.id_columna);
    END IF;
END;
/

--Los triggers automatizan acciones de fondo, en los controles suelen pedir que actualices un dato automáticamente usando
--los modificadores :NEW y :OLD.

CREATE OR REPLACE TRIGGER TRG_AUDITORIA_TABLA
AFTER INSERT OR UPDATE ON TABLA_PRINCIPAL
FOR EACH ROW
DECLARE
    -- Variables si necesitas hacer cálculos antes de registrar
    v_usuario VARCHAR2(50) := USER;
BEGIN
    IF INSERTING THEN
        -- Insertar en una tabla de bitácora el nuevo registro
        INSERT INTO TABLA_AUDITORIA (accion, id_afectado, fecha, usuario)
        VALUES ('INSERCIÓN', :NEW.id_pk, SYSDATE, v_usuario);
        
    ELSIF UPDATING THEN
        -- Comparar valores viejos y nuevos
        IF :OLD.estado <> :NEW.estado THEN
            INSERT INTO TABLA_AUDITORIA (accion, id_afectado, fecha, usuario)
            VALUES ('CAMBIO ESTADO: ' || :OLD.estado || ' a ' || :NEW.estado, :NEW.id_pk, SYSDATE, v_usuario);
        END IF;
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        -- Ojo: Generalmente los triggers no deberían usar DBMS_OUTPUT, pero evita que la DB falle en un quiz.
        DBMS_OUTPUT.PUT_LINE('Error en el trigger: ' || SQLERRM);
END;
/