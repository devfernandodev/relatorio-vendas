CREATE OR REPLACE PROCEDURE registrar_venda (
    p_id_produto   IN NUMBER,
    p_data_venda   IN DATE,
    p_quantidade   IN NUMBER
) IS
    v_estoque NUMBER;   -- Variável para armazenar o estoque atual
    v_count   NUMBER;   -- Variável para verificar se o produto existe
BEGIN
    -- Verifica se o produto existe
    SELECT COUNT(*)
    INTO v_count
    FROM produtos
    WHERE id_produto = p_id_produto;

    IF v_count = 0 THEN
        -- Se o produto não for encontrado, exibe uma mensagem de erro
        DBMS_OUTPUT.PUT_LINE('Erro: Produto com ID ' || p_id_produto || ' não encontrado.');
    ELSE
        -- Se o produto existe, verificar o estoque atual
        SELECT estoque
        INTO v_estoque
        FROM produtos
        WHERE id_produto = p_id_produto;

        DBMS_OUTPUT.PUT_LINE('Estoque atual antes da venda: ' || v_estoque);

        IF p_quantidade <= v_estoque THEN
            -- Atualizar estoque
            UPDATE produtos
            SET estoque = estoque - p_quantidade
            WHERE id_produto = p_id_produto;

            -- Confirmar atualização do estoque
            SELECT estoque INTO v_estoque
            FROM produtos
            WHERE id_produto = p_id_produto;

            DBMS_OUTPUT.PUT_LINE('Estoque atual após a venda: ' || v_estoque);

            -- Inserir venda
            INSERT INTO vendas (id_venda, id_produto, data_venda, quantidade)
            VALUES (sequencia_vendas.NEXTVAL, p_id_produto, p_data_venda, p_quantidade);

            DBMS_OUTPUT.PUT_LINE('Venda registrada para o produto ' || p_id_produto || ', quantidade: ' || p_quantidade);
            COMMIT;
        ELSE
            -- Se a quantidade vendida exceder o estoque
            DBMS_OUTPUT.PUT_LINE('Erro: A quantidade solicitada excede o estoque disponível.');
        END IF;
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro inesperado: ' || SQLERRM);
        ROLLBACK;
END;
/
