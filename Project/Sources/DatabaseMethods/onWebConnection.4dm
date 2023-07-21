//TRACE

C_OBJECT:C1216($response)

$response:=New object:C1471()

If ($1="/api/@")
	$path:=Replace string:C233($1; "/api"; "")
	
	webRouting($path)
Else 
	$response.message:="bad request"
	
	WEB SEND TEXT:C677(JSON Stringify:C1217($response))
End if 
