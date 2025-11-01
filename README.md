# 🎯 Desafio de Projeto: Banco de dados para o Cenário de E-commerce

Este repositório faz parte de um Desafio de Projeto Lógico de Banco de Dados da DIO, focado em um cenário de e-commerce. A ideia foi pegar o modelo conceitual inicial e refiná-lo até chegar a um esquema lógico robusto, que pudesse ser testado com queries mais complexas dos que apresentadas durante a explicação do desafio.

## Diagrama E-commerce

É um fluxograma usado para modelar a estrutura de um banco de dados, podendo analisar entidades e atributos se relacionando entre si.

![ecommerce](https://github.com/SanyMirelly/dio-project-logic-dadatabase/blob/main/ecommerce_relational_schema.png)

## Estrutura do Projeto
O projeto está dividido em três scripts SQL principais:

1.  **`primeiro_projeto.sql`**: Contém todo o código DDL para construir a estrutura do banco de dados.
2.  **`dados_projeto.sql`**: Contém o código DML para preencher o banco de dados com dados de exemplos, possibilitando testes eficazes das consultas e o retorno de dados úteis
3.  **`consulta_dados.sql`**: Apresenta consultas SQL elaboradas para responder a perguntas de negócio. As queries utilizam cláusulas como `SELECT`, `WHERE`, `ORDER BY`, `INNER JOIN`, `GROUP BY` e `HAVING` para obter insights estratégicos dos dados.

## 🔍Consultas dos Dados

As seguintes perguntas foram formuladas e respondidas com SQL no arquivo `consulta_dados.sql`:

### 1. Listar todos os pedidos com os produtos comprados
   
```SQL
select o.idOrder, c.Fname, c.Lname, p.Pname, po.poQuantity, o.orderStatus from orders o
        inner join clients c on o.idOrderClient = c.idClient
		    inner join productOrder po on o.idOrder = po.idPOorder
        inner join product p on po.idPOproduct = p.idProduct
   order by o.idOrder;
```
![Clientes x pedidos](https://github.com/SanyMirelly/dio-project-logic-dadatabase/blob/main/Consultas/Pergunta_1.png)

### 2. Quantos produtos cada cliente já comprou (somando quantidades)
   
```SQL
select c.idClient, concat(c.Fname,' ',c.Lname) as Cliente, sum(po.poQuantity) as Total_Produtos from Clients c
          inner join Orders o on c.idClient = o.idOrderClient
          inner join ProductOrder po on o.idOrder = po.idPOorder
   group by c.idClient;
```
![Clientes x pedidos](https://github.com/SanyMirelly/dio-project-logic-dadatabase/blob/main/Consultas/Pergunta_2.png)

### 3. Produtos mais vendidos
   
```SQL
select p.Pname, sum(po.poQuantity) as Total_Vendido from Product p
          inner join ProductOrder po on p.idProduct = po.idPOproduct
   group by p.idProduct
   order by Total_Vendido desc;
```
![Clientes x pedidos](https://github.com/SanyMirelly/dio-project-logic-dadatabase/blob/main/Consultas/Pergunta_3.png)

### 4. Fornecedores e os produtos que eles fornecem
   
```SQL
select s.SocialName as Fornecedor, p.Pname as Produto, ps.quantity from Supplier s
         inner join ProductSupplier ps on s.idSupplier = ps.idPsSupplier
         inner join Product p on ps.idPsProduct = p.idProduct
   order by s.SocialName;
```
![Clientes x pedidos](https://github.com/SanyMirelly/dio-project-logic-dadatabase/blob/main/Consultas/Pergunta_4.png)

### 5. Fornecedores que entregaram mais de 100 itens
   
```SQL
select s.SocialName as Fornecedor, sum(ps.quantity) as Total_Fornecido from supplier s
         inner join ProductSupplier ps on s.idSupplier = ps.idPsSupplier
   group by s.idSupplier
   having sum(ps.quantity) > 100;
```
![Clientes x pedidos](https://github.com/SanyMirelly/dio-project-logic-dadatabase/blob/main/Consultas/Pergunta_5.png)

## Considerações

O projeto foi desenvolvido para cumprir os requisitos do desafio e, simultaneamente, replicar um ambiente próximo à realidade de um e-commerce. A intenção é que o banco de dados funcione como alicerce para análises e relatórios detalhados, ilustrando o potencial do SQL na transformação de dados em insights valiosos.
