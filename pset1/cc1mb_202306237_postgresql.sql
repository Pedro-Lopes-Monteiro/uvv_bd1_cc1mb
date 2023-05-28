--Essa linha exclui um banco de dados com o mesmo nome, se existente.

DROP DATABASE IF EXISTS uvv;

--Essa linha exclui um usuário com o mesmo nome se existir.

DROP USER IF EXISTS pedrolopes;

--Essa linha cria o usuário do banco de dados.

CREATE USER pedrolopes  WITH 
    CREATEDB 
    CREATEROLE  
    ENCRYPTED  PASSWORD '7432eb146e77b7df0c4b01cd936d36fa';

--Essa linha cria o banco de dados.

CREATE DATABASE uvv
     WITH   OWNER = pedrolopes 
            TEMPLATE = template0 
            ENCODING = 'UTF8' 
            LC_COLLATE = 'pt_BR.UTF-8'
            LC_CTYPE = 'pt_BR.UTF-8'
            ALLOW_CONNECTIONS = true;

--Essa linha comenta o banco de dados.

COMMENT ON DATABASE uvv IS 'Esse banco de dados é utilizado para salvar as informações das lojas da uvv.';

--Essa linha conecta o usuário ao banco de dados.

\c postgres://pedrolopes:7432eb146e77b7df0c4b01cd936d36fa@localhost/uvv

--Essa linha cria o schema.

CREATE SCHEMA lojas AUTHORIZATION pedrolopes;

--Essa linha define o schema a ser utilizado.

alter user pedrolopes
set search_path to lojas, pedrolopes, public;

--Essa linha cria a tabela produtos.

CREATE TABLE lojas.produtos (
                   produto_id                   NUMERIC(38)     NOT NULL,
                   nome                         VARCHAR(255)    NOT NULL,
                   preco_unitario               NUMERIC(10,2),
                   detalhes                     BYTEA,
                   imagem                       BYTEA,
                   imagem_mime_type             VARCHAR(512),
                   imagem_arquivo               VARCHAR(512),
                   imagem_charset               VARCHAR(512),
                   imagem_ultima_atualizacao    DATE,

                   CONSTRAINT pk_produtos          PRIMARY KEY (produto_id)
);

--Comentários da tabela produtos.

COMMENT ON TABLE  lojas.produtos                            IS  'Tabela para salvar as informações dos produtos.';
COMMENT ON COLUMN lojas.produtos.produto_id                 IS  'Coluna para salvar o número de identificação do produto.';
COMMENT ON COLUMN lojas.produtos.nome                       IS  'Coluna para salvar o nome dos produtos.';
COMMENT ON COLUMN lojas.produtos.preco_unitario             IS  'Coluna para salvar o preço de cada produto.';
COMMENT ON COLUMN lojas.produtos.detalhes                   IS  'Coluna para salvar os detalhes dos produtos.';
COMMENT ON COLUMN lojas.produtos.imagem                     IS  'Coluna para salvar as imagens dos produtos.';
COMMENT ON COLUMN lojas.produtos.imagem_mime_type           IS  'Coluna para salvar a imagem dos produtos em um tipo específico de arquivo.';
COMMENT ON COLUMN lojas.produtos.imagem_arquivo             IS  'Coluna para salvar o arquivo da imagem.';
COMMENT ON COLUMN lojas.produtos.imagem_charset             IS  'Coluna para salvar os caracteres da imagem.';
COMMENT ON COLUMN lojas.produtos.imagem_ultima_atualizacao  IS  'Coluna para salvar a data da última atualização na imagem do produto.';

--Essa linha cria a tabela lojas.

CREATE TABLE lojas.lojas (
                   loja_id                    NUMERIC(38)     NOT NULL,
                   nome                       VARCHAR(255)    NOT NULL,
                   endereco_web               VARCHAR(100),
                   endereco_fisico            VARCHAR(512),
                   latitude                   NUMERIC,
                   longitude                  NUMERIC,
                   logo                       BYTEA,
                   logo_mime_type             VARCHAR(512),
                   logo_arquivo               VARCHAR(512),
                   logo_charset               VARCHAR(512),
                   logo_ultima_atualizacao    DATE, 

                   CONSTRAINT pk_lojas          PRIMARY KEY (loja_id)
);

--Comentários da tabela lojas.

