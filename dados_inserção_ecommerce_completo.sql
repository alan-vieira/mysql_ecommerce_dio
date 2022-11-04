-- INSERÇÃO DE DADOS

-- entrando no banco
use ecommerce_completo;

-- monstrando as tabelas do banco
show tables;

select * from clients;
-- tabela clientes
-- idClient, Fname, Minit, Lname, CPF, Address
insert into clients (Fname, Minit, Lname, CPF, Address) 
	   values('Maria','M','Silva', 12346789,'rua silva de prata 29, Carangola - Cidade das flores'),
		     ('Matheus','O','Pimentel', 987654321,'rua alemeda 289, Centro - Cidade das flores'),
			 ('Ricardo','F','Silva', 45678913,'avenida alemeda vinha 1009, Centro - Cidade das flores'),
			 ('Julia','S','França', 789123456,'rua lareijras 861, Centro - Cidade das flores'),
			 ('Roberta','G','Assis', 98745631,'avenidade koller 19, Centro - Cidade das flores'),
			 ('Isabela','M','Cruz', 654789123,'rua alemeda das flores 28, Centro - Cidade das flores');
             
select * from product;
-- tabela produtos
-- idProduct, Pname, classification_kids, category, rating, size
insert into product (Pname, classification_kids, category, rating, size) values
							  ('Fone de ouvido',false,'Eletrônico','4',null),
                              ('Barbie Elsa',true,'Brinquedos','3',null),
                              ('Body Carters',true,'Vestimenta','5',null),
                              ('Microfone Vedo - Youtuber',False,'Eletrônico','4',null),
                              ('Sofá retrátil',False,'Móveis','3','3x57x80'),
                              ('Farinha de arroz',False,'Alimentos','2',null),
                              ('Fire Stick Amazon',False,'Eletrônico','3',null); 
                              
select * from orders;
-- tabela pedidos
-- idOrder, idOrderClient, orderStatus, orderDescription, sendValue, paymentCash
insert into orders (idOrderClient, orderStatus, orderDescription, sendValue, paymentCash) values 
							 (1, default,'compra via aplicativo',null,1),
                             (2,default,'compra via aplicativo',50,0),
                             (3,'Confirmado',null,null,1),
                             (4,default,'compra via web site',150,0);    
						
select * from credit_card;
-- tabela cartão de crédito
-- idCredit_card, idCcClient, Cnumber, Cname, Expiration_date
insert into credit_card (idCcClient, Cnumber, Cname, Expiration_date) values
	(2,'8638-5407-3631-8196','Matheus Pimentel','2028-11-01'),
    (3,'7106-4239-7093-1515','Ricardo Silva','2024-02-01'),
    (4,'6492-5655-8241-3530','Julia França','2027-09-01'),
    (4,'2868-5606-5152-5706','Julia França','2026-01-01'); 

select * from payments;
-- tabela pagamento
-- idPayment, idPclient, typePayment, idPcredit_card
insert into payments (idPclient, typePayment, idPcredit_card) values
	(1, 'Boleto', null),
    (2, 'Cartão', 1),
    (3, 'Cartão', 2),
    (4, 'Cartão', 3);
    
select * from deliver;
-- tabela transporte
-- idDeliver, idDorder, tracking_number, Dstatus, delivery_date
insert into deliver (idDorder, tracking_number, Dstatus, delivery_date) values
	(1,'11111111111111','Entrege','2022-01-01'),
	(2,'22222222222222','Em trânsito','2022-03-22'),
    (3,'33333333333333','Em processamento','2022-03-25'),
    (4,'44444444444444','Em processamento','2022-04-02');    
    
select * from supplier;
-- tabela fornecedor
-- idSupplier, SocialName, CNPJ, contact
insert into supplier (SocialName, CNPJ, contact) values 
							('Almeida e filhos', 123456789123456,'21985474'),
                            ('Eletrônicos Silva',854519649143457,'21985484'),
                            ('Eletrônicos Valma', 934567893934695,'21975474');  
                            
select * from seller;
-- tabela vendedor terceiro
-- idSeller, SocialName, AbstName, CNPJ, CPF, location, contact
insert into seller (SocialName, AbstName, CNPJ, CPF, location, contact) values 
						('Tech eletronics', null, 123456789456321, null, 'Rio de Janeiro', 219946287),
					    ('Botique Durgas',null,null,123456783,'Rio de Janeiro', 219567895),
						('Kids World',null,456789123654485,null,'São Paulo', 1198657484);  
                        
select * from productStorage;
-- tabela estoque
-- idProdStorage, storageLocation, quantity
insert into productStorage (storageLocation,quantity) values 
							('Rio de Janeiro',1000),
                            ('Rio de Janeiro',500),
                            ('São Paulo',10),
                            ('São Paulo',100),
                            ('São Paulo',10),
                            ('Brasília',60);                        


-- INSERÇÃO DE DADOS NAS TABELAS DE RELACIONAMENTO N:M

select * from productOrder;
-- tabela pedido-produto
-- idPOproduct, idPOorder, poQuantity, poStatus
insert into productOrder (idPOproduct, idPOorder, poQuantity, poStatus) values
						 (1,3,2,null),
                         (2,3,1,null),
                         (3,4,1,null);  
                         
select * from productStorage;
-- tabela produto-estoque
-- idProdStorage, storageLocation, quantity
insert into productStorage (storageLocation,quantity) values 
							('Rio de Janeiro',1000),
                            ('Rio de Janeiro',500),
                            ('São Paulo',10),
                            ('São Paulo',100),
                            ('São Paulo',10),
                            ('Brasília',60);
                            
select * from storageLocation;
-- tabela produto-estoque
-- idLproduct, idLstorage, location
insert into storageLocation (idLproduct, idLstorage, location) values
						 (1,2,'RJ'),
                         (2,6,'GO'); 
                         
select * from productSupplier;						
-- tabela produto-fornecedor
-- idPsSupplier, idPsProduct, quantity
insert into productSupplier (idPsSupplier, idPsProduct, quantity) values
						 (1,1,500),
                         (1,2,400),
                         (2,4,633),
                         (3,3,5),
                         (2,5,10); 
                         
select * from productSeller;
-- tabela produto-vendedor(terceiro)
-- idPseller, idPproduct, prodQuantity
insert into productSeller (idPseller, idPproduct, prodQuantity) values 
						 (1,6,80),
                         (2,7,10);                         