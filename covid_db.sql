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
    reg_fecha TIMESTAMP DEFAULT NOW(),
    reg_pruebas_positivas INT,
    reg_pruebas_negativas INT,
    reg_pruebas_indeterminandas INT,
    reg_totalpruebas INT,
    FOREIGN KEY (depips_id_fk) REFERENCES dep_ips(depips_id)   
);
