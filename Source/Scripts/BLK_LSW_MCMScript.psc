ScriptName BLK_LSW_MCMScript extends SKI_ConfigBase

GlobalVariable Property BLK_LSW_LockpickEnabled Auto
GlobalVariable Property BLK_LSW_ArrowEnabled Auto
GlobalVariable Property BLK_LSW_ArrowThreshold Auto
GlobalVariable Property BLK_LSW_LockpickThreshold Auto

Int iOptLockpickEnabled
Int iOptLockpickThreshold
Int iOptArrowEnabled
Int iOptArrowThreshold

Event OnPageReset(String page)
    If page == "" || page == "Settings"
        SetCursorFillMode(TOP_TO_BOTTOM)
        AddHeaderOption("Lockpicks")
        iOptLockpickEnabled = AddToggleOption("Lockpick warning", BLK_LSW_LockpickEnabled.GetValueInt() == 1)
        iOptLockpickThreshold = AddSliderOption("Warn at", BLK_LSW_LockpickThreshold.GetValue(), "{0}")
        AddHeaderOption("Arrows")
        iOptArrowEnabled = AddToggleOption("Arrow warning", BLK_LSW_ArrowEnabled.GetValueInt() == 1)
        iOptArrowThreshold = AddSliderOption("Warn at", BLK_LSW_ArrowThreshold.GetValue(), "{0}")
    EndIf
EndEvent

Event OnOptionSelect(Int option)
    If option == iOptLockpickEnabled
        Bool bNew = BLK_LSW_LockpickEnabled.GetValueInt() == 0
        BLK_LSW_LockpickEnabled.SetValue(bNew as Int)
        SetToggleOptionValue(option, bNew)
    ElseIf option == iOptArrowEnabled
        Bool bNew = BLK_LSW_ArrowEnabled.GetValueInt() == 0
        BLK_LSW_ArrowEnabled.SetValue(bNew as Int)
        SetToggleOptionValue(option, bNew)
    EndIf
EndEvent

Event OnOptionSliderAccept(Int option, Float value)
    If option == iOptLockpickThreshold
        BLK_LSW_LockpickThreshold.SetValue(value)
        SetSliderOptionValue(option, value, "{0}")
    ElseIf option == iOptArrowThreshold
        BLK_LSW_ArrowThreshold.SetValue(value)
        SetSliderOptionValue(option, value, "{0}")
    EndIf
EndEvent

Event OnOptionSliderOpen(Int option)
    If option == iOptLockpickThreshold
        SetSliderDialogStartValue(BLK_LSW_LockpickThreshold.GetValue())
        SetSliderDialogDefaultValue(10.0)
        SetSliderDialogRange(0.0, 100.0)
        SetSliderDialogInterval(1.0)
    ElseIf option == iOptArrowThreshold
        SetSliderDialogStartValue(BLK_LSW_ArrowThreshold.GetValue())
        SetSliderDialogDefaultValue(20.0)
        SetSliderDialogRange(0.0, 200.0)
        SetSliderDialogInterval(1.0)
    EndIf
EndEvent


Event OnOptionHighlight(Int option)
    If option == iOptLockpickEnabled
        SetInfoText("Enable/Disable the warning when your lockpicks are running low.")
    ElseIf option == iOptLockpickThreshold
        SetInfoText("Set the number of lockpicks at which to show the warning.")
    ElseIf option == iOptArrowEnabled
        SetInfoText("Enable/Disable the warning when your arrows are running low.")
    ElseIf option == iOptArrowThreshold
        SetInfoText("Set the number of arrows at which to show the warning.")
    EndIf
EndEvent

Int Function GetVersion()
    return 1
EndFunction

Event OnConfigInit()
    Pages = new String[1]
    Pages[0] = "Settings"
EndEvent