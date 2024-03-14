INICIO DEL PROYECTO

comit de prueba

comit de prueba 2

/* CREACION DE TABLAS */

CREATE TABLE usuario (
    id INT PRIMARY KEY,
    nombre VARCHAR(100),
    apellidos VARCHAR(100),
    username VARCHAR(50),
    correo VARCHAR(100),
    clave_cifrada VARCHAR(100)
);

CREATE TABLE alumno (
    id INT PRIMARY KEY,
    usuario_id INT,
    FOREIGN KEY (usuario_id) REFERENCES usuario(id)
);

CREATE TABLE profesor (
    id INT PRIMARY KEY,
    usuario_id INT,
    FOREIGN KEY (usuario_id) REFERENCES usuario(id)
);

CREATE TABLE inventario (
    id INT PRIMARY KEY,
    cantidad INT,
    alumno_id INT,
    FOREIGN KEY (alumno_id) REFERENCES alumno(id)
);
CREATE TABLE tierras (
    id INT PRIMARY KEY,
    posicion VARCHAR(100),
    tipo_terreno VARCHAR(100),
    alumno_id INT,
    FOREIGN KEY (alumno_id) REFERENCES alumno(id)
);
CREATE TABLE notificaciones (
    id INT PRIMARY KEY,
    tipo VARCHAR(100),
    fecha DATE,
    vista BOOLEAN,
    alumno_id INT,
    FOREIGN KEY (alumno_id) REFERENCES alumno(id)
);

CREATE TABLE curso (
    clave INT PRIMARY KEY,
    nombre VARCHAR(100)
);

CREATE TABLE pertenecer (
    alumno_id INT,
    curso_clave INT,
    progreso INT,
    codicia INT,
    aceptado BOOLEAN,
    FOREIGN KEY (alumno_id) REFERENCES alumno(id),
    FOREIGN KEY (curso_clave) REFERENCES curso(clave)
);

CREATE TABLE tarea (
    id INT PRIMARY KEY,
    fecha DATE,
    recompensa VARCHAR(100)
);

CREATE TABLE participan (
    alumno_id INT,
    tarea_id INT,
    nota INT,
    FOREIGN KEY (alumno_id) REFERENCES alumno(id),
    FOREIGN KEY (tarea_id) REFERENCES tarea(id)
);
CREATE TABLE ranking (
    id INT PRIMARY KEY,
    tarea_id INT,
    FOREIGN KEY (tarea_id) REFERENCES tarea(id)
);
CREATE TABLE gestiona (
    profesor_id INT,  
    ranking_id INT,
    FOREIGN KEY (profesor_id) REFERENCES profesor(id),
    FOREIGN KEY (ranking_id) REFERENCES ranking(id)
);

/* CREACION DE INSERTS */

INSERT INTO usuario (id, nombre, apellidos, username, correo, clave_cifrada) VALUES
(1, 'Daniel', 'Viñuelas', 'Dani', 'DANIELVIÑUELAS@gmail.com', 'clave1'),
(2, 'David', 'Quintanilla', 'DavidLQ', 'DAVIDLOPEZ@gmail.com', 'clave2'),
(3, 'Laura', 'González', 'LauraG', 'lauragonzalez@gmail.com', 'clave3'),
(4, 'María', 'Martínez', 'MariaM', 'mariamartinez@gmail.com', 'clave4'),
(5, 'Carlos', 'Rodríguez', 'CarlosR', 'carlosrodriguez@gmail.com', 'clave5'),
(6, 'Ana', 'López', 'AnaL', 'analopez@gmail.com', 'clave6'),
(7, 'Pedro', 'García', 'PedroG', 'pedrogarcia@gmail.com', 'clave7');

INSERT INTO alumno (id, usuario_id) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7);

INSERT INTO profesor (id, usuario_id) VALUES
(3, 1);

INSERT INTO curso (clave, nombre) VALUES
(1, 'Curso1'),
(2, 'Curso2');

INSERT INTO pertenecer (alumno_id, curso_clave, progreso, codicia, aceptado) VALUES
(1, 1, 50, 2, true),
(2, 2, 75, 3, false),
(3, 1, 60, 1, false),
(4, 2, 80, 4, true),
(5, 1, 70, 3, true),
(6, 2, 85, 2, false),
(7, 1, 55, 2, true);

INSERT INTO tarea (id, fecha, recompensa) VALUES
(1, '2024-03-13', 'Recompensa1'),
(2, '2024-03-14', 'Recompensa2');

INSERT INTO participan (alumno_id, tarea_id, nota) VALUES
(1, 1, 90),
(2, 2, 80),
(3, 1, 85),
(4, 2, 75),
(5, 1, 80),
(6, 2, 90),
(7, 1, 70);

INSERT INTO ranking (id, tarea_id) VALUES
(1, 1),
(2, 2);

INSERT INTO gestiona (profesor_id, ranking_id) VALUES
(3, 1);

/* CONSULTAS SQL */

/* con esta consulta seleccionamos todos los  nombres y correos de todos los usuarios */
SELECT username , correo 
FROM usuario;

/* con esta consulta  estamos seleccionando todas las tareas y sus fechas */
SELECT id, fecha
FROM tarea;

/* con esta consulta seleccionamos todos los profesores y sus nombres de usuario*/
SELECT username
FROM usuario
WHERE id IN (SELECT usuario_id FROM profesor);

