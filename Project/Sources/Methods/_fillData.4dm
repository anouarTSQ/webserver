//%attributes = {}
C_TEXT:C284($users_url; $contents; $response_t)

TRUNCATE TABLE:C1051([Users:2])
TRUNCATE TABLE:C1051([Posts:1])
TRUNCATE TABLE:C1051([Comments:3])

$users_url:="https://jsonplaceholder.typicode.com/users"

$httpCode:=HTTP Request:C1158(HTTP GET method:K71:1; $users_url; $contents; $response_t)

$users:=JSON Parse:C1218($response_t)

For each ($u; $users)
	
	$user:=ds:C1482.Users.new()
	
	$user.name:=$u.name
	$user.username:=$u.username
	$user.email:=$u.email
	$user.address:=$u.address
	$user.phone:=$u.phone
	$user.website:=$u.website
	$user.company:=$u.company
	
	$res:=$user.save()
	
	If (Not:C34($res.success))
		ALERT:C41("ERROR - users !")
	Else 
		$posts_url:="https://jsonplaceholder.typicode.com/users/"+String:C10($users.indexOf($u)+1)+"/posts"
		
		$httpCode:=HTTP Request:C1158(HTTP GET method:K71:1; $posts_url; $contents; $response_t)
		
		$posts:=JSON Parse:C1218($response_t)
		
		For each ($p; $posts)
			$post:=ds:C1482.Posts.new()
			
			$post.title:=$p.title
			$post.body:=$p.body
			$post.UUID_user:=$user.UUID
			
			$res:=$post.save()
			
			If (Not:C34($res.success))
				ALERT:C41("ERROR - posts !")
			Else 
				$comments_url:="https://jsonplaceholder.typicode.com/posts/"+String:C10($posts.indexOf($p)+1)+"/comments"
				
				$httpCode:=HTTP Request:C1158(HTTP GET method:K71:1; $comments_url; $contents; $response_t)
				
				$comments:=JSON Parse:C1218($response_t)
				
				For each ($c; $comments)
					$comment:=ds:C1482.Comments.new()
					
					$comment.name:=$c.name
					$comment.email:=$c.email
					$comment.body:=$c.body
					$comment.UUID_post:=$post.UUID
					
					$res:=$comment.save()
					
					If (Not:C34($res.success))
						ALERT:C41("ERROR - comments !")
					End if 
				End for each 
				
			End if 
		End for each 
		
	End if 
End for each 

ALERT:C41("END !!!")