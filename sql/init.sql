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

INSERT INTO endereco (
    cd_endereco, logradouro, numero, complemento, bairro, cep, cidade, sg_estado
) VALUES (
    1, 
    'Ǫuadra 36 –Área Especial 01 – Vila São José', 
    null, 
    '', 
    'Brazlândia', 
    '00000000', 
    'Brazlândia', 
    'DF'
);

INSERT INTO endereco (
    cd_endereco, logradouro, numero, complemento, bairro, cep, cidade, sg_estado
) VALUES (
    2, 
    'QS 9 Avenida Águas Claras, Lote 3', 
    null, 
    '', 
    'Arniqueira', 
    '00000000', 
    'Arniqueira', 
    'DF'
);

INSERT INTO endereco (
    cd_endereco, logradouro, numero, complemento, bairro, cep, cidade, sg_estado
) VALUES (
    3, 
    'CNM 01 -Bloco 01 - Lote 01 - Ceilândia Centro', 
    1, 
    'Ceilândia Centro', 
    'Ceilândia', 
    '00000000', 
    'Ceilândia', 
    'DF'
);

INSERT INTO endereco (
    cd_endereco, logradouro, numero, complemento, bairro, cep, cidade, sg_estado
) VALUES (
    4, 
    'Ǫuadra 14 –Área Especial –Vila Estrutural', 
    null, 
    '', 
    'Estrutural', 
    '00000000', 
    'Estrutural', 
    'DF'
);

INSERT INTO endereco (
    cd_endereco, logradouro, numero, complemento, bairro, cep, cidade, sg_estado
) VALUES (
    5, 
    'Setor Central - Área Especial - Complexo Esportivo do Gama - Estádio Bezerrão', 
    null, 
    '', 
    'Gama', 
    '00000000', 
    'Gama', 
    'DF'
);

INSERT INTO endereco (
    cd_endereco, logradouro, numero, complemento, bairro, cep, cidade, sg_estado
) VALUES (
    7, 
    'Ǫuadra 2 - Lote A - Feira Livre - Área Especial', 
    null, 
    '', 
    'Paranoá', 
    '00000000', 
    'Paranoá', 
    'DF'
);

INSERT INTO endereco (
    cd_endereco, logradouro, numero, complemento, bairro, cep, cidade, sg_estado
) VALUES (
    6, 
    'Ǫuadra 61 -ÁreaEspecial - Entre Conjuntos D/E, Condomínio Dellago', 
    null, 
    '', 
    'Itapoã', 
    '00000000', 
    'Itapoã', 
    'DF'
);

INSERT INTO endereco (
    cd_endereco, logradouro, numero, complemento, bairro, cep, cidade, sg_estado
) VALUES (
    8, 
    'Setor Recreativo e Cultural - Módulo Esportivo -Via WL 1 - a/NS', 
    null, 
    '', 
    'Planaltina', 
    '00000000', 
    'Planaltina', 
    'DF'
);

INSERT INTO endereco (
    cd_endereco, logradouro, numero, complemento, bairro, cep, cidade, sg_estado
) VALUES (
    9, 
    'Av Recanto das Emas - Ǫuadra 205 - Lote 01', 
    null, 
    '', 
    'Recanto das Emas', 
    '00000000', 
    'Recanto das Emas', 
    'DF'
);

INSERT INTO endereco (
    cd_endereco, logradouro, numero, complemento, bairro, cep, cidade, sg_estado
) VALUES (
    10, 
    'Ǫuadra 10 -Conjunto 01 - Lote 01', 
    null, 
    '', 
    'Riacho Fundo II', 
    '00000000', 
    'Riacho Fundo II', 
    'DF'
);

INSERT INTO endereco (
    cd_endereco, logradouro, numero, complemento, bairro, cep, cidade, sg_estado
) VALUES (
    11, 
    'ADE/S -Conjunto 15 - Lotes 01/02', 
    null, 
    'Às margens da BR 061', 
    'Samambaia', 
    '00000000', 
    'Samambaia', 
    'DF'
);

