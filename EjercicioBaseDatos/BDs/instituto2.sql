DROP DATABASE IF EXISTS instituto2;
CREATE DATABASE instituto2 CHARACTER SET utf8mb4;
USE instituto2;

-- Suponemos que la base de datos 'Escuela' ya está creada y seleccionada

-- Crear la tabla 'persona'
CREATE TABLE persona (
  id INT PRIMARY KEY,
  dni VARCHAR(9),
  nombre VARCHAR(25),
  apellido1 VARCHAR(60),
  apellido2 VARCHAR(60),
  ciudad VARCHAR(25),
  direccion VARCHAR(255),
  telefono VARCHAR(15),
  fecha_nacimiento DATE,
  sexo ENUM('M', 'F', 'Otro'),
  tipo ENUM('alumno', 'profesor', 'administrativo')
);

-- Crear la tabla 'departamento'
CREATE TABLE departamento (
  id INT PRIMARY KEY,
  nombre VARCHAR(45)
);

-- Crear la tabla 'profesor'
CREATE TABLE profesor (
  id_profesor INT PRIMARY KEY,
  id_departamento INT,
  FOREIGN KEY (id_profesor) REFERENCES persona(id),
  FOREIGN KEY (id_departamento) REFERENCES departamento(id)
);

-- Crear la tabla 'grado'
CREATE TABLE grado (
  id INT PRIMARY KEY,
  nombre VARCHAR(100)
);

-- Crear la tabla 'asignatura'
CREATE TABLE asignatura (
  id INT PRIMARY KEY,
  nombre VARCHAR(100),
  creditos FLOAT,
  curso TINYINT,
  cuatrimestre TINYINT,
  id_grado INT,
  FOREIGN KEY (id_grado) REFERENCES grado(id)
);

-- Crear la tabla 'curso_escolar'
CREATE TABLE curso_escolar (
  id INT PRIMARY KEY,
  anyo_inicio YEAR,
  anyo_fin YEAR
);

-- Crear la tabla 'alumno_se_matricula_asignatura'
CREATE TABLE alumno_se_matricula_asignatura (
  alumno_id INT,
  asignatura_id INT,
  id_curso_escolar INT,
  FOREIGN KEY (alumno_id) REFERENCES persona(id),
  FOREIGN KEY (asignatura_id) REFERENCES asignatura(id),
  FOREIGN KEY (id_curso_escolar) REFERENCES curso_escolar(id)
);

-- Insertar datos en 'persona'
INSERT INTO persona VALUES
(1, '12345678A', 'Laura', 'Gonzalez', 'Fernandez', 'Valencia', 'Calle Luna 45', '612345678', '1995-05-20', 'F', 'alumno'),
(2, '87654321B', 'Carlos', 'Martinez', 'Ruiz', 'Sevilla', 'Calle Sol 123', '678901234', '1980-07-15', 'M', 'profesor');

-- Insertar datos en 'departamento'
INSERT INTO departamento VALUES
(1, 'Matemáticas'),
(2, 'Ciencias Sociales');

-- Insertar datos en 'profesor'
INSERT INTO profesor VALUES
(2, 1);

-- Insertar datos en 'grado'
INSERT INTO grado VALUES
(1, 'Ingeniería Informática'),
(2, 'Historia del Arte');

-- Insertar datos en 'asignatura'
INSERT INTO asignatura VALUES
(1, 'Álgebra', 6, 1, 1, 1),
(2, 'Historia Antigua', 4, 1, 2, 2);

-- Insertar datos en 'curso_escolar'
INSERT INTO curso_escolar VALUES
(1, 2023, 2024);

-- Insertar datos en 'alumno_se_matricula_asignatura'
INSERT INTO alumno_se_matricula_asignatura VALUES
(1, 1, 1),
(1, 2, 1);


