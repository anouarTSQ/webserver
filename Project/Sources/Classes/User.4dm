Class extends DataClass

exposed Function createNewUser
	C_OBJECT:C1216($user; $1)
	TRACE:C157
	$user:=$1
	
	$user_e:=ds:C1482.Users.new()
	
	$user_e.fromObject($user)
	
	$res:=$user_e.save()
	
	$0:=New object:C1471("success"; $res.success)
	
	If ($res.success)
		$0:=New object:C1471("success"; True:C214)
	Else 
		$0:=New object:C1471("success"; False:C215)
	End if 