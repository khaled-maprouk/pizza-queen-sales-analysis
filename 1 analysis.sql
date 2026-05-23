select * from pizza 
ما1 إجمالي الإيرادات الكلية من جميع المبيعات؟
create view total_revenue as
SELECT round( SUM(total_price),2) AS total_revenue
FROM pizza
ما2 أكثر أنواع البيتزا مبيعًا من حيث عدد الطلبات؟
create view top5_pizza_orderid as
SELECT distinct TOP 5 pizza_name, COUNT(order_id) AS total_orders
FROM pizza
GROUP BY pizza_name
ORDER BY total_orders DESC;

ما3 اقل انواع البيتزا مبيعا 
create view lees5_pizza_order as
SELECT distinct top 5 pizza_name, COUNT(order_id)   AS total_sold
FROM pizza
GROUP BY pizza_name
ORDER BY total_sold ASC;

.4 ما الفئة (Category) التي حققت أعلى إيرادات؟
create view Category_top_revenue as
SELECT top 4 pizza_category,round( SUM(total_price),0) AS total_revenue
FROM pizza
GROUP BY pizza_category
ORDER BY total_revenue DESC;

.5 ما الحجم (Size) الأكثر طلبًا؟
create view pizza_size_ as
SELECT TOP 5 PIZZA_SIZE , SUM(QUANTITY) AS TOTAL_Orders
from pizza 
group by pizza_size
order by total_orders desc;

ما6 الحجم الذي حقق أعلى Revenue
create view pizzasize_Revenue as
select  pizza_size ,round( sum(total_price),0) as total_revenue
from pizza 
group by pizza_size


ما7 متوسط قيمة الطلب الواحد؟
create view avg_value_order as
select round( sum(total_price)/count (distinct order_id),2) as average_order_value
from pizza
ما8 أكثر الأيام تحقيقًا للمبيعات؟
select * from pizza
create view Highest_days_sales as
SELECT TOP 5 order_date, round (SUM(total_price),0) AS total_sales
FROM pizza
GROUP BY order_date
ORDER BY total_sales deSC;

.9 ما أقل الأيام تحقيقًا للمبيعات؟
create view lees_days_sales as
SELECT TOP 5 order_date, round (SUM(total_price),0) AS total_sales
FROM pizza
GROUP BY order_date
ORDER BY total_sales aSC;

10 ما أكثر ساعات اليوم نشاطًا في الطلبات؟
create view highest_hour_order as
select DATEPART(hour,order_time) as hour,count(order_id) as total_orders
from pizza 
group by DATEPART(hour,order_time)

11. ماأنواع البيتزا التي سعرها أعلى من متوسط الأسعار؟
create view thepizzaprice_higher_than_avg_price as
SELECT DISTINCT pizza_name , unit_price
FROM pizza
WHERE unit_price > (SELECT AVG(unit_price) FROM pizza);

.12 ما الطلبات التي تجاوزت متوسط قيمة الطلبات؟
SELECT order_id, SUM(total_price) AS order_total
FROM pizza
GROUP BY order_id
HAVING SUM(total_price) > (
    SELECT AVG(order_total)
    FROM (
        SELECT order_id, SUM(total_price) AS order_total
        FROM pizza
        GROUP BY order_id
    ) t
);

ما13 الفئات التي تجاوزت مبيعاتها 5000
create view Category_whose_top_sales5000 as
select pizza.pizza_category,round( sum(total_price),0) as total_sales
from pizza
group by pizza_category 
having sum(total_price)> 5000;

14. ما إجمالي المبيعات شهريًا؟
CREATE VIEW total_sales_by_month AS
SELECT 
    CONVERT(VARCHAR(7), order_date, 120) AS month_number,
    DATENAME(MONTH, order_date) AS month_name,
    ROUND(SUM(total_price), 2) AS total_sales
FROM pizza
GROUP BY 
    CONVERT(VARCHAR(7), order_date, 120),
    DATENAME(MONTH, order_date);
15. ما نسبة مساهمة كل Category في إجمالي الإيرادات؟
create view percentage_ofeach_Category_from_total_revenue as
SELECT 
    pizza_category,
    SUM(total_price) AS category_revenue,
    ROUND(
        (SUM(total_price) * 100.0) / (SELECT SUM(total_price) FROM pizza),
        2
    ) AS revenue_percentage
FROM pizza
GROUP BY pizza_category


16. ما أكثر أنواع البيتزا التي تحتوي على Chicken طلبًا؟
create view chiken as
select pizza_name , count (order_id) as total_orders
from pizza
where pizza_ingredients like '%chicken%'
group by pizza_name

17. ما متوسط عدد القطع المباعة لكل Order؟
create view Average_number_ofunits_sold_per_order as
SELECT 
    AVG(order_qty) AS avg_pizzas_per_order
FROM (
    SELECT 
        order_id,
        SUM(quantity) AS order_qty
    FROM pizza
    GROUP BY order_id
) AS t;

18. ما عدد الطلبات لكل يوم من أيام الأسبوع؟
create view order_number_Days_ofthe_week as
SELECT 
    DATENAME(WEEKDAY, order_date) AS weekday,
    COUNT(DISTINCT order_id) AS total_orders
FROM pizza
GROUP BY DATENAME(WEEKDAY, order_date)

19. ما أعلى 5 أنواع بيتزا من حيث الإيرادات؟
CREATE OR ALTER VIEW Highest5_pizza_from_total_revenue AS
SELECT *
FROM (
    SELECT TOP 5 
        pizza_name,
        SUM(total_price) AS total_revenue
    FROM pizza
    GROUP BY pizza_name
    ORDER BY SUM(total_price) DESC
) t;
20. ما أقل 5 أنواع بيتزا من حيث الإيرادات؟
create view less5_pizza_from_total_revenue as
SELECT TOP 5 
    pizza_name,
  round(  SUM(total_price),2) AS total_revenue
FROM pizza
GROUP BY pizza_name
ORDER BY total_revenue aSC;
--total_ orders
create view total_orders as
SELECT COUNT(DISTINCT order_id) AS total_orders
FROM pizza;

create view total_quantity_sold as
SELECT SUM(quantity) AS total_quantity_sold
FROM pizza;

