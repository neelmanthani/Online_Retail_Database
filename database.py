# database.py
# Handles all the methods interacting with the database of the application.
# Students must implement their own methods here to meet the project requirements.

log_bin_trust_function_creators = 1

import os
import pymysql.cursors

db_host = os.environ['DB_HOST']
db_username = os.environ['DB_USER']
db_password = os.environ['DB_PASSWORD']
db_name = os.environ['DB_NAME']


def connect():
    try:
        conn = pymysql.connect(host=db_host,
                               port=3306,
                               user=db_username,
                               password=db_password,
                               db=db_name,
                               charset="utf8mb4", cursorclass=pymysql.cursors.DictCursor)
        print("Bot connected to database {}".format(db_name))

        return conn
    except:
        print("Bot failed to create a connection with your database because your secret environment variables " +
              "(DB_HOST, DB_USER, DB_PASSWORD, DB_NAME) are not set".format(db_name))
        print("\n")

# your code here

#loads all procedures, triggers, and functions into database

def load_procedures_triggers_functions():
     connection = connect()
     if connection:

       sql = """DROP TRIGGER  IF EXISTS  UPDATE_ORDERDETAIL_TOTAL;"""
       cursor = connection.cursor()
       cursor.execute(sql)
       connection.commit()
       
       sql = """CREATE TRIGGER UPDATE_ORDERDETAIL_TOTAL AFTER INSERT ON OrderItem
FOR EACH ROW
BEGIN
	DECLARE cost DECIMAL(10,2);
    DECLARE pid INT;
    DECLARE quantity INT;
	set pid = new.product;
	set quantity = new.quantity;
    set cost = (SELECT p.price*quantity
    FROM Product p 
    WHERE pid = p.product_id);
    UPDATE OrderDetail o
    SET o.total = o.total + cost
    WHERE o.order_id = new.orderDetail;
    
END ;"""
       
       cursor = connection.cursor()
       cursor.execute(sql)
       connection.commit()

       sql = """DROP TRIGGER  IF EXISTS  UPDATE_SUPPLIER_EXPENSE;"""
       cursor = connection.cursor()
       cursor.execute(sql)
       connection.commit()
       
       sql = """CREATE TRIGGER UPDATE_SUPPLIER_EXPENSE AFTER INSERT ON SupplierExpense
FOR EACH ROW
BEGIN

	DECLARE expense_id INT;
    
    INSERT INTO Expense
    VALUES (0, "Supplier Expense", new.amount);
    set expense_id = (LAST_INSERT_ID());
    
    
    INSERT INTO ExpenseIncurred
    VALUES (expense_id, NULL, new.sexpense_id, NULL, NULL);
    
END;"""

       cursor = connection.cursor()
       cursor.execute(sql)
       connection.commit()

       sql = """DROP TRIGGER  IF EXISTS  UPDATE_VENDOR_EXPENSE;"""
       cursor = connection.cursor()
       cursor.execute(sql)
       connection.commit()
       
       sql = """CREATE TRIGGER UPDATE_VENDOR_EXPENSE AFTER INSERT ON VendorExpense
FOR EACH ROW
BEGIN

	DECLARE expense_id INT;
    
    INSERT INTO Expense
    VALUES (0, "Vendor Expense", new.amount);
    set expense_id = (LAST_INSERT_ID());
    
    INSERT INTO ExpenseIncurred
    VALUES (expense_id, new.vexpense_id, NULL, NULL, NULL);
    
END;"""
       
       cursor = connection.cursor()
       cursor.execute(sql)
       connection.commit()

       sql = """DROP TRIGGER  IF EXISTS  UPDATE_PACKAGING_EXPENSE;"""
       cursor = connection.cursor()
       cursor.execute(sql)
       connection.commit()
       
       sql = """CREATE TRIGGER UPDATE_PACKAGING_EXPENSE AFTER INSERT ON PackagingExpense
FOR EACH ROW
BEGIN

	DECLARE expense_id INT;
    
    INSERT INTO Expense
    VALUES (0, "Packaging Expense", new.amount);
    set expense_id = (LAST_INSERT_ID());
    
    INSERT INTO ExpenseIncurred
    VALUES (expense_id, NULL, NULL, NULL, new.pexpense_id);
    
END;"""
       
       cursor = connection.cursor()
       cursor.execute(sql)
       connection.commit()

       sql = """DROP TRIGGER  IF EXISTS  UPDATE_COURIER_EXPENSE;"""
       cursor = connection.cursor()
       cursor.execute(sql)
       connection.commit()
       
       sql = """CREATE TRIGGER UPDATE_COURIER_EXPENSE AFTER INSERT ON CourierExpense
FOR EACH ROW
BEGIN

	DECLARE expense_id INT;
    
    INSERT INTO Expense
    VALUES (0, "Courier Expense", new.amount);
    set expense_id = (LAST_INSERT_ID());
    
    INSERT INTO ExpenseIncurred
    VALUES (expense_id, NULL, NULL, new.cexpense_id, NULL);
    
END;"""
       
       cursor = connection.cursor()
       cursor.execute(sql)
       connection.commit()
       
       sql = """DROP PROCEDURE  IF EXISTS  LIST_PRODUCTS_FROM_CATEGORY;"""
       cursor = connection.cursor()
       cursor.execute(sql)
       
       sql = """CREATE PROCEDURE LIST_PRODUCTS_FROM_CATEGORY (IN category VARCHAR(45), IN amount DECIMAL(10,2))
BEGIN
	SELECT pr.name, pr.price, cat.subcategory_name
    FROM Product pr
    JOIN ProductCategory cat ON pr.product_category = cat.category_id
    WHERE pr.price > amount AND cat.category_name = category;
    
END ;"""
       cursor = connection.cursor()
       cursor.execute(sql)
       connection.commit()

       sql = """DROP PROCEDURE  IF EXISTS  CHECKOUT_CART;"""
       cursor = connection.cursor()
       cursor.execute(sql)
       
       sql = """CREATE PROCEDURE CHECKOUT_CART (IN cart_id INT)
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
    
END ;"""
       cursor = connection.cursor()
       cursor.execute(sql)
       connection.commit()
       
       return
     else:
       print("connection failed");
     return "error"
  

