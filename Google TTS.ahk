#NoEnv
#SingleInstance Force
;#Persistent

SetWorkingDir %A_ScriptDir%
SetBatchLines, -1

global ConfigPath, InitConfigPath, RestartStatus, Profile, ProfileList, OldLangSel, OldTtsInput, LanguageSelect, LastMessage, LanguageList, FileToPlay, BtnID, Text1, Hot1, Text2, Hot2, Text3, Hot3, Text4, Hot4, Text5, Hot5, Text6, Hot6, Text7, Hot7, Text8, Hot8, Text9, Hot9, Text0, Lck0, Lck1, Lck2, Lck3, Lck4, Lck5, Lck6, Lck7, Lck8, Lck9, Hot0

;Create Folders
FileCreateDir, ttssound\Default\da-DK
FileCreateDir, ttssound\Default\en-US
FileCreateDir, ttssound\Default\en-GB
FileCreateDir, ttssound\Default\en-AU
FileCreateDir, ttssound\Default\en-IN

;Init Config
InitConfigPath = ttssound\ini_Config.ini

if !FileExist(InitConfigPath)
{
	FileAppend,
	(
[DEFAULTS]
LangSel=da-DK
ProfSel=Default
ProfList=Default
LastMsg=""
VolSel=0
Restart=0
	), %InitConfigPath%
}

;Initialize Program
IniRead, LanguageSelect, %InitConfigPath%, DEFAULTS, LangSel
IniRead, Profile, %InitConfigPath%, DEFAULTS, ProfSel
IniRead, ProfileList, %InitConfigPath%, DEFAULTS, ProfList
IniRead, LastMessage, %InitConfigPath%, DEFAULTS, LastMsg
IniWrite, 0, %InitConfigPath%, DEFAULTS, Restart
IniRead, RestartStatus, %InitConfigPath%, DEFAULTS, Restart
ConfigPath = ttssound\%Profile%\%LanguageSelect%\TTS_Config.ini
ReadConfig(ConfigPath, LanguageSelect)
GenerateHotkeys()

