DEFINE CLASS EstoqueProduto AS Session
	
	cSql = ""
	
	PROCEDURE Init()
 		This.cSql = "" 	
	ENDPROC
	
	PROCEDURE IncluirProduto(oProduto)
 		TEXT TO This.cSql TEXTMERGE NOSHOW
			INSERT INTO [dbo].[Produtos]
			           ([codigo]
			           ,[nome]
			           ,[grupo]
			           ,[subGrupo]
			           ,[custo]
			           ,[margem]
			           ,[venda]
			           ,[vendaDolar])
			     VALUES
			           (<<"'" + oProduto.Codigo + "'">>
			           ,<<"'" + oProduto.Nome + "'">>
			           ,<<oProduto.Grupo>>
			           ,<<oProduto.SubGrupo>>
			           ,<<oProduto.Custo>>
			           ,<<oProduto.Margem>>
			           ,<<oProduto.Venda>>
			           ,<<oProduto.VendaDolar>>)
 		ENDTEXT
 		SQLEXEC(oCon.ConnectHandle, lcSql)
	ENDPROC
	
	PROCEDURE EditarProduto(oProduto)
 		TEXT TO This.cSql TEXTMERGE NOSHOW
			UPDATE [dbo].[Produtos]
			   SET [codigo] = <<"'" + oProduto.Codigo + "'">>
			      ,[nome] = <<"'" + oProduto.Nome + "'">>
			      ,[grupo] = <<oProduto.Grupo>>
			      ,[subGrupo] = <<oProduto.SubGrupo>>
			      ,[custo] = <<oProduto.Custo>>
			      ,[margem] = <<oProduto.Margem>>
			      ,[venda] = <<oProduto.venda>>
			      ,[vendaDolar] = <<oProduto.VendaDolar>>
			 WHERE id = <<oProduto.Id>>
 		ENDTEXT
 		SQLEXEC(oCon.ConnectHandle, lcSql)
	ENDPROC

	PROCEDURE ExcluirProduto(oProduto)
 		TEXT TO This.cSql TEXTMERGE NOSHOW
			DELETE FROM [dbo].[Produtos] WHERE id = <<oProduto.Id>>
 		ENDTEXT
 		SQLEXEC(oCon.ConnectHandle, lcSql)
	ENDPROC
	
ENDDEFINE