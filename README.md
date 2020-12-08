
# Tutorial sobre diponibilidade em NewSQL

Projeto final da matéria de TBD_2020

# SUMÁRIO

- [INTRODUÇÃO](#INTRODUÇÃO)
	- [O que é NewSQL?](#O-que-é-NewSQL?)
	- [O que é Disponibilidade?](#O-que-é-Disponibilidade?)
	- [Contextualização do Tutorial](#Contextualização-do-Tutorial)
	- [Recursos Utilizados](#Recursos-Utilizados)
- [INSTALAÇÃO DAS FERRAMENTAS](#INSTALAÇÃO-DAS-FERRAMENTAS)
	- [Docker](#Docker)
	- [CockroachDB](#CockroachDB)
	- [MemSQL](#MemSQL)
- [CRIAÇÃO DO CLUSTER UTILIZANDO O DOCKER](#CRIAÇÃO-DO-CLUSTER-UTILIZANDO-O-DOCKER)
	- [CockroachDB](#CockroachDB)
	- [MemSQL](#MemSQL)
- [TRABALHANDO COM A DISPONIBILIDADE: PRÁTICAS E RESULTADOS](#TRABALHANDO-COM-A-DISPONIBILIDADE-PRÁTICAS-E-RESULTADOS)
	- [Estudo de caso com o CockroachDB](#Estudo-de-caso-com-o-CockroachDB)
	- [Estudo de caso com o MemSQL](#Estudo-de-caso-com-o-MemSQL)
- [CONCLUSÃO](#CONCLUSÃO)
	- [Sumarização do que foi aprendido](#Sumarização-do-que-foi-aprendido)
- [GLOSSÁRIO](#GLOSSÁRIO)
- [Referências Bibliográficas](#Referências-Bibliográficas)




## INTRODUÇÃO
A estrutura deste tutorial online está fixada em cinco tópicos gerais que tratam desde os conceitos relacionados até o passo a passo das práticas a serem desenvolvidas. Também são apresentados as descrições acerca da configuração dos recursos utilizados. Este primeiro tópico foca em expor algumas definições respectivas a: NewSQL, disponibilidade e terminologias relacionadas aos recursos selecionados.

### O que é NewSQL?
Os bancos de dados relacionais tradicionais surgiram em um tempo onde a necessidade de armazenamento e gravações eram menores e o acesso não era concorrido (STONEBRAKER et al. 2007). Com a web 3.0, onde milhões de dados são gerados, gravados e acessados com rapidez,  foi criado o NoSQL. Oferecendo acesso rápido e escalonamento horizontal, o NoSQL objetivou-se em resolver problemas relacionados à manutenção e interação com dados volumosos. Para lidar com o novo contexto o NoSQL se apoia no teorema CAP (Consistency, Availability e Partition tolerance), onde para se obter alta disponibilidade se faz necessário manejar os níveis de consistência.

O NoSQL trouxe alterações em relação ao paradigma relacional em termos de uso e manutenção das bases de dados. O primeiro ponto a ser observado é que o NoSQL não utiliza a linguagem SQL para consultas e gravações, e para garantir disponibilidade os resultados podem não ser consistentes.
 Estas alterações geraram grandes dúvidas quanto a sua adesão por parte da comunidade que já estava habituada com os paradigmas tradicionais, desta forma, iniciaram pesquisas para desenvolver um SGBDR que utilizasse a mesma linguagem já conhecida e consolidada no mercado, garantisse transações ACID e fossem escaláveis e altamente disponíveis. Fruto destas pesquisas surgiram os SGBDs New SQL. Segundo Stonebraker e Cattel (2011), as cinco características de um SGBD NewSQL são: 
 
* Linguagem SQL como meio de interação entre o SGBD e a aplicação; 
* Suporte para transações ACID; 
* Controle de concorrência não bloqueante, para que as leituras e escritas não causem conflitos entre si; 
* Arquitetura que forneça um maior desempenho por nó de processamento; 
* Arquitetura escalável, com memória distribuída e com capacidade de funcionar em um aglomerado com um grande número de nós.

### O que é Disponibilidade?
### Contextualização do Tutorial
### Recursos Utilizados
## INSTALAÇÃO DAS FERRAMENTAS
### Docker
### CockroachDB
### MemSQL
## CRIAÇÃO DO CLUSTER UTILIZANDO O DOCKER
### CockroachDB
### MemSQL
## TRABALHANDO COM A DISPONIBILIDADE: PRÁTICAS E RESULTADOS
### Estudo de caso com o CockroachDB
### Estudo de caso com o MemSQL
## CONCLUSÃO
### Sumarização do que foi aprendido
## GLOSSÁRIO
## Referências Bibliográficas




-------------------------------

<a name="a"></a>
# Sumário
- [Título Inicial](#ancora1)
  - [Mark](#ancora2)
  - [Jekyll Themes](#ancora3)
    - [Support or Contact](#ancora4)



<a id="ancora1"></a>
# Título Inicial - NewSQL e Disponibilidade

Este texto apresenta um [teste de link aqui](https://www.youtube.com/watch?v=5B4bHSiOOO8) de um vídeo do **YouTube**.

Este texto apresenta outro [teste de link aqui](https://miro.medium.com/max/700/0*SjaSaU5YPd8u0Mr8), agora usando como exemplo uma **imagem**.

Nesta linha há o exemplo de um `trecho.codigo()` embutido no parágrafo, mostrando a formatação alterada.

Nesta linha há um link, mas que é mostrado por inteiro na página e é clicável como este: <https://u01.appmifile.com/images/2019/06/15/b0920166-f3e8-4ec6-826a-7ee96c313197.png>

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


