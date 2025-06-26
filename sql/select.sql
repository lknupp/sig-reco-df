select a.descricao
from alimento a, 
	refeicao_alimento b,
	refeicao c,
	cardapio_refeicao d,
	cardapio e
where a.cd_alimento = b.cd_alimento
and b.cd_refeicao = c.cd_refeicao
and c.cd_refeicao = d.cd_refeicao 
and d.cd_cardapio = e.cd_cardapio
and e.dt_cardapio = '2025-06-05'
and e.tp_refeicao = 1;