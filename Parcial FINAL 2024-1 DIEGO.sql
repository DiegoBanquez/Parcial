-- Creación de la tabla proyectos
CREATE TABLE IF NOT EXISTS proyectos
(
    id_proyecto     SERIAL PRIMARY KEY,
    nombre_proyecto VARCHAR NOT NULL,
    fecha_proyecto  TIMESTAMP DEFAULT now()
);

-- Creación de la tabla empleados
CREATE TABLE IF NOT EXISTS empleados
(
    id_empleado     SERIAL PRIMARY KEY,
    nombre_empleado VARCHAR(100) NOT NULL,
    edad_empleado   INTEGER      NOT NULL
);

-- Creación de la tabla actores
CREATE TABLE IF NOT EXISTS actores
(
    id_actor     SERIAL PRIMARY KEY,
    nombre_actor VARCHAR(100) NOT NULL,
    genero_actor VARCHAR DEFAULT 'M'
);

-- Creación de la tabla locaciones
CREATE TABLE IF NOT EXISTS locaciones
(
    id_locacion          SERIAL PRIMARY KEY,
    nombre_locacion      VARCHAR NOT NULL,
    descripcion_locacion TEXT    NULL
);

-- creación de la tabla escenas
CREATE TABLE IF NOT EXISTS escenas
(
    id_escena          SERIAL PRIMARY KEY,
    nombre_escena      VARCHAR NOT NULL,
    descripcion_escena TEXT    NOT NULL,
    fk_proyecto_escena BIGINT  NOT NULL,
    fk_locacion_escena BIGINT  NOT NULL,
    FOREIGN KEY (fk_proyecto_escena) REFERENCES proyectos (id_proyecto),
    FOREIGN KEY (fk_locacion_escena) REFERENCES locaciones (id_locacion)
);

-- Creación de tabla intermedia entre actor y escena
CREATE TABLE IF NOT EXISTS actor_escena
(
    id_actor_escena        SERIAL PRIMARY KEY,
    fk_actor_actor_escena  BIGINT NOT NULL,
    fk_escena_actor_escena BIGINT NOT NULL,
    FOREIGN KEY (fk_actor_actor_escena) REFERENCES actores (id_actor),
    FOREIGN KEY (fk_escena_actor_escena) REFERENCES escenas (id_escena)
);

-- Creación de tabla intermedia entre empleados y proyectos
CREATE TABLE IF NOT EXISTS empleado_proyecto
(
    id_empleado_proyecto          SERIAL NOT NULL,
    fk_empleado_empleado_proyecto BIGINT NOT NULL,
    fk_proyecto_empleado_proyecto BIGINT NOT NULL,
    FOREIGN KEY (fk_empleado_empleado_proyecto) REFERENCES empleados (id_empleado),
    FOREIGN KEY (fk_proyecto_empleado_proyecto) REFERENCES proyectos (id_proyecto)
);



------------------------------- INICIO PRIMERA ACTIVIDAD ---------------------
/*
1. Agregar a la tabla proyectos la columna: presupuesto_proyecto de tipo NUMERIC;
2. Crear la tabla cargos para almacenar los cargos de los empleados y crear la llave foránea correspondiente.
3. Cambiar el valor por defecto de la columna genero_actor de la tabla actores por: 'SIN DEFINIR'
*/	
--------------------------------- FIN PRIMERA ACTIVIDAD -----------------------



ALTER TABLE proyectos ADD COLUMN presupuesto_proyecto NUMERIC;


CREATE TABLE IF NOT EXISTS cargos
(
    id_cargo SERIAL PRIMARY KEY,
	nombre_cargo VARCHAR(255) NOT NULL
);

ALTER TABLE empleados ADD COLUMN fk_cargo_empleado BIGINT;

ALTER TABLE empleados
ADD CONSTRAINT fk_cargo_empleado
FOREIGN KEY (fk_cargo_empleado)
REFERENCES cargos(id_cargo);


