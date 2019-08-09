-- RigNode Properties 수집 
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
-- 수집 완료 


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

Ab_L_Forearm_Sub = RigNode()
	Ab_L_Forearm_Sub.nodeName = "Ab L Forearm Sub"
	Ab_L_Forearm_Sub.NodeProperties = #(2.0, 2.0, 0.0, 12.1937, true, 5.0, 11.2, 10.0, false, 10.0, 10.0, 14.0, false, 4.0, 10.0, 10.0, false)
	Ab_L_Forearm_Sub.NodeController = ""
	Ab_L_Forearm_Sub.NodeParent = $'Bip001 L Forearm'
	Ab_L_Forearm_Sub.relativeTransform = (matrix3 [0.999976,0.00683945,-0.00117663] [-0.00684363,0.99997,-0.00359495] [0.0011521,0.00360295,0.999993] [-0.334976,-0.159534,0.392288])

