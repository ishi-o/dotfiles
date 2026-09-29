Set sh = CreateObject("WScript.Shell")
If WScript.Arguments.Count <> 1 Then
  WScript.Quit 1
End If
Select Case LCase(WScript.Arguments(0))
  Case "h"
    sh.SendKeys "%+{LEFT}"
  Case "j"
    sh.SendKeys "%+{DOWN}"
  Case "k"
    sh.SendKeys "%+{UP}"
  Case "l"
    sh.SendKeys "%+{RIGHT}"
  Case Else
    WScript.Quit 1
End Select
