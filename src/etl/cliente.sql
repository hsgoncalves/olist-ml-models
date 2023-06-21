
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


)

SELECT

idVendedor,

count(DISTINCT CASE WHEN descUF = 'AC' THEN idPedido END)*1.0/count(DISTINCT idPedido) as pctClienteAC,
count(DISTINCT CASE WHEN descUF = 'AL' THEN idPedido END)*1.0/count(DISTINCT idPedido) as pctClienteAL,
count(DISTINCT CASE WHEN descUF = 'AM' THEN idPedido END)*1.0/count(DISTINCT idPedido) as pctClienteAM,
count(DISTINCT CASE WHEN descUF = 'AP' THEN idPedido END)*1.0/count(DISTINCT idPedido) as pctClienteAP,
count(DISTINCT CASE WHEN descUF = 'BA' THEN idPedido END)*1.0/count(DISTINCT idPedido) as pctClienteBA,
count(DISTINCT CASE WHEN descUF = 'CE' THEN idPedido END)*1.0/count(DISTINCT idPedido) as pctClienteCE,
count(DISTINCT CASE WHEN descUF = 'DF' THEN idPedido END)*1.0/count(DISTINCT idPedido) as pctClienteDF,
count(DISTINCT CASE WHEN descUF = 'ES' THEN idPedido END)*1.0/count(DISTINCT idPedido) as pctClienteES,
count(DISTINCT CASE WHEN descUF = 'GO' THEN idPedido END)*1.0/count(DISTINCT idPedido) as pctClienteGO,
count(DISTINCT CASE WHEN descUF = 'MA' THEN idPedido END)*1.0/count(DISTINCT idPedido) as pctClienteMA,
count(DISTINCT CASE WHEN descUF = 'MG' THEN idPedido END)*1.0/count(DISTINCT idPedido) as pctClienteMG,
count(DISTINCT CASE WHEN descUF = 'MS' THEN idPedido END)*1.0/count(DISTINCT idPedido) as pctClienteMS,
count(DISTINCT CASE WHEN descUF = 'MT' THEN idPedido END)*1.0/count(DISTINCT idPedido) as pctClienteMT,
count(DISTINCT CASE WHEN descUF = 'PA' THEN idPedido END)*1.0/count(DISTINCT idPedido) as pctClientePA,
count(DISTINCT CASE WHEN descUF = 'PB' THEN idPedido END)*1.0/count(DISTINCT idPedido) as pctClientePB,
count(DISTINCT CASE WHEN descUF = 'PE' THEN idPedido END)*1.0/count(DISTINCT idPedido) as pctClientePE,
count(DISTINCT CASE WHEN descUF = 'PI' THEN idPedido END)*1.0/count(DISTINCT idPedido) as pctClientePI,
count(DISTINCT CASE WHEN descUF = 'PR' THEN idPedido END)*1.0/count(DISTINCT idPedido) as pctClientePR,
count(DISTINCT CASE WHEN descUF = 'RJ' THEN idPedido END)*1.0/count(DISTINCT idPedido) as pctClienteRJ,
count(DISTINCT CASE WHEN descUF = 'RN' THEN idPedido END)*1.0/count(DISTINCT idPedido) as pctClienteRN,
count(DISTINCT CASE WHEN descUF = 'RO' THEN idPedido END)*1.0/count(DISTINCT idPedido) as pctClienteRO,
count(DISTINCT CASE WHEN descUF = 'RR' THEN idPedido END)*1.0/count(DISTINCT idPedido) as pctClienteRR,
count(DISTINCT CASE WHEN descUF = 'RS' THEN idPedido END)*1.0/count(DISTINCT idPedido) as pctClienteRS,
count(DISTINCT CASE WHEN descUF = 'SC' THEN idPedido END)*1.0/count(DISTINCT idPedido) as pctClienteSC,
count(DISTINCT CASE WHEN descUF = 'SE' THEN idPedido END)*1.0/count(DISTINCT idPedido) as pctClienteSE,
count(DISTINCT CASE WHEN descUF = 'SP' THEN idPedido END)*1.0/count(DISTINCT idPedido) as pctClienteSP,
count(DISTINCT CASE WHEN descUF = 'TO' THEN idPedido END)*1.0/count(DISTINCT idPedido) as pctClienteTO

FROM tb_join

GROUP BY idVendedor