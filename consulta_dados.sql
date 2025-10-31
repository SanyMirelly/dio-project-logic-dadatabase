-- 1. Listar todos os pedidos com os produtos comprados
select o.idOrder, c.Fname, c.Lname, p.Pname, po.poQuantity, o.orderStatus from orders o
          inner join clients c on o.idOrderClient = c.idClient
		  inner join productOrder po on o.idOrder = po.idPOorder
          inner join product p on po.idPOproduct = p.idProduct
   order by o.idOrder;

-- 2. Quantos produtos cada cliente já comprou (somando quantidades)
select c.idClient, concat(c.Fname,' ',c.Lname) as Cliente, sum(po.poQuantity) as Total_Produtos from Clients c
          inner join Orders o on c.idClient = o.idOrderClient
          inner join ProductOrder po on o.idOrder = po.idPOorder
   group by c.idClient;

-- 3. Produtos mais vendidos
select p.Pname, sum(po.poQuantity) as Total_Vendido from Product p
          inner join ProductOrder po on p.idProduct = po.idPOproduct
   group by p.idProduct
   order by Total_Vendido desc;

-- 4. Fornecedores e os produtos que eles fornecem
select s.SocialName as Fornecedor, p.Pname as Produto, ps.quantity from Supplier s
         inner join ProductSupplier ps on s.idSupplier = ps.idPsSupplier
         inner join Product p on ps.idPsProduct = p.idProduct
   order by s.SocialName;

-- 5. Fornecedores que entregaram mais de 100 itens
select s.SocialName as Fornecedor, sum(ps.quantity) as Total_Fornecido from supplier s
         inner join ProductSupplier ps on s.idSupplier = ps.idPsSupplier
   group by s.idSupplier
   having sum(ps.quantity) > 100;

-- 6 Clientes que gastaram mais de R$100 em Frete
select c.idClient, concat(c.Fname,' ',c.Lname) as Cliente, sum(o.Freight) as Total_Gasto from Clients c
         inner join Orders o on c.idClient = o.idOrderClient
   group by c.idClient
   having sum(o.Freight) > 100;


-- Recuperar número total de clientes 
select count(*) as Total from Clients;

-- Verificar pedidos feitos pelos clientes
select * from Clients c, Orders o where c.idClient = idOrderClient;

-- Quais são atributos que estou recuperando
select concat(Fname,' ',Lname) as Client, idOrder as Request, orderStatus as Status from Clients c, Orders o where c.idClient = idOrderClient;

-- Recuperar quantos pedidos foram realizados pelos clientes
select c.idClient, Fname, count(*) as Number_of_Orders from Clients c
       inner join Orders o ON c.idClient = o.idOrderClient
   group by idClient;

