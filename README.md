# Shift Eligibility

### Versões

- Ruby 3.0.2
- Rails 7.1.4

### Gems utilizadas

- `kaminari` para paginação;
- `pg` para utilização do postgres;
- `pry-rails` para estilização do console;
- `rswag-api` e `rswag-ui` para documentação a api;
- `rubocop`para verificação de lint;
- `rspec` para testes;

### Setup do Projeto

Este projeto utiliza o docker, acesse a raiz do projeto e execute o comando `docker compose up` para utilizá-lo.

### Documentação da API

- Acesse a raiz do projeto (`http://localhost:3000`) para verificar as rotas disponíveis na aplicação.

### Desempenho do Endpoint

Para melhorar o desempenho e eficiência na busca dos turnos disponíveis para um trabalhador e instalação, as medidas adotadas foram:

1. Otimização de Consultas ao Banco de Dados
    - Para evitar consultas desnecessárias ao banco, utilizei os joins adequados e tentei me utilizar ao máximo
    das consultas SQL, em detrimento de filtros realizados de forma lógica no código, iterando sobre listas, por exemplo.
    Além disso, foram adicionados índices para as colunas frequentemente usadas nos filtros.

2. Uso de Cache
    - Utilizei cache para armazenar os resultados das consultas, pois elas não mudam com tanta frequência. Localmente
    utilizei um cache _in memory_, porém em produção poderíamos utilizar o Redis. O cache foi implementado para armazenar a
    lista de turnos elegíveis para um trabalhador em uma instalação específica. Para evitar que dois trabalhadores tentem
    ser alocados para o mesmo turno, precisamos limpar o cache sempre que um dos shifts salvos mudarem.

3. Paginação
    - Paginação eficiente: Como forma de evitar o carregamento de grandes volumes de dados de uma vez, utilizei a paginação para dividir
    os resultados em blocos gerenciáveis.
