CLEAR
SET DATE TO BRITISH
SET SAFETY OFF
SET EXCLUSIVE OFF
SET PATH TO (SYS(2004))	

WAIT WINDOW "Aguarde, iniciando aplicação..." NOWAIT

SET PROCEDURE TO 	BIBLIOTECADEFUNCOES,;
					BANCODEDADOS,;
					QDFOXJSON,;
					DAOESTOQUEPRODUTO

SET ASSERTS ON
ASSERT .F.

PUBLIC oCon
oCon = CREATEOBJECT("Empty")
ADDPROPERTY(oCon, "ConnectHandle")

InicializarConexaoDb()

DO Criar IN BancoDeDados
DO PreDefinir IN BancoDeDados

DO FORM produto.scx
READ EVENTS

*!*	================ *!*
*!*	================ *!*

FUNCTION InicializarConexaoDb()
	LOCAL lnHandle, lcConnectionString
	
	*!*	TO-DO: Remover hardcode	

	lcConnectionString = "Driver={SQL Server};" + ;
	    "Server=localhost\SQLEXPRESS_1;" + ;
	    "Database=Estoque;Uid=sa;Pwd=hml123;"

	lnHandle = SQLSTRINGCONNECT(lcConnectionString)

	IF lnHandle < 0 	
		MESSAGEBOX("Erro ao conectar ao banco de dados.")
		QUIT
	ENDIF
	
	oCon.ConnectHandle = lnHandle 
ENDFUNC