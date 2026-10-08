# CineSema - Banco de Dados

Atividade III de Banco de Dados (SEDUC DEST1).

Feito por **Alexandre** e **Lucas Vieira**.

A proposta do trabalho era planejar, criar e testar um banco de dados para um negócio qualquer. A gente escolheu um cinema, o CineSema. O banco é em MySQL e roda no computador (host local). O resultado fica guardado num dump com estrutura e dados. No final do README tem também um guia de como subir o mesmo banco na Aiven, caso alguém queira colocar na nuvem.

## Domínio

Gerenciamento de um cinema: clientes, filmes, salas, assentos, sessões, venda de ingressos, bomboniere e pagamentos.

## Contextualização

O CineSema abriu há mais de dez anos com duas salas e foi crescendo. Hoje tem cinco: duas comuns, uma 3D, uma IMAX e uma VIP. Tem também uma bomboniere com pipoca, bebida, doce e combo, e nos fins de semana passam centenas de pessoas por lá.

O problema é que a gestão ficou parada no tempo. Tudo ainda é feito em planilha, caderno e comprovante de papel. A programação está numa planilha, os ingressos em outra e a bomboniere num caderno. Cada setor cuida do seu pedaço e ninguém tem a visão do todo.

Isso gera problemas no dia a dia:

- Dois ingressos vendidos para a mesma cadeira na mesma sessão. O cliente chega e o lugar já está ocupado.
- O mesmo filme ou cliente digitado de formas diferentes, com erro de escrita. Ninguém sabe qual está certo.
- Total do pedido que não bate com a soma dos ingressos e dos produtos, e o caixa fecha com diferença.
- Nenhum histórico do cliente. Não dá para saber quanto ele já gastou nem o que costuma assistir.
- Relatórios feitos na mão, somando linha por linha. Descobrir o faturamento de um filme leva horas.
- Pagamento pendente ou recusado que se perde no meio dos papéis.
- Duas pessoas mexendo na mesma planilha, e uma apagando o que a outra fez.
- Qualquer um altera os dados e não existe backup confiável.

## Proposta

Colocar tudo em um banco de dados relacional (MySQL), para que bilheteria, bomboniere e gerência usem a mesma base.

Na prática, o banco resolve assim:

- Cada informação é cadastrada uma vez e depois só referenciada. Acaba a digitação repetida.
- As chaves estrangeiras não deixam criar, por exemplo, um pedido para um cliente que não existe.
- A tabela de ingressos tem um `UNIQUE (id_sessao, id_assento)`, então é impossível vender o mesmo assento duas vezes na mesma sessão.
- Pedido, ingressos, itens e pagamentos ficam ligados, e dá para conferir os valores com uma consulta.
- Os relatórios saem em segundos.
- Vários usuários podem acessar ao mesmo tempo, cada um com a sua permissão.
- O backup vira um dump que dá para restaurar em qualquer MySQL.

## Modelagem lógica

O banco se chama `cinesema` e tem 10 tabelas. PK é chave primária e FK é chave estrangeira.

**clientes**
- id_cliente: INT, auto incremento, PK
- nome: VARCHAR(150), obrigatório
- cpf: VARCHAR(11), obrigatório, único
- data_nascimento: DATE
- data_cadastro: DATETIME, obrigatório, padrão data/hora atual

**pedidos**
- id_pedido: INT, auto incremento, PK
- data_hora: DATETIME, padrão data/hora atual
- valor_total: DECIMAL(8,2), obrigatório, padrão 0.00
- id_cliente: INT, obrigatório, FK para clientes

**filmes**
- id_filme: INT, auto incremento, PK
- titulo: VARCHAR(70), obrigatório
- duracao: INT (minutos)

**salas**
- id_sala: INT, auto incremento, PK
- numero: INT
- tipo_sala: VARCHAR(30)

**sessoes**
- id_sessao: INT, auto incremento, PK
- data_hora_inicio: DATETIME
- tipo_sessao: VARCHAR(30)
- idioma_exibicao: VARCHAR(30)
- formato_filme: VARCHAR(20)
- preco_base: DECIMAL(10,2)
- id_filme: INT, obrigatório, FK para filmes
- id_sala: INT, obrigatório, FK para salas

