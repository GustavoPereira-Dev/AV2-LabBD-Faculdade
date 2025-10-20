CREATE DATABASE Trabalho02
GO
USE Trabalho02
GO

SELECT * FROM Times
CREATE TABLE Administrador (
codigo		INT				NOT NULL,
entrada		VARCHAR(20)		NOT NULL,		--login
senha		VARCHAR(10)		NOT NULL
PRIMARY KEY(codigo)
)
GO
CREATE TABLE Curso (
codigo		INT				NOT NULL,
nome		VARCHAR(100)	NOT NULL
PRIMARY KEY(codigo)
)
INSERT INTO Curso VALUES
(1, 'Analise e Desenvolvimento de Sistemas'),
(2, 'Comercio Exterior'),
(3, 'Desenvolvimento de Produtos Plasticos'),
(4,	'Desenvolvimento de Software Multiplataforma'),
(5, 'Gestao de Recursos Humanos'),
(6, 'Gestao Empresarial'),
(7, 'Logistica'),
(8, 'Polimeros'),
(9, 'AMS')

GO
CREATE TABLE Candidato (
codigo				INT				NOT NULL		IDENTITY(0,1),
nome				VARCHAR(100)	NOT NULL,
email				VARCHAR(50)		NOT NULL,
telefone			VARCHAR(11)		NOT NULL,
bairro				VARCHAR(100)	NOT NULL,
data_cadastro		DATETIME		NOT NULL,
recebe_mensagem		BIT				NOT NULL,
codigo_curso		INT				NOT NULL,
codigo_administrador			INT				NOT NULL
PRIMARY KEY(codigo)
FOREIGN KEY(codigo_curso) REFERENCES Curso(codigo),
FOREIGN KEY(codigo_administrador) REFERENCES Administrador(codigo)
)
GO
CREATE TABLE Times (
codigo		INT				NOT NULL,
nome		VARCHAR(15)		NOT NULL
PRIMARY KEY(codigo)
)
GO
CREATE TABLE Curiosidade (
codigo			INT				NOT NULL	IDENTITY(0,1),
conteudo		VARCHAR(MAX)	NOT NULL,
codigo_time		INT				NOT NULL,
codigo_administrador		INT				NOT NULL
PRIMARY KEY(codigo)
FOREIGN KEY(codigo_time) REFERENCES Times(codigo),
FOREIGN KEY(codigo_administrador) REFERENCES Administrador(codigo)
)
GO
CREATE TABLE Historico (
codigo					INT			NOT NULL    IDENTITY,
codigo_curiosidade		INT			NULL
PRIMARY KEY(codigo)
FOREIGN KEY(codigo_curiosidade) REFERENCES Curiosidade(codigo)
)
--Adição de times
GO
INSERT INTO Times VALUES
(1, 'Corinthians'),
(2, 'Palmeiras'),
(3, 'Santos'),
(4, 'São Paulo')

--Adição do administrador
GO
INSERT INTO Administrador VALUES
(1, 'admin', 'Jej-W+q%')

--Adição dos históricos
GO
INSERT INTO Historico (codigo) VALUES
(1),
(2),
(3)

--Validação para saber se existem curiosidades cadastradas no sistema
--(Se for 0, já foram cadastradas)
--(Se for 1, não foram cadastradas)

GO
CREATE ALTER FUNCTION fn_verifica_curiosidades ()
RETURNS BIT
AS
	BEGIN
        DECLARE @bit BIT
		DECLARE @cod INT

		SELECT @cod = COUNT(codigo) 
		FROM Curiosidade

		IF @cod <= 0
		BEGIN
			SET @bit = 0
			RETURN @bit
		END

		SET @bit = 1
		RETURN @bit

	END

-- Você deve passar um valor (0 ou 1), mesmo que ele não seja usado
SELECT dbo.fn_verifica_curiosidades() AS bit;

SELECT * FROM Candidato;
SELECT * FROM Curiosidade
SELECT * FROM Times;
DELETE FROM Curiosidade;
-- Quando um aluno selecionar o time, deve-se fazer
--uma escolha aleatória para a tabela do time. Como o número de mensagens iniciais
--é pequeno, deve-se ter uma forma de registrar as 3 últimas ocorrências, para que
--não se repitam e, a cada nova escolha, substitua-se a mais antiga.
GO
CREATE PROCEDURE sp_login_candidato @usuario VARCHAR(100), @email VARCHAR(50), @mensagem VARCHAR(100) OUTPUT
AS	
	IF((SELECT email FROM Candidato WHERE nome LIKE @usuario) = @email)
		SET @mensagem = 'Candidato logado com sucesso'
	ELSE
		RAISERROR('Candidato ou senha incorreta', 16, 1)
GO
CREATE PROCEDURE sp_login_admin @entrada VARCHAR(20), @senha VARCHAR(10), @mensagem VARCHAR(100) OUTPUT
AS	
	IF((SELECT senha FROM Administrador WHERE entrada LIKE @entrada) = @senha)
		SET @mensagem = 'Admin logado com sucesso'
	ELSE
		RAISERROR('Admin ou senha incorreta', 16, 1)
GO

DECLARE @saida varchar(100)
EXEC sp_login_admin 'admin', 'Jej-W+q%', @saida OUTPUT
PRINT(@saida)

