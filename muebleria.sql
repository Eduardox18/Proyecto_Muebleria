-- MySQL dump 10.13  Distrib 5.7.18, for macos10.12 (x86_64)
--
-- Host: localhost    Database: muebleria
-- ------------------------------------------------------
-- Server version	5.7.18

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `Administrador`
--

DROP TABLE IF EXISTS `Administrador`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Administrador` (
  `idAdministrador` int(11) NOT NULL AUTO_INCREMENT,
  `Usuario_idUsuario` int(11) NOT NULL,
  `nombreAdministrador` varchar(45) NOT NULL,
  `apPaternoAdministrador` varchar(45) DEFAULT NULL,
  `apMaternoAdministrador` varchar(45) DEFAULT NULL,
  `emailAdministrador` varchar(45) DEFAULT NULL,
  `calleAdministrador` varchar(45) DEFAULT NULL,
  `estadoAdministrador` varchar(45) DEFAULT NULL,
  `ciudadAdministrador` varchar(45) DEFAULT NULL,
  `coloniaAdministrador` varchar(45) DEFAULT NULL,
  `telCasaAdmnistrador` int(11) DEFAULT NULL,
  `telCelularAdministrador` int(11) DEFAULT NULL,
  `fechaNacAdministrador` date DEFAULT NULL,
  PRIMARY KEY (`idAdministrador`),
  UNIQUE KEY `idAdministrador_UNIQUE` (`idAdministrador`),
  KEY `fk_Administrador_Usuario1_idx` (`Usuario_idUsuario`),
  CONSTRAINT `fk_Administrador_Usuario1` FOREIGN KEY (`Usuario_idUsuario`) REFERENCES `Usuario` (`idUsuario`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Administrador`
--