**assentos**
- id_assento: INT, auto incremento, PK
- fileira: CHAR(1)
- cadeira: INT
- tipo_assento: VARCHAR(30)
- id_sala: INT, obrigatório, FK para salas

**ingressos**
- id_ingresso: INT, auto incremento, PK
- tipo_ingresso: VARCHAR(30)
- valor: DECIMAL(8,2)
- id_pedido: INT, obrigatório, FK para pedidos
- id_sessao: INT, obrigatório, FK para sessoes
- id_assento: INT, obrigatório, FK para assentos
- único em (id_sessao, id_assento)

**produtos**
- id_produto: INT, auto incremento, PK
- nome: VARCHAR(70), obrigatório
- categoria: VARCHAR(30)
- preco: DECIMAL(8,2), obrigatório

**itens_pedido**
- id_item: INT, auto incremento, PK
- quantidade: INT, obrigatório, padrão 1
- preco_unitario: DECIMAL(8,2), obrigatório
- id_pedido: INT, obrigatório, FK para pedidos
- id_produto: INT, obrigatório, FK para produtos

**pagamentos**
- id_pagamento: INT, auto incremento, PK
- metodo: VARCHAR(30), obrigatório
- valor_pago: DECIMAL(8,2), obrigatório
- data_hora: DATETIME, padrão data/hora atual
- status: VARCHAR(20), obrigatório, padrão 'pendente'
- id_pedido: INT, obrigatório, FK para pedidos

O diagrama (DER) está em `docs/der.png`.

## Relacionamentos e cardinalidade

Os relacionamentos são feitos por chave estrangeira, e ela fica sempre na tabela do lado "muitos".

**1:N**
- Um cliente faz vários pedidos, mas cada pedido é de um cliente só.
- Um pedido tem vários ingressos, vários itens da bomboniere e pode ter mais de um pagamento (uma tentativa recusada e outra aprovada, por exemplo).
- Um produto aparece em vários itens de pedido.
- Um filme tem várias sessões, e cada sessão exibe um filme.
- Uma sala recebe várias sessões e tem vários assentos.
- Uma sessão tem vários ingressos vendidos.
- Um assento aparece em vários ingressos, um por sessão.

**N:N** (resolvido com tabela no meio)
- Pedidos e produtos: pela tabela `itens_pedido`.
- Sessões e assentos: pela tabela `ingressos`, onde o par (sessão, assento) não pode se repetir.

## Estrutura do repositório

```
bd-cinesema/
├── README.md
├── sql/
│   ├── 01_estrutura.sql
│   ├── 02_dados.sql
│   └── 03_consultas.sql
├── dump/
│   └── dump_completo.sql
└── docs/
    └── der.png
```

## Como rodar no host local

Precisa ter o MySQL 8 instalado e um cliente, como o MySQL Workbench, o DBeaver ou o terminal.

Os scripts rodam nesta ordem:

1. `sql/01_estrutura.sql` cria o banco `cinesema` e as tabelas.
2. `sql/02_dados.sql` insere os dados (mais de 5 registros por tabela).
3. `sql/03_consultas.sql` executa as 10 consultas.

**No Workbench:** abra a conexão local, vá em *File > Open SQL Script*, escolha o arquivo e clique no raio para executar tudo. Repita para os três.

**Pelo terminal:**

```bash
mysql -u root -p < sql/01_estrutura.sql
mysql -u root -p < sql/02_dados.sql
mysql -u root -p < sql/03_consultas.sql
```

Para conferir se deu certo:

```sql
use cinesema;
show tables;                      -- tem que listar 10 tabelas
select count(*) from ingressos;   -- tem que dar 9
```

O `02_dados.sql` só pode rodar uma vez. O CPF é único e os ids dos inserts partem de tabelas vazias. Se precisar recomeçar:

```sql
drop database if exists cinesema;
```

e rode os scripts de novo.

## Dump (estrutura e dados)

O dump foi gerado pelo MySQL Workbench e está em `dump/dump_completo.sql`.

Para gerar:

1. Menu *Server > Data Export*.
2. Marque o schema `cinesema` e as 10 tabelas.
3. Escolha *Dump Structure and Data*.
4. Em *Export to Self-Contained File*, informe o caminho e o nome `dump_completo.sql`.
5. Marque *Include Create Schema* e clique em *Start Export*.