INSERT INTO endereco (
    cd_endereco, logradouro, numero, complemento, bairro, cep, cidade, sg_estado
) VALUES (
    12, 
    'Quadra 833 - Conjunto 8 - Lote 1', 
    null, 
    'Samambaia Norte', 
    'Samambaia Expansão', 
    '00000000', 
    'Samambaia', 
    'DF'
);

INSERT INTO endereco (
    cd_endereco, logradouro, numero, complemento, bairro, cep, cidade, sg_estado
) VALUES (
    13, 
    'Av. Alagados Área Central', 
    null, 
    'Junto ao prédio da Administração', 
    'Santa Maria', 
    '00000000', 
    'Santa Maria', 
    'DF'
);

INSERT INTO endereco (
    cd_endereco, logradouro, numero, complemento, bairro, cep, cidade, sg_estado
) VALUES (
    14, 
    'Centro de Múltiplas Atividades -Lote 02', 
    null, 
    'Próximo à Administração Regional', 
    'São Sebastião', 
    '00000000', 
    'São Sebastião', 
    'DF'
);

INSERT INTO endereco (
    cd_endereco, logradouro, numero, complemento, bairro, cep, cidade, sg_estado
) VALUES (
    15, 
    'AR 09 - conjunto 03 - St Administrativo', 
    null, 
    '', 
    'Sobradinho', 
    '00000000', 
    'Sobradinho', 
    'DF'
);

INSERT INTO endereco (
    cd_endereco, logradouro, numero, complemento, bairro, cep, cidade, sg_estado
) VALUES (
    16, 
    'ǪNR 01 Área Especial nº 2 Ceilândia Norte', 
    null, 
    '', 
    'Sol Nascente', 
    '00000000', 
    'Sol Nascente', 
    'DF'
);

INSERT INTO endereco (
    cd_endereco, logradouro, numero, complemento, bairro, cep, cidade, sg_estado
) VALUES (
    17, 
    'Ǫuadra 105 conjunto O ae 1 - trecho 02', 
    null, 
    '', 
    'Sol Nascente/Pôr do Sol', 
    '00000000', 
    'Sol Nascente/Pôr do Sol', 
    'DF'
);

INSERT INTO endereco (
    cd_endereco, logradouro, numero, complemento, bairro, cep, cidade, sg_estado
) VALUES (
    18, 
    'Quadra 08 conjunto F lote 01', 
    null, 
    '', 
    'Varjão', 
    '00000000', 
    'Varjão', 
    'DF'
);

-- Tabela de domínio dos tipos de alimento
INSERT INTO tipo_alimento (cd_tipo_alimento, nome) VALUES (1, 'Panificação');
INSERT INTO tipo_alimento (cd_tipo_alimento, nome) VALUES (2, 'Fruta');
INSERT INTO tipo_alimento (cd_tipo_alimento, nome) VALUES (3, 'Bebida');
INSERT INTO tipo_alimento (cd_tipo_alimento, nome) VALUES (4, 'Prato proteico');
INSERT INTO tipo_alimento (cd_tipo_alimento, nome) VALUES (5, 'Guarnição');
INSERT INTO tipo_alimento (cd_tipo_alimento, nome) VALUES (6, 'Salada');
INSERT INTO tipo_alimento (cd_tipo_alimento, nome) VALUES (7, 'Acompanhamento');
INSERT INTO tipo_alimento (cd_tipo_alimento, nome) VALUES (8, 'Sobremesa');
INSERT INTO tipo_alimento (cd_tipo_alimento, nome) VALUES (9, 'Prato único (jantar)');


-- Alimentos

-- Café da manhã

-- Panificação (tp_alimento = 1)
INSERT INTO alimento (cd_alimento, tp_alimento, descricao) VALUES (1, 1, 'Biscoito de queijo');
INSERT INTO alimento (cd_alimento, tp_alimento, descricao) VALUES (2, 1, 'Bolo');
INSERT INTO alimento (cd_alimento, tp_alimento, descricao) VALUES (3, 1, 'Cuscuz com manteiga e ovo');
INSERT INTO alimento (cd_alimento, tp_alimento, descricao) VALUES (4, 1, 'Cuscuz com manteiga e queijo');
INSERT INTO alimento (cd_alimento, tp_alimento, descricao) VALUES (5, 1, 'Pão com manteiga e ovo');
INSERT INTO alimento (cd_alimento, tp_alimento, descricao) VALUES (6, 1, 'Pão com manteiga e presunto');
INSERT INTO alimento (cd_alimento, tp_alimento, descricao) VALUES (7, 1, 'Pão com manteiga e queijo');
INSERT INTO alimento (cd_alimento, tp_alimento, descricao) VALUES (8, 1, 'Pão de queijo');
INSERT INTO alimento (cd_alimento, tp_alimento, descricao) VALUES (9, 1, 'Rosca');