def test_query():
     connection = connect()
     if connection:
       sql = """SELECT user_id, first_name, last_name FROM User"""
       variable = None
       cursor = connection.cursor()
       cursor.execute(sql)
       connection.commit()
       results = cursor.fetchall()
       return results
     else:
       print("connection failed");
     return "error"

def product_reviews_by_score(product_id):
     connection = connect()
     if connection:
       sql = """SELECT r.score, COUNT(r.score) AS count
       FROM Review r
       WHERE r.product = (%s)
       GROUP BY r.score;"""
       variable = product_id
       cursor = connection.cursor()
       cursor.execute(sql, variable)
       connection.commit()
       results = cursor.fetchall()

       textResult = """Review Score Breakdown for \n 
  Product_ID: """ + str(product_id) + "\n\n";

       for row in results:
         textResult +=  "Score: " + str(row["score"]) + "     Count: " + str(row["count"]) + "\n"
       return textResult
     else:
       print("connection failed");
     return "error"
  
def users_by_age_group():
    connection = connect()
    if connection:
       sql = """SELECT TIMESTAMPDIFF( YEAR, u.dob,  CURDATE()) AS age, COUNT(TIMESTAMPDIFF( YEAR, u.dob,  CURDATE())) as count
FROM User u
GROUP BY age 
ORDER BY age DESC;"""
       cursor = connection.cursor()
       cursor.execute(sql)
       connection.commit()
       results = cursor.fetchall()
      
       textResult = "User Ages \n\n"

       for row in results:
         textResult +=  "Age: " + str(row["age"]) + "     Count: " + str(row["count"]) + "\n"
       return textResult
    else:
       print("connection failed");
    return "error"
  