Pelo terminal dá no mesmo:

```bash
mysqldump -u root -p --databases cinesema > dump/dump_completo.sql
```

Para restaurar em outra máquina:

```bash
mysql -u root -p < dump/dump_completo.sql
```

Como o dump já cria o banco, não precisa criar nada antes.

## Consultas

As 10 consultas estão em `sql/03_consultas.sql`, cada uma com um comentário dizendo qual é a pergunta que ela responde:

1. Programação do cinema, com filme, sala, horário e formato (INNER JOIN, ORDER BY)
2. Filmes com duração entre 90 e 150 minutos (WHERE, BETWEEN)
3. Produtos de pipoca da bomboniere (LIKE)
4. Preço médio das sessões por formato (GROUP BY, COUNT, AVG)
5. Faturamento de ingressos por filme (INNER JOIN, SUM, GROUP BY)
6. Clientes que gastaram mais de R$ 100 (SUM, GROUP BY, HAVING)
7. Faturamento da bomboniere por categoria (INNER JOIN, SUM)
8. Total recebido por forma de pagamento, só os aprovados (WHERE, SUM, COUNT)
9. Ingressos de meia-entrada, com cliente, filme e assento (INNER JOIN em 6 tabelas)
10. Clientes que só compraram bomboniere, sem ingresso (LEFT JOIN, IS NULL)

Um exemplo, a consulta 5:

```sql
select f.titulo,
       count(i.id_ingresso) as ingressos_vendidos,
       sum(i.valor) as faturamento
from ingressos i
inner join sessoes se on se.id_sessao = i.id_sessao
inner join filmes f   on f.id_filme = se.id_filme
group by f.id_filme, f.titulo
order by faturamento desc;
```

Resultado:

```
Duna: Parte Dois                   4   180.00
Interestelar                       2    82.50
Homem-Aranha: Sem Volta para Casa  1    40.00
Procurando Nemo                    1    28.00
Divertida Mente 2                  1    14.00
```

## Extra: guia para subir o banco na Aiven

A gente não usou a Aiven no trabalho, mas deixamos o passo a passo aqui caso alguém queira hospedar o banco na nuvem.

1. Crie uma conta em aiven.io.
2. Em *Create service*, escolha **MySQL** e o plano gratuito, se estiver disponível.
3. Dê um nome ao serviço (por exemplo, `bd-cinesema`) e espere o status ficar *Running*.
4. Na página *Overview*, anote o host, a porta, o usuário (`avnadmin`) e a senha. Baixe também o certificado `ca.pem`.
5. Conecte pelo terminal, com SSL:

```bash
mysql --host=SEU_HOST --port=SUA_PORTA --user=avnadmin --password \
      --ssl-mode=REQUIRED --ssl-ca=ca.pem
```

6. Rode os três scripts da pasta `sql/` na mesma ordem do host local:

```bash
mysql --host=SEU_HOST --port=SUA_PORTA --user=avnadmin --password \
      --ssl-mode=REQUIRED --ssl-ca=ca.pem < sql/01_estrutura.sql
```

(repita para o `02_dados.sql` e o `03_consultas.sql`)

7. Confira com `show tables;` e `select count(*) from ingressos;`.

Também dá para restaurar o dump direto na Aiven, em vez de rodar os scripts:

```bash
mysql --host=SEU_HOST --port=SUA_PORTA --user=avnadmin --password \
      --ssl-mode=REQUIRED --ssl-ca=ca.pem < dump/dump_completo.sql
```

E para gerar um dump a partir do banco que está na Aiven:

```bash
mysqldump --host=SEU_HOST --port=SUA_PORTA --user=avnadmin --password \
  --ssl-mode=REQUIRED --ssl-ca=ca.pem --set-gtid-purged=OFF --no-tablespaces \
  --databases cinesema > dump/dump_completo.sql
```

Atenção: nunca suba a senha nem o `ca.pem` para o GitHub. Os menus e limites do plano gratuito mudam com o tempo, então se algo estiver diferente, vale conferir em docs.aiven.io.

## Autores

- Alexandre
- Lucas Vieira

SEDUC DEST1
