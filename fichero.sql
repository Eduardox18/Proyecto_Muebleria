-- MySQL dump 10.13  Distrib 5.7.15, for Win32 (AMD64)
--
-- Host: localhost    Database: muebleria
-- ------------------------------------------------------
-- Server version	5.7.15-log

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
-- Table structure for table `administrador`
--

DROP TABLE IF EXISTS `administrador`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `administrador` (
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
  CONSTRAINT `fk_Administrador_Usuario1` FOREIGN KEY (`Usuario_idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `administrador`
--

LOCK TABLES `administrador` WRITE;
/*!40000 ALTER TABLE `administrador` DISABLE KEYS */;
/*!40000 ALTER TABLE `administrador` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `almacen`
--

DROP TABLE IF EXISTS `almacen`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `almacen` (
  `idAlmacen` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`idAlmacen`),
  UNIQUE KEY `idAlmacen_UNIQUE` (`idAlmacen`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `almacen`
--

LOCK TABLES `almacen` WRITE;
/*!40000 ALTER TABLE `almacen` DISABLE KEYS */;
INSERT INTO `almacen` VALUES (1);
/*!40000 ALTER TABLE `almacen` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `almacenguardamueble`
--

DROP TABLE IF EXISTS `almacenguardamueble`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `almacenguardamueble` (
  `Almacen_idAlmacen` int(11) NOT NULL,
  `Mueble_idMueble` int(11) NOT NULL,
  `existenciasAlmacen` int(11) DEFAULT NULL,
  KEY `fk_Almacen-Guarda-Mueble_Almacen_idx` (`Almacen_idAlmacen`),
  KEY `fk_Almacen-Guarda-Mueble_Mueble1_idx` (`Mueble_idMueble`),
  CONSTRAINT `fk_Almacen-Guarda-Mueble_Almacen` FOREIGN KEY (`Almacen_idAlmacen`) REFERENCES `almacen` (`idAlmacen`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Almacen-Guarda-Mueble_Mueble1` FOREIGN KEY (`Mueble_idMueble`) REFERENCES `mueble` (`idMueble`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `almacenguardamueble`
--

LOCK TABLES `almacenguardamueble` WRITE;
/*!40000 ALTER TABLE `almacenguardamueble` DISABLE KEYS */;
INSERT INTO `almacenguardamueble` VALUES (1,5,4),(1,8,5),(1,1,10),(1,2,15),(1,3,12),(1,4,20),(1,6,55),(1,7,10),(1,9,5),(1,10,6);
/*!40000 ALTER TABLE `almacenguardamueble` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `apartado`
--

DROP TABLE IF EXISTS `apartado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `apartado` (
  `idApartado` int(11) NOT NULL AUTO_INCREMENT,
  `fechaApartado` date DEFAULT NULL,
  `anticipoApartado` double DEFAULT NULL,
  `Cliente_idCliente` int(11) NOT NULL,
  PRIMARY KEY (`idApartado`),
  UNIQUE KEY `idApartado_UNIQUE` (`idApartado`),
  KEY `fk_Apartado_Cliente1_idx` (`Cliente_idCliente`),
  CONSTRAINT `fk_Apartado_Cliente1` FOREIGN KEY (`Cliente_idCliente`) REFERENCES `cliente` (`idCliente`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `apartado`
--

LOCK TABLES `apartado` WRITE;
/*!40000 ALTER TABLE `apartado` DISABLE KEYS */;
/*!40000 ALTER TABLE `apartado` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `apartadoapartamueble`
--

DROP TABLE IF EXISTS `apartadoapartamueble`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `apartadoapartamueble` (
  `pagoInicialApartado` double DEFAULT NULL,
  `liquidacionApartado` double DEFAULT NULL,
  `Apartado_idApartado` int(11) NOT NULL,
  `Mueble_idMueble` int(11) NOT NULL,
  KEY `fk_Apartado-Aparta-Mueble_Apartado1_idx` (`Apartado_idApartado`),
  KEY `fk_Apartado-Aparta-Mueble_Mueble1_idx` (`Mueble_idMueble`),
  CONSTRAINT `fk_Apartado-Aparta-Mueble_Apartado1` FOREIGN KEY (`Apartado_idApartado`) REFERENCES `apartado` (`idApartado`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Apartado-Aparta-Mueble_Mueble1` FOREIGN KEY (`Mueble_idMueble`) REFERENCES `mueble` (`idMueble`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `apartadoapartamueble`
--

LOCK TABLES `apartadoapartamueble` WRITE;
/*!40000 ALTER TABLE `apartadoapartamueble` DISABLE KEYS */;
/*!40000 ALTER TABLE `apartadoapartamueble` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cliente`
--

DROP TABLE IF EXISTS `cliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cliente` (
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cliente`
--

LOCK TABLES `cliente` WRITE;
/*!40000 ALTER TABLE `cliente` DISABLE KEYS */;
INSERT INTO `cliente` VALUES (1,'Lizbeth','Hernández','González','lizbeth@hotmail.com','Villahermosa','Veracruz','Xalapa','Progreso',155327,22567859,'1976-05-08');
/*!40000 ALTER TABLE `cliente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clienterealizapagocredito`
--

DROP TABLE IF EXISTS `clienterealizapagocredito`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `clienterealizapagocredito` (
  `montoPago` double NOT NULL,
  `fechaPago` date DEFAULT NULL,
  `PagoCredito_idPagoCredito` int(11) NOT NULL,
  `Cliente_idCliente` int(11) NOT NULL,
  KEY `fk_Cliente-Realiza-PagoCredito_PagoCredito1_idx` (`PagoCredito_idPagoCredito`),
  KEY `fk_Cliente-Realiza-PagoCredito_Cliente1_idx` (`Cliente_idCliente`),
  CONSTRAINT `fk_Cliente-Realiza-PagoCredito_Cliente1` FOREIGN KEY (`Cliente_idCliente`) REFERENCES `cliente` (`idCliente`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Cliente-Realiza-PagoCredito_PagoCredito1` FOREIGN KEY (`PagoCredito_idPagoCredito`) REFERENCES `pagocredito` (`idPagoCredito`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clienterealizapagocredito`
--

LOCK TABLES `clienterealizapagocredito` WRITE;
/*!40000 ALTER TABLE `clienterealizapagocredito` DISABLE KEYS */;
/*!40000 ALTER TABLE `clienterealizapagocredito` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clientesolicitaapartado`
--

DROP TABLE IF EXISTS `clientesolicitaapartado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `clientesolicitaapartado` (
  `fechaApartado` date DEFAULT NULL,
  `anticipoApartado` double DEFAULT NULL,
  `Apartado_idApartado` int(11) NOT NULL,
  `Cliente_idCliente` int(11) NOT NULL,
  KEY `fk_Cliente-Solicita-Apartado_Apartado1_idx` (`Apartado_idApartado`),
  KEY `fk_Cliente-Solicita-Apartado_Cliente1_idx` (`Cliente_idCliente`),
  CONSTRAINT `fk_Cliente-Solicita-Apartado_Apartado1` FOREIGN KEY (`Apartado_idApartado`) REFERENCES `apartado` (`idApartado`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Cliente-Solicita-Apartado_Cliente1` FOREIGN KEY (`Cliente_idCliente`) REFERENCES `cliente` (`idCliente`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clientesolicitaapartado`
--

LOCK TABLES `clientesolicitaapartado` WRITE;
/*!40000 ALTER TABLE `clientesolicitaapartado` DISABLE KEYS */;
/*!40000 ALTER TABLE `clientesolicitaapartado` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cuenta`
--

DROP TABLE IF EXISTS `cuenta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cuenta` (
  `idCuenta` int(11) NOT NULL AUTO_INCREMENT,
  `numCuenta` varchar(45) DEFAULT NULL,
  `creditoDisponible` double DEFAULT NULL,
  `creditoUtilizado` double DEFAULT NULL,
  `Cliente_idCliente` int(11) NOT NULL,
  PRIMARY KEY (`idCuenta`),
  UNIQUE KEY `idCuenta_UNIQUE` (`idCuenta`),
  KEY `fk_Cuenta_Cliente1_idx` (`Cliente_idCliente`),
  CONSTRAINT `fk_Cuenta_Cliente1` FOREIGN KEY (`Cliente_idCliente`) REFERENCES `cliente` (`idCliente`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cuenta`
--

LOCK TABLES `cuenta` WRITE;
/*!40000 ALTER TABLE `cuenta` DISABLE KEYS */;
/*!40000 ALTER TABLE `cuenta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `empleado`
--

DROP TABLE IF EXISTS `empleado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `empleado` (
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
  CONSTRAINT `fk_Empleado_Usuario1` FOREIGN KEY (`Usuario_idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `empleado`
--

LOCK TABLES `empleado` WRITE;
/*!40000 ALTER TABLE `empleado` DISABLE KEYS */;
INSERT INTO `empleado` VALUES (1,2,'Esmeralda Yamileth','Hernández','González','esmeyhg@gmail.com','Honorio Rodriguez','Veracruz','Xalapa','Ferrer',1862215,8141410,'1997-08-17'),(2,2,'José Andrés','Domínguez','González','andres@gmail.com','Burdeos','Veracruz','Xalapa','Sumidero',8769543,8768549,'1997-10-12'),(3,2,'Angel Eduardo','Domínguez','Delgado','angel@gmail.com','Paraiso','Veracruz','Xalapa','Revolucion',8795838,2269784,'1996-03-25');
/*!40000 ALTER TABLE `empleado` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mueble`
--

DROP TABLE IF EXISTS `mueble`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mueble` (
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
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mueble`
--

LOCK TABLES `mueble` WRITE;
/*!40000 ALTER TABLE `mueble` DISABLE KEYS */;
INSERT INTO `mueble` VALUES (1,'Sillita',200,'Silla',3,3,2,1,'Azul','Madera'),(2,'Sillón',2000,'Sala',2,2,1,3,'Chocolate','Caoba'),(3,'Salita',1,'Salón',2,3,1,4,'Chocolate','Caoba'),(4,'Umbrella',2000,'Silla de sala',4,80,160,60,'Rojo','Cuero'),(5,'Purple Rain',800,'Alfombra',10,200,2,400,'Morado ','Felpa'),(6,'Burdeos',500,'Banco para bar',2,0.4,1.5,0.4,'Rojo','Plástico'),(7,'Blood & Wine',8000,'Bar',1,6,1.5,1,'Blanco','Mármol'),(8,'Heartless',1000,'Lovesit',3,3,1,1,'Rojo','Piel'),(9,'Sweet Dream',4000,'Cama',2,2,1,3,'Chocolate','Madera'),(10,'PrettySofa',2000,'Sofa',4,50,20,12,'Cafe','Terciopelo');
/*!40000 ALTER TABLE `mueble` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mueblesolicitapedido`
--

DROP TABLE IF EXISTS `mueblesolicitapedido`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mueblesolicitapedido` (
  `Mueble_idMueble` int(11) NOT NULL,
  `Pedido_idPedido` int(11) NOT NULL,
  KEY `fk_Mueble-Solicita-Pedido_Mueble1_idx` (`Mueble_idMueble`),
  KEY `fk_Mueble-Solicita-Pedido_Pedido1_idx` (`Pedido_idPedido`),
  CONSTRAINT `fk_Mueble-Solicita-Pedido_Mueble1` FOREIGN KEY (`Mueble_idMueble`) REFERENCES `mueble` (`idMueble`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Mueble-Solicita-Pedido_Pedido1` FOREIGN KEY (`Pedido_idPedido`) REFERENCES `pedido` (`idPedido`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mueblesolicitapedido`
--

LOCK TABLES `mueblesolicitapedido` WRITE;
/*!40000 ALTER TABLE `mueblesolicitapedido` DISABLE KEYS */;
/*!40000 ALTER TABLE `mueblesolicitapedido` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mueblesolicitaventacontado`
--

DROP TABLE IF EXISTS `mueblesolicitaventacontado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mueblesolicitaventacontado` (
  `cantidadVentaContado` int(11) DEFAULT NULL,
  `resguardoVentaContado` tinyint(1) DEFAULT NULL,
  `resguardoPendienteVentaCredito` tinyint(1) DEFAULT NULL,
  `Mueble_idMueble` int(11) NOT NULL,
  `VentaContado_idVentaContado` int(11) NOT NULL,
  KEY `fk_Mueble-Solicita-VentaContado_Mueble1_idx` (`Mueble_idMueble`),
  KEY `fk_Mueble-Solicita-VentaContado_VentaContado1_idx` (`VentaContado_idVentaContado`),
  CONSTRAINT `fk_Mueble-Solicita-VentaContado_Mueble1` FOREIGN KEY (`Mueble_idMueble`) REFERENCES `mueble` (`idMueble`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Mueble-Solicita-VentaContado_VentaContado1` FOREIGN KEY (`VentaContado_idVentaContado`) REFERENCES `ventacontado` (`idVentaContado`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mueblesolicitaventacontado`
--

LOCK TABLES `mueblesolicitaventacontado` WRITE;
/*!40000 ALTER TABLE `mueblesolicitaventacontado` DISABLE KEYS */;
INSERT INTO `mueblesolicitaventacontado` VALUES (4,0,NULL,1,17);
/*!40000 ALTER TABLE `mueblesolicitaventacontado` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mueblesolicitaventacredito`
--

DROP TABLE IF EXISTS `mueblesolicitaventacredito`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mueblesolicitaventacredito` (
  `cantidadVentaCredito` double DEFAULT NULL,
  `resguardoVentaCredito` tinyint(1) DEFAULT NULL,
  `resguardoPendienteVentaCredito` tinyint(1) DEFAULT NULL,
  `VentaCredito_idVentaCredito` int(11) NOT NULL,
  `Mueble_idMueble` int(11) NOT NULL,
  KEY `fk_Mueble-Solicita-VentaCredito_VentaCredito1_idx` (`VentaCredito_idVentaCredito`),
  KEY `fk_Mueble-Solicita-VentaCredito_Mueble1_idx` (`Mueble_idMueble`),
  CONSTRAINT `fk_Mueble-Solicita-VentaCredito_Mueble1` FOREIGN KEY (`Mueble_idMueble`) REFERENCES `mueble` (`idMueble`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Mueble-Solicita-VentaCredito_VentaCredito1` FOREIGN KEY (`VentaCredito_idVentaCredito`) REFERENCES `ventacredito` (`idVentaCredito`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mueblesolicitaventacredito`
--

LOCK TABLES `mueblesolicitaventacredito` WRITE;
/*!40000 ALTER TABLE `mueblesolicitaventacredito` DISABLE KEYS */;
/*!40000 ALTER TABLE `mueblesolicitaventacredito` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pagocredito`
--

DROP TABLE IF EXISTS `pagocredito`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pagocredito` (
  `idPagoCredito` int(11) NOT NULL AUTO_INCREMENT,
  `montoPago` double DEFAULT NULL,
  `fechaPago` date DEFAULT NULL,
  `Cliente_idCliente` int(11) NOT NULL,
  PRIMARY KEY (`idPagoCredito`),
  UNIQUE KEY `idPagoCredito_UNIQUE` (`idPagoCredito`),
  KEY `fk_PagoCredito_Cliente1_idx` (`Cliente_idCliente`),
  CONSTRAINT `fk_PagoCredito_Cliente1` FOREIGN KEY (`Cliente_idCliente`) REFERENCES `cliente` (`idCliente`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pagocredito`
--

LOCK TABLES `pagocredito` WRITE;
/*!40000 ALTER TABLE `pagocredito` DISABLE KEYS */;
/*!40000 ALTER TABLE `pagocredito` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pedido`
--

DROP TABLE IF EXISTS `pedido`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pedido` (
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
  CONSTRAINT `fk_Pedido_Administrador2` FOREIGN KEY (`Administrador_idAdministrador`) REFERENCES `administrador` (`idAdministrador`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pedido_Proveedor1` FOREIGN KEY (`Proveedor_idProveedor`) REFERENCES `proveedor` (`idProveedor`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pedido`
--

LOCK TABLES `pedido` WRITE;
/*!40000 ALTER TABLE `pedido` DISABLE KEYS */;
/*!40000 ALTER TABLE `pedido` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `proveedor`
--

DROP TABLE IF EXISTS `proveedor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `proveedor` (
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
-- Dumping data for table `proveedor`
--

LOCK TABLES `proveedor` WRITE;
/*!40000 ALTER TABLE `proveedor` DISABLE KEYS */;
/*!40000 ALTER TABLE `proveedor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `proveedorsatisfacepedido`
--

DROP TABLE IF EXISTS `proveedorsatisfacepedido`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `proveedorsatisfacepedido` (
  `cantidadPedido` int(11) NOT NULL,
  `costoPedido` double DEFAULT NULL,
  `fechaPedido` date DEFAULT NULL,
  `Pedido_idPedido` int(11) NOT NULL,
  `Proveedor_idProveedor` int(11) NOT NULL,
  KEY `fk_Proveedor-Satisface-Pedido_Pedido1_idx` (`Pedido_idPedido`),
  KEY `fk_Proveedor-Satisface-Pedido_Proveedor1_idx` (`Proveedor_idProveedor`),
  CONSTRAINT `fk_Proveedor-Satisface-Pedido_Pedido1` FOREIGN KEY (`Pedido_idPedido`) REFERENCES `pedido` (`idPedido`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Proveedor-Satisface-Pedido_Proveedor1` FOREIGN KEY (`Proveedor_idProveedor`) REFERENCES `proveedor` (`idProveedor`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `proveedorsatisfacepedido`
--

LOCK TABLES `proveedorsatisfacepedido` WRITE;
/*!40000 ALTER TABLE `proveedorsatisfacepedido` DISABLE KEYS */;
/*!40000 ALTER TABLE `proveedorsatisfacepedido` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuario`
--

DROP TABLE IF EXISTS `usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usuario` (
  `idUsuario` int(11) NOT NULL AUTO_INCREMENT,
  `contrasenaUsuario` varchar(45) DEFAULT NULL,
  `nombreUsuario` varchar(20) NOT NULL,
  PRIMARY KEY (`idUsuario`),
  UNIQUE KEY `idUsuario_UNIQUE` (`idUsuario`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario`
--

LOCK TABLES `usuario` WRITE;
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
INSERT INTO `usuario` VALUES (1,'administrador','administrador'),(2,'empleado','empleado');
/*!40000 ALTER TABLE `usuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ventacontado`
--

DROP TABLE IF EXISTS `ventacontado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ventacontado` (
  `idVentaContado` int(11) NOT NULL AUTO_INCREMENT,
  `fechaVentaContado` date DEFAULT NULL,
  `Empleado_idEmpleado` int(11) NOT NULL,
  `Cliente_idCliente` int(11) NOT NULL,
  PRIMARY KEY (`idVentaContado`),
  UNIQUE KEY `idVentaContado_UNIQUE` (`idVentaContado`),
  KEY `fk_VentaContado_Empleado1_idx` (`Empleado_idEmpleado`),
  KEY `fk_VentaContado_Cliente1_idx` (`Cliente_idCliente`),
  CONSTRAINT `fk_VentaContado_Cliente1` FOREIGN KEY (`Cliente_idCliente`) REFERENCES `cliente` (`idCliente`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_VentaContado_Empleado1` FOREIGN KEY (`Empleado_idEmpleado`) REFERENCES `empleado` (`idEmpleado`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ventacontado`
--

LOCK TABLES `ventacontado` WRITE;
/*!40000 ALTER TABLE `ventacontado` DISABLE KEYS */;
INSERT INTO `ventacontado` VALUES (17,'2017-04-15',1,1),(18,'2017-04-15',1,1),(19,'2017-04-15',1,1);
/*!40000 ALTER TABLE `ventacontado` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ventacredito`
--

DROP TABLE IF EXISTS `ventacredito`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ventacredito` (
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
  CONSTRAINT `fk_VentaCredito_Cliente1` FOREIGN KEY (`Cliente_idCliente`) REFERENCES `cliente` (`idCliente`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_VentaCredito_Empleado1` FOREIGN KEY (`Empleado_idEmpleado`) REFERENCES `empleado` (`idEmpleado`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ventacredito`
--

LOCK TABLES `ventacredito` WRITE;
/*!40000 ALTER TABLE `ventacredito` DISABLE KEYS */;
/*!40000 ALTER TABLE `ventacredito` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-05-15 20:02:10
