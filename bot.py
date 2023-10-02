import bot_commands
import database as db

def response(msg):
  response_data = None #Null
  msg_data = msg.split()
  bot_command = msg_data[0]
  arguments = msg_data[1:]

  if bot_command in bot_commands.TEST_COMMAND:
      if len(arguments) == 0: 
           response_data = test_command()
           return response_data
      else:
        return "don't add arguments"
  elif bot_command in bot_commands.PRODUCT_REVIEWS_BY_SCORE:
      if len(arguments) == 1:
           product_id = arguments[0]
           response_data = db.product_reviews_by_score(product_id)
           return response_data
      else:
        return "invalid number of args"
  elif bot_command in bot_commands.USERS_BY_AGE_GROUP:
      if len(arguments) == 0:
           response_data = db.users_by_age_group()
           return response_data
      else:
        return "invalid number of args"
  elif bot_command in bot_commands.ORDERS_BY_DELIVERY_OPTION:
      if len(arguments) == 0:
           response_data = db.orders_by_delivery_option()
           return response_data
      else:
        return "invalid number of args"
  elif bot_command in bot_commands.COUNT_ADDRESSES_BY_STATE:
      if len(arguments) == 1:
           min_users = arguments[0]
           response_data = db.count_addresses_by_state(min_users)
           return response_data
      else:
        return "invalid number of args"
  elif bot_command in bot_commands.CHECK_OUT_SHOPPING_CART:
      if len(arguments) == 1:
           cart_id = arguments[0]
           response_data = db.check_out_shopping_cart(cart_id)
           return response_data
      else:
        return "invalid number of args"
  elif bot_command in bot_commands.FIND_PRODUCTS:
      if len(arguments) == 2:
           category = arguments[0]
           amount = arguments[1]
           response_data = db.find_products(category, amount)
           return response_data
      else:
        return "invalid number of args"
  elif bot_command in bot_commands.UPDATE_EXPENSES:
      if len(arguments) == 0:
           response_data = db.update_expenses()
           return response_data
      else:
        return "invalid number of args"
  elif bot_command in bot_commands.DELETE_SHOPPING_CART_ITEMS:
      if len(arguments) == 1:
           cart_id = arguments[0]
           response_data = db.delete_shopping_cart_items(cart_id)
           return response_data
      else:
        return "invalid number of args"
  elif bot_command in bot_commands.DELETE_SPECIALIZED_WORKERS:
      if len(arguments) == 1:
           worker_id = arguments[0]
           response_data = db.delete_specialized_workers(worker_id)
           return response_data
      else:
        return "invalid number of args"
  elif bot_command in bot_commands.FIND_LOW_PERFORMERS:
      if len(arguments) == 2:
           years = arguments[0]
           errors = arguments[1]
           response_data = db.find_low_performers(years, errors)
           return response_data
      else:
        return "invalid number of args"
  elif bot_command in bot_commands.FIND_HIGHEST_PAYING_MEMBERS:
      if len(arguments) == 1:
           amount = arguments[0]
           response_data = db.find_highest_paying_members(amount)
           return response_data
      else:
        return "invalid number of args"
  elif bot_command in bot_commands.DISCOUNT_LOW_SELLING_PRODUCTS:
      if len(arguments) == 1:
           percentDiscount = arguments[0]
           response_data = db.discount_low_selling_products(percentDiscount)
           return response_data
      else:
        return "invalid number of args"
  elif bot_command in bot_commands.GIVE_RAISE_TO_QAREPS:
      if len(arguments) == 2:
           percentRaise = arguments[0]
           errors = arguments[1]
           response_data = db.give_raise_to_qareps(percentRaise, errors)
           return response_data
      else:
        return "invalid number of args"
  elif bot_command in bot_commands.RETURNS_PER_DISTRIBUTION_CENTER:
      if len(arguments) == 0:
           response_data = db.returns_per_distribution_center()
           return response_data
      else:
        return "invalid number of args"
  elif bot_command in bot_commands.SALES_PER_PRODUCT_CATEGORY:
      if len(arguments) == 0:
           response_data = db.sales_per_product_category()
           return response_data
      else:
        return "invalid number of args"
  elif bot_command in bot_commands.UPDATE_ORDERDETAIL_TOTAL:
      if len(arguments) == 3:
           orderDetail = arguments[0]
           product = arguments[1]
           quantity = arguments[2]
           response_data = db.update_order_detail_total(orderDetail, product, quantity)
           return response_data
      else:
        return "invalid number of args"

def test_command():
  results = db.test_query()
  return db.test_query()
