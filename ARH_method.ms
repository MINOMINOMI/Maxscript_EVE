Ab_L_biceps = RigNode() 
	Ab_L_biceps.nodeName=
	Ab_L_biceps.nodeProperties=
	Ab_L_biceps.NodeController=
	Ab_L_biceps.NodeParent=
	Ab_L_biceps.relativeTransform=


-- RigNode Properties ���� 
obj = $ 

arProperties = getPropNames obj
arPropValues = #()
for i=1 to arProperties.count do 
(
	append arPropValues (getProperty obj arProperties[i])
)
print "----------"
obj.name 
arPropValues
obj.parent.name 
(inverse obj.transform * obj.parent.transform)
print "----------"
-- ���� �Ϸ� 


obj = $
arProperties = getPropNames obj
for i=1 to arProperties.count do 
(
	setProperty obj arProperties[i] Ab_L_Forearm_Sub.NodeProperties[i] 
)



arPositionContraintTarget = #() 
for i=1 to 5 do 
(
	local target = obj.rotation.controller.getNode i 
	if target != undefined do 
	(
		append arPositionContraintTarget target 
		arPositionContraintTarget.count 
	)
)

arOrientationContraintTargets = #()
for i=1 to 5 do 
(
	local target = obj.rotation.controller.getNode i
	if target != undefined do 
	(
		append arOrientationContraintTargets target 
	)
	arOrientationContraintTargets.count 
)

struct RigNode 
(
	NodeName,
	NodeProperties,
	NodeController,
	NodeParent,
	relativeTransform
)
-- L Limb Start--
Ab_L_Forearm_Sub = RigNode()
	Ab_L_Forearm_Sub.nodeName = "Ab L Forearm Sub"
	Ab_L_Forearm_Sub.NodeProperties = #(2.0, 2.0, 0.0, 12.1937, true, 5.0, 11.2, 10.0, false, 10.0, 10.0, 14.0, false, 4.0, 10.0, 10.0, false)
	Ab_L_Forearm_Sub.NodeController = ""
	Ab_L_Forearm_Sub.NodeParent = $'Bip001 L Forearm'
	Ab_L_Forearm_Sub.relativeTransform = (matrix3 [0.999976,0.00683945,-0.00117663] [-0.00684363,0.99997,-0.00359495] [0.0011521,0.00360295,0.999993] [-0.334976,-0.159534,0.392288])

Ab_L_UpperArm_Sub = RigNode()
	Ab_L_UpperArm_Sub.nodeName ="Ab L UpperArm Sub"
	Ab_L_UpperArm_Sub.nodeProperties = #(2.0, 2.0, 0.0, 12.1908, true, 5.0, 11.2, 10.0, false, 10.0, 10.0, 14.0, false, 4.0, 10.0, 10.0, false)
	Ab_L_UpperArm_Sub.NodeController = 
	Ab_L_UpperArm_Sub.NodeParent =$'Bip001 L UpperArm'
	Ab_L_UpperArm_Sub.relativeTransform = (matrix3 [-0.953565,-0.234113,0.000552177] [-0.233803,0.969245,0.0739638] [0.000582039,0.0738083,-0.992542] [33.6422,-5.49629,257.451])

Ab_L_Elbow = RigNode() 
	Ab_L_Elbow.nodeName="Ab L Elbow"
	Ab_L_Elbow.nodeProperties=#(2.0, 2.0, 0.0, 4.74855, false, 5.0, 11.2, 10.0, false, 5.0, 10.0, 14.0, true, 5.0, 10.0, 10.0, false)
	Ab_L_Elbow.NodeController=
	Ab_L_Elbow.NodeParent=$'Bip001 L UpperArm'
	Ab_L_Elbow.relativeTransform=(matrix3 [0.81807,-0.386027,0.426314] [0.510902,0.147416,-0.846905] [0.264083,0.910632,0.317819] [-39.8032,-98.4396,95.7997])
	
