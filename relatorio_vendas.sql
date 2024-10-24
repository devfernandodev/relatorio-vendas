CREATE OR REPLACE PROCEDURE relatorio_vendas IS
BEGIN
    FOR rec IN (
        SELECT p.nome AS produto,
               p.categoria,
               p.preco,
               v.data_venda,
               v.quantidade
        FROM produtos p
        JOIN vendas v ON p.id_produto = v.id_produto
        ORDER BY v.data_venda DESC  -- Ordenar por data da venda
    ) LOOP
        DBMS_OUTPUT.PUT_LINE('Produto: ' || rec.produto || 
                             ', Categoria: ' || rec.categoria ||
                             ', Pre�o: R$ ' || rec.preco || 
                             ', Data da Venda: ' || TO_CHAR(rec.data_venda, 'DD/MM/YYYY') || 
                             ', Quantidade: ' || rec.quantidade);
    END LOOP;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro ao gerar relat�rio: ' || SQLERRM);
END;
/
