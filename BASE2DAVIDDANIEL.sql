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


