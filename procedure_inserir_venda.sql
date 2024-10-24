CREATE OR REPLACE PROCEDURE inserir_produto_e_venda (
    p_id_produto IN NUMBER,
    p_nome IN VARCHAR2,
    p_categoria IN VARCHAR2,
    p_preco IN NUMBER,
    p_estoque IN NUMBER,
    p_data_venda IN DATE,
    p_quantidade IN NUMBER
) IS
BEGIN
    -- Verifica se o produto já existe
    BEGIN
        INSERT INTO produtos (id_produto, nome, categoria, preco, estoque) 
        VALUES (p_id_produto, p_nome, p_categoria, p_preco, p_estoque);
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            -- Se o produto já existe, apenas ignora o erro
            NULL;
    END;

    -- Atualiza o estoque do produto antes de inserir a venda
    UPDATE produtos 
    SET estoque = estoque - p_quantidade
    WHERE id_produto = p_id_produto;
    
    -- Insere a venda
    INSERT INTO vendas (id_produto, data_venda, quantidade) 
    VALUES (p_id_produto, p_data_venda, p_quantidade);
    COMMIT;
END;