;Create GUI
Gui, -Caption
Gui, Font, c75A2B9
Gui, Color, 1E1E1E, 1E1E1E, CE9178
Gui, Add, Text, gUiMove border xm y5 w460 h15, TTS by Geek
Gui, Add, Text, gGuiMinimize border 0x200 center x+p yp w20 h15, -
Gui, Add, Text, gGuiClose border 0x200 center x+p yp w20 h15, X
Gui, Add, Edit, gCalcCharLeft xm y+m w500 r3 -WantReturn -VScroll +limit200 vTtsInput, %LastMessage%
Gui, Add, Radio, gSetLanguage vLanguageSelectDA xp y+m w40 h20, DA
Gui, Add, Radio, gSetLanguage vLanguageSelectUS x+p yp w40 h20, US
Gui, Add, Radio, gSetLanguage vLanguageSelectGB x+p yp w40 h20, GB
Gui, Add, Radio, gSetLanguage vLanguageSelectAU x+p yp w40 h20, AU
Gui, Add, Radio, gSetLanguage vLanguageSelectIN x+p yp w40 h20, IN
Gui, Add, Button, gPlayTTS x+5 yp w60 h20 Default, Play
Gui, Add, ComboBox, gSetLanguage vProfile x+3 yp, %ProfileList%
Gui, Add, Button, gUpdateProfile 0x200 center x+3 yp w30 h20, ADD
Gui, Add, Button, gUpdateProfile 0x200 center x+3 yp w30 h20, DEL
Gui, Add, Text, vCharLeft 0x200 right x+6 yp w40 h20, 0/200
Gui, Add, Text, gSaveFile vSave1 border 0x200 center xm y105 w40 h20, Save 1
Gui, Add, Text, gToggleLock vToggleLock1 border 0x200 center x+5 yp w40 h20, Lock
Gui, Add, Text, vCharLeft1 0x200 right x+15 yp w40 h20, 0/200
Gui, Add, Hotkey, xm y+5 w140 h20 vHot1, %Hot1%
Gui, Add, Text, gSaveFile vSave2 border 0x200 center xp yp+35 w40 h20, Save 2
Gui, Add, Text, gToggleLock vToggleLock2 border 0x200 center x+5 yp w40 h20, Lock
Gui, Add, Text, vCharLeft2 0x200 right x+15 yp w40 h20, 0/200
Gui, Add, Hotkey, xm y+5 w140 h20 vHot2, %Hot2%
Gui, Add, Text, gSaveFile vSave3 border 0x200 center xp yp+35 w40 h20, Save 3
Gui, Add, Text, gToggleLock vToggleLock3 border 0x200 center x+5 yp w40 h20, Lock
Gui, Add, Text, vCharLeft3 0x200 right x+15 yp w40 h20, 0/200
Gui, Add, Hotkey, xm y+5 w140 h20 vHot3, %Hot3%
Gui, Add, Text, gSaveFile vSave4 border 0x200 center xp yp+35 w40 h20, Save 4
Gui, Add, Text, gToggleLock vToggleLock4 border 0x200 center x+5 yp w40 h20, Lock
Gui, Add, Text, vCharLeft4 0x200 right x+15 yp w40 h20, 0/200
Gui, Add, Hotkey, xm y+5 w140 h20 vHot4, %Hot4%
Gui, Add, Text, gSaveFile vSave5 border 0x200 center xp yp+35 w40 h20, Save 5
Gui, Add, Text, gToggleLock vToggleLock5 border 0x200 center x+5 yp w40 h20, Lock
Gui, Add, Text, vCharLeft5 0x200 right x+15 yp w40 h20, 0/200
Gui, Add, Hotkey, xm y+5 w140 h20 vHot5, %Hot5%
Gui, Add, Text, gSaveFile vSave6 border 0x200 center xp yp+35 w40 h20, Save 6
Gui, Add, Text, gToggleLock vToggleLock6 border 0x200 center x+5 yp w40 h20, Lock
Gui, Add, Text, vCharLeft6 0x200 right x+15 yp w40 h20, 0/200
Gui, Add, Hotkey, xm y+5 w140 h20 vHot6, %Hot6%
Gui, Add, Text, gSaveFile vSave7 border 0x200 center xp yp+35 w40 h20, Save 7
Gui, Add, Text, gToggleLock vToggleLock7 border 0x200 center x+5 yp w40 h20, Lock
Gui, Add, Text, vCharLeft7 0x200 right x+15 yp w40 h20, 0/200
Gui, Add, Hotkey, xm y+5 w140 h20 vHot7, %Hot7%
Gui, Add, Text, gSaveFile vSave8 border 0x200 center xp yp+35 w40 h20, Save 8
Gui, Add, Text, gToggleLock vToggleLock8 border 0x200 center x+5 yp w40 h20, Lock
Gui, Add, Text, vCharLeft8 0x200 right x+15 yp w40 h20, 0/200
Gui, Add, Hotkey, xm y+5 w140 h20 vHot8, %Hot8%
Gui, Add, Text, gSaveFile vSave9 border 0x200 center xp yp+35 w40 h20, Save 9
Gui, Add, Text, gToggleLock vToggleLock9 border 0x200 center x+5 yp w40 h20, Lock
Gui, Add, Text, vCharLeft9 0x200 right x+15 yp w40 h20, 0/200
Gui, Add, Hotkey, xm y+5 w140 h20 vHot9, %Hot9%
Gui, Add, Text, gSaveFile vSave0 border 0x200 center xp yp+35 w40 h20, Save 0
Gui, Add, Text, gToggleLock vToggleLock0 border 0x200 center x+5 yp w40 h20, Lock
Gui, Add, Text, vCharLeft0 0x200 right x+15 yp w40 h20, 0/200
Gui, Add, Hotkey, xm y+5 w140 h20 vHot0, %Hot0%
Gui, Add, Edit, -WantReturn -VScroll +limit200 x157 y105 w351 r4 gUpdateCharLeft vText1, %Text1%
Gui, Add, Edit, -WantReturn -VScroll +limit200 xp y+p w351 r4 gUpdateCharLeft vText2, %Text2%
Gui, Add, Edit, -WantReturn -VScroll +limit200 xp y+p w351 r4 gUpdateCharLeft vText3, %Text3%
Gui, Add, Edit, -WantReturn -VScroll +limit200 xp y+p w351 r4 gUpdateCharLeft vText4, %Text4%
Gui, Add, Edit, -WantReturn -VScroll +limit200 xp y+p w351 r4 gUpdateCharLeft vText5, %Text5%
Gui, Add, Edit, -WantReturn -VScroll +limit200 xp y+p w351 r4 gUpdateCharLeft vText6, %Text6%
Gui, Add, Edit, -WantReturn -VScroll +limit200 xp y+p w351 r4 gUpdateCharLeft vText7, %Text7%
Gui, Add, Edit, -WantReturn -VScroll +limit200 xp y+p w351 r4 gUpdateCharLeft vText8, %Text8%
Gui, Add, Edit, -WantReturn -VScroll +limit200 xp y+p w351 r4 gUpdateCharLeft vText9, %Text9%
Gui, Add, Edit, -WantReturn -VScroll +limit200 xp y+p w351 r4 gUpdateCharLeft vText0, %Text0%

