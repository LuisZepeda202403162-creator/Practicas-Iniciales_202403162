CREATE DATABASE IF NOT EXISTS fiusat_rating;
USE fiusat_rating;

-- 1. Tabla USUARIO (Requerimientos: Registro académico, nombres, correo, contraseña)
CREATE TABLE usuario (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    registro_academico VARCHAR(20) NOT NULL UNIQUE,
    nombres VARCHAR(100) NOT NULL,
    apellidos VARCHAR(100) NOT NULL,
    correo VARCHAR(100) NOT NULL UNIQUE,
    contraseña VARCHAR(255) NOT NULL, -- Se guardará encriptada con bcrypt
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 2. Tabla CATEDRÁTICO
CREATE TABLE catedratico (
    id_catedratico INT AUTO_INCREMENT PRIMARY KEY,
    nombres VARCHAR(100) NOT NULL,
    apellidos VARCHAR(100) NOT NULL,
    correo VARCHAR(100)
);

-- 3. Tabla CURSO (Área de sistemas)
CREATE TABLE curso (
    id_curso INT AUTO_INCREMENT PRIMARY KEY,
    nombre_curso VARCHAR(100) NOT NULL,
    codigo_curso VARCHAR(20), -- Ej: CC101
    creditos INT,
    area VARCHAR(50) DEFAULT 'Sistemas'
);

-- 4. Tabla PUBLICACIÓN (Reseñas)
-- Puede ser sobre un curso O un catedrático 
CREATE TABLE publicacion (
    id_publicacion INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    id_curso INT NULL, -- Nullable si es solo sobre catedrático
    id_catedratico INT NULL, -- Nullable si es solo sobre curso
    mensaje TEXT NOT NULL,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario),
    FOREIGN KEY (id_curso) REFERENCES curso(id_curso),
    FOREIGN KEY (id_catedratico) REFERENCES catedratico(id_catedratico)
);

-- 5. Tabla COMENTARIO
CREATE TABLE comentario (
    id_comentario INT AUTO_INCREMENT PRIMARY KEY,
    id_publicacion INT NOT NULL,
    id_usuario INT NOT NULL,
    mensaje TEXT NOT NULL,
    fecha_comentario TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_publicacion) REFERENCES publicacion(id_publicacion),
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario)
);

-- 6. Tabla CURSO_APROBADO (N:N entre Usuario y Curso)
CREATE TABLE curso_aprobado (
    id_registro INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    id_curso INT NOT NULL,
    fecha_aprobacion DATE,
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario),
    FOREIGN KEY (id_curso) REFERENCES curso(id_curso),
    UNIQUE KEY unique_usuario_curso (id_usuario, id_curso) -- Evitar duplicados
);

-- DATOS DE PRUEBA (Seeders)
INSERT INTO curso (nombre_curso, codigo_curso, creditos) VALUES 
('Introducción a la Programación', 'CC101', 5),
('Programación 2', 'CC201', 5),
('Estructura de Datos', 'CC301', 5);

INSERT INTO catedratico (nombres, apellidos, correo) VALUES 
('Amanda', 'Avila', 'favila@usac.gt'),
('Juan', 'Perez', 'jperez@usac.gt');

-- Usuario de prueba (Contraseña: 1515 - En producción usar bcrypt)
-- Para este ejemplo insertamos texto plano, pero en el backend lo encriptaremos
INSERT INTO usuario (registro_academico, nombres, apellidos, correo, contraseña) VALUES 
('202012345', 'Ana', 'López', 'ana@gmail.com', '1515');

