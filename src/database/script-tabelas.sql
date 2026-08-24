DROP USER IF EXISTS 'user_admin'@'localhost';
CREATE USER 'user_admin'@'localhost' IDENTIFIED BY 'SPTech#2026';

GRANT ALL PRIVILEGES ON nautilus.* TO 'user_admin'@'SPTech#2026';
FLUSH PRIVILEGES;


DROP DATABASE IF EXISTS nautilus;
CREATE DATABASE nautilus;
USE nautilus;

CREATE TABLE empresa(
	id_empresa INT PRIMARY KEY AUTO_INCREMENT,
    razao_social VARCHAR(45),
    cnpj CHAR(14),
    dt_registro DATE
);

CREATE TABLE endereco(
	id_endereco INT PRIMARY KEY AUTO_INCREMENT,
    numero VARCHAR(10),
    cidade VARCHAR(45),
    estado CHAR(2),
    logradouro VARCHAR(100),
    fk_empresa INT,
    FOREIGN KEY (fk_empresa) REFERENCES empresa(id_empresa)
);

CREATE TABLE ambiente_hpc(
	id_ambiente_hpc INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45),
    descricao VARCHAR(60),
    status VARCHAR(45),
    fk_empresa INT,
    FOREIGN KEY (fk_empresa) REFERENCES empresa(id_empresa)
);

CREATE TABLE cluster(
	id_cluster INT PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR(45),
    descricao VARCHAR(60),
    status VARCHAR(45),
    fk_ambiente_hpc INT,
    FOREIGN KEY (fk_ambiente_hpc) REFERENCES ambiente_hpc(id_ambiente_hpc)
);

CREATE TABLE node(
	id_node INT PRIMARY KEY AUTO_INCREMENT,
    hostname VARCHAR(45),
    ip VARCHAR(45),
    descricao VARCHAR(60),
    sistema_operacional VARCHAR(45),
    fk_cluster INT,
    FOREIGN KEY (fk_cluster) REFERENCES cluster(id_cluster)
);

CREATE TABLE componente(
	id_componente INT PRIMARY KEY AUTO_INCREMENT,
    tipo VARCHAR(45),
    nome VARCHAR(45),
    fk_node INT,
    FOREIGN KEY (fk_node) REFERENCES node(id_node)
);

CREATE TABLE tipo_metrica(
	id_tipo_metrica INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45)
);

CREATE TABLE metrica(
	id_metrica INT AUTO_INCREMENT,
    nome VARCHAR(45),
    unidade VARCHAR(45),
    limite_atencao VARCHAR(45),
    limite_critico VARCHAR(45),
    fk_componente INT,
    fk_tipo_metrica INT,
    PRIMARY KEY (id_metrica, fk_tipo_metrica),
    FOREIGN KEY (fk_componente) REFERENCES componente(id_componente),
    FOREIGN KEY (fk_tipo_metrica) REFERENCES tipo_metrica(id_tipo_metrica)
);

CREATE TABLE alerta(
	id_alerta INT PRIMARY KEY AUTO_INCREMENT,
    nivel VARCHAR(45),
    mensagem VARCHAR(100),
    status VARCHAR(45),
    dt_hora DATE,
    fk_metrica INT,
    FOREIGN KEY (fk_metrica) REFERENCES metrica(id_metrica)
);

CREATE TABLE nivel_acesso(
	id_nivel_acesso INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45)
);

CREATE TABLE usuario(
	id_usuario INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45),
    email VARCHAR(45),
    senha VARCHAR(45),
    fk_nivel_acesso INT,
    fk_empresa INT,
    FOREIGN KEY (fk_nivel_acesso) REFERENCES nivel_acesso(id_nivel_acesso),
    FOREIGN KEY (fk_empresa) REFERENCES empresa(id_empresa)
);

CREATE TABLE incidente(
	id_incidente INT PRIMARY KEY AUTO_INCREMENT,
    descricao VARCHAR(100),
    status VARCHAR(45),
    dt_abertura DATE,
    dt_fechamento DATE,
    fk_alerta INT,
    fk_usuario INT,
    FOREIGN KEY (fk_alerta) REFERENCES alerta(id_alerta),
    FOREIGN KEY (fk_usuario) REFERENCES usuario(id_usuario)
);

CREATE TABLE permissao(
	id_permissao INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45),
    descricao VARCHAR(45)
);

CREATE TABLE permissao_nivel_acesso(
	fk_permissao INT,
    fk_nivel_acesso INT,
    PRIMARY KEY (fk_permissao, fk_nivel_acesso),
    FOREIGN KEY (fk_permissao) REFERENCES permissao(id_permissao),
    FOREIGN KEY (fk_nivel_acesso) REFERENCES nivel_acesso(id_nivel_acesso)
);
