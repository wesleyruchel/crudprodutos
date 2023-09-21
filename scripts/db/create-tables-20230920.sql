IF OBJECT_ID (N'GrupoProduto') IS NULL
BEGIN
	CREATE TABLE GrupoProduto (
		id				INT IDENTITY NOT NULL,
		nome			CHAR(60) COLLATE Latin1_General_BIN NOT NULL,
		CONSTRAINT PK_GrupoProduto_Id PRIMARY KEY (id)
	)
END;
			
IF OBJECT_ID (N'SubGrupoProduto') IS NULL
BEGIN
	CREATE TABLE SubGrupoProduto (
		id				INT IDENTITY NOT NULL,
		nome			CHAR(60) COLLATE Latin1_General_BIN NOT NULL,
		CONSTRAINT PK_SubGrupoProduto_Id PRIMARY KEY (id)
	)
END;

IF OBJECT_ID (N'Produto') IS NULL
BEGIN
	CREATE TABLE Produto (
		id				INT IDENTITY NOT NULL,
		codigo			CHAR(16) COLLATE Latin1_General_BIN NOT NULL,
		nome			CHAR(60) COLLATE Latin1_General_BIN NOT NULL,
		grupo			INT NULL,
		subGrupo		INT NULL,
		custo 			NUMERIC(18,2) NOT NULL,
		margem 			NUMERIC(18,2) NOT NULL,
		venda 			NUMERIC(18,2) NOT NULL,			
		CONSTRAINT PK_Produto_Id PRIMARY KEY (id),
		CONSTRAINT FK_IdGrupoProduto FOREIGN KEY (grupo) REFERENCES GrupoProduto(id),
		CONSTRAINT FK_IdSubGrupoProduto FOREIGN KEY (subGrupo) REFERENCES SubGrupoProduto(id)
	)
END;