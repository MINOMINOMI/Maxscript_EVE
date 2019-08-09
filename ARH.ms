include "\\\\10.220.70.12\\eve\\ART_Backup\\Script\\Library\\stella.ms"
--stella Library Include--

Global arBoneSets = #(2,2,2,2)
Global arStates = #(true,true,true)



undo on 
(
	TBSetFunction arBoneSets arStates 
) 

select $Bone* 

for i=1 to selection.count do 
(
	selection[i].name = substituteString selection[i].name "Bone" "Ab"
)

deselect $*

obj = $
arProperties = getPropNames obj
for i=1 to arPropValues.count do 
(
	setProperty obj arProperties[i] arPropValues[i] 
)

