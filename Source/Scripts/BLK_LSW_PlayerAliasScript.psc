ScriptName BLK_LSW_PlayerAliasScript extends ReferenceAlias

MiscObject Property Lockpick Auto

GlobalVariable Property BLK_LSW_LockpickThreshold Auto
Bool bLockpickWarned = false

Ammo kTrackedAmmo
Bool bArrowWarned = false
GlobalVariable Property BLK_LSW_ArrowThreshold Auto

Int Property CURRENT_VERSION = 10000 AutoReadOnly
String Property VERSION_STRING = "1.0.0" AutoReadOnly
Int iInstalledVersion = 0

Event OnInit()
    Maintenance()
EndEvent

Event OnPlayerLoadGame()
    Maintenance()
EndEvent

function Maintenance()
    RemoveAllInventoryEventFilters()
    AddInventoryEventFilter(Lockpick)
    If kTrackedAmmo != None
        AddInventoryEventFilter(kTrackedAmmo)
    EndIf
    If (iInstalledVersion < CURRENT_VERSION)
        Debug.Trace("[BLK_LSW] Version mismatch. Installed: " + iInstalledVersion + ", Current: " + CURRENT_VERSION)
        If(iInstalledVersion > 0)
            Debug.Notification("Low Supplies Warning has been updated to version " + VERSION_STRING)
        EndIf
        iInstalledVersion = CURRENT_VERSION
    EndIf
Endfunction

Event OnObjectEquipped(Form akBaseObject, ObjectReference akReference)
    Ammo kNewAmmo = akBaseObject as Ammo
    If kNewAmmo == None
       return
    EndIf
    If kTrackedAmmo != None
        RemoveInventoryEventFilter(kTrackedAmmo)
    EndIf
    AddInventoryEventFilter(kNewAmmo)
    kTrackedAmmo = kNewAmmo
    bArrowWarned = false
    Int iCount = GetReference().GetItemCount(kTrackedAmmo)
    Int iThreshold = BLK_LSW_ArrowThreshold.GetValueInt()

    If (iCount <= iThreshold && !bArrowWarned)
            Debug.Trace("[BLK_LSW] Arrows left: " + iCount)
            Debug.Notification("You're running low on arrows")
            bArrowWarned = true
    EndIf
EndEvent
    
Event OnItemRemoved(Form akBaseItem, Int aiItemCount, ObjectReference akItemReference, ObjectReference akDestContainer)
    If akBaseItem== Lockpick
        Int iCount = GetReference().GetItemCount(Lockpick)
        Int iThreshold = BLK_LSW_LockpickThreshold.GetValueInt()
        
        If (iCount <= iThreshold && !bLockpickWarned)
            Debug.Trace("[BLK_LSW] Lockpicks left: " + iCount)
            Debug.Notification("You're running low on lockpicks")
            bLockpickWarned = true
        EndIf
           
    ElseIf akBaseItem == kTrackedAmmo
        Int iCount = GetReference().GetItemCount(kTrackedAmmo)
        Int iThreshold = BLK_LSW_ArrowThreshold.GetValueInt()

        If (iCount <= iThreshold && !bArrowWarned)
            Debug.Trace("[BLK_LSW] Arrows left: " + iCount)
            Debug.Notification("You're running low on arrows")
            bArrowWarned = true
        EndIf
    EndIf
EndEvent

Event OnItemAdded(Form akBaseItem, Int aiItemCount, ObjectReference akItemReference, ObjectReference akSourceContainer)
    if akBaseItem == Lockpick
        Int iCount = GetReference().GetItemCount(Lockpick)
        Int iThreshold = BLK_LSW_LockpickThreshold.GetValueInt()
        
        If (iCount > iThreshold)
            Debug.Trace("[BLK_LSW] Warning reset. Lockpicks left: " + iCount)
            bLockpickWarned = false
        EndIf
    ElseIf akBaseItem == kTrackedAmmo
        Int iCount = GetReference().GetItemCount(kTrackedAmmo)
        Int iThreshold = BLK_LSW_ArrowThreshold.GetValueInt()

        If (iCount > iThreshold)
            Debug.Trace("[BLK_LSW] Warning reset. Arrows left: " + iCount)
            bArrowWarned = false
        EndIf
    EndIf
EndEvent