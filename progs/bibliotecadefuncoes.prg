FUNCTION DataParaFormatoAmericado(tcData)
	LOCAL lcDataFormatada
	lcDataFormatada = DTOC(tcData, 1)
	lcDataFormatada = SUBSTR(lcDataFormatada, 6, 2) + "-" + SUBSTR(lcDataFormatada, 9, 2) + "-" + SUBSTR(lcDataFormatada, 1, 4)

	RETURN lcDataFormatada  
ENDFUNC

FUNCTION CriarObjetoRetorno()
	LOCAL loObj
	loObj = CREATEOBJECT("Empty")
	ADDPROPERTY(loObj, "Status", .F.)
	ADDPROPERTY(loObj, "Mensagem", .F.)	
	
	RETURN loObj
ENDFUNC

FUNCTION RecuperarCotacaoDolarDia()
	LOCAL loHTTP, lcUrl, lcQueryParameters
	LOCAL loEx AS Exception loRetorno
	loRetorno = CriarObjetoRetorno()
	
	TRY 
		lcUrl = "https://olinda.bcb.gov.br/olinda/servico/PTAX/versao/v1/odata/CotacaoDolarDia(dataCotacao=@dataCotacao)"
		lcQueryParameters = "%40dataCotacao='" + DataParaFormatoAmericado() + "'&$format=json"
		lcUrl = lcUrl + "?" + lcQueryParameters
		
		loHTTP = CREATEOBJECT("Microsoft.XMLHTTP")
		loHTTP.Open("GET", lcUrl, .F.)
		loHTTP.Send()

		DO WHILE loHTTP.ReadyState <> 4
		    DOEVENTS
		ENDDO
		
		IF loHTTP.Status = 200
		    loRetorno.Status = .T.
		    loRetorno.Mensagem = loHTTP.ResponseText
		ELSE
		    loRetorno.Status = .F.
		    loRetorno.Mensagem = "Algo deu errado! (" + loHTTP.ResponseText + " (" + TRANSFORM(loHTTP.Status) + ") )."
		ENDIF

		RELEASE loHTTP
	CATCH TO loEx
		loRetorno.Status = .F.
		loRetorno.Mensagem = "Uma exceção interrompeu a execução do método (" + loEx.Message + " | " + loEx.Procedure  + ")."
	FINALLY
		RELEASE loHTTP 
	ENDTRY	
	
	RETURN loRetorno
ENDFUNC