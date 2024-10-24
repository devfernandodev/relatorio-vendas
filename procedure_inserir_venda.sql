CREATE OR REPLACE PROCEDURE inserir_venda (
    p_id_produto IN NUMBER,
    p_data_venda IN DATE,
    p_quantidade IN NUMBER
) IS
BEGIN
    INSERT INTO vendas (id_produto, data_venda, quantidade) VALUES (p_id_produto, p_data_venda, p_quantidade);
    COMMIT;
END;