-- Bebida (tp_alimento = 3)
INSERT INTO alimento (cd_alimento, tp_alimento, descricao) VALUES (10, 3, 'Leite e café');

-- Fruta (tp_alimento = 2)
INSERT INTO alimento (cd_alimento, tp_alimento, descricao) VALUES (11, 2, 'Banana');
INSERT INTO alimento (cd_alimento, tp_alimento, descricao) VALUES (12, 2, 'Laranja');
INSERT INTO alimento (cd_alimento, tp_alimento, descricao) VALUES (13, 2, 'Maçã');
INSERT INTO alimento (cd_alimento, tp_alimento, descricao) VALUES (14, 2, 'Mamão');
INSERT INTO alimento (cd_alimento, tp_alimento, descricao) VALUES (15, 2, 'Melancia');
INSERT INTO alimento (cd_alimento, tp_alimento, descricao) VALUES (16, 2, 'Melão');
INSERT INTO alimento (cd_alimento, tp_alimento, descricao) VALUES (17, 2, 'Tangerina');

INSERT INTO alimento (cd_alimento, tp_alimento, descricao) VALUES (18, 4, 'Moqueca de peixe');
INSERT INTO alimento (cd_alimento, tp_alimento, descricao) VALUES (19, 4, 'Coxa / sobrecoxa de frango assado');
INSERT INTO alimento (cd_alimento, tp_alimento, descricao) VALUES (20, 4, 'Picadinho de carne');
INSERT INTO alimento (cd_alimento, tp_alimento, descricao) VALUES (21, 4, 'Isca de frango ao molho de açafrão');
INSERT INTO alimento (cd_alimento, tp_alimento, descricao) VALUES (22, 4, 'Feijoada');
INSERT INTO alimento (cd_alimento, tp_alimento, descricao) VALUES (23, 4, 'Carne moída com milho');
INSERT INTO alimento (cd_alimento, tp_alimento, descricao) VALUES (24, 4, 'Ovo mexido tricolor');
INSERT INTO alimento (cd_alimento, tp_alimento, descricao) VALUES (25, 4, 'Quibe de forno com hortelã');
INSERT INTO alimento (cd_alimento, tp_alimento, descricao) VALUES (26, 4, 'Carne assada ao molho escuro');
INSERT INTO alimento (cd_alimento, tp_alimento, descricao) VALUES (27, 4, 'Estrogonofe de frango');
INSERT INTO alimento (cd_alimento, tp_alimento, descricao) VALUES (28, 4, 'Torta de carne moída');
INSERT INTO alimento (cd_alimento, tp_alimento, descricao) VALUES (29, 4, 'Omelete de forno');
INSERT INTO alimento (cd_alimento, tp_alimento, descricao) VALUES (30, 5, 'Pirão de legumes');
INSERT INTO alimento (cd_alimento, tp_alimento, descricao) VALUES (31, 5, 'Creme de milho');
INSERT INTO alimento (cd_alimento, tp_alimento, descricao) VALUES (32, 5, 'Cenoura sauté com brócolis');
INSERT INTO alimento (cd_alimento, tp_alimento, descricao) VALUES (33, 5, 'Polenta');
INSERT INTO alimento (cd_alimento, tp_alimento, descricao) VALUES (34, 5, 'Purê misto com batata e cenoura');
INSERT INTO alimento (cd_alimento, tp_alimento, descricao) VALUES (35, 5, 'Quibebe de abóbora');
INSERT INTO alimento (cd_alimento, tp_alimento, descricao) VALUES (36, 5, 'Ratatouille');
INSERT INTO alimento (cd_alimento, tp_alimento, descricao) VALUES (37, 5, 'Farofa de couve');
INSERT INTO alimento (cd_alimento, tp_alimento, descricao) VALUES (38, 5, 'Batata doce sauté');
INSERT INTO alimento (cd_alimento, tp_alimento, descricao) VALUES (39, 6, 'Acelga e tomate');
INSERT INTO alimento (cd_alimento, tp_alimento, descricao) VALUES (40, 6, 'Beterraba e chicória');
INSERT INTO alimento (cd_alimento, tp_alimento, descricao) VALUES (41, 6, 'Tabule');
INSERT INTO alimento (cd_alimento, tp_alimento, descricao) VALUES (42, 6, 'Vinagrete');
INSERT INTO alimento (cd_alimento, tp_alimento, descricao) VALUES (43, 6, 'Alface e tomate');
INSERT INTO alimento (cd_alimento, tp_alimento, descricao) VALUES (44, 6, 'Pepino e tomate');
INSERT INTO alimento (cd_alimento, tp_alimento, descricao) VALUES (45, 6, 'Repolho e beterraba');
INSERT INTO alimento (cd_alimento, tp_alimento, descricao) VALUES (46, 7, 'Arroz branco');
INSERT INTO alimento (cd_alimento, tp_alimento, descricao) VALUES (47, 7, 'Feijão carioca');
INSERT INTO alimento (cd_alimento, tp_alimento, descricao) VALUES (48, 7, 'Feijão preto');
INSERT INTO alimento (cd_alimento, tp_alimento, descricao) VALUES (49, 8, 'Banana');
INSERT INTO alimento (cd_alimento, tp_alimento, descricao) VALUES (50, 8, 'Maçã');
INSERT INTO alimento (cd_alimento, tp_alimento, descricao) VALUES (51, 8, 'Laranja');
INSERT INTO alimento (cd_alimento, tp_alimento, descricao) VALUES (52, 8, 'Pudim de coco');
INSERT INTO alimento (cd_alimento, tp_alimento, descricao) VALUES (53, 8, 'Arroz doce');
INSERT INTO alimento (cd_alimento, tp_alimento, descricao) VALUES (54, 8, 'Gelatina');
INSERT INTO alimento (cd_alimento, tp_alimento, descricao) VALUES (55, 8, 'Doce de banana caramelada');
INSERT INTO alimento (cd_alimento, tp_alimento, descricao) VALUES (56, 8, 'Canjica');
INSERT INTO alimento (cd_alimento, tp_alimento, descricao) VALUES (57, 8, 'Doce de batata doce');
INSERT INTO alimento (cd_alimento, tp_alimento, descricao) VALUES (58, 3, 'Suco');
INSERT INTO alimento (cd_alimento, tp_alimento, descricao) VALUES (59, 9, 'Macarrão a bolonhesa');
INSERT INTO alimento (cd_alimento, tp_alimento, descricao) VALUES (60, 9, 'Arroz carreteiro');
INSERT INTO alimento (cd_alimento, tp_alimento, descricao) VALUES (61, 9, 'Galinhada');
INSERT INTO alimento (cd_alimento, tp_alimento, descricao) VALUES (62, 9, 'Creme de abóbora com carne moída e couve-manteiga');
INSERT INTO alimento (cd_alimento, tp_alimento, descricao) VALUES (63, 9, 'Canja de galinha');
INSERT INTO alimento (cd_alimento, tp_alimento, descricao) VALUES (64, 9, 'Sopa de legumes com carne moída e macarrão');
INSERT INTO alimento (cd_alimento, tp_alimento, descricao) VALUES (65, 9, 'Caldo de milho(milho e fubá) com frango desfiado');
INSERT INTO alimento (cd_alimento, tp_alimento, descricao) VALUES (66, 9, 'Arroz colorido com frango');
INSERT INTO alimento (cd_alimento, tp_alimento, descricao) VALUES (67, 9, 'Caldo de feijão com carne moída, macarrão e cheiro verde');
INSERT INTO alimento (cd_alimento, tp_alimento, descricao) VALUES (68, 9, 'Caldo verde(batata, mandioca e couve) com carne moída');
INSERT INTO alimento (cd_alimento, tp_alimento, descricao) VALUES (69, 9, 'Sopa de frango com macarrão e legumes');
INSERT INTO alimento (cd_alimento, tp_alimento, descricao) VALUES (70, 9, 'Pão de sal com carne moída');
INSERT INTO alimento (cd_alimento, tp_alimento, descricao) VALUES (71, 9, 'Caldo de batata, milho e frango');
INSERT INTO alimento (cd_alimento, tp_alimento, descricao) VALUES (72, 9, 'Macarronada com frango');
INSERT INTO alimento (cd_alimento, tp_alimento, descricao) VALUES (73, 9, 'Baião de três');
INSERT INTO alimento (cd_alimento, tp_alimento, descricao) VALUES (74, 9, 'Sopa de macarrão, legumes e carne moída');
INSERT INTO alimento (cd_alimento, tp_alimento, descricao) VALUES (75, 9, 'Vaca atolada');
INSERT INTO alimento (cd_alimento, tp_alimento, descricao) VALUES (76, 9, 'Macarrão oriental com carne e legumes');
INSERT INTO alimento (cd_alimento, tp_alimento, descricao) VALUES (77, 9, 'Creme de abóbora com batata, frango e couve manteiga');
INSERT INTO alimento (cd_alimento, tp_alimento, descricao) VALUES (78, 9, 'Arroz cremoso com carne moída');
INSERT INTO alimento (cd_alimento, tp_alimento, descricao) VALUES (79, 9, 'Macarronada de frango');


