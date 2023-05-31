
-- Verifica se existe um banco de dados chamado "uvv", se existir, exclui
DROP DATABASE IF EXISTS uvv;

-- Verifica se existe um usuario chamado "arthurmachado", se existir, exclui
DROP USER IF EXISTS arthurmachado;
-- Criando o usuario "arthurmachado"
CREATE USER arthurmachado WITH 
CREATEDB
CREATEROLE
INHERIT
ENCRYPTED PASSWORD 'arthur';
-- Criando o banco de dados "uvv"
CREATE DATABASE uvv WITH 
TEMPLATE = 'template0'
ENCODING = 'UTF8'
LC_COLLATE = 'pt_BR.UTF-8'
LC_CTYPE = 'pt_BR.UTF-8'
ALLOW_CONNECTIONS = 'true'
OWNER = 'arthurmachado';

--Iniciando conexão com o banco de dados
\c "dbname=uvv user=arthurmachado password=arthur"
SET ROLE arthurmachado;
-- Criando o schema e autorizando acesso do usúario "arthurmachado"
CREATE SCHEMA IF NOT EXISTS lojas AUTHORIZATION arthurmachado;
SET SEARCH_PATH TO lojas, "$user", public; 
--Trocando para o usuario "arthurmachado" e definindo como padrão o esquema lojas
ALTER USER arthurmachado
SET SEARCH_PATH TO lojas, "$user", public;

--Início da criação das tabelas com os comentários


--Criando a tabela produtos
CREATE TABLE produtos (
                produto_id NUMERIC(38) NOT NULL,
                nome VARCHAR(255) NOT NULL,
                preco_unitario NUMERIC(10,2),
                detalhes BYTEA,
                imagem BYTEA,
                imagem_mime_type VARCHAR(512),
                imagem_arquivo VARCHAR(512),
                imagem_charset VARCHAR(512),
                imagem_ultima_atualizacao DATE,
                CONSTRAINT pk_produto PRIMARY KEY (produto_id),
                
                --Criação das check constraints da tabela produtos
                
                CONSTRAINT ck_produtos_nome
                CHECK (nome IS NOT NULL),
                CONSTRAINT ck_produtos_preco_unitario
                CHECK (preco_unitario > 0));
               
-- Comentários da tabela "produtos" e suas colunas 
COMMENT ON TABLE produtos IS 'Tabela de produtos, contem os produtos das lojas';
COMMENT ON COLUMN produtos.produto_id IS 'Armazena o id do produto';
COMMENT ON COLUMN produtos.nome IS 'Armazena o nome do produto';
COMMENT ON COLUMN produtos.preco_unitario IS 'Armazena o preço unitario do produto';
COMMENT ON COLUMN produtos.detalhes IS 'Armazena os detalhes do produto';
COMMENT ON COLUMN produtos.imagem IS 'Armazena a imagem do produto';
COMMENT ON COLUMN produtos.imagem_mime_type IS 'Armazena o tipo de imagem do produto';
COMMENT ON COLUMN produtos.imagem_arquivo IS 'Armazena o tipo de arquivo da imagem do produto';
COMMENT ON COLUMN produtos.imagem_charset IS 'Armazena o charset do documento dos produtos';
COMMENT ON COLUMN produtos.imagem_ultima_atualizacao IS 'Armazena a data da ultima atualização da imagem do produto';

--Criando a tabela lojas
CREATE TABLE lojas (
                loja_id NUMERIC(38) NOT NULL,
                nome VARCHAR(255) NOT NULL,
                endereco_web VARCHAR(100),
                endereco_fisico VARCHAR(512),
                latitude NUMERIC,
                longitude NUMERIC,
                logo BYTEA,
                logo_mime_type VARCHAR(512),
                logo_arquivo VARCHAR(512),
                logo_charset VARCHAR(512),
                logo_ultima_atualizacao DATE,
                CONSTRAINT pk_loja PRIMARY KEY (loja_id),
                
                --Criação das check constraints da tabela lojas
                
                CONSTRAINT ck_lojas_nome
                CHECK (nome IS NOT NULL),
                CONSTRAINT ck_lojas_endereco 
                CHECK (endereco_web IS NOT NULL OR endereco_fisico IS NOT NULL));
               
