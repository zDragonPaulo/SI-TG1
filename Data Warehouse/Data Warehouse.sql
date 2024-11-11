-- Criação do banco de dados
CREATE DATABASE CrisePetroleo;
USE CrisePetroleo;

-- Tabela Dim_veiculo para informações dos carros
CREATE TABLE Dim_veiculo (
    ID_veiculo INT IDENTITY(1,1) PRIMARY KEY,
    Marca NVARCHAR(50),
    Modelo NVARCHAR(50),
    Pais_origem NVARCHAR(50)
);

-- Tabela Dim_combustivel para informações dos preços de gasolina
CREATE TABLE Dim_combustivel (
    ID_combustivel INT IDENTITY(1,1) PRIMARY KEY,
    Ano INT,
    Preco_combustivel DECIMAL(5, 2)
);

-- Tabela Dim_Tempo para informações simplificadas de tempo
CREATE TABLE Dim_Tempo (
    ID_tempo INT IDENTITY(1,1) PRIMARY KEY,
    Ano INT,
    Semestre INT,
    Trimestre INT
);

-- Tabela Fato_veiculo para associar métricas dos veículos com ano de fabricação e tempo
CREATE TABLE Fato_veiculo (
    ID_fato INT IDENTITY(1,1) PRIMARY KEY,
    Milhas_por_Galao DECIMAL(5, 2),
    Cavalagem DECIMAL(5, 2),
    Aceleracao_media DECIMAL(5, 2),
    Numero_veiculos INT,
    Ano_fabricacao INT,
    ID_combustivel INT,
    ID_veiculo INT,
    ID_tempo INT,
    FOREIGN KEY (ID_combustivel) REFERENCES Dim_combustivel(ID_combustivel),
    FOREIGN KEY (ID_veiculo) REFERENCES Dim_veiculo(ID_veiculo),
    FOREIGN KEY (ID_tempo) REFERENCES Dim_Tempo(ID_tempo)
);

-- Inserção de dados na tabela Dim_veiculo
INSERT INTO Dim_veiculo (Marca, Modelo, Pais_origem)
VALUES 
('Toyota', 'Corolla', 'Japão'),
('Ford', 'Mustang', 'EUA'),
('Volkswagen', 'Golf', 'Alemanha');

-- Inserção de dados na tabela Dim_combustivel
INSERT INTO Dim_combustivel (Ano, Preco_combustivel)
VALUES
(1970, 0.36),
(1971, 0.38),
(1972, 0.39);

-- Inserção de dados na Dim_Tempo para os anos de 1970 a 1972 com semestres e trimestres
INSERT INTO Dim_Tempo (Ano, Semestre, Trimestre)
VALUES 
(1970, 1, 1), (1970, 1, 2), (1970, 2, 3), (1970, 2, 4),
(1971, 1, 1), (1971, 1, 2), (1971, 2, 3), (1971, 2, 4),
(1972, 1, 1), (1972, 1, 2), (1972, 2, 3), (1972, 2, 4);

-- Inserção de dados na tabela Fato_veiculo
-- Supondo que o ID_tempo referente ao Ano_fabricacao corresponde ao primeiro trimestre daquele ano
INSERT INTO Fato_veiculo (Milhas_por_Galao, Cavalagem, Aceleracao_media, Numero_veiculos, Ano_fabricacao, ID_combustivel, ID_veiculo, ID_tempo)
VALUES
(18.5, 130, 15.5, 5000, 1970, 1, 1, (SELECT ID_tempo FROM Dim_Tempo WHERE Ano = 1970 AND Trimestre = 1)),
(20.0, 140, 16.0, 4500, 1971, 2, 2, (SELECT ID_tempo FROM Dim_Tempo WHERE Ano = 1971 AND Trimestre = 1)),
(22.0, 100, 14.0, 4700, 1972, 3, 3, (SELECT ID_tempo FROM Dim_Tempo WHERE Ano = 1972 AND Trimestre = 1));