Ab_L_biceps = RigNode() 
	Ab_L_biceps.nodeName="Ab L biceps"
	Ab_L_biceps.nodeProperties=#(2.0, 2.0, 0.0, 6.50741, true, 5.0, 11.2, 10.0, false, 10.0, 10.0, 14.0, false, 4.0, 10.0, 10.0, false)
	Ab_L_biceps.NodeController=
	Ab_L_biceps.NodeParent=$'Bip001 L UpperArm' 
	Ab_L_biceps.relativeTransform=(matrix3 [0.801867,0.529056,0.277686] [-0.333829,0.0112454,0.942566] [0.495548,-0.848512,0.185632] [-65.1603,99.5715,109.273])
-- L Limb End--	
	

-- R Limb Start--
Ab_R_Forearm_Sub = RigNode()
	Ab_R_Forearm_Sub.nodeName = "Ab R Forearm Sub"
	Ab_R_Forearm_Sub.NodeProperties = #(2.0, 2.0, 0.0, 12.1937, true, 5.0, 11.2, 10.0, false, 10.0, 10.0, 14.0, false, 4.0, 10.0, 10.0, false)
	Ab_R_Forearm_Sub.NodeController = ""
	Ab_R_Forearm_Sub.NodeParent = $'Bip001 L Forearm'
	Ab_R_Forearm_Sub.relativeTransform = (matrix3 [0.999976,0.00683945,-0.00117663] [-0.00684363,0.99997,-0.00359495] [0.0011521,0.00360295,0.999993] [-0.334976,-0.159534,0.392288])

Ab_R_UpperArm_Sub = RigNode()
	Ab_R_UpperArm_Sub.nodeName ="Ab R UpperArm Sub"
	Ab_R_UpperArm_Sub.nodeProperties = #(2.0, 2.0, 0.0, 12.1908, true, 5.0, 11.2, 10.0, false, 10.0, 10.0, 14.0, false, 4.0, 10.0, 10.0, false)
	Ab_R_UpperArm_Sub.NodeController = 
	Ab_R_UpperArm_Sub.NodeParent =$'Bip001 R UpperArm'
	Ab_R_UpperArm_Sub.relativeTransform = (matrix3 [-0.953565,-0.234113,0.000552177] [-0.233803,0.969245,0.0739638] [0.000582039,0.0738083,-0.992542] [33.6422,-5.49629,257.451])

Ab_R_Elbow = RigNode() 
	Ab_R_Elbow.nodeName="Ab R Elbow"
	Ab_R_Elbow.nodeProperties=#(2.0, 2.0, 0.0, 4.74855, false, 5.0, 11.2, 10.0, false, 5.0, 10.0, 14.0, true, 5.0, 10.0, 10.0, false)
	Ab_R_Elbow.NodeController=
	Ab_R_Elbow.NodeParent=$'Bip001 R UpperArm'
	Ab_R_Elbow.relativeTransform=(matrix3 [0.81807,-0.386027,0.426314] [0.510902,0.147416,-0.846905] [0.264083,0.910632,0.317819] [-39.8032,-98.4396,95.7997])
	
Ab_R_biceps = RigNode() 
	Ab_R_biceps.nodeName="Ab R biceps"
	Ab_R_biceps.nodeProperties=#(2.0, 2.0, 0.0, 6.50741, true, 5.0, 11.2, 10.0, false, 10.0, 10.0, 14.0, false, 4.0, 10.0, 10.0, false)
	Ab_R_biceps.NodeController=
	Ab_R_biceps.NodeParent=$'Bip001 R UpperArm'
	Ab_R_biceps.relativeTransform=(matrix3 [0.801867,0.529056,0.277686] [-0.333829,0.0112454,0.942566] [0.495548,-0.848512,0.185632] [-65.1603,99.5715,109.273])
-- R Limb End--	
	
	

-- L Leg Start -- 
Ab_L_Vente = RigNode() 
	Ab_L_Vente.nodeName="Ab L Vente"
	Ab_L_Vente.nodeProperties=#(2.0, 2.0, 10.0, 9.44028, true, 5.0, 10.0, 10.0, false, 10.0, 10.0, 10.0, false, 4.0, 10.0, 10.0, false)
	Ab_L_Vente.NodeController=
	Ab_L_Vente.NodeParent=$'Dm L Hip'
	Ab_L_Vente.relativeTransform=(matrix3 [0.999917,-0.00888993,-0.00934682] [0.00934715,0,0.999956] [-0.00888951,-0.99996,8.31776e-05] [0.889495,97.8938,99.9986])

-- L Leg End -- 