CREATE OR REPLACE TRIGGER TRG_PLANTILLA_AUDITORIA
AFTER INSERT OR UPDATE OR DELETE ON TABLA_A_VIGILAR
FOR EACH ROW -- Se ejecuta fila por fila
DECLARE
    -- Variables útiles para la auditoría
    v_usuario VARCHAR2(50) := USER;
    v_fecha DATE := SYSDATE;
BEGIN
    -- Si el usuario está INSERANDO datos nuevos (:NEW)
    IF INSERTING THEN
        INSERT INTO TABLA_AUDITORIA (accion, id_afectado, fecha, usuario_bd)
        VALUES ('INSERCIÓN NUEVA', :NEW.id_pk, v_fecha, v_usuario);
        
    -- Si el usuario está ACTUALIZANDO datos (:OLD vs :NEW)
    ELSIF UPDATING THEN
        -- Podemos comparar si un dato específico cambió
        IF :OLD.estado <> :NEW.estado THEN
            INSERT INTO TABLA_AUDITORIA (accion, id_afectado, fecha, usuario_bd)
            VALUES ('CAMBIO DE ESTADO: ' || :OLD.estado || ' a ' || :NEW.estado, :NEW.id_pk, v_fecha, v_usuario);
        END IF;
        
    -- Si el usuario está ELIMINANDO datos (:OLD)
    ELSIF DELETING THEN
        INSERT INTO TABLA_AUDITORIA (accion, id_afectado, fecha, usuario_bd)
        VALUES ('ELIMINACIÓN DE REGISTRO', :OLD.id_pk, v_fecha, v_usuario);
    END IF;

EXCEPTION
    WHEN OTHERS THEN
        -- Imprimir error (Ojo: Los triggers de producción no suelen llevar DBMS_OUTPUT, pero para el quiz es excelente)
        DBMS_OUTPUT.PUT_LINE('Error en el Trigger de Auditoría: ' || SQLERRM);
END TRG_PLANTILLA_AUDITORIA;
/