ALTER TABLE actores
ALTER COLUMN genero_actor SET DEFAULT 'SIN DEFINIR';



-- Insertar registros en la tabla cargos
INSERT INTO cargos (id_cargo, nombre_cargo)
VALUES (1, 'Director de Producción'),
       (2, 'Guionista'),
       (3, 'Director de Fotografía'),
       (4, 'Editor de Video'),
       (5, 'Diseñador de Vestuario');

-- Insertar registros en la tabla empleados
INSERT INTO empleados (id_empleado, nombre_empleado, edad_empleado, fk_cargo_empleado)
VALUES (1, 'Juan Pérez', 35, 1),      -- Director de Producción
       (2, 'María García', 28, 2),    -- Guionista
       (3, 'Carlos Martínez', 40, 3), -- Director de Fotografía
       (4, 'Laura López', 32, 4),     -- Editor de Video
       (5, 'Sofía Hernández', 30, 5), -- Diseñador de Vestuario
       (6, 'Pedro Ramírez', 38, NULL),
       (7, 'Ana Rodríguez', 26, NULL),
       (8, 'Luis González', 33, NULL),
       (9, 'María Martínez', 29, NULL),
       (10, 'José Pérez', 42, 3),     -- Director de Fotografía
       (11, 'Elena Gómez', 27, 2),    -- Guionista
       (12, 'Miguel Sánchez', 36, NULL);

-- Insertar registros en la tabla proyectos
INSERT INTO proyectos (id_proyecto, nombre_proyecto, presupuesto_proyecto)
VALUES (1, 'El Misterio del Castillo Encantado', 500000),
       (2, 'Aventuras en el Espacio Exterior', 700000),
       (3, 'La Herencia Perdida', 600000);



INSERT INTO empleado_proyecto (id_empleado_proyecto, fk_empleado_empleado_proyecto, fk_proyecto_empleado_proyecto)
VALUES
    -- Empleados con cargo asignado a proyectos
    (1, 1, 1), -- Juan Pérez (Director de Producción) en "El Misterio del Castillo Encantado"
    (2, 2, 2), -- María García (Guionista) en "Aventuras en el Espacio Exterior"
    (3, 3, 3), -- Carlos Martínez (Director de Fotografía) en "La Herencia Perdida"
    (4, 4, 1), -- Laura López (Editor de Video) en "El Misterio del Castillo Encantado"
    (5, 5, 2), -- Sofía Hernández (Diseñador de Vestuario) en "Aventuras en el Espacio Exterior"

    -- Empleados sin cargo asignado a proyectos
    (6, 6, 3), -- Pedro Ramírez en "La Herencia Perdida"
    (7, 7, 1), -- Ana Rodríguez en "El Misterio del Castillo Encantado"
    (8, 8, 2); -- Luis González en "Aventuras en el Espacio Exterior"


-- Insertar registros en la tabla locaciones
INSERT INTO locaciones (id_locacion, nombre_locacion, descripcion_locacion)
VALUES (1, 'Castillo de San Jorge',
        'Antiguo castillo ubicado en las colinas de Andalucía. Escenario principal de "El Misterio del Castillo Encantado"'),
       (2, 'Estación Espacial Alpha',
        'Avanzada estación espacial en órbita alrededor de la Tierra. Escenario principal de "Aventuras en el Espacio Exterior"'),
       (3, 'Granja de los Smith',
        'Tranquila granja en el campo con extensos campos de cultivo. Escenario secundario de "El Misterio del Castillo Encantado"'),
       (4, 'Paisaje Lunar',
        'Desolado paisaje lunar con cráteres y montañas. Escenario principal de "Aventuras en el Espacio Exterior"'),
       (5, 'Mansión de los Montenegro',
        'Elegante mansión en los suburbios de la ciudad. Escenario principal de "La Herencia Perdida"');


