-- Empresa Stanislavski Spa.
-- USE below structure to execute, make sure to change "user" by your database user.
-- psql < script.sql -U "user"

-- Drop database.
DROP DATABASE blog;

-- 1) Create database.
CREATE DATABASE blog;

-- Connect to database.
\c blog

-- 2) Create table usuarios.
CREATE TABLE usuarios(
    id_usuario SERIAL PRIMARY KEY,
    email VARCHAR(30) UNIQUE
);

-- 2) Create table posts.
CREATE TABLE posts(
    id_post SERIAL PRIMARY KEY,
    titulo VARCHAR(30),
    fecha DATE,
    usuario_id INT,
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id_usuario)
);

-- 2) Create table comentarios.
CREATE TABLE comentarios(
    id_comentario SERIAL PRIMARY KEY,
    texto VARCHAR(255),
    fecha DATE,
    post_id INT,
    usuario_id INT,
    FOREIGN KEY (post_id) REFERENCES posts(id_post),
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id_usuario)
);

-- 3) Insert usuarios.
INSERT INTO usuarios (email) VALUES ('usuario01@hotmail.com');
INSERT INTO usuarios (email) VALUES ('usuario02@gmail.com');
INSERT INTO usuarios (email) VALUES ('usuario03@gmail.com');
INSERT INTO usuarios (email) VALUES ('usuario04@hotmail.com');
INSERT INTO usuarios (email) VALUES ('usuario05@yahoo.com');
INSERT INTO usuarios (email) VALUES ('usuario06@hotmail.com');
INSERT INTO usuarios (email) VALUES ('usuario07@yahoo.com');
INSERT INTO usuarios (email) VALUES ('usuario08@yahoo.com');
INSERT INTO usuarios (email) VALUES ('usuario09@yahoo.com');

-- 3) Insert Posts.
INSERT INTO posts (titulo, fecha, usuario_id) VALUES ('Post 1: Esto es malo', '2020-06-29', 1);
INSERT INTO posts (titulo, fecha, usuario_id) VALUES ('Post 2: Esto es malo', '2020-06-20', 5);
INSERT INTO posts (titulo, fecha, usuario_id) VALUES ('Post 3: Esto es excelente', '2020-05-30', 1);
INSERT INTO posts (titulo, fecha, usuario_id) VALUES ('Post 4: Esto es bueno', '2020-05-09', 9);
INSERT INTO posts (titulo, fecha, usuario_id) VALUES ('Post 5: Esto es bueno', '2020-07-10', 7);
INSERT INTO posts (titulo, fecha, usuario_id) VALUES ('Post 6: Esto es excelente', '2020-07-18', 5);
INSERT INTO posts (titulo, fecha, usuario_id) VALUES ('Post 7: Esto es excelente', '2020-07-07', 8);
INSERT INTO posts (titulo, fecha, usuario_id) VALUES ('Post 8: Esto es excelente', '2020-05-14', 5);
INSERT INTO posts (titulo, fecha, usuario_id) VALUES ('Post 9: Esto es bueno', '2020-05-08', 2);
INSERT INTO posts (titulo, fecha, usuario_id) VALUES ('Post 10: Esto es bueno', '2020-06-02', 6);
INSERT INTO posts (titulo, fecha, usuario_id) VALUES ('Post 11: Esto es bueno', '2020-05-05', 4);
INSERT INTO posts (titulo, fecha, usuario_id) VALUES ('Post 12: Esto es malo', '2020-07-23', 9);
INSERT INTO posts (titulo, fecha, usuario_id) VALUES ('Post 13: Esto es excelente', '2020-05-30', 5);
INSERT INTO posts (titulo, fecha, usuario_id) VALUES ('Post 14: Esto es excelente', '2020-05-01', 8);
INSERT INTO posts (titulo, fecha, usuario_id) VALUES ('Post 15: Esto es malo', '2020-06-17', 7);