--Comentários da tabela "lojas" e suas colunas
COMMENT ON TABLE lojas IS 'Tabela das lojas, contem as lojas';
COMMENT ON COLUMN lojas.loja_id IS 'armazena os id das lojas';
COMMENT ON COLUMN lojas.nome IS 'Armazena o nome das lojas';
COMMENT ON COLUMN lojas.endereco_web IS 'Armazena o endereço web das lojas';
COMMENT ON COLUMN lojas.endereco_fisico IS 'Armazena o endereço fisicio das lojas';
COMMENT ON COLUMN lojas.latitude IS 'Armazena a latitude das lojas';
COMMENT ON COLUMN lojas.longitude IS 'Armazena a longitude das lojas';
COMMENT ON COLUMN lojas.logo IS 'Armazena as logos das lojas';
COMMENT ON COLUMN lojas.logo_mime_type IS 'Armazena o tipo de logo das lojas';
COMMENT ON COLUMN lojas.logo_arquivo IS 'Armazena o arquivo de logo das lojas';
COMMENT ON COLUMN lojas.logo_charset IS 'Armazena o charset do documento das lojas';
COMMENT ON COLUMN lojas.logo_ultima_atualizacao IS 'Armazena a data da ultima atualização das logos das lojas';

--Criando a tabela estoques
CREATE TABLE estoques (
                estoque_id NUMERIC(38) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                produto_id NUMERIC(38) NOT NULL,
                quantidade NUMERIC(38) NOT NULL,
                CONSTRAINT pk_estoque PRIMARY KEY (estoque_id),
                
                --Criação das check constraints da tabela estoques
                
                CONSTRAINT ck_estoques_produto_id
                CHECK (produto_id IS NOT NULL AND produto_id > 0),
                CONSTRAINT ck_estoques_quantidade
                CHECK (quantidade IS NOT NULL AND quantidade >= 0));
               
--Comentários da tabela "estoques" e suas colunas
COMMENT ON TABLE estoques IS 'tabela de estoques, contem as informações de estoque das lojas';
COMMENT ON COLUMN estoques.estoque_id IS 'Armazena o id de indentificação do estoque';
COMMENT ON COLUMN estoques.loja_id IS 'Armazena o id de indentificação da loja';
COMMENT ON COLUMN estoques.produto_id IS 'Armazena o id do produto';
COMMENT ON COLUMN estoques.quantidade IS 'Armazena a quantidade de prodoutos';

--Criando a tabela clientes
CREATE TABLE Clientes (
                cliente_id NUMERIC(38) NOT NULL,
                email VARCHAR(255) NOT NULL,
                nome VARCHAR(255) NOT NULL,
                telefone1 VARCHAR(20),
                telefone2 VARCHAR(20),
                telefone3 VARCHAR(20),
                CONSTRAINT pk_cliente PRIMARY KEY (cliente_id),
                
                --Criação das check constraints da tabela clientes
                CONSTRAINT ck_clientes_nome 
                CHECK (nome IS NOT NULL),
                CONSTRAINT ck_clientes_email
                CHECK (email IS NOT NULL));
               
--Comentários da tabela "clientes" e suas colunas
COMMENT ON TABLE Clientes IS 'Tabela dos clientes, contem os dados dos clientes da loja';
COMMENT ON COLUMN Clientes.cliente_id IS 'armazena os id dos clientes';
COMMENT ON COLUMN Clientes.email IS 'Armazena o email dos clientes';
COMMENT ON COLUMN Clientes.nome IS 'Armazena o nome dos clientes';
COMMENT ON COLUMN Clientes.telefone1 IS 'Armazena o telefone 1 do cliente';
COMMENT ON COLUMN Clientes.telefone2 IS 'Armazena o telefone 2 do cliente';
COMMENT ON COLUMN Clientes.telefone3 IS 'Armazena o telefone 3 do cliente';

--Criando a tabela pedidos
CREATE TABLE pedidos (
                pedido_id NUMERIC(38) NOT NULL,
                data_hora TIMESTAMP NOT NULL,
                cliente_id NUMERIC(38) NOT NULL,
                status VARCHAR(15) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                CONSTRAINT pk_pedido PRIMARY KEY (pedido_id),
                
                --Criação das check constraints da tabela pedidos
                
                CONSTRAINT ck_pedidos_status
                CHECK (status IN ('CANCELADO','COMPLETO','ABERTO','PAGO','REEMBOLSADO','ENVIADO')),
                CONSTRAINT ck_data_hora 
                CHECK (data_hora IS NOT NULL));
               
--Comentários da tabela "pedidos" e suas colunas
COMMENT ON TABLE pedidos IS 'Tabela dos pedidos, contem os pedidos das lojas';
COMMENT ON COLUMN pedidos.pedido_id IS 'o numero de id do pedido';
COMMENT ON COLUMN pedidos.data_hora IS 'armazena o horario do pedido ';
COMMENT ON COLUMN pedidos.cliente_id IS 'armazena o id do cliente';
COMMENT ON COLUMN pedidos.status IS 'armazena o status do pedido';
COMMENT ON COLUMN pedidos.loja_id IS 'armazena o id da loja';

