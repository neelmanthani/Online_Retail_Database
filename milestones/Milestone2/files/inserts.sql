-- Script name: inserts.sql
-- Author:      Neel Manthani
-- Purpose:     insert sample data to test the integrity of this database system
   
-- the database used to insert the data into.
USE OnlineRetailDB; 

-- -----------------------------------------------------
-- Data for table `OnlineRetailDB`.`User`
-- -----------------------------------------------------
START TRANSACTION;
USE `OnlineRetailDB`;
INSERT INTO `OnlineRetailDB`.`User` (`user_id`, `first_name`, `last_name`, `dob`, `registration_date`, `email`, `password`) VALUES (0, 'John', 'Smith', '1998-01-01', '2012-01-01', 'johnsmith@gmail.com', 'password');
INSERT INTO `OnlineRetailDB`.`User` (`user_id`, `first_name`, `last_name`, `dob`, `registration_date`, `email`, `password`) VALUES (1, 'Bryan', 'Jackson', '1970-07-29', '2016-04-05', 'bryanjackson@yahoo.com', 'password');
INSERT INTO `OnlineRetailDB`.`User` (`user_id`, `first_name`, `last_name`, `dob`, `registration_date`, `email`, `password`) VALUES (2, 'Aubrey', 'Graham', '2003-10-23', '2014-02-15', 'drizzydrake@hotmail.com', 'password');

COMMIT;


-- -----------------------------------------------------
-- Data for table `OnlineRetailDB`.`Vendor`
-- -----------------------------------------------------
START TRANSACTION;
USE `OnlineRetailDB`;
INSERT INTO `OnlineRetailDB`.`Vendor` (`vendor_id`, `name`, `contract_start`, `contract_end`) VALUES (0, 'Dyson', '2021-10-20', '2023-10-20');
INSERT INTO `OnlineRetailDB`.`Vendor` (`vendor_id`, `name`, `contract_start`, `contract_end`) VALUES (1, 'Bridgestone', '2003-01-02', '2025-01-01');
INSERT INTO `OnlineRetailDB`.`Vendor` (`vendor_id`, `name`, `contract_start`, `contract_end`) VALUES (2, 'Apple', '2013-05-02', '2026-02-07');

COMMIT;


-- -----------------------------------------------------
-- Data for table `OnlineRetailDB`.`ProductCategory`
-- -----------------------------------------------------
START TRANSACTION;
USE `OnlineRetailDB`;
INSERT INTO `OnlineRetailDB`.`ProductCategory` (`category_id`, `category_name`, `subcategory_name`) VALUES (0, 'Appliances', 'Vacuum');
INSERT INTO `OnlineRetailDB`.`ProductCategory` (`category_id`, `category_name`, `subcategory_name`) VALUES (1, 'Recreation', 'Wood');
INSERT INTO `OnlineRetailDB`.`ProductCategory` (`category_id`, `category_name`, `subcategory_name`) VALUES (2, 'Electronics', 'Powerbank');

COMMIT;


-- -----------------------------------------------------
-- Data for table `OnlineRetailDB`.`OfficeWorker`
-- -----------------------------------------------------
START TRANSACTION;
USE `OnlineRetailDB`;
INSERT INTO `OnlineRetailDB`.`OfficeWorker` (`worker_id`, `salary`, `date_hired`, `is_supervisor`) VALUES (0, 60000, '2005-10-15', true);
INSERT INTO `OnlineRetailDB`.`OfficeWorker` (`worker_id`, `salary`, `date_hired`, `is_supervisor`) VALUES (1, 80000, '2012-06-25', true);
INSERT INTO `OnlineRetailDB`.`OfficeWorker` (`worker_id`, `salary`, `date_hired`, `is_supervisor`) VALUES (2, 100000, '2019-08-28', true);

COMMIT;


-- -----------------------------------------------------
-- Data for table `OnlineRetailDB`.`QualityAssuranceRep`
-- -----------------------------------------------------
START TRANSACTION;
USE `OnlineRetailDB`;
INSERT INTO `OnlineRetailDB`.`QualityAssuranceRep` (`qa_rep_id`, `products_managed`, `errors`, `office_worker`) VALUES (0, 15, 1, 0);
INSERT INTO `OnlineRetailDB`.`QualityAssuranceRep` (`qa_rep_id`, `products_managed`, `errors`, `office_worker`) VALUES (1, 25, 3, 1);
INSERT INTO `OnlineRetailDB`.`QualityAssuranceRep` (`qa_rep_id`, `products_managed`, `errors`, `office_worker`) VALUES (2, 7, 0, 2);

