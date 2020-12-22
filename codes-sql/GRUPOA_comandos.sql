INSERT INTO customers (customer_id, company_name, contact_name, contact_title, address, city, region, postal_code, country) 
VALUES ('NTLSU', 'Nestlé S.A.', 'Paul Bulcke', 'Accounting Manager', '5505 Blue Lagoon Drive', 'Vevey', 'Vaud', '78988-555', 'Suíça');

INSERT INTO orders (order_id, customer_id, employee_id, order_date, required_date, ship_via, freight, ship_name, ship_address, ship_city, ship_region, ship_postal_code, ship_country) 
VALUES (11078, 'NTLSU', 5, '2020-10-10', '2020-10-26', 2, 30.45, 'Nestlé S.A.', '5505 Blue Lagoon Drive', 'Vevey', 'Vaud', '78988-555', 'Suíça');

select count(ship_name) as pedidos_por_pais, ship_country from orders group by ship_country order by pedidos_por_pais desc;

UPDATE customers SET city = 'São Paulo' WHERE city = 'Sao Paulo';

UPDATE orders SET ship_city = 'São Paulo' WHERE ship_city = 'Sao Paulo';

select count(orders.ship_region) as pedidos_por_estado, customers.region from customers inner join orders on customers.customer_id = orders.customer_id
where orders.ship_country like 'Brazil' group by customers.region order by pedidos_por_estado desc;

UPDATE orders SET ship_country = 'Switzerland' WHERE customer_id = 'NTLSU';

UPDATE customers SET country = 'Switzerland' WHERE customer_id = 'NTLSU';

select avg(freight) as media_frete, count(order_id) as quant_pedidos, ship_city from orders where ship_country like 'USA' group by ship_city order by media_frete;

INSERT INTO customers (customer_id, company_name, contact_name, contact_title, address, city, postal_code, country) 
VALUES ('MCDUS', 'McDonalds Corporation', 'Ray Kroc', 'Owner/Marketing Assistant', '110 N Carpenter St, Chicago, IL 60607', 'Chicago', '7785-000', 'USA');

INSERT INTO customers (customer_id, company_name, contact_name, contact_title, address, city, region, postal_code, country, phone) 
VALUES ('HEXSO', 'Hipermercado Extra', 'Tatiana Moreira', 'Marketing Assistant', 'R. Maria Cinto de Biagi, 164 - Jardim Santa Rosália', 'Sorocaba', 'SP', '18095-410', 'Brazil', '(15)3212-6750');

UPDATE orders SET freight = freight + (freight * 0.15) WHERE ship_country like 'USA';

select count(orders.ship_city) as pedidos_por_cidade, customers.city from customers inner join orders on customers.customer_id = orders.customer_id
where orders.ship_country like 'Germany' or orders.ship_country like 'Italy' group by customers.city order by pedidos_por_cidade desc limit 5;

INSERT INTO orders (order_id, customer_id, employee_id, order_date, required_date, ship_via, freight, ship_name, ship_address, ship_city, ship_postal_code, ship_country) 
VALUES (11079, 'CACTU', 9, '2020-08-01', '2020-08-15', 1, 89.23, 'Cactus Comidas para llevar', 'Cerrito 333', 'Buenos Aires', '1010', 'Argentina');

select count(employee_id) as pedidos_por_empregado, employee_id from orders where ship_country like 'UK' or ship_country like 'France' or ship_country like 'Italy' group by employee_id;

INSERT INTO orders (order_id, customer_id, employee_id, order_date, required_date, ship_via, freight, ship_name, ship_address, ship_city, ship_postal_code, ship_country) 
VALUES (11080, 'CENTC', 4, '2020-06-03', '2020-07-12', 5, 45.13, 'Centro comercial Moctezuma', 'Sierras de Granada 9993', 'México D.F.', '05022', 'Mexico');

UPDATE customers SET country = 'Espanha' WHERE city = 'Madrid';

UPDATE orders SET ship_country = 'Espanha' WHERE ship_city = 'Madrid';

select max(orders.freight) as maior_frete_por_cidade, customers.city from customers inner join orders on customers.customer_id = orders.customer_id
where orders.ship_country like 'USA' group by customers.city order by maior_frete_por_cidade desc;

INSERT INTO customers (customer_id, company_name, contact_name, contact_title, address, city, postal_code, country) 
VALUES ('STBCO', 'Starbucks Corporation', 'Kevin Johnson', 'Owner/Marketing Assistant', 'Ave. S, Seattle, WA 98134', 'Washington', '56999-320', 'USA');

select * from customers where contact_title like 'Owner' and fax is null;

UPDATE customers SET city = 'Seattle', region = 'WA' WHERE customer_id = 'STBCO';

select avg(orders.freight) as media_frete_por_regiao, customers.region from customers inner join orders on customers.customer_id = orders.customer_id
where customers.region is not null group by customers.region order by media_frete_por_regiao;

INSERT INTO orders (order_id, customer_id, employee_id, order_date, required_date, ship_via, freight, ship_name, ship_address, ship_city, ship_region, ship_postal_code, ship_country) 
VALUES (11081, 'STBCO', 6, '2020-09-16', '2020-09-30', 3, 87.22, 'Starbucks Corporation', 'Ave. S, Seattle, WA 98134', 'Seattle', 'WA', '56999-320', 'USA');

select distinct ship_city from orders where ship_country not like 'Italy' and ship_country not like 'Ireland';

UPDATE orders SET shipped_date = '1998-12-20' WHERE EXTRACT(Year from required_date) = 1998;

INSERT INTO customers (customer_id, company_name, contact_name, contact_title, address, city, region, postal_code, country, phone) 
VALUES ('LAMBR', 'Lojas Americanas S.A.', 'Max Landesmann', 'Owner', 'Av. dos Oitis, nº 1.460, Distrito Industrial', 'Rio de Janeiro', 'RJ', '89000-565', 'Brazil', '(21)7841-0056');

update orders set shipped_date = '1998-10-01' WHERE EXTRACT(Year from required_date) = 1998 AND ship_country like 'USA' AND ship_region like 'OR' OR ship_region like 'ID';

select customers.contact_name, customers.phone, orders.ship_name, orders.order_id, EXTRACT(Year from orders.shipped_date) as ano_pedido from customers inner join orders on customers.customer_id = orders.customer_id
WHERE orders.ship_region like 'WA' AND EXTRACT(Year from orders.shipped_date) between 1996 and 1997;

INSERT INTO orders (order_id, customer_id, employee_id, order_date, required_date, ship_via, freight, ship_name, ship_address, ship_city, ship_region, ship_postal_code, ship_country) 
VALUES (11082, 'LAMBR', 2, '2020-03-15', '2020-04-05', 1, 90.74, 'Lojas Americanas S.A.', 'Av. dos Oitis, nº 1.460, Distrito Industrial', 'Rio de Janeiro', 'RJ', '89000-565', 'Brazil');

