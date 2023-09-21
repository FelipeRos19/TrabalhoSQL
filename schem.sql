CREATE DATABASE trabalho;
USE trabalho;

CREATE TABLE IF NOT EXISTS neurodivergencia (
  id_neurodivergencia INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  nome VARCHAR(128) NOT NULL,
  sigla VARCHAR(16) NULL,
  descricao VARCHAR(256)
);

CREATE TABLE IF NOT EXISTS grupos_apoio (
  id_grupo INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  id_neurodivergencia INT NOT NULL,
  FOREIGN KEY (id_neurodivergencia) REFERENCES neurodivergencia(id_neurodivergencia) ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS usuarios_neurodivercentes (
    id_usuario INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    id_neurodivergencia INT NOT NULL,
    login VARCHAR(64) NOT NULL,
    senha VARCHAR(64) NOT NULL,
    nome VARCHAR(128) NOT NULL,
    email VARCHAR(64) NOT NULL,
    FOREIGN KEY (id_neurodivergencia) REFERENCES neurodivergencia(id_neurodivergencia) ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS telefone_usuarios (
    id_usuario INT NOT NULL,
    telefone VARCHAR(64) NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES usuarios_neurodivercentes(id_usuario) ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS usuarios_acompanhantes (
    id_acompanhante INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    id_usuario INT NOT NULL,
    login VARCHAR(64) NOT NULL,
    senha VARCHAR(64) NOT NULL,
    nome VARCHAR(128) NOT NULL,
    email VARCHAR(64) NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES usuarios_neurodivercentes(id_usuario) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS integrado (
    id_usuario INT NOT NULL,
    id_grupo INT NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES usuarios_neurodivercentes(id_usuario) ON UPDATE CASCADE,
    FOREIGN KEY (id_grupo) REFERENCES grupos_apoio(id_grupo) ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS clinica (
    id_clinica INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    id_neurodivergencia INT NOT NULL,
    FOREIGN KEY (id_neurodivergencia) REFERENCES neurodivergencia(id_neurodivergencia) ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS busca_ajuda (
    id_usuario INT NOT NULL,
    id_clinica INT NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES usuarios_neurodivercentes(id_usuario) ON UPDATE CASCADE,
    FOREIGN KEY (id_clinica) REFERENCES clinica(id_clinica) ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS profissionais (
    id_profissional INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    id_clinica INT NOT NULL,
    especialidade INT NOT NULL,
    FOREIGN KEY (id_clinica) REFERENCES clinica(id_clinica) ON UPDATE CASCADE,
    FOREIGN KEY (especialidade) REFERENCES neurodivergencia(id_neurodivergencia) ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS trabalho (
    id_profissional INT NOT NULL,
    id_clinica INT NOT NULL,
    FOREIGN KEY (id_profissional) REFERENCES profissionais(id_profissional) ON UPDATE CASCADE,
    FOREIGN KEY (id_clinica) REFERENCES clinica(id_clinica) ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS gestores (
    id_grupo INT NOT NULL,
    id_profissional INT NOT NULL,
    FOREIGN KEY (id_profissional) REFERENCES profissionais(id_profissional) ON UPDATE CASCADE,
    FOREIGN KEY (id_grupo) REFERENCES grupos_apoio(id_grupo) ON UPDATE CASCADE
);