COMMIT;


-- -----------------------------------------------------
-- Data for table `OnlineRetailDB`.`Supplier`
-- -----------------------------------------------------
START TRANSACTION;
USE `OnlineRetailDB`;
INSERT INTO `OnlineRetailDB`.`Supplier` (`supplier_id`, `name`, `contract_start`, `contract_end`) VALUES (0, 'Brimstone', '2014-02-07', '2025-01-01');
INSERT INTO `OnlineRetailDB`.`Supplier` (`supplier_id`, `name`, `contract_start`, `contract_end`) VALUES (1, 'Corduroy', '2018-08-05', '2025-01-01');
INSERT INTO `OnlineRetailDB`.`Supplier` (`supplier_id`, `name`, `contract_start`, `contract_end`) VALUES (2, 'Bloople', '2010-10-17', '2025-01-01');

COMMIT;


-- -----------------------------------------------------
-- Data for table `OnlineRetailDB`.`Product`
-- -----------------------------------------------------
START TRANSACTION;
USE `OnlineRetailDB`;
INSERT INTO `OnlineRetailDB`.`Product` (`product_id`, `name`, `description`, `stock`, `vendor`, `price`, `product_category`, `qa_rep`, `supplier`) VALUES (0, 'Vacuum Cleaner', 'Best vacuum in town', 10, 0, 48.97, 0, 0, NULL);
INSERT INTO `OnlineRetailDB`.`Product` (`product_id`, `name`, `description`, `stock`, `vendor`, `price`, `product_category`, `qa_rep`, `supplier`) VALUES (1, 'Wood Log', 'Highly flammable!', 5, 0, 15.00, 1, 1, 0);
INSERT INTO `OnlineRetailDB`.`Product` (`product_id`, `name`, `description`, `stock`, `vendor`, `price`, `product_category`, `qa_rep`, `supplier`) VALUES (2, 'Portable Charger', 'Long lasting charge!', 20, 2, 20.45, 2, 2, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `OnlineRetailDB`.`VendorExpense`
-- -----------------------------------------------------
START TRANSACTION;
USE `OnlineRetailDB`;
INSERT INTO `OnlineRetailDB`.`VendorExpense` (`vexpense_id`, `amount`, `description`, `date_paid`, `vendor`) VALUES (0, 2500, 'Contract cost', '2004-06-18', 0);
INSERT INTO `OnlineRetailDB`.`VendorExpense` (`vexpense_id`, `amount`, `description`, `date_paid`, `vendor`) VALUES (1, 1000, 'Materials', '2018-09-02', 1);
INSERT INTO `OnlineRetailDB`.`VendorExpense` (`vexpense_id`, `amount`, `description`, `date_paid`, `vendor`) VALUES (2, 30000, 'Court settlement', '2008-12-12', 2);

COMMIT;


-- -----------------------------------------------------
-- Data for table `OnlineRetailDB`.`SupplierExpense`
-- -----------------------------------------------------
START TRANSACTION;
USE `OnlineRetailDB`;
INSERT INTO `OnlineRetailDB`.`SupplierExpense` (`sexpense_id`, `amount`, `description`, `date_paid`, `supplier`) VALUES (0, 2600, 'materials', '2022-10-10', 0);
INSERT INTO `OnlineRetailDB`.`SupplierExpense` (`sexpense_id`, `amount`, `description`, `date_paid`, `supplier`) VALUES (1, 1700, 'wood and lumber', '2021-10-10', 1);
INSERT INTO `OnlineRetailDB`.`SupplierExpense` (`sexpense_id`, `amount`, `description`, `date_paid`, `supplier`) VALUES (2, 3400, 'copper wire', '2020-10-10', 2);

COMMIT;


-- -----------------------------------------------------
-- Data for table `OnlineRetailDB`.`ShoppingSession`
-- -----------------------------------------------------
START TRANSACTION;
USE `OnlineRetailDB`;
INSERT INTO `OnlineRetailDB`.`ShoppingSession` (`session_id`, `total`, `created_at`, `modified_at`, `user`) VALUES (0, 34.76, '2022-05-14T00:00:00+00:00', '2022-08-25T00:00:00+00:00', 0);
INSERT INTO `OnlineRetailDB`.`ShoppingSession` (`session_id`, `total`, `created_at`, `modified_at`, `user`) VALUES (1, 82.94, '2022-09-10T00:00:00+00:00', '2022-10-10T00:00:00+00:00', 1);
INSERT INTO `OnlineRetailDB`.`ShoppingSession` (`session_id`, `total`, `created_at`, `modified_at`, `user`) VALUES (2, 53.25, '2022-11-11T00:00:00+00:00', '2022-11-13T00:00:00+00:00', 2);

COMMIT;


-- -----------------------------------------------------
-- Data for table `OnlineRetailDB`.`CartItem`
-- -----------------------------------------------------
START TRANSACTION;
USE `OnlineRetailDB`;
INSERT INTO `OnlineRetailDB`.`CartItem` (`item_id`, `quantity`, `added_at`, `shopping_session`, `product`) VALUES (0, 23, '2022-10-11T00:00:00+00:00', 0, 0);
INSERT INTO `OnlineRetailDB`.`CartItem` (`item_id`, `quantity`, `added_at`, `shopping_session`, `product`) VALUES (1, 1, '2022-11-07T00:00:00+00:00', 1, 1);
INSERT INTO `OnlineRetailDB`.`CartItem` (`item_id`, `quantity`, `added_at`, `shopping_session`, `product`) VALUES (2, 7, '2022-12-16T00:00:00+00:00', 2, 2);

COMMIT;


-- -----------------------------------------------------
-- Data for table `OnlineRetailDB`.`Review`
-- -----------------------------------------------------
START TRANSACTION;
USE `OnlineRetailDB`;
INSERT INTO `OnlineRetailDB`.`Review` (`review_id`, `description`, `created_at`, `user`, `product`) VALUES (0, 'terrible', '2022-10-20', 0, 0);
INSERT INTO `OnlineRetailDB`.`Review` (`review_id`, `description`, `created_at`, `user`, `product`) VALUES (1, 'great', '2018-05-07', 1, 1);
INSERT INTO `OnlineRetailDB`.`Review` (`review_id`, `description`, `created_at`, `user`, `product`) VALUES (2, 'durable', '2019-07-09', 2, 2);

COMMIT;


-- -----------------------------------------------------
-- Data for table `OnlineRetailDB`.`DeliveryOption`
-- -----------------------------------------------------
START TRANSACTION;
USE `OnlineRetailDB`;
INSERT INTO `OnlineRetailDB`.`DeliveryOption` (`option_id`, `description`, `nonmember_price`, `member_price`) VALUES (0, '2-day', 12.99, 5.99);
INSERT INTO `OnlineRetailDB`.`DeliveryOption` (`option_id`, `description`, `nonmember_price`, `member_price`) VALUES (1, '1-week', 5.99, 2.99);
INSERT INTO `OnlineRetailDB`.`DeliveryOption` (`option_id`, `description`, `nonmember_price`, `member_price`) VALUES (2, '2-weeks', 2.99, 0);

COMMIT;


-- -----------------------------------------------------
-- Data for table `OnlineRetailDB`.`DistributionCenter`
-- -----------------------------------------------------
START TRANSACTION;
USE `OnlineRetailDB`;
INSERT INTO `OnlineRetailDB`.`DistributionCenter` (`center_id`, `total_packages_processed`, `address`) VALUES (0, 2500, '1800 Corduroy Ln, Santa Clara, 95051');
INSERT INTO `OnlineRetailDB`.`DistributionCenter` (`center_id`, `total_packages_processed`, `address`) VALUES (1, 30000, '1700 Xavier St, Sunnyvale, 95050');
INSERT INTO `OnlineRetailDB`.`DistributionCenter` (`center_id`, `total_packages_processed`, `address`) VALUES (2, 2234, '2300 Wilshire Blvd, Los Angeles, 90210');

COMMIT;


-- -----------------------------------------------------
-- Data for table `OnlineRetailDB`.`CourierService`
-- -----------------------------------------------------
START TRANSACTION;
USE `OnlineRetailDB`;
INSERT INTO `OnlineRetailDB`.`CourierService` (`courier_id`, `company_name`, `contract_start`, `contract_end`) VALUES (0, 'FastMail', '2015-05-05', '2023-05-05');
INSERT INTO `OnlineRetailDB`.`CourierService` (`courier_id`, `company_name`, `contract_start`, `contract_end`) VALUES (1, 'FedEx', '2020-07-07', '2023-07-07');
INSERT INTO `OnlineRetailDB`.`CourierService` (`courier_id`, `company_name`, `contract_start`, `contract_end`) VALUES (2, 'UPS', '2022-09-09', '2023-09-09');

COMMIT;


-- -----------------------------------------------------
-- Data for table `OnlineRetailDB`.`PackagingService`
-- -----------------------------------------------------
START TRANSACTION;
USE `OnlineRetailDB`;
INSERT INTO `OnlineRetailDB`.`PackagingService` (`packaging_id`, `company_name`, `contract_start`, `contract_end`) VALUES (0, 'BigPackage', '2013-02-02', '2024-04-04');
INSERT INTO `OnlineRetailDB`.`PackagingService` (`packaging_id`, `company_name`, `contract_start`, `contract_end`) VALUES (1, 'PackItUp', '2014-03-03', '2026-06-06');
INSERT INTO `OnlineRetailDB`.`PackagingService` (`packaging_id`, `company_name`, `contract_start`, `contract_end`) VALUES (2, 'BoxWorld', '2016-04-04', '2028-08-08');

COMMIT;


-- -----------------------------------------------------
-- Data for table `OnlineRetailDB`.`PaymentInformation`
-- -----------------------------------------------------
START TRANSACTION;
USE `OnlineRetailDB`;
INSERT INTO `OnlineRetailDB`.`PaymentInformation` (`payment_id`, `card_number`, `cvv`, `expiration`) VALUES (0, '1111222233334444', 111, '2025-01-01');
INSERT INTO `OnlineRetailDB`.`PaymentInformation` (`payment_id`, `card_number`, `cvv`, `expiration`) VALUES (1, '9999888877776666', 222, '2026-07-01');
INSERT INTO `OnlineRetailDB`.`PaymentInformation` (`payment_id`, `card_number`, `cvv`, `expiration`) VALUES (2, '5555444466667777', 333, '2030-08-01');

COMMIT;


-- -----------------------------------------------------
-- Data for table `OnlineRetailDB`.`OrderDetail`
-- -----------------------------------------------------
START TRANSACTION;
USE `OnlineRetailDB`;
INSERT INTO `OnlineRetailDB`.`OrderDetail` (`order_id`, `total`, `created_at`, `user`, `delivery_option`, `distribution_center`, `courier_service`, `packaging_service`, `payment_information`) VALUES (0, 20.56, '2021-10-15T00:00:00+00:00', 0, 0, 0, 0, 0, 0);
INSERT INTO `OnlineRetailDB`.`OrderDetail` (`order_id`, `total`, `created_at`, `user`, `delivery_option`, `distribution_center`, `courier_service`, `packaging_service`, `payment_information`) VALUES (1, 100.5, '2020-08-17T00:00:00+00:00', 1, 1, 1, 1, 1, 1);
INSERT INTO `OnlineRetailDB`.`OrderDetail` (`order_id`, `total`, `created_at`, `user`, `delivery_option`, `distribution_center`, `courier_service`, `packaging_service`, `payment_information`) VALUES (2, 90.77, '2019-09-13T00:00:00+00:00', 2, 2, 2, 2, 2, 2);

COMMIT;


-- -----------------------------------------------------
-- Data for table `OnlineRetailDB`.`OrderItem`
-- -----------------------------------------------------
START TRANSACTION;
USE `OnlineRetailDB`;
INSERT INTO `OnlineRetailDB`.`OrderItem` (`item_order_id`, `quantity`, `created_at`, `orderDetail`, `product`) VALUES (0, 6, '2022-10-22T00:00:00+00:00', 0, 0);
INSERT INTO `OnlineRetailDB`.`OrderItem` (`item_order_id`, `quantity`, `created_at`, `orderDetail`, `product`) VALUES (1, 4, '2022-10-21T00:00:00+00:00', 1, 1);
INSERT INTO `OnlineRetailDB`.`OrderItem` (`item_order_id`, `quantity`, `created_at`, `orderDetail`, `product`) VALUES (2, 7, '2022-10-20T00:00:00+00:00', 2, 2);

COMMIT;


-- -----------------------------------------------------
-- Data for table `OnlineRetailDB`.`UserPaymentMethod`
-- -----------------------------------------------------
START TRANSACTION;
USE `OnlineRetailDB`;
INSERT INTO `OnlineRetailDB`.`UserPaymentMethod` (`user_payment_id`, `user`, `payment_information`) VALUES (0, 0, 0);
INSERT INTO `OnlineRetailDB`.`UserPaymentMethod` (`user_payment_id`, `user`, `payment_information`) VALUES (1, 1, 1);
INSERT INTO `OnlineRetailDB`.`UserPaymentMethod` (`user_payment_id`, `user`, `payment_information`) VALUES (2, 2, 2);

COMMIT;


-- -----------------------------------------------------
-- Data for table `OnlineRetailDB`.`ReturnReason`
-- -----------------------------------------------------
START TRANSACTION;
USE `OnlineRetailDB`;
INSERT INTO `OnlineRetailDB`.`ReturnReason` (`reason_id`, `description`, `subcategories`) VALUES (0, 'damaged', 'packaging damaged');
INSERT INTO `OnlineRetailDB`.`ReturnReason` (`reason_id`, `description`, `subcategories`) VALUES (1, 'damaged', 'product damaged');
INSERT INTO `OnlineRetailDB`.`ReturnReason` (`reason_id`, `description`, `subcategories`) VALUES (2, 'false advertising', 'product didn\'t meet listed specs');

COMMIT;


-- -----------------------------------------------------
-- Data for table `OnlineRetailDB`.`CustomerServiceRep`
-- -----------------------------------------------------
START TRANSACTION;
USE `OnlineRetailDB`;
INSERT INTO `OnlineRetailDB`.`CustomerServiceRep` (`service_rep_id`, `returns_handled`, `errors`, `office_worker`) VALUES (0, 245, 1, 0);
INSERT INTO `OnlineRetailDB`.`CustomerServiceRep` (`service_rep_id`, `returns_handled`, `errors`, `office_worker`) VALUES (1, 3000, 300, 1);
INSERT INTO `OnlineRetailDB`.`CustomerServiceRep` (`service_rep_id`, `returns_handled`, `errors`, `office_worker`) VALUES (2, 50, 1, 2);

COMMIT;


-- -----------------------------------------------------
-- Data for table `OnlineRetailDB`.`Return`
-- -----------------------------------------------------
START TRANSACTION;
USE `OnlineRetailDB`;
INSERT INTO `OnlineRetailDB`.`Return` (`return_id`, `description`, `created_at`, `reason`, `cust_service_rep`, `user`, `orderDetail`) VALUES (0, 'low quality', '2022-10-14', 0, 0, 0, 0);
INSERT INTO `OnlineRetailDB`.`Return` (`return_id`, `description`, `created_at`, `reason`, `cust_service_rep`, `user`, `orderDetail`) VALUES (1, 'not what I expected', '2022-03-21', 1, 1, 1, 1);
INSERT INTO `OnlineRetailDB`.`Return` (`return_id`, `description`, `created_at`, `reason`, `cust_service_rep`, `user`, `orderDetail`) VALUES (2, 'broke very quickly', '2021-04-29', 2, 2, 2, 2);

COMMIT;


-- -----------------------------------------------------
-- Data for table `OnlineRetailDB`.`DistributionCenterWorker`
-- -----------------------------------------------------
START TRANSACTION;
USE `OnlineRetailDB`;
INSERT INTO `OnlineRetailDB`.`DistributionCenterWorker` (`worker_id`, `packages_processed`, `errors`, `salary`, `distribution_center`) VALUES (0, 249, 1, 30000, 0);
INSERT INTO `OnlineRetailDB`.`DistributionCenterWorker` (`worker_id`, `packages_processed`, `errors`, `salary`, `distribution_center`) VALUES (1, 1580, 0, 35000, 1);
INSERT INTO `OnlineRetailDB`.`DistributionCenterWorker` (`worker_id`, `packages_processed`, `errors`, `salary`, `distribution_center`) VALUES (2, 276, 25, 37000, 2);

COMMIT;


-- -----------------------------------------------------
-- Data for table `OnlineRetailDB`.`CourierExpense`
-- -----------------------------------------------------
START TRANSACTION;
USE `OnlineRetailDB`;
INSERT INTO `OnlineRetailDB`.`CourierExpense` (`cexpense_id`, `amount`, `description`, `paid_on`, `courier_service`) VALUES (0, 2000, 'monthly payment', '2019-05-07', 0);
INSERT INTO `OnlineRetailDB`.`CourierExpense` (`cexpense_id`, `amount`, `description`, `paid_on`, `courier_service`) VALUES (1, 4000, 'contract renewal', '2021-07-09', 1);
INSERT INTO `OnlineRetailDB`.`CourierExpense` (`cexpense_id`, `amount`, `description`, `paid_on`, `courier_service`) VALUES (2, 6000, 'annual payment', '2022-09-12', 2);

COMMIT;


-- -----------------------------------------------------
-- Data for table `OnlineRetailDB`.`PackagingExpense`
-- -----------------------------------------------------
START TRANSACTION;
USE `OnlineRetailDB`;
INSERT INTO `OnlineRetailDB`.`PackagingExpense` (`cexpense_id`, `amount`, `description`, `paid_on`, `packaging_service`) VALUES (0, 1500, 'Packaging Tape', '2022-10-10', 0);
INSERT INTO `OnlineRetailDB`.`PackagingExpense` (`cexpense_id`, `amount`, `description`, `paid_on`, `packaging_service`) VALUES (1, 7430, 'Bubblewrap', '2014-10-14', 1);
INSERT INTO `OnlineRetailDB`.`PackagingExpense` (`cexpense_id`, `amount`, `description`, `paid_on`, `packaging_service`) VALUES (2, 90000, 'Cardboard packaging', '2023-10-09', 2);

COMMIT;


-- -----------------------------------------------------
-- Data for table `OnlineRetailDB`.`Address`
-- -----------------------------------------------------
START TRANSACTION;
USE `OnlineRetailDB`;
INSERT INTO `OnlineRetailDB`.`Address` (`address_id`, `street`, `zipcode`, `city`, `state`) VALUES (0, '2323 El Camino Rd', 95042, 'Adustro', 'California');
INSERT INTO `OnlineRetailDB`.`Address` (`address_id`, `street`, `zipcode`, `city`, `state`) VALUES (1, '1400 Border Ln', 15853, 'Corpal', 'Alaska');
INSERT INTO `OnlineRetailDB`.`Address` (`address_id`, `street`, `zipcode`, `city`, `state`) VALUES (2, '1594 Signal Blvd', 25058, 'Lakeshore', 'Utah');

COMMIT;


-- -----------------------------------------------------
-- Data for table `OnlineRetailDB`.`UserAddress`
-- -----------------------------------------------------
START TRANSACTION;
USE `OnlineRetailDB`;
INSERT INTO `OnlineRetailDB`.`UserAddress` (`u_address_id`, `user`, `address`) VALUES (0, 0, 0);
INSERT INTO `OnlineRetailDB`.`UserAddress` (`u_address_id`, `user`, `address`) VALUES (1, 1, 1);
INSERT INTO `OnlineRetailDB`.`UserAddress` (`u_address_id`, `user`, `address`) VALUES (2, 2, 2);

COMMIT;


-- -----------------------------------------------------
-- Data for table `OnlineRetailDB`.`Alert`
-- -----------------------------------------------------
START TRANSACTION;
USE `OnlineRetailDB`;
INSERT INTO `OnlineRetailDB`.`Alert` (`alert_id`, `subject`, `description`, `created_at`, `expires_at`) VALUES (0, 'Big Fall Sales', 'This fall theres going to be a lot of things on the market. Don\'t miss out!', '2020-10-14', '2023-01-01');
INSERT INTO `OnlineRetailDB`.`Alert` (`alert_id`, `subject`, `description`, `created_at`, `expires_at`) VALUES (1, 'Big Summer Sales!', 'This summer theres going to be a lot of things on the market. Don\'t miss out!', '2021-10-13', '2023-02-02');
INSERT INTO `OnlineRetailDB`.`Alert` (`alert_id`, `subject`, `description`, `created_at`, `expires_at`) VALUES (2, 'Big Winter Sales!', 'This winter theres going to be a lot of things on the market. Don\'t miss out!', '2022-10-15', '2023-03-03');

COMMIT;


-- -----------------------------------------------------
-- Data for table `OnlineRetailDB`.`TargetedAlert`
-- -----------------------------------------------------
START TRANSACTION;
USE `OnlineRetailDB`;
INSERT INTO `OnlineRetailDB`.`TargetedAlert` (`t_alert_id`, `user`, `alert`) VALUES (0, 0, 0);
INSERT INTO `OnlineRetailDB`.`TargetedAlert` (`t_alert_id`, `user`, `alert`) VALUES (1, 1, 1);
INSERT INTO `OnlineRetailDB`.`TargetedAlert` (`t_alert_id`, `user`, `alert`) VALUES (2, 2, 2);

COMMIT;


-- -----------------------------------------------------
-- Data for table `OnlineRetailDB`.`Membership`
-- -----------------------------------------------------
START TRANSACTION;
USE `OnlineRetailDB`;
INSERT INTO `OnlineRetailDB`.`Membership` (`membership_id`, `start_date`, `expiry_date`, `user`) VALUES (0, '2021-10-13', '2023-11-24', 0);
INSERT INTO `OnlineRetailDB`.`Membership` (`membership_id`, `start_date`, `expiry_date`, `user`) VALUES (1, '2020-09-18', '2024-10-24', 1);
INSERT INTO `OnlineRetailDB`.`Membership` (`membership_id`, `start_date`, `expiry_date`, `user`) VALUES (2, '2022-11-14', '2025-09-24', 2);

COMMIT;


-- -----------------------------------------------------
-- Data for table `OnlineRetailDB`.`PPCManager`
-- -----------------------------------------------------
START TRANSACTION;
USE `OnlineRetailDB`;
INSERT INTO `OnlineRetailDB`.`PPCManager` (`manager_id`, `channels_handled`, `total_clicks`, `office_worker`) VALUES (0, 1, 500, 0);
INSERT INTO `OnlineRetailDB`.`PPCManager` (`manager_id`, `channels_handled`, `total_clicks`, `office_worker`) VALUES (1, 1, 2500, 1);
INSERT INTO `OnlineRetailDB`.`PPCManager` (`manager_id`, `channels_handled`, `total_clicks`, `office_worker`) VALUES (2, 1, 5060, 2);

COMMIT;


-- -----------------------------------------------------
-- Data for table `OnlineRetailDB`.`AdvertisingChannel`
-- -----------------------------------------------------
START TRANSACTION;
USE `OnlineRetailDB`;
INSERT INTO `OnlineRetailDB`.`AdvertisingChannel` (`channel_id`, `channel_name`, `cost`, `clicks`, `contract_start`, `contract_end`, `manager`) VALUES (0, 'Facebook', 20000, 1500, '2019-10-24', '2023-01-01', 0);
INSERT INTO `OnlineRetailDB`.`AdvertisingChannel` (`channel_id`, `channel_name`, `cost`, `clicks`, `contract_start`, `contract_end`, `manager`) VALUES (1, 'Instagram', 50000, 700, '2020-12-14', '2024-01-01', 1);
INSERT INTO `OnlineRetailDB`.`AdvertisingChannel` (`channel_id`, `channel_name`, `cost`, `clicks`, `contract_start`, `contract_end`, `manager`) VALUES (2, 'Google', 80000, 9000, '2018-07-10', '2025-01-01', 2);

COMMIT;


-- -----------------------------------------------------
-- Data for table `OnlineRetailDB`.`marketingSpecialist`
-- -----------------------------------------------------
START TRANSACTION;
USE `OnlineRetailDB`;
INSERT INTO `OnlineRetailDB`.`marketingSpecialist` (`specialist_id`, `partnerships_handled`, `total_cost`, `office_worker`) VALUES (0, 1, 29456, 0);
INSERT INTO `OnlineRetailDB`.`marketingSpecialist` (`specialist_id`, `partnerships_handled`, `total_cost`, `office_worker`) VALUES (1, 2, 19259, 1);
INSERT INTO `OnlineRetailDB`.`marketingSpecialist` (`specialist_id`, `partnerships_handled`, `total_cost`, `office_worker`) VALUES (2, 1, 24844, 2);

COMMIT;


-- -----------------------------------------------------
-- Data for table `OnlineRetailDB`.`BrandPartnership`
-- -----------------------------------------------------
START TRANSACTION;
USE `OnlineRetailDB`;
INSERT INTO `OnlineRetailDB`.`BrandPartnership` (`partnership_id`, `company_name`, `contract_start`, `contract_end`, `specialist`) VALUES (0, 'GreatBread', '2018-07-07', '2023-07-07', 0);
INSERT INTO `OnlineRetailDB`.`BrandPartnership` (`partnership_id`, `company_name`, `contract_start`, `contract_end`, `specialist`) VALUES (1, 'HopefulGiant', '2019-08-08', '2023-08-08', 1);
INSERT INTO `OnlineRetailDB`.`BrandPartnership` (`partnership_id`, `company_name`, `contract_start`, `contract_end`, `specialist`) VALUES (2, 'Gerber', '2020-09-09', '2023-09-09', 2);

COMMIT;


-- -----------------------------------------------------
-- Data for table `OnlineRetailDB`.`Expense`
-- -----------------------------------------------------
START TRANSACTION;
USE `OnlineRetailDB`;
INSERT INTO `OnlineRetailDB`.`Expense` (`expense_id`, `category`, `amount`) VALUES (0, 'Packaging', 12345);
INSERT INTO `OnlineRetailDB`.`Expense` (`expense_id`, `category`, `amount`) VALUES (1, 'Courier', 2495);
INSERT INTO `OnlineRetailDB`.`Expense` (`expense_id`, `category`, `amount`) VALUES (2, 'Supplier', 30000);

COMMIT;


-- -----------------------------------------------------
-- Data for table `OnlineRetailDB`.`ExpenseIncurred`
-- -----------------------------------------------------
START TRANSACTION;
USE `OnlineRetailDB`;
INSERT INTO `OnlineRetailDB`.`ExpenseIncurred` (`expense_incurred_id`, `vexpense`, `sexpense`, `cexpense`, `pexpense`) VALUES (0, NULL, NULL, NULL, 0);
INSERT INTO `OnlineRetailDB`.`ExpenseIncurred` (`expense_incurred_id`, `vexpense`, `sexpense`, `cexpense`, `pexpense`) VALUES (1, NULL, NULL, 2, NULL);
INSERT INTO `OnlineRetailDB`.`ExpenseIncurred` (`expense_incurred_id`, `vexpense`, `sexpense`, `cexpense`, `pexpense`) VALUES (2, NULL, 1, NULL, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `OnlineRetailDB`.`ProcessedOrders`
-- -----------------------------------------------------
START TRANSACTION;
USE `OnlineRetailDB`;
INSERT INTO `OnlineRetailDB`.`ProcessedOrders` (`p_order_id`, `worker_id`, `order_id`, `date_processed`) VALUES (0, 0, 0, '2020-10-10');
INSERT INTO `OnlineRetailDB`.`ProcessedOrders` (`p_order_id`, `worker_id`, `order_id`, `date_processed`) VALUES (1, 1, 1, '2019-07-07');
INSERT INTO `OnlineRetailDB`.`ProcessedOrders` (`p_order_id`, `worker_id`, `order_id`, `date_processed`) VALUES (2, 2, 2, '2019-05-05');

COMMIT;


-- -----------------------------------------------------
-- Data for table `OnlineRetailDB`.`ProductReturns`
-- -----------------------------------------------------
START TRANSACTION;
USE `OnlineRetailDB`;
INSERT INTO `OnlineRetailDB`.`ProductReturns` (`product_return_id`, `product`, `return`) VALUES (0, 0, 0);
INSERT INTO `OnlineRetailDB`.`ProductReturns` (`product_return_id`, `product`, `return`) VALUES (1, 1, 1);
INSERT INTO `OnlineRetailDB`.`ProductReturns` (`product_return_id`, `product`, `return`) VALUES (2, 2, 2);

COMMIT;

