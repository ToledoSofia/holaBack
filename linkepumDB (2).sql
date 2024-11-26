-- MySQL Workbench Forward Engineering
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Linkepum
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Linkepum
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Linkepum` DEFAULT CHARACTER SET ascii ;
USE `Linkepum` ;

-- -----------------------------------------------------
-- Table `Linkepum`.`Grupos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Linkepum`.`Grupos` (
  `idGrupos` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(150) NOT NULL,
  `descripcion` VARCHAR(300) NULL,
  `fecha_creacion` DATE NULL,
  `promedio_rankin` VARCHAR(45) NULL,
  ubicacion varchar(100),
  `usuario` VARCHAR(50) NOT NULL,
  `contrasena` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`idGrupos`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Linkepum`.`Musico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Linkepum`.`Musico` (
  `idMusico` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(100) NOT NULL,
  `apellido` VARCHAR(100) NULL,
  `descripcion` VARCHAR(300) NULL,
  ubicacion varchar(100),
  `usuario` VARCHAR(50) NOT NULL,
  `contrasena` VARCHAR(100) NOT NULL,
  foto_perfil VARCHAR(500),
  foto_portada varchar(500),
  PRIMARY KEY (`idMusico`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Linkepum`.`Instrumento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Linkepum`.`Instrumento` (
  `idInstrumento` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `tipo_instrumento` VARCHAR(45) NULL,
  PRIMARY KEY (`idInstrumento`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Linkepum`.`grupos_musicos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Linkepum`.`grupos_musicos` (
  `idAsociacion` INT NOT NULL AUTO_INCREMENT,
  `Grupos_idGrupos` INT NOT NULL,
  `Musico_idMusico` INT NOT NULL,
  PRIMARY KEY (`idAsociacion`, `Grupos_idGrupos`, `Musico_idMusico`),
  INDEX `fk_grupos_musicos_Musico1_idx` (`Musico_idMusico` ASC) VISIBLE,
  CONSTRAINT `fk_grupos_musicos_Grupos`
    FOREIGN KEY (`Grupos_idGrupos`)
    REFERENCES `Linkepum`.`Grupos` (`idGrupos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_grupos_musicos_Musico1`
    FOREIGN KEY (`Musico_idMusico`)
    REFERENCES `Linkepum`.`Musico` (`idMusico`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Linkepum`.`musico_instrumento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Linkepum`.`musico_instrumento` (
  `Musico_idMusico` INT NOT NULL,
  `Instrumento_idInstrumento` INT NOT NULL,
  PRIMARY KEY (`Musico_idMusico`, `Instrumento_idInstrumento`),
  INDEX `fk_musico_instrumento_Instrumento1_idx` (`Instrumento_idInstrumento` ASC) VISIBLE,
  CONSTRAINT `fk_musico_instrumento_Musico1`
    FOREIGN KEY (`Musico_idMusico`)
    REFERENCES `Linkepum`.`Musico` (`idMusico`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_musico_instrumento_Instrumento1`
    FOREIGN KEY (`Instrumento_idInstrumento`)
    REFERENCES `Linkepum`.`Instrumento` (`idInstrumento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Linkepum`.`Solicitud`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Linkepum`.`Solicitud` (
  `idSolicitud` INT NOT NULL AUTO_INCREMENT,
  `fecha_solicitud` DATETIME NOT NULL,
  `grupo` INT NOT NULL,
  `musico` INT NOT NULL,
  `tipo` VARCHAR(45) NOT NULL,
  `estado` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idSolicitud`, `grupo`, `musico`),
  INDEX `fk_Solicitud_Grupos1_idx` (`grupo` ASC) VISIBLE,
  INDEX `fk_Solicitud_Musico1_idx` (`musico` ASC) VISIBLE,
  CONSTRAINT `fk_Solicitud_Grupos1`
    FOREIGN KEY (`grupo`)
    REFERENCES `Linkepum`.`Grupos` (`idGrupos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Solicitud_Musico1`
    FOREIGN KEY (`musico`)
    REFERENCES `Linkepum`.`Musico` (`idMusico`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Linkepum`.`Publicacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Linkepum`.`Publicacion` (
  `idPublicacion` INT NOT NULL AUTO_INCREMENT,
  `imagen` VARCHAR(500) NULL,
  `texto` VARCHAR(100) NULL,
  `fecha_publicacion` VARCHAR(45) NOT NULL,
  `Grupos_idGrupos` INT NOT NULL,
  `Musico_idMusico` INT NOT NULL,
  PRIMARY KEY (`idPublicacion`),
  INDEX `fk_Publicacion_Grupos1_idx` (`Grupos_idGrupos` ASC) VISIBLE,
  INDEX `fk_Publicacion_Musico1_idx` (`Musico_idMusico` ASC) VISIBLE,
  CONSTRAINT `fk_Publicacion_Grupos1`
    FOREIGN KEY (`Grupos_idGrupos`)
    REFERENCES `Linkepum`.`Grupos` (`idGrupos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Publicacion_Musico1`
    FOREIGN KEY (`Musico_idMusico`)
    REFERENCES `Linkepum`.`Musico` (`idMusico`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Linkepum`.`Rol`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Linkepum`.`Rol` (
  `idRol` INT NOT NULL AUTO_INCREMENT,
  `Instrumento_idInstrumento` INT NOT NULL,
  `grupos_musicos_idAsociacion` INT NOT NULL,
  PRIMARY KEY (`idRol`, `Instrumento_idInstrumento`, `grupos_musicos_idAsociacion`),
  INDEX `fk_Rol_Instrumento1_idx` (`Instrumento_idInstrumento` ASC) VISIBLE,
  INDEX `fk_Rol_grupos_musicos1_idx` (`grupos_musicos_idAsociacion` ASC) VISIBLE,
  CONSTRAINT `fk_Rol_Instrumento1`
    FOREIGN KEY (`Instrumento_idInstrumento`)
    REFERENCES `Linkepum`.`Instrumento` (`idInstrumento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Rol_grupos_musicos1`
    FOREIGN KEY (`grupos_musicos_idAsociacion`)
    REFERENCES `Linkepum`.`grupos_musicos` (`idAsociacion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Linkepum`.`Ranking`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Linkepum`.`Ranking` (
  `idRanking` INT NOT NULL AUTO_INCREMENT,
  `cantidad` FLOAT NULL,
  `Grupos_idGrupos` INT NOT NULL,
  `Musico_idMusico` INT NOT NULL,
  PRIMARY KEY (`idRanking`),
  INDEX `fk_Ranking_Grupos1_idx` (`Grupos_idGrupos` ASC) VISIBLE,
  INDEX `fk_Ranking_Musico1_idx` (`Musico_idMusico` ASC) VISIBLE,
  CONSTRAINT `fk_Ranking_Grupos1`
    FOREIGN KEY (`Grupos_idGrupos`)
    REFERENCES `Linkepum`.`Grupos` (`idGrupos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Ranking_Musico1`
    FOREIGN KEY (`Musico_idMusico`)
    REFERENCES `Linkepum`.`Musico` (`idMusico`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

use Linkepum;
select * from Musico;
