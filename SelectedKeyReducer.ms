fn getSelectedNodes =
(
    local arNodes = selection as array 
    return arNodes 
)

fn getFramesforDelete fStartFrame fEndFrame iInterval =
(
    /*debug code
    fStartFrame = 0 
    fEndFrame = 100 
    iInterval =3
    */
    arAllFrames =  ( for i = fStartFrame to fEndFrame collect i )
        
    local arSpecific = #()
    local arIntervalFrames = #()
    local temp = 0
    local nodes = getSelectedNodes()

    for i=fStartFrame to fEndFrame do 
    (
        temp += 1
        cnt = fStartFrame + ( iInterval * temp )
        if cnt < fEndFrame do 
        (
            append arSpecific cnt 
        )
    )
    
    for i in arSpecific do 
    (
        indexkey = findItem arAllFrames i 
        --print indexKey 
        arAllFrames = deleteItem arAllFrames indexkey
    )

    indexKey = findItem arAllFrames fStartFrame
    arAllFrames = deleteItem arAllFrames indexkey

    indexKey = findItem arAllFrames fEndFrame
    arAllFrames = deleteItem arAllFrames indexKey
    
    -- for i in arAllFrames do print i -> Debug Line 
    for i in arAllFrames do 
    (
        for j in nodes do 
        (
            local iIndex = getKeyIndex j.controller i 

            if iIndex > 0 do 
            (
                deleteKey j.controller iIndex 
            )
        )
    )
)
Try
(
    DestroyDialog rltKeyReducer
)
Catch()

rollout rltKeyReducer "Selected Key Reducer"
(
    Spinner sprStartFrame "Start Frame : " across:2 type:#integer range:[-100,50000,0]
    Spinner sprEndFrame "End Frame : " type:#integer range:[-100,50000,0]
    Spinner sprFrames "Key Reduction Interval" type:#integer
    button btnReduceKeys "Reduce Keys"


    on btnReduceKeys pressed do 
    (
        undo on
        ( 
            local fStartFrame = sprStartFrame.value 
            local fEndFrame = sprEndFrame.value 
            local iInterval = sprFrames.value + 1
            getFramesforDelete fStartFrame fEndFrame iInterval
        )
    )
)createDialog rltKeyReducer 400 100


--maxSCript Remainder = mod {Val1} {Val2}

