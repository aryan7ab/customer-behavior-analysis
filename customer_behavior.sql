CREATE DATABASE customer_behavior;
use customer_behavior;

select * from customer limit 3;

#1. total revenue by male vs female customers
select gender, sum(purchase_amount) as revenue from customer group by gender;

#2. Which customers used a discount but still spent more than avg purchase amt
select customer_id, purchase_amount,
(select avg(purchase_amount) from customer) from customer
where discount_applied = 'Yes' AND 
purchase_amount >= (
Select avg(purchase_amount) from customer);

#3. What are the top5 products with the highest review rating
select item_purchased as product, round(avg(review_rating),2) as rating
from customer 
group by item_purchased
order by rating desc limit 5;

#4. Compare the avg purchase amounts between standard and express shipping
select shipping_type, round(avg(purchase_amount),2) as avg_amount from customer
where shipping_type IN ('Standard', 'Express')
group by shipping_type;

#5. Do subscribed customers spend more? compare avg spend and total revenue between
#subscribers and non-subscribers
select subscription_status, count(customer_id) as 'Total customers',
avg(purchase_amount) as 'Average Spend', sum(purchase_amount) as 'Total Revenue'
from customer
group by subscription_status
order by sum(purchase_amount) desc;

#6. which 5 products have highest percentage of purchases with discounts applied?
SELECT 
    item_purchased AS Product,
    COUNT(*) AS total_sales,
    SUM(discount_applied = 'Yes') AS discounted_sales,
    ROUND(100 * SUM(discount_applied = 'Yes') / count(*), 2) AS discount_rate
FROM customer
GROUP BY item_purchased
ORDER BY discount_rate DESC
LIMIT 5;

#7. Segment customers into new, returning and loyal based on their total number of
#previous purchases and show the count of each segment.
SELECT 
	CASE 
		when previous_purchases = 1 then 'New'
        when previous_purchases BETWEEN 2 and 10 then 'Returning'
        else 'Loyal'
	end as customer_segment,
    count(*) as customer_count
from customer
group by customer_segment
order by customer_segment DESC;

#8.  what are the top3 most purchased products within each category
with cte_item_rank as (
select item_purchased,
count(customer_id) as total_orders,
category,
row_number() over (partition by category order by count(customer_id) desc) as item_rank
from customer
group by category, item_purchased
)

select item_rank, item_purchased, total_orders, category
from cte_item_rank
where item_rank<=3;

#9. customers who buy repeatedly (5+ previous purchases) also likely to subscribe?
with cte_subscribe as (
select customer_id, previous_purchases from customer
where previous_purchases>5 AND subscription_status = 'Yes'
)

select count(customer_id) as 'Repeated buyers who subscribe' from cte_subscribe;

#10. What is the revenue contribution of each age group?
select age_group, sum(purchase_amount) as total_revenue
from customer
group by age_group
order by total_revenue desc;