/*Seleccionar todas las notificaciones no vistas:*/

SELECT *
FROM notificaciones
WHERE vista = false;

/*Seleccionar todas las tierras y sus posiciones:*/

SELECT posicion
FROM tierras;

/*Seleccionar todas las recompensas de las tareas completadas:*/ 

SELECT DISTINCT recompensa
FROM tarea
JOIN participan ON tarea.id = participan.tarea_id;

/* con esta consulta seleccionamos todos los usuarios y sus correos por orden alfabetico de su apellido*/ 

SELECT correo
FROM usuario
ORDER BY apellidos;

/* con esta consulta seleccionamos todas las tareas completadas por un alumno concreto */

SELECT tarea.id, tarea.fecha
FROM tarea
JOIN participan ON tarea.id = participan.tarea_id
JOIN alumno ON participan.alumno_id = alumno.id
JOIN usuario ON alumno.usuario_id = usuario.id
WHERE usuario.username = 'nombre_usuario';

/* con esta consulta seleccionamos a todos los alumnos que se llaman David y  hayan completado alguna  tarea*/

SELECT u.nombre, u.apellidos
FROM usuario u
JOIN alumno a ON u.id = a.usuario_id
JOIN participan p ON a.id = p.alumno_id
JOIN tarea t ON p.tarea_id = t.id
WHERE u.nombre = 'David';

/*Seleccionar el promedio de notas de todas las tareas completadas por cada alumno:*/


SELECT a.id, AVG(p.nota) AS promedio_notas
FROM alumno a
JOIN participan p ON a.id = p.alumno_id
GROUP BY a.id;

/*Seleccionar el número total de notificaciones no vistas para cada usuario*/


SELECT u.id, COUNT(n.id) AS num_notificaciones
FROM usuario u
JOIN notificaciones n ON u.id = n.alumno_id
WHERE n.vista = false
GROUP BY u.id;

/* con esta consulta seleccionamos todos los cursos y el profesor que los imparte*/

SELECT c.nombre AS nombre_curso, u.nombre AS nombre_profesor, u.apellidos AS apellidos_profesor
FROM curso c
JOIN pertenecer p ON c.clave = p.curso_clave
JOIN profesor pr ON p.curso_clave = pr.curso_clave
JOIN usuario u ON pr.usuario_id = u.id;

/* con esta consulta seleccionamos todas las tareas , el nombre de usuario de quien las completo y su nota */

SELECT t.id, u.username, p.nota
FROM tarea t
JOIN participan p ON t.id = p.tarea_id
JOIN alumno a ON p.alumno_id = a.id
JOIN usuario u ON a.usuario_id = u.id;

/* con esta tarea  seleccionamos  todas las tareas que se han completado mas de 5 veces */

SELECT tarea.id, tarea.fecha, COUNT(participan.tarea_id) AS completadas
FROM tarea
JOIN participan ON tarea.id = participan.tarea_id
GROUP BY tarea.id
HAVING COUNT(participan.tarea_id) > 5;

/*Seleccionar todos los alumnos que están inscritos en más de un curso:*/

SELECT u.nombre, u.apellidos
FROM usuario u
JOIN alumno a ON u.id = a.usuario_id
JOIN pertenecer p ON a.id = p.alumno_id
GROUP BY u.nombre, u.apellidos
HAVING COUNT(DISTINCT p.curso_clave) > 1;

/*Seleccionar el curso con la menor cantidad de alumnos inscritos:*/

SELECT c.nombre AS nombre_curso, COUNT(p.alumno_id) AS cantidad_alumnos
FROM curso c
JOIN pertenecer p ON c.clave = p.curso_clave
GROUP BY c.nombre
ORDER BY COUNT(p.alumno_id) ASC
LIMIT 1;

/*Seleccionar el nombre de usuario del profesor y la cantidad total de alumnos inscritos en sus cursos:*/

SELECT u.username, COUNT(DISTINCT p.alumno_id) AS total_alumnos_inscritos
FROM usuario u
JOIN profesor pr ON u.id = pr.usuario_id
JOIN pertenecer p ON pr.curso_clave = p.curso_clave
GROUP BY u.username;

/* con esta tarea seleccionamos el nombre de usuario y la cantidad de tareas completadas por cada alumno, ordenados por orden descendente*/

SELECT u.username, COUNT(DISTINCT tarea_id) AS cantidad_tareas_completadas
FROM usuario u
JOIN alumno a ON u.id = a.usuario_id
JOIN participan p ON a.id = p.alumno_id
GROUP BY u.username
ORDER BY cantidad_tareas_completadas DESC;

/* con esta consulta seleccionamos  el nombre de usuario y la cantidad de cursos en los que está inscrito cada usuario, y el nombre del curso más reciente al que se ha inscrito*/


SELECT u.username, COUNT(p.curso_clave) AS cantidad_cursos_inscritos, MAX(c.nombre) AS ultimo_curso_inscrito
FROM usuario u
JOIN alumno a ON u.id = a.usuario_id
JOIN pertenecer p ON a.id = p.alumno_id
JOIN curso c ON p.curso_clave = c.clave
GROUP BY u.username;


/*  con esta consulta seleccionamos todos los usuarios cuyos nombres de usuario empiezan por la letra D . */
SELECT *
FROM usuario
WHERE username LIKE 'D%';



