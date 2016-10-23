SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

CREATE SCHEMA IF NOT EXISTS `Bamazon` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `Bamazon` ;

-- -----------------------------------------------------
-- Table `Bamazon`.`Department`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Bamazon`.`Department` ;

CREATE  TABLE IF NOT EXISTS `Bamazon`.`Department` (
  `departmentID` INT NOT NULL AUTO_INCREMENT ,
  `departmentName` VARCHAR(50) NULL ,
  `overheadCost` DECIMAL(19,4) NULL ,
  `totalSales` DECIMAL(19,4) NULL ,
  PRIMARY KEY (`departmentID`) ,
  UNIQUE INDEX `departmentID_UNIQUE` (`departmentID` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Bamazon`.`Products`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Bamazon`.`Products` ;

CREATE  TABLE IF NOT EXISTS `Bamazon`.`Products` (
  `itemID` INT NOT NULL AUTO_INCREMENT ,
  `productName` VARCHAR(50) NULL ,
  `departmentID` INT NULL ,
  `price` DECIMAL(19,4) NULL ,
  `stockQuantity` INT NULL ,
  PRIMARY KEY (`itemID`) ,
  UNIQUE INDEX `itemID_UNIQUE` (`itemID` ASC) ,
  INDEX `departmentID_idx` (`departmentID` ASC) ,
  CONSTRAINT `departmentID`
    FOREIGN KEY (`departmentID` )
    REFERENCES `Bamazon`.`Department` (`departmentID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `Bamazon` ;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
