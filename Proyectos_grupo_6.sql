CREATE DATABASE IF NOT EXISTS ag2_proyecto;

USE ag2_proyecto;

/* Desactivamos la integridad referencial */

SET foreign_key_checks = 0;

/* Creamos las tablas y realizamos Bulk Insert masivos de los datos de cada tabla */

CREATE TABLE IF NOT EXISTS `Empleados` ( 
									`IdEmpleado` INT(11) NOT NULL,
									`Nombre` VARCHAR(25) NOT NULL,
									`Apellidos` VARCHAR(25) NOT NULL,
									`Sexo` CHAR(1) NOT NULL,
									`Municipio` VARCHAR(50) NOT NULL,
									`Fecha_nac` DATE NOT NULL,
									`Sueldo` INT(11) NOT NULL,
									`Idpto` INT(11) NOT NULL
									);
                                    
INSERT INTO `Empleados` (`IdEmpleado`, `Nombre`, `Apellidos`, `sexo`, `Municipio`, `Fecha_nac`, `Sueldo`, `Idpto`) 
VALUES
	(10478, 'Alberto', 'Pérez López', 'M', 'Madrid', '1965-09-12', 1500, 1),
	(10479, 'Gloria', 'Ruiz Ruiz', 'F', 'Sevilla', '1968-06-12', 1650, 2),
	(10480, 'Antonio', 'García Montero', 'M', 'Madrid', '1969-10-12', 1350, 1),
	(10481, 'Ana', 'López Ramírez', 'F', 'Sevilla', '1970-05-12', 1250, 3),
	(10482, 'Eduardo', 'Chicón Terrales', 'M', 'Córdoba', '1920-05-12', 1470, 2);
    
CREATE TABLE IF NOT EXISTS `Proyectos`(
									`IdProyecto` INT(11) NOT NULL,
									`Nombre` VARCHAR (25) NOT NULL,
									`Fecha_ini` DATE NOT NULL,
									`Fecha_Fin` DATE NOT NULL
									);
INSERT INTO `Proyectos` (`IdProyecto`, `Nombre`, `Fecha_ini`, `Fecha_fin`)
VALUES
	(1, 'SINUBE','2018-09-12', '2019-09-12'),
	(2, 'TRASPI', '2017-09-12', '2019-09-12'),
	(3, 'RUNTA', '2016-09-12', '2019-09-12'),
	(4, 'CARTAL', '2019-05-12', '2019-09-12');
    
CREATE TABLE IF NOT EXISTS `Departamentos`(
										`Idpto` INT(11) NOT NULL,
										`Nombre` VARCHAR(25) NOT NULL,
										`Presupuestos` INT(11) NOT NULL
										);
INSERT INTO `Departamentos` (`Idpto`, `Nombre`, `Presupuestos`)
VALUES
	(1, 'I+D', 50000),
	(2, 'Diseño', 25000),
	(3, 'Ventas', 15000),
	(4, 'Marketing', 10000);
    
CREATE TABLE IF NOT EXISTS `Asignacion`(
									`IdEmpleado` INT(11) NOT NULL,
									`IdProyecto` INT(11) NOT NULL
									);
INSERT INTO `Asignacion` (`IdEmpleado`, `IdProyecto`)
	VALUES
	(10478, 1),
    (10480, 3),
    (10481, 1),
    (10482, 2);
                                    
/* Realizamos alter table para asignar las claves primarias de cada tabla */ 

ALTER TABLE `Empleados`
	ADD PRIMARY KEY (`IdEmpleado`);

ALTER TABLE `Proyectos`
	ADD PRIMARY KEY (`IdProyecto`, `Nombre`);

ALTER TABLE `Departamentos`
	ADD PRIMARY KEY (`Idpto`);
    
/* Realizamos alter table para asignar las foreign Key y para activar las clausulas de consistencia */

ALTER TABLE `Empleados`
	ADD CONSTRAINT `Empleados_ibfk_1` FOREIGN KEY (`Idpto`) REFERENCES `departamentos` (`Idpto`) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE `Asignacion`
	ADD CONSTRAINT `Asignacion_ibfk_3` FOREIGN KEY (`IdEmpleado`) REFERENCES `Empleados` (`IdEmpleado`) ON DELETE NO ACTION ON UPDATE NO ACTION,	
    ADD CONSTRAINT `Asignacion_ibfk_2` FOREIGN KEY (`IdProyecto`) REFERENCES `Proyectos` (`IdProyecto`) ON DELETE NO ACTION ON UPDATE NO ACTION;

/* Activamos la integridad referencial */

SET foreign_key_checks = 1;

/* Hacemos commit para guardar los cambios */

COMMIT;


   





