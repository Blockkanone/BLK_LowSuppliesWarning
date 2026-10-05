ScriptName BLK_LSW_PlayerAliasScript extends ReferenceAlias

MiscObject Property Lockpick Auto

Event OnInit()
    AddInventoryEventFilter(Lockpick)
EndEvent

Event OnItemRemoved(Form akBaseItem, Int aiItemCount, ObjectReference akItemReference, ObjectReference akDestContainer)
    Int iCount = GetReference().GetItemCount(Lockpick)
    
    If (iCount <= 10)
        Debug.Trace("[BLK_LSW] Lockpicks left: " + iCount)
        Debug.Notification("You're running low on lockpicks")
    EndIf
EndEvent