-- Dados dos restaurantes
INSERT INTO restaurante (cd_rest, nome,latitude, longitude, hr_aber, hr_fech, cd_endereco)
VALUES (1, 'Restaurante Comunitário Arniqueira', 0, 0 ,'07:00:00', '19:00:00', 2);

INSERT INTO restaurante (cd_rest, nome,latitude, longitude, hr_aber, hr_fech, cd_endereco)
VALUES (2, 'Restaurante Comunitário Brazlândia', 0, 0, '06:20:00', '19:00:00', 1);

INSERT INTO restaurante (cd_rest, nome,latitude, longitude, hr_aber, hr_fech, cd_endereco)
VALUES (3, 'Restaurante Comunitário Ceilândia', 0, 0 ,'07:00:00', '19:00:00', 3);

INSERT INTO restaurante (cd_rest, nome,latitude, longitude, hr_aber, hr_fech, cd_endereco)
VALUES (4, 'Restaurante Comunitário Estrutural', 0, 0 ,'07:00:00', '19:00:00', 4);

INSERT INTO restaurante (cd_rest, nome,latitude, longitude, hr_aber, hr_fech, cd_endereco)
VALUES (5, 'Restaurante Comunitário Gama', 0, 0 ,'07:00:00', '19:00:00', 5);

