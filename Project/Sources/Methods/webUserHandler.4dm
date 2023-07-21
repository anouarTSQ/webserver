//%attributes = {}
C_TEXT:C284($path; $1)
C_TEXT:C284($httpMethod; $2)

$path:=$1
$httpMethod:=$2

Case of 
	: ($httpMethod="GET")
		If ()
			
		Else 
			
		End if 
	: ($httpMethod="POST")
		
	: ($httpMethod="PUT")
	: ($httpMethod="DELETE")
	Else 
		
End case 
