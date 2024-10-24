CREATE FUNCTION relatorio_vendas_diarias (
    p_data IN DATE
) RETURN SYS_REFCURSOR IS
    v_cursor SYS_REFCURSOR;
BEGIN
    OPEN v_cursor FOR
        SELECT p.nome, SUM(v.quantidade) AS quantidade_vendida
        FROM vendas v
        JOIN produtos p ON v.id_produto = p.id_produto
        WHERE v.data_venda = p_data
        GROUP BY p.nome;
    RETURN v_cursor;
END;