def orders_by_delivery_option():
    connection = connect()
    if connection:
       sql = """SELECT devop.description, COUNT(od.delivery_option) as count
FROM OrderDetail od
JOIN DeliveryOption devop ON od.delivery_option = devop.option_id
GROUP BY od.delivery_option;"""
       cursor = connection.cursor()
       cursor.execute(sql)
       connection.commit()
       results = cursor.fetchall()

       textResult = "Number of Orders Using Delivery Option \n\n"

       for row in results:
          textResult +=  "Delivery Option: " + str(row["description"]) + "     Count: " + str(row["count"]) + "\n"
       return textResult
    else:
       print("connection failed");
    return "error"
  
def count_addresses_by_state(min_users):
    connection = connect()
    if connection:
       sql = """SELECT COUNT(ad.state) as count, ad.state
FROM Address ad
JOIN UserAddress uad ON ad.address_id = uad.address
GROUP BY ad.state
HAVING COUNT(ad.state) >= %s"""
       variable = min_users
       print(min_users)
       cursor = connection.cursor()
       cursor.execute(sql, variable)
       connection.commit()
       results = cursor.fetchall()

       textResult = "Number of Addresses Per State \n\n"

       for row in results:
          textResult +=  "State: " + str(row["state"]) + "     Count: " + str(row["count"]) + "\n"
       return textResult
    else:
       print("connection failed");
    return "error"

def check_out_shopping_cart(cart_id):
  connection = connect()
  if connection:

    
      sqlInfo1 = """SELECT oi.item_order_id, oi.quantity, oi.orderDetail, oi.product FROM OrderItem oi;"""
      sqlInfo2 = """SELECT ci.item_id, ci.quantity, ci.product FROM CartItem ci;""" 
      sqlInfo3 = """SELECT od.order_id, od.user, od.total FROM OrderDetail od;"""
      
      cursor = connection.cursor()
    
      cursor.execute(sqlInfo1)
      results = cursor.fetchall()

      textResult = "Before Checking Out Cart: \n\n"
      textResult += "Order Items \n"

      for row in results:
          textResult +=  "ID: " + str(row["item_order_id"]) + "     Quantity: " + str(row["quantity"]) + "     OrderDetail: " + str(row["orderDetail"]) + "     Product_ID: " + str(row["product"]) + "\n"

      textResult += "\n"

      cursor.execute(sqlInfo2)
      results = cursor.fetchall()

      textResult += "Cart Items \n"

      for row in results:
          textResult +=  "ID: " + str(row["item_id"]) + "     Quantity: " + str(row["quantity"]) + "     Product_ID: " + str(row["product"]) + "\n"

      textResult += "\n"

      cursor.execute(sqlInfo3)
      results = cursor.fetchall()

      textResult += "Order Details \n"

      for row in results:
          textResult +=  "ID: " + str(row["order_id"]) + "     User_ID: " + str(row["user"]) + "     Total: " + str(row["total"]) + "\n"

      textResult += "\n\n"
    

    
      sql = """CALL CHECKOUT_CART(%s)"""
      variable = cart_id
      cursor.execute(sql, variable)
      connection.commit()

      cursor.execute(sqlInfo1)
      results = cursor.fetchall()

      textResult += "After Checking Out Cart: \n\n"
      textResult += "Order Items \n"

      for row in results:
          textResult +=  "ID: " + str(row["item_order_id"]) + "     Quantity: " + str(row["quantity"]) + "     OrderDetail: " + str(row["orderDetail"]) + "     Product_ID: " + str(row["product"]) + "\n"

      textResult += "\n"

      cursor.execute(sqlInfo2)
      results = cursor.fetchall()

      textResult += "Cart Items \n"

      for row in results:
          textResult +=  "ID: " + str(row["item_id"]) + "     Quantity: " + str(row["quantity"]) + "     Product_ID: " + str(row["product"]) + "\n"

      textResult += "\n"

      cursor.execute(sqlInfo3)
      results = cursor.fetchall()

      textResult += "Order Details \n"

      for row in results:
          textResult +=  "ID: " + str(row["order_id"]) + "     User_ID: " + str(row["user"]) + "     Total: " + str(row["total"]) + "\n"

      textResult += "\n\n"
      
      return textResult
  else:
      print("connection failed");
  return
  