CREATE FUNCTION fn_sortear_curiosidade_id (@codigo_time INT)
RETURNS TABLE
AS
RETURN
(
    -- Esta função retorna a LISTA de todos os códigos de curiosidade
    -- para o time especificado, que NÃO ESTEJAM entre os 3 mais recentes do histórico.
    -- A aleatoriedade NÃO é aplicada aqui.
    SELECT 
        c.codigo
    FROM 
        Curiosidade c
    WHERE 
        c.codigo_time = @codigo_time
        AND c.codigo NOT IN (
            SELECT TOP 3 h.codigo_curiosidade
            FROM Historico h
            ORDER BY h.codigo DESC
        )
);

-- DECLARE @mensagem VARCHAR(MAX)
-- EXEC sp_gerenciar_sorteio_curiosidade 4, @mensagem OUTPUT
-- PRINT (@mensagem)

-- SELECT * FROM Historico;
-- DELETE FROM Historico;


CREATE PROCEDURE sp_gerenciar_sorteio_curiosidade
(
    @codigo_time INT,
    @conteudo_saida VARCHAR(MAX) OUTPUT
)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @id_curiosidade_sorteada INT;

    -- 1. CHAMA A NOVA FUNÇÃO (iTVF) e aplica a aleatoriedade AQUI, na procedure.
    -- A sintaxe é como se estivéssemos consultando uma tabela.
    SELECT TOP 1 @id_curiosidade_sorteada = codigo
    FROM dbo.fn_sortear_curiosidade_id(@codigo_time)
    ORDER BY NEWID(); -- << A ALEATORIEDADE FOI MOVIDA PARA CÁ!

    PRINT(@id_curiosidade_sorteada)

    IF @id_curiosidade_sorteada IS NOT NULL
    BEGIN
        BEGIN TRY
            BEGIN TRANSACTION;

            INSERT INTO Historico (codigo_curiosidade) VALUES (@id_curiosidade_sorteada);
                      
            -- Lógica para deletar os registros antigos
            DELETE FROM Historico
            WHERE codigo NOT IN (
                SELECT TOP 3 codigo
                FROM Historico
                ORDER BY codigo DESC
            );

            COMMIT TRANSACTION;

            SELECT @conteudo_saida = conteudo FROM Curiosidade WHERE codigo = @id_curiosidade_sorteada;

        END TRY
        BEGIN CATCH
            PRINT('Catch')
            IF XACT_STATE() <> 0
            BEGIN
                ROLLBACK TRANSACTION;
            END
        END CATCH
    END
    ELSE
    BEGIN
        SET @conteudo_saida = 'Nenhuma curiosidade encontrada para este time no momento.';
    END
END

--Cadastro de candidatos, uma vez cadastrado o aluno não pode 
--ser modificado ou excluído da base.
GO
CREATE ALTER PROCEDURE sp_inserir_candidato (@nome VARCHAR(100), @email VARCHAR(50), @telefone VARCHAR(11),
                                       @bairro VARCHAR(100), @curso INT, 
									   @recebe_mensagem BIT, @saida VARCHAR(100) OUTPUT) AS

	INSERT INTO Candidato (
        nome,
        email,
        telefone,
        bairro,
        codigo_curso,
        data_cadastro,      -- 5ª coluna da tabela
        recebe_mensagem,    -- 6ª coluna da tabela
        codigo_administrador          -- 8ª coluna da tabela
    ) VALUES
	(@nome, @email, @telefone, @bairro, @curso, CAST(GETDATE() AS VARCHAR(20)), @recebe_mensagem, 1)
    -- TODO: Formatar a data no insert

	SET @saida = 'Candidato adicionado com sucesso.'

GO
-- DISABLE TRIGGER t_deletar_atualizar_candidato ON Candidato

CREATE TRIGGER t_deletar_atualizar_candidato ON Candidato
FOR DELETE, UPDATE
AS
	BEGIN
		RAISERROR('Não é permitido excluir ou modificar candidatos cadastrados no sistema.', 16, 1)
		ROLLBACK TRANSACTION
	END

DECLARE @mensagem VARCHAR(MAX)
EXEC sp_inserir_candidato 'Gustavo Pereira', 'teste@gmail.com', '1197423432', 'Vila Suiça', 1, false, @mensagem OUTPUT
PRINT (@mensagem)

SELECT * FROM Candidato;
DELETE FROM Candidato;
--Cadastro das curiosidades, não podem ser modificadas ou excluídas da base.

GO

CREATE PROCEDURE sp_inserir_curiosidade (@conteudo VARCHAR(MAX), @codigo_time INT,
                                         @saida VARCHAR(100) OUTPUT) AS

	INSERT INTO Curiosidade VALUES
	(@conteudo, @codigo_time, 1)

	SET @saida = 'Curiosidade adiciona com sucesso.'

GO


CREATE TRIGGER t_deletar_atualizar_curiosidade ON Curiosidade
FOR DELETE, UPDATE
AS
	BEGIN
		RAISERROR('Não é permitido excluir ou modificar curiosidades cadastradas no sistema.', 16, 1)
		ROLLBACK TRANSACTION
	END

-- DISABLE TRIGGER t_deletar_atualizar_curiosidade ON Curiosidade