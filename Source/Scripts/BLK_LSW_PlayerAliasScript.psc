ScriptName BLK_LSW_PlayerAliasScript extends ReferenceAlias

MiscObject Property Lockpick Auto

GlobalVariable Property BLK_LSW_LockpickThreshold Auto
Bool bLockpickWarned = false

Ammo kTrackedAmmo
Bool bArrowWarned = false
GlobalVariable Property BLK_LSW_ArrowThreshold Auto

Int Property CURRENT_VERSION = 10001 AutoReadOnly
String Property VERSION_STRING = "1.0.1" AutoReadOnly
Int iInstalledVersion = 0

GlobalVariable Property BLK_LSW_LockpickEnabled Auto
GlobalVariable Property BLK_LSW_ArrowEnabled Auto
GlobalVariable Property BLK_LSW_FPPerspectiveEnabled Auto
GlobalVariable Property BLK_LSW_FPAutoChecked Auto

String Property ArrowThirdPersonMessage = "You're running low on arrows" AutoReadOnly
String Property ArrowFirstPersonMessage = "I'm running low on arrows" AutoReadOnly
String Property LockpickThirdPersonMessage = "You're running low on lockpicks" AutoReadOnly
String Property LockpickFirstPersonMessage = "I'm running low on lockpicks" AutoReadOnly

String MessageArrow
String MessageLockpick

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
    If BLK_LSW_FPPerspectiveEnabled.GetValueInt() == 1
        MessageArrow = ArrowFirstPersonMessage
    ElseIf BLK_LSW_FPPerspectiveEnabled.GetValueInt() == 0
        MessageArrow = ArrowThirdPersonMessage
    EndIf
    Ammo kNewAmmo = akBaseObject as Ammo
    If kNewAmmo == None
       return
    EndIf
    CheckSurvivalAuto()
    If kTrackedAmmo != None
        RemoveInventoryEventFilter(kTrackedAmmo)
    EndIf
    AddInventoryEventFilter(kNewAmmo)
    kTrackedAmmo = kNewAmmo
    bArrowWarned = false
    Int iCount = GetReference().GetItemCount(kTrackedAmmo)
    Int iThreshold = BLK_LSW_ArrowThreshold.GetValueInt()

    If (iCount <= iThreshold && !bArrowWarned && BLK_LSW_ArrowEnabled.GetValueInt() == 1)
            Debug.Trace("[BLK_LSW] Arrows left: " + iCount)
            Debug.Notification(MessageArrow)
            bArrowWarned = true
    EndIf
EndEvent
    
Event OnItemRemoved(Form akBaseItem, Int aiItemCount, ObjectReference akItemReference, ObjectReference akDestContainer)
    CheckSurvivalAuto()
    If BLK_LSW_FPPerspectiveEnabled.GetValueInt() == 1
        MessageArrow = ArrowFirstPersonMessage
    ElseIf BLK_LSW_FPPerspectiveEnabled.GetValueInt() == 0
        MessageArrow = ArrowThirdPersonMessage
    EndIf
    If BLK_LSW_FPPerspectiveEnabled.GetValueInt() == 1
        MessageLockpick = LockpickFirstPersonMessage
    ElseIf BLK_LSW_FPPerspectiveEnabled.GetValueInt() == 0
        MessageLockpick = LockpickThirdPersonMessage
    EndIf
    If akBaseItem == Lockpick && BLK_LSW_LockpickEnabled.GetValueInt() == 1
        Int iCount = GetReference().GetItemCount(Lockpick)
        Int iThreshold = BLK_LSW_LockpickThreshold.GetValueInt()
        
        If (iCount <= iThreshold && !bLockpickWarned)
            Debug.Trace("[BLK_LSW] Lockpicks left: " + iCount)
            Debug.Notification(MessageLockpick)
            bLockpickWarned = true
        EndIf
           
    ElseIf akBaseItem == kTrackedAmmo && BLK_LSW_ArrowEnabled.GetValueInt() == 1
        Int iCount = GetReference().GetItemCount(kTrackedAmmo)
        Int iThreshold = BLK_LSW_ArrowThreshold.GetValueInt()

        If (iCount <= iThreshold && !bArrowWarned)
            Debug.Trace("[BLK_LSW] Arrows left: " + iCount)
            Debug.Notification(MessageArrow)
            bArrowWarned = true
        EndIf
    EndIf
EndEvent

Event OnItemAdded(Form akBaseItem, Int aiItemCount, ObjectReference akItemReference, ObjectReference akSourceContainer)
    If akBaseItem == Lockpick
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

Function CheckSurvivalAuto()
    If BLK_LSW_FPAutoChecked.GetValueInt() == 1
        return
    EndIf
    GlobalVariable kSurvivalToggle = Game.GetFormFromFile(0x828, "ccQDRSSE001-SurvivalMode.esl") as GlobalVariable
    If kSurvivalToggle != None && kSurvivalToggle.GetValueInt() == 1
        BLK_LSW_FPAutoChecked.SetValue(1)
        BLK_LSW_FPPerspectiveEnabled.SetValue(1)
    EndIF
EndFunction