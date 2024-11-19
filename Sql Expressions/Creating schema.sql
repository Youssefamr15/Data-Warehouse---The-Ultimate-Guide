
-- Looking at the problem
select * from staging.dim_product;


select * from core.dim_product;

-- Setting up schema & table structure
CREATE SCHEMA core;


CREATE TABLE core.dim_product (
    Product_PK int, 
    product_id varchar(5),
    product_name varchar(100),
    category varchar(50),
    subcategory varchar(50),
    brand varchar(50)
   );
   
-- Looking at the results
SELECT * FROM core.dim_product;


truncate table staging.dim_product;