INSERT INTO restaurante (cd_rest, nome,latitude, longitude, hr_aber, hr_fech, cd_endereco)
VALUES (6, 'Restaurante Comunitário Itapoã', 0, 0 ,'07:00:00', '19:00:00', 6);

INSERT INTO restaurante (cd_rest, nome,latitude, longitude, hr_aber, hr_fech, cd_endereco)
VALUES (7, 'Restaurante Comunitário Paranoá', 0, 0 ,'07:00:00', '19:00:00', 7);

INSERT INTO restaurante (cd_rest, nome,latitude, longitude, hr_aber, hr_fech, cd_endereco)
VALUES (8, 'Restaurante Comunitário Planaltina', 0, 0 ,'07:00:00', '19:00:00', 8);

INSERT INTO restaurante (cd_rest, nome,latitude, longitude, hr_aber, hr_fech, cd_endereco)
VALUES (9, 'Restaurante Comunitário Recanto das Emas', 0, 0 ,'07:00:00', '19:00:00', 9);

INSERT INTO restaurante (cd_rest, nome,latitude, longitude, hr_aber, hr_fech, cd_endereco)
VALUES (10, 'Restaurante Comunitário Riacho Fundo II', 0, 0 ,'07:00:00', '19:00:00', 10);

INSERT INTO restaurante (cd_rest, nome,latitude, longitude, hr_aber, hr_fech, cd_endereco)
VALUES (11, 'Restaurante Comunitário Samambaia', 0, 0 ,'07:00:00', '19:00:00', 11);