Switch LanguageSelect
{
Case "da-DK":
	GuiControl,,LanguageSelectDA,1
Case "en-US":
    GuiControl,,LanguageSelectUS,1
Case "en-GB":
    GuiControl,,LanguageSelectGB,1
Case "en-AU":
    GuiControl,,LanguageSelectAU,1
Case "en-IN":
    GuiControl,,LanguageSelectIN,1
}
GuiControl, ChooseString, Profile, %Profile%
UpdateUI(LanguageSelect, InitConfigPath)
Gui, Show
return

;Minimize Program
GuiMinimize:
WinMinimize, A
return

;Quit Program
GuiEscape:
GuiClose:
ExitApp
return

;Update UI
SetLanguage:
Gui, Submit, NoHide
ControlGet, list, List,, ComboBox1
if(A_GuiControl = "Profile")
{
	If !Instr("`n" list "`n", "`n" Profile "`n")
	{
		Return
	}
}

UpdateUI(LanguageSelect, InitConfigPath)

RestartStatus := True

if(RestartStatus)
{
	Reload
}
Return


;Update Profile List (Default is blocked from action)
UpdateProfile:
UpdateProfileList(ProfileList, Profile, InitConfigPath)
Return

UpdateCharLeft:
	UpdateCharLeft(A_GuiControl)
return

;Calculate and display th echaracters left for a message
CalcCharLeft:
Gui, Submit, NoHide
StringLen, Length, TtsInput
GuiControl, Text, CharLeft, %Length%/200
IniWrite, %TtsInput%, %InitConfigPath%, DEFAULTS, LastMsg
return

;Drag move using fake title bar
uiMove:
PostMessage, 0xA1, 2,,, A
Return

;ToggleUI Elements locked state
ToggleLock:
Switch A_GuiControl
{
Case "ToggleLock1":
    BtnID := "1"
Case "ToggleLock2":
    BtnID := "2"
Case "ToggleLock3":
    BtnID := "3"
Case "ToggleLock4":
    BtnID := "4"
Case "ToggleLock5":
    BtnID := "5"
Case "ToggleLock6":
    BtnID := "6"
Case "ToggleLock7":
    BtnID := "7"
Case "ToggleLock8":
    BtnID := "8"
Case "ToggleLock9":
    BtnID := "9"
Case "ToggleLock0":
    BtnID := "0"
}

