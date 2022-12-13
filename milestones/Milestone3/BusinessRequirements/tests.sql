Use OnlineRetailDB;

SELECT r.score, COUNT(r.score) as cnt 
FROM Review r
WHERE product = 1
GROUP BY r.score;


SELECT TIMESTAMPDIFF( YEAR, u.dob,  CURDATE()) AS age, COUNT(TIMESTAMPDIFF( YEAR, u.dob,  CURDATE())) as cnt
FROM User u
GROUP BY age;

SELECT COUNT(od.delivery_option) as cnt, devop.description
FROM OrderDetail od
JOIN DeliveryOption devop ON od.delivery_option = devop.option_id
GROUP BY od.delivery_option;

SELECT COUNT(ad.state) as cnt, ad.state
FROM Address ad
JOIN UserAddress uad ON ad.address_id = uad.address
GROUP BY ad.state
HAVING COUNT(ad.state) >= 2;

-- SELECT * FROM CartItem;
-- SELECT * FROM OrderItem;
-- SELECT * FROM OrderDetail;

DELIMITER $$

DROP TRIGGER  IF EXISTS  UPDATE_SUPPLIER_EXPENSE$$
CREATE TRIGGER UPDATE_SUPPLIER_EXPENSE AFTER INSERT ON SupplierExpense
FOR EACH ROW
BEGIN

	DECLARE expense_id INT;
    
    INSERT INTO Expense
    VALUES (0, "Supplier Expense", new.amount);
    set expense_id = (LAST_INSERT_ID());
    
    
    INSERT INTO ExpenseIncurred
    VALUES (expense_id, NULL, new.sexpense_id, NULL, NULL);
    
END $$

DROP TRIGGER  IF EXISTS  UPDATE_VENDOR_EXPENSE$$
CREATE TRIGGER UPDATE_VENDOR_EXPENSE AFTER INSERT ON VendorExpense
FOR EACH ROW
BEGIN

	DECLARE expense_id INT;
    
    INSERT INTO Expense
    VALUES (0, "Vendor Expense", new.amount);
    set expense_id = (LAST_INSERT_ID());
    
    INSERT INTO ExpenseIncurred
    VALUES (expense_id, new.vexpense_id, NULL, NULL, NULL);
    
END $$

DROP TRIGGER  IF EXISTS  UPDATE_PACKAGING_EXPENSE$$
CREATE TRIGGER UPDATE_PACKAGING_EXPENSE AFTER INSERT ON PackagingExpense
FOR EACH ROW
BEGIN

	DECLARE expense_id INT;
    
    INSERT INTO Expense
    VALUES (0, "Packaging Expense", new.amount);
    set expense_id = (LAST_INSERT_ID());
    
    INSERT INTO ExpenseIncurred
    VALUES (expense_id, NULL, NULL, NULL, new.pexpense_id);
    
END $$

DROP TRIGGER  IF EXISTS  UPDATE_COURIER_EXPENSE$$
CREATE TRIGGER UPDATE_COURIER_EXPENSE AFTER INSERT ON CourierExpense
FOR EACH ROW
BEGIN

	DECLARE expense_id INT;
    
    INSERT INTO Expense
    VALUES (0, "Courier Expense", new.amount);
    set expense_id = (LAST_INSERT_ID());
    
    INSERT INTO ExpenseIncurred
    VALUES (expense_id, NULL, NULL, new.cexpense_id, NULL);
    
END $$

DROP TRIGGER  IF EXISTS  UPDATE_ORDERDETAIL_TOTAL$$
CREATE TRIGGER UPDATE_ORDERDETAIL_TOTAL AFTER INSERT ON OrderItem
FOR EACH ROW
BEGIN

	DECLARE cost DECIMAL(10,2);
    DECLARE pid INT;
    DECLARE quantity INT;
    
	set pid = new.product;
	set quantity = new.quantity;
    set cost = (SELECT p.price*quantity
    FROM Product p 
    WHERE pid = p.product_id)
    ;
    
    UPDATE OrderDetail o
    SET o.total = o.total + cost
    WHERE o.order_id = new.orderDetail;
    
END $$

DROP TRIGGER  IF EXISTS  CASCADE_DELETE_SPECIALIZED_WORKERS$$
CREATE TRIGGER CASCADE_DELETE_SPECIALIZED_WORKERS BEFORE DELETE ON OfficeWorker
FOR EACH ROW
BEGIN
	DECLARE worker_id INT;
    
    set worker_id = old.worker_id;
    
    DELETE FROM MarketingSpecialist m
    WHERE m.office_worker = worker_id;
    
    DELETE FROM PPCManager p
    WHERE p.office_worker = worker_id;
    
    DELETE FROM CustomerServiceRep c
    WHERE c.office_worker = worker_id;
    
    DELETE FROM QualityAssuranceRep q
    WHERE q.office_worker = worker_id;

