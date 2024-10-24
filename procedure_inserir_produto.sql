CREATE OR REPLACE PROCEDURE inserir_produto (
    p_id_produto   IN NUMBER,
    p_nome         IN VARCHAR2,
    p_categoria    IN VARCHAR2,
    p_preco        IN NUMBER,
    p_estoque      IN NUMBER
) IS
    v_count NUMBER;  -- Variável para armazenar o resultado da contagem
BEGIN
    -- Verifica se o produto já existe
    SELECT COUNT(*)
    INTO v_count
    FROM produtos
    WHERE id_produto = p_id_produto;

    IF v_count > 0 THEN
        -- Se o produto já existe, exibe uma mensagem
        DBMS_OUTPUT.PUT_LINE('Produto já existente com ID: ' || p_id_produto);
    ELSE
        -- Se o produto não existir, insere um novo produto
        INSERT INTO produtos (id_produto, nome, categoria, preco, estoque)
        VALUES (p_id_produto, p_nome, p_categoria, p_preco, p_estoque);
        
        DBMS_OUTPUT.PUT_LINE('Novo produto inserido com ID: ' || p_id_produto);
        COMMIT;
    END IF;
END;
/