INSERT INTO restaurante (cd_rest, nome,latitude, longitude, hr_aber, hr_fech, cd_endereco)
VALUES (12, 'Restaurante Comunitário Santa Maria', 0, 0 ,'07:00:00', '19:00:00', 13);

INSERT INTO restaurante (cd_rest, nome,latitude, longitude, hr_aber, hr_fech, cd_endereco)
VALUES (13, 'Restaurante Comunitário São Sebastião', 0, 0 ,'07:00:00', '19:00:00', 14);

INSERT INTO restaurante (cd_rest, nome,latitude, longitude, hr_aber, hr_fech, cd_endereco)
VALUES (14, 'Restaurante Comunitário Sobradinho', 0, 0 ,'07:00:00', '19:00:00', 15);

INSERT INTO restaurante (cd_rest, nome,latitude, longitude, hr_aber, hr_fech, cd_endereco)
VALUES (15, 'Restaurante Comunitário Sol Nascente', 0, 0 ,'07:00:00', '19:00:00', 16);

INSERT INTO restaurante (cd_rest, nome,latitude, longitude, hr_aber, hr_fech, cd_endereco)
VALUES (16, 'Restaurante Comunitário Sol Nascente/Pôr do Sol', 0, 0 ,'07:00:00', '19:00:00', 17);

INSERT INTO restaurante (cd_rest, nome,latitude, longitude, hr_aber, hr_fech, cd_endereco)
VALUES (17, 'Restaurante Comunitário Varjão', 0, 0 ,'07:00:00', '19:00:00', 18);

INSERT INTO restaurante (cd_rest, nome,latitude, longitude, hr_aber, hr_fech, cd_endereco)
VALUES (18, 'Restaurante Comunitário Samambaia Expansão', 0, 0 ,'07:00:00', '19:00:00', 12);

-- Dados telefones dos restaurantes

insert into telefone (cd_telefone , ddd, telefone, cd_rest) 
values (1, 61, '37737164', 1);

insert into telefone (cd_telefone , ddd, telefone, cd_rest) 
values (2, 61, '37737593', 2);
insert into telefone (cd_telefone , ddd, telefone, cd_rest) 
values (3, 61, '37737594', 3);
insert into telefone (cd_telefone , ddd, telefone, cd_rest) 
values (4, 61, '37737595', 4);
insert into telefone (cd_telefone , ddd, telefone, cd_rest) 
values (5, 61, '37737596', 5);
insert into telefone (cd_telefone , ddd, telefone, cd_rest) 
values (6, 61, '37737597', 6);
insert into telefone (cd_telefone , ddd, telefone, cd_rest) 
values (7, 61, '37737598', 7);
insert into telefone (cd_telefone , ddd, telefone, cd_rest) 
values (8, 61, '37737599', 8);
insert into telefone (cd_telefone , ddd, telefone, cd_rest) 
values (9, 61, '37737600', 9);
insert into telefone (cd_telefone , ddd, telefone, cd_rest) 
values (10, 61, '37737601', 10);
insert into telefone (cd_telefone , ddd, telefone, cd_rest) 
values (11, 61, '37737602', 11);
insert into telefone (cd_telefone , ddd, telefone, cd_rest) 
values (12, 61, '37737624', 18);
insert into telefone (cd_telefone , ddd, telefone, cd_rest) 
values (13, 61, '37737623', 12);
insert into telefone (cd_telefone , ddd, telefone, cd_rest) 
values (14, 61, '37737620', 13);
insert into telefone (cd_telefone , ddd, telefone, cd_rest) 
values (15, 61, '37737649', 14);
insert into telefone (cd_telefone , ddd, telefone, cd_rest) 
values (16, 61, '37737639', 15);
insert into telefone (cd_telefone , ddd, telefone, cd_rest) 
values (17, 61, '37737636', 16);
insert into telefone (cd_telefone , ddd, telefone, cd_rest) 
values (18, 61, '37737529', 17);
