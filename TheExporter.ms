/* Eve Exporter Script By Minomi*/

include "\\\\10.220.70.12\\eve\\ART_Backup\\Script\\getKeySelector\\SelectedKeyFunc.ms"
include "\\\\10.220.70.12\\eve\\ART_Backup\\Script\\getKeySelector\\selectedKeyBipOpposite.ms"
include "\\\\10.220.70.12\\eve\\ART_Backup\\Script\\BVHRetargeter\\BVHRetargeter.ms"

Global BodyNodes ="\\\\10.220.70.12\\eve\\ART_Backup\\Script\\Exporter\\BodyNodes.ms"
Global FacialNodes = "\\\\10.220.70.12\\eve\\ART_Backup\\Script\\Exporter\\FacialNodes.ms"
Global LastExportPath = ( (GetDir #userScripts) + "\\" + "LastExportPath.ms" )
Global eveLogo = "\\\\10.220.70.12\\eve\\ART_Backup\\Script\\Logo\\eveLogo.bmp"
Global rolloutSetting = ( (getDir #userScripts) + "\\" + "personalSetting.ini" )

fn grabchildren aBone childArray:#() getSelf:true = 
(
	for cBone in aBone.children do
	(
		append childArray cBone		
		if cBone.children.count !=0 do 
		(
			grabchildren cBone childArray:childArray 
		)
	)
	
	if getSelf do childArray = #(aBone)+childArray
	
	return childArray
)--Code by FScreen 

fn makeExportogDir =
(
	local userName = sysInfo.username
	local userLogDir = "\\\\10.220.70.12\\eve\\ART_Backup\\CollectedLog\\" + userName
	if (doesDirectoryExist userLogDir) != true then 
	(
		makeDir userLogDir
	)
	return userLogDir
)

fn collectUserLog logDir fileName = 
(
	local txtfileName = fileName + ".txt"
	file = logDir + "\\" + txtfileName 
	createFile file 
)


fn animationExportSetUp =
(
	FbxExporterSetParam "Animation" true
	
	FbxExporterSetParam "UseSceneName" true
	
	FbxExporterSetParam "BakeAnimation" true
	FbxExporterSetParam "BakeFrameStart" animationRange.start
	FbxExporterSetParam "BakeFrameEnd" animationRange.end
	FbxExporterSetParam "BakeFrameStep" 1
	FbxExporterSetParam "BakeResampleAnimation" true
	FbxExporterSetParam "Resampling" 30.0
	FbxExporterSetParam "FilterKeyReducer" false
	FbxExporterSetParam "Skin" true	
	FbxExporterSetParam "Shape" false
	
	FbxExporterSetParam "SmoothingGroups" true	 	--Export With Smoothing Group
	
	FbxExporterSetParam "UpAxis" #z						 	--Up Axis -> +Z
	FbxExporterSetParam "Lights" false					 	--Export WithOut Light
	FbxExporterSetParam "ASCII" true						 	--FBX Format -> ASCII
	FbxExporterSetParam "ConvertUnit" #custom unit	--unit Size -> Custom
	
	
	
) -- from FBX Export Parameter Selection


Fn fn_getMultipleFiles =
(
	theDialog = dotNetObject "System.Windows.Forms.OpenFileDialog" --create a OpenFileDialog 
	theDialog.title = "PLEASE Select One Or More Files" --set the title
	theDialog.Multiselect = true --allow multiple files to be selected
	theDialog.Filter = "All Files (*.*)|*.*|max Files (*.max)|*.max" --specify the filter
	theDialog.FilterIndex = 2 --set the filter drop-down list to All Files
	result = theDialog.showDialog() --display the dialog, get result into variable
	result.ToString() --when closed, convert the result to string
	result.Equals result.OK --returns TRUE if OK was pressed, FALSE otherwise
	result.Equals result.Cancel --returns TRUE if Cancel was pressed, FALSE otherwise
	theFilenames = theDialog.fileNames --the selected filenames will be returned as an array
	return theFilenames
)

fn getBodyNodes = 
(	
	File = BodyNodes
	fileSTM = openFile File
	ar_selection = #()

	deselect $*
	while not eof fileSTM do
	(
		try
		(
			txt = readLine fileSTM 
			nodeName = getNodeByName txt
			append ar_selection nodeName 
		)
		Catch(print nodeName)
	)
	close fileSTM
	UndefinedNodeinScene = findItem ar_selection undefined 
	if UndefinedNodeinScene == 0 then
	(
		select ar_Selection
	)
	else 
	(
		messageBox "This file(Scene) doesn't seem to be \nthe right file of PC(EVE) " title:"Script Alert"
		format "undefined Node num : %" UndefinedNodeinScene
		--exit 
	)
) -- NodeName parsing from txt file


fn getFacialNodes = 
(	
	File = FacialNodes
	fileSTM = openFile File
	ar_selection = #()
	deselect $*
	while not eof fileSTM do
	(
		try
		(
			txt = readLine fileSTM 
			nodeName = getNodeByName txt
			append ar_selection nodeName
		)
		Catch(print nodeName)
	)
	close fileSTM
	select ar_Selection
	--selectMore $Bip001*
) -- NodeName parsing from txt file


fn getLastExportPath =
(
	
	isLastExportPath = doesFileExist ( (GetDir #userScripts) + "\\" + "LastExportPath.ms" )
	
	if isLastExportPath != True then
	(
		file = createFile ( (GetDir #userScripts) + "\\" + "LastExportPath.ms" )
		LastExportPath = ( (GetDir #userScripts) + "\\" + "LastExportPath.ms" )
	)
	
	else 
	(
		file = LastExportPath
		fileSTM = openFile File
		while not eof fileSTM do
		(
			try
			(
				txt = readLine fileSTM
				ExportPath = txt
			)
			Catch()
		)
	)
	Close fileSTM
	
	if ExportPath == undefined do
	(
		ExportPath = ""
	)
	return ExportPath
)

fn makeNewINIFile =
(
	local isPersonalSettingFile = doesFileExist ( (getDir #userScripts) + "\\" + "personalSetting.ini")

	if isPersonalSettingFile != True then
	(
		local file = createFile( (getDir #userScripts) + "\\" + "personalSetting.ini" )
		local PersonalSetting = ( (getDir #userScripts) + "\\" + "personalSetting.ini" )
		Format "\n New iniFile : % \n" PersonalSetting

		setINISetting PersonalSetting "personalSetting" "Species" "1"
		setINISetting PersonalSetting "personalSetting" "ExportOption" "1"
	) 
)

fn getSkinObjs =
(
	local objs = $*
	local skinObjs = #()
	for obj in objs do
	(
		for i=1 to obj.modifiers.count do if classof obj.modifiers[i] == Skin do append skinObjs obj
	)
	return skinObjs
)

fn getMeshObjs = 
(
	local objs = $*
	local meshObjs = #()
	for obj in objs do
	(
		if Classof obj == PolyMeshObject do 
		(
			append MeshObjs obj
		)
	)
	return meshObjs 
)

fn getSkinBone obj = 
(		
	select obj
	setCommandPanelTaskMode mode:#modify  		
	
	local skinModifierID=0
	for i=1 to obj.modifiers.count do if classof obj.modifiers[i] == Skin do skinModifierID=i
	
	if skinModifierID != 0 then
	(	
		local skinModifier =  Obj.modifiers[skinModifierID]       
		local boneCount = skinOps.GetNumberBones skinModifier	--skin?? ????? Bone ?????? ????
		
		local result = for i in 1 to boneCount collect getNodeByName (skinOps.GetBoneName skinModifier i 1)		
		return result
	)
	else
	(
		return #()
	)
)

fn isRootNodeisRoot =
(
	local bRootisValid = isValidNode $Root 

	if bRootisValid == true then 
	(
		if( $Bip001.parent == $Root ) then
		(
			isRoot = True
		)
		else 
		(
			isRoot = false
			$Bip001.parent = $Root 
		)
	)
	else 
	(
		local bnRootNode = boneSys.createBone [ 0, 0, 0 ] [ 0, -20, 0 ] [ 0, 0, 1 ] -- Root를 -Y를 Front로 놓고 생성 
		bnRootNode.name = "Root"
		$Bip001.parent = bnRootNode 
		print "Root Node Created"
	)

	Return isRoot 
)

fn selectMeshesOnly = --wrappingCode 
(
	deselect $*
	ar_meshObjs = getMeshObjs()
	select ar_meshObjs
)


Global ar_MaxFiles =#()
Global BatchDir = getLastExportPath()
Global b_FacialOnly = false

Global Species = (getINISetting rolloutSetting "personalSetting" "Species") as integer 
Global exportOption = (getINISetting rolloutSetting "personalSetting" "exportOption") as integer
Global facialSetting = 1
Global cnt = 0

Global ar_skinObjs = #()
Global ar_meshObjs = #()
Global ar_skinBones = #()
Global specificName = ""

fn selectSkinBones = --wrappingCode 
(
	ar_skinObjs = getSkinObjs()
	for i=1 to ar_SkinObjs.count do
	(
		local skinBone = getSkinBone ar_skinObjs[i]
		append ar_skinBones skinBone
	)
	for i in ar_skinBones do selectMore i
)

fn selectBeforeExport =
(
	case species of
	(
		1 : --when Export PC Species
		(
			
			getBodyNodes() -- get Bone Object 
			Case exportOption of
			(
				1 : --when Export bones and Mesh 
				(
					ar_skinObjs = getSkinObjs()
					selectMore ar_skinObjs
					format "select Bones and Mesh PC[EVE]\n"
				)
				2 : -- when Export Bones Only 
				(
					if facialSetting == 2 do -- Export facialNodes Only 
					(							
						deselect $* 
						getFacialNodes()
					)
				) 
				3 : --when Export Meshes Only 
				(
					selectMeshesOnly()
					--ddl_facialSetting.enabled = false
				)
			)
		)
		2 : --when export Mob Species 
		(
			Case exportOption of 
			(
				1 : --when Export Bones and Mesh 
				(
					selectSkinBones()
					selectMore ar_skinObjs 
				)
				2 : --when Export Bones Only 
				(
					selectSkinBones()
				)
				3 : --when Export Meshes Only 
				(
					selectMeshesOnly()
				)
			)
					
		)
		3 : --when Export Weapon Species 
		(
			Case exportOption of 
			(
				1 : --when Export Bones and Mesh 
				(	
					ar_skinBones = grabchild $Weapon_Root
					select ar_skinBones
				)
				2 : --when Export Bones On;y 
				(
					ar_skinBones = grabchild $Weapon_Root
					select ar_skinBones
				)
				3 : -- when Export Meshes Only 
				(
					selectMeshesOnly()
				)
			)
		)
	)
	if exportOption == 4 do
	(
		deselect $*
		select $*
	)
)

fn ExtractFile = --code Wrap
(
	local exportPath = BatchDir + "\\"
	if MaxFileName != undefined then 
	(
		if specificName == "" then
		(
			local exportName = substituteString MaxFileName ".max" ".fbx"
			local exportFileName = exportPath + exportName 
		)
		else 
		(
			local exportName = specificName + ".fbx"
			local exportFileName = exportPath + exportName
		)

		format "\nExportFileName : %\n" exportFileName

		exportFile exportFileName #noPrompt selectedOnly:True using:FBXEXPORTER
		fileName = getFilenameFile exportFileName 
		return fileName
	)
	else
	(
		--exportName = ""
		mesaageBox "first, save this Scene\nAnd Redo."	title:"script Alert"
	)
	--fileName = getFilenameFile exportName 
)

Try(closeRolloutFloater theFloater) Catch()

rollout 'Exporter' "The Exporter 1.0" width:505 height:723
(
	button 'btn_selectFiles' "Select Files" pos:[19,21] width:158 height:90 align:#left
	button 'eveLogo' "11" pos:[195,21] width:90 height:90 images:#("//10.220.70.12/eve/ART_Backup/Script/Logo/eveLogo.bmp", "//10.220.70.12/eve/ART_Backup/Script/Logo/eveLogo.bmp",1, 1,1,1,1,1)
	listBox 'mlb_FileNames' "File List" pos:[28,139] width:433 height:16 align:#left
	button 'btn_FilePath' "Select Export Path" pos:[24,394] width:93 height:34 align:#left
	editText 'et_FilePath' "" pos:[120,393] width:343 height:35 align:#left
	dropDownList 'ddl_Species' "Species" pos:[20,461] width:448 height:41 items:#("PC(EVE)", "MOB(NA)", "Weapon(WP)") align:#left selection:Species
	dropDownList 'ddl_exportOption' "Export Option" pos:[20,500] width:448 height:41 items:#("Bones + Mesh", "Bones Only", "Mesh Only", "All") selection:exportOption align:#left
	button 'btn_export' "Export" pos:[305,20] width:158 height:90 align:#left
	groupBox 'grp1' "Import / Export" pos:[9,5] width:467 height:118 align:#left
	progressBar 'pgb_process' "Exporting..." pos:[22,621] width:440 height:20 align:#left
	edittext 'et_processText' "" pos:[17,650] width:447
	edittext 'et_exportName' "Export Name : " pos:[20,565] width:250
	checkBox 'chx_isMultiExport' "Multi Export?" pos:[280,565] tooltip:"if unchecked, Export Scene objects"
	dropDownList 'ddl_FacialSetting' "Facial" pos:[366,543] width:101 height:41 items:#("WithOut Facial", "Facial Only") align:#left
	groupBox 'grp2' "" pos:[12,126] width:468 height:314 align:#left
	groupBox 'grp3' "" pos:[13,453] width:468 height:138 align:#left
	groupBox 'grp4' "Progress" pos:[13,603] width:468 height:90 align:#left
	
	
	On Exporter open do
	(
		et_FilePath.text = ( BatchDir as string )
		ddl_FacialSetting.enabled = false
		et_processText.text = "Preparing for the export..."
		--makeExportogDir()
		--Species = getINISetting rolloutSetting "personalSetting" "Species"
		--exportOption = getINISetting rolloutSetting "personalSetting" "exportOption"
	)
	on eveLogo pressed do
	(
		ShellLaunch "http://dev.shiftup.co.kr/confluence/pages/viewpage.action?spaceKey=EVE&title=Project+EVE+dev" ""
	)
	On btn_selectFiles Pressed do
	(
		ar_MaxFiles = fn_getMultipleFiles multi:true fileFilter:"MAX Files (*.max)|*.max"
		mlb_FileNames.items = ar_MaxFiles
		chx_isMultiExport.checked = true
	)
	
	On ddl_Species selected i do
	(
		if i != 1 then
		(
			ddl_FacialSetting.enabled = false
			facialSetting = 0
		)
		else BatchDir
		(
			ddl_FacialSetting.enabled = true
			facialSetting = 1
		)
		Species = i
		setINISetting rolloutSetting "personalSetting" "Species" ( Species as string )
	)
	
	On ddl_exportOption selected i do
	(
		if i == 3 or i == 4 then
		(
			ddl_Species.enabled = false
			ddl_FacialSetting.enabled = false
		)
		else if i == 1 then 
		(
			ddl_Species.enabled = true
			ddl_FacialSetting.enabled = false
		)
		else
		(
			ddl_Species.enabled = true
			ddl_FacialSetting.enabled = true
		)
		exportOption = i
		setINISetting rolloutSetting "personalSetting" "ExportOption" ( exportOption as string )
	)
	
	On ddl_facialSetting selected i do
	(
		facialSetting = i
	)
	
	On et_exportName changed txt do
	(
		specificName = txt 
	)
	On btn_FilePath Pressed do
	(
		local savePath = getSavePath "Set Output Path"
		if savePath != undefined then 
		(
			et_FilePath.text = savePath
		)
		else 
		(
			et_FilePath.text = ""
		)
		BatchDir = et_FilePath.text
		File = createFile LastExportPath
		Format BatchDir to:File
		close File
	)
	on btn_export Pressed do
	(
		et_processText.text = "Exporting..."
		cnt = 0 
		
		if ( ddl_Species.enabled != true ) then Species = 0
		else Species = ddl_Species.selection
		if ( ddl_FacialSetting.enabled != True ) then FacialSetting = 0
		else FacialSetting = ddl_FacialSetting.selection

		format "\n%,%,%\n" Species exportOption facialSetting
		animationExportSetUp()


		if ar_MaxFiles.count != 0 then --do Multi Export 
		(
			specificName = ""
			et_exportName.text = specificName
			
			for i in ar_MaxFiles do 
			(
				loadMaxFile i quiet:true
				units.systemScale = 1

				--hideByCategory.none()
				--unhide $*

				selectBeforeExport()

				animationExportSetUp()

				fileName = ExtractFile()
				logDir = makeExportogDir()
				collectUserLog logDir fileName  
				cnt += 1
				pgb_process.value = (100.0 / ar_MaxFiles.count ) * cnt
			)
			if pgb_process.value == 100.0 OR cnt == ar_MaxFiles.count do
			(
				--messageBox "Export Process Compelete" Title:"Script Alert" 
				et_processText.text = "Export Process Complete"
			)
		)
		else -- do Scene Export 
		(

			units.SystemScale = 1

			selectBeforeExport()
			
			fileName = ExtractFile()
			logDir = makeExportogDir()
			collectUserLog logDir fileName  
			pgb_process.value = 100
			if pgb_process.value == 100 do 
			(
				--messageBox "Export Process Compelete" Title:"Script Alert" 
				et_processText.text = "Export Process Complete"
			)
		)
	)
)
theFloater = newRolloutFloater "The Exporter" 505 730

addRollout 'Exporter' theFloater rolledUp:false
addRollout 'setKeyForSelected' theFloater rolledUp:true
addRollout 'rBipCopytoSel' theFloater rolledUp:true 
addRollout 'BVHRetargeter' theFloater rolledUp:true 