COMMENT ON TABLE  lojas.lojas                          IS  'Tabela para salvar as informações das lojas.';
COMMENT ON COLUMN lojas.lojas.loja_id                  IS  'Coluna para salvar o número de identificação da loja.';
COMMENT ON COLUMN lojas.lojas.nome                     IS  'Coluna para salvar o nome da loja.';
COMMENT ON COLUMN lojas.lojas.endereco_web             IS  'Coluna para salvar a URL da loja.';
COMMENT ON COLUMN lojas.lojas.endereco_fisico          IS  'Coluna para salvar o endereço físico da loja.';
COMMENT ON COLUMN lojas.lojas.latitude                 IS  'Coluna para salvar a latitude em que a loja está localizada.';
COMMENT ON COLUMN lojas.lojas.longitude                IS  'Coluna para salvar a longitude em que a loja está localizada.';
COMMENT ON COLUMN lojas.lojas.logo                     IS  'Coluna para salvar a logo da loja.';
COMMENT ON COLUMN lojas.lojas.logo_mime_type           IS  'Coluna para salvar a logo da loja em um tipo específico de arquivo.';
COMMENT ON COLUMN lojas.lojas.logo_arquivo             IS  'Coluna para salvar o arquivo da logo.';
COMMENT ON COLUMN lojas.lojas.logo_charset             IS  'Coluna para salvar os caracteres da logo.';
COMMENT ON COLUMN lojas.lojas.logo_ultima_atualizacao  IS  'Coluna para salvar a data da última atualização na logo.';

--Essa linha cria a tabela estoques.

CREATE TABLE lojas.estoques (
                   estoque_id               NUMERIC(38)   NOT NULL,
                   FK_estoques_loja_id      NUMERIC(38)   NOT NULL,
                   FK_estoques_produto_id   NUMERIC(38)   NOT NULL,
                   quantidade               NUMERIC(38)   NOT NULL,

                   CONSTRAINT pk_estoques    PRIMARY KEY (estoque_id)
);

--Comentários da tabela estoques.

COMMENT ON TABLE  lojas.estoques                         IS  'Tabela para guardar as informações dos estoques.';
COMMENT ON COLUMN lojas.estoques.estoque_id              IS  'Coluna para salvar o número de identificação do estoque.';
COMMENT ON COLUMN lojas.estoques.FK_estoques_loja_id     IS  'FK da tabela lojas.';
COMMENT ON COLUMN lojas.estoques.FK_estoques_produto_id  IS  'FK da tabela produtos.';
COMMENT ON COLUMN lojas.estoques.quantidade              IS  'Coluna para salvar a quantidade de produtos no estoque.';

--Essa linha cria a tabela clientes.

CREATE TABLE lojas.clientes (
                   cliente_id   NUMERIC(38)    NOT NULL,
                   email        VARCHAR(255)   NOT NULL,
                   nome         VARCHAR(255)   NOT NULL,
                   telefone1    VARCHAR(20),
                   telefone2    VARCHAR(20),
                   telefone3    VARCHAR(20),

                   CONSTRAINT pk_clientes    PRIMARY KEY (cliente_id)
);

--Comentários da tabela clientes.   

COMMENT ON TABLE  lojas.clientes             IS  'Tabela para salvar os contatos dos clientes.';
COMMENT ON COLUMN lojas.clientes.cliente_id  IS  'Coluna para salvar o número de identificação específica do cliente.';
COMMENT ON COLUMN lojas.clientes.email       IS  'Coluna para salvar o e-mail de contato do cliente.';
COMMENT ON COLUMN lojas.clientes.nome        IS  'Coluna para salvar o nome do cliente.';
COMMENT ON COLUMN lojas.clientes.telefone1   IS  'Coluna para salvar o primeiro de três possíveis números de contato do cliente.';
COMMENT ON COLUMN lojas.clientes.telefone2   IS  'Coluna para salvar o segundo de três possíveis números de contato do cliente.';
COMMENT ON COLUMN lojas.clientes.telefone3   IS  'Coluna para salvar o terceiro de três possíveis números de contato do cliente.';

--Essa linha cria a tabela envios.

CREATE TABLE lojas.envios (
                   envio_id              NUMERIC(38)   NOT NULL,
                   FK_envios_loja_id     NUMERIC(38)   NOT NULL,
                   FK_envios_cliente_id  NUMERIC(38)   NOT NULL,
                   endereco_entrega      VARCHAR(512)  NOT NULL,
                   status                VARCHAR(15)   NOT NULL,
   
                   CONSTRAINT pk_envios    PRIMARY KEY (envio_id)
);

--Comentários da tabela envios.

COMMENT ON TABLE  lojas.envios                      IS  'Tabela para salvar as informações dos envios.';
COMMENT ON COLUMN lojas.envios.envio_id             IS  'Coluna para salvar o número de identificação do envio.';
COMMENT ON COLUMN lojas.envios.FK_envios_loja_id    IS  'FK da tabela lojas.';
COMMENT ON COLUMN lojas.envios.FK_envios_cliente_id IS  'FK da tabela clientes.';
COMMENT ON COLUMN lojas.envios.endereco_entrega     IS  'Coluna para salvar o endereço da entrega.';
COMMENT ON COLUMN lojas.envios.status               IS  'Coluna para salvar o status do envio.';