END $$

DROP TRIGGER  IF EXISTS  CASCADE_DELETE_CART_ITEMS$$
CREATE TRIGGER CASCADE_DELETE_CART_ITEMS BEFORE DELETE ON ShoppingSession
FOR EACH ROW
BEGIN

	DECLARE shopping_session_id INT;
    
    set shopping_session_id = old.session_id;
    
    DELETE FROM CartItem ci
    WHERE ci.shopping_session = shopping_session_id;

END $$



DROP PROCEDURE  IF EXISTS  CHECKOUT_CART $$
CREATE PROCEDURE CHECKOUT_CART (IN cart_id INT)
BEGIN
	DECLARE temp_total DECIMAL(10,2);
    DECLARE user_id INT;
    DECLARE order_detail_id INT;
    
    set temp_total = (SELECT total FROM ShoppingSession WHERE session_id = cart_id);
    set user_id = (SELECT user FROM ShoppingSession WHERE session_id = cart_id);
    
    INSERT INTO OrderDetail
    VALUES (0, 0, NOW(), user_id, NULL, NULL, NULL, NULL, NULL);
    set order_detail_id = (LAST_INSERT_ID());
    
    
	INSERT INTO OrderItem (quantity, created_at, product, orderDetail)
	SELECT ci.quantity, NOW(), ci.product, order_detail_id
    FROM CartItem ci
    WHERE ci.shopping_session = cart_id;
    
    DELETE FROM CartItem WHERE shopping_session = cart_id;
    DELETE FROM ShoppingSession WHERE session_id = cart_id;
    
END $$

DROP PROCEDURE  IF EXISTS  LIST_PRODUCTS_FROM_CATEGORY$$
CREATE PROCEDURE LIST_PRODUCTS_FROM_CATEGORY (IN category VARCHAR(45), IN amount DECIMAL(10,2))
BEGIN
	SELECT pr.name, pr.price, cat.subcategory_name
    FROM Product pr
    JOIN ProductCategory cat ON pr.product_category = cat.category_id
    WHERE pr.price > amount AND cat.category_name = category;
    
END $$

DROP FUNCTION  IF EXISTS  FIND_LOW_PERFORMERS$$
CREATE FUNCTION FIND_LOW_PERFORMERS (years INT, numErrors INT) RETURNS int DETERMINISTIC
BEGIN
 DECLARE total INT;
 DECLARE currentDate DATE;
 
 SET currentDate = NOW();
  
 -- Select all customer service reps with over numErrors mistakes and with under years of experience
 
SET total = (SELECT COUNT(*)
FROM OfficeWorker ow
LEFT JOIN CustomerServiceRep csr ON ow.worker_id = csr.office_worker
LEFT JOIN QualityAssuranceRep qar ON ow.worker_id = qar.office_worker
WHERE (csr.errors >= numErrors || qar.errors >= numErrors) && DATEDIFF(NOW(), ow.date_hired) < (years*365))
;
 

RETURN total;  
  
END $$

DROP FUNCTION  IF EXISTS  FIND_HIGH_PAYING_MEMBERS$$
CREATE FUNCTION FIND_HIGH_PAYING_MEMBERS (amount DECIMAL(10,2)) RETURNS int DETERMINISTIC
BEGIN
 DECLARE total INT;
  

 SET total = (SELECT COUNT(*) 
FROM
(SELECT u.user_id, SUM(od.total) totals
 FROM User u
 JOIN OrderDetail od ON od.user = u.user_id
 JOIN Membership mb ON mb.user = u.user_id
 GROUP BY u.user_id
 HAVING SUM(od.total) > amount) counts);


RETURN total;  
  
END $$

DROP PROCEDURE  IF EXISTS  DISCOUNT_LOW_SELLING_PRODUCTS$$
CREATE PROCEDURE DISCOUNT_LOW_SELLING_PRODUCTS (IN discount DECIMAL(10,2))
BEGIN

	UPDATE Product p
	LEFT JOIN OrderItem oi
	ON oi.product = p.product_id
	SET p.price = p.price * discount
	WHERE oi.product IS NULL;

END $$


DROP PROCEDURE  IF EXISTS  GIVE_QAREPS_RAISE$$
CREATE PROCEDURE GIVE_QAREPS_RAISE (IN raise DECIMAL(10,2), IN numErrors INT)
BEGIN

	UPDATE OfficeWorker ow
	LEFT JOIN QualityAssuranceRep qar
	ON ow.worker_id = qar.office_worker
	SET ow.salary = ow.salary * (1 + raise)
	WHERE qar.errors <= numErrors;

