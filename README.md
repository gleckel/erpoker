# ERPoker - Projeto II - Gabi, Marcos e Wederson.

## Acessos:

Trello: https://trello.com/b/0NMETuW3/erpoker  

Salesforce: https://playful-unicorn-hy8l6h-dev-ed.lightning.force.com/lightning/setup/SetupOneHome/home  


## Tarefas: 

### Data - 06/10/22

Gabi: Criei github, trello e acessos do salesforce. Ajustei os niveis de acesso de Gerente e Agente. (Os agentes não podem ter acesso aos dados totais de rake gerado.)  

Wed e Marcos: Estudando sobre triggers e conectando o vscode ao projeto pra subir alterações no git.   

## Descrição dos Requisitos: 

**Descrição [RF01]**

O sistema deve manter registros de lançamentos de fichas. Esses lançamentos devem ter contidos informações de: 
 - Agente
 - Cliente 
 - Pagamento realizado
 - Qual foi a forma de pagamento se houve
 - Data do lançamento 
 - Venda ou Pagamento 

**Descrição [RF02]**
O sistema deve manter dados de usuários. Esses dados devem ter:
- Nome
- Contato (Relacionamento)
- CPF
- Limite de crédito 
- Fichas Compradas

**Descrição [RF03]**
O sistema deve atualizar limite de crédito e fichas compradas conforma lançamentos, tanto se for venda quanto for pagamento.

**Descrição [RF04]**
O sistema deve gerar relatórios semanais de fichas vendidas por agente. Esse relatório deve gerar informações de vendas de fichas no crédito e vendas pagas. 

**Descrição [RF05]**
O sistema deve possuir gráficos para analisar informações como:
- Lançamentos de venda mensais ou semanais
- Lançamentos de venda no crédito mensais ou semanais
- Lançamentos de venda por agente mensais ou semanais

**Descrição [RF06]**
O sistema deve manter registros de rake TOTAL gerado diariamente. O qual deve conter informações de:
-Valor do rake
-Data

**Descrição [RF07]** 
O sistema deve manter registros de rake gerado por agente semanal. O qual deve conter informações de:
-Valor do rake
-Data do periodo
-Agente

## Descrição das triggers necessárias: 

Quando criar um relatório preencher automaticamente: 
Rake Gerado no Periodo - Conforme datas selecionadas. 
Compras do agente - Conforme datas selecionadas. Selecionar no usuario se há saldo devedor.
Valor do pagamento: Pegar o rake gerado no periodo e compras do agente e realizar a subtração. Se o valor do rake gerado no periodo já realiza a conta e abate o valor jogado, se o valor do rake gerado for menor do que o saldo devedor o valor deve ficar negativo.Por fim deve ser atualizado o saldo devedor e o limite de crédito do usuario.

# Feito:
Quando houver um lançamento de venda de fichas e o pagamento for realizado, atualizar o Valor total Vendido do usuario com o valor atual + o valor da venda.

 
## A fazer na semana:
### David:
Atualmente quando um usuario esta DEVENDO e lança uma nova venda de fichas (PAGA) o saldo devedor e o limite de crédito permanece o mesmo, deve-se retirar o valor da venda do saldo devedor e do limite de crédito (caso o valor for maior, reduzir o saldo devedor e adicionar o resto em saldo total vendido).

### Wed: 
Adicionar em LancamentoBO.atualizaSaldoDevedor: Caso a venda de fichas for realizada, e o pagamento não for feito no ato deve-se verificar se o usuario tem um limite de credito igual ou maior do que o da compra.
Feito em LancamentoBO.atualizaSaldoDevedor: Se tiver o limite de crédito do usuario deve diminuir e o saldo devedor aumentar.
Regra de validação: Quando houver uma venda de fichas deve verificar se o campo "forma de pagamento" estiver preenchido, deve-se preencher o campo "pago".
Tutorial regra de validação: https://trailhead.salesforce.com/pt-BR/content/learn/modules/point_click_business_logic/validation_rules