def find_products(category, amount):
    connection = connect()
    if connection:
      
      sql = """CALL LIST_PRODUCTS_FROM_CATEGORY(%s , %s)"""
      variable = (category, amount)
      cursor = connection.cursor()
      cursor.execute(sql, variable)
      connection.commit()
      results = cursor.fetchall()

      textResult = "Products in the " + category + " category" + "\n\n"

      for row in results:
          textResult +=  "Name: " + str(row["name"]) + "     Price: " + str(row["price"]) + "     Subcategory: " + str(row["subcategory_name"])+ "\n"
        
      return textResult
      
    return
  
def update_order_detail_total(orderDetail, product, quantity):
  connection = connect()
  if connection:

      sqlInfo1 = """SELECT oi.item_order_id, oi.quantity, oi.orderDetail, oi.product FROM OrderItem oi;"""
      sqlInfo2 = """SELECT od.order_id, od.user, od.total FROM OrderDetail od;"""
      
      cursor = connection.cursor()
    
      cursor.execute(sqlInfo1)
      results = cursor.fetchall()

      textResult = "Before Inserting New Order Item: \n\n"
      textResult += "Order Items \n"

      for row in results:
          textResult +=  "ID: " + str(row["item_order_id"]) + "     Quantity: " + str(row["quantity"]) + "     OrderDetail: " + str(row["orderDetail"]) + "     Product_ID: " + str(row["product"]) + "\n"

      textResult += "\n"

      cursor.execute(sqlInfo2)
      results = cursor.fetchall()

      textResult += "Order Details \n"

      for row in results:
          textResult +=  "ID: " + str(row["order_id"]) + "     User_ID: " + str(row["user"]) + "     Total: " + str(row["total"]) + "\n"

      textResult += "\n\n"

      sql = """INSERT INTO OrderItem
      VALUES (0, %s, NOW(), %s, %s)"""
      variable = (orderDetail, product, quantity)
      cursor.execute(sql, variable)
      connection.commit()

      cursor.execute(sqlInfo1)
      results = cursor.fetchall()

      textResult += "After Inserting New Order Item: \n\n"
      textResult += "Order Items \n"

      for row in results:
          textResult +=  "ID: " + str(row["item_order_id"]) + "     Quantity: " + str(row["quantity"]) + "     OrderDetail: " + str(row["orderDetail"]) + "     Product_ID: " + str(row["product"]) + "\n"

      textResult += "\n"

      cursor.execute(sqlInfo2)
      results = cursor.fetchall()

      textResult += "Order Details \n"

      for row in results:
          textResult +=  "ID: " + str(row["order_id"]) + "     User_ID: " + str(row["user"]) + "     Total: " + str(row["total"]) + "\n"

      textResult += "\n\n"
    
      return textResult
  
  return
  
def update_expenses():

  connection = connect()
  if connection:

    
      sqlInfo1 = """SELECT * FROM ExpenseIncurred;"""
      sqlInfo2 = """SELECT * FROM Expense;"""
      
      cursor = connection.cursor()
    
      cursor.execute(sqlInfo1)
      results = cursor.fetchall()

      textResult = "Before Updating Expenses: \n\n"
      textResult += "ExpenseIncurred \n"

      for row in results:
          textResult +=  "ID: " + str(row["expense_incurred_id"]) + "     Vendor Expense ID: " + str(row["vexpense"]) + "     Supplier Expense ID: " + str(row["sexpense"]) + "     Courier Expense ID: " + str(row["cexpense"]) + "     Packaging Expense ID: " + str(row["pexpense"]) + "\n"

      textResult += "\n"

      cursor.execute(sqlInfo2)
      results = cursor.fetchall()

      textResult += "Expense \n"

      for row in results:
          textResult +=  "ID: " + str(row["expense_id"]) + "     Category: " + str(row["category"]) + "     Amount: " + str(row["amount"]) + "\n"

      textResult += "\n\n"
    
    
      sql = """INSERT INTO SupplierExpense
VALUES (0, 200, "stest", NOW(), 0);"""
      cursor.execute(sql)
      connection.commit()

      sql = """INSERT INTO VendorExpense
VALUES (0, 200, "vtest", NOW(), 0);"""
      cursor.execute(sql)
      connection.commit()

      sql = """INSERT INTO PackagingExpense
VALUES (0, 200, "ptest", NOW(), 0);"""
      cursor.execute(sql)
      connection.commit()

      sql = """INSERT INTO CourierExpense
VALUES (0, 200, "ctest", NOW(), 0);"""
      cursor.execute(sql)
      connection.commit()

      cursor.execute(sqlInfo1)
      results = cursor.fetchall()

      textResult += "After Updating Expenses: \n\n"
      textResult += "ExpenseIncurred \n"

      for row in results:
          textResult +=  "ID: " + str(row["expense_incurred_id"]) + "     Vendor Expense ID: " + str(row["vexpense"]) + "     Supplier Expense ID: " + str(row["sexpense"]) + "     Courier Expense ID: " + str(row["cexpense"]) + "     Packaging Expense ID: " + str(row["pexpense"]) + "\n"

      textResult += "\n"

      cursor.execute(sqlInfo2)
      results = cursor.fetchall()

      textResult += "Expense \n"

      for row in results:
          textResult +=  "ID: " + str(row["expense_id"]) + "     Category: " + str(row["category"]) + "     Amount: " + str(row["amount"]) + "\n"

      textResult += "\n\n"

      
      return textResult
  else:
      print("connection failed");
  return

