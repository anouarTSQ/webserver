//%attributes = {}
C_TEXT:C284($path; $1)
C_TEXT:C284($httpMethod)

$path:=$1

$httpMethod:=getHttpMethod()

Case of 
	: ($path="/User@")
		$path:=Replace string:C233($path; "/User"; "")
		
		webUserHandler($path; $httpMethod)
		
	: ($path="/Post@")
		
	: ($path="/Comment@")
		
	Else 
		response.message:="bad request"
		
		WEB SEND TEXT:C677(JSON Stringify:C1217($response))
End case 