-- 3) Insert Comentarios.
INSERT INTO comentarios(texto, fecha, post_id, usuario_id) VALUES ('Este es el comentario 1', '2020-07-08', 6, 3);
INSERT INTO comentarios(texto, fecha, post_id, usuario_id) VALUES ('Este es el comentario 2', '2020-06-07', 2, 4);
INSERT INTO comentarios(texto, fecha, post_id, usuario_id) VALUES ('Este es el comentario 3', '2020-06-16', 4, 6);
INSERT INTO comentarios(texto, fecha, post_id, usuario_id) VALUES ('Este es el comentario 4', '2020-06-15', 13, 2);
INSERT INTO comentarios(texto, fecha, post_id, usuario_id) VALUES ('Este es el comentario 5', '2020-05-14', 6, 6);
INSERT INTO comentarios(texto, fecha, post_id, usuario_id) VALUES ('Este es el comentario 6', '2020-07-08', 3, 3);
INSERT INTO comentarios(texto, fecha, post_id, usuario_id) VALUES ('Este es el comentario 7', '2020-05-22', 1, 6);
INSERT INTO comentarios(texto, fecha, post_id, usuario_id) VALUES ('Este es el comentario 8', '2020-07-09', 7, 6);
INSERT INTO comentarios(texto, fecha, post_id, usuario_id) VALUES ('Este es el comentario 9', '2020-06-30', 13, 8);
INSERT INTO comentarios(texto, fecha, post_id, usuario_id) VALUES ('Este es el comentario 10', '2020-06-19', 6, 8);
INSERT INTO comentarios(texto, fecha, post_id, usuario_id) VALUES ('Este es el comentario 11', '2020-05-09', 1, 5);
INSERT INTO comentarios(texto, fecha, post_id, usuario_id) VALUES ('Este es el comentario 12', '2020-06-17', 15, 8);
INSERT INTO comentarios(texto, fecha, post_id, usuario_id) VALUES ('Este es el comentario 13', '2020-05-01', 9, 1);
INSERT INTO comentarios(texto, fecha, post_id, usuario_id) VALUES ('Este es el comentario 14', '2020-05-31', 5, 2);
INSERT INTO comentarios(texto, fecha, post_id, usuario_id) VALUES ('Este es el comentario 15', '2020-06-28', 3, 4);

-- 4) Select email, id, titulo of all the posts published from user 5.
SELECT usuarios.email, usuarios.id_usuario, posts.titulo
FROM usuarios
INNER JOIN posts
ON usuarios.id_usuario=posts.usuario_id
WHERE usuarios.id_usuario=5;

-- 5) Show all the emails, ids and text comments that wasn't performed by user email "usuario06@hotmail.com".
SELECT usuarios.email, usuarios.id_usuario, comentarios.texto
FROM comentarios
LEFT JOIN usuarios
ON comentarios.usuario_id=usuarios.id_usuario
WHERE usuarios.email NOT IN ('usuario06@hotmail.com');

-- 6) Show the usuarios that haven't publish any post.
SELECT usuarios.email, usuarios.id_usuario, posts.titulo, posts.fecha, posts.usuario_id, posts.id_post
FROM usuarios
LEFT JOIN posts
ON usuarios.id_usuario=posts.usuario_id
WHERE posts.titulo IS NULL AND posts.fecha IS NULL AND posts.usuario_id IS NULL AND posts.id_post IS NULL
ORDER BY usuarios.id_usuario DESC;

-- 7) Show all the posts and their comments, including these that do not have any comment.
SELECT posts.titulo, posts.fecha, comentarios.texto, comentarios.fecha
FROM posts
FULL OUTER JOIN comentarios
ON posts.id_post=comentarios.post_id;

-- 8) Show all the users who have published a post in June.
SELECT usuarios.id_usuario, usuarios.email, posts.titulo, posts.fecha
FROM usuarios
INNER JOIN posts
ON usuarios.id_usuario=posts.usuario_id
WHERE posts.fecha BETWEEN '2020-06-01' AND '2020-06-30'
ORDER BY posts.fecha;
