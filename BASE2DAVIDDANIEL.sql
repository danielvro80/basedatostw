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


