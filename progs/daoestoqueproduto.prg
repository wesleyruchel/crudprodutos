DEFINE CLASS EstoqueProduto AS Custom
	
	cSql = ""
	cXML = ""
	
	PROCEDURE Init()
 		This.cSql = "" 	
	ENDPROC
	
	PROCEDURE CriarCursorProdutos()
		TEXT TO This.cSql TEXTMERGE NOSHOW
			SELECT 
				P.id,
				P.codigo,
				P.nome,
				P.grupo,
				P.subGrupo,
				P.custo,
				P.margem,
				P.venda,
				G.nome AS grupoNome,
				S.nome AS subGrupoNome
			FROM Produtos P (NOLOCK)
			LEFT JOIN GruposProduto G (NOLOCK)
				ON P.grupo = G.id
			LEFT JOIN SubGruposProduto S (NOLOCK)
				ON P.subGrupo = S.id
		ENDTEXT
		SQLEXEC(oCon.ConnectHandle, This.cSql, "crsCursor")
		CURSORTOXML("crsCursor", "cXML", 2, 4, 0, '1')

		RETURN cXML
	ENDPROC 
	
	PROCEDURE Incluir(oProduto)
 		TEXT TO This.cSql TEXTMERGE NOSHOW
			INSERT INTO [dbo].[Produtos]
			           ([codigo]
			           ,[nome]
			           ,[grupo]
			           ,[subGrupo]
			           ,[custo]
			           ,[margem]
			           ,[venda])
			     VALUES
			           (<<"'" + ALLTRIM(oProduto.Codigo) + "'">>
			           ,<<"'" + ALLTRIM(oProduto.Nome) + "'">>
			           ,<<oProduto.Grupo>>
			           ,<<oProduto.SubGrupo>>
			           ,<<oProduto.Custo>>
			           ,<<oProduto.Margem>>
			           ,<<oProduto.Venda>>)
 		ENDTEXT
 		RETURN (SQLEXEC(oCon.ConnectHandle, This.cSql) > 0)
	ENDPROC
	
	PROCEDURE Atualizar(oProduto)
 		TEXT TO This.cSql TEXTMERGE NOSHOW
			UPDATE [dbo].[Produtos]
			   SET [codigo] = <<"'" + ALLTRIM(oProduto.Codigo) + "'">>
			      ,[nome] = <<"'" + ALLTRIM(oProduto.Nome) + "'">>
			      ,[grupo] = <<oProduto.Grupo>>
			      ,[subGrupo] = <<oProduto.SubGrupo>>
			      ,[custo] = <<oProduto.Custo>>
			      ,[margem] = <<oProduto.Margem>>
			      ,[venda] = <<oProduto.venda>>
			 WHERE id = <<oProduto.Id>>
 		ENDTEXT
 		RETURN (SQLEXEC(oCon.ConnectHandle, This.cSql) > 0)
	ENDPROC

	PROCEDURE Deletar(lnId)
 		TEXT TO This.cSql TEXTMERGE NOSHOW
			DELETE FROM [dbo].[Produtos] WHERE id = <<lnId>>
 		ENDTEXT
 		RETURN (SQLEXEC(oCon.ConnectHandle, This.cSql) > 0)
	ENDPROC
	
ENDDEFINE