END $$


DELIMITER ;


-- CALL CHECKOUT_CART(1);


-- SELECT * FROM OrderItem;
-- SELECT * FROM CartItem;
-- SELECT * FROM OrderDetail;
-- SELECT * FROM Product;

CALL LIST_PRODUCTS_FROM_CATEGORY("Clothing" , 10);
CALL LIST_PRODUCTS_FROM_CATEGORY("Clothing" , 20);

SELECT * FROM ExpenseIncurred;
SELECT * FROM Expense;

INSERT INTO SupplierExpense
VALUES (0, 200, "stest", NOW(), 0);

INSERT INTO VendorExpense
VALUES (0, 200, "vtest", NOW(), 0);

INSERT INTO PackagingExpense
VALUES (0, 200, "ptest", NOW(), 0);

INSERT INTO CourierExpense
VALUES (0, 200, "ctest", NOW(), 0);

SELECT * FROM ExpenseIncurred;
SELECT * FROM Expense;

SELECT FIND_LOW_PERFORMERS(11,2);

SELECT FIND_HIGH_PAYING_MEMBERS(1000);


-- SELECT DATEDIFF(NOW(), ow.date_hired) as yrs, ow.worker_id, csr.errors, ow.date_hired,
-- csr.service_rep_id, qar.qa_rep_id, qar.errors
-- FROM OfficeWorker ow
-- LEFT JOIN CustomerServiceRep csr ON ow.worker_id = csr.office_worker
-- LEFT JOIN QualityAssuranceRep qar ON ow.worker_id = qar.office_worker
-- WHERE (csr.errors >= 2 || qar.errors >= 2) && DATEDIFF(NOW(), ow.date_hired) < (20*365) 
-- ;


-- SELECT COUNT(*) 
-- FROM
-- (SELECT u.user_id, SUM(od.total) totals
--  FROM User u
--  JOIN OrderDetail od ON od.user = u.user_id
--  JOIN Membership mb ON mb.user = u.user_id
--  GROUP BY u.user_id
--  HAVING SUM(od.total) > 30) counts;


-- SELECT * FROM PackagingExpense;
-- SELECT * FROM Expense;
-- SELECT * FROM ExpenseIncurred;


-- select products that are not included in order items

SELECT * FROM Product;

CALL DISCOUNT_LOW_SELLING_PRODUCTS(0.5);

SELECT * FROM Product;


SELECT * FROM QualityAssuranceRep;
SELECT * FROM OfficeWorker;

CALL GIVE_QAREPS_RAISE (0.2, 2);

SELECT * FROM OfficeWorker;

-- find the number of returns per distribution center; select all orders processed and group by 

SELECT center_id, COUNT(*)
FROM
(SELECT dcw.distribution_center center_id
 FROM ProcessedOrder po, DistributionCenterWorker dcw, OrderReturn orr
 WHERE po.worker_id = dcw.worker_id
 AND po.order_id = orr.orderDetail
) returned_processed_orders
GROUP BY center_id;

-- select all order items, calculate price of each, find the product cost

SELECT pc.category_id, pc.category_name, pc.subcategory_name, SUM(sales.total) AS total_sales
FROM
(SELECT (oi.quantity * p.price) AS total, p.product_category FROM OrderItem oi
JOIN Product p
ON p.product_id = oi.product) sales, ProductCategory pc
WHERE pc.category_id = sales.product_category
GROUP BY pc.category_id;


SELECT * FROM OfficeWorker;
SELECT * FROM QualityAssuranceRep;
SELECT * FROM PPCManager;
SELECT * FROM MarketingSpecialist;
SELECT * FROM CustomerServiceRep;

-- DELETE FROM OfficeWorker ow
-- WHERE ow.worker_id = 6;


SELECT * FROM OfficeWorker;
SELECT * FROM QualityAssuranceRep;
SELECT * FROM PPCManager;
SELECT * FROM MarketingSpecialist;
SELECT * FROM CustomerServiceRep;


-- SELECT *
-- FROM OfficeWorker ow
-- LEFT JOIN CustomerServiceRep csr ON ow.worker_id = csr.office_worker
-- LEFT JOIN QualityAssuranceRep qar ON ow.worker_id = qar.office_worker
-- WHERE (csr.errors >= 2 || qar.errors >= 2) && DATEDIFF(NOW(), ow.date_hired) < (11*365);

SELECT FIND_LOW_PERFORMERS(11,2);

SELECT * FROM OfficeWorker;
SELECT * FROM CustomerServiceRep;
SELECT * FROM QualityAssuranceRep;


