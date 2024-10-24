CREATE FUNCTION comparacao_vendas (
    p_data_inicio1 IN DATE,
    p_data_fim1 IN DATE,
    p_data_inicio2 IN DATE,
    p_data_fim2 IN DATE
) RETURN SYS_REFCURSOR IS
    v_cursor SYS_REFCURSOR;
BEGIN
    OPEN v_cursor FOR
        SELECT p.nome,
               SUM(CASE WHEN v.data_venda BETWEEN p_data_inicio1 AND p_data_fim1 THEN v.quantidade ELSE 0 END) AS vendas_periodo1,
               SUM(CASE WHEN v.data_venda BETWEEN p_data_inicio2 AND p_data_fim2 THEN v.quantidade ELSE 0 END) AS vendas_periodo2
        FROM vendas v
        JOIN produtos p ON v.id_produto = p.id_produto
        GROUP BY p.nome;
    RETURN v_cursor;
END;
