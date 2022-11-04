-- entrando no banco
use ecommerce_completo;

-- visualizando todas as tabelas do banco
show tables;

-- Quantos clientes existem no banco de dados?
select * from clients;
select count(*) from clients;

-- Quantos produtos estão cadastrador no banco?
select count(*) from product;

-- Quais clientes efetuaram compras?
select * from clients c, orders o where c.idClient = o.idOrderClient;

select c.idClient as ID, concat(Fname,' ',Lname) as Name, o.idOrderClient as Request 
from clients c, orders o 
where c.idClient = o.idOrderClient;

-- Quantos clientes efetuaram compras?
select count(*) from clients c, orders o where c.idClient = o.idOrderClient;

-- Como está o andamento das entregas?
select * from orders o, deliver d where d.idDorder = o.idOrder;

select o.idOrder as Request, d.Dstatus as Status 
from orders o, deliver d 
where idDorder = idOrder;

-- Com qual cartão de crédito o cliente efetuou a compra?
select * from orders o, payments p, credit_card cc 
where o.idOrderClient = p.idPclient 
and p.idPcredit_card = cc.idCredit_card;

select o.idOrder as Request, Cnumber as CardNumber
from orders o, payments p, credit_card cc 
where o.idOrderClient = p.idPclient 
and p.idPcredit_card = cc.idCredit_card;


-- recuperação de pedido com produto associado
select * from clients c 
inner join orders o on c.idClient = o.idOrderClient
inner join productOrder p on p.idPOorder = o.idOrder;

select * from clients c 
inner join orders o ON c.idClient = o.idOrderClient
inner join productOrder p on p.idPOorder = o.idOrder
order by idClient;

-- Quantos pedidos foram realizados por cada cliente?
select c.idClient, Fname, count(*) as Number_of_orders from clients c 
				inner join orders o ON c.idClient = o.idOrderClient
		group by idClient; 

