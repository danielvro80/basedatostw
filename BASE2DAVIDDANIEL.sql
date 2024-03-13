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