If(Lck%BtnID% = "Enabled")
{
	Lck%BtnID% = Disabled
	UpdateUI(LanguageSelect, InitConfigPath)
	GuiControl, Text, ToggleLock%BtnID%, Unlock
	IniWrite, Disable, %ConfigPath%, %LanguageSelect%, Save%BtnID%L
} else {
	Lck%BtnID% = Enabled
	UpdateUI(LanguageSelect, InitConfigPath)
	GuiControl, Text, ToggleLock%BtnID%, Lock
	IniWrite, Enabled, %ConfigPath%, %LanguageSelect%, Save%BtnID%L
}
return

;Save TTS
SaveFile:
Gui, Submit, NoHide

Switch A_GuiControl
{
Case "Save1":
    BtnID := "1"
Case "Save2":
    BtnID := "2"
Case "Save3":
    BtnID := "3"
Case "Save4":
    BtnID := "4"
Case "Save5":
    BtnID := "5"
Case "Save6":
    BtnID := "6"
Case "Save7":
    BtnID := "7"
Case "Save8":
    BtnID := "8"
Case "Save9":
    BtnID := "9"
Case "Save0":
    BtnID := "0"
}

if(Hot%BtnID% = "")
{
	MsgBox, 262452,, Would you like to delete this hotkey and TTS for %LanguageSelect%? (press Yes or No)
	IfMsgBox Yes
	{
		FileDelete, ttssound\%Profile%\%LanguageSelect%\%BtnID%.mp3
		IniWrite, %A_Space%, %ConfigPath%, %LanguageSelect%, Save%BtnID%T
		IniWrite, % Hot%BtnID%, %ConfigPath%, %LanguageSelect%, Save%BtnID%H
		IniWrite, Enabled, %ConfigPath%, %LanguageSelect%, Save%BtnID%L
		Reload
	}
} else {
	if(Text%BtnID% != "")
	{
		IniWrite, % Text%BtnID%, %ConfigPath%, %LanguageSelect%, Save%BtnID%T
		IniWrite, % Hot%BtnID%, %ConfigPath%, %LanguageSelect%, Save%BtnID%H
		DownloadAudio(LanguageSelect, Profile, BtnID, Text%BtnID%)
		Reload
	} else if(TtsInput != "")
	{
		IniWrite, %TtsInput%, %ConfigPath%, %LanguageSelect%, Save%BtnID%T
		IniWrite, % Hot%BtnID%, %ConfigPath%, %LanguageSelect%, Save%BtnID%H
		DownloadAudio(LanguageSelect, Profile, BtnID, TtsInput)
		Reload
	} else if(Text%BtnID% = "") and (TtsInput = "")
	{
		IniWrite, "", %ConfigPath%, %LanguageSelect%, Save%BtnID%T
		IniWrite, % Hot%BtnID%, %ConfigPath%, %LanguageSelect%, Save%BtnID%H
		UpdID := SubStr(A_GuiControl, 5, 1)
		FileDelete, ttssound\%Profile%\%LanguageSelect%\%UpdID%.mp3
		Reload
	}
}
return

;Playback
PlayTTS:
Gui, Submit, NoHide

If (TtsInput != OldTtsInput) || (OldLangSel != LanguageSelect)
{
	DownloadAudio(LanguageSelect, "Default", "translate_tts", TtsInput)
}

OldLangSel := LanguageSelect
OldTtsInput := TtsInput
SoundPlay, ttssound\%Profile%\%LanguageSelect%\translate_tts.mp3
return

;Basic Hotkeys GoSub
DynamicPlayAudio1:
	SoundPlay, ttssound\%Profile%\%LanguageSelect%\1.mp3
return
DynamicPlayAudio2:
	SoundPlay, ttssound\%Profile%\%LanguageSelect%\2.mp3
return
DynamicPlayAudio3:
	SoundPlay, ttssound\%Profile%\%LanguageSelect%\3.mp3
return
DynamicPlayAudio4:
	SoundPlay, ttssound\%Profile%\%LanguageSelect%\4.mp3
return
DynamicPlayAudio5:
	SoundPlay, ttssound\%Profile%\%LanguageSelect%\5.mp3
