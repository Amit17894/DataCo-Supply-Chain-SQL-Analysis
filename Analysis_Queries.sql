# 3. Delays
WITH delay AS
(
SELECT order_date_dateorders_clean, 
       shipping_date_dateorders_clean, 
       datediff(shipping_date_dateorders_clean,order_date_dateorders_clean) AS actual_shipping_days,
	   days_for_shipment_scheduled AS scheduled_shipping_days
FROM dataco_supplychain_data
)
SELECT *,
	   actual_shipping_days - scheduled_shipping_days AS gap, 
       CASE WHEN actual_shipping_days - scheduled_shipping_days < 0 THEN "Advance Shipping"
			WHEN actual_shipping_days - scheduled_shipping_days = 0 THEN "On Time"
            ELSE "Late Delivery" 
	   END AS delivery_status
FROM delay
LIMIT 10;

# 4. Worst Performing Cities 
SELECT  order_city,
		AVG(days_for_shipping_real - days_for_shipment_scheduled) AS avg_delay
FROM dataco_supplychain_data
GROUP BY order_city
HAVING avg_delay > 2
ORDER BY avg_delay DESC
LIMIT 10;

# 5. Profit Vs Late Delivery
SELECT  delivery_status,
		AVG(order_profit_per_order) AS avg_profit_as_per_delviery_status,
        AVG(order_item_profit_ratio) AS avg_profit_ratio
FROM dataco_supplychain_data
GROUP BY delivery_status; 

# 6. Monthly Trend
WITH trend AS
(
SELECT YEAR(order_date_dateorders_clean) AS YEAR_1,
	   MONTH(order_date_dateorders_clean) AS MONTH_1,
       COUNT(*) AS number_of_orders,
       SUM(late_delivery_risk) AS late_del
FROM dataco_supplychain_data
GROUP BY YEAR_1,MONTH_1
ORDER BY YEAR_1 ASC, MONTH_1 ASC
)
SELECT *,
       late_del/number_of_orders*100 AS late_del_percent_every_month
FROM trend;

       