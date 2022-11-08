-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema OnlineRetailDB
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `OnlineRetailDB` ;

-- -----------------------------------------------------
-- Schema OnlineRetailDB
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `OnlineRetailDB` DEFAULT CHARACTER SET utf8 ;
USE `OnlineRetailDB` ;

-- -----------------------------------------------------
-- Table `OnlineRetailDB`.`User`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OnlineRetailDB`.`User` ;

CREATE TABLE IF NOT EXISTS `OnlineRetailDB`.`User` (
  `user_id` INT UNSIGNED ZEROFILL NOT NULL,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `dob` DATETIME NOT NULL,
  `registration_date` DATETIME NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`user_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OnlineRetailDB`.`Vendor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OnlineRetailDB`.`Vendor` ;

CREATE TABLE IF NOT EXISTS `OnlineRetailDB`.`Vendor` (
  `vendor_id` INT ZEROFILL UNSIGNED NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `contract_start` DATETIME NULL,
  `contract_end` DATETIME NULL,
  PRIMARY KEY (`vendor_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OnlineRetailDB`.`ProductCategory`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OnlineRetailDB`.`ProductCategory` ;

CREATE TABLE IF NOT EXISTS `OnlineRetailDB`.`ProductCategory` (
  `category_id` INT UNSIGNED ZEROFILL NOT NULL,
  `category_name` VARCHAR(45) NOT NULL,
  `subcategory_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`category_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OnlineRetailDB`.`OfficeWorker`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OnlineRetailDB`.`OfficeWorker` ;

CREATE TABLE IF NOT EXISTS `OnlineRetailDB`.`OfficeWorker` (
  `worker_id` INT UNSIGNED ZEROFILL NOT NULL,
  `salary` DECIMAL(10,2) UNSIGNED NOT NULL,
  `date_hired` DATETIME NOT NULL,
  `is_supervisor` TINYINT NOT NULL,
  PRIMARY KEY (`worker_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OnlineRetailDB`.`QualityAssuranceRep`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OnlineRetailDB`.`QualityAssuranceRep` ;

CREATE TABLE IF NOT EXISTS `OnlineRetailDB`.`QualityAssuranceRep` (
  `qa_rep_id` INT UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT,
  `products_managed` INT UNSIGNED NOT NULL,
  `errors` INT UNSIGNED NOT NULL,
  `office_worker` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`qa_rep_id`, `office_worker`),
  INDEX `FK_QAREP_OFFICEWORKER_idx` (`office_worker` ASC) VISIBLE,
  CONSTRAINT `FK_QAREP_OFFICEWORKER`
    FOREIGN KEY (`office_worker`)
    REFERENCES `OnlineRetailDB`.`OfficeWorker` (`worker_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OnlineRetailDB`.`Supplier`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OnlineRetailDB`.`Supplier` ;

CREATE TABLE IF NOT EXISTS `OnlineRetailDB`.`Supplier` (
  `supplier_id` INT UNSIGNED ZEROFILL NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `contract_start` DATETIME NULL,
  `contract_end` DATETIME NULL,
  PRIMARY KEY (`supplier_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OnlineRetailDB`.`Product`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OnlineRetailDB`.`Product` ;

CREATE TABLE IF NOT EXISTS `OnlineRetailDB`.`Product` (
  `product_id` INT UNSIGNED ZEROFILL NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `description` VARCHAR(255) NOT NULL,
  `stock` INT UNSIGNED NOT NULL,
  `vendor` INT ZEROFILL UNSIGNED NULL,
  `price` DECIMAL(10,2) UNSIGNED NOT NULL,
  `product_category` INT UNSIGNED NULL,
  `qa_rep` INT UNSIGNED NULL,
  `supplier` INT UNSIGNED NULL,
  PRIMARY KEY (`product_id`),
  INDEX `FK_PRODUCT_VENDOR_idx` (`vendor` ASC) VISIBLE,
  INDEX `FK_PRODUCT_CATEGORY_idx` (`product_category` ASC) VISIBLE,
  INDEX `FK_PRODUCT_SUPPLIER_idx` (`supplier` ASC) VISIBLE,
  INDEX `FK_PRODUCT_QAREP_idx` (`qa_rep` ASC) VISIBLE,
  CONSTRAINT `FK_PRODUCT_VENDOR`
    FOREIGN KEY (`vendor`)
    REFERENCES `OnlineRetailDB`.`Vendor` (`vendor_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `FK_PRODUCT_CATEGORY`
    FOREIGN KEY (`product_category`)
    REFERENCES `OnlineRetailDB`.`ProductCategory` (`category_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `FK_PRODUCT_QAREP`
    FOREIGN KEY (`qa_rep`)
    REFERENCES `OnlineRetailDB`.`QualityAssuranceRep` (`qa_rep_id`)
    ON DELETE NO ACTION
    ON UPDATE SET NULL,
  CONSTRAINT `FK_PRODUCT_SUPPLIER`
    FOREIGN KEY (`supplier`)
    REFERENCES `OnlineRetailDB`.`Supplier` (`supplier_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OnlineRetailDB`.`VendorExpense`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OnlineRetailDB`.`VendorExpense` ;

CREATE TABLE IF NOT EXISTS `OnlineRetailDB`.`VendorExpense` (
  `vexpense_id` INT UNSIGNED ZEROFILL NOT NULL,
  `amount` INT UNSIGNED NOT NULL,
  `description` VARCHAR(100) NOT NULL,
  `date_paid` DATETIME NOT NULL,
  `vendor` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`vexpense_id`),
  INDEX `FK_VENDOREXPENSE_VENDOR_idx` (`vendor` ASC) VISIBLE,
  CONSTRAINT `FK_VENDOREXPENSE_VENDOR`
    FOREIGN KEY (`vendor`)
    REFERENCES `OnlineRetailDB`.`Vendor` (`vendor_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OnlineRetailDB`.`SupplierExpense`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OnlineRetailDB`.`SupplierExpense` ;

CREATE TABLE IF NOT EXISTS `OnlineRetailDB`.`SupplierExpense` (
  `sexpense_id` INT UNSIGNED ZEROFILL NOT NULL,
  `amount` INT UNSIGNED NOT NULL,
  `description` VARCHAR(100) NOT NULL,
  `date_paid` DATETIME NOT NULL,
  `supplier` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`sexpense_id`),
  INDEX `FK_VENDOREXPENSE_VENDOR0_idx` (`supplier` ASC) VISIBLE,
  CONSTRAINT `FK_VENDOREXPENSE_VENDOR0`
    FOREIGN KEY (`supplier`)
    REFERENCES `OnlineRetailDB`.`Supplier` (`supplier_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OnlineRetailDB`.`ShoppingSession`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OnlineRetailDB`.`ShoppingSession` ;

CREATE TABLE IF NOT EXISTS `OnlineRetailDB`.`ShoppingSession` (
  `session_id` INT UNSIGNED ZEROFILL NOT NULL,
  `total` INT UNSIGNED NOT NULL,
  `created_at` DATETIME NOT NULL,
  `modified_at` DATETIME NOT NULL,
  `user` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`session_id`),
  INDEX `FK_SHOPPINGSESSION_USER_idx` (`user` ASC) VISIBLE,
  CONSTRAINT `FK_SHOPPINGSESSION_USER`
    FOREIGN KEY (`user`)
    REFERENCES `OnlineRetailDB`.`User` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OnlineRetailDB`.`CartItem`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OnlineRetailDB`.`CartItem` ;

CREATE TABLE IF NOT EXISTS `OnlineRetailDB`.`CartItem` (
  `item_id` INT UNSIGNED ZEROFILL NOT NULL,
  `quantity` INT UNSIGNED NOT NULL,
  `added_at` DATETIME NOT NULL,
  `shopping_session` INT UNSIGNED NOT NULL,
  `product` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`item_id`),
  INDEX `FK_CARTITEM_SHOPPINGSESSION_idx` (`shopping_session` ASC) VISIBLE,
  INDEX `FK_CARTITEM_PRODUCT_idx` (`product` ASC) VISIBLE,
  CONSTRAINT `FK_CARTITEM_SHOPPINGSESSION`
    FOREIGN KEY (`shopping_session`)
    REFERENCES `OnlineRetailDB`.`ShoppingSession` (`session_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `FK_CARTITEM_PRODUCT`
    FOREIGN KEY (`product`)
    REFERENCES `OnlineRetailDB`.`Product` (`product_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OnlineRetailDB`.`Review`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OnlineRetailDB`.`Review` ;

CREATE TABLE IF NOT EXISTS `OnlineRetailDB`.`Review` (
  `review_id` INT UNSIGNED ZEROFILL NOT NULL,
  `description` VARCHAR(255) NOT NULL,
  `created_at` DATETIME NOT NULL,
  `user` INT UNSIGNED ZEROFILL NOT NULL,
  `product` INT UNSIGNED ZEROFILL NOT NULL,
  PRIMARY KEY (`review_id`),
  INDEX `FK_REVIEW_PRODUCT_idx` (`product` ASC) VISIBLE,
  INDEX `FK_REVIEW_USER_idx` (`user` ASC) VISIBLE,
  CONSTRAINT `FK_REVIEW_USER`
    FOREIGN KEY (`user`)
    REFERENCES `OnlineRetailDB`.`User` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `FK_REVIEW_PRODUCT`
    FOREIGN KEY (`product`)
    REFERENCES `OnlineRetailDB`.`Product` (`product_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OnlineRetailDB`.`DeliveryOption`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OnlineRetailDB`.`DeliveryOption` ;

CREATE TABLE IF NOT EXISTS `OnlineRetailDB`.`DeliveryOption` (
  `option_id` INT UNSIGNED ZEROFILL NOT NULL,
  `description` VARCHAR(45) NOT NULL,
  `nonmember_price` DECIMAL(10,2) NOT NULL,
  `member_price` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`option_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OnlineRetailDB`.`DistributionCenter`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OnlineRetailDB`.`DistributionCenter` ;

CREATE TABLE IF NOT EXISTS `OnlineRetailDB`.`DistributionCenter` (
  `center_id` INT UNSIGNED ZEROFILL NOT NULL,
  `total_packages_processed` INT UNSIGNED NOT NULL,
  `address` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`center_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OnlineRetailDB`.`CourierService`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OnlineRetailDB`.`CourierService` ;

CREATE TABLE IF NOT EXISTS `OnlineRetailDB`.`CourierService` (
  `courier_id` INT UNSIGNED ZEROFILL NOT NULL,
  `company_name` VARCHAR(45) NOT NULL,
  `contract_start` DATETIME NOT NULL,
  `contract_end` VARCHAR(45) NULL,
  PRIMARY KEY (`courier_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OnlineRetailDB`.`PackagingService`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OnlineRetailDB`.`PackagingService` ;

CREATE TABLE IF NOT EXISTS `OnlineRetailDB`.`PackagingService` (
  `packaging_id` INT UNSIGNED ZEROFILL NOT NULL,
  `company_name` VARCHAR(45) NOT NULL,
  `contract_start` DATETIME NOT NULL,
  `contract_end` DATETIME NULL,
  PRIMARY KEY (`packaging_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OnlineRetailDB`.`PaymentInformation`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OnlineRetailDB`.`PaymentInformation` ;

CREATE TABLE IF NOT EXISTS `OnlineRetailDB`.`PaymentInformation` (
  `payment_id` INT UNSIGNED ZEROFILL NOT NULL,
  `card_number` INT UNSIGNED NOT NULL,
  `cvv` INT UNSIGNED NOT NULL,
  `expiration` DATETIME NOT NULL,
  PRIMARY KEY (`payment_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OnlineRetailDB`.`OrderDetail`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OnlineRetailDB`.`OrderDetail` ;

CREATE TABLE IF NOT EXISTS `OnlineRetailDB`.`OrderDetail` (
  `order_id` INT UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT,
  `total` DECIMAL(10,2) NOT NULL,
  `created_at` DATETIME NOT NULL,
  `user` INT UNSIGNED NULL,
  `delivery_option` INT UNSIGNED NOT NULL,
  `distribution_center` INT UNSIGNED NULL,
  `courier_service` INT UNSIGNED NULL,
  `packaging_service` INT UNSIGNED NULL,
  `payment_information` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`order_id`),
  INDEX `FK_ORDERDETAIL_USER_idx` (`user` ASC) VISIBLE,
  INDEX `FK_ORDERDETAIL_DELIVERYOPTION_idx` (`delivery_option` ASC) VISIBLE,
  INDEX `FK_ORDERDETAIL_DISTRIBUTIONCENTER_idx` (`distribution_center` ASC) VISIBLE,
  INDEX `FK_ORDERDETAIL_COURIERSERVICE_idx` (`courier_service` ASC) VISIBLE,
  INDEX `FK_ORDERDETAIL_PACKAGINGSERVICE_idx` (`packaging_service` ASC) VISIBLE,
  INDEX `FK_ORDERDETAIL_PAYMENTINFORMATION_idx` (`payment_information` ASC) VISIBLE,
  CONSTRAINT `FK_ORDERDETAIL_USER`
    FOREIGN KEY (`user`)
    REFERENCES `OnlineRetailDB`.`User` (`user_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `FK_ORDERDETAIL_DELIVERYOPTION`
    FOREIGN KEY (`delivery_option`)
    REFERENCES `OnlineRetailDB`.`DeliveryOption` (`option_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `FK_ORDERDETAIL_DISTRIBUTIONCENTER`
    FOREIGN KEY (`distribution_center`)
    REFERENCES `OnlineRetailDB`.`DistributionCenter` (`center_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `FK_ORDERDETAIL_COURIERSERVICE`
    FOREIGN KEY (`courier_service`)
    REFERENCES `OnlineRetailDB`.`CourierService` (`courier_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `FK_ORDERDETAIL_PACKAGINGSERVICE`
    FOREIGN KEY (`packaging_service`)
    REFERENCES `OnlineRetailDB`.`PackagingService` (`packaging_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `FK_ORDERDETAIL_PAYMENTINFORMATION`
    FOREIGN KEY (`payment_information`)
    REFERENCES `OnlineRetailDB`.`PaymentInformation` (`payment_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OnlineRetailDB`.`OrderItem`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OnlineRetailDB`.`OrderItem` ;

CREATE TABLE IF NOT EXISTS `OnlineRetailDB`.`OrderItem` (
  `item_order_id` INT UNSIGNED ZEROFILL NOT NULL,
  `quantity` INT UNSIGNED NOT NULL,
  `created_at` DATETIME NOT NULL,
  `orderDetail` INT UNSIGNED NOT NULL,
  `product` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`item_order_id`),
  INDEX `FK_ORDERITEM_ORDERDETAIL_idx` (`orderDetail` ASC) VISIBLE,
  INDEX `FK_ORDERITEM_PRODUCT_idx` (`product` ASC) VISIBLE,
  CONSTRAINT `FK_ORDERITEM_ORDERDETAIL`
    FOREIGN KEY (`orderDetail`)
    REFERENCES `OnlineRetailDB`.`OrderDetail` (`order_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `FK_ORDERITEM_PRODUCT`
    FOREIGN KEY (`product`)
    REFERENCES `OnlineRetailDB`.`Product` (`product_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OnlineRetailDB`.`UserPaymentMethod`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OnlineRetailDB`.`UserPaymentMethod` ;

CREATE TABLE IF NOT EXISTS `OnlineRetailDB`.`UserPaymentMethod` (
  `user_payment_id` INT ZEROFILL UNSIGNED NOT NULL,
  `user` INT UNSIGNED NOT NULL,
  `payment_information` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`user_payment_id`),
  INDEX `FK_USERPAYMENTMETHOD_USER_idx` (`user` ASC) VISIBLE,
  INDEX `FK_USERPAYMENTMETHOD_PAYMENTMETHOD_idx` (`payment_information` ASC) VISIBLE,
  CONSTRAINT `FK_USERPAYMENTMETHOD_USER`
    FOREIGN KEY (`user`)
    REFERENCES `OnlineRetailDB`.`User` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `FK_USERPAYMENTMETHOD_PAYMENTMETHOD`
    FOREIGN KEY (`payment_information`)
    REFERENCES `OnlineRetailDB`.`PaymentInformation` (`payment_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OnlineRetailDB`.`ReturnReason`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OnlineRetailDB`.`ReturnReason` ;

CREATE TABLE IF NOT EXISTS `OnlineRetailDB`.`ReturnReason` (
  `reason_id` INT UNSIGNED ZEROFILL NOT NULL,
  `description` VARCHAR(45) NOT NULL,
  `subcategories` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`reason_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OnlineRetailDB`.`CustomerServiceRep`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OnlineRetailDB`.`CustomerServiceRep` ;

CREATE TABLE IF NOT EXISTS `OnlineRetailDB`.`CustomerServiceRep` (
  `service_rep_id` INT UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT,
  `returns_handled` INT UNSIGNED NOT NULL,
  `errors` INT UNSIGNED NOT NULL,
  `office_worker` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`service_rep_id`, `office_worker`),
  INDEX `FK_CUSTSERVICEREP_OFFICEWORKER_idx` (`office_worker` ASC) VISIBLE,
  CONSTRAINT `FK_CUSTSERVICEREP_OFFICEWORKER`
    FOREIGN KEY (`office_worker`)
    REFERENCES `OnlineRetailDB`.`OfficeWorker` (`worker_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OnlineRetailDB`.`Return`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OnlineRetailDB`.`Return` ;

CREATE TABLE IF NOT EXISTS `OnlineRetailDB`.`Return` (
  `return_id` INT UNSIGNED ZEROFILL NOT NULL,
  `description` VARCHAR(255) NULL,
  `created_at` DATETIME NOT NULL,
  `reason` INT UNSIGNED NOT NULL,
  `cust_service_rep` INT UNSIGNED NULL,
  `user` INT UNSIGNED NOT NULL,
  `orderDetail` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`return_id`),
  INDEX `FK_RETURN_RETURNREASON_idx` (`reason` ASC) VISIBLE,
  INDEX `FK_RETURN_CUSTSERVICEREP_idx` (`cust_service_rep` ASC) VISIBLE,
  INDEX `FK_RETURN_USERID_idx` (`user` ASC) VISIBLE,
  INDEX `FK_RETURN_ORDERDETAIL_idx` (`orderDetail` ASC) VISIBLE,
  UNIQUE INDEX `orderDetail_UNIQUE` (`orderDetail` ASC) VISIBLE,
  CONSTRAINT `FK_RETURN_RETURNREASON`
    FOREIGN KEY (`reason`)
    REFERENCES `OnlineRetailDB`.`ReturnReason` (`reason_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `FK_RETURN_CUSTSERVICEREP`
    FOREIGN KEY (`cust_service_rep`)
    REFERENCES `OnlineRetailDB`.`CustomerServiceRep` (`service_rep_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `FK_RETURN_USERID`
    FOREIGN KEY (`user`)
    REFERENCES `OnlineRetailDB`.`User` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `FK_RETURN_ORDERDETAIL`
    FOREIGN KEY (`orderDetail`)
    REFERENCES `OnlineRetailDB`.`OrderDetail` (`order_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OnlineRetailDB`.`DistributionCenterWorker`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OnlineRetailDB`.`DistributionCenterWorker` ;

CREATE TABLE IF NOT EXISTS `OnlineRetailDB`.`DistributionCenterWorker` (
  `worker_id` INT UNSIGNED ZEROFILL NOT NULL,
  `packages_processed` INT UNSIGNED NOT NULL,
  `errors` INT NOT NULL,
  `salary` DECIMAL(10,2) NOT NULL,
  `distribution_center` INT UNSIGNED NULL,
  PRIMARY KEY (`worker_id`),
  INDEX `FK_DISTRIBUTIONCENTERWORKER_DISTRIBUTIONCENTER_idx` (`distribution_center` ASC) VISIBLE,
  CONSTRAINT `FK_DISTRIBUTIONCENTERWORKER_DISTRIBUTIONCENTER`
    FOREIGN KEY (`distribution_center`)
    REFERENCES `OnlineRetailDB`.`DistributionCenter` (`center_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OnlineRetailDB`.`CourierExpense`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OnlineRetailDB`.`CourierExpense` ;

CREATE TABLE IF NOT EXISTS `OnlineRetailDB`.`CourierExpense` (
  `cexpense_id` INT UNSIGNED ZEROFILL NOT NULL,
  `amount` DECIMAL(10,2) UNSIGNED NOT NULL,
  `description` VARCHAR(100) NULL,
  `paid_on` DATETIME NOT NULL,
  `courier_service` INT UNSIGNED NULL,
  PRIMARY KEY (`cexpense_id`),
  INDEX `FK_COURIEREXPENSE_COURIERSERVICE_idx` (`courier_service` ASC) VISIBLE,
  CONSTRAINT `FK_COURIEREXPENSE_COURIERSERVICE`
    FOREIGN KEY (`courier_service`)
    REFERENCES `OnlineRetailDB`.`CourierService` (`courier_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OnlineRetailDB`.`PackagingExpense`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OnlineRetailDB`.`PackagingExpense` ;

CREATE TABLE IF NOT EXISTS `OnlineRetailDB`.`PackagingExpense` (
  `cexpense_id` INT UNSIGNED ZEROFILL NOT NULL,
  `amount` DECIMAL(10,2) UNSIGNED NOT NULL,
  `description` VARCHAR(100) NULL,
  `paid_on` DATETIME NOT NULL,
  `packaging_service` INT UNSIGNED NULL,
  PRIMARY KEY (`cexpense_id`),
  INDEX `FK_COURIEREXPENSE_PACKAGINGSERVICE0_idx` (`packaging_service` ASC) VISIBLE,
  CONSTRAINT `FK_COURIEREXPENSE_PACKAGINGSERVICE0`
    FOREIGN KEY (`packaging_service`)
    REFERENCES `OnlineRetailDB`.`PackagingService` (`packaging_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OnlineRetailDB`.`Supervisor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OnlineRetailDB`.`Supervisor` ;

CREATE TABLE IF NOT EXISTS `OnlineRetailDB`.`Supervisor` (
  `worker_id` INT UNSIGNED ZEROFILL NOT NULL,
  `supervisor_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`worker_id`),
  INDEX `FK_SUPERVISOR_SUPERVISOR_idx` (`supervisor_id` ASC) VISIBLE,
  CONSTRAINT `FK_SUPERVISOR_OFFICEWORKER`
    FOREIGN KEY (`worker_id`)
    REFERENCES `OnlineRetailDB`.`OfficeWorker` (`worker_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `FK_SUPERVISOR_SUPERVISOR`
    FOREIGN KEY (`supervisor_id`)
    REFERENCES `OnlineRetailDB`.`OfficeWorker` (`worker_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OnlineRetailDB`.`Address`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OnlineRetailDB`.`Address` ;

CREATE TABLE IF NOT EXISTS `OnlineRetailDB`.`Address` (
  `address_id` INT UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT,
  `street` VARCHAR(45) NULL,
  `zipcode` INT NULL,
  `city` VARCHAR(45) NULL,
  `state` VARCHAR(45) NULL,
  PRIMARY KEY (`address_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OnlineRetailDB`.`UserAddress`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OnlineRetailDB`.`UserAddress` ;

CREATE TABLE IF NOT EXISTS `OnlineRetailDB`.`UserAddress` (
  `u_address_id` INT UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT,
  `user` INT UNSIGNED NOT NULL,
  `address` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`u_address_id`),
  INDEX `FK_USERADDRESS_USER_idx` (`user` ASC) VISIBLE,
  INDEX `FK_USERADDRESS_ADDRESS_idx` (`address` ASC) VISIBLE,
  CONSTRAINT `FK_USERADDRESS_USER`
    FOREIGN KEY (`user`)
    REFERENCES `OnlineRetailDB`.`User` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `FK_USERADDRESS_ADDRESS`
    FOREIGN KEY (`address`)
    REFERENCES `OnlineRetailDB`.`Address` (`address_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OnlineRetailDB`.`Alert`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OnlineRetailDB`.`Alert` ;

CREATE TABLE IF NOT EXISTS `OnlineRetailDB`.`Alert` (
  `alert_id` INT UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT,
  `subject` VARCHAR(45) NOT NULL,
  `description` VARCHAR(200) NOT NULL,
  `created_at` DATETIME NOT NULL,
  `expires_at` DATETIME NOT NULL,
  PRIMARY KEY (`alert_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OnlineRetailDB`.`TargetedAlert`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OnlineRetailDB`.`TargetedAlert` ;

CREATE TABLE IF NOT EXISTS `OnlineRetailDB`.`TargetedAlert` (
  `t_alert_id` INT UNSIGNED ZEROFILL NOT NULL,
  `user` INT UNSIGNED NOT NULL,
  `alert` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`t_alert_id`),
  INDEX `PK_TALERT_USER_idx` (`user` ASC) VISIBLE,
  INDEX `PK_TALERT_ALERT_idx` (`alert` ASC) VISIBLE,
  CONSTRAINT `PK_TALERT_USER`
    FOREIGN KEY (`user`)
    REFERENCES `OnlineRetailDB`.`User` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `PK_TALERT_ALERT`
    FOREIGN KEY (`alert`)
    REFERENCES `OnlineRetailDB`.`Alert` (`alert_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OnlineRetailDB`.`Membership`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OnlineRetailDB`.`Membership` ;

CREATE TABLE IF NOT EXISTS `OnlineRetailDB`.`Membership` (
  `membership_id` INT UNSIGNED ZEROFILL NOT NULL,
  `start_date` DATETIME NOT NULL,
  `expiry_date` DATETIME NOT NULL,
  `user` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`membership_id`),
  INDEX `FK_MEMBERSHIP_USER_idx` (`user` ASC) VISIBLE,
  CONSTRAINT `FK_MEMBERSHIP_USER`
    FOREIGN KEY (`user`)
    REFERENCES `OnlineRetailDB`.`User` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OnlineRetailDB`.`PPCManager`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OnlineRetailDB`.`PPCManager` ;

CREATE TABLE IF NOT EXISTS `OnlineRetailDB`.`PPCManager` (
  `manager_id` INT UNSIGNED ZEROFILL NOT NULL,
  `channels_handled` INT UNSIGNED NOT NULL,
  `total_clicks` INT UNSIGNED NOT NULL,
  `office_worker` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`manager_id`, `office_worker`),
  INDEX `FK_PPCMANAGER_OFFICEWORKER_idx` (`office_worker` ASC) VISIBLE,
  CONSTRAINT `FK_PPCMANAGER_OFFICEWORKER`
    FOREIGN KEY (`office_worker`)
    REFERENCES `OnlineRetailDB`.`OfficeWorker` (`worker_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OnlineRetailDB`.`AdvertisingChannel`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OnlineRetailDB`.`AdvertisingChannel` ;

CREATE TABLE IF NOT EXISTS `OnlineRetailDB`.`AdvertisingChannel` (
  `channel_id` INT UNSIGNED ZEROFILL NOT NULL,
  `channel_name` VARCHAR(45) NOT NULL,
  `cost` DECIMAL(10,2) UNSIGNED NOT NULL,
  `clicks` INT UNSIGNED NOT NULL,
  `contract_start` DATETIME NOT NULL,
  `contract_end` DATETIME NULL,
  `manager` INT UNSIGNED NULL,
  PRIMARY KEY (`channel_id`),
  INDEX `FK_ADVERTISINGCHANNEL_PPCMANAGER_idx` (`manager` ASC) VISIBLE,
  CONSTRAINT `FK_ADVERTISINGCHANNEL_PPCMANAGER`
    FOREIGN KEY (`manager`)
    REFERENCES `OnlineRetailDB`.`PPCManager` (`manager_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OnlineRetailDB`.`marketingSpecialist`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OnlineRetailDB`.`marketingSpecialist` ;

CREATE TABLE IF NOT EXISTS `OnlineRetailDB`.`marketingSpecialist` (
  `specialist_id` INT UNSIGNED ZEROFILL NOT NULL,
  `partnerships_handled` INT UNSIGNED NOT NULL,
  `total_cost` DECIMAL(10,2) UNSIGNED NULL,
  `office_worker` INT UNSIGNED ZEROFILL NOT NULL,
  PRIMARY KEY (`specialist_id`, `office_worker`),
  INDEX `FK_MARKETINGSPECIALIST_OFFICEWORKER_idx` (`office_worker` ASC) VISIBLE,
  CONSTRAINT `FK_MARKETINGSPECIALIST_OFFICEWORKER`
    FOREIGN KEY (`office_worker`)
    REFERENCES `OnlineRetailDB`.`OfficeWorker` (`worker_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OnlineRetailDB`.`BrandPartnership`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OnlineRetailDB`.`BrandPartnership` ;

CREATE TABLE IF NOT EXISTS `OnlineRetailDB`.`BrandPartnership` (
  `partnership_id` INT UNSIGNED ZEROFILL NOT NULL,
  `company_name` VARCHAR(45) NOT NULL,
  `contract_start` DATETIME NOT NULL,
  `contract_end` DATETIME NULL,
  `specialist` INT UNSIGNED NULL,
  PRIMARY KEY (`partnership_id`),
  INDEX `FK_BRANDPARTNERSHIP_MARKETINGSPECIALIST_idx` (`specialist` ASC) VISIBLE,
  CONSTRAINT `FK_BRANDPARTNERSHIP_MARKETINGSPECIALIST`
    FOREIGN KEY (`specialist`)
    REFERENCES `OnlineRetailDB`.`marketingSpecialist` (`specialist_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OnlineRetailDB`.`Expense`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OnlineRetailDB`.`Expense` ;

CREATE TABLE IF NOT EXISTS `OnlineRetailDB`.`Expense` (
  `expense_id` INT UNSIGNED ZEROFILL NOT NULL,
  `category` VARCHAR(45) NULL,
  `amount` DECIMAL(10,2) NULL,
  PRIMARY KEY (`expense_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OnlineRetailDB`.`ExpenseIncurred`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OnlineRetailDB`.`ExpenseIncurred` ;

CREATE TABLE IF NOT EXISTS `OnlineRetailDB`.`ExpenseIncurred` (
  `expense_incurred_id` INT UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT,
  `vexpense` INT UNSIGNED NULL,
  `sexpense` INT UNSIGNED NULL,
  `cexpense` INT UNSIGNED NULL,
  `pexpense` INT UNSIGNED NULL,
  PRIMARY KEY (`expense_incurred_id`),
  UNIQUE INDEX `pexpense_UNIQUE` (`pexpense` ASC) VISIBLE,
  UNIQUE INDEX `cexpense_UNIQUE` (`cexpense` ASC) VISIBLE,
  UNIQUE INDEX `sexpense_UNIQUE` (`sexpense` ASC) VISIBLE,
  UNIQUE INDEX `vexpense_UNIQUE` (`vexpense` ASC) VISIBLE,
  CONSTRAINT `FK_EXPENSEINCURRED_VEXPENSE`
    FOREIGN KEY (`vexpense`)
    REFERENCES `OnlineRetailDB`.`VendorExpense` (`vexpense_id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT,
  CONSTRAINT `FK_EXPENSEINCURRED_SEXPENSE`
    FOREIGN KEY (`sexpense`)
    REFERENCES `OnlineRetailDB`.`SupplierExpense` (`sexpense_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_EXPENSEINCURRED_PEXPENSE`
    FOREIGN KEY (`pexpense`)
    REFERENCES `OnlineRetailDB`.`PackagingExpense` (`cexpense_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_EXPENSEINCURRED_CEXPENSE`
    FOREIGN KEY (`cexpense`)
    REFERENCES `OnlineRetailDB`.`CourierExpense` (`cexpense_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_EXPENSEINCURRED_EXPENSE`
    FOREIGN KEY (`expense_incurred_id`)
    REFERENCES `OnlineRetailDB`.`Expense` (`expense_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OnlineRetailDB`.`ProcessedOrders`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OnlineRetailDB`.`ProcessedOrders` ;

CREATE TABLE IF NOT EXISTS `OnlineRetailDB`.`ProcessedOrders` (
  `p_order_id` INT UNSIGNED ZEROFILL NOT NULL,
  `worker_id` INT UNSIGNED NOT NULL,
  `order_id` INT UNSIGNED NOT NULL,
  `date_processed` DATETIME NOT NULL,
  PRIMARY KEY (`p_order_id`),
  INDEX `FK_PROCESSEDORDERS_WORKER_idx` (`worker_id` ASC) VISIBLE,
  INDEX `FK_PROCESSEDORDERS_ORDERDETAIL_idx` (`order_id` ASC) VISIBLE,
  CONSTRAINT `FK_PROCESSEDORDERS_WORKER`
    FOREIGN KEY (`worker_id`)
    REFERENCES `OnlineRetailDB`.`DistributionCenterWorker` (`worker_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_PROCESSEDORDERS_ORDERDETAIL`
    FOREIGN KEY (`order_id`)
    REFERENCES `OnlineRetailDB`.`OrderDetail` (`order_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OnlineRetailDB`.`ProductReturns`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OnlineRetailDB`.`ProductReturns` ;

CREATE TABLE IF NOT EXISTS `OnlineRetailDB`.`ProductReturns` (
  `product_return_id` INT UNSIGNED ZEROFILL NOT NULL,
  `product` INT UNSIGNED NOT NULL,
  `return` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`product_return_id`),
  INDEX `FK_PRODUCTRETURN_PRODUCT_idx` (`product` ASC) VISIBLE,
  INDEX `FK_PRODUCTRETURN_RETURN_idx` (`return` ASC) VISIBLE,
  CONSTRAINT `FK_PRODUCTRETURN_PRODUCT`
    FOREIGN KEY (`product`)
    REFERENCES `OnlineRetailDB`.`Product` (`product_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_PRODUCTRETURN_RETURN`
    FOREIGN KEY (`return`)
    REFERENCES `OnlineRetailDB`.`Return` (`return_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
