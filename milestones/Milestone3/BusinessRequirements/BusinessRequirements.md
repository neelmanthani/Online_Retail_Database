Database Business Requirements


1. Find the number of reviews on a product sorted by score (uses GROUP BY)
2. Find the number of users from each age (uses GROUP BY)
3. Find number of orders made with each type of delivery option (uses GROUP BY)
4. Find the number of user addresses from each state, where the count of users is greater than <X> (uses GROUP BY and HAVING)
5. Create a procedure to update order details when user checks out shopping cart  (uses stored procedure)
6. Create a procedure to find all products in a category (passed as parameter) that cost more than a certain amount (also passed as parameter) (uses stored procedure)
7. Update order detail total when adding a new order item (uses trigger)
8. Update expenses when a specific expense is made (uses trigger)
9. Delete cart items when shopping session is deleted (uses ON CASCADE)
10. Delete corresponding PPC Manager, marketing specialist, qa rep, or customer service rep when office worker is deleted (uses ON CASCADE)
11. Create a function to find all office workers that have made over <X> errors that have been working for less than <Y> years (uses function)
12. Create a function to find the number of users that have made purchases which total more than <X> who are members (uses function)
13. Lower price of products that haven’t sold by <X>% (uses update that includes join)
14. Give a <X>% raise to QA reps that have <Y> or less errors (uses update that includes join)
15. Find the number of returns that are made on orders processed from each distribution center (uses inner query)
16. For each product category, find the total sales (uses GROUP BY and inner query)




Bot Commands


1. /product_reviews_by_score \<product_id\> (i.e. /product_reviews_by_score 1)
2. /users_by_age_group
3. /orders_by_delivery_option
4. /count_addresses_by_state \<users\>  (i.e. /count_addresses_by_state 2)
5. /check_out_shopping_cart \<cart_id\> (i.e. /check_out_shopping_cart 1)
6. /find_products \<category\>, \<amount\>  (i.e. /find_products Clothing 20)
7. /update_order_detail_total \<order_detail\>, \<product\>, \<quantity\>  (i.e. /update_order_detail_total 1 2 3)
8. /update_expenses 
9. /delete_shopping_cart_items \<cart_id\> (i.e. /delete_shopping_cart_items 2)
10. /delete_specialized_workers \<worker_id\> (i.e. /delete_specialized_workers 3)
11. /find_low_performers \<years\>, \<errors\> (i.e. /find_low_performers 11 2)
12. /find_highest_paying_members \<amount\> (i.e. /find_highest_paying_members 25)
13. /discount_low_selling_products \<percentDiscount\> (i.e. /discount_low_selling_products 0.9)
14. /give_raise_to_qareps \<percentRaise\>, \<errors\> (i.e. /give_raise_to_qareps 0.3, 2)
15. /returns_per_distribution_center
16. /sales_per_product_category