-- Insertar registros en la tabla escenas
INSERT INTO escenas (id_escena, nombre_escena, descripcion_escena, fk_proyecto_escena, fk_locacion_escena)
VALUES
    -- Escenas para "El Misterio del Castillo Encantado"
    (1, 'Descubrimiento en el Salón Principal',
     'Los protagonistas descubren un antiguo secreto en el salón principal del castillo.', 1, 1),
    (2, 'Escape de los Túneles Subterráneos',
     'Los personajes escapan de los túneles subterráneos del castillo mientras son perseguidos por una fuerza maligna.',
     1, 1),
    (3, 'Confrontación en la Torre del Castillo',
     'Una emocionante confrontación tiene lugar en la cima de la torre del castillo.', 1, 1),

    -- Escenas para "Aventuras en el Espacio Exterior"
    (4, 'Aterrizaje en la Superficie Lunar',
     'La tripulación aterriza en la superficie lunar para explorar un misterioso fenómeno.', 2, 4),
    (5, 'Encuentro con Extraterrestres',
     'Los personajes tienen un encuentro inesperado con una civilización alienígena en la estación espacial abandonada.',
     2, 2),
    (6, 'Huida de la Estación Espacial',
     'Los protagonistas escapan de la estación espacial justo antes de que se autodestruya.', 2, 2),

    -- Escenas para "La Herencia Perdida"
    (7, 'Recepción en la Mansión',
     'Los personajes asisten a una recepción en la mansión para celebrar la lectura del testamento.', 3, 5),
    (8, 'Descubrimiento en el Desván',
     'Un importante descubrimiento se realiza en el desván de la mansión, revelando secretos sobre la familia.', 3, 5),
    (9, 'Confrontación en el Jardín',
     'Una intensa confrontación tiene lugar en los exuberantes jardines de la mansión.', 3, 5);


-- Insertar registros en la tabla actores
INSERT INTO actores (id_actor, nombre_actor, genero_actor)
VALUES (1, 'María González', 'F'),         -- Actriz femenina
       (2, 'Javier López', 'M'),           -- Actor masculino
       (3, 'Ana Martínez', 'F'),           -- Actriz femenina
       (4, 'Carlos Sánchez', 'M'),         -- Actor masculino
       (5, 'Patricia Rodríguez', DEFAULT), -- Género: Sin definir
       (6, 'Alejandro Gómez', DEFAULT),    -- Género: Sin definir
       (7, 'Laura Martín', 'F'),           -- Actriz femenina
       (8, 'Pablo Ruiz', 'M'),             -- Actor masculino
       (9, 'Carmen Díaz', 'F'),            -- Actriz femenina
       (10, 'David López', 'M'),           -- Actor masculino
       (11, 'Elena Pérez', DEFAULT);       -- Género: Sin definir


INSERT INTO actor_escena (fk_actor_actor_escena, fk_escena_actor_escena)
VALUES
    -- Actores en escenas de "El Misterio del Castillo Encantado"
    (1, 1),  -- María González en "Descubrimiento en el Salón Principal"
    (2, 1),  -- Javier López en "Descubrimiento en el Salón Principal"
    (3, 1),  -- Ana Martínez en "Descubrimiento en el Salón Principal"
    (5, 2),  -- Patricia Rodríguez en "Escape de los Túneles Subterráneos"
    (6, 3),  -- Alejandro Gómez en "Confrontación en la Torre del Castillo"

    -- Actores en escenas de "Aventuras en el Espacio Exterior"
    (7, 4),  -- Laura Martín en "Aterrizaje en la Superficie Lunar"
    (9, 5),  -- Carmen Díaz en "Encuentro con Extraterrestres"
    (10, 6), -- David López en "Huida de la Estación Espacial"

    -- Actores en escenas de "La Herencia Perdida"
    (11, 7), -- Elena Pérez en "Recepción en la Mansión"
    (1, 8),  -- María González en "Descubrimiento en el Desván"
    (3, 8);  -- Ana Martínez en "Descubrimiento en el Desván"
	