return
DynamicPlayAudio6:
	SoundPlay, ttssound\%Profile%\%LanguageSelect%\6.mp3
return
DynamicPlayAudio7:
	SoundPlay, ttssound\%Profile%\%LanguageSelect%\7.mp3
return
DynamicPlayAudio8:
	SoundPlay, ttssound\%Profile%\%LanguageSelect%\8.mp3
return
DynamicPlayAudio9:
	SoundPlay, ttssound\%Profile%\%LanguageSelect%\9.mp3
return
DynamicPlayAudio0:
	SoundPlay, ttssound\%Profile%\%LanguageSelect%\0.mp3
return

;Random Functions / GoTo's
LC_UriEncode(Uri, RE="[0-9A-Za-z]")
{
	VarSetCapacity(Var, StrPut(Uri, "UTF-8"), 0), StrPut(Uri, &Var, "UTF-8")
	While Code := NumGet(Var, A_Index - 1, "UChar")
		Res .= (Chr:=Chr(Code)) ~= RE ? Chr : Format("%{:02X}", Code)
	Return, Res
}

;Read config file and create it if it doesn't exist
ReadConfig(ByRef ConfigPath, ByRef LanguageSelect:="da-DK")
{
	global
	if !FileExist(ConfigPath)
	{
		FileAppend,
		(
[DEFAULTS]
LangSel=%LanguageSelect%
VolSel=0
		), %ConfigPath%
	}
	loop, 10
	{
		index := A_Index-1
		IniRead, Text%index%, %ConfigPath%, %LanguageSelect%, Save%index%T
		if(Text%index% = "ERROR")
		{
			IniWrite, "", %ConfigPath%, %LanguageSelect%, Save%index%T
			IniRead, Text%index%, %ConfigPath%, %LanguageSelect%, Save%index%T
		}
		IniRead, Hot%index%, %ConfigPath%, %LanguageSelect%, Save%index%H
		if(Hot%index% = "ERROR")
		{
			IniWrite, "", %ConfigPath%, %LanguageSelect%, Save%index%H
			IniRead, Hot%index%, %ConfigPath%, %LanguageSelect%, Save%index%H
		}
		IniRead, Lck%index%, %ConfigPath%, %LanguageSelect%, Save%index%L
		if(Lck%index% = "ERROR")
		{
			IniWrite, Enabled, %ConfigPath%, %LanguageSelect%, Save%index%L
			IniRead, Lck%index%, %ConfigPath%, %LanguageSelect%, Save%index%L
		}
	}
	return
}

;Update the GUI with new data
UpdateUI(ByRef LanguageSelect:="da-DK", ByRef InitConfigPath:="ttssound\ini_Config.ini")
{
	;Set UI for language selection
	Gui, Submit, NoHide
	Switch A_GuiControl
	{
	Case "LanguageSelectDA":
		LanguageSelect := "da-DK"
	Case "LanguageSelectUS":
		LanguageSelect := "en-US"
	Case "LanguageSelectGB":
		LanguageSelect := "en-GB"
	Case "LanguageSelectAU":
		LanguageSelect := "en-AU"
	Case "LanguageSelectIN":
		LanguageSelect := "en-IN"
	Case "Profile":
		IniWrite, %Profile%, %InitConfigPath%, DEFAULTS, ProfSel
	}
	IniWrite, %LanguageSelect%, %InitConfigPath%, DEFAULTS, LangSel


	loop, 10
	{
		index := A_Index-1
		if(Text%index% != "")
		{
			ControlName = Text%index%
			UpdateCharLeft(ControlName)
		}

	}

	;Set lock state and text for Text Input, Hotkey input and Save button
	loop, 10
	{
		index := A_Index-1
		GuiControl, Text, Text%index%, % Text%index%
		GuiControl,, Hot%index%, % Hot%index%
		GuiControl, % Lck%index%, Save%index%
		GuiControl, % Lck%index%, Hot%index%
		GuiControl, % Lck%index%, Text%index%
		if(Lck%index% = "Enabled")
		{
			GuiControl, Text, ToggleLock%index%, Lock
		} else {
			GuiControl, Text, ToggleLock%index%, Unlock
		}
	}
}