def delete_shopping_cart_items(cart_id):
    connection = connect()
    if connection:

      sqlInfo1 = """SELECT ss.session_id FROM ShoppingSession ss;"""
      sqlInfo2 = """SELECT ci.item_id, ci.shopping_session FROM CartItem ci;"""

      cursor = connection.cursor()
    
      cursor.execute(sqlInfo1)
      results = cursor.fetchall()

      textResult = "Before Deleting Cart: \n\n"
      textResult += "Shopping Session \n"

      for row in results:
          textResult +=  "ID: " + str(row["session_id"]) + "\n"

      textResult += "\n"

      cursor.execute(sqlInfo2)
      results = cursor.fetchall()

      textResult += "Cart Items \n"

      for row in results:
          textResult +=  "ID: " + str(row["item_id"]) + "     Shopping Session: " + str(row["shopping_session"]) + "\n"

      textResult += "\n\n"
      
      sql = """DELETE FROM ShoppingSession ss
      WHERE ss.session_id = (%s);"""

      variable = cart_id
      cursor = connection.cursor()
      cursor.execute(sql, variable)
      connection.commit()


      textResult += "After Deleting Cart: \n\n"
      textResult += "Shopping Session \n"

      cursor.execute(sqlInfo1)
      results = cursor.fetchall()

      for row in results:
          textResult +=  "ID: " + str(row["session_id"]) + "\n"

      textResult += "\n"

      cursor.execute(sqlInfo2)
      results = cursor.fetchall()

      textResult += "Cart Items \n"

      for row in results:
          textResult +=  "ID: " + str(row["item_id"]) + "     Shopping Session: " + str(row["shopping_session"]) + "\n"

      textResult += "\n\n"
      
      return textResult
    return
  