--Essa linha cria a tabela pedidos.

CREATE TABLE lojas.pedidos (
                   pedido_id               NUMERIC(38)   NOT NULL,
                   data_hora               TIMESTAMP     NOT NULL,
                   FK_pedidos_cliente_id   NUMERIC(38)   NOT NULL,
                   status                  VARCHAR(15)   NOT NULL,
                   FK_pedidos_loja_id      NUMERIC(38)   NOT NULL,

                   CONSTRAINT pk_pedidos     PRIMARY KEY (pedido_id)
);

--Comentários da tabela pedidos.

COMMENT ON TABLE  lojas.pedidos                       IS  'Tabela para guardar as informações dos pedidos realizados.';
COMMENT ON COLUMN lojas.pedidos.pedido_id             IS  'Coluna para salvar o número de identificação do pedido.';
COMMENT ON COLUMN lojas.pedidos.data_hora             IS  'Coluna para guardar as informações de data e hora em que o pedido foi realizado.';
COMMENT ON COLUMN lojas.pedidos.FK_pedidos_cliente_id IS  'FK da tabela clientes.';
COMMENT ON COLUMN lojas.pedidos.status                IS  'coluna para salvar o status atual do pedido';
COMMENT ON COLUMN lojas.pedidos.FK_pedidos_loja_id    IS  'FK da tabela lojas.';

--Essa linha cria a tabela pedidos_itens.

CREATE TABLE lojas.pedidos_itens (
                   PFK_pedido_id               NUMERIC(38)     NOT NULL,
                   PFK_produto_id              NUMERIC(38)     NOT NULL,
                   numero_da_linha             NUMERIC(38)     NOT NULL,
                   preco_unitario              NUMERIC(10,2)   NOT NULL,
                   quantidade                  NUMERIC(38)     NOT NULL,
                   FK_pedidos_itens_envio_id   NUMERIC(38),

                   CONSTRAINT pk_pedidos_itens     PRIMARY KEY (PFK_pedido_id, PFK_produto_id)
);

--Comentários da tabela pedidos_itens.

COMMENT ON TABLE  lojas.pedidos_itens                            IS  'Tabela para guardar as informações dos intens dos pedidos.';
COMMENT ON COLUMN lojas.pedidos_itens.PFK_pedido_id              IS  'PK da tabela pedidos_itens e FK da tabela pedidos.';
COMMENT ON COLUMN lojas.pedidos_itens.PFK_produto_id             IS  'PK da tabela pedidos_itens e FK da tabela produtos.';
COMMENT ON COLUMN lojas.pedidos_itens.numero_da_linha            IS  'Coluna para salvar o número da linha dos itens.';
COMMENT ON COLUMN lojas.pedidos_itens.preco_unitario             IS  'Coluna para salvar o preço do itens do pedido.';
COMMENT ON COLUMN lojas.pedidos_itens.quantidade                 IS  'Coluna para salvar a quantidade de itens no pedido.';
COMMENT ON COLUMN lojas.pedidos_itens.FK_pedidos_itens_envio_id  IS  'FK da tabela envios.';


--Essa linha cria uma foreign key para a tabela produtos.

ALTER TABLE lojas.estoques ADD CONSTRAINT produtos_estoques_fk
FOREIGN KEY (FK_estoques_produto_id)
REFERENCES lojas.produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--Essa linha cria uma foreign key para a tabela lojas.

ALTER TABLE lojas.estoques ADD CONSTRAINT lojas_estoques_fk
FOREIGN KEY (FK_estoques_loja_id)
REFERENCES lojas.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--Essa linha cria uma foreign key para a tabela lojas.

ALTER TABLE lojas.envios ADD CONSTRAINT lojas_envios_fk
FOREIGN KEY (FK_envios_loja_id)
REFERENCES lojas.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--Essa linha cria uma foreign key para a tabela clientes.

ALTER TABLE lojas.envios ADD CONSTRAINT clientes_envios_fk
FOREIGN KEY (FK_envios_cliente_id)
REFERENCES lojas.clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--Essa linha cria uma foreign key para a tabela lojas.

ALTER TABLE lojas.pedidos ADD CONSTRAINT lojas_pedidos_fk
FOREIGN KEY (FK_pedidos_loja_id)
REFERENCES lojas.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--Essa linha cria uma foreign key para a tabela clientes.

ALTER TABLE lojas.pedidos ADD CONSTRAINT clientes_pedidos_fk
FOREIGN KEY (FK_pedidos_cliente_id)
REFERENCES lojas.clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--Essa linha cria uma foreign key para a tabela produtos.

ALTER TABLE lojas.pedidos_itens ADD CONSTRAINT produtos_pedidos_itens_fk
FOREIGN KEY (PFK_produto_id)
REFERENCES lojas.produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--Essa linha cria uma foreign key para a tabela envios.

