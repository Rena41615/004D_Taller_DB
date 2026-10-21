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