USE new_schema;
-- Second: Write a query that directly answers question(s) from a business stakeholder
-- Which user spent the most money in the month of August?
SELECT EXTRACT(MONTH FROM purchase_date) AS month ,user_id, r.total_spent
FROM users u 
LEFT JOIN receipts r on r.user_id = u.id
HAVING month = 8
ORDER BY r.total_spent DESC;

-- What user bought the most expensive item?
SELECT u.birth_date,u.gender,u.state,u.sign_up_platform,u.sign_up_source,r.total_spent
FROM users u
INNER JOIN receipts r ON u.id = r.user_id
WHERE r. total_spent IS NOT NULL
ORDER BY r.total_spent DESC;

-- What is the name of the most expensive item purchased?
SELECT description, total_final_price/quantity_purchased AS price
FROM receipt_items
ORDER BY price DESC;

-- How many users scanned in each month?
SELECT COUNT(DISTINCT user_id), EXTRACT(MONTH FROM date_scanned) AS month
FROM receipts
GROUP BY month;

-- Third: Choose something noteworthy about the data and share with a non-technical stakeholder
-- Which state has the strongest spending power?
SELECT SUM(r.total_spent),u.state
FROM receipts r 
LEFT JOIN users u on u.id = r.user_id
WHERE r.total_spent > 0
GROUP BY state
ORDER BY SUM(r.total_spent) DESC;
-- By figuring out this problem, the stakeholder can make better decisions about delivering certain number of products
-- to different states, which can reduce costs for delivery and warehouse storage. What's more, the stakeholder can develop
-- the strategy to assign different prices of products to different states.
  