def delete_specialized_workers(worker_id):
    connection = connect()
    if connection:

    

      sqlInfo1 = """SELECT ow.worker_id FROM OfficeWorker ow;"""
      sqlInfo2 = """SELECT qar.qa_rep_id, qar.office_worker FROM QualityAssuranceRep qar;"""
      sqlInfo3 = """SELECT pm.manager_id, pm.office_worker FROM PPCManager pm;"""
      sqlInfo4 = """SELECT ms.specialist_id, ms.office_worker FROM MarketingSpecialist ms;"""
      sqlInfo5 = """SELECT csr.service_rep_id, csr.office_worker FROM CustomerServiceRep csr;"""

      cursor = connection.cursor()
      
      cursor.execute(sqlInfo1)
      results = cursor.fetchall()

      textResult = "Before Deleting Office Worker: \n\n"
      textResult += "Office Worker \n"

      for row in results:
          textResult +=  "ID: " + str(row["worker_id"]) + "\n"

      textResult += "\n"

      cursor.execute(sqlInfo2)
      results = cursor.fetchall()

      textResult += "Quality Assurance Rep \n"

      for row in results:
          textResult +=  "QARep ID: " + str(row["qa_rep_id"]) + "     Office Worker ID: " + str(row["office_worker"]) + "\n"

      textResult += "\n"

      cursor.execute(sqlInfo3)
      results = cursor.fetchall()

      textResult += "Marketing Specialist \n"

      for row in results:
          textResult +=  "PPC ID: " + str(row["manager_id"]) + "     Office Worker ID: " + str(row["office_worker"]) + "\n"

      textResult += "\n"

      cursor.execute(sqlInfo4)
      results = cursor.fetchall()

      textResult += "PPC Manager \n"

      for row in results:
          textResult +=  "Specialist ID: " + str(row["specialist_id"]) + "     Office Worker ID: " + str(row["office_worker"]) + "\n"

      textResult += "\n"

      cursor.execute(sqlInfo5)
      results = cursor.fetchall()

      textResult += "Service Representative \n"

      for row in results:
          textResult +=  "Service Rep ID: " + str(row["service_rep_id"]) + "     Office Worker ID: " + str(row["office_worker"]) + "\n"

      textResult += "\n\n"
      
    
  
      sql = """DELETE FROM OfficeWorker ow
      WHERE ow.worker_id = (%s);"""

      variable = worker_id
      cursor = connection.cursor()
      cursor.execute(sql, variable)
      connection.commit()

      cursor.execute(sqlInfo1)
      results = cursor.fetchall()

      textResult += "After Deleting Office Worker: \n\n"
      textResult += "Office Worker \n"

      for row in results:
          textResult +=  "ID: " + str(row["worker_id"]) + "\n"

      textResult += "\n"

      cursor.execute(sqlInfo2)
      results = cursor.fetchall()

      textResult += "Quality Assurance Rep \n"

      for row in results:
          textResult +=  "QARep ID: " + str(row["qa_rep_id"]) + "     Office Worker ID: " + str(row["office_worker"]) + "\n"

      textResult += "\n"

      cursor.execute(sqlInfo3)
      results = cursor.fetchall()

      textResult += "Marketing Specialist \n"

      for row in results:
          textResult +=  "PPC ID: " + str(row["manager_id"]) + "     Office Worker ID: " + str(row["office_worker"]) + "\n"

      textResult += "\n"

      cursor.execute(sqlInfo4)
      results = cursor.fetchall()

      textResult += "PPC Manager \n"

      for row in results:
          textResult +=  "Specialist ID: " + str(row["specialist_id"]) + "     Office Worker ID: " + str(row["office_worker"]) + "\n"

      textResult += "\n"

      cursor.execute(sqlInfo5)
      results = cursor.fetchall()

      textResult += "Service Representative \n"

      for row in results:
          textResult +=  "Service Rep ID: " + str(row["service_rep_id"]) + "     Office Worker ID: " + str(row["office_worker"]) + "\n"

      textResult += "\n\n"

      return textResult
    return
  
def find_low_performers (years, errors):
    connection = connect()
    if connection:
      
      sql = """SELECT FIND_LOW_PERFORMERS(%s, %s)"""
      variable = (years, errors)
      cursor = connection.cursor()
      cursor.execute(sql, variable)
      connection.commit()
      results = cursor.fetchall()
      textResult = "Lowest Performers \n\n";
      key = "FIND_LOW_PERFORMERS(\'" + years + "\',\'" + errors + "\')"

      textResult +=  "Number of low performers: " + str(results[0]) + "\n"
      return textResult
      
    return
  
def find_highest_paying_members(amount):
    connection = connect()
    if connection:
      
      sql = """SELECT FIND_HIGH_PAYING_MEMBERS(%s)"""
      variable = amount
      cursor = connection.cursor()
      cursor.execute(sql, variable)
      connection.commit()
      results = cursor.fetchall()

      textResult = "Highest Paying Members \n\n";
      key = "FIND_HIGH_PAYING_MEMBERS(\'" + amount + "\')"

      textResult +=  "Number of high paying members: " + str(results[0][key]) + "\n"
      return textResult
    return
  
