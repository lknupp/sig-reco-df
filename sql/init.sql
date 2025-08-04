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
    cd_refeicao INTEGER NOT NULL,
    valor_calorico INTEGER NOT NULL,
    tipo INTEGER NOT NULL,
    cd_cardapio INTEGER NOT NULL, -- Novo campo adicionado
    CONSTRAINT pk_refeicao PRIMARY KEY (cd_refeicao)
);

CREATE TABLE refeicao_alimento (
    cd_alimento INTEGER NOT NULL,
    cd_refeicao INTEGER NOT NULL,
    CONSTRAINT pk_refeicao_alimento PRIMARY KEY (cd_alimento, cd_refeicao)
);

CREATE TABLE restaurante (
    cd_rest INTEGER NOT NULL,
    nome VARCHAR(200) NOT NULL,
    latitude REAL NOT NULL,
    longitude REAL NOT NULL,
    hr_aber TIME NOT NULL,
    hr_fech TIME NOT NULL,
    logradouro VARCHAR(200) NOT NULL,
    numero INTEGER,
    complemento VARCHAR(200),
    bairro VARCHAR(200) NOT NULL,
    cep VARCHAR(8),
    cidade VARCHAR(200) NOT NULL,
    sg_estado CHAR(2) NOT NULL,
    CONSTRAINT pk_restaurante PRIMARY KEY (cd_rest)
);

