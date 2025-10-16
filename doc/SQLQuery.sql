CREATE DATABASE Trabalho02
GO
USE Trabalho02
GO
CREATE TABLE Administrador (
codigo		INT				NOT NULL,
entrada		VARCHAR(20)		NOT NULL,		--login
senha		VARCHAR(10)		NOT NULL
PRIMARY KEY(codigo)
)
GO
CREATE TABLE Candidato (
codigo				INT				NOT NULL		IDENTITY(0,1),
nome				VARCHAR(100)	NOT NULL,
email				VARCHAR(50)		NOT NULL,
telefone			VARCHAR(11)		NOT NULL,
bairro				VARCHAR(100)	NOT NULL,
curso				VARCHAR(50)		NOT NULL,
data_cadastro		DATETIME		NOT NULL,
recebe_mensagem		BIT				NOT NULL,
codigo_adm			INT				NOT NULL
PRIMARY KEY(codigo)
FOREIGN KEY(codigo_adm) REFERENCES Administrador(codigo)
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
codigo_adm		INT				NOT NULL
PRIMARY KEY(codigo)
FOREIGN KEY(codigo_time) REFERENCES Times(codigo),
FOREIGN KEY(codigo_adm) REFERENCES Administrador(codigo)
)
GO
CREATE TABLE Historico (
codigo					INT			NOT NULL,
data_adicao				DATETIME	NULL,
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

INSERT INTO Curiosidade VALUES
('O Corinthians foi batizado em homenagem ao Corinthian FC, time inglês que havia excursionado pelo Brasil. No começo, algumas pessoas não tinham gostado desse nome.', 1, 1),
('O Corinthians foi fundado por um grupo de trabalhadores humildes. O primeiro presidente, por exemplo, era alfaiate. Os próprios jogadores ajudaram a construir o campo onde a equipe faria seus amistosos.', 1, 1),
('O mascote do clube, o Mosqueteiro, surgiu de uma crônica do jornal A Gazeta Esportiva após um amistoso contra o Barracas, da Argentina. O texto comparava a garra dos jogadores corintianos com Os Três Mosqueteiros.', 1, 1),
('O primeiro ídolo do Corinthians foi Neco. Ele jogou nas décadas de 1910 e 1920 e ficou marcado pelo temperamento forte.', 1, 1),
('O verso “Campeão dos Campeões” no hino do Corinthians faz uma referência a uma conquista de 1930, quando foi realizado um jogo entre Corinthians e Vasco.', 1, 1),
('O Corinthians foi o primeiro campeão da Copa do Mundo de Clubes da Fifa, em 2000.', 1, 1)


-- Quando um aluno selecionar o time, deve-se fazer
--uma escolha aleatória para a tabela do time. Como o número de mensagens iniciais
--é pequeno, deve-se ter uma forma de registrar as 3 últimas ocorrências, para que
--não se repitam e, a cada nova escolha, substitua-se a mais antiga.

GO
CREATE FUNCTION fn_sortear_curiosidade_id (@codigo_time INT)
RETURNS INT
AS
BEGIN
    DECLARE @id_curiosidade_sorteada INT;

    SELECT TOP 1 @id_curiosidade_sorteada = c.codigo
    FROM Curiosidade c
    WHERE c.codigo_time = @codigo_time
      AND c.codigo NOT IN (
          SELECT TOP 3 h.codigo_curiosidade
          FROM Historico h
          ORDER BY h.codigo DESC -- Ordena pelo ID sequencial
      )
    ORDER BY NEWID();

    RETURN @id_curiosidade_sorteada;
END

CREATE PROCEDURE sp_gerenciar_sorteio_curiosidade
(
    @codigo_time INT,
    @conteudo_saida VARCHAR(MAX) OUTPUT
)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @id_curiosidade_sorteada INT;

    -- 1. CHAMA A UDF para obter o ID da curiosidade
    SET @id_curiosidade_sorteada = dbo.fn_sortear_curiosidade_id(@codigo_time);

    -- 2. TRATAMENTO DE EDGE CASE: Se a UDF retornou NULL (ex: todas as curiosidades
    -- do time estão no histórico recente), sorteia qualquer uma para não falhar.
    IF @id_curiosidade_sorteada IS NULL
    BEGIN
        SELECT TOP 1 @id_curiosidade_sorteada = codigo
        FROM Curiosidade
        WHERE codigo_time = @codigo_time
        ORDER BY NEWID();
    END

    -- Se, após as tentativas, um ID válido foi encontrado...
    IF @id_curiosidade_sorteada IS NOT NULL
    BEGIN
        BEGIN TRY
            -- Inicia a transação para garantir que INSERT e DELETE ocorram juntos
            BEGIN TRANSACTION;

            -- 3. INSERE o novo registro no histórico
            INSERT INTO Historico (codigo_curiosidade) VALUES (@id_curiosidade_sorteada);

            -- 4. DELETA os registros antigos, mantendo apenas os 3 mais recentes
            WITH HistoricoOrdenado AS (
                SELECT codigo,
                       ROW_NUMBER() OVER (ORDER BY data_adicao DESC) as rn
                FROM Historico
            )
            DELETE FROM HistoricoOrdenado WHERE rn > 3;

            -- Se tudo correu bem, confirma as alterações
            COMMIT TRANSACTION;

            -- 5. PREPARA O TEXTO de saída para a aplicação
            SELECT @conteudo_saida = conteudo FROM Curiosidade WHERE codigo = @id_curiosidade_sorteada;

        END TRY
        BEGIN CATCH
            -- Se ocorreu qualquer erro, desfaz a transação
            ROLLBACK TRANSACTION;

            -- Opcional: Relançar o erro para a aplicação
            -- THROW;
        END CATCH
    END
    ELSE
    BEGIN
        -- Se mesmo assim não encontrou (ex: time sem curiosidades)
        SET @conteudo_saida = 'Nenhuma curiosidade encontrada para este time no momento.';
    END
END

--Cadastro de candidatos, uma vez cadastrado o aluno não pode 
--ser modificado ou excluído da base.
GO
CREATE PROCEDURE sp_inserir_candidato (@nome VARCHAR(100), @email VARCHAR(50), @telefone VARCHAR(11),
                                       @bairro VARCHAR(100), @curso VARCHAR(50), 
									   @recebe_mensagem BIT, @saida VARCHAR(100) OUTPUT) AS

	INSERT INTO Candidato VALUES
	(@nome, @email, @telefone, @bairro, @curso, GETDATE(), @recebe_mensagem, 1)

	SET @saida = 'Candidato adicionado com sucesso.'

GO
CREATE TRIGGER t_deletar_atualizar_candidato ON Candidato
FOR DELETE, UPDATE
AS
	BEGIN
		RAISERROR('Não é permitido excluir ou modificar candidatos cadastrados no sistema.', 16, 1)
		ROLLBACK TRANSACTION
	END

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