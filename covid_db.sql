--Crear la base de datos
CREATE DATABASE project_covid; 

-- Conectarse a la base de datos
\c project_covid; 

-- Crear un nuevo esquema
CREATE SCHEMA registro_pruebas_data; 

--Establecer el nuevo esquema de trabajo
SET search_path TO registro_pruebas_data, public;


CREATE TABLE departamento(
    dep_id SERIAL PRIMARY KEY,
    dep_nombre VARCHAR(45) NOT NULL
);

CREATE TABLE ips(
    ips_id SERIAL PRIMARY KEY,
    ips_nombre VARCHAR(45) NOT NULL,
    ips_clave VARCHAR(45) NOT NULL
);

CREATE TABLE dep_ips(
    depips_id SERIAL PRIMARY KEY,
    dep_id_fk INT NOT NULL,
    ips_id_fk INT NOT NULL,
    FOREIGN KEY (dep_id_fk) REFERENCES departamento(dep_id),
    FOREIGN KEY (ips_id_fk) REFERENCES ips(ips_id)
);

CREATE TABLE registros(
    reg_id SERIAL PRIMARY KEY,
    depips_id_fk INT NOT NULL,
    fecha TIMESTAMP DEFAULT NOW(),
    pruebas_positivas INT,
    pruebas_negativas INT,
    pruebas_indeterminandas INT,
    totalpruebas INT,
    FOREIGN KEY (depips_id_fk) REFERENCES dep_ips(depips_id)   
);

--CASOS DE USO

--Incersiones de prueba elementos de prueba
INSERT INTO ips(ips_nombre, ips_clave) VALUES('colsanitas', 'colsanitas123');
INSERT INTO ips(ips_nombre, ips_clave) VALUES('sura', 'sura3454');
INSERT INTO ips(ips_nombre, ips_clave) VALUES('comfama envigado', 'cfE125');

INSERT INTO departamento(dep_nombre) VALUES('Antioquia');
INSERT INTO departamento(dep_nombre) VALUES('Nariño');
INSERT INTO departamento(dep_nombre) VALUES('Huila');

INSERT INTO dep_ips(dep_id_fk, ips_id_fk) VALUES(1, 3);
INSERT INTO dep_ips(dep_id_fk, ips_id_fk) VALUES(1, 1);
INSERT INTO dep_ips(dep_id_fk, ips_id_fk) VALUES(3, 1);
INSERT INTO dep_ips(dep_id_fk, ips_id_fk) VALUES(2, 1);
INSERT INTO dep_ips(dep_id_fk, ips_id_fk) VALUES(2, 2);
INSERT INTO dep_ips(dep_id_fk, ips_id_fk) VALUES(2, 3);

INSERT INTO registros(depips_id_fk, pruebas_positivas, pruebas_negativas,pruebas_indeterminandas, totalpruebas) 
VALUES(1, 40, 30, 15, 85);
INSERT INTO registros(depips_id_fk, pruebas_positivas, pruebas_negativas,pruebas_indeterminandas, totalpruebas) 
VALUES(1, 40, 30, 15, 85);
INSERT INTO registros(depips_id_fk, pruebas_positivas, pruebas_negativas,pruebas_indeterminandas, totalpruebas) 
VALUES(1, 20, 30, 40, 90);
INSERT INTO registros(depips_id_fk, pruebas_positivas, pruebas_negativas,pruebas_indeterminandas, totalpruebas) 
VALUES(3, 20, 45, 5, 70);
INSERT INTO registros(depips_id_fk, pruebas_positivas, pruebas_negativas,pruebas_indeterminandas, totalpruebas) 
VALUES(6, 10, 10, 10, 30);

--Esta inserción debe fallar porque viola la llave foránea
INSERT INTO registros(depips_id_fk, pruebas_positivas, pruebas_negativas,pruebas_indeterminandas, totalpruebas) 
VALUES(7, 5, 45, 15, 65);

--Ejemplo uniendo tablas para ver datos del departamento y su ips
SELECT depips_id, dep_id, ips_id, dep_nombre, ips_nombre, ips_clave 
FROM dep_ips 
JOIN ips 
ON dep_ips.ips_id_fk = ips.ips_id 
JOIN departamento
ON dep_ips.dep_id_fk = departamento.dep_id
WHERE dep_nombre = 'Antioquia';

--Ejemplo que une la tabla de registro con las demás tablas
echa, depips_id, dep_nombre, ips_nombre, ips_clave, pruebas_positivas, pruebas_negativas,pruebas_indeterminandas, totalpruebas
FROM registros
JOIN dep_ips ON registros.depips_id_fk = dep_ips.depips_id
JOIN ips ON dep_ips.ips_id_fk = ips.ips_id 
JOIN departamento ON dep_ips.dep_id_fk = departamento.dep_id
WHERE dep_nombre = 'Antioquia';