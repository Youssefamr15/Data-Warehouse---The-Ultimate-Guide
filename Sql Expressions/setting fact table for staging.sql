-- Setting up sales fact table for staging

CREATE TABLE "staging".sales
(
    transaction_id integer,
	transactional_date timestamp,
	product_id character varying,
    customer_id integer,
    payment character varying,
    credit_card bigint,
    loyalty_card character varying,
    cost numeric,
    quantity integer,
    price numeric,
    PRIMARY KEY (transaction_id)
);

-- Setting up sales fact table for core

CREATE TABLE core.sales
(
    transaction_id integer,
	transactional_date timestamp,
	transactional_date_fk bigint,
	product_id character varying,
	product_fk integer,
    customer_id integer,
    payment_fk integer,
    credit_card bigint,
    cost numeric,
    quantity integer,
    price numeric,
	total_cost numeric,
	total_price numeric,
	profit numeric,  
    PRIMARY KEY (transaction_id)
);


select *
from core.sales;


-- Setting up sales payment tables for staging and core


CREATE TABLE core.dim_payment
(
    payment_pk integer NOT NULL GENERATED BY DEFAULT AS IDENTITY ( INCREMENT 1 START 1 ),
    payment character varying,
    loyalty_card character varying,
    PRIMARY KEY (payment_pk)
);



select *
from core.dim_payment;


SELECT * FROM staging.sales;

select Distinct
Coalesce(payment,'cash') as payment,
loyalty_card
from staging.sales;


SELECT 
	transaction_id ,
	transactional_date ,
	EXTRACT(year from transactional_date)*10000 + EXTRACT('month' from transactional_date)*100+EXTRACT('day' from transactional_date)as 	transactional_date_fk,
	f.product_id ,
	p.product_PK as product_FK,
	payment_PK as payment_FK,
    customer_id ,
    credit_card ,
   	cost  ,
    quantity ,
   	price
FROM "staging".sales f
LEFT JOIN 
core.dim_payment d
ON d.payment = COALESCE(f.payment,'cash') AND d.loyalty_card=f.loyalty_card
LEFT JOIN core.dim_product p on p.product_id=f.product_id
order by transaction_id


select


