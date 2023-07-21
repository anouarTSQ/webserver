//%attributes = {}
$aa:=User in group:C338(Current user:C182; "Admin")


Class extends DataClass

exposed Function getAnouar
	$0:="Anouar"
	
exposed Function getAll
	C_COLLECTION:C1488($projects)
	
	$projects:=New collection:C1472()
	
	$projects_es:=ds:C1482.Project.query("hidden = :1"; False:C215)
	
	For each ($p; $projects_es)
		$projects.push(New object:C1471(\
			"UUID"; $p.UUID; \
			"name"; $p.name; \
			"description"; $p.description; \
			"slug"; $p.slug; \
			"url"; $p.url; \
			"port"; $p.port; \
			"folderPath"; $p.folderPath; \
			"status"; $p.status; \
			"analysis"; $p.analysis.length; \
			"color"; $p.color; \
			"currentVersion"; $p.currentVersion; \
			"targetVersion"; $p.targetVersion\
			))
	End for each 
	
	$0:=New object:C1471(\
		"success"; True:C214; \
		"count"; $projects.length; \
		"projects"; $projects\
		)
	
exposed Function createProject
	C_OBJECT:C1216(\
		$project; $1; \
		$project_e; $res\
		)
	
	$project:=$1
	
	$project_e:=ds:C1482.Project.new()
	$project_e.fromObject($project)
	
	$res:=$project_e.save()
	
	If ($res.success)
		$0:=New object:C1471(\
			"success"; True:C214; \
			"project"; $project_e.toObject()\
			)
	Else 
		$0:=New object:C1471(\
			"success"; False:C215\
			)
	End if 
	
exposed Function updateProject
	C_OBJECT:C1216(\
		$project; $1; \
		$project_e; $project_es; $res\
		)
	
	$project:=$1
	
	$project_es:=ds:C1482.Project.query("slug = :1"; $project.slug)
	
	If ($project_es.length>0)
		$project_e:=$project_es[0]
		$project_e.fromObject($project)
		
		$res:=$project_e.save()
		
		If ($res.success)
			$0:=New object:C1471(\
				"success"; True:C214; \
				"project"; $project_e.toObject()\
				)
		Else 
			$0:=New object:C1471(\
				"success"; False:C215\
				)
		End if 
	Else 
		$0:=New object:C1471(\
			"success"; False:C215\
			)
	End if 
	
exposed Function getProjectBySlug
	C_TEXT:C284($slug; $1)
	
	$slug:=$1
	
	$projects_es:=ds:C1482.Project.query("slug = :1"; $slug)
	
	If ($projects_es.length>0)
		$0:=New object:C1471(\
			"success"; True:C214; \
			"project"; $projects_es[0].toObject()\
			)
	Else 
		$0:=New object:C1471(\
			"success"; False:C215\
			)
	End if 
	
exposed Function pingOnProjectBySlug
	C_TEXT:C284($slug; $1)
	C_OBJECT:C1216($res)
	
	$slug:=$1
	
	$res:=New object:C1471("success"; False:C215; "projectReachable"; False:C215)
	
	$projects_es:=ds:C1482.Project.query("slug = :1"; $slug)
	
	If ($projects_es.length>0)
		$res.success:=True:C214
		
		$urlProject:=$projects_es[0].url+":"+$projects_es[0].port
		$fullUrl:=$urlProject+"/api/checkConnection"
		
		ON ERR CALL:C155("errWebHandler")
		
		HTTP SET OPTION:C1160(HTTP timeout:K71:10; 3)
		$httpCode:=HTTP Get:C1157($fullUrl; $response)
		
		If ($httpCode>0) & ($httpCode=200)
			$res.success:=True:C214
			$res.projectReachable:=True:C214
		End if 
	End if 
	
	$0:=$res
	
exposed Function pingOnProjectByUrl
	C_TEXT:C284($urlProject; $1)
	C_OBJECT:C1216($response; $res)
	
	$res:=New object:C1471("success"; False:C215)
	
	$urlProject:=$1
	$fullUrl:=$urlProject+"/api/checkConnection?option=\"onCreationProcess\""
	
	ON ERR CALL:C155("errWebHandler")
	
	HTTP SET OPTION:C1160(HTTP timeout:K71:10; 3)
	$httpCode:=HTTP Get:C1157($fullUrl; $response)
	
	If ($httpCode>0) & ($httpCode=200)
		$res.success:=True:C214
		$res.projectPathFolder:=$response.projectPathFolder
	End if 
	//TRACE
	
	$0:=$res
	
exposed Function openFolderProject
	C_TEXT:C284($slug; $1)
	C_OBJECT:C1216($res)
	
	$slug:=$1
	
	$res:=New object:C1471("success"; False:C215)
	
	$projects_es:=ds:C1482.Project.query("slug = :1"; $slug)
	
	If ($projects_es.length>0)
		SHOW ON DISK:C922($projects_es[0].folderPath; *)
	End if 
	
	$0:=$res