--Criando a tabela envios
CREATE TABLE envios (
                envio_id NUMERIC(38) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                cliente_id NUMERIC(38) NOT NULL,
                endereco_entrega VARCHAR(512) NOT NULL,
                status VARCHAR(15) NOT NULL,
                CONSTRAINT pk_envio PRIMARY KEY (envio_id),
                
                --Criação das check constraints da tabela envios
                
                CONSTRAINT ck_envios_status
                CHECK (status IN ('CRIADO','ENVIADO','TRANSITO','ENTREGUE')),
                CONSTRAINT ck_envios_endereco_entrega
                CHECK (endereco_entrega IS NOT NULL));
               
--Comentários da tabela "envios" e suas colunas
COMMENT ON TABLE envios IS 'Tabela de envio contem as informações para envio dos produtos das lojas';
COMMENT ON COLUMN envios.envio_id IS 'armazena os id dos envios';
COMMENT ON COLUMN envios.loja_id IS 'armazena os id de intedificação da loja';
COMMENT ON COLUMN envios.cliente_id IS 'armazena o id dos clientes';
COMMENT ON COLUMN envios.endereco_entrega IS 'Armazena os dados de endereço de entrega';
COMMENT ON COLUMN envios.status IS 'Armazena o status de envio do pedido';

--Criando a tabela pedidos_itens
CREATE TABLE pedidos_itens (
                pedido_id NUMERIC(38) NOT NULL,
                produto_id NUMERIC(38) NOT NULL,
                numero_da_linha NUMERIC(38) NOT NULL,
                preco_unitario NUMERIC(10,2) NOT NULL,
                quantidade NUMERIC(38) NOT NULL,
                envio_id NUMERIC(38),
                CONSTRAINT pedido_pk PRIMARY KEY (pedido_id, produto_id),
                
                 --Criação das check constraints da tabela pedidos_itens
                
                CONSTRAINT ck_pedidos_itens_preco_unitario
                CHECK (preco_unitario IS NOT NULL AND preco_unitario > 0),
                CONSTRAINT ck_pedidos_itens_quantidade
                CHECK (quantidade IS NOT NULL AND quantidade > 0));
               
--Comentários da tabela "pedidos_itens" e suas colunas
COMMENT ON TABLE pedidos_itens IS 'armazena o itens dos pedidos';
COMMENT ON COLUMN pedidos_itens.pedido_id IS 'armazena o id do pedido';
COMMENT ON COLUMN pedidos_itens.produto_id IS 'armazena o id do produto';
COMMENT ON COLUMN pedidos_itens.numero_da_linha IS 'armazena o numero de linhas ';
COMMENT ON COLUMN pedidos_itens.preco_unitario IS 'armazena o preco pela unidade ';
COMMENT ON COLUMN pedidos_itens.quantidade IS 'armazena a quantidade do pedido';
COMMENT ON COLUMN pedidos_itens.envio_id IS 'armazena o id do envio';

--Criação dos relacionamentos 

--Adicionando a Fk produtos e estoques
ALTER TABLE estoques ADD CONSTRAINT produtos_estoques_fk
FOREIGN KEY (produto_id)
REFERENCES produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
--Adicionando a Fk produtos e pedidos_itens
ALTER TABLE pedidos_itens ADD CONSTRAINT produtos_pedidos_itens_fk
FOREIGN KEY (produto_id)
REFERENCES produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
--Adicionando a Fk lojas e envios
ALTER TABLE envios ADD CONSTRAINT lojas_envios_fk
FOREIGN KEY (loja_id)
REFERENCES lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
--Adicionando a Fk lojas e estoques
ALTER TABLE estoques ADD CONSTRAINT lojas_estoques_fk
FOREIGN KEY (loja_id)
REFERENCES lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
--Adicionando a Fk lojas e pedidos
ALTER TABLE pedidos ADD CONSTRAINT lojas_pedidos_fk
FOREIGN KEY (loja_id)
REFERENCES lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
--Adicionando a Fk clientes e envios
ALTER TABLE envios ADD CONSTRAINT clientes_envios_fk
FOREIGN KEY (cliente_id)
REFERENCES Clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
--Adicionando a Fk clientes e pedidos
ALTER TABLE pedidos ADD CONSTRAINT clientes_pedidos_fk
FOREIGN KEY (cliente_id)
REFERENCES Clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
--Adicionando a Fk pedidos e pedidos_itens
ALTER TABLE pedidos_itens ADD CONSTRAINT pedidos_pedidos_itens_fk
FOREIGN KEY (pedido_id)
REFERENCES pedidos (pedido_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
--Adicionando a Fk envios e pedidos_itens
ALTER TABLE pedidos_itens ADD CONSTRAINT envios_pedidos_itens_fk
FOREIGN KEY (envio_id)
REFERENCES envios (envio_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;





