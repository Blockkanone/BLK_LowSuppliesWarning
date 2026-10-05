ScriptName BLK_LSW_PlayerAliasScript extends ReferenceAlias

MiscObject Property Lockpick Auto

GlobalVariable Property BLK_LSW_LockpickThreshold Auto
Bool bLockpickWarned = false

Event OnInit()
    AddInventoryEventFilter(Lockpick)
EndEvent

Event OnItemRemoved(Form akBaseItem, Int aiItemCount, ObjectReference akItemReference, ObjectReference akDestContainer)
    Int iCount = GetReference().GetItemCount(Lockpick)
    Int iThreshold = BLK_LSW_LockpickThreshold.GetValueInt()
    
    If (iCount <= iThreshold && !bLockpickWarned)
        Debug.Trace("[BLK_LSW] Lockpicks left: " + iCount)
        Debug.Notification("You're running low on lockpicks")
        bLockpickWarned = true
    EndIf
    
EndEvent

Event OnItemAdded(Form akBaseItem, Int aiItemCount, ObjectReference akItemReference, ObjectReference akSourceContainer)
    Int iCount = GetReference().GetItemCount(Lockpick)
    Int iThreshold = BLK_LSW_LockpickThreshold.GetValueInt()
    
    If (iCount > iThreshold)
        Debug.Trace("[BLK_LSW] Warning reset. Lockpicks left: " + iCount)
        bLockpickWarned = false
    EndIf
    
EndEvent