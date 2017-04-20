-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema muebleria
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema muebleria
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `muebleria` DEFAULT CHARACTER SET utf8 ;
USE `muebleria` ;

-- -----------------------------------------------------
-- Table `muebleria`.`Almacen`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `muebleria`.`Almacen` (
  `idAlmacen` INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`idAlmacen`),
  UNIQUE INDEX `idAlmacen_UNIQUE` (`idAlmacen` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `muebleria`.`Mueble`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `muebleria`.`Mueble` (
  `idMueble` INT NOT NULL AUTO_INCREMENT,
  `nombreMueble` VARCHAR(45) NULL,
  `precioMueble` DOUBLE NULL,
  `tipoMueble` VARCHAR(45) NULL,
  `stockMinimoMueble` INT NULL,
  `baseMueble` DOUBLE NULL,
  `alturaMueble` DOUBLE NULL,
  `profundidadMueble` DOUBLE NULL,
  `colorMueble` VARCHAR(45) NULL,
  `materialMueble` VARCHAR(45) NULL,
  PRIMARY KEY (`idMueble`),
  UNIQUE INDEX `idMueble_UNIQUE` (`idMueble` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `muebleria`.`AlmacenGuardaMueble`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `muebleria`.`AlmacenGuardaMueble` (
  `Almacen_idAlmacen` INT NOT NULL,
  `Mueble_idMueble` INT NOT NULL,
  `existenciasAlmacen` INT NULL,
  INDEX `fk_Almacen-Guarda-Mueble_Almacen_idx` (`Almacen_idAlmacen` ASC),
  INDEX `fk_Almacen-Guarda-Mueble_Mueble1_idx` (`Mueble_idMueble` ASC),
  CONSTRAINT `fk_Almacen-Guarda-Mueble_Almacen`
    FOREIGN KEY (`Almacen_idAlmacen`)
    REFERENCES `muebleria`.`Almacen` (`idAlmacen`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Almacen-Guarda-Mueble_Mueble1`
    FOREIGN KEY (`Mueble_idMueble`)
    REFERENCES `muebleria`.`Mueble` (`idMueble`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `muebleria`.`Usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `muebleria`.`Usuario` (
  `idUsuario` INT NOT NULL AUTO_INCREMENT,
  `contrasenaUsuario` VARCHAR(45) NULL,
  PRIMARY KEY (`idUsuario`),
  UNIQUE INDEX `idUsuario_UNIQUE` (`idUsuario` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `muebleria`.`Empleado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `muebleria`.`Empleado` (
  `idEmpleado` INT NOT NULL AUTO_INCREMENT,
  `Usuario_idUsuario` INT NOT NULL,
  `nombreEmpleado` VARCHAR(45) NOT NULL,
  `apPaternoEmpleado` VARCHAR(45) NOT NULL,
  `apMaternoEmpleado` VARCHAR(45) NULL,
  `emailEmpleado` VARCHAR(45) NULL,
  `calleEmpleado` VARCHAR(45) NULL,
  `estadoEmpleado` VARCHAR(45) NULL,
  `ciudadEmpleado` VARCHAR(45) NULL,
  `coloniaEmpleado` VARCHAR(45) NULL,
  `telCasaEmpleado` INT NULL,
  `telCelularEmpleado` INT NULL,
  `fechaNacEmpleado` DATE NULL,
  PRIMARY KEY (`idEmpleado`),
  UNIQUE INDEX `idEmpleado_UNIQUE` (`idEmpleado` ASC),
  INDEX `fk_Empleado_Usuario1_idx` (`Usuario_idUsuario` ASC),
  CONSTRAINT `fk_Empleado_Usuario1`
    FOREIGN KEY (`Usuario_idUsuario`)
    REFERENCES `muebleria`.`Usuario` (`idUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `muebleria`.`Cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `muebleria`.`Cliente` (
  `idCliente` INT NOT NULL AUTO_INCREMENT,
  `nombreCliente` VARCHAR(45) NOT NULL,
  `apPaternoCliente` VARCHAR(45) NOT NULL,
  `apMaternoCliente` VARCHAR(45) NULL,
  `emailCliente` VARCHAR(45) NULL,
  `calleCliente` VARCHAR(45) NULL,
  `estadoCliente` VARCHAR(45) NULL,
  `ciudadCliente` VARCHAR(45) NULL,
  `coloniaCliente` VARCHAR(45) NULL,
  `telCasaCliente` INT NULL,
  `telCelularCliente` INT NULL,
  `fechaNacCliente` DATE NULL,
  UNIQUE INDEX `idCliente_UNIQUE` (`idCliente` ASC),
  PRIMARY KEY (`idCliente`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `muebleria`.`VentaContado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `muebleria`.`VentaContado` (
  `idVentaContado` INT NOT NULL AUTO_INCREMENT,
  `fechaVentaContado` DATE NULL,
  `Empleado_idEmpleado` INT NOT NULL,
  `Cliente_idCliente` INT NOT NULL,
  PRIMARY KEY (`idVentaContado`),
  UNIQUE INDEX `idVentaContado_UNIQUE` (`idVentaContado` ASC),
  INDEX `fk_VentaContado_Empleado1_idx` (`Empleado_idEmpleado` ASC),
  INDEX `fk_VentaContado_Cliente1_idx` (`Cliente_idCliente` ASC),
  CONSTRAINT `fk_VentaContado_Empleado1`
    FOREIGN KEY (`Empleado_idEmpleado`)
    REFERENCES `muebleria`.`Empleado` (`idEmpleado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_VentaContado_Cliente1`
    FOREIGN KEY (`Cliente_idCliente`)
    REFERENCES `muebleria`.`Cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `muebleria`.`MuebleSolicitaVentaContado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `muebleria`.`MuebleSolicitaVentaContado` (
  `cantidadVentaContado` DOUBLE NULL,
  `resguardoVentaContado` VARCHAR(45) NULL,
  `resguardoPendienteVentaCredito` VARCHAR(45) NULL,
  `Mueble_idMueble` INT NOT NULL,
  `VentaContado_idVentaContado` INT NOT NULL,
  INDEX `fk_Mueble-Solicita-VentaContado_Mueble1_idx` (`Mueble_idMueble` ASC),
  INDEX `fk_Mueble-Solicita-VentaContado_VentaContado1_idx` (`VentaContado_idVentaContado` ASC),
  CONSTRAINT `fk_Mueble-Solicita-VentaContado_Mueble1`
    FOREIGN KEY (`Mueble_idMueble`)
    REFERENCES `muebleria`.`Mueble` (`idMueble`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Mueble-Solicita-VentaContado_VentaContado1`
    FOREIGN KEY (`VentaContado_idVentaContado`)
    REFERENCES `muebleria`.`VentaContado` (`idVentaContado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `muebleria`.`Administrador`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `muebleria`.`Administrador` (
  `idAdministrador` INT NOT NULL AUTO_INCREMENT,
  `Usuario_idUsuario` INT NOT NULL,
  `nombreAdministrador` VARCHAR(45) NOT NULL,
  `apPaternoAdministrador` VARCHAR(45) NULL,
  `apMaternoAdministrador` VARCHAR(45) NULL,
  `emailAdministrador` VARCHAR(45) NULL,
  `calleAdministrador` VARCHAR(45) NULL,
  `estadoAdministrador` VARCHAR(45) NULL,
  `ciudadAdministrador` VARCHAR(45) NULL,
  `coloniaAdministrador` VARCHAR(45) NULL,
  `telCasaAdmnistrador` INT NULL,
  `telCelularAdministrador` INT NULL,
  `fechaNacAdministrador` DATE NULL,
  PRIMARY KEY (`idAdministrador`),
  UNIQUE INDEX `idAdministrador_UNIQUE` (`idAdministrador` ASC),
  INDEX `fk_Administrador_Usuario1_idx` (`Usuario_idUsuario` ASC),
  CONSTRAINT `fk_Administrador_Usuario1`
    FOREIGN KEY (`Usuario_idUsuario`)
    REFERENCES `muebleria`.`Usuario` (`idUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `muebleria`.`Proveedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `muebleria`.`Proveedor` (
  `idProveedor` INT NOT NULL AUTO_INCREMENT,
  `razonSocialProveedor` VARCHAR(45) NULL,
  `emailProveedor` VARCHAR(45) NULL,
  `calleProveedor` VARCHAR(45) NULL,
  `coloniaProveedor` VARCHAR(45) NULL,
  `ciudadProveedor` VARCHAR(45) NULL,
  `estadoProveedor` VARCHAR(45) NULL,
  `telefonoProveedor` VARCHAR(45) NULL,
  PRIMARY KEY (`idProveedor`),
  UNIQUE INDEX `idProveedor_UNIQUE` (`idProveedor` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `muebleria`.`Pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `muebleria`.`Pedido` (
  `idPedido` INT NOT NULL AUTO_INCREMENT,
  `detallePedido` VARCHAR(45) NULL,
  `cantidadPedido` INT NULL,
  `costoPedido` DOUBLE NULL,
  `fechaPedido` DATE NULL,
  `Proveedor_idProveedor` INT NOT NULL,
  `Administrador_idAdministrador` INT NOT NULL,
  PRIMARY KEY (`idPedido`),
  UNIQUE INDEX `idPedido_UNIQUE` (`idPedido` ASC),
  INDEX `fk_Pedido_Administrador2_idx` (`Administrador_idAdministrador` ASC),
  INDEX `fk_Pedido_Proveedor1_idx` (`Proveedor_idProveedor` ASC),
  CONSTRAINT `fk_Pedido_Administrador2`
    FOREIGN KEY (`Administrador_idAdministrador`)
    REFERENCES `muebleria`.`Administrador` (`idAdministrador`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pedido_Proveedor1`
    FOREIGN KEY (`Proveedor_idProveedor`)
    REFERENCES `muebleria`.`Proveedor` (`idProveedor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `muebleria`.`MuebleSolicitaPedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `muebleria`.`MuebleSolicitaPedido` (
  `Mueble_idMueble` INT NOT NULL,
  `Pedido_idPedido` INT NOT NULL,
  INDEX `fk_Mueble-Solicita-Pedido_Mueble1_idx` (`Mueble_idMueble` ASC),
  INDEX `fk_Mueble-Solicita-Pedido_Pedido1_idx` (`Pedido_idPedido` ASC),
  CONSTRAINT `fk_Mueble-Solicita-Pedido_Mueble1`
    FOREIGN KEY (`Mueble_idMueble`)
    REFERENCES `muebleria`.`Mueble` (`idMueble`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Mueble-Solicita-Pedido_Pedido1`
    FOREIGN KEY (`Pedido_idPedido`)
    REFERENCES `muebleria`.`Pedido` (`idPedido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `muebleria`.`Apartado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `muebleria`.`Apartado` (
  `idApartado` INT NOT NULL AUTO_INCREMENT,
  `fechaApartado` DATE NULL,
  `anticipoApartado` DOUBLE NULL,
  `Cliente_idCliente` INT NOT NULL,
  PRIMARY KEY (`idApartado`),
  UNIQUE INDEX `idApartado_UNIQUE` (`idApartado` ASC),
  INDEX `fk_Apartado_Cliente1_idx` (`Cliente_idCliente` ASC),
  CONSTRAINT `fk_Apartado_Cliente1`
    FOREIGN KEY (`Cliente_idCliente`)
    REFERENCES `muebleria`.`Cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `muebleria`.`ApartadoApartaMueble`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `muebleria`.`ApartadoApartaMueble` (
  `pagoInicialApartado` DOUBLE NULL,
  `liquidacionApartado` DOUBLE NULL,
  `Apartado_idApartado` INT NOT NULL,
  `Mueble_idMueble` INT NOT NULL,
  INDEX `fk_Apartado-Aparta-Mueble_Apartado1_idx` (`Apartado_idApartado` ASC),
  INDEX `fk_Apartado-Aparta-Mueble_Mueble1_idx` (`Mueble_idMueble` ASC),
  CONSTRAINT `fk_Apartado-Aparta-Mueble_Apartado1`
    FOREIGN KEY (`Apartado_idApartado`)
    REFERENCES `muebleria`.`Apartado` (`idApartado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Apartado-Aparta-Mueble_Mueble1`
    FOREIGN KEY (`Mueble_idMueble`)
    REFERENCES `muebleria`.`Mueble` (`idMueble`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `muebleria`.`VentaCredito`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `muebleria`.`VentaCredito` (
  `idVentaCredito` INT NOT NULL AUTO_INCREMENT,
  `ventaCreditoPagada` TINYINT(1) NULL,
  `montoPagado` DOUBLE NULL,
  `fechaVentaCredito` DATE NULL,
  `Empleado_idEmpleado` INT NOT NULL,
  `Cliente_idCliente` INT NOT NULL,
  PRIMARY KEY (`idVentaCredito`),
  UNIQUE INDEX `idVentaCredito_UNIQUE` (`idVentaCredito` ASC),
  INDEX `fk_VentaCredito_Empleado1_idx` (`Empleado_idEmpleado` ASC),
  INDEX `fk_VentaCredito_Cliente1_idx` (`Cliente_idCliente` ASC),
  CONSTRAINT `fk_VentaCredito_Empleado1`
    FOREIGN KEY (`Empleado_idEmpleado`)
    REFERENCES `muebleria`.`Empleado` (`idEmpleado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_VentaCredito_Cliente1`
    FOREIGN KEY (`Cliente_idCliente`)
    REFERENCES `muebleria`.`Cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `muebleria`.`MuebleSolicitaVentaCredito`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `muebleria`.`MuebleSolicitaVentaCredito` (
  `cantidadVentaCredito` DOUBLE NULL,
  `resguardoVentaCredito` TINYINT(1) NULL,
  `resguardoPendienteVentaCredito` TINYINT(1) NULL,
  `VentaCredito_idVentaCredito` INT NOT NULL,
  `Mueble_idMueble` INT NOT NULL,
  INDEX `fk_Mueble-Solicita-VentaCredito_VentaCredito1_idx` (`VentaCredito_idVentaCredito` ASC),
  INDEX `fk_Mueble-Solicita-VentaCredito_Mueble1_idx` (`Mueble_idMueble` ASC),
  CONSTRAINT `fk_Mueble-Solicita-VentaCredito_VentaCredito1`
    FOREIGN KEY (`VentaCredito_idVentaCredito`)
    REFERENCES `muebleria`.`VentaCredito` (`idVentaCredito`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Mueble-Solicita-VentaCredito_Mueble1`
    FOREIGN KEY (`Mueble_idMueble`)
    REFERENCES `muebleria`.`Mueble` (`idMueble`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `muebleria`.`ProveedorSatisfacePedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `muebleria`.`ProveedorSatisfacePedido` (
  `cantidadPedido` INT NOT NULL,
  `costoPedido` DOUBLE NULL,
  `fechaPedido` DATE NULL,
  `Pedido_idPedido` INT NOT NULL,
  `Proveedor_idProveedor` INT NOT NULL,
  INDEX `fk_Proveedor-Satisface-Pedido_Pedido1_idx` (`Pedido_idPedido` ASC),
  INDEX `fk_Proveedor-Satisface-Pedido_Proveedor1_idx` (`Proveedor_idProveedor` ASC),
  CONSTRAINT `fk_Proveedor-Satisface-Pedido_Pedido1`
    FOREIGN KEY (`Pedido_idPedido`)
    REFERENCES `muebleria`.`Pedido` (`idPedido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Proveedor-Satisface-Pedido_Proveedor1`
    FOREIGN KEY (`Proveedor_idProveedor`)
    REFERENCES `muebleria`.`Proveedor` (`idProveedor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `muebleria`.`PagoCredito`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `muebleria`.`PagoCredito` (
  `idPagoCredito` INT NOT NULL AUTO_INCREMENT,
  `montoPago` DOUBLE NULL,
  `fechaPago` DATE NULL,
  `Cliente_idCliente` INT NOT NULL,
  PRIMARY KEY (`idPagoCredito`),
  UNIQUE INDEX `idPagoCredito_UNIQUE` (`idPagoCredito` ASC),
  INDEX `fk_PagoCredito_Cliente1_idx` (`Cliente_idCliente` ASC),
  CONSTRAINT `fk_PagoCredito_Cliente1`
    FOREIGN KEY (`Cliente_idCliente`)
    REFERENCES `muebleria`.`Cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `muebleria`.`ClienteRealizaPagoCredito`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `muebleria`.`ClienteRealizaPagoCredito` (
  `montoPago` DOUBLE NOT NULL,
  `fechaPago` DATE NULL,
  `PagoCredito_idPagoCredito` INT NOT NULL,
  `Cliente_idCliente` INT NOT NULL,
  INDEX `fk_Cliente-Realiza-PagoCredito_PagoCredito1_idx` (`PagoCredito_idPagoCredito` ASC),
  INDEX `fk_Cliente-Realiza-PagoCredito_Cliente1_idx` (`Cliente_idCliente` ASC),
  CONSTRAINT `fk_Cliente-Realiza-PagoCredito_PagoCredito1`
    FOREIGN KEY (`PagoCredito_idPagoCredito`)
    REFERENCES `muebleria`.`PagoCredito` (`idPagoCredito`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Cliente-Realiza-PagoCredito_Cliente1`
    FOREIGN KEY (`Cliente_idCliente`)
    REFERENCES `muebleria`.`Cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `muebleria`.`ClienteSolicitaApartado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `muebleria`.`ClienteSolicitaApartado` (
  `fechaApartado` DATE NULL,
  `anticipoApartado` DOUBLE NULL,
  `Apartado_idApartado` INT NOT NULL,
  `Cliente_idCliente` INT NOT NULL,
  INDEX `fk_Cliente-Solicita-Apartado_Apartado1_idx` (`Apartado_idApartado` ASC),
  INDEX `fk_Cliente-Solicita-Apartado_Cliente1_idx` (`Cliente_idCliente` ASC),
  CONSTRAINT `fk_Cliente-Solicita-Apartado_Apartado1`
    FOREIGN KEY (`Apartado_idApartado`)
    REFERENCES `muebleria`.`Apartado` (`idApartado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Cliente-Solicita-Apartado_Cliente1`
    FOREIGN KEY (`Cliente_idCliente`)
    REFERENCES `muebleria`.`Cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `muebleria`.`Cuenta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `muebleria`.`Cuenta` (
  `idCuenta` INT NOT NULL AUTO_INCREMENT,
  `numCuenta` VARCHAR(45) NULL,
  `creditoDisponible` DOUBLE NULL,
  `creditoUtilizado` DOUBLE NULL,
  `Cliente_idCliente` INT NOT NULL,
  PRIMARY KEY (`idCuenta`),
  UNIQUE INDEX `idCuenta_UNIQUE` (`idCuenta` ASC),
  INDEX `fk_Cuenta_Cliente1_idx` (`Cliente_idCliente` ASC),
  CONSTRAINT `fk_Cuenta_Cliente1`
    FOREIGN KEY (`Cliente_idCliente`)
    REFERENCES `muebleria`.`Cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
