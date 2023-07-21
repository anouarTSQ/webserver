//%attributes = {}
C_OBJECT:C1216($0)
C_OBJECT:C1216($1)

C_OBJECT:C1216($entity; $in; $out)
C_VARIANT:C1683($key)

$in:=$1

$out:=New object:C1471("success"; False:C215)

If ($in.dataClass#Null:C1517)
	
	$entity:=ds:C1482.Posts.new()  //create a reference
	
	For each ($key; $in.parameters)
		
		$entity[$key]:=$in.parameters[$key]
		
	End for each 
	
	$entity.DatePosted:=Current date:C33
	$entity.UserUUID:=$in.userUUID
	
	$entity.save()  // save the entity
	
	$out.success:=True:C214  // notify App that action success
	$out.dataSynchro:=True:C214  // notify App to refresh the selection
	$out.statusText:="Posting added"
	
Else 
	
	$out.errors:=New collection:C1472("No Selection")
	
End if 

$0:=$out