;Change Char Left For Input
UpdateCharLeft(InputControlID)
{
	Gui, Submit, NoHide
	UpdID := SubStr(InputControlID, 5, 1)
	StrTest := % %InputControlID%
	StringLen, Length, % %InputControlID%
	GuiControl, Text, CharLeft%UpdID%, %Length%/200
}

;Update the hotkeys used (also run when changing language or do a reload)
GenerateHotkeys()
{
	global
	loop, 10
	{
		local index := A_Index-1
		local HK := % Hot%index%
		if(HK != "")
		{
			Hotkey, % Hot%index%, DynamicPlayAudio%index%, On
		} else {
			Try
			{
				Hotkey, % Hot%index%, Off
			}
		}
	}
	return
}

;Download audio file from google TTS service
DownloadAudio(ByRef LanguageSelect:="da-DK", ByRef Profile:="Default", FileName:="translate_tts", TextInput:="")
{
	FileDelete, ttssound\%Profile%\%LanguageSelect%\%FileName%.mp3
	StringLen, GetLength, TextInput
	GoToURL := "https://translate.google.com/translate_tts?ie=UTF-8&total=1&idx=0&textlen=" GetLength "&client=tw-ob&q=" LC_UriEncode(TextInput) "&tl=" LanguageSelect
	UrlDownloadToFile, %GoToURL%, ttssound\%Profile%\%LanguageSelect%\%FileName%.mp3
	return
}

;Add or remove profile from list and delete profile folder
UpdateProfileList(ByRef ProfileList, ByRef Profile, ByRef InitConfigPath)
{
	global
	Gui, Submit, NoHide
	If(Profile != "Default") and (Profile != "")
	{
		Switch A_GuiControl
		{
		Case "ADD":
			local count :=0
			Loop, Parse, ProfileList, | ;Loop over each item in the list.
			{
				if(A_LoopField = Profile)
				{
					count++
				}
			}
			if(count = 0)
			{
				ProfileList .= "|" . Profile
				FileCreateDir, ttssound\%Profile%\da-DK
				FileCreateDir, ttssound\%Profile%\en-US
				FileCreateDir, ttssound\%Profile%\en-GB
				FileCreateDir, ttssound\%Profile%\en-AU
				FileCreateDir, ttssound\%Profile%\en-IN
				IniWrite, %Profile%, %InitConfigPath%, DEFAULTS, ProfSel
				GuiControl,, Profile, %Profile%
				ConfigPath = ttssound\%Profile%\%LanguageSelect%\TTS_Config.ini
				ReadConfig(ConfigPath, LanguageSelect)
				UpdateUI(LanguageSelect, InitConfigPath)
			}
			IniWrite, %ProfileList%, %InitConfigPath%, DEFAULTS, ProfList
			reload
		Case "DEL":
			MsgBox, 262452,, Would you like to delete this profile and every TTS binded to it? (press Yes or No)
			IfMsgBox Yes
			{
				local Temp =
				Loop, Parse, ProfileList, | ;Loop over each item in the list.
				{
					If !A_LoopField Or (A_LoopField = Profile) Or (A_LoopField = "Default") ;If this is the item you want to delete (or if it's blank), skip it.
					{
						if(A_LoopField = Profile)
						{
							FileRemoveDir, ttssound\%Profile%, 1
						}
					} else {
						Temp .= "|" . A_LoopField ;Put all the other items back into a list.
					}
				}
				ProfileList := "Default" Temp
				GuiControl,, Profile, |%ProfileList%
				IniWrite, Default, %InitConfigPath%, DEFAULTS, ProfSel
				GuiControl, ChooseString, Profile, Default
				IniWrite, %ProfileList%, %InitConfigPath%, DEFAULTS, ProfList
				reload
			}
		}
	}
}