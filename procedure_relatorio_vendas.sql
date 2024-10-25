CREATE OR REPLACE PROCEDURE relatorio_vendas IS
   CURSOR c_vendas IS
      SELECT p.nome,
             p.categoria,
             p.preco,
             v.data_venda,
             v.quantidade,
             p.estoque - v.quantidade AS estoque_restante
        FROM vendas v
        JOIN produtos p ON v.id_produto = p.id_produto
        ORDER BY v.data_venda DESC; -- Ordenar pela data da venda

   v_nome produtos.nome%TYPE;
   v_categoria produtos.categoria%TYPE;
   v_preco produtos.preco%TYPE;
   v_data_venda vendas.data_venda%TYPE;
   v_quantidade vendas.quantidade%TYPE;
   v_estoque_restante NUMBER;

BEGIN
   OPEN c_vendas;
   DBMS_OUTPUT.PUT_LINE('Relatório de Vendas');
   DBMS_OUTPUT.PUT_LINE('====================');
   DBMS_OUTPUT.PUT_LINE('Produto                   | Categoria         | Preço    | Data Venda  | Quantidade | Estoque Restante');
   DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------------------------------------------------------');

   LOOP
      FETCH c_vendas INTO v_nome, v_categoria, v_preco, v_data_venda, v_quantidade, v_estoque_restante;
      EXIT WHEN c_vendas%NOTFOUND;

      DBMS_OUTPUT.PUT_LINE(RPAD(v_nome, 25) || ' | ' || 
                           RPAD(v_categoria, 18) || ' | R$ ' || 
                           TO_CHAR(v_preco, 'FM9999999.00') || ' | ' ||
                           TO_CHAR(v_data_venda, 'DD/MM/YYYY') || ' | ' ||
                           RPAD(v_quantidade, 10) || ' | ' || 
                           v_estoque_restante);
   END LOOP;

   CLOSE c_vendas;
END;
