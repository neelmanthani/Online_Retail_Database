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
  `dob` DATE NOT NULL,
  `registration_date` DATE NOT NULL,
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
  `contract_start` DATE NULL,
  `contract_end` DATE NULL,
  PRIMARY KEY (`vendor_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OnlineRetailDB`.`ProductCategory`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OnlineRetailDB`.`ProductCategory` ;

CREATE TABLE IF NOT EXISTS `OnlineRetailDB`.`ProductCategory` (
  `category_id` INT UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT,
  `category_name` VARCHAR(45) NOT NULL,
  `subcategory_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`category_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OnlineRetailDB`.`OfficeWorker`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OnlineRetailDB`.`OfficeWorker` ;

CREATE TABLE IF NOT EXISTS `OnlineRetailDB`.`OfficeWorker` (
  `worker_id` INT UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT,
  `salary` DECIMAL(10,2) UNSIGNED NOT NULL,
  `date_hired` DATE NOT NULL,
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
  PRIMARY KEY (`qa_rep_id`),
  INDEX `FK_QAREP_OFFICEWORKER_idx` (`office_worker` ASC) VISIBLE,
  CONSTRAINT `FK_QAREP_OFFICEWORKER`
    FOREIGN KEY (`office_worker`)
    REFERENCES `OnlineRetailDB`.`OfficeWorker` (`worker_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OnlineRetailDB`.`Supplier`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OnlineRetailDB`.`Supplier` ;

CREATE TABLE IF NOT EXISTS `OnlineRetailDB`.`Supplier` (
  `supplier_id` INT UNSIGNED ZEROFILL NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `contract_start` DATE NULL,
  `contract_end` DATE NULL,
  PRIMARY KEY (`supplier_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OnlineRetailDB`.`Product`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OnlineRetailDB`.`Product` ;

CREATE TABLE IF NOT EXISTS `OnlineRetailDB`.`Product` (
  `product_id` INT UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT,
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
    ON DELETE SET NULL
    ON UPDATE CASCADE,
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
  `vexpense_id` INT UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT,
  `amount` INT UNSIGNED NOT NULL,
  `description` VARCHAR(100) NOT NULL,
  `date_paid` DATE NOT NULL,
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
  `sexpense_id` INT UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT,
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
  `created_at` DATE NOT NULL,
  `user` INT UNSIGNED ZEROFILL NOT NULL,
  `product` INT UNSIGNED ZEROFILL NOT NULL,
  `score` TINYINT(1) UNSIGNED NOT NULL,
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
  `contract_start` DATE NOT NULL,
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
  `contract_start` DATE NOT NULL,
  `contract_end` DATE NULL,
  PRIMARY KEY (`packaging_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OnlineRetailDB`.`PaymentInformation`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OnlineRetailDB`.`PaymentInformation` ;

CREATE TABLE IF NOT EXISTS `OnlineRetailDB`.`PaymentInformation` (
  `payment_id` INT UNSIGNED ZEROFILL NOT NULL,
  `card_number` VARCHAR(16) NOT NULL,
  `cvv` INT UNSIGNED NOT NULL,
  `expiration` DATE NOT NULL,
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
  `delivery_option` INT UNSIGNED NULL,
  `distribution_center` INT UNSIGNED NULL,
  `courier_service` INT UNSIGNED NULL,
  `packaging_service` INT UNSIGNED NULL,
  `payment_information` INT UNSIGNED NULL,
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
  `item_order_id` INT UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT,
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
  PRIMARY KEY (`service_rep_id`),
  INDEX `FK_CUSTSERVICEREP_OFFICEWORKER_idx` (`office_worker` ASC) VISIBLE,
  CONSTRAINT `FK_CUSTSERVICEREP_OFFICEWORKER`
    FOREIGN KEY (`office_worker`)
    REFERENCES `OnlineRetailDB`.`OfficeWorker` (`worker_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OnlineRetailDB`.`OrderReturn`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OnlineRetailDB`.`OrderReturn` ;

CREATE TABLE IF NOT EXISTS `OnlineRetailDB`.`OrderReturn` (
  `return_id` INT UNSIGNED ZEROFILL NOT NULL,
  `description` VARCHAR(255) NULL,
  `created_at` DATE NOT NULL,
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
  `cexpense_id` INT UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT,
  `amount` DECIMAL(10,2) UNSIGNED NOT NULL,
  `description` VARCHAR(100) NULL,
  `paid_on` DATE NOT NULL,
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
  `pexpense_id` INT UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT,
  `amount` DECIMAL(10,2) UNSIGNED NOT NULL,
  `description` VARCHAR(100) NULL,
  `paid_on` DATE NOT NULL,
  `packaging_service` INT UNSIGNED NULL,
  PRIMARY KEY (`pexpense_id`),
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
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
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
  `alert_id` INT UNSIGNED ZEROFILL NOT NULL,
  `subject` VARCHAR(45) NOT NULL,
  `description` VARCHAR(200) NOT NULL,
  `created_at` DATE NOT NULL,
  `expires_at` DATE NOT NULL,
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
  `start_date` DATE NOT NULL,
  `expiry_date` DATE NOT NULL,
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
  `manager_id` INT UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT,
  `channels_handled` INT UNSIGNED NOT NULL,
  `total_clicks` INT UNSIGNED NOT NULL,
  `office_worker` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`manager_id`),
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
  `contract_start` DATE NOT NULL,
  `contract_end` DATE NULL,
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
-- Table `OnlineRetailDB`.`MarketingSpecialist`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OnlineRetailDB`.`MarketingSpecialist` ;

CREATE TABLE IF NOT EXISTS `OnlineRetailDB`.`MarketingSpecialist` (
  `specialist_id` INT UNSIGNED ZEROFILL NOT NULL,
  `partnerships_handled` INT UNSIGNED NOT NULL,
  `total_cost` DECIMAL(10,2) UNSIGNED NULL,
  `office_worker` INT UNSIGNED ZEROFILL NOT NULL,
  PRIMARY KEY (`specialist_id`),
  INDEX `FK_MARKETINGSPECIALIST_OFFICEWORKER_idx` (`office_worker` ASC) VISIBLE,
  CONSTRAINT `FK_MARKETINGSPECIALIST_OFFICEWORKER`
    FOREIGN KEY (`office_worker`)
    REFERENCES `OnlineRetailDB`.`OfficeWorker` (`worker_id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OnlineRetailDB`.`BrandPartnership`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OnlineRetailDB`.`BrandPartnership` ;

CREATE TABLE IF NOT EXISTS `OnlineRetailDB`.`BrandPartnership` (
  `partnership_id` INT UNSIGNED ZEROFILL NOT NULL,
  `company_name` VARCHAR(45) NOT NULL,
  `contract_start` DATE NOT NULL,
  `contract_end` DATE NULL,
  `specialist` INT UNSIGNED NULL,
  PRIMARY KEY (`partnership_id`),
  INDEX `FK_BRANDPARTNERSHIP_MARKETINGSPECIALIST_idx` (`specialist` ASC) VISIBLE,
  CONSTRAINT `FK_BRANDPARTNERSHIP_MARKETINGSPECIALIST`
    FOREIGN KEY (`specialist`)
    REFERENCES `OnlineRetailDB`.`MarketingSpecialist` (`specialist_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OnlineRetailDB`.`Expense`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OnlineRetailDB`.`Expense` ;

CREATE TABLE IF NOT EXISTS `OnlineRetailDB`.`Expense` (
  `expense_id` INT UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT,
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
    REFERENCES `OnlineRetailDB`.`PackagingExpense` (`pexpense_id`)
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
-- Table `OnlineRetailDB`.`ProcessedOrder`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OnlineRetailDB`.`ProcessedOrder` ;

CREATE TABLE IF NOT EXISTS `OnlineRetailDB`.`ProcessedOrder` (
  `p_order_id` INT UNSIGNED ZEROFILL NOT NULL,
  `worker_id` INT UNSIGNED NOT NULL,
  `order_id` INT UNSIGNED NOT NULL,
  `date_processed` DATE NOT NULL,
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
    REFERENCES `OnlineRetailDB`.`OrderReturn` (`return_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `OnlineRetailDB`.`User`
-- -----------------------------------------------------
START TRANSACTION;
USE `OnlineRetailDB`;
INSERT INTO `OnlineRetailDB`.`User` (`user_id`, `first_name`, `last_name`, `dob`, `registration_date`, `email`, `password`) VALUES (0, 'John', 'Smith', '1998-01-01', '2012-01-01', 'johnsmith@gmail.com', 'password');
INSERT INTO `OnlineRetailDB`.`User` (`user_id`, `first_name`, `last_name`, `dob`, `registration_date`, `email`, `password`) VALUES (1, 'Bryan', 'Jackson', '1970-07-29', '2016-04-05', 'bryanjackson@yahoo.com', 'password');
INSERT INTO `OnlineRetailDB`.`User` (`user_id`, `first_name`, `last_name`, `dob`, `registration_date`, `email`, `password`) VALUES (2, 'Aubrey', 'Graham', '2003-10-23', '2014-02-15', 'drizzydrake@hotmail.com', 'password');
INSERT INTO `OnlineRetailDB`.`User` (`user_id`, `first_name`, `last_name`, `dob`, `registration_date`, `email`, `password`) VALUES (3, 'Phil', 'Swift', '1998-02-02', '2014-02-15', 'pswift@gmail.com', 'password');
INSERT INTO `OnlineRetailDB`.`User` (`user_id`, `first_name`, `last_name`, `dob`, `registration_date`, `email`, `password`) VALUES (4, 'Jack', 'Johnson', '1970-06-25', '2014-02-15', 'jjohnson@hotmail.com', 'password');
INSERT INTO `OnlineRetailDB`.`User` (`user_id`, `first_name`, `last_name`, `dob`, `registration_date`, `email`, `password`) VALUES (5, 'Bill', 'Hader', '1970-03-28', '2014-02-15', 'bhader@msnbc.net', 'password');
INSERT INTO `OnlineRetailDB`.`User` (`user_id`, `first_name`, `last_name`, `dob`, `registration_date`, `email`, `password`) VALUES (6, 'Janine', 'Smith', '2003-09-18', '2014-02-15', 'jsmith@yahoo.com', 'password');
INSERT INTO `OnlineRetailDB`.`User` (`user_id`, `first_name`, `last_name`, `dob`, `registration_date`, `email`, `password`) VALUES (7, 'Caroline', 'Staller', '2003-09-15', '2014-02-15', 'cstaller@gmail.com', 'password');
INSERT INTO `OnlineRetailDB`.`User` (`user_id`, `first_name`, `last_name`, `dob`, `registration_date`, `email`, `password`) VALUES (8, 'Randy', 'Fujishin', '2003-04-22', '2014-02-15', 'rfujishin@yahoo.com', 'password');
INSERT INTO `OnlineRetailDB`.`User` (`user_id`, `first_name`, `last_name`, `dob`, `registration_date`, `email`, `password`) VALUES (9, 'Kurisu', 'Makise', '1970-05-22', '2014-02-15', 'kmakise@hotmail.com', 'password');
INSERT INTO `OnlineRetailDB`.`User` (`user_id`, `first_name`, `last_name`, `dob`, `registration_date`, `email`, `password`) VALUES (10, 'Cami', 'Dang', '1998-04-04', '2014-02-15', 'cdang@gmail.com', 'password');

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
INSERT INTO `OnlineRetailDB`.`ProductCategory` (`category_id`, `category_name`, `subcategory_name`) VALUES (0, 'Recreation', 'Wood');
INSERT INTO `OnlineRetailDB`.`ProductCategory` (`category_id`, `category_name`, `subcategory_name`) VALUES (0, 'Electronics', 'Powerbank');
INSERT INTO `OnlineRetailDB`.`ProductCategory` (`category_id`, `category_name`, `subcategory_name`) VALUES (0, 'Clothing', 'Footwear');
INSERT INTO `OnlineRetailDB`.`ProductCategory` (`category_id`, `category_name`, `subcategory_name`) VALUES (0, 'Clothing', 'Etc');

COMMIT;


-- -----------------------------------------------------
-- Data for table `OnlineRetailDB`.`OfficeWorker`
-- -----------------------------------------------------
START TRANSACTION;
USE `OnlineRetailDB`;
INSERT INTO `OnlineRetailDB`.`OfficeWorker` (`worker_id`, `salary`, `date_hired`, `is_supervisor`) VALUES (0, 60000, '2005-10-15', true);
INSERT INTO `OnlineRetailDB`.`OfficeWorker` (`worker_id`, `salary`, `date_hired`, `is_supervisor`) VALUES (0, 80000, '2012-06-25', true);
INSERT INTO `OnlineRetailDB`.`OfficeWorker` (`worker_id`, `salary`, `date_hired`, `is_supervisor`) VALUES (0, 100000, '2019-08-28', true);
INSERT INTO `OnlineRetailDB`.`OfficeWorker` (`worker_id`, `salary`, `date_hired`, `is_supervisor`) VALUES (0, 100000, '2019-08-28', true);
INSERT INTO `OnlineRetailDB`.`OfficeWorker` (`worker_id`, `salary`, `date_hired`, `is_supervisor`) VALUES (0, 100000, '2019-08-28', true);
INSERT INTO `OnlineRetailDB`.`OfficeWorker` (`worker_id`, `salary`, `date_hired`, `is_supervisor`) VALUES (0, 100000, '2019-08-28', true);
INSERT INTO `OnlineRetailDB`.`OfficeWorker` (`worker_id`, `salary`, `date_hired`, `is_supervisor`) VALUES (0, 100000, '2019-08-28', true);
INSERT INTO `OnlineRetailDB`.`OfficeWorker` (`worker_id`, `salary`, `date_hired`, `is_supervisor`) VALUES (0, 100000, '2019-08-28', true);
INSERT INTO `OnlineRetailDB`.`OfficeWorker` (`worker_id`, `salary`, `date_hired`, `is_supervisor`) VALUES (0, 100000, '2019-08-28', true);
INSERT INTO `OnlineRetailDB`.`OfficeWorker` (`worker_id`, `salary`, `date_hired`, `is_supervisor`) VALUES (0, 100000, '2019-08-28', true);
INSERT INTO `OnlineRetailDB`.`OfficeWorker` (`worker_id`, `salary`, `date_hired`, `is_supervisor`) VALUES (0, 100000, '2019-08-28', true);
INSERT INTO `OnlineRetailDB`.`OfficeWorker` (`worker_id`, `salary`, `date_hired`, `is_supervisor`) VALUES (0, 100000, '2019-08-28', true);

COMMIT;


-- -----------------------------------------------------
-- Data for table `OnlineRetailDB`.`QualityAssuranceRep`
-- -----------------------------------------------------
START TRANSACTION;
USE `OnlineRetailDB`;
INSERT INTO `OnlineRetailDB`.`QualityAssuranceRep` (`qa_rep_id`, `products_managed`, `errors`, `office_worker`) VALUES (0, 15, 1, 4);
INSERT INTO `OnlineRetailDB`.`QualityAssuranceRep` (`qa_rep_id`, `products_managed`, `errors`, `office_worker`) VALUES (0, 25, 3, 5);
INSERT INTO `OnlineRetailDB`.`QualityAssuranceRep` (`qa_rep_id`, `products_managed`, `errors`, `office_worker`) VALUES (0, 7, 0, 6);

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
INSERT INTO `OnlineRetailDB`.`Product` (`product_id`, `name`, `description`, `stock`, `vendor`, `price`, `product_category`, `qa_rep`, `supplier`) VALUES (0, 'Vacuum Cleaner', 'Best vacuum in town', 10, 0, 48.97, 1, 1, NULL);
INSERT INTO `OnlineRetailDB`.`Product` (`product_id`, `name`, `description`, `stock`, `vendor`, `price`, `product_category`, `qa_rep`, `supplier`) VALUES (0, 'Wood Log', 'Highly flammable!', 5, 0, 15.00, 2, 2, 0);
INSERT INTO `OnlineRetailDB`.`Product` (`product_id`, `name`, `description`, `stock`, `vendor`, `price`, `product_category`, `qa_rep`, `supplier`) VALUES (0, 'Portable Charger', 'Long lasting charge!', 20, 2, 20.45, 3, 3, NULL);
INSERT INTO `OnlineRetailDB`.`Product` (`product_id`, `name`, `description`, `stock`, `vendor`, `price`, `product_category`, `qa_rep`, `supplier`) VALUES (0, 'Socks', 'test', 30, NULL, 20.50, 4, NULL, NULL);
INSERT INTO `OnlineRetailDB`.`Product` (`product_id`, `name`, `description`, `stock`, `vendor`, `price`, `product_category`, `qa_rep`, `supplier`) VALUES (0, 'Sandals', 'test', 30, NULL, 21, 4, NULL, NULL);
INSERT INTO `OnlineRetailDB`.`Product` (`product_id`, `name`, `description`, `stock`, `vendor`, `price`, `product_category`, `qa_rep`, `supplier`) VALUES (0, 'Shoes', 'test', 30, NULL, 22, 4, NULL, NULL);
INSERT INTO `OnlineRetailDB`.`Product` (`product_id`, `name`, `description`, `stock`, `vendor`, `price`, `product_category`, `qa_rep`, `supplier`) VALUES (0, 'Hat', 'test', 30, NULL, 19, 5, NULL, NULL);
INSERT INTO `OnlineRetailDB`.`Product` (`product_id`, `name`, `description`, `stock`, `vendor`, `price`, `product_category`, `qa_rep`, `supplier`) VALUES (0, 'Tie', 'test', 30, NULL, 16, 5, NULL, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `OnlineRetailDB`.`VendorExpense`
-- -----------------------------------------------------
START TRANSACTION;
USE `OnlineRetailDB`;
INSERT INTO `OnlineRetailDB`.`VendorExpense` (`vexpense_id`, `amount`, `description`, `date_paid`, `vendor`) VALUES (0, 2500, 'Contract cost', '2004-06-18', 0);
INSERT INTO `OnlineRetailDB`.`VendorExpense` (`vexpense_id`, `amount`, `description`, `date_paid`, `vendor`) VALUES (0, 1000, 'Materials', '2018-09-02', 1);
INSERT INTO `OnlineRetailDB`.`VendorExpense` (`vexpense_id`, `amount`, `description`, `date_paid`, `vendor`) VALUES (0, 30000, 'Court settlement', '2008-12-12', 2);

COMMIT;


-- -----------------------------------------------------
-- Data for table `OnlineRetailDB`.`SupplierExpense`
-- -----------------------------------------------------
START TRANSACTION;
USE `OnlineRetailDB`;
INSERT INTO `OnlineRetailDB`.`SupplierExpense` (`sexpense_id`, `amount`, `description`, `date_paid`, `supplier`) VALUES (0, 2600, 'materials', '2022-10-10', 0);
INSERT INTO `OnlineRetailDB`.`SupplierExpense` (`sexpense_id`, `amount`, `description`, `date_paid`, `supplier`) VALUES (0, 1700, 'wood and lumber', '2021-10-10', 1);
INSERT INTO `OnlineRetailDB`.`SupplierExpense` (`sexpense_id`, `amount`, `description`, `date_paid`, `supplier`) VALUES (0, 3400, 'copper wire', '2020-10-10', 2);

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
INSERT INTO `OnlineRetailDB`.`CartItem` (`item_id`, `quantity`, `added_at`, `shopping_session`, `product`) VALUES (0, 23, '2022-10-11T00:00:00+00:00', 0, 1);
INSERT INTO `OnlineRetailDB`.`CartItem` (`item_id`, `quantity`, `added_at`, `shopping_session`, `product`) VALUES (1, 1, '2022-11-07T00:00:00+00:00', 1, 2);
INSERT INTO `OnlineRetailDB`.`CartItem` (`item_id`, `quantity`, `added_at`, `shopping_session`, `product`) VALUES (2, 7, '2022-12-16T00:00:00+00:00', 2, 3);
INSERT INTO `OnlineRetailDB`.`CartItem` (`item_id`, `quantity`, `added_at`, `shopping_session`, `product`) VALUES (3, 15, '2022-12-16T00:00:00+00:00', 1, 4);

COMMIT;


-- -----------------------------------------------------
-- Data for table `OnlineRetailDB`.`Review`
-- -----------------------------------------------------
START TRANSACTION;
USE `OnlineRetailDB`;
INSERT INTO `OnlineRetailDB`.`Review` (`review_id`, `description`, `created_at`, `user`, `product`, `score`) VALUES (0, 'terrible', '2022-10-20', 0, 1, 1);
INSERT INTO `OnlineRetailDB`.`Review` (`review_id`, `description`, `created_at`, `user`, `product`, `score`) VALUES (1, 'great', '2018-05-07', 1, 2, 5);
INSERT INTO `OnlineRetailDB`.`Review` (`review_id`, `description`, `created_at`, `user`, `product`, `score`) VALUES (2, 'durable', '2019-07-09', 2, 3, 4);
INSERT INTO `OnlineRetailDB`.`Review` (`review_id`, `description`, `created_at`, `user`, `product`, `score`) VALUES (3, 'bad', '2019-07-09', 3, 1, 2);
INSERT INTO `OnlineRetailDB`.`Review` (`review_id`, `description`, `created_at`, `user`, `product`, `score`) VALUES (4, 'awful', '2019-07-09', 4, 1, 1);
INSERT INTO `OnlineRetailDB`.`Review` (`review_id`, `description`, `created_at`, `user`, `product`, `score`) VALUES (5, 'ok', '2019-07-09', 5, 1, 3);
INSERT INTO `OnlineRetailDB`.`Review` (`review_id`, `description`, `created_at`, `user`, `product`, `score`) VALUES (6, 'ok', '2019-07-09', 6, 2, 3);
INSERT INTO `OnlineRetailDB`.`Review` (`review_id`, `description`, `created_at`, `user`, `product`, `score`) VALUES (7, 'great', '2019-07-09', 7, 2, 4);
INSERT INTO `OnlineRetailDB`.`Review` (`review_id`, `description`, `created_at`, `user`, `product`, `score`) VALUES (8, 'excellent', '2019-07-09', 8, 2, 5);
INSERT INTO `OnlineRetailDB`.`Review` (`review_id`, `description`, `created_at`, `user`, `product`, `score`) VALUES (9, 'great', '2019-07-09', 9, 2, 4);
INSERT INTO `OnlineRetailDB`.`Review` (`review_id`, `description`, `created_at`, `user`, `product`, `score`) VALUES (10, 'great', '2019-07-09', 10, 3, 4);

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
INSERT INTO `OnlineRetailDB`.`OrderDetail` (`order_id`, `total`, `created_at`, `user`, `delivery_option`, `distribution_center`, `courier_service`, `packaging_service`, `payment_information`) VALUES (0, 100.5, '2020-08-17T00:00:00+00:00', 1, 1, 1, 1, 1, 1);
INSERT INTO `OnlineRetailDB`.`OrderDetail` (`order_id`, `total`, `created_at`, `user`, `delivery_option`, `distribution_center`, `courier_service`, `packaging_service`, `payment_information`) VALUES (0, 90.77, '2019-09-13T00:00:00+00:00', 2, 2, 2, 2, 2, 2);
INSERT INTO `OnlineRetailDB`.`OrderDetail` (`order_id`, `total`, `created_at`, `user`, `delivery_option`, `distribution_center`, `courier_service`, `packaging_service`, `payment_information`) VALUES (0, 25, '2019-09-13T00:00:00+00:00', 3, 0, 0, 0, 0, 0);
INSERT INTO `OnlineRetailDB`.`OrderDetail` (`order_id`, `total`, `created_at`, `user`, `delivery_option`, `distribution_center`, `courier_service`, `packaging_service`, `payment_information`) VALUES (0, 30, '2019-09-13T00:00:00+00:00', 4, 0, 1, 1, 1, 1);
INSERT INTO `OnlineRetailDB`.`OrderDetail` (`order_id`, `total`, `created_at`, `user`, `delivery_option`, `distribution_center`, `courier_service`, `packaging_service`, `payment_information`) VALUES (0, 35, '2019-09-13T00:00:00+00:00', 5, 0, 2, 2, 2, 2);
INSERT INTO `OnlineRetailDB`.`OrderDetail` (`order_id`, `total`, `created_at`, `user`, `delivery_option`, `distribution_center`, `courier_service`, `packaging_service`, `payment_information`) VALUES (0, 40, '2019-09-13T00:00:00+00:00', 6, 1, 0, 0, 0, 0);
INSERT INTO `OnlineRetailDB`.`OrderDetail` (`order_id`, `total`, `created_at`, `user`, `delivery_option`, `distribution_center`, `courier_service`, `packaging_service`, `payment_information`) VALUES (0, 45, '2019-09-13T00:00:00+00:00', 7, 1, 1, 1, 1, 1);
INSERT INTO `OnlineRetailDB`.`OrderDetail` (`order_id`, `total`, `created_at`, `user`, `delivery_option`, `distribution_center`, `courier_service`, `packaging_service`, `payment_information`) VALUES (0, 50, '2019-09-13T00:00:00+00:00', 8, 2, 2, 2, 2, 2);

COMMIT;


-- -----------------------------------------------------
-- Data for table `OnlineRetailDB`.`OrderItem`
-- -----------------------------------------------------
START TRANSACTION;
USE `OnlineRetailDB`;
INSERT INTO `OnlineRetailDB`.`OrderItem` (`item_order_id`, `quantity`, `created_at`, `orderDetail`, `product`) VALUES (0, 6, '2022-10-22T00:00:00+00:00', 1, 1);
INSERT INTO `OnlineRetailDB`.`OrderItem` (`item_order_id`, `quantity`, `created_at`, `orderDetail`, `product`) VALUES (0, 4, '2022-10-21T00:00:00+00:00', 2, 2);
INSERT INTO `OnlineRetailDB`.`OrderItem` (`item_order_id`, `quantity`, `created_at`, `orderDetail`, `product`) VALUES (0, 7, '2022-10-20T00:00:00+00:00', 3, 3);
INSERT INTO `OnlineRetailDB`.`OrderItem` (`item_order_id`, `quantity`, `created_at`, `orderDetail`, `product`) VALUES (0, 9, '2022-10-20T00:00:00+00:00', 4, 4);
INSERT INTO `OnlineRetailDB`.`OrderItem` (`item_order_id`, `quantity`, `created_at`, `orderDetail`, `product`) VALUES (0, 24, '2022-10-20T00:00:00+00:00', 5, 5);
INSERT INTO `OnlineRetailDB`.`OrderItem` (`item_order_id`, `quantity`, `created_at`, `orderDetail`, `product`) VALUES (0, 1, '2022-10-20T00:00:00+00:00', 6, 6);
INSERT INTO `OnlineRetailDB`.`OrderItem` (`item_order_id`, `quantity`, `created_at`, `orderDetail`, `product`) VALUES (0, 3, '2022-10-20T00:00:00+00:00', 7, 7);

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
INSERT INTO `OnlineRetailDB`.`CustomerServiceRep` (`service_rep_id`, `returns_handled`, `errors`, `office_worker`) VALUES (0, 245, 1, 1);
INSERT INTO `OnlineRetailDB`.`CustomerServiceRep` (`service_rep_id`, `returns_handled`, `errors`, `office_worker`) VALUES (0, 3000, 300, 2);
INSERT INTO `OnlineRetailDB`.`CustomerServiceRep` (`service_rep_id`, `returns_handled`, `errors`, `office_worker`) VALUES (0, 50, 1, 3);

COMMIT;


-- -----------------------------------------------------
-- Data for table `OnlineRetailDB`.`OrderReturn`
-- -----------------------------------------------------
START TRANSACTION;
USE `OnlineRetailDB`;
INSERT INTO `OnlineRetailDB`.`OrderReturn` (`return_id`, `description`, `created_at`, `reason`, `cust_service_rep`, `user`, `orderDetail`) VALUES (0, 'low quality', '2022-10-14', 0, 1, 0, 1);
INSERT INTO `OnlineRetailDB`.`OrderReturn` (`return_id`, `description`, `created_at`, `reason`, `cust_service_rep`, `user`, `orderDetail`) VALUES (1, 'not what I expected', '2022-03-21', 1, 2, 1, 2);
INSERT INTO `OnlineRetailDB`.`OrderReturn` (`return_id`, `description`, `created_at`, `reason`, `cust_service_rep`, `user`, `orderDetail`) VALUES (2, 'broke very quickly', '2021-04-29', 2, 3, 2, 3);
INSERT INTO `OnlineRetailDB`.`OrderReturn` (`return_id`, `description`, `created_at`, `reason`, `cust_service_rep`, `user`, `orderDetail`) VALUES (3, 'broke very quickly', '2021-04-29', 2, 3, 2, 4);
INSERT INTO `OnlineRetailDB`.`OrderReturn` (`return_id`, `description`, `created_at`, `reason`, `cust_service_rep`, `user`, `orderDetail`) VALUES (4, 'broke very quickly', '2021-04-29', 2, 3, 2, 5);
INSERT INTO `OnlineRetailDB`.`OrderReturn` (`return_id`, `description`, `created_at`, `reason`, `cust_service_rep`, `user`, `orderDetail`) VALUES (5, 'broke very quickly', '2021-04-29', 2, 3, 2, 6);

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
INSERT INTO `OnlineRetailDB`.`CourierExpense` (`cexpense_id`, `amount`, `description`, `paid_on`, `courier_service`) VALUES (0, 4000, 'contract renewal', '2021-07-09', 1);
INSERT INTO `OnlineRetailDB`.`CourierExpense` (`cexpense_id`, `amount`, `description`, `paid_on`, `courier_service`) VALUES (0, 6000, 'annual payment', '2022-09-12', 2);

COMMIT;


-- -----------------------------------------------------
-- Data for table `OnlineRetailDB`.`PackagingExpense`
-- -----------------------------------------------------
START TRANSACTION;
USE `OnlineRetailDB`;
INSERT INTO `OnlineRetailDB`.`PackagingExpense` (`pexpense_id`, `amount`, `description`, `paid_on`, `packaging_service`) VALUES (0, 1500, 'Packaging Tape', '2022-10-10', 0);
INSERT INTO `OnlineRetailDB`.`PackagingExpense` (`pexpense_id`, `amount`, `description`, `paid_on`, `packaging_service`) VALUES (0, 7430, 'Bubblewrap', '2014-10-14', 1);
INSERT INTO `OnlineRetailDB`.`PackagingExpense` (`pexpense_id`, `amount`, `description`, `paid_on`, `packaging_service`) VALUES (0, 90000, 'Cardboard packaging', '2023-10-09', 2);

COMMIT;


-- -----------------------------------------------------
-- Data for table `OnlineRetailDB`.`Address`
-- -----------------------------------------------------
START TRANSACTION;
USE `OnlineRetailDB`;
INSERT INTO `OnlineRetailDB`.`Address` (`address_id`, `street`, `zipcode`, `city`, `state`) VALUES (0, '2323 El Camino Rd', 95042, 'Adustro', 'California');
INSERT INTO `OnlineRetailDB`.`Address` (`address_id`, `street`, `zipcode`, `city`, `state`) VALUES (0, '1400 Border Ln', 15853, 'Corpal', 'Alaska');
INSERT INTO `OnlineRetailDB`.`Address` (`address_id`, `street`, `zipcode`, `city`, `state`) VALUES (0, '1594 Signal Blvd', 25058, 'Lakeshore', 'Utah');
INSERT INTO `OnlineRetailDB`.`Address` (`address_id`, `street`, `zipcode`, `city`, `state`) VALUES (0, '1594 Signal Blvd', 25058, 'Santa Fe', 'Utah');
INSERT INTO `OnlineRetailDB`.`Address` (`address_id`, `street`, `zipcode`, `city`, `state`) VALUES (0, '1594 Signal Blvd', 25058, 'Santa Fe', 'California');
INSERT INTO `OnlineRetailDB`.`Address` (`address_id`, `street`, `zipcode`, `city`, `state`) VALUES (0, '1594 Signal Blvd', 25058, 'Santa Fe', 'California');
INSERT INTO `OnlineRetailDB`.`Address` (`address_id`, `street`, `zipcode`, `city`, `state`) VALUES (0, '1594 Signal Blvd', 25058, 'Santa Fe', 'California');
INSERT INTO `OnlineRetailDB`.`Address` (`address_id`, `street`, `zipcode`, `city`, `state`) VALUES (0, '1594 Signal Blvd', 25058, 'Santa Fe', 'Utah');
INSERT INTO `OnlineRetailDB`.`Address` (`address_id`, `street`, `zipcode`, `city`, `state`) VALUES (0, '1594 Signal Blvd', 25058, 'Santa Fe', 'Kansas');

COMMIT;


-- -----------------------------------------------------
-- Data for table `OnlineRetailDB`.`UserAddress`
-- -----------------------------------------------------
START TRANSACTION;
USE `OnlineRetailDB`;
INSERT INTO `OnlineRetailDB`.`UserAddress` (`u_address_id`, `user`, `address`) VALUES (0, 0, 1);
INSERT INTO `OnlineRetailDB`.`UserAddress` (`u_address_id`, `user`, `address`) VALUES (0, 1, 2);
INSERT INTO `OnlineRetailDB`.`UserAddress` (`u_address_id`, `user`, `address`) VALUES (0, 2, 3);
INSERT INTO `OnlineRetailDB`.`UserAddress` (`u_address_id`, `user`, `address`) VALUES (DEFAULT, 3, 4);
INSERT INTO `OnlineRetailDB`.`UserAddress` (`u_address_id`, `user`, `address`) VALUES (DEFAULT, 4, 5);
INSERT INTO `OnlineRetailDB`.`UserAddress` (`u_address_id`, `user`, `address`) VALUES (DEFAULT, 5, 6);
INSERT INTO `OnlineRetailDB`.`UserAddress` (`u_address_id`, `user`, `address`) VALUES (DEFAULT, 6, 7);
INSERT INTO `OnlineRetailDB`.`UserAddress` (`u_address_id`, `user`, `address`) VALUES (DEFAULT, 7, 8);

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
INSERT INTO `OnlineRetailDB`.`Membership` (`membership_id`, `start_date`, `expiry_date`, `user`) VALUES (3, '2022-11-14', '2024-10-24', 3);
INSERT INTO `OnlineRetailDB`.`Membership` (`membership_id`, `start_date`, `expiry_date`, `user`) VALUES (4, '2022-11-14', '2024-10-24', 4);
INSERT INTO `OnlineRetailDB`.`Membership` (`membership_id`, `start_date`, `expiry_date`, `user`) VALUES (5, '2022-11-14', '2024-10-24', 5);
INSERT INTO `OnlineRetailDB`.`Membership` (`membership_id`, `start_date`, `expiry_date`, `user`) VALUES (6, '2022-11-14', '2024-10-24', 6);
INSERT INTO `OnlineRetailDB`.`Membership` (`membership_id`, `start_date`, `expiry_date`, `user`) VALUES (7, '2022-11-14', '2024-10-24', 7);
INSERT INTO `OnlineRetailDB`.`Membership` (`membership_id`, `start_date`, `expiry_date`, `user`) VALUES (8, '2022-11-14', '2024-10-24', 8);

COMMIT;


-- -----------------------------------------------------
-- Data for table `OnlineRetailDB`.`PPCManager`
-- -----------------------------------------------------
START TRANSACTION;
USE `OnlineRetailDB`;
INSERT INTO `OnlineRetailDB`.`PPCManager` (`manager_id`, `channels_handled`, `total_clicks`, `office_worker`) VALUES (0, 1, 500, 1);
INSERT INTO `OnlineRetailDB`.`PPCManager` (`manager_id`, `channels_handled`, `total_clicks`, `office_worker`) VALUES (0, 1, 2500, 2);
INSERT INTO `OnlineRetailDB`.`PPCManager` (`manager_id`, `channels_handled`, `total_clicks`, `office_worker`) VALUES (0, 1, 5060, 3);

COMMIT;


-- -----------------------------------------------------
-- Data for table `OnlineRetailDB`.`AdvertisingChannel`
-- -----------------------------------------------------
START TRANSACTION;
USE `OnlineRetailDB`;
INSERT INTO `OnlineRetailDB`.`AdvertisingChannel` (`channel_id`, `channel_name`, `cost`, `clicks`, `contract_start`, `contract_end`, `manager`) VALUES (0, 'Facebook', 20000, 1500, '2019-10-24', '2023-01-01', 1);
INSERT INTO `OnlineRetailDB`.`AdvertisingChannel` (`channel_id`, `channel_name`, `cost`, `clicks`, `contract_start`, `contract_end`, `manager`) VALUES (1, 'Instagram', 50000, 700, '2020-12-14', '2024-01-01', 2);
INSERT INTO `OnlineRetailDB`.`AdvertisingChannel` (`channel_id`, `channel_name`, `cost`, `clicks`, `contract_start`, `contract_end`, `manager`) VALUES (2, 'Google', 80000, 9000, '2018-07-10', '2025-01-01', 3);

COMMIT;


-- -----------------------------------------------------
-- Data for table `OnlineRetailDB`.`MarketingSpecialist`
-- -----------------------------------------------------
START TRANSACTION;
USE `OnlineRetailDB`;
INSERT INTO `OnlineRetailDB`.`MarketingSpecialist` (`specialist_id`, `partnerships_handled`, `total_cost`, `office_worker`) VALUES (0, 1, 29456, 1);
INSERT INTO `OnlineRetailDB`.`MarketingSpecialist` (`specialist_id`, `partnerships_handled`, `total_cost`, `office_worker`) VALUES (1, 2, 19259, 2);
INSERT INTO `OnlineRetailDB`.`MarketingSpecialist` (`specialist_id`, `partnerships_handled`, `total_cost`, `office_worker`) VALUES (2, 1, 24844, 3);

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
INSERT INTO `OnlineRetailDB`.`Expense` (`expense_id`, `category`, `amount`) VALUES (0, 'Courier', 2495);
INSERT INTO `OnlineRetailDB`.`Expense` (`expense_id`, `category`, `amount`) VALUES (0, 'Supplier', 30000);

COMMIT;


-- -----------------------------------------------------
-- Data for table `OnlineRetailDB`.`ExpenseIncurred`
-- -----------------------------------------------------
START TRANSACTION;
USE `OnlineRetailDB`;
INSERT INTO `OnlineRetailDB`.`ExpenseIncurred` (`expense_incurred_id`, `vexpense`, `sexpense`, `cexpense`, `pexpense`) VALUES (0, NULL, NULL, NULL, 1);
INSERT INTO `OnlineRetailDB`.`ExpenseIncurred` (`expense_incurred_id`, `vexpense`, `sexpense`, `cexpense`, `pexpense`) VALUES (0, NULL, NULL, 2, NULL);
INSERT INTO `OnlineRetailDB`.`ExpenseIncurred` (`expense_incurred_id`, `vexpense`, `sexpense`, `cexpense`, `pexpense`) VALUES (0, NULL, 1, NULL, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `OnlineRetailDB`.`ProcessedOrder`
-- -----------------------------------------------------
START TRANSACTION;
USE `OnlineRetailDB`;
INSERT INTO `OnlineRetailDB`.`ProcessedOrder` (`p_order_id`, `worker_id`, `order_id`, `date_processed`) VALUES (0, 0, 1, '2020-10-10');
INSERT INTO `OnlineRetailDB`.`ProcessedOrder` (`p_order_id`, `worker_id`, `order_id`, `date_processed`) VALUES (1, 1, 2, '2019-07-07');
INSERT INTO `OnlineRetailDB`.`ProcessedOrder` (`p_order_id`, `worker_id`, `order_id`, `date_processed`) VALUES (2, 2, 3, '2019-05-05');
INSERT INTO `OnlineRetailDB`.`ProcessedOrder` (`p_order_id`, `worker_id`, `order_id`, `date_processed`) VALUES (3, 0, 4, '2019-05-05');
INSERT INTO `OnlineRetailDB`.`ProcessedOrder` (`p_order_id`, `worker_id`, `order_id`, `date_processed`) VALUES (4, 0, 5, '2019-05-05');
INSERT INTO `OnlineRetailDB`.`ProcessedOrder` (`p_order_id`, `worker_id`, `order_id`, `date_processed`) VALUES (5, 0, 6, '2019-05-05');
INSERT INTO `OnlineRetailDB`.`ProcessedOrder` (`p_order_id`, `worker_id`, `order_id`, `date_processed`) VALUES (6, 1, 7, '2019-05-05');
INSERT INTO `OnlineRetailDB`.`ProcessedOrder` (`p_order_id`, `worker_id`, `order_id`, `date_processed`) VALUES (7, 1, 8, '2019-05-05');

COMMIT;


-- -----------------------------------------------------
-- Data for table `OnlineRetailDB`.`ProductReturns`
-- -----------------------------------------------------
START TRANSACTION;
USE `OnlineRetailDB`;
INSERT INTO `OnlineRetailDB`.`ProductReturns` (`product_return_id`, `product`, `return`) VALUES (0, 1, 0);
INSERT INTO `OnlineRetailDB`.`ProductReturns` (`product_return_id`, `product`, `return`) VALUES (1, 2, 1);
INSERT INTO `OnlineRetailDB`.`ProductReturns` (`product_return_id`, `product`, `return`) VALUES (2, 3, 2);

COMMIT;

