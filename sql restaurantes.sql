
CREATE TABLE usuario (
                cd_usuario INTEGER NOT NULL,
                login VARCHAR(16) UNIQUE NOT NULL,
                senha VARCHAR(256) NOT NULL,
                role INTEGER NOT NULL,
                CONSTRAINT usuario PRIMARY KEY (cd_usuario)
);


CREATE TABLE alimento (
                cd_alimento INTEGER NOT NULL,
                tp_alimento INTEGER NOT NULL,
                descricao VARCHAR(300) NOT NULL,
                CONSTRAINT alimento PRIMARY KEY (cd_alimento)
);


CREATE TABLE refeicao (
                cd_refeicao VARCHAR NOT NULL,
                valor_calorico VARCHAR NOT NULL,
                tipo INTEGER NOT NULL,
                CONSTRAINT refeicao PRIMARY KEY (cd_refeicao)
);


CREATE TABLE refeicao_alimento (
                cd_alimento INTEGER NOT NULL,
                cd_refeicao VARCHAR NOT NULL,
                CONSTRAINT refeicao_alimento PRIMARY KEY (cd_alimento, cd_refeicao)
);


CREATE TABLE endereco (
                cd_endereco INTEGER NOT NULL,
                logradouro VARCHAR(200) NOT NULL,
                numero INTEGER NOT NULL,
                complemento VARCHAR(200) NOT NULL,
                bairro VARCHAR(200) NOT NULL,
                cep VARCHAR(8) NOT NULL,
                cidade VARCHAR(200) NOT NULL,
                sg_estado CHAR(2) NOT NULL,
                CONSTRAINT endereco PRIMARY KEY (cd_endereco)
);


CREATE TABLE restaurante (
                cd_rest INTEGER NOT NULL,
                nome VARCHAR(200) NOT NULL,
                latitude REAL NOT NULL,
                longitude REAL NOT NULL,
                hr_aber TIME NOT NULL,
                hr_fech TIME NOT NULL,
                cd_endereco INTEGER UNIQUE NOT NULL,
                CONSTRAINT restaurante PRIMARY KEY (cd_rest)
);


CREATE TABLE cardapio (
                cd_cardapio INTEGER NOT NULL,
                tp_refeicao INTEGER NOT NULL,
                dt_cardapio DATE NOT NULL,
                cd_rest INTEGER NOT NULL,
                CONSTRAINT cardapio PRIMARY KEY (cd_cardapio)
);


CREATE TABLE cardapio_refeicao (
                cd_cardapio INTEGER NOT NULL,
                cd_refeicao VARCHAR NOT NULL,
                CONSTRAINT cardapio_refeicao PRIMARY KEY (cd_cardapio, cd_refeicao)
);


CREATE TABLE administra (
                cd_rest INTEGER NOT NULL,
                cd_usuario INTEGER NOT NULL,
                CONSTRAINT administra PRIMARY KEY (cd_rest, cd_usuario)
);


CREATE TABLE telefone (
                cd_telefone INTEGER NOT NULL,
                ddd INTEGER NOT NULL,
                telefone INTEGER NOT NULL,
                cd_rest INTEGER NOT NULL,
                CONSTRAINT telefone PRIMARY KEY (cd_telefone)
);


ALTER TABLE administra ADD CONSTRAINT usuario_administra_fk
FOREIGN KEY (cd_usuario)
REFERENCES usuario (cd_usuario)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE refeicao_alimento ADD CONSTRAINT alimento_refeicao_alimento_fk
FOREIGN KEY (cd_alimento)
REFERENCES alimento (cd_alimento)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE cardapio_refeicao ADD CONSTRAINT refeicao_cardapio_refeicao_fk
FOREIGN KEY (cd_refeicao)
REFERENCES refeicao (cd_refeicao)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE refeicao_alimento ADD CONSTRAINT refeicao_refeicao_alimento_fk
FOREIGN KEY (cd_refeicao)
REFERENCES refeicao (cd_refeicao)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE restaurante ADD CONSTRAINT endereco_restaurante_fk
FOREIGN KEY (cd_endereco)
REFERENCES endereco (cd_endereco)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE telefone ADD CONSTRAINT restaurante_telefone_fk
FOREIGN KEY (cd_rest)
REFERENCES restaurante (cd_rest)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE administra ADD CONSTRAINT restaurante_administra_fk
FOREIGN KEY (cd_rest)
REFERENCES restaurante (cd_rest)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE cardapio ADD CONSTRAINT restaurante_cardapio_fk
FOREIGN KEY (cd_rest)
REFERENCES restaurante (cd_rest)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE cardapio_refeicao ADD CONSTRAINT cardapio_cardapio_refeicao_fk
FOREIGN KEY (cd_cardapio)
REFERENCES cardapio (cd_cardapio)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
