CREATE TABLE vendas (
    id_venda NUMBER PRIMARY KEY,
    id_produto NUMBER,
    data_venda DATE,
    quantidade NUMBER,
    FOREIGN KEY (id_produto) REFERENCES produtos(id_produto)
);
