INSERT INTO orders (order_id, customer_id, employee_id, order_date, required_date, ship_via, freight, ship_name, ship_address, ship_city, ship_region, ship_postal_code, ship_country) 
VALUES (11083, 'QUEEN', 2, '2020-06-14', '2020-06-30', 5, 100.28, 'Queen Cozinha', 'Alameda dos Canàrios, 891', 'São Paulo', 'SP', '05487-020', 'Brazil');

INSERT INTO orders (order_id, customer_id, employee_id, order_date, required_date, ship_via, freight, ship_name, ship_address, ship_city, ship_postal_code, ship_country) 
VALUES (11084, 'QUICK', 6, '2020-05-02', '2020-06-05', 2, 210.88, 'QUICK-Stop', 'Taucherstraße 10', 'Cunewalde', '01307', 'Germany');

select EXTRACT(Month from order_date) mes_pedido, customer_id from orders where EXTRACT(Year from order_date) = 1998 AND ship_country like 'UK' order by mes_pedido;

UPDATE orders SET freight = freight + (freight * 0.25) WHERE ship_country like 'Brazil' OR ship_country like 'Argentina' OR ship_country like 'Venezuela';

select min(orders.freight) as menor_frete_por_cidade, customers.city from customers inner join orders on customers.customer_id = orders.customer_id
where orders.ship_country like 'UK' or orders.ship_country like 'Ireland' group by customers.city order by menor_frete_por_cidade;

update orders set shipped_date = '2020-12-20' WHERE EXTRACT(Year from required_date) = 2020 AND shipped_date is null;

INSERT INTO customers (customer_id, company_name, contact_name, contact_title, address, city, region, postal_code, country) 
VALUES ('BKGUS', 'Burger King Corporation', 'Keith J. Kramer', 'Owner', '5505 Blue Lagoon Drive, Condado de Miami-Dade', 'Miami', 'Flórida', '78988-555', 'USA');

select contact_name, contact_title, company_name, address from customers where contact_title like 'Owner%' and phone is null order by contact_name;

INSERT INTO orders (order_id, customer_id, employee_id, order_date, required_date, ship_via, freight, ship_name, ship_address, ship_city, ship_region, ship_postal_code, ship_country) 
VALUES (11085, 'BKGUS', 8, '2020-09-06', '2020-11-01', 1, 65.97, 'Burger King Corporation', '5505 Blue Lagoon Drive, Condado de Miami-Dade', 'Miami', 'Flórida', '78988-555', 'USA');

UPDATE orders SET freight = freight - (freight * 0.50) WHERE ship_region like 'SP' OR ship_region like 'RJ';

select count(orders.ship_city) as pedidos_por_cidade, customers.city from customers inner join orders on customers.customer_id = orders.customer_id
where orders.ship_country like 'Canada' group by customers.city order by pedidos_por_cidade desc;

INSERT INTO orders (order_id, customer_id, employee_id, order_date, required_date, ship_via, freight, ship_name, ship_address, ship_city, ship_postal_code, ship_country) 
VALUES (11086, 'EASTC', 9, '2020-11-12', '2020-11-30', 3, 102.97, 'Eastern Connection', '35 King George', 'London', 'WX3 6FW', 'UK');

INSERT INTO customers (customer_id, company_name, contact_name, contact_title, address, city, region, postal_code, country, phone) 
VALUES ('MLIBR', 'Mercado Livre', 'Fernanda Macedo', 'Order Administrator', 'Av. das Nações Unidas, 439 - Pres. Altino', 'São Paulo', 'SP', '06233-200', 'Brazil', '(11)1545-9898');

update orders set shipped_date = '2020-12-25' WHERE shipped_date is null;

select count(EXTRACT(Year from required_date)) as pedidos_em_1996, ship_country from orders where EXTRACT(Year from required_date) = 1996 group by ship_country;

UPDATE customers SET country = 'Spain' WHERE city in ('Madrid', 'Barcelona', 'Sevilla');

INSERT INTO customers (customer_id, company_name, contact_name, contact_title, address, city, region, postal_code, country, phone) 
VALUES ('SINMO', 'Sinhá Moça', 'Karla Silveira', 'Sales Manager', 'Rua Floriano Peixoto, 526', 'Capão Bonito', 'SP', '18300-250', 'Brazil', '(15)3542-5787');

select customers.contact_name, customers.phone, orders.ship_name, orders.order_id, EXTRACT(Year from orders.shipped_date) as ano_pedido from customers inner join orders on customers.customer_id = orders.customer_id
WHERE orders.ship_city in ('Seattle', 'Boise', 'Elgin') AND EXTRACT(Year from orders.shipped_date) between 1996 and 1998 order by customers.contact_name;

UPDATE orders SET ship_country = 'Spain' WHERE ship_city in ('Madrid', 'Barcelona', 'Sevilla');

update customers set company_name = 'Carlinhos BBQ Lanches', contact_title = 'Owner' where customer_id = 'SINMO';

INSERT INTO orders (order_id, customer_id, employee_id, order_date, required_date, ship_via, freight, ship_name, ship_address, ship_city, ship_postal_code, ship_country) 
VALUES (11087, 'SINMO', 5, '2020-10-06', '2020-11-01', 1, 19.90, 'Carlinhos BBQ Lanches', 'Rua Floriano Peixoto, 526', 'Capão Bonito', '18300-250', 'Brazil');

select max(freight), ship_region from orders where ship_country = 'Brazil' group by ship_region;

INSERT INTO orders (order_id, customer_id, employee_id, order_date, required_date, ship_via, freight, ship_name, ship_address, ship_city, ship_postal_code, ship_country) 
VALUES (11088, 'BKGUS', 1, '2020-03-06', '2020-04-05', 4, 45.30, 'Burger King Corporation', '5505 Blue Lagoon Drive, Condado de Miami-Dade', 'Miami', '78988-555', 'USA');

INSERT INTO orders (order_id, customer_id, employee_id, order_date, required_date, ship_via, freight, ship_name, ship_address, ship_city, ship_postal_code, ship_country) 
VALUES (11089, 'SINMO', 9, '2020-04-03', '2020-06-09', 3, 80.90, 'Carlinhos BBQ Lanches', 'Rua Floriano Peixoto, 526', 'Capão Bonito', '18300-250', 'Brazil');

update orders set ship_region = 'SP' where ship_city = 'Capão Bonito' and ship_region is null;

select avg(orders.freight) as frete_medio_por_cidade, customers.city from customers inner join orders on customers.customer_id = orders.customer_id
where orders.ship_country in ('Brazil', 'Mexico') group by customers.city order by frete_medio_por_cidade;

select distinct ship_city, ship_region, ship_country from orders where ship_region is not null AND ship_country in ('UK', 'USA', 'Canada');

update orders set ship_region = 'Flórida'  where ship_city = 'Miami' and ship_region is null;

update orders set shipped_date = '2020-12-02' WHERE EXTRACT(Year from required_date) = 2020 AND ship_via between 1 and 4;

select customers.contact_name, customers.phone, orders.order_id, EXTRACT(Month from orders.required_date) as mes_pedido from customers inner join orders on customers.customer_id = orders.customer_id
WHERE EXTRACT(Year from orders.required_date) = 1996 AND EXTRACT(Month from orders.required_date) between 10 and 12 AND orders.ship_country like 'USA';

