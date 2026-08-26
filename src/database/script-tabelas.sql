DROP USER IF EXISTS 'user_admin'@'localhost';
CREATE USER 'user_admin'@'localhost' IDENTIFIED BY 'SPTech#2026';
GRANT ALL PRIVILEGES ON nautilus.* TO 'user_admin'@'localhost';
FLUSH PRIVILEGES;

DROP DATABASE IF EXISTS nautilus;
CREATE DATABASE nautilus;
USE nautilus;

CREATE TABLE empresa(
	id INT PRIMARY KEY AUTO_INCREMENT,
    razao_social VARCHAR(45),
    cnpj CHAR(14),
    dt_registro DATE
);

CREATE TABLE endereco(
	id INT PRIMARY KEY AUTO_INCREMENT,
    numero VARCHAR(10),
    cidade VARCHAR(45),
    estado CHAR(2),
    logradouro VARCHAR(100),
    empresa_fk INT NOT NULL,
    FOREIGN KEY (empresa_fk) REFERENCES empresa(id)
);

CREATE TABLE ambiente_hpc(
	id_ambiente_hpc INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45),
    descricao VARCHAR(45),
    status VARCHAR(45),
    empresa_fk INT NOT NULL,
    FOREIGN KEY (empresa_fk) REFERENCES empresa(id)
);

CREATE TABLE cluster(
	id_cluster INT PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR(45),
    descricao VARCHAR(45),
    status VARCHAR(45),
    ambiente_hpc_fk INT NOT NULL,
    FOREIGN KEY (ambiente_hpc_fk) REFERENCES ambiente_hpc(id_ambiente_hpc)
);

CREATE TABLE node(
	id_node INT PRIMARY KEY AUTO_INCREMENT,
    hostname VARCHAR(45),
    ip VARCHAR(45),
    status VARCHAR(45),
    sistema_operacional VARCHAR(45),
    cluster_fk INT NOT NULL,
    FOREIGN KEY (cluster_fk) REFERENCES cluster(id_cluster)
);

CREATE TABLE componente(
	id_componente INT PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR(45),
	comando_parametro VARCHAR(45),
	unidade VARCHAR(45)
);

CREATE TABLE nivel_acesso(
	id_nivel_acesso INT PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR(45)
);

CREATE TABLE permissao(
	id_permissao INT PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR(45),
	descricao VARCHAR(45)
);

CREATE TABLE permissao_nivel_acesso(
	fk_permissao INT NOT NULL,
	fk_nivel_acesso INT NOT NULL,
	PRIMARY KEY (fk_permissao, fk_nivel_acesso),
	FOREIGN KEY (fk_permissao) REFERENCES permissao(id_permissao),
	FOREIGN KEY (fk_nivel_acesso) REFERENCES nivel_acesso(id_nivel_acesso)
);

CREATE TABLE usuario(
	id_usuario INT PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR(45),
	email VARCHAR(45),
	senha VARCHAR(45),
	nivel_acesso_fk INT NOT NULL,
	empresa_fk INT NOT NULL,
	FOREIGN KEY (nivel_acesso_fk) REFERENCES nivel_acesso(id_nivel_acesso),
	FOREIGN KEY (empresa_fk) REFERENCES empresa(id)
);

CREATE TABLE componente_node(
	fk_componente INT NOT NULL,
	fk_node INT NOT NULL,
	limite_atencao VARCHAR(45),
	limite_critico VARCHAR(45),
	PRIMARY KEY (fk_componente, fk_node),
	FOREIGN KEY (fk_componente) REFERENCES componente(id_componente),
	FOREIGN KEY (fk_node) REFERENCES node(id_node)
);
