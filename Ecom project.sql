---CREATED TABLE
CREATE TABLE consumer (
customer_id VARCHAR(30),
age int,
gender VARCHAR(20),
income_level VARCHAR(20),
marital_status VARCHAR(20),
education_level VARCHAR(20),
occupation VARCHAR(20),
location VARCHAR(100),
purchase_category VARCHAR(100),
purchase_amt DECIMAL(10,2),
freq_of_purchase INT,
purchase_channel VARCHAR(10),
brand_loyalty INT,
product_rating INT,
hours_spent_on_product_research DECIMAL(3,2),
social_media_influence VARCHAR(20),
discount_sensitivity VARCHAR(40),
return_rate INT,
customer_satisfaction INT,
engagement_with_ads VARCHAR(20),
device_used_for_shopping VARCHAR(50),
payment_method VARCHAR(20),
time_of_purchase DATE,
discount_used BOOLEAN,
customer_loyalty_program_member BOOLEAN,
purchase_intent VARCHAR(50),
shipping_preference VARCHAR(50),
time_to_decision INT);

--- Checking to see if import went through
SELECT * 
FROM consumer;

----Make backup table 
CREATE TABLE consumer_backup AS 
SELECT *
FROM consumer;

---Cleaning the data set 
UPDATE consumer
SET purchase_category = REPLACE(purchase_category, ')', ' ')

UPDATE consumer
SET purchase_category = REPLACE(purchase_category, '(', ' ')

---Locating the top 3 purchase categories based off the average 
---purchase amount 
SELECT purchase_category, ROUND(AVG(purchase_amt),2) AS average_purchase_amt
FROM consumer
GROUP BY purchase_category 
ORDER BY average_purchase_amt DESC
LIMIT 3

SELECT age, 
	gender, 
	income_level,
	marital_status,
	education_level,
	purchase_category,
	purchase_amt,
	freq_of_purchase,
	purchase_channel,
	product_rating,
	social_media_influence,
	return_rate,
	engagement_with_ads,
	device_used_for_shopping,
	payment_method,
	time_of_purchase,
	brand_loyalty
FROM consumer;

---Income vs purchase amount 
SELECT income_level, ROUND(AVG(purchase_amt),2)
FROM consumer
GROUP BY income_level
ORDER BY ROUND(AVG(purchase_amt),2) DESC;

---Age group and social media influence
SELECT 
	CASE 
		WHEN age BETWEEN 18 AND 25 THEN '18-24'
		WHEN age BETWEEN 25 AND 34 THEN '25-34'
		WHEN age BETWEEN 35 AND 44 THEN '35-44'
		WHEN age BETWEEN 45 AND 54 THEN '45-54'
		ELSE 'Unknown'
	END AS age_group,
social_media_influence,
COUNT(*)
FROM consumer
GROUP BY age_group,social_media_influence
ORDER BY age_group,social_media_influence;

---Peak season for shoppers
SELECT 
  TO_CHAR(time_of_purchase, 'YYYY-MM') AS purchase_month,
  COUNT(*) AS total_purchases
FROM consumer
GROUP BY purchase_month
ORDER BY total_purchases DESC
LIMIT 3;

---Which purchase channel is used the most
SELECT purchase_channel, COUNT(*)
FROM consumer
GROUP BY purchase_channel 
ORDER BY COUNT(*) DESC

---Each age group prefernce on shopping
SELECT 
	CASE 
		WHEN age BETWEEN 18 AND 25 THEN '18-24'
		WHEN age BETWEEN 25 AND 34 THEN '25-34'
		WHEN age BETWEEN 35 AND 44 THEN '35-44'
		WHEN age BETWEEN 45 AND 54 THEN '45-54'
		ELSE 'Unknown'
	END AS age_group,
purchase_channel,
COUNT(*)
FROM consumer
GROUP BY age_group,purchase_channel
ORDER BY purchase_channel DESC, age_group;


---Brand Loyalty vs Purchase Amount 
SELECT brand_loyalty,
ROUND(AVG(purchase_amt),2) AS avg_purchase_amt,
COUNT(*) AS total_customers
FROM consumer
GROUP BY brand_loyalty
ORDER BY brand_loyalty DESC;

---Return Rate by Product Rating 
SELECT 
  product_rating,
  ROUND(AVG(return_rate), 2) AS avg_return_rate,
  COUNT(*) AS num_reviews
FROM consumer
GROUP BY product_rating
ORDER BY product_rating ASC;

---Avg time to decision by device used
SELECT 
  device_used_for_shopping,
  ROUND(AVG(time_to_decision), 2) AS avg_time_to_decision,
  COUNT(*) AS total_users
FROM consumer
GROUP BY device_used_for_shopping
ORDER BY avg_time_to_decision ASC;