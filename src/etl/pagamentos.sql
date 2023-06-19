-- Objetivo Principal: Criação de variáveis relativas ao pagamento de cada venda feita por vendedor nos últimos 6 meses
-- de 2017.
-- tb_pedidos: Cruzando id dos Pedidos com id do Vendedor, filtrando a época de interesse e retirando valores nulos;
WITH tb_pedidos AS (

        SELECT
                DISTINCT
                t1.idPedido,
                t2.idVendedor

        FROM pedido as t1

        LEFT JOIN item_pedido as t2
        on t1.idPedido = t2.idPedido

        WHERE t1.dtPedido <= '2018-01-01'
        and t1.dtPedido > DATE('2018-01-01', '-6 months')
        and idVendedor is not NULL

),

-- tb_join: Unindo as tabelas 'pedido', 'pagamento_pedido' e 'item_pedido' a partir do id do Pedido
tb_join AS (

        SELECT t2.*,
                t3.idVendedor

        FROM pedido as t1

        LEFT JOIN pagamento_pedido as t2
        ON t1.idPedido = t2.idPedido

        LEFT JOIN item_pedido as t3
        ON t1.idPedido = t3.idPedido

        WHERE t1.dtPedido < '2018-01-01'
        AND t1.dtPedido >= DATE('2018-01-01', '-6 months')
        AND t3.idVendedor is not NULL

),

-- tb_group: Estabelecendo valores para novas variáveis que usaremos mais a frente
tb_group as (

SELECT idVendedor,
        descTipoPagamento,
        count(DISTINCT idPedido) as qtdePedidoMeioPagamento,
        sum(vlPagamento) as vlPedidoMeioPagamento

FROM tb_join

GROUP BY idVendedor, descTipoPagamento
ORDER BY idVendedor, descTipoPagamento

),

-- Criando as novas variáveis da tabela, 'quantidade de vendas por cada forma de pagamento', 'valor total de vendas por forma de pagamento'
-- e porcentagem dessas duas variáveis anteriores em relaão ao total.
tb_summary AS (

SELECT idVendedor,

sum(case when descTipoPagamento = 'boleto' then qtdePedidoMeioPagamento else 0 end) as qtde_boleto_pedido, 
sum(case when descTipoPagamento = 'credit_card' then qtdePedidoMeioPagamento else 0 end) as qtde_credit_card_pedido, 
sum(case when descTipoPagamento = 'debit_card' then qtdePedidoMeioPagamento else 0 end) as qtde_debit_card_pedido, 
sum(case when descTipoPagamento = 'voucher' then qtdePedidoMeioPagamento else 0 end) as qtde_voucher_pedido,

sum(case when descTipoPagamento = 'boleto' then vlPedidoMeioPagamento else 0 end) as valor_boleto_pedido, 
sum(case when descTipoPagamento = 'credit_card' then vlPedidoMeioPagamento else 0 end) as valor_credit_card_pedido, 
sum(case when descTipoPagamento = 'debit_card' then vlPedidoMeioPagamento else 0 end) as valor_debit_card_pedido, 
sum(case when descTipoPagamento = 'voucher' then vlPedidoMeioPagamento else 0 end) as valor_voucher_pedido,

sum(case when descTipoPagamento = 'boleto' then qtdePedidoMeioPagamento else 0 end) * 1.0 / sum(qtdePedidoMeioPagamento) as pct_qtde_boleto_pedido, 
sum(case when descTipoPagamento = 'credit_card' then qtdePedidoMeioPagamento else 0 end) * 1.0 / sum(qtdePedidoMeioPagamento) as pct_qtde_credit_card_pedido, 
sum(case when descTipoPagamento = 'debit_card' then qtdePedidoMeioPagamento else 0 end) * 1.0 / sum(qtdePedidoMeioPagamento) as pct_qtde_debit_card_pedido, 
sum(case when descTipoPagamento = 'voucher' then qtdePedidoMeioPagamento else 0 end) * 1.0 / sum(qtdePedidoMeioPagamento) as pct_qtde_voucher_pedido,

sum(case when descTipoPagamento = 'boleto' then vlPedidoMeioPagamento else 0 end) / sum(vlPedidoMeioPagamento) as pct_valor_boleto_pedido, 
sum(case when descTipoPagamento = 'credit_card' then vlPedidoMeioPagamento else 0 end) / sum(vlPedidoMeioPagamento) as pct_valor_credit_card_pedido, 
sum(case when descTipoPagamento = 'debit_card' then vlPedidoMeioPagamento else 0 end) / sum(vlPedidoMeioPagamento) as pct_valor_debit_card_pedido, 
sum(case when descTipoPagamento = 'voucher' then vlPedidoMeioPagamento else 0 end) / sum(vlPedidoMeioPagamento) as pct_valor_voucher_pedido

FROM tb_group

GROUP BY idVendedor

),

-- Criando variáveis relativas às parcelas das compras realizadas;
tb_cartao AS(
        SELECT idVendedor,
                AVG(nrParcelas) as avgQtdeParcelas,
                max(nrParcelas) AS maxQtdeParcelas,
                min(nrParcelas) AS minQtdeParcelas

        FROM tb_join

        WHERE descTipoPagamento = 'credit_card'

        GROUP BY idVendedor

)

SELECT  '2018-01-01' AS dtReference,
        t1.*,
        t2.avgQtdeParcelas,
        t2.maxQtdeParcelas,
        t2.minQtdeParcelas

FROM tb_summary as t1

Left JOIN tb_cartao as t2
ON t1.idVendedor = t2.idVendedor