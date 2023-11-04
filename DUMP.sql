SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema CRM2
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema CRM2
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `CRM2` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `CRM2` ;

-- -----------------------------------------------------
-- Table `CRM2`.`Department`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CRM2`.`Department` (
  `DepartID` INT NOT NULL AUTO_INCREMENT,
  `ManagerID` INT NULL DEFAULT NULL,
  `DepartName` VARCHAR(25) NULL DEFAULT NULL,
  PRIMARY KEY (`DepartID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `CRM2`.`Employee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CRM2`.`Employee` (
  `EmployeeID` INT NOT NULL AUTO_INCREMENT,
  `EmpFName` VARCHAR(20) NULL DEFAULT NULL,
  `EmpLName` VARCHAR(20) NULL DEFAULT NULL,
  `DOB` DATE NULL DEFAULT NULL,
  `MobileNum` CHAR(10) NULL DEFAULT NULL,
  `Landline` CHAR(10) NULL DEFAULT NULL,
  `Ext` VARCHAR(4) NULL DEFAULT NULL,
  `DepartID` INT NULL DEFAULT NULL,
  `HireDate` DATE NULL DEFAULT NULL,
  `ExitDate` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`EmployeeID`),
  INDEX `DepartID` (`DepartID` ASC) VISIBLE,
  CONSTRAINT `Employee_ibfk_1`
    FOREIGN KEY (`DepartID`)
    REFERENCES `CRM2`.`Department` (`DepartID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `CRM2`.`Locations`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CRM2`.`Locations` (
  `LocationID` INT NOT NULL AUTO_INCREMENT,
  `Address1` VARCHAR(100) NULL DEFAULT NULL,
  `Address2` VARCHAR(25) NULL DEFAULT NULL,
  `City` VARCHAR(50) NULL DEFAULT NULL,
  `Province` VARCHAR(50) NULL DEFAULT NULL,
  `ZIP` VARCHAR(10) NULL DEFAULT NULL,
  `Country` VARCHAR(60) NULL DEFAULT NULL,
  `Continent` VARCHAR(13) NULL DEFAULT NULL,
  PRIMARY KEY (`LocationID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `CRM2`.`CustomerType`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CRM2`.`CustomerType` (
  `CuTypeID` INT NOT NULL AUTO_INCREMENT,
  `CuType` VARCHAR(25) NULL DEFAULT NULL,
  PRIMARY KEY (`CuTypeID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `CRM2`.`Company`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CRM2`.`Company` (
  `CompanyID` INT NOT NULL AUTO_INCREMENT,
  `CompanyName` VARCHAR(25) NULL DEFAULT NULL,
  `YearEst` DATE NULL DEFAULT NULL,
  `LocationID` INT NULL DEFAULT NULL,
  PRIMARY KEY (`CompanyID`),
  INDEX `LocationID` (`LocationID` ASC) VISIBLE,
  CONSTRAINT `Company_ibfk_1`
    FOREIGN KEY (`LocationID`)
    REFERENCES `CRM2`.`Locations` (`LocationID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `CRM2`.`Customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CRM2`.`Customer` (
  `CustomerID` INT NOT NULL AUTO_INCREMENT,
  `CustFName` VARCHAR(20) NULL DEFAULT NULL,
  `CustLName` VARCHAR(20) NULL DEFAULT NULL,
  `Gender` CHAR(1) NULL DEFAULT NULL,
  `DOB` DATE NULL DEFAULT NULL,
  `Ethnicity` VARCHAR(15) NULL DEFAULT NULL,
  `MobileNum` CHAR(10) NULL DEFAULT NULL,
  `Email` VARCHAR(100) NULL DEFAULT NULL,
  `LocationID` INT NULL DEFAULT NULL,
  `CuOwner` INT NULL DEFAULT NULL,
  `CuType` INT NULL DEFAULT NULL,
  `CompanyID` INT NULL DEFAULT NULL,
  PRIMARY KEY (`CustomerID`),
  INDEX `LocationID` (`LocationID` ASC) VISIBLE,
  INDEX `CuOwner` (`CuOwner` ASC) VISIBLE,
  INDEX `CuType` (`CuType` ASC) VISIBLE,
  INDEX `CompanyID` (`CompanyID` ASC) VISIBLE,
  CONSTRAINT `Customer_ibfk_1`
    FOREIGN KEY (`LocationID`)
    REFERENCES `CRM2`.`Locations` (`LocationID`),
  CONSTRAINT `Customer_ibfk_2`
    FOREIGN KEY (`CuOwner`)
    REFERENCES `CRM2`.`Employee` (`EmployeeID`),
  CONSTRAINT `Customer_ibfk_3`
    FOREIGN KEY (`CuType`)
    REFERENCES `CRM2`.`CustomerType` (`CuTypeID`),
  CONSTRAINT `Customer_ibfk_4`
    FOREIGN KEY (`CompanyID`)
    REFERENCES `CRM2`.`Company` (`CompanyID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `CRM2`.`Activity`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CRM2`.`Activity` (
  `ActivityID` INT NOT NULL AUTO_INCREMENT,
  `ActivityType` VARCHAR(50) NULL DEFAULT NULL,
  `ActivityDate` DATETIME NULL DEFAULT NULL,
  `Notes` TEXT NULL DEFAULT NULL,
  `EmployeeID` INT NULL DEFAULT NULL,
  `CustomerID` INT NULL DEFAULT NULL,
  PRIMARY KEY (`ActivityID`),
  INDEX `EmployeeID` (`EmployeeID` ASC) VISIBLE,
  INDEX `CustomerID` (`CustomerID` ASC) VISIBLE,
  CONSTRAINT `Activity_ibfk_1`
    FOREIGN KEY (`EmployeeID`)
    REFERENCES `CRM2`.`Employee` (`EmployeeID`),
  CONSTRAINT `Activity_ibfk_2`
    FOREIGN KEY (`CustomerID`)
    REFERENCES `CRM2`.`Customer` (`CustomerID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `CRM2`.`Communication`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CRM2`.`Communication` (
  `CommunicationID` INT NOT NULL AUTO_INCREMENT,
  `EmployeeID` INT NULL DEFAULT NULL,
  `CustomerID` INT NULL DEFAULT NULL,
  `CommunicationDateTime` DATETIME NULL DEFAULT NULL,
  `CommunicationType` VARCHAR(50) NULL DEFAULT NULL,
  `Content` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`CommunicationID`),
  INDEX `EmployeeID` (`EmployeeID` ASC) VISIBLE,
  INDEX `CustomerID` (`CustomerID` ASC) VISIBLE,
  CONSTRAINT `Communication_ibfk_1`
    FOREIGN KEY (`EmployeeID`)
    REFERENCES `CRM2`.`Employee` (`EmployeeID`),
  CONSTRAINT `Communication_ibfk_2`
    FOREIGN KEY (`CustomerID`)
    REFERENCES `CRM2`.`Customer` (`CustomerID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `CRM2`.`Feedback`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CRM2`.`Feedback` (
  `FeedbackID` INT NOT NULL AUTO_INCREMENT,
  `CustomerID` INT NULL DEFAULT NULL,
  `EmployeeID` INT NULL DEFAULT NULL,
  `FeedbackDateTime` DATETIME NULL DEFAULT NULL,
  `Rating` INT NULL DEFAULT NULL,
  `Comments` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`FeedbackID`),
  INDEX `CustomerID` (`CustomerID` ASC) VISIBLE,
  INDEX `EmployeeID` (`EmployeeID` ASC) VISIBLE,
  CONSTRAINT `Feedback_ibfk_1`
    FOREIGN KEY (`CustomerID`)
    REFERENCES `CRM2`.`Customer` (`CustomerID`),
  CONSTRAINT `Feedback_ibfk_2`
    FOREIGN KEY (`EmployeeID`)
    REFERENCES `CRM2`.`Employee` (`EmployeeID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `CRM2`.`Invoice`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CRM2`.`Invoice` (
  `InvoiceID` INT NOT NULL AUTO_INCREMENT,
  `CustomerID` INT NULL DEFAULT NULL,
  `InvoiceDate` DATE NULL DEFAULT NULL,
  `DueDate` DATE NULL DEFAULT NULL,
  `TotalAmount` DECIMAL(10,2) NULL DEFAULT NULL,
  `Status` VARCHAR(50) NULL DEFAULT NULL,
  PRIMARY KEY (`InvoiceID`),
  INDEX `CustomerID` (`CustomerID` ASC) VISIBLE,
  CONSTRAINT `Invoice_ibfk_1`
    FOREIGN KEY (`CustomerID`)
    REFERENCES `CRM2`.`Customer` (`CustomerID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `CRM2`.`Opportunity`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CRM2`.`Opportunity` (
  `OpportunityID` INT NOT NULL AUTO_INCREMENT,
  `CustomerID` INT NULL DEFAULT NULL,
  `EmployeeID` INT NULL DEFAULT NULL,
  `Status` VARCHAR(50) NULL DEFAULT NULL,
  `ExpectedCloseDate` DATE NULL DEFAULT NULL,
  `Amount` DECIMAL(10,2) NULL DEFAULT NULL,
  PRIMARY KEY (`OpportunityID`),
  INDEX `CustomerID` (`CustomerID` ASC) VISIBLE,
  INDEX `EmployeeID` (`EmployeeID` ASC) VISIBLE,
  CONSTRAINT `Opportunity_ibfk_1`
    FOREIGN KEY (`CustomerID`)
    REFERENCES `CRM2`.`Customer` (`CustomerID`),
  CONSTRAINT `Opportunity_ibfk_2`
    FOREIGN KEY (`EmployeeID`)
    REFERENCES `CRM2`.`Employee` (`EmployeeID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `CRM2`.`Payment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CRM2`.`Payment` (
  `PaymentID` INT NOT NULL AUTO_INCREMENT,
  `InvoiceID` INT NULL DEFAULT NULL,
  `PaymentDate` DATE NULL DEFAULT NULL,
  `Amount` DECIMAL(10,2) NULL DEFAULT NULL,
  `PaymentMethod` VARCHAR(50) NULL DEFAULT NULL,
  PRIMARY KEY (`PaymentID`),
  INDEX `InvoiceID` (`InvoiceID` ASC) VISIBLE,
  CONSTRAINT `Payment_ibfk_1`
    FOREIGN KEY (`InvoiceID`)
    REFERENCES `CRM2`.`Invoice` (`InvoiceID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `CRM2`.`Product`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CRM2`.`Product` (
  `ProductID` INT NOT NULL AUTO_INCREMENT,
  `ProductName` VARCHAR(20) NULL DEFAULT NULL,
  `ProductColor` VARCHAR(30) NULL DEFAULT NULL,
  `ProductPrice` DECIMAL(10,2) NULL DEFAULT NULL,
  PRIMARY KEY (`ProductID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `CRM2`.`Sale`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CRM2`.`Sale` (
  `SaleID` INT NOT NULL AUTO_INCREMENT,
  `CustomerID` INT NULL DEFAULT NULL,
  `SaleDate` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`SaleID`),
  INDEX `CustomerID` (`CustomerID` ASC) VISIBLE,
  CONSTRAINT `Sale_ibfk_1`
    FOREIGN KEY (`CustomerID`)
    REFERENCES `CRM2`.`Customer` (`CustomerID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `CRM2`.`SalesProducts`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CRM2`.`SalesProducts` (
  `SaleID` INT NOT NULL,
  `ProductID` INT NOT NULL,
  PRIMARY KEY (`SaleID`, `ProductID`),
  INDEX `ProductID` (`ProductID` ASC) VISIBLE,
  CONSTRAINT `SalesProducts_ibfk_1`
    FOREIGN KEY (`SaleID`)
    REFERENCES `CRM2`.`Sale` (`SaleID`),
  CONSTRAINT `SalesProducts_ibfk_2`
    FOREIGN KEY (`ProductID`)
    REFERENCES `CRM2`.`Product` (`ProductID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `CRM2`.`Task`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CRM2`.`Task` (
  `TaskID` INT NOT NULL AUTO_INCREMENT,
  `ContactMode` VARCHAR(20) NULL DEFAULT NULL,
  `Memo` VARCHAR(500) NULL DEFAULT NULL,
  `StartTime` DATETIME NULL DEFAULT NULL,
  `EndTime` DATETIME NULL DEFAULT NULL,
  `EmpID` INT NULL DEFAULT NULL,
  `CustomerID` INT NULL DEFAULT NULL,
  PRIMARY KEY (`TaskID`),
  INDEX `EmpID` (`EmpID` ASC) VISIBLE,
  INDEX `CustomerID` (`CustomerID` ASC) VISIBLE,
  CONSTRAINT `Task_ibfk_1`
    FOREIGN KEY (`EmpID`)
    REFERENCES `CRM2`.`Employee` (`EmployeeID`),
  CONSTRAINT `Task_ibfk_2`
    FOREIGN KEY (`CustomerID`)
    REFERENCES `CRM2`.`Customer` (`CustomerID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