ALTER TABLE lojas.pedidos_itens ADD CONSTRAINT envios_pedidos_itens_fk
FOREIGN KEY (FK_pedidos_itens_envio_id)
REFERENCES lojas.envios (envio_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--Essa linha cria uma foreign key para a tabela pedidos.

ALTER TABLE lojas.pedidos_itens ADD CONSTRAINT pedidos_pedidos_itens_fk
FOREIGN KEY (PFK_pedido_id)
REFERENCES lojas.pedidos (pedido_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;


/*Check constraints tabela produtos.*/

alter table lojas.produtos
add constraint cc_produtos_preco_unitario
check ( preco_unitario >= 0 );

alter table lojas.produtos
add constraint cc_produtos_produto_id
check ( produto_id >= 0 );

/*Check constraints tabela lojas.*/

alter table lojas.lojas
add constraint cc_lojas_loja_id
check ( loja_id >= 0 );

alter table lojas.lojas
add constraint cc_lojas_endereco_web
check (endereco_web ~ 'https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{2,255}\.[a-z]{2,9}\y([-a-zA-Z0-9@:%_\+.~#?&//=]*)$'); 
--Regex retirado do Stack OverFlow (https://stackoverflow.com/questions/42522442/how-to-validate-a-url-via-a-check-constraint-in-postgres).

alter table lojas.lojas
add constraint cc_lojas_endereco_web_null
check ((endereco_web IS NOT NULL AND endereco_fisico IS NULL));

alter table lojas.lojas
add constraint cc_lojas_endereco_fisico_null
check ((endereco_fisico IS NOT NULL AND endereco_web IS NULL));

/*Check constraints tabela estoques.*/

alter table lojas.estoques
add constraint cc_lojas_estoque_id
check ( estoque_id >= 0 );

alter table lojas.estoques
add constraint cc_lojas_FK_estoques_loja_id
check ( FK_estoques_loja_id >= 0 );

alter table lojas.estoques
add constraint cc_lojas_FK_estoques_produto_id
check ( FK_estoques_produto_id >= 0 );

alter table lojas.estoques
add constraint cc_lojas_quantidade
check ( quantidade >= 0 );

/*Check constraints tabela clientes.*/

alter table lojas.clientes
add constraint cc_lojas_cliente_id
check ( cliente_id >= 0 );

alter table lojas.clientes
add constraint cc_lojas_email
check (email ~ '^[A-Za-z0-9._+%-]+@[A-Za-z0-9.-]+[.][A-Za-z]+$'); 
--Regex retirado do Stack OverFlow (https://stackoverflow.com/questions/42522442/how-to-validate-a-url-via-a-check-constraint-in-postgres).

/*Check constraints tabela envios.*/

alter table lojas.envios
add constraint cc_lojas_envio_id
check ( envio_id >= 0 );

alter table lojas.envios
add constraint cc_lojas_FK_envios_loja_id
check ( FK_envios_loja_id >= 0 );

alter table lojas.envios
add constraint cc_lojas_FK_envios_cliente_id
check ( FK_envios_cliente_id >= 0 );

alter table lojas.envios
add constraint cc_lojas_status
check (status IN ('CRIADO', 'ENVIADO', 'TRANSITO', 'ENTREGUE'));

/*Check constraints tabela pedidos.*/

alter table lojas.pedidos
add constraint cc_lojas_pedido_id
check ( pedido_id >= 0 );

alter table lojas.pedidos
add constraint cc_lojas_FK_pedidos_cliente_id
check ( FK_pedidos_cliente_id >= 0 );

alter table lojas.pedidos
add constraint cc_lojas_status
check (status IN ('CANCELADO', 'COMPLETO', 'ABERTO', 'PAGO', 'REEMBOLSADO', 'ENVIADO'));

alter table lojas.pedidos
add constraint cc_lojas_FK_pedidos_loja_id
check ( FK_pedidos_loja_id >= 0 );

/*Check constraints tabela pedidos_itens.*/

alter table lojas.pedidos_itens
add constraint cc_lojas_PFK_pedido_id
check ( PFK_pedido_id >= 0 );

alter table lojas.pedidos_itens
add constraint cc_lojas_PFK_produto_id
check ( PFK_produto_id >= 0 );

alter table lojas.pedidos_itens
add constraint cc_lojas_numero_da_linha
check ( numero_da_linha >= 0 );

alter table lojas.pedidos_itens
add constraint cc_lojas_preco_unitario
check ( preco_unitario >= 0 );

alter table lojas.pedidos_itens
add constraint cc_lojas_quantidade
check ( quantidade >= 0 );

alter table lojas.pedidos_itens
add constraint cc_lojas_FK_pedidos_envio_id
check ( FK_pedidos_itens_envio_id >= 0 );
