<p align="center">
  <img src="image-gerais/logos2.PNG" width="600" height="140" alt="texto de exemplo">
</p>

A estrutura deste tutorial online está fixada em cinco tópicos gerais que tratam desde os conceitos teóricos relacionados até o passo a passo das práticas a serem desenvolvidas. Consulte o sumário a seguir para estudar um tópico em particular ou acesse na sequência os materiais apresentados.

<a id="sumario"></a>
# Sumário
- [Introdução](#intro-sec1)
	- [O que é NewSQL?](#newsql-sec1a)
	- [O que é Disponibilidade?](#disponibilidade-sec1b)
	- [Contextualização do Tutorial](#contexto-sec1c)
	- [Recursos Utilizados](#recursos-sec1d)
- [Instalação das Ferramentas](#instalacoes-sec2)
	- [Docker](#docker-sec2a)
	- [CockroachDB](#cockroachdb-sec2b)
	- [MemSQL](#memsql-sec2c)
- [Criação do Cluster Utilizando o Docker](#criar-cluster-sec3)
	- [CockroachDB](#cockroachdb-sec3a)
	- [MemSQL](#memsql-sec3b)
- [Trabalhando com a Disponibilidade: Práticas e Resultados](#praticas-sec4)
	- [Estudo de caso com o CockroachDB](#estudo-cockroachdb-sec4a)
	- [Estudo de caso com o MemSQL](#estudo-memsql-sec4b)
- [Conclusão](#conclusao-sec5)
	- [Sumarização do que foi aprendido](#aprendizados-sec5a)
- [Glossário](#glossario-sec6)
- [Referências Bibliográficas](#referencias-sec7)

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

Esta mesma 

<a id="recursos-sec1d"></a>
## Recursos Utilizados

| :-------:
| [Voltar ao Sumário](#sumario)

<a id="instalacoes-sec2"></a>
# Instalação das Ferramentas

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

<a id="MONGODB-2020"></a>
- MONGODB. MongoDB Documentation: Replication. 2020. Disponível em: <https://docs.mongodb.com/manual/replication/>. Acesso em: 19 out. 2020.
<a id="REZENDE-2013"></a>
- REZENDE, Ricardo. Alta disponibilidade no banco de dados Oracle. DevMedia. 2013. Disponível em: <https://www.devmedia.com.br/alta-disponibilidade-no-banco-de-dados-oracle/28971>. Acesso em: 18 out. 2020.
<a id="STONEBRAKER-2011"></a>
- STONEBRAKER, M., CATTELL, R. 10 Rules for Scalable Performance in ‘Simple Operation’ Datastores. Communications Of The Acm, v. 54, n. 6, p. 72-80, jun. 2011. Disponível em: <https://doi.org/10.1145/1953122.1953144>. Acesso em: 17 out. 2020.
<a id="STONEBRAKER-2007"></a>
- STONEBRAKER, M. et al. The End of an Architectural Era (It’s Time for a Complete Rewrite). Vldb '07: Proceedings Of The 33Rd International Conference On Very Large Data Bases, p. 1150-1160, jul. 2007. Disponível em: <http://nms.csail.mit.edu/~stavros/pubs/hstore.pdf>. Acesso em: 18 out. 2020.
<a id="YUGABYTE-2020"></a>
- YUGABYTE. Northwind sample database. 2020. Disponível em: <https://docs.yugabyte.com/latest/sample-data/northwind/>. Acesso em: 19 out. 2020.


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


