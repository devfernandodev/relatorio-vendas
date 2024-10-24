CREATE OR REPLACE TRIGGER trg_vendas
BEFORE INSERT ON vendas
FOR EACH ROW
BEGIN
    :new.id_venda := vendas_seq.NEXTVAL;
END;
