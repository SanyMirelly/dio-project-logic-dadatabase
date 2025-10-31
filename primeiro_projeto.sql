-- Criação do Banco de Dados para o Cenário de E-commerce --
-- drop database ecommerce;
create database ecommerce;
use ecommerce;

-- Criar Tabela Cliente--
create table Clients(
        idClient int auto_increment primary key,
        Fname varchar(10),
        Minit char(3),
        Lname varchar(20),
        CPF char(11) not null,
        Andress varchar(255)
);

alter table Clients auto_increment=1;

-- Criar Tabela Pagamento --
create table Payments(
    idClient int,
    idPayment int auto_increment,
    typePayment enum('Boleto','Cartão','Pix'),
    limitAvailable float,
    primary key(idPayment),
    constraint fk_payment_client foreign key (idClient) references Clients(idClient)
        on update cascade on delete cascade
);

-- Criar Tabela Produto --
-- Size = Dimenção do Produto --

create table Product(
        idProduct int auto_increment primary key,
        Pname varchar(255) not null,
        Classification_kids bool,
        Category enum('Eletrônico','Vestimenta','Brinquedos','Alimentos','Móveis') not null,
        Avaliação float default 0,
        Size varchar(10)
);

alter table Product auto_increment=1;

-- Criar Tabela Pedido --
create table Orders(
        idOrder int auto_increment primary key,
        idOrderClient int,
        idPayment int,
        orderStatus enum('Cancelado','Confirmado','Em processamento') default 'Em processamento',
        orderDescription varchar(255),
        Freight float default 10,
        PaymentCash bool default false,
        constraint fk_orders_client foreign key (idOrderClient) references Clients(idClient),
        constraint fk_orders_payment foreign key (idPayment) references Payments(idPayment)
    on update cascade on delete set null
);

alter table Orders auto_increment=1;

-- Criar Tabela Estoque --
create table ProductStock(
        idProductStock int auto_increment primary key,
        StockLocation varchar(255),
        Quantity int default 0
);

alter table ProductStock auto_increment=1;

-- Criar Tabela Fornecedor --
create table Supplier(
        idSupplier int auto_increment primary key,
        SocialName varchar(255) not null,
        CNPJ char(15) not null,
        Contact char(11) not null,
        constraint unique_supplier unique (CNPJ)
);

alter table Supplier auto_increment=1;
        
-- Criar Tabela Vendedor --
create table Seller(
        idSeller int auto_increment primary key,
        SocialName varchar(255) not null,
        AbstName varchar(255),
        CNPJ char(15),
        CPF char(9),
        Location varchar(255),
        Contact char(11) not null,
        constraint unique_cnpj_sellerr unique (CNPJ),
        constraint unique_cpf_sellerr unique (CPF)
);

alter table Seller auto_increment=1;

-- tabelas de relacionamentos M:N --

create table ProductSeller(
        idPseller int,
        idPproduct int,
        ProdQuantity int default 1,
        primary key (idPseller, idPproduct),
        constraint fk_product_seller foreign key (idPseller) references Seller(idSeller),
        constraint fk_product_product foreign key (idPproduct) references Product(idProduct)
);

alter table ProductSeller auto_increment=1;
        
create table ProductOrder(
        idPOproduct int,
        idPOorder int,
        PoQuantity int default 1,
        PoStatus enum('Disponível','Sem Estoque') default 'Disponível',
        primary key (idPOproduct, idPOorder),
        constraint fk_productorder_seller foreign key (idPOproduct) references product(idProduct),
        constraint fk_productorder_product foreign key (idPOorder) references Orders(idOrder)
);

alter table ProductOrder auto_increment=1;
        
create table StockLocation(
        idLproduct int,
        idLStock int,
        Location varchar (255) not null,
        primary key (idLproduct, idLStock),
        constraint fk_stock_location_product foreign key (idLproduct) references product(idProduct),
        constraint fk_stock_location_stock foreign key (idLStock) references ProductStock(idProductStock)
);

alter table StockLocation auto_increment=1;

create table ProductSupplier(
	    idPsSupplier int,
        idPsProduct int,
        quantity int not null,
        primary key (idPsSupplier, idPsProduct),
        constraint fk_product_supplier_supplier foreign key (idPsSupplier) references Supplier(idSupplier),
        constraint fk_product_supplier_product foreign key (idPsProduct) references Product(idProduct)
);

alter table ProductSupplier auto_increment=1;

show tables;
show databases;

use information_schema;
desc referential_constraints;
select * from referential_constraints where constraint_schema = 'ecommerce';


