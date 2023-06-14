-- Unindo t1 e t2 com base no filtro de data feito (6 últimos meses de 2017).

WITH tb_join as (

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

tb_group as (

SELECT idVendedor,
        descTipoPagamento,
        count(DISTINCT idPedido) as qtdePedidoMeioPagamento,
        sum(vlPagamento) as vlPedidoMeioPagamento

FROM tb_join

GROUP BY idVendedor, descTipoPagamento
ORDER BY idVendedor, descTipoPagamento

)

SELECT idVendedor,

sum(case when descTipoPagamento = 'boleto' then qtdePedidoMeioPagamento else 0 end) as qtde_boleto_pedido, 
sum(case when descTipoPagamento = 'credit_card' then qtdePedidoMeioPagamento else 0 end) as qtde_credit_card_pedido, 
sum(case when descTipoPagamento = 'debit_card' then qtdePedidoMeioPagamento else 0 end) as qtde_debit_card_pedido, 
sum(case when descTipoPagamento = 'voucher' then qtdePedidoMeioPagamento else 0 end) as qtde_voucher_pedido,

sum(case when descTipoPagamento = 'boleto' then vlPedidoMeioPagamento else 0 end) as valor_boleto_pedido, 
sum(case when descTipoPagamento = 'credit_card' then vlPedidoMeioPagamento else 0 end) as valor_credit_card_pedido, 
sum(case when descTipoPagamento = 'debit_card' then vlPedidoMeioPagamento else 0 end) as valor_debit_card_pedido, 
sum(case when descTipoPagamento = 'voucher' then vlPedidoMeioPagamento else 0 end) as valor_voucher_pedido,

sum(case when descTipoPagamento = 'boleto' then qtdePedidoMeioPagamento else 0 end) / sum(qtdePedidoMeioPagamento) as pct_qtde_boleto_pedido, 
sum(case when descTipoPagamento = 'credit_card' then qtdePedidoMeioPagamento else 0 end) / sum(qtdePedidoMeioPagamento) as pct_qtde_credit_card_pedido, 
sum(case when descTipoPagamento = 'debit_card' then qtdePedidoMeioPagamento else 0 end) / sum(qtdePedidoMeioPagamento) as pct_qtde_debit_card_pedido, 
sum(case when descTipoPagamento = 'voucher' then qtdePedidoMeioPagamento else 0 end) / sum(qtdePedidoMeioPagamento) as pct_qtde_voucher_pedido,

sum(case when descTipoPagamento = 'boleto' then vlPedidoMeioPagamento else 0 end) / sum(vlPedidoMeioPagamento) as pct_valor_boleto_pedido, 
sum(case when descTipoPagamento = 'credit_card' then vlPedidoMeioPagamento else 0 end) / sum(vlPedidoMeioPagamento) as pct_valor_credit_card_pedido, 
sum(case when descTipoPagamento = 'debit_card' then vlPedidoMeioPagamento else 0 end) / sum(vlPedidoMeioPagamento) as pct_valor_debit_card_pedido, 
sum(case when descTipoPagamento = 'voucher' then vlPedidoMeioPagamento else 0 end) / sum(vlPedidoMeioPagamento) as pct_valor_voucher_pedido

FROM tb_group

GROUP BY 1