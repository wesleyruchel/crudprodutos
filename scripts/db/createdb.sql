USE master;
GO

CREATE DATABASE Estoque;
GO

USE Estoque;
GO

CREATE LOGIN hml WITH PASSWORD = 'hml123';
GO

CREATE USER hml FOR LOGIN hml;
GO

-- Propriet�rio do banco de dados
EXEC sp_addrolemember 'db_owner', 'hml';
GO
