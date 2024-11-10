CREATE DATABASE CrisePetroleo
USE CrisePetroleo;

-- Tabela Dim_veiculo para informações dos carros
CREATE TABLE Dim_veiculo (
    ID_veiculo INT IDENTITY(1,1) PRIMARY KEY,
    Marca NVARCHAR(50),
    Modelo NVARCHAR(50),
    Pais_origem NVARCHAR(50),
);

-- Tabela Dim_combustivel para informações dos preços de gasolina
CREATE TABLE Dim_combustivel (
    ID_combustivel INT IDENTITY(1,1) PRIMARY KEY,
    Ano INT,
    Preco_combustivel DECIMAL(5, 2)
);

-- Tabela Fato_veiculo para associar métricas dos veículos com ano de fabricação
CREATE TABLE Fato_veiculo (
    ID_fato INT IDENTITY(1,1) PRIMARY KEY,
    Milhas_por_Galao DECIMAL(5, 2),
    Cavalagem DECIMAL(5, 2),
    Aceleracao_media DECIMAL(5, 2),
    Numero_veiculos INT,
    Ano_fabricacao INT,
    ID_combustivel INT,
    ID_veiculo INT,
    FOREIGN KEY (ID_combustivel) REFERENCES Dim_combustivel(ID_combustivel),
    FOREIGN KEY (ID_veiculo) REFERENCES Dim_veiculo(ID_veiculo)
);

------------------------------------------------------------------------------------------------

-- Inserção na Tabela Dim_veiculo
INSERT INTO Dim_veiculo (Marca, Modelo, Pais_origem)
VALUES 
('Toyota', 'Corolla', 'Japão'),
('Ford', 'Mustang', 'EUA'),
('Volkswagen', 'Golf', 'Alemanha');

-- Inserção na Tabela Dim_combustivel
INSERT INTO Dim_combustivel (Ano, Preco_combustivel)
VALUES
(1970, 0.36),
(1971, 0.38),
(1972, 0.39);

-- Inserção na Tabela Fato_veiculo
INSERT INTO Fato_veiculo (Milhas_por_Galao, Cavalagem, Aceleracao_media, Numero_veiculos, Ano_fabricacao, ID_combustivel, ID_veiculo)
VALUES
(18.5, 130, 15.5, 5000, 1970, 1, 1),
(20.0, 140, 16.0, 4500, 1971, 2, 2),
(22.0, 100, 14.0, 4700, 1972, 3, 3);
