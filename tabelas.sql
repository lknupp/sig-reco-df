-- TABELAS

CREATE TABLE usuario (
    cd_usuario INTEGER NOT NULL,
    login VARCHAR(16) UNIQUE NOT NULL,
    senha VARCHAR(256) NOT NULL,
    role INTEGER NOT NULL,
    CONSTRAINT pk_usuario PRIMARY KEY (cd_usuario)
);

CREATE TABLE alimento (
    cd_alimento INTEGER NOT NULL,
    tp_alimento INTEGER NOT NULL,
    descricao VARCHAR(300) NOT NULL,
    CONSTRAINT pk_alimento PRIMARY KEY (cd_alimento)
);

CREATE TABLE refeicao (
    cd_refeicao VARCHAR(50) NOT NULL,
    valor_calorico VARCHAR(20) NOT NULL,
    tipo INTEGER NOT NULL,
    CONSTRAINT pk_refeicao PRIMARY KEY (cd_refeicao)
);

CREATE TABLE refeicao_alimento (
    cd_alimento INTEGER NOT NULL,
    cd_refeicao VARCHAR(50) NOT NULL,
    CONSTRAINT pk_refeicao_alimento PRIMARY KEY (cd_alimento, cd_refeicao)
);

CREATE TABLE endereco (
    cd_endereco INTEGER NOT NULL,
    logradouro VARCHAR(200) NOT NULL,
    numero INTEGER,
    complemento VARCHAR(200),
    bairro VARCHAR(200) NOT NULL,
    cep VARCHAR(8),
    cidade VARCHAR(200) NOT NULL,
    sg_estado CHAR(2) NOT NULL,
    CONSTRAINT pk_endereco PRIMARY KEY (cd_endereco)
);

CREATE TABLE restaurante (
    cd_rest INTEGER NOT NULL,
    nome VARCHAR(200) NOT NULL,
    latitude REAL NOT NULL,
    longitude REAL NOT NULL,
    hr_aber TIME NOT NULL,
    hr_fech TIME NOT NULL,
    cd_endereco INTEGER UNIQUE NOT NULL,
    CONSTRAINT pk_restaurante PRIMARY KEY (cd_rest)
);

CREATE TABLE cardapio (
    cd_cardapio INTEGER NOT NULL,
    tp_refeicao INTEGER NOT NULL,
    dt_cardapio DATE NOT NULL,
    cd_rest INTEGER NOT NULL,
    CONSTRAINT pk_cardapio PRIMARY KEY (cd_cardapio)
);

CREATE TABLE cardapio_refeicao (
    cd_cardapio INTEGER NOT NULL,
    cd_refeicao VARCHAR(50) NOT NULL,
    CONSTRAINT pk_cardapio_refeicao PRIMARY KEY (cd_cardapio, cd_refeicao)
);

CREATE TABLE administra (
    cd_rest INTEGER NOT NULL,
    cd_usuario INTEGER NOT NULL,
    CONSTRAINT pk_administra PRIMARY KEY (cd_rest, cd_usuario)
);

CREATE TABLE telefone (
    cd_telefone INTEGER NOT NULL,
    ddd INTEGER NOT NULL,
    telefone INTEGER NOT NULL,
    cd_rest INTEGER NOT NULL,
    CONSTRAINT pk_telefone PRIMARY KEY (cd_telefone)
);

CREATE TABLE tipo_alimento (
    cd_tipo_alimento INTEGER PRIMARY KEY,
    nome VARCHAR(50) NOT NULL
);

ALTER TABLE administra ADD CONSTRAINT fk_administra_usuario
    FOREIGN KEY (cd_usuario)
    REFERENCES usuario (cd_usuario)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

ALTER TABLE administra ADD CONSTRAINT fk_administra_restaurante
    FOREIGN KEY (cd_rest)
    REFERENCES restaurante (cd_rest)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

ALTER TABLE refeicao_alimento ADD CONSTRAINT fk_refeicao_alimento_alimento
    FOREIGN KEY (cd_alimento)
    REFERENCES alimento (cd_alimento)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

ALTER TABLE refeicao_alimento ADD CONSTRAINT fk_refeicao_alimento_refeicao
    FOREIGN KEY (cd_refeicao)
    REFERENCES refeicao (cd_refeicao)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

ALTER TABLE restaurante ADD CONSTRAINT fk_restaurante_endereco
    FOREIGN KEY (cd_endereco)
    REFERENCES endereco (cd_endereco)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

ALTER TABLE telefone ADD CONSTRAINT fk_telefone_restaurante
    FOREIGN KEY (cd_rest)
    REFERENCES restaurante (cd_rest)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

ALTER TABLE cardapio ADD CONSTRAINT fk_cardapio_restaurante
    FOREIGN KEY (cd_rest)
    REFERENCES restaurante (cd_rest)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

ALTER TABLE cardapio_refeicao ADD CONSTRAINT fk_cardapio_refeicao_cardapio
    FOREIGN KEY (cd_cardapio)
    REFERENCES cardapio (cd_cardapio)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

ALTER TABLE cardapio_refeicao ADD CONSTRAINT fk_cardapio_refeicao_refeicao
    FOREIGN KEY (cd_refeicao)
    REFERENCES refeicao (cd_refeicao)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;