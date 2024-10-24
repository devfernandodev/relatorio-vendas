# Sistema de Gestão de Vendas em PL/SQL

## Funcionalidades

- **Inserir Produto**
- **Registrar Venda**
- **Gerar Relatório de Vendas**
- **Comparação de Vendas**

# Instruções de Uso

-**Inserir Produto**

BEGIN
    inserir_produto(
        p_id_produto => 1002,  -- ID do produto a ser inserido
        p_nome => 'Notebook',
        p_categoria => 'Eletrônicos',
        p_preco => 3500,
        p_estoque => 20
    );
END;
/

**Registrar Venda**

CREATE OR REPLACE PROCEDURE registrar_venda (
    p_id_produto   IN NUMBER,
    p_data_venda   IN DATE,
    p_quantidade   IN NUMBER
);

**Gerar Relatório de Vendas**
BEGIN
    relatorio_vendas;
END;
/


**Comparação de Vendas**

CREATE OR REPLACE FUNCTION comparacao_vendas (
    p_data_inicio1 IN DATE,
    p_data_fim1 IN DATE,
    p_data_inicio2 IN DATE,
    p_data_fim2 IN DATE
) RETURN SYS_REFCURSOR;
