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

--Adi��o de times
GO
INSERT INTO Times VALUES
(1, 'Corinthians'),
(2, 'Palmeiras'),
(3, 'Santos'),
(4, 'S�o Paulo')

--Adi��o do administrador
GO
INSERT INTO Administrador VALUES
(1, 'admin', 'Jej-W+q%')

--Adi��o dos hist�ricos
GO
INSERT INTO Historico (codigo) VALUES
(1),
(2),
(3)

INSERT INTO Curiosidade VALUES
('O Corinthians foi batizado em homenagem ao Corinthian FC, time ingl�s que havia excursionado pelo Brasil. No come�o, algumas pessoas n�o tinham gostado desse nome.', 1, 1),
('O Corinthians foi fundado por um grupo de trabalhadores humildes. O primeiro presidente, por exemplo, era alfaiate. Os pr�prios jogadores ajudaram a construir o campo onde a equipe faria seus amistosos.', 1, 1),
('O mascote do clube, o Mosqueteiro, surgiu de uma cr�nica do jornal A Gazeta Esportiva ap�s um amistoso contra o Barracas, da Argentina. O texto comparava a garra dos jogadores corintianos com Os Tr�s Mosqueteiros.', 1, 1),
('O primeiro �dolo do Corinthians foi Neco. Ele jogou nas d�cadas de 1910 e 1920 e ficou marcado pelo temperamento forte.', 1, 1),
('O verso �Campe�o dos Campe�es� no hino do Corinthians faz uma refer�ncia a uma conquista de 1930, quando foi realizado um jogo entre Corinthians e Vasco.', 1, 1),
('O Corinthians foi o primeiro campe�o da Copa do Mundo de Clubes da Fifa, em 2000.', 1, 1)


-- Quando um aluno selecionar o time, deve-se fazer
--uma escolha aleat�ria para a tabela do time. Como o n�mero de mensagens iniciais
--� pequeno, deve-se ter uma forma de registrar as 3 �ltimas ocorr�ncias, para que
--n�o se repitam e, a cada nova escolha, substitua-se a mais antiga.

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
    -- do time est�o no hist�rico recente), sorteia qualquer uma para n�o falhar.
    IF @id_curiosidade_sorteada IS NULL
    BEGIN
        SELECT TOP 1 @id_curiosidade_sorteada = codigo
        FROM Curiosidade
        WHERE codigo_time = @codigo_time
        ORDER BY NEWID();
    END

    -- Se, ap�s as tentativas, um ID v�lido foi encontrado...
    IF @id_curiosidade_sorteada IS NOT NULL
    BEGIN
        BEGIN TRY
            -- Inicia a transa��o para garantir que INSERT e DELETE ocorram juntos
            BEGIN TRANSACTION;

            -- 3. INSERE o novo registro no hist�rico
            INSERT INTO Historico (codigo_curiosidade) VALUES (@id_curiosidade_sorteada);

            -- 4. DELETA os registros antigos, mantendo apenas os 3 mais recentes
            WITH HistoricoOrdenado AS (
                SELECT codigo,
                       ROW_NUMBER() OVER (ORDER BY data_adicao DESC) as rn
                FROM Historico
            )
            DELETE FROM HistoricoOrdenado WHERE rn > 3;

            -- Se tudo correu bem, confirma as altera��es
            COMMIT TRANSACTION;

            -- 5. PREPARA O TEXTO de sa�da para a aplica��o
            SELECT @conteudo_saida = conteudo FROM Curiosidade WHERE codigo = @id_curiosidade_sorteada;

        END TRY
        BEGIN CATCH
            -- Se ocorreu qualquer erro, desfaz a transa��o
            ROLLBACK TRANSACTION;

            -- Opcional: Relan�ar o erro para a aplica��o
            -- THROW;
        END CATCH
    END
    ELSE
    BEGIN
        -- Se mesmo assim n�o encontrou (ex: time sem curiosidades)
        SET @conteudo_saida = 'Nenhuma curiosidade encontrada para este time no momento.';
    END
END

--Cadastro de candidatos, uma vez cadastrado o aluno n�o pode 
--ser modificado ou exclu�do da base.
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
		RAISERROR('N�o � permitido excluir ou modificar candidatos cadastrados no sistema.', 16, 1)
		ROLLBACK TRANSACTION
	END

--Cadastro das curiosidades, n�o podem ser modificadas ou exclu�das da base.

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
		RAISERROR('N�o � permitido excluir ou modificar curiosidades cadastradas no sistema.', 16, 1)
		ROLLBACK TRANSACTION
	END