select* from sale.sales_data_dump1;

select count(*) 
from sale.sales_data_dump1;

-- Average Quantity 
select avg(Quantity)
from sale.sales_data_dump1;

-- Target Gap on sales 
select Customer_ID, City , Actual_Sales, Target_Sales, round((Target_Sales-Actual_Sales),0) Target_Gap
from sale.sales_data_dump1;

-- 	Achievement %	of target sales 			         
select Customer_ID, City , Actual_Sales, Target_Sales, round((Actual_Sales/Target_Sales)*100,0) Target_Gap_per
from sale.sales_data_dump1;

-- 	Discount Amount on sales
select Customer_ID, City , List_Price, Selling_Price, (List_Price-Selling_Price) Discount_Amount
from sale.sales_data_dump1;

-- 	Discount % on sales 
select Customer_ID, City , List_Price, Selling_Price, (100- (Selling_Price/List_Price)*100) Discount_Perc
from sale.sales_data_dump1;

-- Sales segment 
select Quantity ,
case when Quantity between 1 and 49 then '1 to 50'
when Quantity between 50 and 99 then '1 to 99'
when Quantity between 100 and 249 then '100 to 249'
when Quantity between 250 and 499 then '250 to 499'
when Quantity between 500 and 999 then '500 to 999'
else 'remaining  is 1000+ ' 
end as 'Quantity_Group'
from sale.sales_data_dump1
order by Quantity asc;

-- Specify Metro and non-metro citys using case 
select *,
case when City in ('Mumbai', 'Bengaluru' , 'Delhi') then 'Metro City'
else 'Non-Mtero City'
end as 'City_Segment'
from sale.sales_data_dump1
order by City_Segment;

-- Total sales in metro citys 
select sum(Actual_Sales) as Metro_sales 
from sale.sales_data_dump1
where City in ('Mumbai' , 'Bengaluru' , 'Delhi');

-- Count of transaction in metro citys 
select count(*) as Metro_transaction_Count 
from sale.sales_data_dump1
where City in ('Mumbai' , 'Bengaluru' , 'Delhi');

-- Ratio of metro to non-metro citys on actual sales using with function 
with metro_sales as 
(select sum(Actual_Sales) as metro_Sales
from sale.sales_data_dump1
where City in ('Mumbai' , 'Bengaluru' , 'Delhi') ),
non_metro_sales as (
select sum(Actual_Sales) as non_metro_sales 
from sale.sales_data_dump1
where City not in ('Mumbai' , 'Bengaluru' , 'Delhi') )

select metro_sales*metro_sales / non_metro_sales*non_metro_sales as metro_nonmetro_ratio
from metro_sales , non_metro_sales ;


-- Count of citys in 100 to 250 segment 
select count(*) as '100 to 250 count'
from sale.sales_data_dump1
where Quantity between 100 and 250;

alter table sale.sales_data_dump1
drop column MyUnknownColumn;

-- weightes sales 
select * ,
case when City in ('Mumbai', 'Delhi', 'Bengaluru') then Actual_Sales*0.5
when City in ('Hyderabad', 'Gurugram') then Actual_Sales*0.3
else Actual_Sales*0.1
end as Weighted_Sales 
from sale.sales_data_dump1;

alter table sale.sales_data_dump1
rename column Date to Date1;

INSERT INTO sale.sales_data_dump1 (Date1) VALUES (STR_TO_DATE("Sep-2015", "%m-%Y"));

select* from sale.sales_data_dump1;

alter table sale.sales_data_dump1 
modify Date1 varchar(255);




