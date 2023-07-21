//%attributes = {}
ARRAY TEXT:C222($names; 0)
ARRAY TEXT:C222($values; 0)

C_TEXT:C284($0; $httpMethod)

WEB GET HTTP HEADER:C697($names; $values)

$pos:=Find in array:C230($names; "X-METHOD")

If ($pos>0)
	$httpMethod:=$values{$pos}
End if 

$0:=$httpMethod
