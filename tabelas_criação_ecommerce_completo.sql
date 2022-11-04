-- drop database ecommerce_completo;

-- criando o banco
create database ecommerce_completo;

-- entrando no banco
use ecommerce_completo;


-- CRIANDO AS TABELAS

-- cartão de crédito
create table credit_card(
	idCredit_card int auto_increment primary key,
    Cnumber char(19) not null,
    Cname varchar(30) not null,
    Expiration_date date not null
    
);
alter table credit_card auto_increment=1;

-- cliente
create table clients(
	idClient int auto_increment primary key,
    idCcredit_card int,
    Fname varchar(10),
    Minit char(3),
    Lname varchar(20),
    CPF char(11),
    Address varchar(255),
    constraint fk_client_ccard foreign key (idCcredit_card) references clients(idClient),
    constraint unique_cpf_client unique (CPF)
);
alter table clients auto_increment=1;

-- pedido
create table orders(
	idOrder int auto_increment primary key,
    idOrderClient int,
    idOrderDeliver int,
    orderStatus enum('Cancelado','Confirmado','Em processamento') default 'Em processamento',
    orderDescription varchar(255),
    sendValue float default 10,
    paymentCash boolean default false,
    constraint fk_orders_deliver foreign key (idOrderDeliver) references credit_card(idCredit_card),
    constraint fk_ordes_client foreign key (idOrderClient) references clients(idClient)
			on update cascade
);
alter table orders auto_increment=1;

-- produto
create table product(
	idProduct int auto_increment primary key,
    Pname varchar(255) not null,
    classification_kids bool default false,
	category enum('Eletrônico','Vestimenta','Brinquedos','Alimentos','Móveis') not null,
    rating enum('1', '2', '3', '4', '5') default '1',
    size varchar(10)
);
alter table product auto_increment=1;

-- pagamento
create table payments(
	idPayment int auto_increment primary key,
    idPclient int,
    typePayment enum('Boleto','Cartão'),
    idPcredit_card int,
    constraint fk_payment_client foreign key (idPclient) references clients(idClient),
    constraint fk_paymant_credit_card foreign key (idPcredit_card) references credit_card(idCredit_card)
);

-- entrega
create table deliver(
	idDeliver int auto_increment primary key,
	tracking_number varchar(15),
    Dstatus enum('Em processamento', 'Em trânsito', 'Entrege'),
    delivery_date date
);
alter table deliver auto_increment=1;

-- fornecedor
 create table supplier(
	idSupplier int auto_increment primary key,
    SocialName varchar(255) not null,
    CNPJ char(15) not null,
    contact char(11) not null,
    constraint unique_supplier unique (CNPJ)
);
alter table supplier auto_increment=1;
 
 -- estoque
 create table productStorage(
	idProdStorage int auto_increment primary key,
    storageLocation varchar(255),
    quantity int default 0
);
alter table productStorage auto_increment=1;
 
 -- vendedor (terceiro)
 create table seller(
	idSeller int auto_increment primary key,
    SocialName varchar(255) not null,
    AbstName varchar(255),
    CNPJ char(15),
    CPF char(9),
    location varchar(255),
    contact char(11) not null,
    constraint unique_cnpj_seller unique (CNPJ),
    constraint unique_cpf_seller unique (CPF)
);
alter table seller auto_increment=1;


-- CRIANDO AS TABELAS DE RELACIONAMENTO N:M

-- produto-pedido
create table productOrder(
	idPOproduct int,
    idPOorder int,
    poQuantity int default 1,
    poStatus enum('Disponível', 'Sem estoque') default 'Disponível',
    primary key (idPOproduct, idPOorder),
    constraint fk_productorder_product foreign key (idPOproduct) references product(idProduct),
    constraint fk_productorder_order foreign key (idPOorder) references orders(idOrder)

);

-- produto-estoque
create table storageLocation(
	idLproduct int,
    idLstorage int,
    location varchar(255) not null,
    primary key (idLproduct, idLstorage),
    constraint fk_storage_location_product foreign key (idLproduct) references product(idProduct),
    constraint fk_storage_location_storage foreign key (idLstorage) references productStorage(idProdStorage)
);

-- produto-fornecedor
create table productSupplier(
	idPsSupplier int,
    idPsProduct int,
    quantity int not null,
    primary key (idPsSupplier, idPsProduct),
    constraint fk_product_supplier_supplier foreign key (idPsSupplier) references supplier(idSupplier),
    constraint fk_product_supplier_prodcut foreign key (idPsProduct) references product(idProduct)
);

-- produto-vendedor(terceiro)
create table productSeller(
	idPseller int,
    idPproduct int,
    prodQuantity int default 1,
    primary key (idPseller, idPproduct),
    constraint fk_product_seller foreign key (idPseller) references seller(idSeller),
    constraint fk_product_product foreign key (idPproduct) references product(idProduct)
);

-- entrega-pedido*
-- Dstatus enum('Em processamento', 'Em trânsito', 'Entrege')
create table deliverOrder(
	idDOdeliver int,
    idDOorder int,
    Dstatus enum('Em processamento', 'Em trânsito', 'Entrege'),
    primary key (idDOdeliver, idDOorder),
    constraint fk_deliver_order_deliver foreign key (idDOdeliver) references deliver(idDeliver),
    constraint fk_deliver_order_order foreign key (idDOorder) references orders(idOrder)
    );