def discount_low_selling_products(percentDiscount):
    connection = connect()
    if connection:

      sqlInfo1 = """SELECT p.name, p.price
      FROM Product p;"""
      
      cursor = connection.cursor()
    
      cursor.execute(sqlInfo1)
      results = cursor.fetchall()

      textResult = "Before Applying Discount: \n\n"
      textResult += "Products \n"

      for row in results:
          textResult +=  "Product Name: " + str(row["name"]) + "     Price: " + str(row["price"]) + "\n"

      textResult += "\n\n"
      
      sql = """CALL DISCOUNT_LOW_SELLING_PRODUCTS(%s)"""
      variable = percentDiscount
      cursor = connection.cursor()
      cursor.execute(sql, variable)
      connection.commit()

      cursor.execute(sqlInfo1)
      results = cursor.fetchall()

      textResult += "After Applying Discount: \n\n"
      textResult += "Products \n"

      for row in results:
          textResult +=  "Product Name: " + str(row["name"]) + "     Price: " + str(row["price"]) + "\n"

      textResult += "\n\n"
      
      return textResult
    return
  
def give_raise_to_qareps (percentRaise, errors):
    connection = connect()
    if connection:

      sqlInfo1 = """SELECT ow.worker_id, ow.salary, qar.errors
      FROM OfficeWorker ow
      JOIN QualityAssuranceRep qar
      ON ow.worker_id = qar.office_worker;"""
      
      cursor = connection.cursor()
    
      cursor.execute(sqlInfo1)
      results = cursor.fetchall()

      textResult = "Before Giving Raise: \n\n"
      textResult += "QA Reps \n"

      for row in results:
          textResult +=  "ID: " + str(row["worker_id"]) + "     Salary: " + str(row["salary"]) + "     Errors: " + str(row["errors"]) + "\n"

      textResult += "\n\n"
      
      sql = """CALL GIVE_QAREPS_RAISE (%s, %s)"""
      variable = (percentRaise, errors)
      cursor = connection.cursor()
      cursor.execute(sql, variable)
      connection.commit()

      cursor.execute(sqlInfo1)
      results = cursor.fetchall()

      textResult += "After Giving Raise: \n\n"
      textResult += "QA Reps \n"

      for row in results:
          textResult +=  "ID: " + str(row["worker_id"]) + "     Salary: " + str(row["salary"]) + "     Errors: " + str(row["errors"]) + "\n"

      textResult += "\n\n"
      
      return textResult
    return
  
def returns_per_distribution_center():
     connection = connect()
     if connection:
       sql = """SELECT center_id, COUNT(*)
FROM
(SELECT dcw.distribution_center center_id
 FROM ProcessedOrder po, DistributionCenterWorker dcw, OrderReturn orr
 WHERE po.worker_id = dcw.worker_id
 AND po.order_id = orr.orderDetail
) returned_processed_orders
GROUP BY center_id;"""
       cursor = connection.cursor()
       cursor.execute(sql)
       connection.commit()
       results = cursor.fetchall()
       textResult = "Returns Per Distribution Center \n\n";

       for row in results:
         textResult +=  "Center ID: " + str(row["center_id"]) + "     Count: " + str(row["COUNT(*)"]) + "\n"
       return textResult
     return
  
def sales_per_product_category():
     connection = connect()
     if connection:
       sql = """SELECT pc.category_id, pc.category_name, pc.subcategory_name, SUM(sales.total) AS total_sales
FROM
(SELECT (oi.quantity * p.price) AS total, p.product_category FROM OrderItem oi
JOIN Product p
ON p.product_id = oi.product) sales, ProductCategory pc
WHERE pc.category_id = sales.product_category
GROUP BY pc.category_id;"""
       cursor = connection.cursor()
       cursor.execute(sql)
       connection.commit()
       results = cursor.fetchall()

       textResult = "Sales Per Product Category \n\n";

       for row in results:
         textResult +=  "Category ID: " + str(row["category_id"]) + "     Category: " + str(row["category_name"]) + "     Subcategory: " + str(row["subcategory_name"]) + "     Total Sales: " + str(row["total_sales"]) + "\n"
       return textResult
       
     return
