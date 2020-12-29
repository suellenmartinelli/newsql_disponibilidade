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
	5. [Benchmarks com CockroachDB e MemSQL](#benchmark-sec1e)
2. [Instalação das Ferramentas](#instalacoes-sec2)
	1. [Docker](#docker-sec2a)
	2. [CockroachDB](#cockroachdb-sec2b)
	3. [MemSQL](#memsql-sec2c)
3. [Criação do Cluster Utilizando o Docker](#criar-cluster-sec3)
	1. [CockroachDB](#cockroach-sec3)
		- [Topologia do Cluster](#topologia-cockroach-sec3)
		- [Criação do Cluster](#cockroachdb-sec3a)
	2. [MemSQL](#memsql-sec3)
		- [Topologia do Cluster](#topologia-memsql-sec3)
		- [Criação do Cluster](#memsql-sec3b)
4. [Trabalhando com a Disponibilidade: Práticas e Resultados](#praticas-sec4)
	1. [Estudo de caso com o CockroachDB](#estudo-cockroachdb-sec4a)
	2. [Estudo de caso com o MemSQL](#estudo-memsql-sec4b)
	3. [Resultados e comparações entre o CockroachDB e o MemSQL](#resultados-sec4c)
5. [Conclusão](#conclusao-sec5)
	1. [Sumarização do que foi aprendido](#aprendizados-sec5a)
6. [Glossário](#glossario-sec6)
7. [Referências Bibliográficas](#referencias-sec7)

<a id="intro-sec1"></a>
# Introdução

A Introdução contempla uma visão geral dos tópicos a serem abordados no tutorial. Também são apresentados algumas descrições e explicações acerca dos recursos a serem utilizados neste tutorial. Aqui serão apresentadas definições respectivas a: NewSQL, disponibilidade, terminologias relacionadas aos recursos selecionados e contexto dos estudos de caso.

<a id="newsql-sec1a"></a>
## O que é NewSQL?

Os bancos de dados relacionais tradicionais surgiram em um tempo onde a necessidade de armazenamento e gravações eram menores e o acesso não era concorrido [(STONEBRAKER et al. 2007)](#STONEBRAKER-2007). Com a web 3.0, onde milhões de dados são gerados, gravados e acessados com rapidez, foi criado o NoSQL. Oferecendo acesso rápido e escalonamento horizontal, o NoSQL focou em resolver problemas relacionados à manutenção e interação com dados volumosos. Para lidar com o novo contexto o NoSQL se apoia no teorema CAP *(**C**onsistency, **A**vailability e **P**artition tolerance)*, onde para se obter alta disponibilidade se faz necessário manejar os níveis de consistência.

O NoSQL trouxe alterações em relação ao paradigma relacional em termos de uso e manutenção das bases de dados. O primeiro ponto a ser observado é que o NoSQL não utiliza a linguagem SQL para consultas e gravações, e para garantir disponibilidade os resultados podem não ser consistentes. Estas alterações geraram grandes dúvidas quanto a sua adesão por parte da comunidade que já estava habituada com os paradigmas tradicionais. Desta forma, iniciaram-se pesquisas para desenvolver um SGBD *(**S**istema de **G**erenciamento de **B**anco de **D**ados)* que utilizasse a mesma linguagem já conhecida e consolidada no mercado, que garantisse transações ACID *(**A**tomicity, **C**onsistency, **I**solation, **D**urability)*, que fossem escaláveis e altamente disponíveis. Como fruto destas pesquisas surgiram os SGBDs NewSQL. Segundo [Stonebraker e Cattell (2011)](#STONEBRAKER-2011), as cinco características de um SGBD NewSQL são: 
 
* Linguagem SQL como meio de interação entre o SGBD e a aplicação; 
* Suporte para transações ACID; 
* Controle de concorrência não bloqueante, para que as leituras e escritas não causem conflitos entre si; 
* Arquitetura que forneça um maior desempenho por nó de processamento; 
* Arquitetura escalável, com memória distribuída e com capacidade de funcionar em um aglomerado com um grande número de nós.

O paradigma NewSQL surge então para combinar os benefícios do paradigma relacional com o tratamento de Big Data suportados pelo paradigma NoSQL. Sistemas NewSQL são soluções modernas que buscam prover o mesmo desempenho escalável dos BDs NoSQL para transações OLTP *(Online Transaction Processing)* com suporte a todas as propriedades ACID, como encontrado nos bancos de dados relacionais [(KNOB et al., 2019)](#KNOB-2019).

<a id="disponibilidade-sec1b"></a>
## O que é Disponibilidade?

A disponibilidade é a uma característica de sistemas que podem se manter ativos pelo máximo de tempo possível. Em sistemas de banco de dados isto significa atender uma requisição do usuário (seja ela de leitura, escrita ou atualização) sempre que solicitado. Desta forma pode-se concluir que um sistema é disponível quando responde sempre às requisições com sucesso, e indisponível quando ocorre falha ao concretizar uma consulta [(REZENDE, 2013)](#REZENDE-2013). 

Uma das grandes diferenças entre os bancos de dados relacionais tradicionais e os bancos de dados NoSQL está no tratamento da disponibilidade. Para garantir disponibilidade, os bancos NoSQL podem manejar cópias das informações em vários servidores, clusters e/ou nós. A replicação através de redundância aumenta a disponibilidade dos dados, podendo ainda melhorar a capacidade de resposta à leituras, pois com diversas cópias vários clientes podem solicitar a leitura a partir de locais diferentes. 

Outro fator relativo às replicações é a tolerância a falhas. Na hipótese de um servidor, ou cluster, ou nó falhar, o sistema direciona a requisição para outro ponto que contenha o mesmo dado, logo, quanto maior o número de réplicas melhor poderão ser trabalhadas as questões relacionadas à tolerância a falhas [(MONGODB, 2020)](#MONGODB-2020).

Um conceito similar é a alta disponibilidade *(high avaliability)*, que caracteriza sistemas de informação resistentes a falhas de hardware, software e energia, cujo objetivo é manter os serviços disponíveis o maior tempo possível. Geralmente, quanto maior a necessidade de alta disponibilidade, maior precisa ser a redundância dos dados e custo das soluções, tendo em vista que isso depende do tipo de serviço (ramo da empresa, necessidades comerciais, etc) que se pretende disponibilizar [(WIKIPÉDIA, 2020)](#WIKI-2020). 

<a id="contexto-sec1c"></a>
## Contextualização do Tutorial

Como enredo deste tutorial, a base de dados Northwind será utilizada. Esta base foi originalmente criada pela Microsoft e tem sido usada como contexto de estudo para vários tutoriais relacionados a banco de dados. Os dados são relativos a um cenário de vendas de uma empresa fictícia chamada “Northwind Traders”, que importa e exporta alimentos para todo o mundo [(YUGABYTE, 2020)](#YUGABYTE-2020).

A base de dados Northwind inclui 14 tabelas e inclui dados sobre fornecedores, clientes, funcionários, produtos, distribuidores e ordens de pedidos. Os relacionamentos entre essas e demais entidades são apresentados na Figura X.

<p align="center">
  <img src="image-intro/diagramaER.png" width="550">
</p>
  <p align="center">
  <caption><span style="color:#696969"> Figura X: Diagrama Entidade Relacionamento da base Northwind | Fonte: Yugabyte (2020)</span></caption>
</p>

Diante do uso dessa base de dados por cada solução NewSQL selecionada, este tutorial irá apresentar um passo a passo que permite realizar uma prova de conceito acerca da disponiblidade dos dados em cada tecnologia NewSQL escolhida. Maiores detalhes sobre o conteúdo dessas provas de conceito são dados na seção [Trabalhando com a Disponibilidade: Práticas e Resultados](#praticas-sec4).

<a id="recursos-sec1d"></a>
## Recursos Utilizados

>@Suellen: um dos comentários da @Sahudy na apresentação foi "tentar falar o essencial na intro, deixar o tutorial enxuto". Pode ser que esta subsação diminua...

Os recursos que serão utilizados para a elaboração deste tutorial são: Docker; CockroachDB; e MemSQL.

O Docker é uma plataforma open source que fornece recursos para criar, executar, manejar e publicar containers [(MOLL, 2019)](#MOLL-2019). Containers são abstrações a nível de sistema operacional e se caracterizam por agrupar códigos, bibliotecas e dependências com o intuito de garantir a execução de um determinado aplicativo em um ambiente isolado do sistema host [(BRITO, 2020)](#BRITO-2020). A imagem de um container no Docker gera um pacote de software leve, autônomo e executável que inclui tudo o que é necessário para executar um aplicativo [(DOCKER, 2020)](#DOCKER-2020).

A finalidade de utilização do Docker neste tutorial encontra-se em abstrair especificidades relacionadas ao sistema host durante a instalação e utilização das ferramentas de banco de dados. Os clusters que servirão para as provas de conceito serão criados sob containers levando em consideração as recomendações dos desenvolvedores das ferramentas utilizadas. A versão utilizada neste tutorial será a Docker Community Edition (Docker CE, versão 19.03, gratuita).

>@Suellen: cabe aqui uma imagem para expor o "visual" da aplicação Docker.

O CockroachDB é um dos bancos de dados selecionados para o tutorial. Ele é um banco de dados relacional que trabalha com linguagem SQL, suportada por uma API do PostgreSQL, capaz de fornecer escalabilidade e consistência em sistemas distribuídos. Ele também suporta transações ACID, além de possuir autogestão na replicação e fragmentação dos dados no cluster, evitando qualquer alteração manual nos dados [(COCKROACH LABS, 2020a)](#COCKROACH-2020A).

O CockroachDB é caracterizado por ser um sistema que permite o desenvolvimento de aplicações com alta disponibilidade. Seus recursos permitem manejar situações relacionadas a queda de alguns nós da infraestrutura de forma transparente, sem que a aplicação perca acesso aos dados [(PAT RESEARCH, 2020)](#PAT-2020).

A escolha do CockroachDB deve-se a documentação e materiais de apoio (blog, vídeos) disponíveis no site oficial para utilização do banco. Além de ser um banco de dados dedicado a tratar a disponibilidade. A versão utilizada é o CockroachDB Core (versão 20.1.7, gratuita).

>@Suellen: cabe aqui uma imagem para expor o "visual" da aplicação CockroachDB.

O MemSQL é o segundo banco de dados selecionado para o tutorial. Ele é um banco de dados relacional distribuído que lida com transações ACID e análises em tempo real, trabalhando com escalabilidade horizontal. Fornece suporte à sintaxe SQL e é compatível com o MySQL, permitindo com que aplicativos que usam de um driver do MySQL possam se conectar ao MemSQL de maneira transparente [(MEMSQL, 2020a)](#MEMSQL-2020A).

O MemSQL também tem como característica chave fornecer alta disponibilidade em um sistema distribuído através do compartilhamento de cópias dos dados entre os nós do cluster. Desta forma, é possível perder contato com alguns nós sem deixar o sistema todo inoperante. Quanto ao funcionamento das transações, para assegurar a disponibilidade, estas são confirmadas no disco como registros de log e replicadas automaticamente, suportando a queda de um nó e usando dados de logs para recuperar as transações confirmadas [(MEMSQL, 2020a)](#MEMSQL-2020A).

A escolha do MemSQL também é associada a documentação e materiais de apoio disponíveis no site oficial para utilização do banco. Além de ser um banco de dados que prioriza a disponibilidade. A versão utilizada é o MemSQL Software (versão 7.1, gratuita).

>@Suellen: cabe aqui uma imagem para expor o "visual" da aplicação MemSQL.

<a id="benchmark-sec1e"></a>
## Benchmarks com CockroachDB e MemSQL

Benchmark (na computação) é o ato de comparar de forma eficiente e equivalente a performance entre dispositivos ou softwares utilizando um ou mais programas para efetuar simulações, testes padronizados e ensaios, analisando diferentes tipos de dados [(COSTA, 2020)](#COSTA-2020). Existem na literatura alguns estudos recentes que apresentam benchmarks com diferentes soluções NewSQL. Aqui, serão comentados dois estudos identificados.

O trabalho de [Knob et al. (2019)](#KNOB-2019) compara soluções NewSQL, sendo duas delas o MemSQL e CockroachDB, utilizando-se de dois softwares de benchmark (*Yahoo! Cloud Serving Benchmark - YCSB* e *Voter*) focados em transações OLTP (*Online Transaction Processing*) em um ambiente distribuído. Os experimentos consideraram um cluster de três nós físicos e as métricas avaliadas foram a taxa de transações executadas no tempo (*Throughput*) e a latência das transações, através da análise da média geral das latências. 

O YCSB gera uma carga de trabalho mista com operações de leitura e escrita, incluindo diferentes volumes de dados e número de requisições. A ferramenta realiza escolhas aleatórias, como as operações que serão feitas (INSERT, UPDATE, SELECT), qual registro ler ou escrever, e quantos registros examinar. Já o Voter simula a saturação de um cenário em que o BD receberá requisições constantes, sendo cada requisição associada ao voto de uma pessoa para um determinado candidato. Ao receber uma requisição, a aplicação invoca uma transação para atualizar o número total de votos de cada participante, enquanto uma segunda transação contabiliza todos os votos. Cada teste foi configurado com um fator de escala em 1000 e com 64 usuários virtuais emulados para manipulação (64 conexões simultâneas).

O estudo de [Knob et al. (2019)](#KNOB-2019) revelou que ao analisar as médias de transações por segundo, nos dois benchmarks, o MemSQL foi superior ao CockroachDB, tanto em ambientes que solicitam requisições variadas como uniformes. Já os resultados sobre a latência média do CockroachDB no benchmark YCSB mostrou que em 99% das requisições feitas ao BD, a latência média era de quase 24 segundos, apresentando um desempenho ruim do CockroachDB quando comparado ao MemSQL. Essa discrepância não ocorreu no Voter, que trabalhou com transações menores e de apenas um tipo. Assim, o MemSQL obteve alta taxa de *throughput* e baixa latência, com diferenças consideráveis ao CockroachDB, como apresenta os resultados da Tabela X.

<p align="center">
  <img src="image-intro/quadro-intro.png" width="620">
  </p>
  <p align="center">
  <caption><span style="color:#696969"> Tabela X: Valores obtidos nos benchmarks | Fonte: Adaptado de Knob et al. (2019) </span></caption>
</p>

O segundo estudo apresentado, desenvolvido por [Kaur e Sachdeva (2017)](#KAUR-2017), efetuou um benchmark com quatro soluções NewSQL (entre elas o CockroachDB e o MemSQL), dedicou-se a analisar o desempenho dos bancos ao lidarem com operações de leitura, gravação e atualização. Cada solução NewSQL foi instalada em um mesmo sistema operacional, configuradas com base de dados e carga de trabalho iguais. Como parâmetros considerados para gerar uma análise comparativa, foram extraídas a latência de leitura, a latência de gravação, a latência de atualização e o tempo de execução das operações, sendo a média obtida em cada parâmetro apresentado na Tabela Y.

<p align="center">
  <img src="image-intro/quadro2-intro.png" width="500">
  </p>
  <p align="center">
  <caption><span style="color:#696969"> Tabela Y: Valores obtidos no benchmark | Fonte: Adaptado de Kaur e Sachdeva (2017) </span></caption>
</p>

Novamente, o MemSQL se mostrou superior ao CockroachDB em relação aos diferentes parâmetros de latência. Inclusive, entre os demais bancos de dados (Volt DB e NuoDB) comparados no estudo de [Kaur e Sachdeva (2017)](#KAUR-2017), o CockroachDB foi o que apresentou as latências mais altas. O tempo de execução médio das consultas, mesmo sendo um pouco mais rápido que o MemSQL, não tira a vantagem do MemSQL, pensando no desempenho geral de cada aplicação.

| :-------:
| [Voltar ao Sumário](#sumario)

<a id="instalacoes-sec2"></a>
# Instalação das Ferramentas

Neste tópico serão abordados os passos e códigos utilizados para instalar as ferramentas utilizadas ao longo do tutorial. A seção conterá informações como: partes de tutoriais oficiais da instalação já disponíveis na Internet; recomendações sobre os ambientes de instalação; prints de tela; e informações relacionadas a configuração do ambiente.

<a id="docker-sec2a"></a>
## Docker

Para o tutorial de instalação do **Docker** será considerado um computador com o sistema operacional Linux Mint na versão 18.3. Informações sobre a instalação em outros sistemas operacionais podem ser consultados diretamente na documentação oficial por meio dos links:

- Windows: [Tutorial de instalação no Windows](https://docs.docker.com/docker-for-windows/install/)
	- *Observações importantes para Windows:* 
	- O docker para ser instalado precisa do Hyper - v, que é a virtualização do Windows, o Windows Home não traz este recurso, para isso é necessário atualizar a versão e a build, atualizar o WSL,  e instalar uma distro do Linux de sua preferência. Instruções de como realizar a verificação e a instalação presentes na documentação oficial da Microsoft: https://docs.microsoft.com/en-us/windows/wsl/install-win10#step-2---update-to-wsl-2
 	- Para as demais versões do Windows, basta seguir a documentação oficial do Docker com as instalações.
	- Após a instalação do docker verificar se está em um Container Linux, para o Windows Home os containers por padrão são Linux e não há como alterar, já nas demais versões a opção de outros containers vem habilitada. 
- Para verificar se está em um container Linux, com o Docker ativo, procure pelo ícone do docker na barra de tarefas e clique com o botão direito sobre ele, se houver uma opção  “Switch to Windows containers…”, significa que você está no container Linux, se a opção for  “Switch to Linux containers…”
significa que está na opção de containers do Windows, e para mudar, basta clicar nesta opção.

<p align="center">
<img src="image-gerais/LinuxContainers_Wind.jpg" width="300">
</p>
<p> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<caption><span style="color:#696969"> Figura X: Switch to Linux Containers | Fonte: do autor </span> </caption>
</p>
	
- O Docker no Windows possui uma interface Gráfica, onde é possível realizar algumas configurações e ações nos container e imagens 

<p align="center">
<img src="image-gerais/WinCont.png" width="550">
</p>
<p> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<caption><span style="color:#696969"> Figura X: Interface gráfica Containers | Fonte: do autor </span> </caption>
</p>
	
<p align="center">
<img src="image-gerais/winimage.png" width="550">
</p>
	
<p> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<caption><span style="color:#696969"> Figura X: Interface gráfica Imagens | Fonte: do autor </span> </caption>
</p>

 - As ações na interface gráfica são limitadas, para utilizar os recursos do Docker utilize o Power Shell.
 - Todos os comandos do docker utilizados neste capítulo podem ser reproduzidos no Windows sem o uso do comando sudo( comando de super usuário no Linux), para isso utilize o Power Shell e o execute como administrador.

	
<p align="center">
<img src="image-gerais/winshell.png" width="550">
</p>
<p> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<caption><span style="color:#696969"> Figura X: Interface gráfica Imagens | Fonte: do autor </span> </caption>
</p>
	
- Mac: [Tutorial de instalação no Mac](https://docs.docker.com/docker-for-mac/install/)

Antes de começar a instalação no Linux, é importante garantir que seu usuário tem permissões de administrador. Para testar se seu usuário possui permissão de administrador execute no terminal o comando `sudo -v`, se o terminal solicitar sua senha significa que você possui permissão, caso contrário será exibida uma mensagem de erro.

Após constatar que possui privilégios de administrador você deve atualizar o cache das listas de repositórios, para isto execute o comando `sudo apt-get update`. Pronto, privilégios checados, lista de repositórios atualizada, estamos prontos para a instalação!

Para começar a instalação devemos primeiro garantir que as dependências do instalador do docker estão satisfeitas, estas depêndencias são:

- `apt-transport-https`: para permitir que o gerenciador de pacotes transfira os dados através de https;
- `ca-certificates`: habilitar o sistema a verificar certificados de segurança;
- `curl`: para transfirir dados;
- `software-properties-common`: scripts para gerenciar o software.

Para instalar todos eles ao mesmo tempo podemos executar apenas um comando: `sudo apt-get install  curl apt-transport-https ca-certificates software-properties-common`. Não se preocupe em analisar se estes softwares já estão presentes no seu sistema, o `APT-GET` é inteligente e não irá baixar pacotes que já estão instalados, e caso a versão instalada seja antiga ele irá atualizar ;).

A instalação oficial do Docker não está presente nas listas básicas de aplicativos do Linux. Mas isto não é motivo para preocupação, com apenas duas linhas de código já seremos capazes de acessar o repositório oficial. O primeiro passo é adicionar a chave CPG oficial do docker para garantir a segurança enquanto baixamos os arquivos do repositório oficial, o comando é este: `curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -`.

Tendo adicionado a chave agora vamos adicionar o repositório da última versão estável do Docker em nossas lista através do comando: `sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"`. Como acabamos de adicionar um novo repositório em nossas listas, devemos atualizar novamente o cache com o comando `sudo apt-get update`.

*Obs.:* - Caso ocorra algum erro 404 ao procurar a release do Linux que está usando, significa que no momento a release não existe no repositório, neste caso altere o código, onde ele puxa a release do seu Linux, e insira manualmente uma release existente no  [repositório](https://download.docker.com/linux/ubuntu/dists/). Sugerimos a release **bionic**  `sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"`

Chegou a hora esperada: instalar o docker-ce. Para isto basta executar o comando: `sudo apt install docker-ce`. Após concluir o processo de instalação (que é todo automatizado) podemos confirmar se o docker está ligado através do comando: `sudo systemctl status docker`, caso tenha ocorrido tudo bem devemos observar uma mensagem deste tipo:

<p align="center">
  <img src="image-instalacoes/docker-status.png" width="530" height="80">
</p>

Neste ponto estamos habilitados a seguir com as instalações, pois nosso docker está instalado e operante :D.

<a id="cockroachdb-sec2b"></a>
## CockroachDB

Todas as versões do CockroachDB são distribuidas em formato binário, isto significa que não há um instalador. Para utilização do CockroachDB basta fazer o download dos arquivos para o sistema operacional utilizado, extrair em uma pasta e executar o sistema. Para este tutorial iremos utilizar a versão do sistema que funciona sobre container Docker, para isto utilizaremos a imagem distribuida oficialmente pelo fabricante através do Docker Hub.

Tendo o Docker já instalado, basta executar o comando `sudo docker pull cockroachdb/cockroach:v20.1.9`. Este comando irá verificar se esta imagem já existe em seu computador, caso não exista ele fará o download. Não é necessário mais nenhum passo para a instalação, a utilização desta imagem será abordada na seção de criação do cluster utilizando o [CockroachDB](#cockroachdb-sec3a), onde criaremos um container para cada nó da nossa arquitetura.


<a id="memsql-sec2c"></a>
## MemSQL

O MemSQL é uma ferramenta paga. Para a ocasião deste tutorial iremos utilizar a versão gratuita que possui diversas limitações de utilização, porém, servirá para nosso propósito de prova de conceito. Antes de iniciar a instalação é preciso criar uma conta para obter uma liçenca (chave de acesso) para a versão gratuita. O cadastro deve ser feito por meio [deste link](https://www.singlestore.com/free/).

A versão grátis do MemSQL trata-se de apenas um container Docker onde existem três instâncias do banco de dados. A fabricante chama esta instalação de "cluster-in-a-box" pois toda a configuração do banco acontece de forma automática dentro do container e o usuário não pode interferir (caixa preta). Para instalação do MemSQL basta criar um arquivo de configuração com informações básicas para que o Docker faça todo o trabalho, este arquivo é o `docker-compose.yaml` e ele deve conter este conteudo:

~~~docker-compose.yaml
version: '2'

services:
  memsql:
    image: 'memsql/cluster-in-a-box'
    ports:
      - 3306:3306
      - 8080:8080
    environment:
      LICENSE_KEY: <sua chave de acesso deve ser colocada aqui>
      START_AFTER_INIT: 'Y' 
~~~

Para entender melhor os passos que serão executados de forma automática pelo Docker faremos uma breve explicação do conteudo deste arquivo:

- A tag `services` contém toda informação relacionada ao container que o Docker deve configurar, neste caso o Docker irá criar um container chamado `memsql` que utilizará a imagem `memsql/cluster-in-a-box` presente no Docker Hub;
- A tag `ports` faz um mapeamento entre as portas do container e do computador host, sendo a primeira porta relativa ao container e a segunda ao host. Por exemplo, o comando `80:8888` indica que a porta 80 do container será mapeada para a porta 8888 do computador host. O arquivo de .yaml está fazendo um redirecionamento direto utilizando as mesmas portas para container e host, agora com o entendimento de como funciona você será capaz de manejar estas portas caso elas já estejam em uso no host, mantendo atenção para alterar apenas o 2º parâmetro;
- A tag `LICENSE_KEY` deve conter a chave de acesso que conseguimos ao se cadastrar no site oficial. Em um ambiente real de uso não é recomendado manter a chave de acesso salva no arquivo por questões de segurança, neste casos é recomendado utilizar as "variáveis de ambiente". Para mais informações sobre este tipo de utilização pode ser conferida na [documentação oficial](https://docs.singlestore.com/v7.1/guides/use-memsql/develop/getstarted/free/);
- A tag `START_AFTER_INIT` é apenas uma garantia para que o container não se desligue durante a utilização, deixe ela ali ;).

Ao executar o `docker-compose.yaml` o Docker pode criar alguns arquivos ocultos no local onde o arquivo se encontra, por isto é recomendado salvar este arquivo em uma pasta específica para o MemSQL. Após criar a pasta e salvar o arquivo o processo de instalação está concluido!. 

**Atenção**: 
- O download da imagem oficial do Docker Hub só vai acontecer na primeira inicialização do cluster que será descrita na seção de criação de cluster usando o [MemSQL](#memsql-sec3b);
- O sistema exige ao menos 10GB livres no HD para poder iniciar, ele irá ocupar todo este espaço, mas é um requisito para criar o cluster.

| :-------:
| [Voltar ao Sumário](#sumario)

<a id="criar-cluster-sec3"></a>
# Criação do Cluster Utilizando o Docker

<a id="cockroach-sec3"></a>
## CockroachDB

<a id="topologia-cockroach-sec3"></a>
### Topologia do Cluster

<a id="cockroachdb-sec3a"></a>
### Criação do Cluster

Para criar o cluster com o CockroachBD será necessário criar três containers, cada um terá uma instancia do banco de dados e representará um computador diferente. A comunicação entre os containers acontecerá por meio de uma rede interna do Docker, e este será o primeiro passo para criar o cluster. Para criar a rede devemos executar o comando: `docker network create -d bridge roachnet`. Este comando irá criar, no ambiente do Docker, uma rede chamada **roachnet**. Isto significa que apenas os containers podem ver e usar essa rede, exatamente como uma rede local. O nome roachnet é arbitrário e pode ser alternado conforme seu gosto, basta recordá-lo pois iremos utilizar nos próximos comandos.

Para organizar os arquivos do Docker devemos criar uma pasta chamada `cockroach-data`. dentro desta pasta devemos criar outras três, uma para cada container que iremos inicializar, sendo: `roach1`, `roach2` e `roach3`. **Dica:** crie esta pasta em um diretório com o caminho pouco complexo, pois nos próximos comandos nós iremos escrever este endereço.

Para iniciar o primeiro container iremos executar no terminal o seguinte comando:

~~~docker
docker run -d \
--name=roach1 \
--hostname=roach1 \
--net=roachnet \
-p 26257:26257 -p 8080:8080  \
-v "rota_para_a_pasta/cockroach-data/roach1:/cockroach/cockroach-data"  \
cockroachdb/cockroach:v20.1.7 start \
--insecure \
--join=roach1,roach2,roach3
~~~

Explicação:

- O `docker run` indica que um container deve ser iniciado, caso ele não exista, será criado;
- O flag `name` é a identificação do container que será criado, ele pode ser alterado, porém, existem outras referências para este nome, caso queira colocar outro nome tenha isto em mente e atualize todas as referências;
- O `hostname` serve para a identificação durante a configuração da rede interna;
- A flag `net` faz referência a rede na qual nosso container irá se conectar, no caso do exemplo vamos nos conectar na **roachnet** que foi criada nos passos anteriores, caso você tenha alterado o nome da rede no passo anterior **atenção aqui**;
- As flags `p` indicam o redirecionamento de portas do container -> host, no geral não precisam ser alteradas. Lembrando que as portas relacionadas container (1º parametro) não devem ser alternadas;
- A flag `-v` é um direcionamento entre uma pasta existente dentro do container e uma pasta no computador host, isto é necessário pois o container não tem um armazenamento permanente e todos os dados são apagados quando o container desliga. Os dados salvos nesta pasta ficarão salvos no computador host e serão usados pelo container;
- O comando `cockroachdb/cockroach:v20.1.9 start` irá iniciar, dentro do container recem criado, a imagem que fizemos o download na seção de instalação;
- A flag `insecure` faz parte da implementação voltada a teste do CockroachDB, ela **não deve ser alterada**;
- Uma das tags mais imporantes é a `join`, ela ira indicar quais containers devem se conectar dentro da rede local do Docker, no caso do exemplo os containers de hostname roach1,roach2 e roach3 serão conectados.

Após executar este comando teremos o container principal ativo, porém, ainda faltam os nós que compoem a estrutura básica do cockroach. Após entender bem a estrutua do comando que inicia o container principal podemos notar que para iniciar outro container só precisamos mudar o: `name`, `hostname`, e a rota/pasta da flag `v`. Como a conexão da maquina host será realizada apenas com o container principal, os outros containers (nós) não precisam de configuração de portas, a rede local do Docker basta.

Então para subir o container **roach2**:

~~~docker
docker run -d \
--name=roach2 \
--hostname=roach2 \
--net=roachnet \
-v "rota_para_a_pasta/cockroach-data/roach2:/cockroach/cockroach-data"  \
cockroachdb/cockroach:v20.1.7 start \
--insecure \
--join=roach1,roach2,roach3
~~~

E o container **roach3**:

~~~docker
docker run -d \
--name=roach3 \
--hostname=roach3 \
--net=roachnet \
-v "rota_para_a_pasta/cockroach-data/roach3:/cockroach/cockroach-data"  \
cockroachdb/cockroach:v20.1.7 start \
--insecure \
--join=roach1,roach2,roach3
~~~

Após executar estes comandos com sucesso teremos três containers ligados, cada um rodando uma instância do CockroachDB. Para inicializar o cluster basta executar o comando: `docker exec -it roach1 ./cockroach init --insecure`. Este comando irá iniciar o sistema do CockroachDB dentro do container **roach1** e toda a configuração restante acontecerá automaticamente. Neste ponto teremos um cluster de CockroachDB ativo, onde o container **roach1** é o principal e os outros são seus nós secundários :).

**Recordando**: Cada container é uma instalação unica do CockroachDB. O unico container que tem comunicação aberta com a maquina host é o principal. O dados utilizados pelo banco (incluindo os binários que salvam as informações armazenadas dentro do banco) serão salvas na pasta atrelada à tag `v`. A comunicação entre containers é feita via rede interna do Docker.

Os comandos aqui contidos para criação de containers são para Linux, caso necessite realizar a criação no Windows ou Mac acesse a [documentação](https://www.cockroachlabs.com/docs/v20.2/start-a-local-cluster-in-docker-windows) e escolha seu sistema operacional. 

<a id="memsql-sec3"></a>
## MemSQL

<a id="topologia-memsql-sec3"></a>
### Topologia do Cluster

<a id="memsql-sec3b"></a>
### Criação do Cluster

A criação do cluster utilizando o MemSQL acontece de forma transparente para o usuário, para iniciar o processo é necessário abrir o terminal e navegar até a pasta onde o arquivo `docker-compose.yaml` foi salvo. Após acessar a pasta executar o comando: `docker-compose up`, ao executar este comando o docker irá vasculhar a pasta atual por um arquivo `docker-compose.yaml` e quando encontrar irá executá-lo. Neste ponto todos os comandos escritos no arquivo `docker-compose.yaml` serão executados. Caso seja a primeira execução é neste ponto que a imagem do sistema será baixada do Docker Hub.

Se ao executar o documento  o sistema indicar que o *docker-compose up* não é um comando reconhecido, é necessário instalar o módulo de docker compose, acesse a  [documentação](https://docs.docker.com/compose/install/) siga as instruções referente ao seu sistema operacional.

| :-------:
| [Voltar ao Sumário](#sumario)

<a id="praticas-sec4"></a>
# Trabalhando com a Disponibilidade: Práticas e Resultados

Para realizar um teste de disponibilidade em cada uma das soluções NewSQL apresentadas, foram desenvolvidas instruções SQL (?????) que atendem a três tipos de comandos, sendo eles de escrita-escrita, leitura-escrita e leitura-leitura. Escrita-escrita é relacionado a comandos INSERT que efetuam a gravação de um novo registro em banco, leitura-escrita inclui instruções como UPDATE (para atualizar) e DELETE (para apagar) um registro existente em banco, e leitura-leitura é associado aos comandos SELECT para selecionar dados de uma ou mais tabelas. Para manter um padrão na quantidade de comandos, foram desenvolvidas 20 instruções para cada um dos tipos mencionados, gerando assim um total de 60 comandos.

A base de dados Northwind possui 13 tabelas no total (como mostrado na seção X), porém, vale ressaltar que os comandos apresentados para a prática destinam-se apenas às tabelas “customers” e “orders”. As instruções foram limitadas a estas duas tabelas justamente para ser possível avaliar resultados acerca da disponibilidade fornecida por diferentes soluções NewSQL que foram submetidas ao mesmo conteúdo de teste.

<p align="center">
  <img src="images-praticas/tables2-estudo-caso.PNG" width="500">
</p>
  <p align="center">
  <caption><span style="color:#696969"> Figura X: description | Fonte: ref yugabyte </span></caption>
</p>

Os 60 comandos do experimento prático são divididos em dois conjuntos (Grupo A e Grupo B), com 30 instruções cada. Essa divisão também distribui igualmente a variedade de comandos por tipo em cada grupo. Ou seja, cada grupo possui 10 comandos de escrita-escrita, mais 10 instruções de leitura-escrita e outros 10 comandos de leitura-leitura, organizados de maneira intercalada. Cada grupo de comandos precisa ser executado na mesma ordem, respeitando a sequência em que são apresentados neste tutorial.

Diante desta introdução, siga os procedimentos dados em cada estudo de caso a seguir. Após o passo a passo efetuado em cada estudo, este tutorial abordará sobre algumas métricas e resultados obtidos na aplicação dos comandos, respectivos à disponibilidade dos dados.

>@Suellen: um dos comentários da @Sahudy na planilha foi "slide 10. def dos conceitos em cada implementacao." Acredito que nesta seção, termos como JOIN, INSERT, UPDATE e outras coisas que aparecerem, precisam ter um explicação sucinta na seção Glossário.

>@Suellen: opções de formatação para os codes: retirar comantários; programar barra de rolagem vertical e tamanho fixo para a caixa de exibição do código; se necessário, aplicar quebra de linha nos comandos. Ou se ficar melhor, fornecer um link que dê aceso somente so SQL deste grupo de código.

<a id="estudo-cockroachdb-sec4a"></a>
## Estudo de caso com o CockroachDB

- **Passo 1:** Com o CockroachDB ativo com 3 nós em seu cluster e com o banco de dados Northwind pronto para uso, retorne para o terminal SQL. <br> Caso você tenha fechado esta tela, execute novamente a instrução `docker exec -it roach1 ./cockroach sql --insecure` em um terminal Linux e, na sequência, aplique um `USE northwind;`<br> Dentro do terminal SQL e do BD Northwind, **execute os comandos (Grupo A) apresentados, de uma só vez** (você também pode [acessar os comandos do Grupo A aqui](codes-sql/GRUPOA_comandos.sql)):

~~~SQL
INSERT INTO customers (customer_id, company_name, contact_name, contact_title, address, city, region, postal_code, country) VALUES ('NTLSU', 'Nestlé S.A.', 'Paul Bulcke', 'Accounting Manager', '5505 Blue Lagoon Drive', 'Vevey', 'Vaud', '78988-555', 'Suíça');

INSERT INTO orders (order_id, customer_id, employee_id, order_date, required_date, ship_via, freight, ship_name, ship_address, ship_city, ship_region, ship_postal_code, ship_country) VALUES (11078, 'NTLSU', 5, '2020-10-10', '2020-10-26', 2, 30.45, 'Nestlé S.A.', '5505 Blue Lagoon Drive', 'Vevey', 'Vaud', '78988-555', 'Suíça');

select count(ship_name) as pedidos_por_pais, ship_country from orders group by ship_country order by pedidos_por_pais desc;

UPDATE customers SET city = 'São Paulo' WHERE city = 'Sao Paulo';

UPDATE orders SET ship_city = 'São Paulo' WHERE ship_city = 'Sao Paulo';

select count(orders.ship_region) as pedidos_por_estado, customers.region from customers inner join orders on customers.customer_id = orders.customer_id where orders.ship_country like 'Brazil' group by customers.region order by pedidos_por_estado desc;

UPDATE orders SET ship_country = 'Switzerland' WHERE customer_id = 'NTLSU';

UPDATE customers SET country = 'Switzerland' WHERE customer_id = 'NTLSU';

select avg(freight) as media_frete, count(order_id) as quant_pedidos, ship_city from orders where ship_country like 'USA' group by ship_city order by media_frete;

INSERT INTO customers (customer_id, company_name, contact_name, contact_title, address, city, postal_code, country) VALUES ('MCDUS', 'McDonalds Corporation', 'Ray Kroc', 'Owner/Marketing Assistant', '110 N Carpenter St, Chicago, IL 60607', 'Chicago', '7785-000', 'USA');

INSERT INTO customers (customer_id, company_name, contact_name, contact_title, address, city, region, postal_code, country, phone) VALUES ('HEXSO', 'Hipermercado Extra', 'Tatiana Moreira', 'Marketing Assistant', 'R. Maria Cinto de Biagi, 164 - Jardim Santa Rosália', 'Sorocaba', 'SP', '18095-410', 'Brazil', '(15)3212-6750');

UPDATE orders SET freight = freight + (freight * 0.15) WHERE ship_country like 'USA';

select count(orders.ship_city) as pedidos_por_cidade, customers.city from customers inner join orders on customers.customer_id = orders.customer_id where orders.ship_country like 'Germany' or orders.ship_country like 'Italy' group by customers.city order by pedidos_por_cidade desc limit 5;

INSERT INTO orders (order_id, customer_id, employee_id, order_date, required_date, ship_via, freight, ship_name, ship_address, ship_city, ship_postal_code, ship_country) VALUES (11079, 'CACTU', 9, '2020-08-01', '2020-08-15', 1, 89.23, 'Cactus Comidas para llevar', 'Cerrito 333', 'Buenos Aires', '1010', 'Argentina');

select count(employee_id) as pedidos_por_empregado, employee_id from orders where ship_country like 'UK' or ship_country like 'France' or ship_country like 'Italy' group by employee_id;

INSERT INTO orders (order_id, customer_id, employee_id, order_date, required_date, ship_via, freight, ship_name, ship_address, ship_city, ship_postal_code, ship_country) VALUES (11080, 'CENTC', 4, '2020-06-03', '2020-07-12', 5, 45.13, 'Centro comercial Moctezuma', 'Sierras de Granada 9993', 'México D.F.', '05022', 'Mexico');

UPDATE customers SET country = 'Espanha' WHERE city = 'Madrid';

UPDATE orders SET ship_country = 'Espanha' WHERE ship_city = 'Madrid';

select max(orders.freight) as maior_frete_por_cidade, customers.city from customers inner join orders on customers.customer_id = orders.customer_id where orders.ship_country like 'USA' group by customers.city order by maior_frete_por_cidade desc;

INSERT INTO customers (customer_id, company_name, contact_name, contact_title, address, city, postal_code, country) VALUES ('STBCO', 'Starbucks Corporation', 'Kevin Johnson', 'Owner/Marketing Assistant', 'Ave. S, Seattle, WA 98134', 'Washington', '56999-320', 'USA');

select * from customers where contact_title like 'Owner' and fax is null;

UPDATE customers SET city = 'Seattle', region = 'WA' WHERE customer_id = 'STBCO';

select avg(orders.freight) as media_frete_por_regiao, customers.region from customers inner join orders on customers.customer_id = orders.customer_id where customers.region is not null group by customers.region order by media_frete_por_regiao;

INSERT INTO orders (order_id, customer_id, employee_id, order_date, required_date, ship_via, freight, ship_name, ship_address, ship_city, ship_region, ship_postal_code, ship_country) VALUES (11081, 'STBCO', 6, '2020-09-16', '2020-09-30', 3, 87.22, 'Starbucks Corporation', 'Ave. S, Seattle, WA 98134', 'Seattle', 'WA', '56999-320', 'USA');

select distinct ship_city from orders where ship_country not like 'Italy' and ship_country not like 'Ireland';

UPDATE orders SET shipped_date = '1998-12-20' WHERE EXTRACT(Year from required_date) = 1998;

INSERT INTO customers (customer_id, company_name, contact_name, contact_title, address, city, region, postal_code, country, phone) VALUES ('LAMBR', 'Lojas Americanas S.A.', 'Max Landesmann', 'Owner', 'Av. dos Oitis, nº 1.460, Distrito Industrial', 'Rio de Janeiro', 'RJ', '89000-565', 'Brazil', '(21)7841-0056');

update orders set shipped_date = '1998-10-01' WHERE EXTRACT(Year from required_date) = 1998 AND ship_country like 'USA' AND ship_region like 'OR' OR ship_region like 'ID';

select customers.contact_name, customers.phone, orders.ship_name, orders.order_id, EXTRACT(Year from orders.shipped_date) as ano_pedido from customers inner join orders on customers.customer_id = orders.customer_id WHERE orders.ship_region like 'WA' AND EXTRACT(Year from orders.shipped_date) between 1996 and 1997;

INSERT INTO orders (order_id, customer_id, employee_id, order_date, required_date, ship_via, freight, ship_name, ship_address, ship_city, ship_region, ship_postal_code, ship_country) VALUES (11082, 'LAMBR', 2, '2020-03-15', '2020-04-05', 1, 90.74, 'Lojas Americanas S.A.', 'Av. dos Oitis, nº 1.460, Distrito Industrial', 'Rio de Janeiro', 'RJ', '89000-565', 'Brazil');
~~~~

Observe as saídas emitidas pela aplicação. Se o CockroachDB permitir a execução dos comandos e tudo correr como esperado, o CockroachDB vai emitir o tempo de execução de cada comando. O retorno apresentado após a última instrução será semelhante ao mostrado na Figura X.

<p align="center">
  <img src="images-praticas/passo1-GA-saidas-terminal.png" width="300">
  </p>
  <p align="center">
  <caption><span style="color:#696969"> Figura X: Exemplos de saídas após executar os comandos | Fonte: Elaborado pelo(a) autor(a) </span></caption>
</p>

Observe saídas respectivas ao tempo de execução das instruções, uso de hardware e outras métricas ao acessar `http://localhost:8080` no seu navegador. Ele dará acesso ao *Cockroach Labs*, ambiente gráfico do CockroachDB, como no exemplo da Figura Y. Para alterar a visualização dos tipos de gráficos, basta acessar as áreas destacadas em verde na imagem.

<p align="center">
  <img src="images-praticas/passo1-GA-CKLabs.png" width="570">
 </p>
  <p align="center">
  <caption><span style="color:#696969"> Figura Y: Exemplos de gráficos obtidos via Cockroach Labs | Fonte: Elaborado pelo(a) autor(a) </span></caption>
</p>

- **Passo 2:** Agora vamos **forçar a queda de um dos nós secundários do nosso cluster** no CockroachDB. Para isso, acesse um segundo terminal Linux e aplique o comando `docker stop roach2`. Execute o comando e aguarde o nome do container ser mostrado na tela como retorno, como na Figura Z.

<p align="center">
  <img src="images-praticas/passo2-docker-stop.png" width="530">
 </p>
  <p align="center">
  <caption><span style="color:#696969"> Figura Z: Desativando um nó no cluster do CockroachDB | Fonte: Elaborado pelo(a) autor(a) </span></caption>
</p>

Para confirmar se nosso banco no CockroachDB está operando apenas com dois nós, execute a instrução `docker ps -a` para listar os containers no Docker. Se apenas o *roach2* aparecer com o status como *Exited* e os demais containers do CockroachDB como *Up*, quer dizer que tudo está ok.

- **Passo 3:** Com esta nova configuração do cluster, vamos executar nosso segundo grupo de comandos (Grupo B). <br> Novamente, retorne ao terminal SQL e **rode as instruções a seguir, de uma só vez** (você também pode [acessar os comandos do Grupo B aqui](codes-sql/GRUPOB_comandos.sql)):

~~~SQL
INSERT INTO orders (order_id, customer_id, employee_id, order_date, required_date, ship_via, freight, ship_name, ship_address, ship_city, ship_region, ship_postal_code, ship_country) VALUES (11083, 'QUEEN', 2, '2020-06-14', '2020-06-30', 5, 100.28, 'Queen Cozinha', 'Alameda dos Canàrios, 891', 'São Paulo', 'SP', '05487-020', 'Brazil');

INSERT INTO orders (order_id, customer_id, employee_id, order_date, required_date, ship_via, freight, ship_name, ship_address, ship_city, ship_postal_code, ship_country) VALUES (11084, 'QUICK', 6, '2020-05-02', '2020-06-05', 2, 210.88, 'QUICK-Stop', 'Taucherstraße 10', 'Cunewalde', '01307', 'Germany');

select EXTRACT(Month from order_date) mes_pedido, customer_id from orders where EXTRACT(Year from order_date) = 1998 AND ship_country like 'UK' order by mes_pedido;

UPDATE orders SET freight = freight + (freight * 0.25) WHERE ship_country like 'Brazil' OR ship_country like 'Argentina' OR ship_country like 'Venezuela';

select min(orders.freight) as menor_frete_por_cidade, customers.city from customers inner join orders on customers.customer_id = orders.customer_id where orders.ship_country like 'UK' or orders.ship_country like 'Ireland' group by customers.city order by menor_frete_por_cidade;

update orders set shipped_date = '2020-12-20' WHERE EXTRACT(Year from required_date) = 2020 AND shipped_date is null;

INSERT INTO customers (customer_id, company_name, contact_name, contact_title, address, city, region, postal_code, country) VALUES ('BKGUS', 'Burger King Corporation', 'Keith J. Kramer', 'Owner', '5505 Blue Lagoon Drive, Condado de Miami-Dade', 'Miami', 'Flórida', '78988-555', 'USA');

select contact_name, contact_title, company_name, address from customers where contact_title like 'Owner%' and phone is null order by contact_name;

INSERT INTO orders (order_id, customer_id, employee_id, order_date, required_date, ship_via, freight, ship_name, ship_address, ship_city, ship_region, ship_postal_code, ship_country) VALUES (11085, 'BKGUS', 8, '2020-09-06', '2020-11-01', 1, 65.97, 'Burger King Corporation', '5505 Blue Lagoon Drive, Condado de Miami-Dade', 'Miami', 'Flórida', '78988-555', 'USA');

UPDATE orders SET freight = freight - (freight * 0.50) WHERE ship_region like 'SP' OR ship_region like 'RJ';

select count(orders.ship_city) as pedidos_por_cidade, customers.city from customers inner join orders on customers.customer_id = orders.customer_id where orders.ship_country like 'Canada' group by customers.city order by pedidos_por_cidade desc;

INSERT INTO orders (order_id, customer_id, employee_id, order_date, required_date, ship_via, freight, ship_name, ship_address, ship_city, ship_postal_code, ship_country) VALUES (11086, 'EASTC', 9, '2020-11-12', '2020-11-30', 3, 102.97, 'Eastern Connection', '35 King George', 'London', 'WX3 6FW', 'UK');

INSERT INTO customers (customer_id, company_name, contact_name, contact_title, address, city, region, postal_code, country, phone) VALUES ('MLIBR', 'Mercado Livre', 'Fernanda Macedo', 'Order Administrator', 'Av. das Nações Unidas, 439 - Pres. Altino', 'São Paulo', 'SP', '06233-200', 'Brazil', '(11)1545-9898');

update orders set shipped_date = '2020-12-25' WHERE shipped_date is null;

select count(EXTRACT(Year from required_date)) as pedidos_em_1996, ship_country from orders where EXTRACT(Year from required_date) = 1996 group by ship_country;

UPDATE customers SET country = 'Spain' WHERE city in ('Madrid', 'Barcelona', 'Sevilla');

INSERT INTO customers (customer_id, company_name, contact_name, contact_title, address, city, region, postal_code, country, phone) VALUES ('SINMO', 'Sinhá Moça', 'Karla Silveira', 'Sales Manager', 'Rua Floriano Peixoto, 526', 'Capão Bonito', 'SP', '18300-250', 'Brazil', '(15)3542-5787');

select customers.contact_name, customers.phone, orders.ship_name, orders.order_id, EXTRACT(Year from orders.shipped_date) as ano_pedido from customers inner join orders on customers.customer_id = orders.customer_id WHERE orders.ship_city in ('Seattle', 'Boise', 'Elgin') AND EXTRACT(Year from orders.shipped_date) between 1996 and 1998 order by customers.contact_name;

UPDATE orders SET ship_country = 'Spain' WHERE ship_city in ('Madrid', 'Barcelona', 'Sevilla');

update customers set company_name = 'Carlinhos BBQ Lanches', contact_title = 'Owner' where customer_id = 'SINMO';

INSERT INTO orders (order_id, customer_id, employee_id, order_date, required_date, ship_via, freight, ship_name, ship_address, ship_city, ship_postal_code, ship_country) VALUES (11087, 'SINMO', 5, '2020-10-06', '2020-11-01', 1, 19.90, 'Carlinhos BBQ Lanches', 'Rua Floriano Peixoto, 526', 'Capão Bonito', '18300-250', 'Brazil');

select max(freight), ship_region from orders where ship_country = 'Brazil' group by ship_region;

INSERT INTO orders (order_id, customer_id, employee_id, order_date, required_date, ship_via, freight, ship_name, ship_address, ship_city, ship_postal_code, ship_country) VALUES (11088, 'BKGUS', 1, '2020-03-06', '2020-04-05', 4, 45.30, 'Burger King Corporation', '5505 Blue Lagoon Drive, Condado de Miami-Dade', 'Miami', '78988-555', 'USA');

INSERT INTO orders (order_id, customer_id, employee_id, order_date, required_date, ship_via, freight, ship_name, ship_address, ship_city, ship_postal_code, ship_country) VALUES (11089, 'SINMO', 9, '2020-04-03', '2020-06-09', 3, 80.90, 'Carlinhos BBQ Lanches', 'Rua Floriano Peixoto, 526', 'Capão Bonito', '18300-250', 'Brazil');

update orders set ship_region = 'SP' where ship_city = 'Capão Bonito' and ship_region is null;

select avg(orders.freight) as frete_medio_por_cidade, customers.city from customers inner join orders on customers.customer_id = orders.customer_id where orders.ship_country in ('Brazil', 'Mexico') group by customers.city order by frete_medio_por_cidade;

select distinct ship_city, ship_region, ship_country from orders where ship_region is not null AND ship_country in ('UK', 'USA', 'Canada');

update orders set ship_region = 'Flórida'  where ship_city = 'Miami' and ship_region is null;

update orders set shipped_date = '2020-12-02' WHERE EXTRACT(Year from required_date) = 2020 AND ship_via between 1 and 4;

select customers.contact_name, customers.phone, orders.order_id, EXTRACT(Month from orders.required_date) as mes_pedido from customers inner join orders on customers.customer_id = orders.customer_id WHERE EXTRACT(Year from orders.required_date) = 1996 AND EXTRACT(Month from orders.required_date) between 10 and 12 AND orders.ship_country like 'USA';
~~~

Observe as saídas emitidas pela aplicação, semelhantes a Figura X. Se o CockroachDB fornecer uma mensagem semelhante ao retorno obtido no Passo 1, então quer dizer que mesmo com 2 nós em atividade o banco manteve-se disponível. Caso queira observar outras métricas (gráficos) via Cockroach Labs, retorne ao `http://localhost:8080`.

<p align="center">
  <img src="images-praticas/passo1-GA-saidas-terminal.png" width="300">
  </p>
  <p align="center">
  <caption><span style="color:#696969"> Figura X: Exemplos de saídas após executar os comandos - COLOCAR PRINT GRUPO B | Fonte: Elaborado pelo(a) autor(a) </span></caption>
</p>

**Observação:** Caso um nó crítico seja desativado, antes de executar o Grupo B de comandos, você terá uma saída semelhante a da Figura Y. Isso representa que o banco de dados não suportou operar com 2 nós e só conseguiu fornecer disponibilidade com, no mínimo, 3 nós em operação. 

>@Suéllen: figura Y para apresentar saída COM ERRO, COM BD INDISPONÍVEL.

Em breve, uma avaliação deste resultado será feita na seção [Resultados e comparações entre o CockroachDB e o MemSQL](#resultados-sec4c).

<a id="estudo-memsql-sec4b"></a>
## Estudo de caso com o MemSQL

- **Passo 1:** Com o **MemSQL ativo com 5 nós em seu cluster e com o banco de dados Northwind** pronto para uso, retorne ao MemSQL Studio aberto em seu navegador via `http://localhost:8080`. <br> Dentro do MemSQL Studio acesse a opção *SQL Editor* no menu lateral e na área em branco aplique o comando `USE northwind;` para ser executado, clicando em *Run CTRL*, como mostra os destaques em verde na Figura A.

<p align="center">
  <img src="images-praticas/passo1-localizacao-memsql.png" width="630">
  </p>
  <p align="center">
  <caption><span style="color:#696969"> Figura A: Localização do SQL Editor no MemSQL Studio | Fonte: Elaborado pelo(a) autor(a) </span></caption>
</p>

Na área do *SQL Editor*, **execute os comandos (Grupo A) apresentados, de uma só vez**.  Para isso, deixe todos os comandos selecionados antes de clicar em *Run CTRL* (você também pode [acessar os comandos do Grupo A aqui](codes-sql/GRUPOA_comandos.sql)):

~~~SQL
INSERT INTO customers (customer_id, company_name, contact_name, contact_title, address, city, region, postal_code, country) VALUES ('NTLSU', 'Nestlé S.A.', 'Paul Bulcke', 'Accounting Manager', '5505 Blue Lagoon Drive', 'Vevey', 'Vaud', '78988-555', 'Suíça');

INSERT INTO orders (order_id, customer_id, employee_id, order_date, required_date, ship_via, freight, ship_name, ship_address, ship_city, ship_region, ship_postal_code, ship_country) VALUES (11078, 'NTLSU', 5, '2020-10-10', '2020-10-26', 2, 30.45, 'Nestlé S.A.', '5505 Blue Lagoon Drive', 'Vevey', 'Vaud', '78988-555', 'Suíça');

select count(ship_name) as pedidos_por_pais, ship_country from orders group by ship_country order by pedidos_por_pais desc;

UPDATE customers SET city = 'São Paulo' WHERE city = 'Sao Paulo';

UPDATE orders SET ship_city = 'São Paulo' WHERE ship_city = 'Sao Paulo';

select count(orders.ship_region) as pedidos_por_estado, customers.region from customers inner join orders on customers.customer_id = orders.customer_id where orders.ship_country like 'Brazil' group by customers.region order by pedidos_por_estado desc;

UPDATE orders SET ship_country = 'Switzerland' WHERE customer_id = 'NTLSU';

UPDATE customers SET country = 'Switzerland' WHERE customer_id = 'NTLSU';

select avg(freight) as media_frete, count(order_id) as quant_pedidos, ship_city from orders where ship_country like 'USA' group by ship_city order by media_frete;

INSERT INTO customers (customer_id, company_name, contact_name, contact_title, address, city, postal_code, country) VALUES ('MCDUS', 'McDonalds Corporation', 'Ray Kroc', 'Owner/Marketing Assistant', '110 N Carpenter St, Chicago, IL 60607', 'Chicago', '7785-000', 'USA');

INSERT INTO customers (customer_id, company_name, contact_name, contact_title, address, city, region, postal_code, country, phone) VALUES ('HEXSO', 'Hipermercado Extra', 'Tatiana Moreira', 'Marketing Assistant', 'R. Maria Cinto de Biagi, 164 - Jardim Santa Rosália', 'Sorocaba', 'SP', '18095-410', 'Brazil', '(15)3212-6750');

UPDATE orders SET freight = freight + (freight * 0.15) WHERE ship_country like 'USA';

select count(orders.ship_city) as pedidos_por_cidade, customers.city from customers inner join orders on customers.customer_id = orders.customer_id where orders.ship_country like 'Germany' or orders.ship_country like 'Italy' group by customers.city order by pedidos_por_cidade desc limit 5;

INSERT INTO orders (order_id, customer_id, employee_id, order_date, required_date, ship_via, freight, ship_name, ship_address, ship_city, ship_postal_code, ship_country) VALUES (11079, 'CACTU', 9, '2020-08-01', '2020-08-15', 1, 89.23, 'Cactus Comidas para llevar', 'Cerrito 333', 'Buenos Aires', '1010', 'Argentina');

select count(employee_id) as pedidos_por_empregado, employee_id from orders where ship_country like 'UK' or ship_country like 'France' or ship_country like 'Italy' group by employee_id;

INSERT INTO orders (order_id, customer_id, employee_id, order_date, required_date, ship_via, freight, ship_name, ship_address, ship_city, ship_postal_code, ship_country) VALUES (11080, 'CENTC', 4, '2020-06-03', '2020-07-12', 5, 45.13, 'Centro comercial Moctezuma', 'Sierras de Granada 9993', 'México D.F.', '05022', 'Mexico');

UPDATE customers SET country = 'Espanha' WHERE city = 'Madrid';

UPDATE orders SET ship_country = 'Espanha' WHERE ship_city = 'Madrid';

select max(orders.freight) as maior_frete_por_cidade, customers.city from customers inner join orders on customers.customer_id = orders.customer_id where orders.ship_country like 'USA' group by customers.city order by maior_frete_por_cidade desc;

INSERT INTO customers (customer_id, company_name, contact_name, contact_title, address, city, postal_code, country) VALUES ('STBCO', 'Starbucks Corporation', 'Kevin Johnson', 'Owner/Marketing Assistant', 'Ave. S, Seattle, WA 98134', 'Washington', '56999-320', 'USA');

select * from customers where contact_title like 'Owner' and fax is null;

UPDATE customers SET city = 'Seattle', region = 'WA' WHERE customer_id = 'STBCO';

select avg(orders.freight) as media_frete_por_regiao, customers.region from customers inner join orders on customers.customer_id = orders.customer_id where customers.region is not null group by customers.region order by media_frete_por_regiao;

INSERT INTO orders (order_id, customer_id, employee_id, order_date, required_date, ship_via, freight, ship_name, ship_address, ship_city, ship_region, ship_postal_code, ship_country) VALUES (11081, 'STBCO', 6, '2020-09-16', '2020-09-30', 3, 87.22, 'Starbucks Corporation', 'Ave. S, Seattle, WA 98134', 'Seattle', 'WA', '56999-320', 'USA');

select distinct ship_city from orders where ship_country not like 'Italy' and ship_country not like 'Ireland';

UPDATE orders SET shipped_date = '1998-12-20' WHERE EXTRACT(Year from required_date) = 1998;

INSERT INTO customers (customer_id, company_name, contact_name, contact_title, address, city, region, postal_code, country, phone) VALUES ('LAMBR', 'Lojas Americanas S.A.', 'Max Landesmann', 'Owner', 'Av. dos Oitis, nº 1.460, Distrito Industrial', 'Rio de Janeiro', 'RJ', '89000-565', 'Brazil', '(21)7841-0056');

update orders set shipped_date = '1998-10-01' WHERE EXTRACT(Year from required_date) = 1998 AND ship_country like 'USA' AND ship_region like 'OR' OR ship_region like 'ID';

select customers.contact_name, customers.phone, orders.ship_name, orders.order_id, EXTRACT(Year from orders.shipped_date) as ano_pedido from customers inner join orders on customers.customer_id = orders.customer_id WHERE orders.ship_region like 'WA' AND EXTRACT(Year from orders.shipped_date) between 1996 and 1997;

INSERT INTO orders (order_id, customer_id, employee_id, order_date, required_date, ship_via, freight, ship_name, ship_address, ship_city, ship_region, ship_postal_code, ship_country) VALUES (11082, 'LAMBR', 2, '2020-03-15', '2020-04-05', 1, 90.74, 'Lojas Americanas S.A.', 'Av. dos Oitis, nº 1.460, Distrito Industrial', 'Rio de Janeiro', 'RJ', '89000-565', 'Brazil');
~~~~

Observe as saídas emitidas pela aplicação. Se o MemSQL permitir a execução dos comandos e tudo correr como esperado, o MemSQL vai emitir o tempo de execução de cada comando, via *Log*, opção localizada no inferior da tela. O retorno apresentado após a última instrução será semelhante ao mostrado na Figura X.

<p align="center">
  <img src="images-praticas/passo1-GA-codes.png" width="670">
  </p>
  <p align="center">
  <caption><span style="color:#696969"> Figura X: Exemplos de saídas após executar os comandos | Fonte: Elaborado pelo(a) autor(a) </span></caption>
</p>

- **Passo 2:** Agora vamos **forçar a queda de um dos nós secundários (*Leaf*) do nosso cluster** no MemSQL. Para isso, no *SQL Editor* clique no botão *Console* na área inferior da tela do MemSQL Studio. Acesse a opção *Nodes* no menu lateral para ver todos os nós ativos e, com o *Console* ainda aberto, execute o comando `DETACH LEAF '127.0.0.1':3307;`. Aguarde ele confirmar a operação, como nas marcações em verde da Figura Z.

<p align="center">
  <img src="images-praticas/passo2-desativa-no2-memsql-NOVA.png" width="630">
 </p>
  <p align="center">
  <caption><span style="color:#696969"> Figura Z: Desativando um nó no cluster do MemSQL | Fonte: Elaborado pelo(a) autor(a) </span></caption>
</p>

Para confirmar se nosso banco no MemSQL está operando apenas com dois nós, consulte a lista de nós presente na tela. Se um dos nós do tipo *Leaf* mostrar o *CPU Usage* como *Unknown*, quer dizer que um nó foi desativado e tudo está ok.

- **Passo 3:** Com esta nova configuração do cluster, vamos executar nosso segundo grupo de comandos (Grupo B). <br> Novamente, retorne ao *SQL Editor* do MemSQL Studio e **rode as instruções a seguir, de uma só vez**. Para isso, deixe todos os comandos selecionados antes de clicar em *Run CTRL* (você também pode [acessar os comandos do Grupo B aqui](codes-sql/GRUPOB_comandos.sql)):


~~~SQL
INSERT INTO orders (order_id, customer_id, employee_id, order_date, required_date, ship_via, freight, ship_name, ship_address, ship_city, ship_region, ship_postal_code, ship_country) VALUES (11083, 'QUEEN', 2, '2020-06-14', '2020-06-30', 5, 100.28, 'Queen Cozinha', 'Alameda dos Canàrios, 891', 'São Paulo', 'SP', '05487-020', 'Brazil');

INSERT INTO orders (order_id, customer_id, employee_id, order_date, required_date, ship_via, freight, ship_name, ship_address, ship_city, ship_postal_code, ship_country) VALUES (11084, 'QUICK', 6, '2020-05-02', '2020-06-05', 2, 210.88, 'QUICK-Stop', 'Taucherstraße 10', 'Cunewalde', '01307', 'Germany');

select EXTRACT(Month from order_date) mes_pedido, customer_id from orders where EXTRACT(Year from order_date) = 1998 AND ship_country like 'UK' order by mes_pedido;

UPDATE orders SET freight = freight + (freight * 0.25) WHERE ship_country like 'Brazil' OR ship_country like 'Argentina' OR ship_country like 'Venezuela';

select min(orders.freight) as menor_frete_por_cidade, customers.city from customers inner join orders on customers.customer_id = orders.customer_id where orders.ship_country like 'UK' or orders.ship_country like 'Ireland' group by customers.city order by menor_frete_por_cidade;

update orders set shipped_date = '2020-12-20' WHERE EXTRACT(Year from required_date) = 2020 AND shipped_date is null;

INSERT INTO customers (customer_id, company_name, contact_name, contact_title, address, city, region, postal_code, country) VALUES ('BKGUS', 'Burger King Corporation', 'Keith J. Kramer', 'Owner', '5505 Blue Lagoon Drive, Condado de Miami-Dade', 'Miami', 'Flórida', '78988-555', 'USA');

select contact_name, contact_title, company_name, address from customers where contact_title like 'Owner%' and phone is null order by contact_name;

INSERT INTO orders (order_id, customer_id, employee_id, order_date, required_date, ship_via, freight, ship_name, ship_address, ship_city, ship_region, ship_postal_code, ship_country) VALUES (11085, 'BKGUS', 8, '2020-09-06', '2020-11-01', 1, 65.97, 'Burger King Corporation', '5505 Blue Lagoon Drive, Condado de Miami-Dade', 'Miami', 'Flórida', '78988-555', 'USA');

UPDATE orders SET freight = freight - (freight * 0.50) WHERE ship_region like 'SP' OR ship_region like 'RJ';

select count(orders.ship_city) as pedidos_por_cidade, customers.city from customers inner join orders on customers.customer_id = orders.customer_id where orders.ship_country like 'Canada' group by customers.city order by pedidos_por_cidade desc;

INSERT INTO orders (order_id, customer_id, employee_id, order_date, required_date, ship_via, freight, ship_name, ship_address, ship_city, ship_postal_code, ship_country) VALUES (11086, 'EASTC', 9, '2020-11-12', '2020-11-30', 3, 102.97, 'Eastern Connection', '35 King George', 'London', 'WX3 6FW', 'UK');

INSERT INTO customers (customer_id, company_name, contact_name, contact_title, address, city, region, postal_code, country, phone) VALUES ('MLIBR', 'Mercado Livre', 'Fernanda Macedo', 'Order Administrator', 'Av. das Nações Unidas, 439 - Pres. Altino', 'São Paulo', 'SP', '06233-200', 'Brazil', '(11)1545-9898');

update orders set shipped_date = '2020-12-25' WHERE shipped_date is null;

select count(EXTRACT(Year from required_date)) as pedidos_em_1996, ship_country from orders where EXTRACT(Year from required_date) = 1996 group by ship_country;

UPDATE customers SET country = 'Spain' WHERE city in ('Madrid', 'Barcelona', 'Sevilla');

INSERT INTO customers (customer_id, company_name, contact_name, contact_title, address, city, region, postal_code, country, phone) VALUES ('SINMO', 'Sinhá Moça', 'Karla Silveira', 'Sales Manager', 'Rua Floriano Peixoto, 526', 'Capão Bonito', 'SP', '18300-250', 'Brazil', '(15)3542-5787');

select customers.contact_name, customers.phone, orders.ship_name, orders.order_id, EXTRACT(Year from orders.shipped_date) as ano_pedido from customers inner join orders on customers.customer_id = orders.customer_id WHERE orders.ship_city in ('Seattle', 'Boise', 'Elgin') AND EXTRACT(Year from orders.shipped_date) between 1996 and 1998 order by customers.contact_name;

UPDATE orders SET ship_country = 'Spain' WHERE ship_city in ('Madrid', 'Barcelona', 'Sevilla');

update customers set company_name = 'Carlinhos BBQ Lanches', contact_title = 'Owner' where customer_id = 'SINMO';

INSERT INTO orders (order_id, customer_id, employee_id, order_date, required_date, ship_via, freight, ship_name, ship_address, ship_city, ship_postal_code, ship_country) VALUES (11087, 'SINMO', 5, '2020-10-06', '2020-11-01', 1, 19.90, 'Carlinhos BBQ Lanches', 'Rua Floriano Peixoto, 526', 'Capão Bonito', '18300-250', 'Brazil');

select max(freight), ship_region from orders where ship_country = 'Brazil' group by ship_region;

INSERT INTO orders (order_id, customer_id, employee_id, order_date, required_date, ship_via, freight, ship_name, ship_address, ship_city, ship_postal_code, ship_country) VALUES (11088, 'BKGUS', 1, '2020-03-06', '2020-04-05', 4, 45.30, 'Burger King Corporation', '5505 Blue Lagoon Drive, Condado de Miami-Dade', 'Miami', '78988-555', 'USA');

INSERT INTO orders (order_id, customer_id, employee_id, order_date, required_date, ship_via, freight, ship_name, ship_address, ship_city, ship_postal_code, ship_country) VALUES (11089, 'SINMO', 9, '2020-04-03', '2020-06-09', 3, 80.90, 'Carlinhos BBQ Lanches', 'Rua Floriano Peixoto, 526', 'Capão Bonito', '18300-250', 'Brazil');

update orders set ship_region = 'SP' where ship_city = 'Capão Bonito' and ship_region is null;

select avg(orders.freight) as frete_medio_por_cidade, customers.city from customers inner join orders on customers.customer_id = orders.customer_id where orders.ship_country in ('Brazil', 'Mexico') group by customers.city order by frete_medio_por_cidade;

select distinct ship_city, ship_region, ship_country from orders where ship_region is not null AND ship_country in ('UK', 'USA', 'Canada');

update orders set ship_region = 'Flórida'  where ship_city = 'Miami' and ship_region is null;

update orders set shipped_date = '2020-12-02' WHERE EXTRACT(Year from required_date) = 2020 AND ship_via between 1 and 4;

select customers.contact_name, customers.phone, orders.order_id, EXTRACT(Month from orders.required_date) as mes_pedido from customers inner join orders on customers.customer_id = orders.customer_id WHERE EXTRACT(Year from orders.required_date) = 1996 AND EXTRACT(Month from orders.required_date) between 10 and 12 AND orders.ship_country like 'USA';
~~~

Observe as saídas emitidas pela aplicação, semelhantes a Figura X. Se o MemSQL fornecer uma mensagem semelhante ao retorno obtido no Passo 1, então quer dizer que mesmo com um nó a menos funcionando no cluster, o banco manteve-se disponível. 

<p align="center">
  <img src="images-praticas/passo3-GB-memsql-NOVA.png" width="630">
  </p>
  <p align="center">
  <caption><span style="color:#696969"> Figura X: Exemplos de saídas após executar os comandos | Fonte: Elaborado pelo(a) autor(a) </span></caption>
</p>

**Observação:** Caso um nó crítico seja desativado, após executar o Grupo B de comandos você terá uma saída semelhante a da Figura Y, com um erro tipo  **ERROR 1777 ER_DISTRIBUTED_PARTITION_HAS_NO_INSTANCES**. <br> Isso representa que o banco de dados não suportou operar com 4 nós e só conseguiu fornecer disponibilidade com os 5 nós em operação. 

<p align="center">
  <img src="images-praticas/passo3-falha-GB-memsql.png" width="630">
 </p>
  <p align="center">
  <caption><span style="color:#696969"> Figura Z: Falha na execução de comandos com 4 nós ativos no MemSQL | Fonte: Elaborado pelo(a) autor(a) </span></caption>
</p>

Em relação ao MemSQL essa falha pode ocorrer quando o nó inativo tiver um nível de redundância (*redundancy_level*) igual a 2, equivalente a configuração de *High Availability*. Uma avaliação deste resultado será feita na seção a seguir.

<a id="resultados-sec4c"></a>
## Resultados e comparações entre o CockroachDB e o MemSQL

Na prova de conceito efetuada com o CockroachDB e o MemSQL sobre a disponibilidade das soluções, ambas tiveram resultados satisfatórios mesmo ao forçar a queda de um nó no cluster, conforme práticas efetuadas neste tutorial. Realmente as soluções cumprem o aspecto de alta disponibilidade (*high availability*) prometidos em suas documentações oficiais.

Porém, foram notadas algumas caraterísticas que diferenciam cada solução NewSQL utilizada quando se fala de alta disponibilidade na prática. O Quadro X apresenta um resumo dessas diferenças e de características presentes em cada prova de conceito realizada, sendo elas discutidas a seguir.

<p align="center">
  <img src="images-resultados/quadro-comparativo.png" width="550">
 </p>
  <p align="center">
  <caption><span style="color:#696969"> Quadro X: Características dos Bancos de Dados CockroachDB e MemSQL | <br> Fonte: Elaborado pelo(a) autor(a) </span></caption>
</p>

A justificativa para a elaboração desse layout na organização dos clusters deve-se à composição de uma estrutura mínima que atendesse ao fator de alta disponibilidade em cada solução NewSQL. Portanto, o conteúdo prático das provas de conceito foram iguais nos dois estudos de caso, com o intuito de verificar se a disponibilidade dos dados era mantida mesmo diante da queda de um nó, mas cada solução necessitava de uma composição diferente em seu cluster.

Todavia, para as duas soluções NewSQL, a queda de um dos nós no teste não poderia ser o Principal (ou Master), devido a ambos usarem o modelo de distribuição de coordenador-subordinado e terem a necessidade do nó Master estar em operação para o banco se manter disponível. 

Em relação aos nós secundários do CockroachDB, independente de qual nó tivesse a queda, o banco manteve-se disponível. Ele só ficou indisponível quando eram desativados os dois nós secundários e mantido somente o nó principal em funcionamento. Na Figura X há um exemplo em que foi feita a queda em todos os nós secundários e enviada uma consulta SELECT. O terminal do banco ficou “em espera” e só retornou a consulta ao reativar um dos nós secundários.

<p align="center">
  <img src="images-resultados/queda-total3-cockroachDB.png" width="630">
 </p>
  <p align="center">
  <caption><span style="color:#696969"> Figura X: Situação em que o banco ficaria indisponível no CockroachDB | <br> Fonte: Elaborado pelo(a) autor(a) </span></caption>
</p>

O comportamento exibido na Figura X é justificado pela lógica de armazenamento utilizada pelo CockroachDB, uma vez que os dados que pertencem a um mesmo registro armazenado em uma tabela são salvos em vários intervalos mapeados e replicados entre diferentes nós do cluster. Mesmo efetuando uma operação de leitura, como o SELECT, devido a arquitetura do CockroachDB o nó Master depende de consultar dados (por meio de chaves) em ranges localizados nos nós secundários [(COCKROACH LABS, 2020b)](#COCKROACH-2020B). 

Já no caso dos nós secundários existentes no cluster do MemSQL a disponibilidade dos dados depende em qual grupo de redundância cada nó opera. Um grupo de disponibilidade é um conjunto de nós que armazenam dados de maneira redundante para garantir alta disponibilidade. Cada grupo de disponibilidade contém uma cópia de cada partição do sistema - algumas como mestres e outras como réplicas. Atualmente, MemSQL suporta até dois grupos de disponibilidade [(MEMSQL, 2020b)](#MEMSQL-2020B), sendo eles o *redundancy-1* (redundância-1) e o *redundancy-* (redundância-2).

No ambiente organizado para a prova de conceito, os dois nós que pertencem ao grupo de redundância-1 não possuem cópias extras de seus dados e, caso ocorra uma falha em um nó secundário, o cluster fica offline até tal nó voltar ao sistema [(MEMSQL, 2020c)](#MEMSQL-2020C). Ou seja, independente do número de nós que o cluster tivesse, se todos os nós fossem de redundância-1, a queda de um dos nós tornaria o banco indisponível. Outros dois nós do cluster do MemSQL foram configurados com redundância-2, que são capazes de lidar com falhas em nós secundários e gerar réplicas dos dados para manter o banco de dados online. 

Mesmo com essa configuração, a disponibilidade do banco só será mantida se houver a queda de alguns nós secundários e não todos. Essas configurações que podem ser aplicadas nos nós refletem também no algoritmo de balanceamento utilizado por cada grupo de nós em relação a distribuição dos dados no cluster [(MEMSQL, 2020c)](#MEMSQL-2020C). O Quadro Y exibe diferentes combinações de nós (com status de online e offline) do cluster do MemSQL, considerando a mesma disposição elaborada para a prova de conceito, com o intuito de exemplifficar em quais casos a disponibilidade dos dados seria mantida.

<p align="center">
  <img src="images-resultados/quadro-disponibilidade-memsql.png" width="610">
 </p>
  <p align="center">
  <caption><span style="color:#696969"> Quadro Y: Cenários de disponibilidade do cluster no MemSQL | Fonte: Elaborado pelo(a) autor(a) </span></caption>
</p>

Diante de uma análise das combinações exemplificadas no Quadro Y, apenas duas combinações podem ser generalizadas ao considerar o cluster na situação de disponível: quando fica offline somente um nó de redundância-1; ou quando há queda de apenas um nó de redundância-2. Como o MemSQL trabalha com a fragmentação dos dados usando índices e cada nó é relacionado a um nó específico para a troca de dados (em sua configuração padrão), a queda de um nó em particular pode trazer mais danos ao funcionamento do cluster. Por exemplo, o nó configurado na 3310, ao ser o único nó de redundância-2 a sofrer uma queda, junto de qualquer outro nó de redundância-1 que também esteja offline, torna o cluster indisponível (cenários de 11 à 14). O cluster apresenta menos chance de se tornar indisponível quando, nesta mesma lógica, o nó de redundância-2 desativado é o de porta 3309 (cenários de 4 à 7).

De maneira geral, as soluções realmente conseguem manter a disponibilidade dos dados caso ocorra queda de um nó. Porém, para elaborar um banco de dados persistente a cenários mais “drásticos” é necessário utilizar da versão paga do software, disponível por cada solução NewSQL, com a finalidade de aplicar outras estruturas e configurações capazes de deixar tanto o CockroachDB como o MemSQL ainda mais robustos em relação ao fator de disponibilidade.

| :-------:
| [Voltar ao Sumário](#sumario)

<a id="conclusao-sec5"></a>
# Conclusão

A finalidade deste tutorial foi apresentar uma visão prática do aspecto de disponibilidade aplicado em duas soluções NewSQL diferentes por meio de uma prova de conceito. A disponibilidade foi abordada a partir do uso da mesma base de dados (a Northwind) nas aplicações CockroachDB e MemSQL, sendo replicado os mesmos grupos de comandos SQL em cada uma das provas de conceito.

Sobre a preparação dos ambientes de cada aplicação, como a instalação de ferramentas e a organização do cluster, usuários com mais experiência em ambiente Linux e com conhecimentos prévios em Docker podem apresentar mais facilidade para a realização deste tutorial. Quanto a “subir” a base de dados Northwind e efetuar comandos (como leituras e gravações) as soluções NewSQL podem ser de simples operação aos usuários que possuem conhecimentos básicos de SQL, uma vez que elas utilizam da mesma linguagem usada por bancos de dados relacionais.

Já em relação às provas de conceitos apresentadas neste tutorial, elas serviram para fornecer uma breve experiência sobre como cada solução NewSQL iria se comportar, frente a queda de um nó no cluster. Como discutido na seção de [Resultados e comparações entre o CockroachDB e o MemSQL](#resultados-sec4c), cada solução precisa de um ambiente mínimo diferente para fornecer alta disponibilidade dos dados e, por isso, o cluster de cada prova de conceito tinha quantidade de nós e configurações distintas. Todavia, os grupos de códigos e processos aplicados foram os mesmos nos dois estudos de caso.

Os dois estudos de caso apresentaram um funcionamento positivo do banco, mantendo a disponibilidade dos dados mesmo com a queda de um nó. Porém, é preciso levar em conta o modelo de distribuição e a lógica de armazenamento em que cada banco de dados funciona, para compreender os diferentes cenários em que tanto o CockroachDB como o MemSQL são capazes de manter a disponibilidade dos dados. Outro fator para garantir a alta disponibilidade é a aquisição das versões pagas do CockroachDB e do MemSQL, tendo em vista que as versões gratuitas das aplicações limitam o uso de determinadas configurações, capazes de manter a alta disponibilidade dos dados.

<a id="aprendizados-sec5a"></a>
## Sumarização do que foi aprendido

Entre os aprendizados que puderam ser absorvidos pelo grupo que desenvolveu o tutorial, e que também podem ser obtidos por parte de alunos e professores da área de Ciência da Computação ao estudarem este material são:

- Conhecimentos acerca dos aspectos teóricos que envolveram as provas de conceito apresentadas;
- Aprendizagem prática que incorporou desde a instalação de aplicações (Docker, CockroachDB e MemSQL), até a configuração dos clusters e realização das provas de conceito;
- Experiência prática no ambiente Linux para realizar todas as configurações necessárias e gerar um ambiente apto para ser utilizado por cada solução NewSQL;
- Experiência prática ao operar a base de dados northwind no CockroachDB e no MemSQL;
- Compreensão sobre as diferentes arquiteturas de cada solução NewSQL usada neste tutorial e como elas influenciam na disponibilidade de cada banco de dados.

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
<a id="COCKROACH-2020B"></a>
- COCKROACH LABS. [CockroachDB: Architecture Overview](https://www.cockroachlabs.com/docs/v20.1/architecture/). Cockroach Labs, 2020b.
<a id="COSTA-2020"></a>
- COSTA, Matheus Bigogno. [O que é Benchmark?](https://canaltech.com.br/hardware/O-que-e-Benchmark/). CanalTech, 2020.
<a id="DOCKER-2020"></a>
- DOCKER. [What is a Container?: a standardized unit of software](https://www.docker.com/resources/what-container). Docker Inc. 2020.
<a id="KAUR-2017"></a>
- KAUR, Karambir; SACHDEVA, Monika [Performance evaluation of NewSQL databases](https://ieeexplore.ieee.org/document/8068585). 2017 International Conference on Inventive Systems and Control (ICISC), 2017, Coimbatore, India. p. 1 - 5. DOI 10.1109/ICISC.2017.8068585.
<a id="KNOB-2019"></a>
- KNOB, Ronan R. et al. [Uma Análise de Soluções NewSQL](https://sol.sbc.org.br/index.php/erbd/article/view/8475). In: XV Escola Regional de Banco de Dados (ERBD), 2019, Chapecó. Porto Alegre: Sociedade Brasileira de Computação, p. 21 - 30. ISSN 2595-413X.
<a id="MEMSQL-2020A"></a>
- MEMSQL. [How MemSQL Works](https://docs.memsql.com/v7.1/introduction/how-memsql-works/). MemSQL Docs, 2020a. 
<a id="MEMSQL-2020B"></a>
- MEMSQL. [High Availability](https://docs.singlestore.com/v7.3/key-concepts-and-features/distributed-architecture/high-availability/). MemSQL Docs, 2020b. 
<a id="MEMSQL-2020C"></a>
- MEMSQL. [Managing High Availability (MemSQL Ops)](https://docs.singlestore.com/v7.1/tools/memsql-ops/managing-high-availability/). MemSQL Docs, 2020c. 
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
<a id="WIKI-2020"></a>
- WIKIPÉDIA. [Sistema de alta disponibilidade](https://pt.wikipedia.org/wiki/Sistema_de_alta_disponibilidade/). 2020.
<a id="YUGABYTE-2020"></a>
- YUGABYTE. [Northwind sample database](https://docs.yugabyte.com/latest/sample-data/northwind/). YugabytesDB, 2020.
