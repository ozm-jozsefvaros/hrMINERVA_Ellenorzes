'E gy�tem�nyben, ha az MIT licencia eml�ttettik, (megjel�lve a szerz�t �s a m� sz�let�s�nek �v�t) azon az al�bbi felhaszn�l�si enged�lyt kell �rteni:

'Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"),
'to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software,
'and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
'The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
'THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
'FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
'WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
Option Compare Database

Private Sub Oszlopok�tnevez�se(rng As Object)
    Dim cell As Object
    Dim dict As Object
    Dim key As Variant
    Dim count As Long
    
    ' Create a dictionary to store counts of each value
    Set dict = CreateObject("Scripting.Dictionary")
    
    ' Loop through each cell in the range
    For Each cell In rng
        ' Check if the value is already in the dictionary
        If dict.Exists(cell.Value) Then
            ' Increment count and concatenate the value
            count = count + 1
            'Debug.Print cell.Value
            cell.Value = cell.Value & count
        Else
            ' Add the value to the dictionary with count as 1
            dict.Add cell.Value, 1
        End If
    Next cell
End Sub
Sub UresOszlopokTorlese(ByVal strF�jln�v�tvonallal As String, Optional ByVal strT�blaN�v As String = "tSzem�lyek", Optional ByVal bAd�jelKellE As Boolean = True, Optional ByVal bT�r�lniKellE As Boolean = True, Optional ByVal kezd�cella As String = vbNullString)
'#####################################################################################################
'#
'#  A szem�lyt�rzs t�bl�ban kit�rli az �res (adatot nem tartalmaz�) oszlopokat,
'#  majd az els� oszlop el� besz�r egy oszlopot, ami az ad�jelet tartalmazza majd sz�m-k�nt t�rolva,
'#  az eg�sz t�bl�t elnevezi tSzem�lyek n�ven.
'#
'#####################################################################################################
    On Error GoTo Hiba
    
    Dim xlApp As Excel.Application
    Dim xlWB As Excel.Workbook
    Dim iCol As Long
    Dim ehj As New ehjoszt
    Dim lap As Excel.Worksheet
    Dim sor As Long
    Dim ezaSor As Long
    Dim ter�let As Range
    Dim torolt As Boolean
    Dim fejl�c As Range
    
    Set xlApp = New Excel.Application
    xlApp.DisplayAlerts = False
    Set xlWB = xlApp.Workbooks.Open(strF�jln�v�tvonallal)
    Set lap = xlWB.Sheets(1)
    Debug.Print lap.Name

    If bT�r�lniKellE Then
        With lap.UsedRange
            ehj.Ini (100)
            ehj.oszlopszam = .Columns.count
            For iCol = ehj.oszlopszam To 1 Step -1  '.Columns.Count
                If iCol Mod 10 = 0 Then: Debug.Print iCol & ",";
                ezaSor = lap.Cells(lap.Rows.count, iCol).End(xlUp).row
                
                torolt = False
                If ezaSor < 3 Then
                    Debug.Print ezaSor & ",";
                    lap.Columns(iCol).EntireColumn.Delete
                    torolt = True
                    Debug.Print torolt
                End If
                Debug.Print ".";
                ehj.Novel
            Next
            sor = .Rows.count
        End With
    End If
    'Ad�jel besz�r�sa
    If bAd�jelKellE Then
        If lap.Range("A2").Value <> "Ad�jel" Then
            lap.Range("A1").EntireColumn.Insert
        End If
        'Biztos, ami biztos, az Ad�jel-et �s a k�pletet beillesztj�k akkor is, ha m�r ott van...
        Set ter�let = lap.Range("A3:A" & sor + 1) 'Hogy az utols� sor ne maradjon ki
        lap.Range("A2").Value = "Ad�jel"
        ter�let.Formula = "=J3*1"
    End If 'bAd�jelKellE
    With lap
        Set fejl�c = .Range(.Cells(2, 1), .Cells(2, .UsedRange.Columns.count))
    End With
    Call Oszlopok�tnevez�se(fejl�c)
    
    'Elnevezz�k a teljes t�bl�t
    If strT�blaN�v <> "" Then
        If kezd�cella = vbNullString Then
             xlWB.Names.Add Name:=strT�blaN�v, RefersTo:=lap.UsedRange
            ' Debug.Print ImportT�blaHibaJav�t�(lap.UsedRange)
        Else
            Dim uOszlop, uSor As Long
            Dim kCella As Range
            
            Set kCella = lap.Range(kezd�cella)
            uOszlop = kCella.CurrentRegion.Columns.count
            uSor = kCella.CurrentRegion.Rows.count
            
            xlWB.Names.Add Name:=strT�blaN�v, RefersTo:=kCella.Resize(uSor, uOszlop)
        End If
    End If
    
    xlWB.Save
    xlWB.Close
    xlApp.Quit
    
    Set lap = Nothing
    Set xlWB = Nothing
    Set xlApp = Nothing
    
    Exit Sub
   
Hiba:
    If Err.Number = 1004 Then
        strF�jln�v�tvonallal = Replace(strF�jln�v�tvonallal, ".xlsx", "") & CStr(CLng(Timer)) & ".xlsx"
        xlWB.SaveAs strF�jln�v�tvonallal
        Resume Next
    End If
    MsgBox "Error: " & Err.Description, vbExclamation + vbOKOnly, "Error"
End Sub
Public Sub CloseAllExcel()
    Dim obj As Object
    On Error GoTo ExitSub
    Dim i As Integer
    'There shouldn't be more than 10000 running Excel applications
    'Can use While True too, but small risk of infinite loop
    For i = 0 To 10000
        Set obj = GetObject(, "Excel.Application")
        obj.Quit
    Next i
ExitSub:
End Sub
Sub MegnyitMentBez�r(ByVal f�jlN�v�tv As String)
    Dim ojExcel As Object
    Dim ojWB As Object
    
    Set ojExcel = CreateObject("Excel.Application")
    Set ojWB = ojExcel.Workbooks.Open(f�jlN�v�tv, ReadOnly:=False, IgnoreReadOnlyRecommended:=True, Editable:=True, Notify:=False)
    ojWB.Save
    ojWB.Close
    ojExcel.Quit
    Set ojWB = Nothing
    Set ojExcel = Nothing
    
End Sub