FUNCTION DataParaFormatoAmericano(tcData)
	LOCAL lcDataFormatada
	lcDataFormatada = DTOC(tcData, 1)
	lcDataFormatada = SUBSTR(lcDataFormatada, 5, 2) + "-" + SUBSTR(lcDataFormatada, 7, 2) + "-" + SUBSTR(lcDataFormatada, 1, 4)

	RETURN lcDataFormatada  
ENDFUNC

FUNCTION CriarObjetoRetorno(toObjeto)
	toObjeto = CREATEOBJECT("Empty")
	ADDPROPERTY(toObjeto, "Status", .F.)
	ADDPROPERTY(toObjeto, "Mensagem", .F.)	
	ADDPROPERTY(toObjeto, "Dados", .F.)	
	
	RETURN toObjeto
ENDFUNC

FUNCTION ConverterJsonParaObjeto(tcJson)
	JSONStart()
	
    RETURN JSON.Parse(tcJson)
ENDFUNC

FUNCTION RecuperarCotacaoDolarDia()
	LOCAL loHTTP, lcUrl, lcQueryParameters, loResponse
	LOCAL loEx AS Exception, loRetorno
	CriarObjetoRetorno(@loRetorno)
	
	TRY 
		lcUrl = "https://olinda.bcb.gov.br/olinda/servico/PTAX/versao/v1/odata/CotacaoDolarDia(dataCotacao=@dataCotacao)"
		lcQueryParameters = "%40dataCotacao='" + DataParaFormatoAmericano(DATE()) + "'&$format=json"
		lcUrl = lcUrl + "?" + lcQueryParameters
		
		loHTTP = CREATEOBJECT("Microsoft.XMLHTTP")
		loHTTP.Open("GET", lcUrl, .F.)
		loHTTP.SetRequestHeader("Content-Type", "application/json; charset=utf-8")
		loHTTP.SetRequestHeader("Accept", "application/json")
		loHTTP.Send()
		
		IF loHTTP.Status = 200	
		    loRetorno.Status = .T.
		    loRetorno.Mensagem = "Sucesso!"
		    loResponse = ConverterJsonParaObjeto(STRTRAN(loHTTP.ResponseText,"@odata.contex", "oDataContex")) && Ajusta para conseguir converter
			
			* Para recupear os valores da Colletion retornada pela classe que converte o Json.
			FOR EACH v IN loResponse.Value
				loRetorno.Dados = v
			ENDFOR
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