------------------------- INICIO SEGUNDA ACTIVIDAD ------------------------
/*
Generar las consultas SQL que entreguen los resultados solicitados:

1. Obtener todos los datos de los empleados que tengan más de 30 años y menos de 50 años.
2. Obtener el nombre de TODOS los empleados y de los proyectos en los que trabajan.
3. Obtener los empleados que el cargo sea Guionista, pero no estén en ningún proyecto.
4. Nombre de los actores que NO participan en alguna escena.
5. Obtener el nombre de los actores, el nombre de la escena en la que participan, el proyecto al que pertenece la escena y el nombre de la locación en la que se desarrolla la escena.
6. Nombre de los actores que NO participan en escenas del proyecto 'El Misterio del Castillo Encantado'
7. Obtener el nombre de los actores, nombre y la descripción de las escenas donde los actores de éstas sean de género femenino o sean de genero másculino, tengan entre 25 y 35 años, y que el nombre de la escena contenga la preposición "en" en cualquier posición.
*/
-------------------------- FIN SEGUNDA ACTIVIDAD ------------------------

SELECT * FROM empleados WHERE edad_empleado BETWEEN 31 AND 49;

SELECT empleados.nombre_empleado, proyectos.nombre_proyecto
FROM empleados
INNER JOIN empleado_proyecto ON empleados.id_empleado = empleado_proyecto.fk_empleado_empleado_proyecto
INNER JOIN proyectos ON empleado_proyecto.fk_proyecto_empleado_proyecto = proyectos.id_proyecto;

SELECT empleados.nombre_empleado
FROM empleados 
LEFT JOIN empleado_proyecto ON empleados.id_empleado = empleado_proyecto.fk_empleado_empleado_proyecto
WHERE empleados.fk_cargo_empleado = 2
AND empleado_proyecto.fk_proyecto_empleado_proyecto IS NULL;

SELECT actores.nombre_actor
FROM actores
LEFT JOIN actor_escena ON actores.id_actor = actor_escena.fk_actor_actor_escena
WHERE actor_escena.fk_actor_actor_escena IS NULL;

SELECT
actores.nombre_actor,
escenas.nombre_escena,
proyectos.nombre_proyecto,
locaciones.nombre_locacion
FROM actores
INNER JOIN actor_escena ON actores.id_actor = actor_escena.fk_actor_actor_escena
INNER JOIN escenas ON actor_escena.fk_escena_actor_escena = escenas.id_escena
INNER JOIN proyectos ON escenas.fk_proyecto_escena = proyectos.id_proyecto
INNER JOIN locaciones ON escenas.fk_locacion_escena = locaciones.id_locacion;

SELECT DISTINCT actores.nombre_actor
FROM actores
WHERE actores.id_actor NOT IN (
SELECT actores.id_actor
FROM actores
INNER JOIN actor_escena ON actores.id_actor = actor_escena.fk_actor_actor_escena
INNER JOIN escenas ON actor_escena.fk_escena_actor_escena = escenas.id_escena
INNER JOIN proyectos ON escenas.fk_proyecto_escena = proyectos.id_proyecto
WHERE proyectos.nombre_proyecto = 'El Misterio del Castillo Encantado'
);

/* Profe, en la 7 los actores no tienen edad, entonces pues le dejo este pedazo sin esa condición */
SELECT actores.nombre_actor, escenas.nombre_escena, escenas.descripcion_escena
FROM actores 
JOIN actor_escena  ON actores.id_actor = actor_escena.fk_actor_actor_escena
JOIN escenas  ON actor_escena.fk_escena_actor_escena = escenas.id_escena
WHERE (actores.genero_actor = 'F' OR actores.genero_actor = 'M')
AND escenas.nombre_escena LIKE '% en %';