FUNCTION Criar()
	LOCAL lcSql
	TEXT TO lcSql TEXTMERGE NOSHOW
		IF OBJECT_ID (N'GruposProduto') IS NULL
		BEGIN
			CREATE TABLE GruposProduto (
				id				INT IDENTITY NOT NULL,
				nome			CHAR(60) COLLATE Latin1_General_BIN NOT NULL,
				CONSTRAINT PK_GrupoProduto_Id PRIMARY KEY (id)
			)
		END;
			
		IF OBJECT_ID (N'SubGruposProduto') IS NULL
		BEGIN
			CREATE TABLE SubGruposProduto(
				id				INT IDENTITY NOT NULL,
				nome			CHAR(60) COLLATE Latin1_General_BIN NOT NULL,
				CONSTRAINT PK_SubGrupoProduto_Id PRIMARY KEY (id)
			)
		END;

		IF OBJECT_ID (N'Produtos') IS NULL
		BEGIN
			CREATE TABLE Produtos (
				id				INT IDENTITY NOT NULL,
				codigo			CHAR(16) COLLATE Latin1_General_BIN NOT NULL,
				nome			CHAR(60) COLLATE Latin1_General_BIN NOT NULL,
				grupo			INT NULL,
				subGrupo		INT NULL,
				custo 			NUMERIC(18,2) NOT NULL,
				margem 			NUMERIC(18,2) NOT NULL,
				venda 			NUMERIC(18,2) NOT NULL,			
				CONSTRAINT PK_Produto_Id PRIMARY KEY (id),
				CONSTRAINT FK_IdGrupoProduto FOREIGN KEY (grupo) REFERENCES GruposProduto(id),
				CONSTRAINT FK_IdSubGrupoProduto FOREIGN KEY (subGrupo) REFERENCES SubGruposProduto(id)
			)
		END;
	ENDTEXT
	SQLEXEC(oCon.ConnectHandle, lcSql)
ENDFUNC

FUNCTION PreDefinir()
	LOCAL lcSql
	TEXT TO lcSql TEXTMERGE NOSHOW
		INSERT INTO [dbo].[GruposProduto]
		           ([nome])
		     VALUES
		           ('Calçados')
		GO

		INSERT INTO [dbo].[SubGruposProduto]
		           ([nome])
		     VALUES
		           ('Masculinos')
		GO


		INSERT INTO [dbo].[SubGruposProduto]
		           ([nome])
		     VALUES
		           ('Femininos')
		GO

		INSERT INTO [dbo].[SubGruposProduto]
		           ([nome])
		     VALUES
		           ('Infantis')
		GO
	ENDTEXT
	SQLEXEC(oCon.ConnectHandle, lcSql)
ENDFUNC