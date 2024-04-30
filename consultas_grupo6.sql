use ag2_proyecto;

-- 1. Extraer tablas con comandos de selección --

SELECT * -- seleccionar todo
FROM `asignacion`; -- de la tabla asignacion

SELECT * -- seleccionar todo
FROM `empleados`; -- de la tabla empleados

SELECT * -- seleccionar todo
FROM `proyectos`; --  de la tabla proyectos

SELECT * -- seleccionar todo 
FROM `departamentos`; -- de la tabla departamentos

-- 2. Lista de `proyectos a partir de Marzo de 2019 --

SELECT `nombre`, `fecha_ini` AS `Fecha de incio del proyecto` -- seleccionar nombre y fecha_ini con alias (fecha de inicio del proyecto)
FROM `Proyectos` --  de la tabla proyectos
WHERE (fecha_ini >= '2019-03-12'); -- que empiecen a partir de marzo del último año

-- 3. Listado de empleados con el apellido "López" --

SELECT `apellidos` -- seleccionar de la columna apellidos
FROM `empleados` -- de la tabla empleados
WHERE (apellidos LIKE '%López%'); -- los empleados que contengan López en el apellido

-- 4, 5.  Muestra el nombre del proyecto del empleado "10480" -- 

SELECT `idproyecto` -- seleccionar todas la columna idproyecto
FROM `Asignacion` -- de la tabla asignacion
WHERE (idempleado = 10480); -- para saber a que idproyecto corresponde el empleado 10480

SELECT `nombre`, `idproyecto` -- seleccionar las columnas nombre, idproyecto
FROM `proyectos` -- de la tabla proyectos
WHERE (idproyecto = 3); -- con el idproyecto numero 3, para saber el nombre del proyecto al cual esta asignado el empleado 10480

-- 6. Sacar un listado de los empleados que sean de Madrid o Córdoba con dos select diferentes-- 

SELECT * -- seleccionamos todas las columnas
FROM `empleados` -- de la tabla empleados
WHERE (municipio = 'Madrid' or municipio = 'Córdoba'); -- y que su municipio sea "Madrid" o "Córdoba"

SELECT * -- seleccionamos el idempleado
FROM `empleados` -- de la tabla empleados 
WHERE `municipio`IN ('Madrid', 'Cordoba'); -- con municipio en "Madrid" o "Cordoba"

-- 7. Listado de empleados con sueldo entre 1300 y 1550 --

SELECT * -- seleccionamos todos
FROM `empleados` --  de la tabla empleados
WHERE (sueldo >= 1300) AND (sueldo <= 1550); -- con un sueldo entre 1300 y 1550 euros

-- 8. Ordena los empleados por fecha de nacimiento descendente que hayan nacido despues de 1976 -- 

SELECT * -- Seleccionar todo
FROM `empleados` -- de la tabla empleados
WHERE year(fecha_nac > 1976) -- donde hayan nacido después de 1976
ORDER BY `fecha_nac` DESC; -- y ordenados por fecha de nacimiento en orden descendente. (no hay ninguno que cumpla los requisitos)

-- 9. sumar 5000 Euros al presupuesto de marketing--

UPDATE `departamentos` -- Modificar la tabla departamentos
SET presupuestos = presupuestos + 5000 -- sumando 5000 euros
WHERE Idpto=(SELECT `idpto` -- seleccionando el idpto
			FROM `departamentos` -- de la tabla departamento
            WHERE nombre = 'Marketing' ); -- que corresponde al nombre de "Marketing"

-- 10. Se cambia de proyecto a "Alberto Perez Lopez" ahora tendrá asignado el proyecto "RUNTA" --

UPDATE Asignacion -- Modificar la tabla asignación
SET IdProyecto = (SELECT IdProyecto -- poniendo aquel Id de proyecto 
                  FROM Proyectos -- de la tabla proyectos
                  WHERE Nombre = 'RUNTA') -- que corresponda al proyecto de nombre Runta
WHERE IdEmpleado = (SELECT IdEmpleado -- para el Id de empleado
					FROM Empleados -- de la tabla empleados
					WHERE (Nombre = 'Alberto') and (Apellidos = 'Pérez López')); -- que corresponda a nombre Alberto y a los apellidos Pérez López 

-- 11. Quitar asignación del proyecto a "Antonio García Montero" -- 

DELETE FROM Asignacion  -- Borrar la asignación
 WHERE IdEmpleado = (SELECT IdEmpleado -- del Id de Empleado 
                    FROM Empleados -- de la tabla empleados
                    WHERE (Nombre = 'Antonio') AND (Apellidos = 'García Montero')); -- que corresponde al nombre Antonio y a los apellidos García Montero
                    
-- 12. Todos los empleados del departamento Diseño cuyo sueldo sea más de 1500 euros --

SELECT * -- seleccionar todas las columnas
FROM Empleados -- de la tabla Empleados
WHERE (sueldo>1500) AND IdPto = (SELECT IdPto -- cuyo sueldo sea mayor de 1500 euros y su id de departamento
                                FROM Departamentos -- de la tabla departamentos
                                WHERE Nombre = 'Diseño'); -- corresponda a aquel departamento que tenga el nombre Diseño.
                                
                                
-- 13. Incrementar en un 5% el sueldo de los empleados de I+D  que ganen menos de 1400 Euros--

UPDATE Empleados -- Modificar tabla Empleados
SET Sueldo= Sueldo*1.05 -- incrementando el sueldo en un 5%
WHERE (sueldo<1400) AND IdPto = (SELECT IdPto -- En aquellos sueldos que sean inferiores a 1400 euros y cuyo id de departamento
                        FROM Departamentos -- de la tabla departamentos
                        WHERE Nombre = 'I+D'); -- corresponda a aquel departamento que tiene el nombre de I+D
