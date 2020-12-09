<p align="center">
  <img src="image-gerais/logos2.PNG" width="530" height="130" alt="texto de exemplo">
</p>

A estrutura deste tutorial online está fixada em cinco tópicos gerais que tratam desde os conceitos teóricos relacionados até o passo a passo das práticas a serem desenvolvidas. Consulte o sumário a seguir para estudar um tópico em particular ou acesse na sequência os materiais apresentados.

<a id="sumario"></a>
# Sumário
1. [Introdução](#intro-sec1)
	1. [O que é NewSQL?](#newsql-sec1a)
	2. [O que é Disponibilidade?](#disponibilidade-sec1b)
	3. [Contextualização do Tutorial](#contexto-sec1c)
	4. [Recursos Utilizados](#recursos-sec1d)
2. [Instalação das Ferramentas](#instalacoes-sec2)
	1. [Docker](#docker-sec2a)
	2. [CockroachDB](#cockroachdb-sec2b)
	3. [MemSQL](#memsql-sec2c)
3. [Criação do Cluster Utilizando o Docker](#criar-cluster-sec3)
	1. [CockroachDB](#cockroachdb-sec3a)
	2. [MemSQL](#memsql-sec3b)
4. [Trabalhando com a Disponibilidade: Práticas e Resultados](#praticas-sec4)
	1. [Estudo de caso com o CockroachDB](#estudo-cockroachdb-sec4a)
	2. [Estudo de caso com o MemSQL](#estudo-memsql-sec4b)
5. [Conclusão](#conclusao-sec5)
	1. [Sumarização do que foi aprendido](#aprendizados-sec5a)
6. [Glossário](#glossario-sec6)
7. [Referências Bibliográficas](#referencias-sec7)

<a id="intro-sec1"></a>
# Introdução
A Introdução contempla uma visão geral dos tópicos a serem abordados no tutorial. Também são apresentados as algumas descrições acerca da configuração dos recursos utilizados. Este primeiro tópico foca em expor definições respectivas a: NewSQL, disponibilidade e terminologias relacionadas aos recursos selecionados.

<a id="newsql-sec1a"></a>
## O que é NewSQL?
Os bancos de dados relacionais tradicionais surgiram em um tempo onde a necessidade de armazenamento e gravações eram menores e o acesso não era concorrido [(STONEBRAKER et al. 2007)](#STONEBRAKER-2007). Com a web 3.0, onde milhões de dados são gerados, gravados e acessados com rapidez,  foi criado o NoSQL. Oferecendo acesso rápido e escalonamento horizontal, o NoSQL objetivou-se em resolver problemas relacionados à manutenção e interação com dados volumosos. Para lidar com o novo contexto o NoSQL se apoia no teorema CAP (**C**onsistency, **A**vailability e **P**artition tolerance), onde para se obter alta disponibilidade se faz necessário manejar os níveis de consistência.

O NoSQL trouxe alterações em relação ao paradigma relacional em termos de uso e manutenção das bases de dados. O primeiro ponto a ser observado é que o NoSQL não utiliza a linguagem SQL para consultas e gravações, e para garantir disponibilidade os resultados podem não ser consistentes.
 Estas alterações geraram grandes dúvidas quanto a sua adesão por parte da comunidade que já estava habituada com os paradigmas tradicionais, desta forma, iniciaram pesquisas para desenvolver um SGBDR que utilizasse a mesma linguagem já conhecida e consolidada no mercado, garantisse transações ACID e fossem escaláveis e altamente disponíveis. Fruto destas pesquisas surgiram os SGBDs New SQL. Segundo [Stonebraker e Cattell (2011)](#STONEBRAKER-2011), as cinco características de um SGBD NewSQL são: 
 
* Linguagem SQL como meio de interação entre o SGBD e a aplicação; 
* Suporte para transações ACID; 
* Controle de concorrência não bloqueante, para que as leituras e escritas não causem conflitos entre si; 
* Arquitetura que forneça um maior desempenho por nó de processamento; 
* Arquitetura escalável, com memória distribuída e com capacidade de funcionar em um aglomerado com um grande número de nós.

<a id="disponibilidade-sec1b"></a>
## O que é Disponibilidade?

A disponibilidade é a uma característica de sistemas que podem se manter ativos pelo máximo de tempo possível. Em sistemas de banco de dados isto significa atender uma requisição do usuário (seja ela de leitura, escrita ou modificação) sempre que solicitado. Desta forma pode-se concluir que um sistema é disponível quando responde sempre às requisições com sucesso, e indisponível quando ocorre falha [(REZENDE, 2013)](#REZENDE-2013).

Uma das grandes diferenças entre os bancos de dados relacionais tradicionais e os bancos de dados NoSQL está no tratamento da disponibilidade. Para garantir disponibilidade, os bancos NoSQL podem manejar cópias das informações em vários servidores, clusters e/ou nós. A replicação através de redundância aumenta a disponibilidade dos dados, podendo ainda melhorar a capacidade de resposta à leituras, pois com diversas cópias vários clientes podem solicitar a leitura a partir de locais diferentes. 

Outro fator relativo às replicações é a tolerância a falhas. Na hipótese de um servidor, ou cluster, ou nó falhar, o sistema direciona a requisição para outro ponto que contenha a mesma informação, logo, quanto maior o número de réplicas melhor poderão ser trabalhadas as questões relacionadas à tolerância a falhas [(MONGODB, 2020)](#MONGODB-2020).

<a id="contexto-sec1c"></a>
## Contextualização do Tutorial

Como enredo deste tutorial, a base de dados Northwind será utilizada. Esta base foi originalmente criada pela Microsoft e tem sido usada como contexto de estudo para vários tutoriais relacionados a banco de dados. Os dados são relativos a um cenário de vendas de uma empresa fictícia chamada “Northwind Traders”, que importa e exporta alimentos para todo o mundo [(YUGABYTE, 2020)](#YUGABYTE-2020). A base inclui dados sobre fornecedores, clientes, funcionários, produtos, distribuidores e ordens de pedidos.

>@Suellen: pode ser que aqui precisemos explicar um pouco mais sobre o BD a ser usado relacionado a uma "intro" dos cenários dos estudos que vamos apresentar em seções. posteriores 

<a id="recursos-sec1d"></a>
## Recursos Utilizados

Os recursos que serão utilizados para a elaboração deste tutorial são: Docker; CockroachDB; e MemSQL.

O Docker é uma plataforma open source que fornece recursos para criar, executar, manejar e publicar containers [(MOLL, 2019)](#MOLL-2019). Containers são abstrações a nível de sistema operacional e se caracterizam por agrupar códigos, bibliotecas e dependências com o intuito de garantir a execução de um determinado aplicativo em um ambiente isolado do sistema host [(BRITO, 2020)](#BRITO-2020). A imagem de um container no Docker gera um pacote de software leve, autônomo e executável que inclui tudo o que é necessário para executar um aplicativo [(DOCKER, 2020)](#DOCKER-2020).

A finalidade de utilização do Docker neste tutorial encontra-se em abstrair especificidades relacionadas ao sistema host durante a instalação e utilização das ferramentas de banco de dados. Os clusters que servirão para as provas de conceito serão criados sob containers levando em consideração as recomendações dos desenvolvedores das ferramentas utilizadas. A versão utilizada neste tutorial será a Docker Community Edition (Docker CE, versão 19.03, gratuita).

>@Suellen: cabe aqui uma imagem para expor o "visual" da aplicação Docker.

O CockroachDB é um dos bancos de dados selecionados para o tutorial. Ele é um banco de dados relacional que trabalha com linguagem SQL, suportada por uma API do PostgreSQL, capaz de fornecer escalabilidade e consistência em sistemas distribuídos. Ele também suporta transações ACID, além de possuir autogestão na replicação e fragmentação dos dados no cluster, evitando qualquer alteração manual nos dados [(COCKROACH LABS, 2020a)](#COCKROACH-2020A).

O CockroachDB é caracterizado por ser um sistema que permite o desenvolvimento de aplicações com alta disponibilidade. Seus recursos permitem manejar situações relacionadas a queda de alguns nós da infraestrutura de forma transparente, sem que a aplicação perca acesso aos dados [(PAT RESEARCH, 2020)](#PAT-2020).

A escolha do CockroachDB deve-se a documentação e materiais de apoio (blog, vídeos) disponíveis no site oficial para utilização do banco. Além de ser um banco de dados dedicado a tratar a disponibilidade. A versão utilizada é o CockroachDB (versão 20.1.7, gratuita).

>@Suellen: cabe aqui uma imagem para expor o "visual" da aplicação CockroachDB.

O MemSQL é o segundo banco de dados selecionado para o tutorial. Ele é um banco de dados relacional distribuído que lida com transações ACID e análises em tempo real, trabalhando com escalabilidade horizontal. Fornece suporte à sintaxe SQL e é compatível com o MySQL, permitindo com que aplicativos que usam de um driver do MySQL possam se conectar ao MemSQL de maneira transparente [(MEMSQL, 2020a)](#MEMSQL-2020A).

O MemSQL também tem como característica chave fornecer alta disponibilidade em um sistema distribuído através do compartilhamento de cópias dos dados entre os nós do cluster. Desta forma, é possível perder contato com alguns nós sem deixar o sistema todo inoperante. Quanto ao funcionamento das transações, para assegurar a disponibilidade, estas são confirmadas no disco como registros de log e replicadas automaticamente, suportando a queda de um nó e usando dados de logs para recuperar as transações confirmadas [(MEMSQL, 2020a)](#MEMSQL-2020A).

A escolha do MemSQL também é associada a documentação e materiais de apoio disponíveis no site oficial para utilização do banco. Além de ser um banco de dados que prioriza a disponibilidade. A versão utilizada é o MemSQL Software (versão 7.1, gratuita).

>@Suellen: cabe aqui uma imagem para expor o "visual" da aplicação MemSQL.

| :-------:
| [Voltar ao Sumário](#sumario)

<a id="instalacoes-sec2"></a>
# Instalação das Ferramentas

Neste tópico serão abordados os passos e códigos utilizados para instalar as ferramentas utilizadas ao longo do tutorial. A seção conterá informações como: partes de tutoriais oficiais da instalação já disponíveis na Internet; recomendações sobre os ambientes de instalação; prints de tela; e informações relacionadas a configuração do ambiente.

<a id="docker-sec2a"></a>
## Docker

<a id="cockroachdb-sec2b"></a>
## CockroachDB

<a id="memsql-sec2c"></a>
## MemSQL

| :-------:
| [Voltar ao Sumário](#sumario)

<a id="criar-cluster-sec3"></a>
# Criação do Cluster Utilizando o Docker

<a id="cockroachdb-sec3a"></a>
## CockroachDB

<a id="memsql-sec3b"></a>
## MemSQL

| :-------:
| [Voltar ao Sumário](#sumario)

<a id="praticas-sec4"></a>
# Trabalhando com a Disponibilidade: Práticas e Resultados

<a id="estudo-cockroachdb-sec4a"></a>
## Estudo de caso com o CockroachDB

<a id="estudo-memsql-sec4b"></a>
## Estudo de caso com o MemSQL

| :-------:
| [Voltar ao Sumário](#sumario)

<a id="conclusao-sec5"></a>
# Conclusão

<a id="aprendizados-sec5a"></a>
## Sumarização do que foi aprendido

<a id="glossario-sec6"></a>
# Glossário

| :-------:
| [Voltar ao Sumário](#sumario)

<a id="referencias-sec7"></a>
# Referências Bibliográficas

<a id="BRITO-2020"></a>
- BRITO, Michelli. [Containers e Docker](https://www.youtube.com/watch?v=TR8zX1D6abU). Canal Michelli Brito, 2020.
<a id="COCKROACH-2020A"></a>
- COCKROACH LABS. [CockroachDB: Distributed SQL](https://www.cockroachlabs.com/product/). Cockroach Labs, 2020a.
<a id="DOCKER-2020"></a>
- DOCKER. [What is a Container?: a standardized unit of software](https://www.docker.com/resources/what-container). Docker Inc. 2020.
<a id="MEMSQL-2020A"></a>
- MEMSQL. [How MemSQL Works](https://docs.memsql.com/v7.1/introduction/how-memsql-works/). MemSQL Docs, 2020a. 
<a id="MOLL-2019"></a>
- MOLL, Vinicius. [Como construir uma aplicação com Docker?](https://blog.geekhunter.com.br/docker-na-pratica-como-construir-uma-aplicacao/) GeekHunter, 2019.
<a id="MONGODB-2020"></a>
- MONGODB. [MongoDB Documentation: Replication](https://docs.mongodb.com/manual/replication/). 2020.
<a id="PAT-2020"></a>
- PAT RESEARCH. [CockroachDB](https://www.predictiveanalyticstoday.com/cockroachdb/). Pat Research - Predictive Analytics Today, 2020.
<a id="REZENDE-2013"></a>
- REZENDE, Ricardo. [Alta disponibilidade no banco de dados Oracle](https://www.devmedia.com.br/alta-disponibilidade-no-banco-de-dados-oracle/28971). DevMedia, 2013.
<a id="STONEBRAKER-2011"></a>
- STONEBRAKER, Michael, CATTELL, [Rick. 10 Rules for Scalable Performance in ‘Simple Operation’ Datastores](https://doi.org/10.1145/1953122.1953144). Communications Of The Acm, v. 54, n. 6, p. 72-80, jun. 2011.
<a id="STONEBRAKER-2007"></a>
- STONEBRAKER, Michael et al. [The End of an Architectural Era (It’s Time for a Complete Rewrite)](http://nms.csail.mit.edu/~stavros/pubs/hstore.pdf). VLDB '07: Proceedings Of The 33Rd International Conference On Very Large Data Bases, p. 1150-1160, jul. 2007.
<a id="YUGABYTE-2020"></a>
- YUGABYTE. [Northwind sample database](https://docs.yugabyte.com/latest/sample-data/northwind/). YugabytesDB, 2020.


# Fim do tutorial e dicas de formatação markdown
**----------------- não apagar os comandos / conteúdos abaixo para vermos como exemplos de marcação do markdown ----------------------**

<a name="a"></a>
# Dica de Sumário
- [Título Inicial](#ancora1)
  - [Mark](#ancora2)
  - [Jekyll Themes](#ancora3)
    - [Support or Contact](#ancora4)

<a id="ancora1"></a>
# Dicas de Formatação para o Markdown

**Site sobre comandos markdown:** <https://docs.pipz.com/central-de-ajuda/learning-center/guia-basico-de-markdown#open>

Este texto apresenta um [teste de link aqui](https://www.youtube.com/watch?v=5B4bHSiOOO8) de um vídeo do **YouTube**.

**Exemplo para add códigos diferentes sobre um mesmo tema:**

~~~javascript
Esta é uma linha de código para ser feita no JavaScript.
~~~

~~~php
Esta é uma linha de código para ser feita no PHP.
~~~

**Exemplo 1 para add figuras:**  --> [acesse este material](https://www.youtube.com/watch?v=nvPOUdz5PL4) e faça os passos. É basicamente lançar uma imagem para a área de 'Issues' do github, copiar o código gerado da figura e não salvá-la no Issues. Basta ir ao README e colar o código da imagem copiado no Issues.

**Exemplo 2 para add figuras:** --> add código HTML chamando o caminho da figura a partir do subdiretório da imagem que deseja exibir, tipo:
```markdown
<p align="center">
  <img src="image-gerais/logo-ppgccs.png" width="350" alt="texto de exemplo">
</p>
```

Nesta linha há o exemplo de um `trecho.codigo()` embutido no parágrafo, mostrando a formatação alterada.

Nesta linha há um link, mostrado por inteiro e clicável como este: <https://u01.appmifile.com/images/2019/06/15/b0920166-f3e8-4ec6-826a-7ee96c313197.png>

<a id="ancora2"></a>
## Mark

Markdown is a lightweight and easy-to-use syntax for styling your writing. It includes conventions for

```markdown
Syntax highlighted code block

# Header 1
## Header 2
### Header 3

- Bulleted
- List

1. Numbered
2. List

**Bold** and _Italic_ and `Code` text

[Link](url) and ![Image](src)
```

For more details see [GitHub Flavored Markdown](https://guides.github.com/features/mastering-markdown/).

<a id="ancora3"></a>
## Jekyll Themes

Your Pages site will use the layout and styles from the Jekyll theme you have selected in your [repository settings](https://github.com/suellenmartinelli/ProjetoTeste/settings). The name of this theme is saved in the Jekyll `_config.yml` configuration file.

<a id="ancora4"></a>
### Support or Contact

Having trouble with Pages? Check out our [documentation](https://docs.github.com/categories/github-pages-basics/) or [contact support](https://github.com/contact) and we’ll help you sort it out.


