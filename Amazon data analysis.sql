use P7_Amazon;

Select *
from [User] U 
join Product P on p.product_id = U.product_id
join Review R on R.product_id = u.product_id;

select review_id, COUNT(*)
from Review
group by review_id
having COUNT(*) = 1;


with DDRT as ( select *,
              ROW_NUMBER() over ( partition by review_id order by review_id ) as DD
			  from Review
			  )
Delete 
from DDRT
where DD > 1;



select [user_id], COUNT(*)
from [User]
group by [user_id]
having COUNT(*) = 1 ;


with DDUT as ( select *, 
               ROW_NUMBER() over( partition by [user_id] order by [user_id]) as UT
			   from [User]
			)
Delete 
from DDUT
where UT > 1;

select Count(*)
from Review;

select COUNT(*)
from [User];


                 -- check user name sring--
Select *
from [User]
where user_name Not Like ('%_');


                --delete unuse string--

Delete 
from [User]
WHERE user_name IN ('(sic)', 'NULL', '??????')
   OR user_name LIKE '%?%'
   OR user_name LIKE '%$%'
   OR user_name LIKE '%@%'
   OR user_name LIKE '%|%' ;
---------------------------------------------------------------------------------------------------------------------------------------------------------
                                               --SQL Problems--
-----------------------------------------------------------------------------------------------------------------------------------------------------



--1. **List all products with their category and price.**

Select product_id, product_name, Category, actual_price
from Product;


--2. **Find users who have posted reviews.**

Select U.user_id, U.user_name, R.review_id, R.review_title
from [User] U
join Review R on R.product_id = U.product_id
where R.review_title is not null;


--3. **Count how many products are in each category.**


Select RIGHT(category, CHARINDEX('|', REVERSE(category) + '|') - 1) as Final_Category, Count(product_id) as Products
from Product
group by RIGHT(category, CHARINDEX('|', REVERSE(category) + '|') - 1)
order by Count(*) desc;

--4. **Show average rating for each product.**

Select product_id, product_name, Round(AVG(rating), 2) as average_rating
from Product
group by product_id, product_name
order by average_rating desc;

--5. **List all reviews with product name and user name (JOIN).**

Select u.user_name, p.product_name, r.review_title
from [User] u
join Product p on p.product_id = u.product_id
join Review r on u.product_id = r.product_id;

--6. **Top 5 products with highest average rating (min. 5 reviews).**

Select  top 5 product_id, product_name, ROUND(avg(rating), 2) as Average_rating
from Product
group by product_id, product_name
order by Average_rating desc;


--7. **List users who reviewed more than 3 products.**

select u.user_id, u.user_name, count( r.product_id) as products_revieweds
from [User] u
join Review r on u.product_id = r.product_id
group by u.user_id, u.user_name
having COUNT( r.product_id) > 3;


--8.  List categories with average discount more than 20%.

with Average_Discount as (
select category, Round(AVG(discount_percentage * 100), 2) as Avg_discount,
RIGHT(category, CHARINDEX('|', REVERSE(category) + '|') - 1) as Final_Category
from product
group by category
)
Select Final_Category, Avg_Discount
from Average_Discount
where Avg_discount > 20 ;

--9. Find products with rating above 4.5 and discount above 30%.

Select product_id, Round(rating , 2) as Rating, ROUND(discount_percentage * 100 , 2) as Discount
from Product
Where rating > 4.5 or discount_percentage > 30 ;


--10. List top 3 most reviewed products in each category.

with review_Count as 
(Select p.category, p.product_id, COUNT(r.review_id) as Reviewed, 
RIGHT(p.category, CHARINDEX('|', REVERSE(p.category) + '|') - 1) AS final_category,
DENSE_RANK() over (Partition by RIGHT(p.category, CHARINDEX('|', REVERSE(p.category) + '|') - 1)  order by COUNT(r.review_id) desc) as rank
from Product p
join Review r on p.product_id = r.product_id
group by p.category, p.product_id)

select  Top 3 final_category, Product_id, Reviewed
from review_Count
where rank <= 3
order by Reviewed desc;


--11.Show the number of products in each category.

WITH Category AS (
    SELECT 
        product_id,
        product_name,
        category,
        RIGHT(category, CHARINDEX('|', REVERSE(category) + '|') - 1) AS final_category
    FROM Product
)
SELECT 
    final_category, 
    COUNT(product_id) AS Products
FROM Category
GROUP BY final_category 
order by Products desc;


--13. Find the average price of products per category.

Select  RIGHT(category, CHARINDEX('|', REVERSE(category) + '|') - 1 ) as Final_Category, Round(AVG(actual_price), 2) as Average_Price
from Product
group by Right (category, CHARINDEX('|', REVERSE(category) + '|') -1);


--12. List products with more than 6 reviews and rating below 3.5.
    

	 select r.product_id, Count(r.review_id) as Reviews,  Round(p.rating, 2) as Rating
	 from Review r
	 join Product p on p.product_id = r.product_id
	 Where p.rating > 3.5
	 group by r.product_id, p.rating
	  having Count(review_id) > 6;

--14. Show top 5 products with highest rating count.

select top 5 product_id, rating_count
from Product
order by rating_count desc;



--15. Calculate estimated revenue for each product (discounted_price × rating_count).

Select product_id, (discounted_price * rating_count) as estimated_revenue
from Product
order by estimated_revenue desc;

--16 Find users who reviewed more than 5 different products.

SELECT 
    u.user_id,
    u.user_name,
    COUNT(DISTINCT r.product_id) AS product_reviewed
FROM Review r
JOIN [User] u ON r.product_id = u.product_id
GROUP BY u.user_id, u.user_name
HAVING COUNT(DISTINCT r.product_id) > 5
ORDER BY product_reviewed DESC;


--17 List top 5 products with highest discount in each category.

WITH DiscountedProducts_ranks AS (
    SELECT 
        product_id,
        product_name,
        category,
        discounted_price,
        RIGHT(category, CHARINDEX('|', REVERSE(category) + '|') - 1) AS final_category,
        DENSE_RANK() OVER (
            PARTITION BY RIGHT(category, CHARINDEX('|', REVERSE(category) + '|') - 1)
            ORDER BY discounted_price DESC
        ) AS rank
    FROM Product
)

SELECT 
    final_category,
    product_id,
    product_name,
    discounted_price
FROM DiscountedProducts_ranks
WHERE rank <= 5
ORDER BY final_category, rank;



--18. Find products with low rating but high number of reviews.

with Product_Review_Stats as 
          (select p.product_id, ROUND( AVG(p.rating), 2) as Rating, Count(r.review_id) as Reviews
           from Product p
            join Review r on r.product_id = p.product_id
            group by p.product_id
          )

select product_id, Rating, Reviews 
from Product_Review_Stats
where Rating < 3 and Reviews > 5
;

