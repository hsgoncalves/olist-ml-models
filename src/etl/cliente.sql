
WITH tb_join AS (

SELECT DISTINCT
        t1.idPedido,
        t1.idCliente,
        t2.idVendedor,
        t3.descUF

FROM item_pedido AS t2

INNER JOIN pedido AS t1
ON t1.idPedido = t2.idPedido

INNER JOIN cliente as t3
ON t3.idCliente = t1.idCliente

where t1.dtPedido BETWEEN '2017-07-01' AND '2018-01-01'


),

tb_group AS (

SELECT

idVendedor,

count(DISTINCT descUF) AS qtdeUFsPedidos,

count(DISTINCT CASE WHEN descUF = 'AC' THEN idPedido END)*1.0/count(DISTINCT idPedido) as pctPedidoAC,
count(DISTINCT CASE WHEN descUF = 'AL' THEN idPedido END)*1.0/count(DISTINCT idPedido) as pctPedidoAL,
count(DISTINCT CASE WHEN descUF = 'AM' THEN idPedido END)*1.0/count(DISTINCT idPedido) as pctPedidoAM,
count(DISTINCT CASE WHEN descUF = 'AP' THEN idPedido END)*1.0/count(DISTINCT idPedido) as pctPedidoAP,
count(DISTINCT CASE WHEN descUF = 'BA' THEN idPedido END)*1.0/count(DISTINCT idPedido) as pctPedidoBA,
count(DISTINCT CASE WHEN descUF = 'CE' THEN idPedido END)*1.0/count(DISTINCT idPedido) as pctPedidoCE,
count(DISTINCT CASE WHEN descUF = 'DF' THEN idPedido END)*1.0/count(DISTINCT idPedido) as pctPedidoDF,
count(DISTINCT CASE WHEN descUF = 'ES' THEN idPedido END)*1.0/count(DISTINCT idPedido) as pctPedidoES,
count(DISTINCT CASE WHEN descUF = 'GO' THEN idPedido END)*1.0/count(DISTINCT idPedido) as pctPedidoGO,
count(DISTINCT CASE WHEN descUF = 'MA' THEN idPedido END)*1.0/count(DISTINCT idPedido) as pctPedidoMA,
count(DISTINCT CASE WHEN descUF = 'MG' THEN idPedido END)*1.0/count(DISTINCT idPedido) as pctPedidoMG,
count(DISTINCT CASE WHEN descUF = 'MS' THEN idPedido END)*1.0/count(DISTINCT idPedido) as pctPedidoMS,
count(DISTINCT CASE WHEN descUF = 'MT' THEN idPedido END)*1.0/count(DISTINCT idPedido) as pctPedidoMT,
count(DISTINCT CASE WHEN descUF = 'PA' THEN idPedido END)*1.0/count(DISTINCT idPedido) as pctPedidoPA,
count(DISTINCT CASE WHEN descUF = 'PB' THEN idPedido END)*1.0/count(DISTINCT idPedido) as pctPedidoPB,
count(DISTINCT CASE WHEN descUF = 'PE' THEN idPedido END)*1.0/count(DISTINCT idPedido) as pctPedidoPE,
count(DISTINCT CASE WHEN descUF = 'PI' THEN idPedido END)*1.0/count(DISTINCT idPedido) as pctPedidoPI,
count(DISTINCT CASE WHEN descUF = 'PR' THEN idPedido END)*1.0/count(DISTINCT idPedido) as pctPedidoPR,
count(DISTINCT CASE WHEN descUF = 'RJ' THEN idPedido END)*1.0/count(DISTINCT idPedido) as pctPedidoRJ,
count(DISTINCT CASE WHEN descUF = 'RN' THEN idPedido END)*1.0/count(DISTINCT idPedido) as pctPedidoRN,
count(DISTINCT CASE WHEN descUF = 'RO' THEN idPedido END)*1.0/count(DISTINCT idPedido) as pctPedidoRO,
count(DISTINCT CASE WHEN descUF = 'RR' THEN idPedido END)*1.0/count(DISTINCT idPedido) as pctPedidoRR,
count(DISTINCT CASE WHEN descUF = 'RS' THEN idPedido END)*1.0/count(DISTINCT idPedido) as pctPedidoRS,
count(DISTINCT CASE WHEN descUF = 'SC' THEN idPedido END)*1.0/count(DISTINCT idPedido) as pctPedidoSC,
count(DISTINCT CASE WHEN descUF = 'SE' THEN idPedido END)*1.0/count(DISTINCT idPedido) as pctPedidoSE,
count(DISTINCT CASE WHEN descUF = 'SP' THEN idPedido END)*1.0/count(DISTINCT idPedido) as pctPedidoSP,
count(DISTINCT CASE WHEN descUF = 'TO' THEN idPedido END)*1.0/count(DISTINCT idPedido) as pctPedidoTO

FROM tb_join

GROUP BY idVendedor

)

SELECT 
        '2018-01-01' as dtReference,
        *

FROM tb_group