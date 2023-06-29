
WITH tb_join AS (
SELECT DISTINCT
        t2.idProduto,
        t2.idVendedor,
        t3.*

FROM pedido as t1

INNER JOIN item_pedido as t2
on t1.idPedido = t2.idPedido

INNER JOIN produto as t3
on t2.idProduto = t3.idProduto

where t1.dtPedido BETWEEN '2017-07-01' AND '2018-01-01'

),

tb_summary as (

SELECT idVendedor,
        avg(coalesce(nrFotos,0)) as avgFotos,
        avg(vlComprimentoCm * vlAlturaCm * vlLarguraCm) as avgVolume,
        max(vlComprimentoCm * vlAlturaCm * vlLarguraCm) as maxVolume,
        min(vlComprimentoCm * vlAlturaCm * vlLarguraCm) as minVolume,

        count(DISTINCT CASE WHEN descCategoria = 'automotivo' then idProduto end) * 1.0 / count(DISTINCT idProduto) as pctCategoriaautomotivo, 
        count(DISTINCT CASE WHEN descCategoria = 'bebes' then idProduto end) * 1.0 / count(DISTINCT idProduto) as pctCategoriabebes, 
        count(DISTINCT CASE WHEN descCategoria = 'beleza_saude' then idProduto end) * 1.0 / count(DISTINCT idProduto) as pctCategoriabeleza_saude, 
        count(DISTINCT CASE WHEN descCategoria = 'briquedos' then idProduto end) * 1.0 / count(DISTINCT idProduto) as pctCategoriabriquedos, 
        count(DISTINCT CASE WHEN descCategoria = 'cama_mesa_banho' then idProduto end) * 1.0 / count(DISTINCT idProduto) as pctCategoriacama_mesa_banho, 
        count(DISTINCT CASE WHEN descCategoria = 'cool_stuff' then idProduto end) * 1.0 / count(DISTINCT idProduto) as pctCategoriacool_stuff, 
        count(DISTINCT CASE WHEN descCategoria = 'eletronicos' then idProduto end) * 1.0 / count(DISTINCT idProduto) as pctCategoriaeletronicos, 
        count(DISTINCT CASE WHEN descCategoria = 'esporte_lazer' then idProduto end) * 1.0 / count(DISTINCT idProduto) as pctCategoriaesporte_lazer, 
        count(DISTINCT CASE WHEN descCategoria = 'ferramentas_jardim' then idProduto end) * 1.0 / count(DISTINCT idProduto) as pctCategoriaferramentas_jardim, 
        count(DISTINCT CASE WHEN descCategoria = 'informatica_acessorios' then idProduto end) * 1.0 / count(DISTINCT idProduto) as pctCategoriainformatica_acessorios, 
        count(DISTINCT CASE WHEN descCategoria = 'moveis_decoracao' then idProduto end) * 1.0 / count(DISTINCT idProduto) as pctCategoriamoveis_decoracao, 
        count(DISTINCT CASE WHEN descCategoria = 'perfumaria' then idProduto end) * 1.0 / count(DISTINCT idProduto) as pctCategoriaperfumaria, 
        count(DISTINCT CASE WHEN descCategoria = 'relogios_presentes' then idProduto end) * 1.0 / count(DISTINCT idProduto) as pctCategoriarelogios_presentes, 
        count(DISTINCT CASE WHEN descCategoria = 'telefonia' then idProduto end) * 1.0 / count(DISTINCT idProduto) as pctCategoriatelefonia, 
        count(DISTINCT CASE WHEN descCategoria = 'utilidades_domesticas' then idProduto end) * 1.0 / count(DISTINCT idProduto) as pctCategoriautilidades_domesticas 

FROM tb_join

GROUP BY idVendedor

)

SELECT * from tb_summary

/*SELECT descCategoria

FROM item_pedido as t2

INNER JOIN produto as t3
on t2.idProduto = t3.idProduto

WHERE t2.idVendedor IS NOT NULL

GROUP BY 1
ORDER BY count(DISTINCT idPedido) DESC

LIMIT 15