CREATE TABLE cardapio (
    cd_cardapio INTEGER NOT NULL,
    dt_cardapio DATE NOT NULL,
    cd_rest INTEGER NOT NULL,
    CONSTRAINT pk_cardapio PRIMARY KEY (cd_cardapio)
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

-- Nova chave estrangeira para refeicao
ALTER TABLE refeicao ADD CONSTRAINT fk_refeicao_cardapio
    FOREIGN KEY (cd_cardapio)
    REFERENCES cardapio (cd_cardapio)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;



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

create extension POSTGIS;
-- Dados dos restaurantes
SELECT AddGeometryColumn('public', 'restaurante', 'geometria', 4326, 'POINT', 2);

INSERT INTO public.restaurante (cd_rest, nome, latitude, longitude, hr_aber, hr_fech, logradouro, numero, complemento, bairro, cep, cidade, sg_estado, geometria) VALUES (1, 'Restaurante Comunitário Arniqueira', -15.869719, -48.024475, '07:00:00', '19:00:00', 'QS 9 Avenida Águas Claras, Lote 3', NULL, '', 'Arniqueira', '00000000', 'Arniqueira', 'DF', '0101000020E6100000E9482EFF210348C06E6B0BCF4BBD2FC0');
INSERT INTO public.restaurante (cd_rest, nome, latitude, longitude, hr_aber, hr_fech, logradouro, numero, complemento, bairro, cep, cidade, sg_estado, geometria) VALUES (2, 'Restaurante Comunitário Brazlândia', -15.665602, -48.195736, '06:20:00', '19:00:00', 'Ǫuadra 36 –Área Especial 01 – Vila São José', NULL, '', 'Brazlândia', '00000000', 'Brazlândia', 'DF', '0101000020E61000002E5393E00D1948C0EC4D0CC9C9542FC0');
INSERT INTO public.restaurante (cd_rest, nome, latitude, longitude, hr_aber, hr_fech, logradouro, numero, complemento, bairro, cep, cidade, sg_estado, geometria) VALUES (3, 'Restaurante Comunitário Ceilândia', -15.817427, -48.102737, '07:00:00', '19:00:00', 'CNM 01 -Bloco 01 - Lote 01 - Ceilândia Centro', 1, 'Ceilândia Centro', 'Ceilândia', '00000000', 'Ceilândia', 'DF', '0101000020E6100000698B6B7C260D48C01BBCAFCA85A22FC0');
INSERT INTO public.restaurante (cd_rest, nome, latitude, longitude, hr_aber, hr_fech, logradouro, numero, complemento, bairro, cep, cidade, sg_estado, geometria) VALUES (4, 'Restaurante Comunitário Estrutural', -15.781683, -47.999256, '07:00:00', '19:00:00', 'Ǫuadra 14 –Área Especial –Vila Estrutural', NULL, '', 'Estrutural', '00000000', 'Estrutural', 'DF', '0101000020E6100000782AE09EE7FF47C0A7AD11C138902FC0');
INSERT INTO public.restaurante (cd_rest, nome, latitude, longitude, hr_aber, hr_fech, logradouro, numero, complemento, bairro, cep, cidade, sg_estado, geometria) VALUES (5, 'Restaurante Comunitário Gama', -16.012821, -48.061584, '07:00:00', '19:00:00', 'Setor Central - Área Especial - Complexo Esportivo do Gama - Estádio Bezerrão', NULL, '', 'Gama', '00000000', 'Gama', 'DF', '0101000020E61000007BFA08FCE10748C0B7B3AF3C480330C0');
INSERT INTO public.restaurante (cd_rest, nome, latitude, longitude, hr_aber, hr_fech, logradouro, numero, complemento, bairro, cep, cidade, sg_estado, geometria) VALUES (6, 'Restaurante Comunitário Itapoã', -15.745008, -47.77057, '07:00:00', '19:00:00', 'Ǫuadra 61 -ÁreaEspecial - Entre Conjuntos D/E, Condomínio Dellago', NULL, '', 'Itapoã', '00000000', 'Itapoã', 'DF', '0101000020E6100000ADA3AA09A2E247C0498446B0717D2FC0');
INSERT INTO public.restaurante (cd_rest, nome, latitude, longitude, hr_aber, hr_fech, logradouro, numero, complemento, bairro, cep, cidade, sg_estado, geometria) VALUES (7, 'Restaurante Comunitário Paranoá', -15.779326, -47.78105, '07:00:00', '19:00:00', 'Ǫuadra 2 - Lote A - Feira Livre - Área Especial', NULL, '', 'Paranoá', '00000000', 'Paranoá', 'DF', '0101000020E610000039454772F9E347C051D845D1038F2FC0');
INSERT INTO public.restaurante (cd_rest, nome, latitude, longitude, hr_aber, hr_fech, logradouro, numero, complemento, bairro, cep, cidade, sg_estado, geometria) VALUES (8, 'Restaurante Comunitário Planaltina', -15.613478, -47.650726, '07:00:00', '19:00:00', 'Setor Recreativo e Cultural - Módulo Esportivo -Via WL 1 - a/NS', NULL, '', 'Planaltina', '00000000', 'Planaltina', 'DF', '0101000020E6100000155454FD4AD347C088A1D5C9193A2FC0');
INSERT INTO public.restaurante (cd_rest, nome, latitude, longitude, hr_aber, hr_fech, logradouro, numero, complemento, bairro, cep, cidade, sg_estado, geometria) VALUES (9, 'Restaurante Comunitário Recanto das Emas', -15.904078, -48.07281, '07:00:00', '19:00:00', 'Av Recanto das Emas - Ǫuadra 205 - Lote 01', NULL, '', 'Recanto das Emas', '00000000', 'Recanto das Emas', 'DF', '0101000020E61000002F698CD6510948C0F110C64FE3CE2FC0');
INSERT INTO public.restaurante (cd_rest, nome, latitude, longitude, hr_aber, hr_fech, logradouro, numero, complemento, bairro, cep, cidade, sg_estado, geometria) VALUES (10, 'Restaurante Comunitário Riacho Fundo II', -15.900039, -48.050518, '07:00:00', '19:00:00', 'Ǫuadra 10 -Conjunto 01 - Lote 01', NULL, '', 'Riacho Fundo II', '00000000', 'Riacho Fundo II', 'DF', '0101000020E6100000FEEDB25F770648C0C43F6CE9D1CC2FC0');
INSERT INTO public.restaurante (cd_rest, nome, latitude, longitude, hr_aber, hr_fech, logradouro, numero, complemento, bairro, cep, cidade, sg_estado, geometria) VALUES (11, 'Restaurante Comunitário Samambaia', -15.888829, -48.084877, '07:00:00', '19:00:00', 'ADE/S -Conjunto 15 - Lotes 01/02', NULL, 'Às margens da BR 061', 'Samambaia', '00000000', 'Samambaia', 'DF', '0101000020E61000005F97E13FDD0A48C007793D9814C72FC0');
INSERT INTO public.restaurante (cd_rest, nome, latitude, longitude, hr_aber, hr_fech, logradouro, numero, complemento, bairro, cep, cidade, sg_estado, geometria) VALUES (12, 'Restaurante Comunitário Santa Maria', -16.017117, -48.01666, '07:00:00', '19:00:00', 'Av. Alagados Área Central', NULL, 'Junto ao prédio da Administração', 'Santa Maria', '00000000', 'Santa Maria', 'DF', '0101000020E6100000609335EA210248C0A4349BC7610430C0');
INSERT INTO public.restaurante (cd_rest, nome, latitude, longitude, hr_aber, hr_fech, logradouro, numero, complemento, bairro, cep, cidade, sg_estado, geometria) VALUES (13, 'Restaurante Comunitário São Sebastião', -15.903878, -47.77386, '07:00:00', '19:00:00', 'Centro de Múltiplas Atividades -Lote 02', NULL, 'Próximo à Administração Regional', 'São Sebastião', '00000000', 'São Sebastião', 'DF', '0101000020E61000005ED72FD80DE347C0D525E318C9CE2FC0');
INSERT INTO public.restaurante (cd_rest, nome, latitude, longitude, hr_aber, hr_fech, logradouro, numero, complemento, bairro, cep, cidade, sg_estado, geometria) VALUES (14, 'Restaurante Comunitário Sobradinho', -15.641625, -47.81953, '07:00:00', '19:00:00', 'AR 09 - conjunto 03 - St Administrativo', NULL, '', 'Sobradinho', '00000000', 'Sobradinho', 'DF', '0101000020E6100000A20BEA5BE6E847C08D976E1283482FC0');
INSERT INTO public.restaurante (cd_rest, nome, latitude, longitude, hr_aber, hr_fech, logradouro, numero, complemento, bairro, cep, cidade, sg_estado, geometria) VALUES (15, 'Restaurante Comunitário Sol Nascente', -15.806657, -48.15339, '07:00:00', '19:00:00', 'ǪNR 01 Área Especial nº 2 Ceilândia Norte', NULL, '', 'Sol Nascente', '00000000', 'Sol Nascente', 'DF', '0101000020E610000048C49448A21348C0CF2D7425029D2FC0');
INSERT INTO public.restaurante (cd_rest, nome, latitude, longitude, hr_aber, hr_fech, logradouro, numero, complemento, bairro, cep, cidade, sg_estado, geometria) VALUES (16, 'Restaurante Comunitário Sol Nascente/Pôr do Sol', -15.832067, -48.141926, '07:00:00', '19:00:00', 'Ǫuadra 105 conjunto O ae 1 - trecho 02', NULL, '', 'Sol Nascente/Pôr do Sol', '00000000', 'Sol Nascente/Pôr do Sol', 'DF', '0101000020E6100000DE3994A12A1248C0632992AF04AA2FC0');
INSERT INTO public.restaurante (cd_rest, nome, latitude, longitude, hr_aber, hr_fech, logradouro, numero, complemento, bairro, cep, cidade, sg_estado, geometria) VALUES (17, 'Restaurante Comunitário Varjão', -15.709124, -47.88092, '07:00:00', '19:00:00', 'Quadra 08 conjunto F lote 01', NULL, '', 'Varjão', '00000000', 'Varjão', 'DF', '0101000020E610000038328FFCC1F047C00E9E094D126B2FC0');
INSERT INTO public.restaurante (cd_rest, nome, latitude, longitude, hr_aber, hr_fech, logradouro, numero, complemento, bairro, cep, cidade, sg_estado, geometria) VALUES (18, 'Restaurante Comunitário Samambaia Expansão', -15.8893, -48.147484, '07:00:00', '19:00:00', 'Quadra 833 - Conjunto 8 - Lote 1', NULL, 'Samambaia Norte', 'Samambaia Expansão', '00000000', 'Samambaia', 'DF', '0101000020E6100000755776C1E01248C065AA605452C72FC0');

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

-- Novos inserts para cardapio (um por data)
INSERT INTO public.cardapio (cd_cardapio, dt_cardapio, cd_rest) VALUES
(1, '2025-06-02', 1),
(2, '2025-06-03', 1),
(3, '2025-06-04', 1),
(4, '2025-06-05', 1),
(5, '2025-06-06', 1),
(6, '2025-06-07', 1),
(7, '2025-06-08', 1),
(8, '2025-06-09', 1),
(9, '2025-06-10', 1),
(10, '2025-06-11', 1),
(11, '2025-06-12', 1),
(12, '2025-06-13', 1),
(13, '2025-06-14', 1),
(14, '2025-06-15', 1),
(15, '2025-06-16', 1),
(16, '2025-06-17', 1),
(17, '2025-06-18', 1),
(18, '2025-06-19', 1),
(19, '2025-06-20', 1),
(20, '2025-06-21', 1),
(21, '2025-06-22', 1),
(22, '2025-06-23', 1),
(23, '2025-06-24', 1),
(24, '2025-06-25', 1),
(25, '2025-06-26', 1),
(26, '2025-06-27', 1),
(27, '2025-06-28', 1),
(28, '2025-06-29', 1),
(29, '2025-06-30', 1),
(30, '2025-07-01', 1),
(31, '2025-07-02', 1),
(32, '2025-07-03', 1),
(33, '2025-07-04', 1),
(34, '2025-07-05', 1),
(35, '2025-07-06', 1);

-- Refeições com cd_cardapio atualizado
INSERT INTO refeicao (cd_refeicao, valor_calorico, tipo, cd_cardapio) VALUES
(1, 435, 1, 1), -- Segunda-Feira 02/06/2025: Cuscuz com manteiga e queijo
(2, 509, 1, 2), -- Terça-Feira 03/06/2025: Rosca
(3, 796, 1, 3), -- Quarta-Feira 04/06/2025: Pão com manteiga e presunto
(4, 477, 1, 4), -- Quinta-Feira 05/06/2025: Biscoito de queijo ou pão de queijo
(5, 775, 1, 5), -- Sexta-Feira 06/06/2025: Pão com manteiga e queijo
(6, 840, 1, 6), -- Sábado 07/06/2025: Pão com manteiga e OVO
(7, 712, 1, 7), -- Domingo 08/06/2025: Cuscuz com manteiga e ovo
(8, 789, 1, 8), -- Segunda-Feira 09/06/2025: Pão com manteiga e queijo
(9, 691, 1, 9), -- Terça-Feira 10/06/2025: Pão com manteiga e presunto
(10, 470, 1, 10), -- Quarta-Feira 11/06/2025: Biscoito de queijo ou pão de queijo
(11, 700, 1, 11), -- Quinta-Feira 12/06/2025: Cuscuz com manteiga e ovo
(12, 575, 1, 12), -- Sexta-Feira 13/06/2025: Bolo
(13, 544, 1, 13), -- Sábado 14/06/2025: Cuscuz com manteiga e queijo
(14, 840, 1, 14), -- Domingo 15/06/2025: Pão com manteiga e ovo
(15, 712, 1, 15), -- Segunda-Feira 16/06/2025: Cuscuz com manteiga e ovo
(16, 530, 1, 16), -- Terça-Feira 17/06/2025: Rosca
(17, 418, 1, 17), -- Quarta-Feira 18/06/2025: Cuscuz com manteiga e queijo
(18, 796, 1, 18), -- Quinta-Feira 19/06/2025: Pão com manteiga e presunto
(19, 758, 1, 19), -- Sexta-Feira 20/06/2025: Pão com manteiga e queijo
(20, 829, 1, 20), -- Sábado 21/06/2025: Pão com manteiga e OVO
(21, 579, 1, 21), -- Domingo 22/06/2025: Biscoito de queijo ou pão de queijo
(22, 694, 1, 22), -- Segunda-feira 23/06/2025: Pão com manteiga e presunto
(23, 676, 1, 23), -- Terça-feira 24/06/2025: Biscoito de queijo ou pão de queijo
(24, 474, 1, 24), -- Quarta-Feira 25/06/2025: Bolo
(25, 720, 1, 25), -- Quinta-feira 26/06/2025: Cuscuz com manteiga e ovo
(26, 890, 1, 26), -- Sexta-Feira 27/06/2025: Pão com manteiga e OVO
(27, 544, 1, 27), -- Sábado 28/06/2025: Cuscuz com manteiga e queijo
(28, 771, 1, 28), -- Domingo 29/06/2025: Pão com manteiga e queijo
(29, 789, 1, 29), -- Segunda-Feira 30/06/2025: Cuscuz com manteiga e queijo
(30, 691, 1, 30), -- Terça-Feira 01/07/2025: Pão com manteiga e presunto
(31, 470, 1, 31), -- Quarta-Feira 02/07/2025: Pão com manteiga e queijo
(32, 700, 1, 32), -- Quinta-Feira 03/07/2025: Cuscuz com manteiga e ovo
(33, 575, 1, 33), -- Sexta-Feira 04/07/2025: Bolo
(34, 544, 1, 34), -- Sábado 05/07/2025: Biscoito de queijo ou pão de queijo
(35, 840, 1, 35), -- Domingo 06/07/2025: Pão com manteiga e OVO
(36, 587, 3, 1), -- Segunda-Feira 02/06/2025: Macarrão a bolonhesa
(37, 445, 3, 2), -- Terça-Feira 03/06/2025: Arroz carreteiro
(38, 682, 3, 3), -- Quarta-Feira 04/06/2025: Galinhada
(39, 740, 3, 4), -- Quinta-Feira 05/06/2025: Creme de abóbora com carne moída e couve-manteiga
(40, 563, 3, 5), -- Sexta-Feira 06/06/2025: Canja de galinha
(41, 620, 3, 6), -- Sábado 07/06/2025: Sopa de legumes com carne moída e macarrão
(42, 689, 3, 7), -- Domingo 08/06/2025: Caldo de milho(milho e fubá) com frango desfiado
(43, 755, 3, 8), -- Segunda-Feira 09/06/2025: Arroz colorido com frango
(44, 810, 3, 9), -- Terça-Feira 10/06/2025: Caldo de feijão com carne moída, macarrão e cheiro verde
(45, 600, 3, 10), -- Quarta-Feira 11/06/2025: Caldo verde(batata, mandioca e couve) com carne moída
(46, 580, 3, 11), -- Quinta-Feira 12/06/2025: Sopa de frango com macarrão e legumes
(47, 700, 3, 12), -- Sexta-Feira 13/06/2025: Pão de sal com carne moída
(48, 650, 3, 13), -- Sábado 14/06/2025: Caldo de batata, milho e frango
(49, 720, 3, 14), -- Domingo 15/06/2025: Macarronada com frango
(50, 780, 3, 15), -- Segunda-Feira 16/06/2025: Baião de três
(51, 850, 3, 16), -- Terça-Feira 17/06/2025: Sopa de macarrão, legumes e carne moída
(52, 630, 3, 17), -- Quarta-Feira 18/06/2025: Vaca atolada
(53, 595, 3, 18), -- Quinta-Feira 19/06/2025: Macarrão oriental com carne e legumes
(54, 715, 3, 19), -- Sexta-Feira 20/06/2025: Creme de abóbora com batata, frango e couve manteiga
(55, 660, 3, 20), -- Sábado 21/06/2025: Arroz cremoso com carne moída
(56, 730, 3, 21), -- Domingo 22/06/2025: Macarronada de frango
(57, 790, 3, 22), -- Segunda-feira 23/06/2025: Macarrão a bolonhesa
(58, 860, 3, 23), -- Terça-feira 24/06/2025: Arroz carreteiro
(59, 640, 3, 24), -- Quarta-Feira 25/06/2025: Galinhada
(60, 605, 3, 25), -- Quinta-feira 26/06/2025: Creme de abóbora com carne moída e couve-manteiga
(61, 725, 3, 26), -- Sexta-Feira 27/06/2025: Canja de galinha
(62, 670, 3, 27), -- Sábado 28/06/2025: Sopa de legumes com carne moída e macarrão
(63, 740, 3, 28), -- Domingo 29/06/2025: Caldo de milho(milho e fubá) com frango desfiado
(64, 800, 3, 29), -- Segunda-Feira 30/06/2025: Arroz colorido com frango
(65, 870, 3, 30), -- Terça-Feira 01/07/2025: Caldo de feijão com carne moída, macarrão e cheiro verde
(66, 650, 3, 31), -- Quarta-Feira 02/07/2025: Caldo verde(batata, mandioca e couve) com carne moída
(67, 615, 3, 32), -- Quinta-Feira 03/07/2025: Sopa de frango com macarrão e legumes
(68, 735, 3, 33), -- Sexta-Feira 04/07/2025: Pão de sal com carne moída
(69, 680, 3, 34), -- Sábado 05/07/2025: Caldo de batata, milho e frango
(70, 750, 3, 35), -- Domingo 06/07/2025: Macarronada com frango
(71, 1026, 2, 1), -- Segunda-Feira 02/06/2025: Moqueca de peixe (posta)
(72, 1229, 2, 2), -- Terça-Feira 03/06/2025: Coxa / sobrecoxa de frango assado
(73, 804, 2, 3), -- Quarta-Feira 04/06/2025: Picadinho de carne
(74, 1035, 2, 4), -- Quinta-Feira 05/06/2025: Isca de frango ao molho de açafrão
(75, 1418, 2, 5), -- Sexta-Feira 06/06/2025: Feijoada
(76, 892, 2, 6), -- Sábado 07/06/2025: Silveirinha de frango
(77, 1289, 2, 7), -- Domingo 08/06/2025: Carne moída com milho
(78, 934, 2, 8), -- Segunda-Feira 09/06/2025: Isca de fígado acebolado
(79, 1158, 2, 9), -- Terça-Feira 10/06/2025: Coxa / sobrecoxa de frango assado
(80, 820, 2, 10), -- Quarta-Feira 11/06/2025: Carne bovina ao molho escuro
(81, 1074, 2, 11), -- Quinta-Feira 12/06/2025: Cubos de frango ao molho de tomate com manjericão
(82, 1418, 2, 12), -- Sexta-Feira 13/06/2025: Feijoada
(83, 851, 2, 13), -- Sábado 14/06/2025: Isca de frango acebolado
(84, 875, 2, 14), -- Domingo 15/06/2025: Carne assada ao molho escuro
(85, 1186, 2, 15), -- Segunda-Feira 16/06/2025: Carne moída com batata
(86, 1293, 2, 16), -- Terça-Feira 17/06/2025: Coxa / sobrecoxa de frango assado
(87, 1233, 2, 17), -- Quarta-Feira 18/06/2025: Carne suína ao barbecue
(88, 847, 2, 18), -- Quinta-Feira 19/06/2025: Picadinho de carne com milho
(89, 1241, 2, 19), -- Sexta-Feira 20/06/2025: Feijoada
(90, 1109, 2, 20), -- Sábado 21/06/2025: Cubos de frango a moda caipira
(91, 882, 2, 21), -- Domingo 22/06/2025: Carne bovina ao molho vermelho
(92, 924, 2, 22), -- Segunda-feira 23/06/2025: Silveirinha de carne moída
(93, 1136, 2, 23), -- Terça-feira 24/06/2025: Coxa / sobrecoxa de frango assado
(94, 917, 2, 24), -- Quarta-Feira 25/06/2025: Dobradinha
(95, 1096, 2, 25), -- Quinta-feira 26/06/2025: Isca de frango a pizzaiolo
(96, 1284, 2, 26), -- Sexta-Feira 27/06/2025: Feijoada
(97, 1194, 2, 27), -- Sábado 28/06/2025: Estrogonofe de frango
(98, 1189, 2, 28), -- Domingo 29/06/2025: Carne à chinesa
(99, 919, 2, 29), -- Segunda-Feira 30/06/2025: Filé de peixe ao molho de tomate
(100, 1319, 2, 30), -- Terça-Feira 01/07/2025: Coxa / sobrecoxa de frango assado
(101, 917, 2, 31), -- Quarta-Feira 02/07/2025: Picadinho de carne
(102, 1096, 2, 32), -- Quinta-Feira 03/07/2025: Cubos de frango ao molho com manjericão
(103, 1284, 2, 33), -- Sexta-Feira 04/07/2025: Feijoada
(104, 1194, 2, 34), -- Sábado 05/07/2025: Isca de frango com cebola caramelizada
(105, 1175, 2, 35); -- Domingo 06/07/2025: Cubos de carne à primavera


-- Café da manhã
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES
(4, 1), -- Cuscuz com manteiga e queijo
(10, 1), -- Leite e café
(12, 1), -- Laranja

(9, 2), -- Rosca
(10, 2), -- Leite e café
(15, 2), -- Melancia

(6, 3), -- Pão com manteiga e presunto
(10, 3), -- Leite e café
(11, 3), -- Banana

(1, 4), -- Biscoito de queijo
(8, 4), -- Pão de queijo
(10, 4), -- Leite e café
(17, 4), -- Tangerina

(7, 5), -- Pão com manteiga e queijo
(10, 5), -- Leite e café
(14, 5), -- Mamão

(5, 6), -- Pão com manteiga e ovo
(10, 6), -- Leite e café
(13, 6), -- Maçã

(3, 7), -- Cuscuz com manteiga e ovo
(10, 7), -- Leite e café
(12, 7), -- Laranja

(7, 8), -- Pão com manteiga e queijo
(10, 8), -- Leite e café
(13, 8), -- Maçã

(6, 9), -- Pão com manteiga e presunto
(10, 9), -- Leite e café
(14, 9), -- Mamão

(1, 10), -- Biscoito de queijo
(8, 10), -- Pão de queijo
(10, 10), -- Leite e café
(12, 10), -- Laranja

(3, 11), -- Cuscuz com manteiga e ovo
(10, 11), -- Leite e café
(15, 11), -- Melancia

(2, 12), -- Bolo
(10, 12), -- Leite e café
(17, 12), -- Tangerina

(4, 13), -- Cuscuz com manteiga e queijo
(10, 13), -- Leite e café
(11, 13), -- Banana

(5, 14), -- Pão com manteiga e ovo
(10, 14), -- Leite e café
(13, 14), -- Maçã

(3, 15), -- Cuscuz com manteiga e ovo
(10, 15), -- Leite e café
(12, 15), -- Laranja

(9, 16), -- Rosca
(10, 16), -- Leite e café
(17, 16), -- Tangerina

(4, 17), -- Cuscuz com manteiga e queijo
(10, 17), -- Leite e café
(16, 17), -- Melão

(6, 18), -- Pão com manteiga e presunto
(10, 18), -- Leite e café
(11, 18), -- Banana

(7, 19), -- Pão com manteiga e queijo
(10, 19), -- Leite e café
(15, 19), -- Melancia

(5, 20), -- Pão com manteiga e ovo
(10, 20), -- Leite e café
(17, 20), -- Tangerina

(1, 21), -- Biscoito de queijo
(8, 21), -- Pão de queijo
(10, 21), -- Leite e café
(11, 21), -- Banana

(6, 22), -- Pão com manteiga e presunto
(10, 22), -- Leite e café
(17, 22), -- Tangerina

(1, 23), -- Biscoito de queijo
(8, 23), -- Pão de queijo
(10, 23), -- Leite e café
(11, 23), -- Banana

(2, 24), -- Bolo
(10, 24), -- Leite e café
(14, 24), -- Mamão

(3, 25), -- Cuscuz com manteiga e ovo
(10, 25), -- Leite e café
(17, 25), -- Tangerina

(5, 26), -- Pão com manteiga e ovo
(10, 26), -- Leite e café
(15, 26), -- Melancia

(4, 27), -- Cuscuz com manteiga e queijo
(10, 27), -- Leite e café
(11, 27), -- Banana

(7, 28), -- Pão com manteiga e queijo
(10, 28), -- Leite e café
(12, 28), -- Laranja

(4, 29), -- Cuscuz com manteiga e queijo
(10, 29), -- Leite e café
(13, 29), -- Maçã

(6, 30), -- Pão com manteiga e presunto
(10, 30), -- Leite e café
(14, 30), -- Mamão

(7, 31), -- Pão com manteiga e queijo
(10, 31), -- Leite e café
(12, 31), -- Laranja

(3, 32), -- Cuscuz com manteiga e ovo
(10, 32), -- Leite e café
(15, 32), -- Melancia

(2, 33), -- Bolo
(10, 33), -- Leite e café
(17, 33), -- Tangerina

(1, 34), -- Biscoito de queijo
(8, 34), -- Pão de queijo
(10, 34), -- Leite e café
(11, 34), -- Banana

(5, 35), -- Pão com manteiga e ovo
(10, 35), -- Leite e café
(13, 35); -- Maçã

-- Almoço

INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (11, 71);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (18, 71);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (24, 71);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (30, 71);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (39, 71);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (46, 71);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (47, 71);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (48, 71);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (58, 71);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (17, 72);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (19, 72);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (31, 72);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (43, 72);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (46, 72);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (47, 72);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (48, 72);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (58, 72);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (14, 73);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (20, 73);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (32, 73);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (40, 73);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (46, 73);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (47, 73);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (48, 73);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (58, 73);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (21, 74);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (38, 74);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (41, 74);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (46, 74);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (47, 74);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (48, 74);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (53, 74);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (58, 74);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (12, 75);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (22, 75);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (25, 75);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (37, 75);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (42, 75);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (46, 75);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (47, 75);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (48, 75);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (58, 75);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (15, 76);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (45, 76);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (46, 76);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (47, 76);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (48, 76);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (58, 76);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (23, 77);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (39, 77);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (46, 77);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (47, 77);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (48, 77);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (54, 77);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (58, 77);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (17, 78);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (29, 78);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (38, 78);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (45, 78);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (46, 78);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (47, 78);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (48, 78);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (58, 78);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (11, 79);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (19, 79);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (33, 79);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (40, 79);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (46, 79);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (47, 79);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (48, 79);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (58, 79);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (13, 80);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (26, 80);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (40, 80);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (46, 80);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (47, 80);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (48, 80);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (58, 80);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (43, 81);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (46, 81);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (47, 81);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (48, 81);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (55, 81);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (58, 81);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (12, 82);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (22, 82);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (37, 82);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (42, 82);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (46, 82);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (47, 82);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (48, 82);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (58, 82);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (14, 83);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (21, 83);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (34, 83);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (43, 83);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (46, 83);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (47, 83);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (48, 83);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (58, 83);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (26, 84);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (35, 84);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (44, 84);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (46, 84);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (47, 84);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (48, 84);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (58, 84);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (15, 85);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (23, 85);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (45, 85);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (46, 85);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (47, 85);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (48, 85);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (58, 85);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (11, 86);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (19, 86);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (37, 86);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (43, 86);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (46, 86);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (47, 86);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (48, 86);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (58, 86);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (29, 87);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (43, 87);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (46, 87);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (47, 87);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (48, 87);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (56, 87);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (58, 87);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (17, 88);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (20, 88);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (35, 88);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (41, 88);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (46, 88);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (47, 88);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (48, 88);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (58, 88);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (12, 89);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (22, 89);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (28, 89);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (37, 89);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (42, 89);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (46, 89);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (47, 89);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (48, 89);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (58, 89);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (30, 90);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (44, 90);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (46, 90);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (47, 90);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (48, 90);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (57, 90);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (58, 90);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (13, 91);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (38, 91);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (40, 91);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (46, 91);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (47, 91);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (48, 91);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (58, 91);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (15, 92);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (33, 92);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (43, 92);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (46, 92);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (47, 92);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (48, 92);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (58, 92);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (12, 93);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (19, 93);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (35, 93);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (40, 93);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (46, 93);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (47, 93);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (48, 93);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (58, 93);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (24, 94);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (40, 94);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (46, 94);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (47, 94);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (48, 94);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (52, 94);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (58, 94);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (11, 95);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (21, 95);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (43, 95);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (46, 95);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (47, 95);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (48, 95);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (58, 95);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (12, 96);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (22, 96);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (28, 96);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (37, 96);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (42, 96);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (46, 96);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (47, 96);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (48, 96);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (58, 96);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (27, 97);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (38, 97);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (45, 97);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (46, 97);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (47, 97);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (48, 97);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (58, 97);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (16, 98);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (44, 98);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (46, 98);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (47, 98);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (48, 98);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (58, 98);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (18, 99);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (29, 99);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (38, 99);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (40, 99);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (46, 99);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (47, 99);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (48, 99);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (58, 99);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (11, 100);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (19, 100);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (31, 100);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (43, 100);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (46, 100);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (47, 100);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (48, 100);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (58, 100);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (20, 101);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (36, 101);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (40, 101);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (46, 101);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (47, 101);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (48, 101);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (54, 101);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (58, 101);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (13, 102);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (35, 102);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (45, 102);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (46, 102);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (47, 102);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (48, 102);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (58, 102);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (12, 103);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (22, 103);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (25, 103);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (37, 103);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (42, 103);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (46, 103);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (47, 103);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (48, 103);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (58, 103);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (17, 104);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (21, 104);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (32, 104);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (44, 104);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (46, 104);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (47, 104);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (48, 104);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (58, 104);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (11, 105);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (34, 105);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (45, 105);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (46, 105);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (47, 105);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (48, 105);
INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES (58, 105);

-- Jantar

INSERT INTO refeicao_alimento (cd_alimento, cd_refeicao) VALUES
(59, 36), -- Macarrão a bolonhesa
(60, 37), -- Arroz carreteiro
(61, 38), -- Galinhada
(62, 39), -- Creme de abóbora com carne moída e couve-manteiga
(63, 40), -- Canja de galinha
(64, 41), -- Sopa de legumes com carne moída e macarrão
(65, 42), -- Caldo de milho (milho e fubá) com frango desfiado
(66, 43), -- Arroz colorido com frango
(67, 44), -- Caldo de feijão com carne moída, macarrão e cheiro verde
(61, 45), -- Galinhada
(68, 46), -- Caldo verde (batata, mandioca e couve) com carne moída
(69, 47), -- Sopa de frango com macarrão e legumes
(70, 48), -- Pão de sal com carne moída
(71, 49), -- Caldo de batata, milho e frango
(72, 50), -- Macarronada com frango
(73, 51), -- Baião de três
(61, 52), -- Galinhada
(74, 53), -- Sopa de macarrão, legumes e carne moída
(66, 54), -- Arroz colorido com frango
(75, 55), -- Vaca atolada
(60, 56), -- Arroz carreteiro
(63, 57), -- Canja de galinha
(76, 58), -- Macarrão oriental com carne e legumes
(61, 59), -- Galinhada
(67, 60), -- Caldo de feijão com macarrão e carne
(69, 61), -- Sopa de frango com macarrão e legumes
(73, 62), -- Baião de três
(77, 63), -- Creme de abóbora com batata, frango e couve manteiga
(78, 64), -- Arroz cremoso com carne moída
(69, 65), -- Sopa de frango com macarrão e legumes
(61, 66), -- Galinhada
(75, 67), -- Vaca atolada
(79, 68), -- Macarronada de frango
(73, 69), -- Baião de três
(71, 70); -- Caldo de batata, milho e frango

