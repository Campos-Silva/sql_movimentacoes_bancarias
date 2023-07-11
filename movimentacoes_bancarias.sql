-- Criando o banco de dados "DB_CONTAS":
CREATE DATABASE DB_CONTAS;

-- Utilizando o banco de dados "DB_CONTAS":
USE DB_CONTAS;

-- Criação das tabelas:
CREATE TABLE TB_CONTAS(
	ID BIGINT AUTO_INCREMENT NOT NULL, 
    NUMERO_AGENCIA BIGINT NOT NULL, 
    NUMERO_CONTA BIGINT NOT NULL,
    
    CONSTRAINT PK_ID PRIMARY KEY(ID)
);

-- Criando uma nova tabela denominada "TB_UNIDADES_BANCARIAS":
CREATE TABLE TB_UNIDADES_BANCARIAS(
	ID BIGINT AUTO_INCREMENT NOT NULL, 
    INSTITUICAO VARCHAR(100) NOT NULL, 
    UF VARCHAR(10) NOT NULL,
    
    CONSTRAINT PK_ID PRIMARY KEY(ID)
);

-- Adicionando uma nova coluna na tabela "TB_CONTA" denominada de "ID_INSTITUICAO", sendo ela uma chave estrangeira:
ALTER TABLE TB_CONTAS ADD COLUMN ID_INSTITUICAO BIGINT NOT NULL;
ALTER TABLE TB_CONTAS ADD CONSTRAINT FK_CONTA_ID_INSTITUICAO FOREIGN KEY(ID_INSTITUICAO) REFERENCES TB_UNIDADES_BANCARIAS(ID) ON DELETE CASCADE;


-- Criando uma nova tabela denominada "TB_TIPOS_CONTAS":
CREATE TABLE TB_TIPOS_CONTAS(
	ID BIGINT AUTO_INCREMENT NOT NULL, 
    DESCRICAO VARCHAR(100) NOT NULL,
    
    CONSTRAINT PK_ID PRIMARY KEY(ID)
);


-- Adicionando uma nova coluna na tabela "TB_CONTA" denominada de "ID_TIPO_CONTA", sendo ela uma chave estrangeira:
ALTER TABLE TB_CONTAS ADD COLUMN ID_TIPO_CONTA BIGINT NOT NULL;
ALTER TABLE TB_CONTAS ADD CONSTRAINT FK_CONTA_ID_TIPO FOREIGN KEY(ID_TIPO_CONTA) REFERENCES TB_TIPOS_CONTAS(ID) ON DELETE CASCADE;


-- Criando uma nova tabela denominada "TB_MOVIMENTACOES":
CREATE TABLE TB_MOVIMENTACOES(
	ID BIGINT AUTO_INCREMENT NOT NULL, 
    TIPO VARCHAR(10) NOT NULL,
    VALOR BIGINT NOT NULL,
    DATA_OPERACAO DATE,
    ID_CONTA BIGINT NOT NULL,
    
    CONSTRAINT PK_ID PRIMARY KEY(ID)
);


-- Criando uma relação de restrição de chave estrangeira denominada de "ID_CONTA" na tabela TB_MOVIMENTACOES" relacionada a "TB_CONTA":
ALTER TABLE TB_MOVIMENTACOES ADD CONSTRAINT FK_MOVIMENTACOES_ID_CONTA FOREIGN KEY(ID_CONTA) REFERENCES TB_CONTAS(ID) ON DELETE CASCADE;


-- Inserindo valores nas respectivas tabelas:

-- 1) Tabela "TB_UNIDADES_BANCARIAS":
INSERT INTO
	TB_UNIDADES_BANCARIAS(
		ID, INSTITUICAO, UF)
			VALUES
				(1,'A','SP'),
				(2,'B','RJ'),
				(3,'C','AM'),
				(4,'D','PR'),
				(5,'E','MG')
    ;


-- 2) Tabela "TB_TIPOS_CONTAS":
INSERT INTO
	TB_TIPOS_CONTAS(
		ID, DESCRICAO)
			VALUES
				(1,'conta_corrente'),
                (2,'conta_poupanca'),
                (3,'investimentos'),
                (4,'conta_salario'),
                (5,'conta_digital')
    ;


-- 3) Tabela "TB_CONTAS":
INSERT INTO
	TB_CONTAS(
		ID, NUMERO_AGENCIA, NUMERO_CONTA, ID_INSTITUICAO, ID_TIPO_CONTA)
			VALUES
				(1, 45897, 147520, 1, 1),
                (2, 17835, 149630, 2, 3),
                (3, 14630, 589753, 3, 2),
                (4, 17530, 330257, 4, 4),
                (5, 66884, 147630, 5, 1)
    ;


-- 4) Tabela "TB_MOVIMENTACOES":
INSERT INTO
	TB_MOVIMENTACOES(
		ID, TIPO, VALOR, DATA_OPERACAO, ID_CONTA)
			VALUES
				(1, 'Entrada', 350, '2023-06-12', 1),
                (2, 'Entrada', 850, '2023-05-07', 4),
                (3, 'Saida', 50, '2023-02-14', 5),
                (4, 'Entrada', 600, '2023-06-12', 1),
                (5, 'Saida', 75, '2023-01-20', 2)
;


-- Fazendo a seleção de valores de movimentações que são superiores a R$100,00 e do tipo "Entrada":
 SELECT * FROM TB_MOVIMENTACOES WHERE VALOR > 100 AND TIPO = 'Entrada';
 
 