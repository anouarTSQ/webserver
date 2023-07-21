//%attributes = {}
TRACE:C157
C_OBJECT:C1216($0; $response)
C_OBJECT:C1216($1; $request)
$request:=$1  // Information provided by mobile application 
$response:=New object:C1471  // Information returned to mobile application
Case of 
	: ($request.action="addPostings")
		// Insert here the code for the action"Add..." 
	: ($request.action="editPostings")
		// Insert here the code for the action "Edit..."
	: ($request.action="deletePostings")
		// Insert here the code for the action "Remove"
	Else 
		//
		
End case 

$0:=$response