LOCK TABLES `Administrador` WRITE;
/*!40000 ALTER TABLE `Administrador` DISABLE KEYS */;
/*!40000 ALTER TABLE `Administrador` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Almacen`
--

DROP TABLE IF EXISTS `Almacen`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Almacen` (
  `idAlmacen` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`idAlmacen`),
  UNIQUE KEY `idAlmacen_UNIQUE` (`idAlmacen`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Almacen`
--

LOCK TABLES `Almacen` WRITE;
/*!40000 ALTER TABLE `Almacen` DISABLE KEYS */;
INSERT INTO `Almacen` VALUES (1);
/*!40000 ALTER TABLE `Almacen` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `AlmacenGuardaMueble`
--

DROP TABLE IF EXISTS `AlmacenGuardaMueble`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `AlmacenGuardaMueble` (
  `Almacen_idAlmacen` int(11) NOT NULL,
  `Mueble_idMueble` int(11) NOT NULL,
  `existenciasAlmacen` int(11) DEFAULT NULL,
  KEY `fk_Almacen-Guarda-Mueble_Almacen_idx` (`Almacen_idAlmacen`),
  KEY `fk_Almacen-Guarda-Mueble_Mueble1_idx` (`Mueble_idMueble`),
  CONSTRAINT `fk_Almacen-Guarda-Mueble_Almacen` FOREIGN KEY (`Almacen_idAlmacen`) REFERENCES `Almacen` (`idAlmacen`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Almacen-Guarda-Mueble_Mueble1` FOREIGN KEY (`Mueble_idMueble`) REFERENCES `Mueble` (`idMueble`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `AlmacenGuardaMueble`
--

LOCK TABLES `AlmacenGuardaMueble` WRITE;
/*!40000 ALTER TABLE `AlmacenGuardaMueble` DISABLE KEYS */;
INSERT INTO `AlmacenGuardaMueble` VALUES (1,5,4),(1,8,5),(1,1,10),(1,2,15),(1,3,12),(1,4,20),(1,6,55),(1,7,10),(1,9,5);
/*!40000 ALTER TABLE `AlmacenGuardaMueble` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Apartado`
--

DROP TABLE IF EXISTS `Apartado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Apartado` (
  `idApartado` int(11) NOT NULL AUTO_INCREMENT,
  `fechaApartado` date DEFAULT NULL,
  `anticipoApartado` double DEFAULT NULL,
  `Cliente_idCliente` int(11) NOT NULL,
  PRIMARY KEY (`idApartado`),
  UNIQUE KEY `idApartado_UNIQUE` (`idApartado`),
  KEY `fk_Apartado_Cliente1_idx` (`Cliente_idCliente`),
  CONSTRAINT `fk_Apartado_Cliente1` FOREIGN KEY (`Cliente_idCliente`) REFERENCES `Cliente` (`idCliente`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Apartado`
--

LOCK TABLES `Apartado` WRITE;
/*!40000 ALTER TABLE `Apartado` DISABLE KEYS */;
/*!40000 ALTER TABLE `Apartado` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ApartadoApartaMueble`
--

DROP TABLE IF EXISTS `ApartadoApartaMueble`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ApartadoApartaMueble` (
  `pagoInicialApartado` double DEFAULT NULL,
  `liquidacionApartado` double DEFAULT NULL,
  `Apartado_idApartado` int(11) NOT NULL,
  `Mueble_idMueble` int(11) NOT NULL,
  KEY `fk_Apartado-Aparta-Mueble_Apartado1_idx` (`Apartado_idApartado`),
  KEY `fk_Apartado-Aparta-Mueble_Mueble1_idx` (`Mueble_idMueble`),
  CONSTRAINT `fk_Apartado-Aparta-Mueble_Apartado1` FOREIGN KEY (`Apartado_idApartado`) REFERENCES `Apartado` (`idApartado`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Apartado-Aparta-Mueble_Mueble1` FOREIGN KEY (`Mueble_idMueble`) REFERENCES `Mueble` (`idMueble`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ApartadoApartaMueble`
--

LOCK TABLES `ApartadoApartaMueble` WRITE;
/*!40000 ALTER TABLE `ApartadoApartaMueble` DISABLE KEYS */;
/*!40000 ALTER TABLE `ApartadoApartaMueble` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Cliente`
--

DROP TABLE IF EXISTS `Cliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Cliente` (
  `idCliente` int(11) NOT NULL AUTO_INCREMENT,
  `nombreCliente` varchar(45) NOT NULL,
  `apPaternoCliente` varchar(45) NOT NULL,
  `apMaternoCliente` varchar(45) DEFAULT NULL,
  `emailCliente` varchar(45) DEFAULT NULL,
  `calleCliente` varchar(45) DEFAULT NULL,
  `estadoCliente` varchar(45) DEFAULT NULL,
  `ciudadCliente` varchar(45) DEFAULT NULL,
  `coloniaCliente` varchar(45) DEFAULT NULL,
  `telCasaCliente` int(11) DEFAULT NULL,
  `telCelularCliente` int(11) DEFAULT NULL,
  `fechaNacCliente` date DEFAULT NULL,
  PRIMARY KEY (`idCliente`),
  UNIQUE KEY `idCliente_UNIQUE` (`idCliente`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Cliente`
--

LOCK TABLES `Cliente` WRITE;
/*!40000 ALTER TABLE `Cliente` DISABLE KEYS */;
/*!40000 ALTER TABLE `Cliente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ClienteRealizaPagoCredito`
--

DROP TABLE IF EXISTS `ClienteRealizaPagoCredito`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ClienteRealizaPagoCredito` (
  `montoPago` double NOT NULL,
  `fechaPago` date DEFAULT NULL,
  `PagoCredito_idPagoCredito` int(11) NOT NULL,
  `Cliente_idCliente` int(11) NOT NULL,
  KEY `fk_Cliente-Realiza-PagoCredito_PagoCredito1_idx` (`PagoCredito_idPagoCredito`),
  KEY `fk_Cliente-Realiza-PagoCredito_Cliente1_idx` (`Cliente_idCliente`),
  CONSTRAINT `fk_Cliente-Realiza-PagoCredito_Cliente1` FOREIGN KEY (`Cliente_idCliente`) REFERENCES `Cliente` (`idCliente`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Cliente-Realiza-PagoCredito_PagoCredito1` FOREIGN KEY (`PagoCredito_idPagoCredito`) REFERENCES `PagoCredito` (`idPagoCredito`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ClienteRealizaPagoCredito`
--

LOCK TABLES `ClienteRealizaPagoCredito` WRITE;
/*!40000 ALTER TABLE `ClienteRealizaPagoCredito` DISABLE KEYS */;
/*!40000 ALTER TABLE `ClienteRealizaPagoCredito` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ClienteSolicitaApartado`
--

DROP TABLE IF EXISTS `ClienteSolicitaApartado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ClienteSolicitaApartado` (
  `fechaApartado` date DEFAULT NULL,
  `anticipoApartado` double DEFAULT NULL,
  `Apartado_idApartado` int(11) NOT NULL,
  `Cliente_idCliente` int(11) NOT NULL,
  KEY `fk_Cliente-Solicita-Apartado_Apartado1_idx` (`Apartado_idApartado`),
  KEY `fk_Cliente-Solicita-Apartado_Cliente1_idx` (`Cliente_idCliente`),
  CONSTRAINT `fk_Cliente-Solicita-Apartado_Apartado1` FOREIGN KEY (`Apartado_idApartado`) REFERENCES `Apartado` (`idApartado`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Cliente-Solicita-Apartado_Cliente1` FOREIGN KEY (`Cliente_idCliente`) REFERENCES `Cliente` (`idCliente`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ClienteSolicitaApartado`
--

LOCK TABLES `ClienteSolicitaApartado` WRITE;
/*!40000 ALTER TABLE `ClienteSolicitaApartado` DISABLE KEYS */;
/*!40000 ALTER TABLE `ClienteSolicitaApartado` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Cuenta`
--

DROP TABLE IF EXISTS `Cuenta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Cuenta` (
  `idCuenta` int(11) NOT NULL AUTO_INCREMENT,
  `numCuenta` varchar(45) DEFAULT NULL,
  `creditoDisponible` double DEFAULT NULL,
  `creditoUtilizado` double DEFAULT NULL,
  `Cliente_idCliente` int(11) NOT NULL,
  PRIMARY KEY (`idCuenta`),
  UNIQUE KEY `idCuenta_UNIQUE` (`idCuenta`),
  KEY `fk_Cuenta_Cliente1_idx` (`Cliente_idCliente`),
  CONSTRAINT `fk_Cuenta_Cliente1` FOREIGN KEY (`Cliente_idCliente`) REFERENCES `Cliente` (`idCliente`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Cuenta`
--

LOCK TABLES `Cuenta` WRITE;
/*!40000 ALTER TABLE `Cuenta` DISABLE KEYS */;
/*!40000 ALTER TABLE `Cuenta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Empleado`
--

DROP TABLE IF EXISTS `Empleado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Empleado` (
  `idEmpleado` int(11) NOT NULL AUTO_INCREMENT,
  `Usuario_idUsuario` int(11) NOT NULL,
  `nombreEmpleado` varchar(45) NOT NULL,
  `apPaternoEmpleado` varchar(45) NOT NULL,
  `apMaternoEmpleado` varchar(45) DEFAULT NULL,
  `emailEmpleado` varchar(45) DEFAULT NULL,
  `calleEmpleado` varchar(45) DEFAULT NULL,
  `estadoEmpleado` varchar(45) DEFAULT NULL,
  `ciudadEmpleado` varchar(45) DEFAULT NULL,
  `coloniaEmpleado` varchar(45) DEFAULT NULL,
  `telCasaEmpleado` int(11) DEFAULT NULL,
  `telCelularEmpleado` int(11) DEFAULT NULL,
  `fechaNacEmpleado` date DEFAULT NULL,
  PRIMARY KEY (`idEmpleado`),
  UNIQUE KEY `idEmpleado_UNIQUE` (`idEmpleado`),
  KEY `fk_Empleado_Usuario1_idx` (`Usuario_idUsuario`),
  CONSTRAINT `fk_Empleado_Usuario1` FOREIGN KEY (`Usuario_idUsuario`) REFERENCES `Usuario` (`idUsuario`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Empleado`
--

LOCK TABLES `Empleado` WRITE;
/*!40000 ALTER TABLE `Empleado` DISABLE KEYS */;
/*!40000 ALTER TABLE `Empleado` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Mueble`
--

DROP TABLE IF EXISTS `Mueble`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Mueble` (
  `idMueble` int(11) NOT NULL AUTO_INCREMENT,
  `nombreMueble` varchar(45) DEFAULT NULL,
  `precioMueble` double DEFAULT NULL,
  `tipoMueble` varchar(45) DEFAULT NULL,
  `stockMinimoMueble` int(11) DEFAULT NULL,
  `baseMueble` double DEFAULT NULL,
  `alturaMueble` double DEFAULT NULL,
  `profundidadMueble` double DEFAULT NULL,
  `colorMueble` varchar(45) DEFAULT NULL,
  `materialMueble` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idMueble`),
  UNIQUE KEY `idMueble_UNIQUE` (`idMueble`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Mueble`
--

LOCK TABLES `Mueble` WRITE;
/*!40000 ALTER TABLE `Mueble` DISABLE KEYS */;
INSERT INTO `Mueble` VALUES (1,'Silla',200,'Silla',3,3,2,1,'Azul','Madera'),(2,'Sillón',2000,'Sala',2,2,1,3,'Chocolate','Caoba'),(3,'Salita',1,'Salón',2,3,1,4,'Chocolate','Caoba'),(4,'Umbrella',2000,'Silla de sala',4,80,160,60,'Rojo','Cuero'),(5,'Purple Rain',800,'Alfombra',10,200,2,400,'Morado ','Felpa'),(6,'Burdeos',500,'Banco para bar',2,0.4,1.5,0.4,'Rojo','Plástico'),(7,'Blood & Wine',8000,'Bar',1,6,1.5,1,'Blanco','Mármol'),(8,'Heartless',1000,'Lovesit',3,3,1,1,'Rojo','Piel'),(9,'Sweet Dream',4000,'Cama',2,2,1,3,'Chocolate','Madera');
/*!40000 ALTER TABLE `Mueble` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `MuebleSolicitaPedido`
--

DROP TABLE IF EXISTS `MuebleSolicitaPedido`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `MuebleSolicitaPedido` (
  `Mueble_idMueble` int(11) NOT NULL,
  `Pedido_idPedido` int(11) NOT NULL,
  KEY `fk_Mueble-Solicita-Pedido_Mueble1_idx` (`Mueble_idMueble`),
  KEY `fk_Mueble-Solicita-Pedido_Pedido1_idx` (`Pedido_idPedido`),
  CONSTRAINT `fk_Mueble-Solicita-Pedido_Mueble1` FOREIGN KEY (`Mueble_idMueble`) REFERENCES `Mueble` (`idMueble`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Mueble-Solicita-Pedido_Pedido1` FOREIGN KEY (`Pedido_idPedido`) REFERENCES `Pedido` (`idPedido`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `MuebleSolicitaPedido`
--

LOCK TABLES `MuebleSolicitaPedido` WRITE;
/*!40000 ALTER TABLE `MuebleSolicitaPedido` DISABLE KEYS */;
/*!40000 ALTER TABLE `MuebleSolicitaPedido` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `MuebleSolicitaVentaContado`
--

DROP TABLE IF EXISTS `MuebleSolicitaVentaContado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `MuebleSolicitaVentaContado` (
  `cantidadVentaContado` double DEFAULT NULL,
  `resguardoVentaContado` varchar(45) DEFAULT NULL,
  `resguardoPendienteVentaCredito` varchar(45) DEFAULT NULL,
  `Mueble_idMueble` int(11) NOT NULL,
  `VentaContado_idVentaContado` int(11) NOT NULL,
  KEY `fk_Mueble-Solicita-VentaContado_Mueble1_idx` (`Mueble_idMueble`),
  KEY `fk_Mueble-Solicita-VentaContado_VentaContado1_idx` (`VentaContado_idVentaContado`),
  CONSTRAINT `fk_Mueble-Solicita-VentaContado_Mueble1` FOREIGN KEY (`Mueble_idMueble`) REFERENCES `Mueble` (`idMueble`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Mueble-Solicita-VentaContado_VentaContado1` FOREIGN KEY (`VentaContado_idVentaContado`) REFERENCES `VentaContado` (`idVentaContado`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `MuebleSolicitaVentaContado`
--

LOCK TABLES `MuebleSolicitaVentaContado` WRITE;
/*!40000 ALTER TABLE `MuebleSolicitaVentaContado` DISABLE KEYS */;
/*!40000 ALTER TABLE `MuebleSolicitaVentaContado` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `MuebleSolicitaVentaCredito`
--

DROP TABLE IF EXISTS `MuebleSolicitaVentaCredito`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `MuebleSolicitaVentaCredito` (
  `cantidadVentaCredito` double DEFAULT NULL,
  `resguardoVentaCredito` tinyint(1) DEFAULT NULL,
  `resguardoPendienteVentaCredito` tinyint(1) DEFAULT NULL,
  `VentaCredito_idVentaCredito` int(11) NOT NULL,
  `Mueble_idMueble` int(11) NOT NULL,
  KEY `fk_Mueble-Solicita-VentaCredito_VentaCredito1_idx` (`VentaCredito_idVentaCredito`),
  KEY `fk_Mueble-Solicita-VentaCredito_Mueble1_idx` (`Mueble_idMueble`),
  CONSTRAINT `fk_Mueble-Solicita-VentaCredito_Mueble1` FOREIGN KEY (`Mueble_idMueble`) REFERENCES `Mueble` (`idMueble`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Mueble-Solicita-VentaCredito_VentaCredito1` FOREIGN KEY (`VentaCredito_idVentaCredito`) REFERENCES `VentaCredito` (`idVentaCredito`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `MuebleSolicitaVentaCredito`
--

LOCK TABLES `MuebleSolicitaVentaCredito` WRITE;
/*!40000 ALTER TABLE `MuebleSolicitaVentaCredito` DISABLE KEYS */;
/*!40000 ALTER TABLE `MuebleSolicitaVentaCredito` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PagoCredito`
--

DROP TABLE IF EXISTS `PagoCredito`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `PagoCredito` (
  `idPagoCredito` int(11) NOT NULL AUTO_INCREMENT,
  `montoPago` double DEFAULT NULL,
  `fechaPago` date DEFAULT NULL,
  `Cliente_idCliente` int(11) NOT NULL,
  PRIMARY KEY (`idPagoCredito`),
  UNIQUE KEY `idPagoCredito_UNIQUE` (`idPagoCredito`),
  KEY `fk_PagoCredito_Cliente1_idx` (`Cliente_idCliente`),
  CONSTRAINT `fk_PagoCredito_Cliente1` FOREIGN KEY (`Cliente_idCliente`) REFERENCES `Cliente` (`idCliente`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PagoCredito`
--

LOCK TABLES `PagoCredito` WRITE;
/*!40000 ALTER TABLE `PagoCredito` DISABLE KEYS */;
/*!40000 ALTER TABLE `PagoCredito` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Pedido`
--

DROP TABLE IF EXISTS `Pedido`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Pedido` (
  `idPedido` int(11) NOT NULL AUTO_INCREMENT,
  `detallePedido` varchar(45) DEFAULT NULL,
  `cantidadPedido` int(11) DEFAULT NULL,
  `costoPedido` double DEFAULT NULL,
  `fechaPedido` date DEFAULT NULL,
  `Proveedor_idProveedor` int(11) NOT NULL,
  `Administrador_idAdministrador` int(11) NOT NULL,
  PRIMARY KEY (`idPedido`),
  UNIQUE KEY `idPedido_UNIQUE` (`idPedido`),
  KEY `fk_Pedido_Administrador2_idx` (`Administrador_idAdministrador`),
  KEY `fk_Pedido_Proveedor1_idx` (`Proveedor_idProveedor`),
  CONSTRAINT `fk_Pedido_Administrador2` FOREIGN KEY (`Administrador_idAdministrador`) REFERENCES `Administrador` (`idAdministrador`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pedido_Proveedor1` FOREIGN KEY (`Proveedor_idProveedor`) REFERENCES `Proveedor` (`idProveedor`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Pedido`
--

LOCK TABLES `Pedido` WRITE;
/*!40000 ALTER TABLE `Pedido` DISABLE KEYS */;
/*!40000 ALTER TABLE `Pedido` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Proveedor`
--

DROP TABLE IF EXISTS `Proveedor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Proveedor` (
  `idProveedor` int(11) NOT NULL AUTO_INCREMENT,
  `razonSocialProveedor` varchar(45) DEFAULT NULL,
  `emailProveedor` varchar(45) DEFAULT NULL,
  `calleProveedor` varchar(45) DEFAULT NULL,
  `coloniaProveedor` varchar(45) DEFAULT NULL,
  `ciudadProveedor` varchar(45) DEFAULT NULL,
  `estadoProveedor` varchar(45) DEFAULT NULL,
  `telefonoProveedor` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idProveedor`),
  UNIQUE KEY `idProveedor_UNIQUE` (`idProveedor`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Proveedor`
--

LOCK TABLES `Proveedor` WRITE;
/*!40000 ALTER TABLE `Proveedor` DISABLE KEYS */;
/*!40000 ALTER TABLE `Proveedor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ProveedorSatisfacePedido`
--

DROP TABLE IF EXISTS `ProveedorSatisfacePedido`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ProveedorSatisfacePedido` (
  `cantidadPedido` int(11) NOT NULL,
  `costoPedido` double DEFAULT NULL,
  `fechaPedido` date DEFAULT NULL,
  `Pedido_idPedido` int(11) NOT NULL,
  `Proveedor_idProveedor` int(11) NOT NULL,
  KEY `fk_Proveedor-Satisface-Pedido_Pedido1_idx` (`Pedido_idPedido`),
  KEY `fk_Proveedor-Satisface-Pedido_Proveedor1_idx` (`Proveedor_idProveedor`),
  CONSTRAINT `fk_Proveedor-Satisface-Pedido_Pedido1` FOREIGN KEY (`Pedido_idPedido`) REFERENCES `Pedido` (`idPedido`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Proveedor-Satisface-Pedido_Proveedor1` FOREIGN KEY (`Proveedor_idProveedor`) REFERENCES `Proveedor` (`idProveedor`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ProveedorSatisfacePedido`
--

LOCK TABLES `ProveedorSatisfacePedido` WRITE;
/*!40000 ALTER TABLE `ProveedorSatisfacePedido` DISABLE KEYS */;
/*!40000 ALTER TABLE `ProveedorSatisfacePedido` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Usuario`
--

DROP TABLE IF EXISTS `Usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Usuario` (
  `idUsuario` int(11) NOT NULL AUTO_INCREMENT,
  `contrasenaUsuario` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idUsuario`),
  UNIQUE KEY `idUsuario_UNIQUE` (`idUsuario`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Usuario`
--

LOCK TABLES `Usuario` WRITE;
/*!40000 ALTER TABLE `Usuario` DISABLE KEYS */;
/*!40000 ALTER TABLE `Usuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `VentaContado`
--

DROP TABLE IF EXISTS `VentaContado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `VentaContado` (
  `idVentaContado` int(11) NOT NULL AUTO_INCREMENT,
  `fechaVentaContado` date DEFAULT NULL,
  `Empleado_idEmpleado` int(11) NOT NULL,
  `Cliente_idCliente` int(11) NOT NULL,
  PRIMARY KEY (`idVentaContado`),
  UNIQUE KEY `idVentaContado_UNIQUE` (`idVentaContado`),
  KEY `fk_VentaContado_Empleado1_idx` (`Empleado_idEmpleado`),
  KEY `fk_VentaContado_Cliente1_idx` (`Cliente_idCliente`),
  CONSTRAINT `fk_VentaContado_Cliente1` FOREIGN KEY (`Cliente_idCliente`) REFERENCES `Cliente` (`idCliente`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_VentaContado_Empleado1` FOREIGN KEY (`Empleado_idEmpleado`) REFERENCES `Empleado` (`idEmpleado`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `VentaContado`
--

LOCK TABLES `VentaContado` WRITE;
/*!40000 ALTER TABLE `VentaContado` DISABLE KEYS */;
/*!40000 ALTER TABLE `VentaContado` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `VentaCredito`
--

DROP TABLE IF EXISTS `VentaCredito`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `VentaCredito` (
  `idVentaCredito` int(11) NOT NULL AUTO_INCREMENT,
  `ventaCreditoPagada` tinyint(1) DEFAULT NULL,
  `montoPagado` double DEFAULT NULL,
  `fechaVentaCredito` date DEFAULT NULL,
  `Empleado_idEmpleado` int(11) NOT NULL,
  `Cliente_idCliente` int(11) NOT NULL,
  PRIMARY KEY (`idVentaCredito`),
  UNIQUE KEY `idVentaCredito_UNIQUE` (`idVentaCredito`),
  KEY `fk_VentaCredito_Empleado1_idx` (`Empleado_idEmpleado`),
  KEY `fk_VentaCredito_Cliente1_idx` (`Cliente_idCliente`),
  CONSTRAINT `fk_VentaCredito_Cliente1` FOREIGN KEY (`Cliente_idCliente`) REFERENCES `Cliente` (`idCliente`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_VentaCredito_Empleado1` FOREIGN KEY (`Empleado_idEmpleado`) REFERENCES `Empleado` (`idEmpleado`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `VentaCredito`
--

LOCK TABLES `VentaCredito` WRITE;
/*!40000 ALTER TABLE `VentaCredito` DISABLE KEYS */;
/*!40000 ALTER TABLE `VentaCredito` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-05-03 16:15:48
