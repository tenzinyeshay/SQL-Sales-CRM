create database CRM;

use CRM;

create table accounts (
	account_name varchar(100) Primary Key, sector text, year_established int,
    revenue decimal (10,2), employee int, office_loc text, sub_office text);
    
    select * from accounts;
    
    create table products ( 
    product varchar(100) primary key, series text, sales_price decimal(10,2));
    
    select * from products;
    
    create table sales_team(
    sales_agent varchar(100) primary key, manager text, regional_off text);
    
    select * from sales_team;
    
    create table sale_pipeline(
    opportunity_id varchar(100) primary key, sales_agent varchar(100), product varchar(100),
    account_name varchar(100), deal_stage text, engage_date date, close_date date, close_value int,
    foreign key (sales_agent) references sales_team(sales_agent),
    foreign key (product) references products (product),
    foreign key (account_name) references accounts(account_name)
    );
    
    select * from sale_pipeline;
    select * from sales_team;
    select * from accounts;
    select * from products;
    
   -- Rank agents by total deal value
    
	select sales_agent, sum(close_value) as totalclosevalue,
    rank()over(order by sum(close_value) desc) as agent_rank
    from sales_pipeline
    group by sales_agent;
    
    -- rank agents by total close value by region
    
    select ST.sales_agent, sum(SP.close_value) as totalclosevalue, ST.regional_off,
    rank() over(partition by regional_off order by sum(SP.close_value) desc) as agent_rank
    from sales_pipeline SP
    Inner Join sales_team ST  ON SP.sales_agent = SP.sales_agent
    group by ST.sales_agent, ST.regional_off;

	-- rank products overall with no gaps
    
    select product, sales_price,
    dense_rank() over(order by sales_price desc) as product_rank
    from products;
    
    -- rank products by sales_revenue within opportunity id 
    
    select SP.opportunity_id, P.sales_price, account_name,
    dense_rank() over(partition by account_name order by P.sales_price desc) as product_rank
    from sales_pipeline SP
    Inner Join products P ON SP.product = P.product;
    
    select SP.opportunity_id, P.sales_price, account_name,
    dense_rank() over(order by P.sales_price desc) as product_rank
    from sales_pipeline SP
    Inner Join products P ON SP.product = P.product;
    
    -- rank accounts by total revenue from closed deals(closed value) per product
    
    select account_name, sum(close_value), product,
    rank() over(partition by product order by sum(close_value)desc) as rank_product,
    dense_rank() over(partition by product order by sum(close_value)desc) as denserank_product
    from sales_pipeline
    group by account_name, product;
    
    select account_name, opportunity_id, engage_date,
    row_number() over(order by engage_date) as row_num
    from sales_pipeline;
    
    -- order deals for each sales agent chronologically 
    
    
    select * from (select sales_agent, opportunity_id, engage_date,
    row_number() over(partition by sales_agent order by engage_date) as row_num
    from sales_pipeline) ranked
    where row_num = 1;
    
   
    select SP.opportunity_id, P.sales_price, account_name,
	rank() over(partition by account_name order by P.sales_price desc) as product_rank,
    dense_rank() over(partition by account_name order by P.sales_price desc) as product_denserank,
    row_number() over(partition by account_name order by P.sales_price desc) as row_num
    from sales_pipeline SP
    Inner Join products P ON SP.product = P.product;
    
	-- Lag compares previous value with the current values
    -- lead compares the next value with current
    
    -- compare previous close value with the current
    
    select account_name, close_value as current_value, close_date,
    lag(close_value) over (order by close_date) as previous_value
    from sales_pipeline;
    
    -- compare each deals value to the previous values for the same account
    
    select account_name, close_value as current_value, close_date,
    lag(close_value) over(partition by account_name order by close_date) as previous_value;
    
    -- compare close value to the next one
    
    select account_name, close_value as current_value, close_date,
    lead(close_value) over(partition by account_name order by close_date) as next_value
    from sales_pipeline;
    
    select account_name, close_value as current_value, close_date,
    lag(close_value) over(partition by account_name order by close_date) as previous_value,
    lead(close_value) over(partition by account_name order by close_date) as next_value
    from sales_pipeline;
    
    
    
    
   
    
    