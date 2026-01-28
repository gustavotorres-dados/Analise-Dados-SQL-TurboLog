/*******************************************************************************
   PROJETO: TurboLog - Sistema de Gestão de Logística
   OBJETIVO: Análise de performance de motoristas e controle de fretes.
   CONCEITOS: DDL, DML, Joins, Case, Transactions e Procedures.
*******************************************************************************/

-- 1. CRIAÇÃO DO AMBIENTE
USE master;
GO

IF EXISTS (SELECT name FROM sys.databases WHERE name = 'TurboLog')
BEGIN
    DROP DATABASE TurboLog;
END
GO

CREATE DATABASE TurboLog;
GO

USE TurboLog;
GO

-- 2. CRIAÇÃO DAS TABELAS (SCHEMA)
CREATE TABLE Motoristas (
    id_motorista INT PRIMARY KEY IDENTITY(1,1),
    nome VARCHAR(100) NOT NULL,
    veiculo VARCHAR(50)
);

CREATE TABLE Regioes (
    id_regiao INT PRIMARY KEY IDENTITY(1,1),
    nome_regiao VARCHAR(50) NOT NULL
);

CREATE TABLE Entregas (
    id_entrega INT PRIMARY KEY IDENTITY(1,1),
    valor_frete DECIMAL(10,2),
    data_entrega DATE,
    id_motorista INT,
    id_regiao INT,
    CONSTRAINT FK_Motorista FOREIGN KEY (id_motorista) REFERENCES Motoristas(id_motorista),
    CONSTRAINT FK_Regiao FOREIGN KEY (id_regiao) REFERENCES Regioes(id_regiao)
);
GO

-- 3. POPULANDO O BANCO (DADOS INICIAIS)
INSERT INTO Motoristas (nome, veiculo) VALUES 
('Carlos Ramos', 'Caminhão'), 
('Beatriz Silva', 'Fiorino'), 
('Marcos Souza', 'Moto');

INSERT INTO Regioes (nome_regiao) VALUES 
('Centro'), 
('Zona Sul'), 
('Interior');

INSERT INTO Entregas (valor_frete, data_entrega, id_motorista, id_regiao) VALUES 
(150.00, '2026-01-20', 1, 1), 
(80.00, '2026-01-21', 2, 2), 
(200.00, '2026-01-22', 1, 3), 
(45.00, '2026-01-23', 3, 1);
GO

-- 4. CONSULTAS ANALÍTICAS (QUERIES DE NEGÓCIO)

-- Relatório Consolidado: Motorista, Região e Valor
SELECT 
    M.nome AS Motorista, 
    R.nome_regiao AS Regiao, 
    E.valor_frete
FROM Entregas E
JOIN Motoristas M ON E.id_motorista = M.id_motorista
JOIN Regioes R ON E.id_regiao = R.id_regiao;

-- Classificação de Frete (Lógica de Bonificação)
SELECT 
    id_entrega,
    valor_frete,
    CASE 
        WHEN valor_frete > 100 THEN 'Frete Pesado (Bônus)'
        ELSE 'Frete Comum'
    END AS status_frete
FROM Entregas;

-- Faturamento Total por Motorista
SELECT 
    M.nome, 
    SUM(E.valor_frete) AS faturamento_total,
    COUNT(E.id_entrega) AS total_entregas
FROM Motoristas M
LEFT JOIN Entregas E ON M.id_motorista = E.id_motorista
GROUP BY M.nome;
GO

-- 5. AUTOMAÇÃO (STORED PROCEDURE)
-- Procedure para consultar entregas por região
CREATE OR ALTER PROCEDURE usp_ConsultaPorRegiao
    @nome_regiao VARCHAR(50)
AS
BEGIN
    SELECT E.id_entrega, M.nome AS Motorista, E.valor_frete
    FROM Entregas E
    JOIN Motoristas M ON E.id_motorista = M.id_motorista
    JOIN Regioes R ON E.id_regiao = R.id_regiao
    WHERE R.nome_regiao = @nome_regiao;
END;
GO

-- Exemplo de uso: EXEC usp_ConsultaPorRegiao 'Centro';