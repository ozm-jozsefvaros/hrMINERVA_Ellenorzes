'E gy�tem�nyben, ha az MIT licencia eml�ttettik, (megjel�lve a szerz�t �s a m� sz�let�s�nek �v�t) azon az al�bbi felhaszn�l�si enged�lyt kell �rteni:

'Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"),
'to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software,
'and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
'The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
'THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
'FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
'WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
Option Explicit
Option Compare Database
Sub F�jlV�laszt�(Sz�vegMez� As TextBox, Felirat As String, Optional Munkak�nyvt�r As String = "", Optional f�jln�v As String = "", Optional f�jlt�pus As String = "")
'Open file ablakot nyit meg Felirat felirattal, s a kiv�lasztott �rt�ket a Sz�vegMez� beviteli mez�be teszi.
'Meg lehet adni kezd� mapp�t, vagy ak�r az alap�rtelmezetten megjelen� �llom�nyok neveit is helykit�lt�kkel (* �s ?)
'Meg lehet adni a f�jlt�pusok list�j�t, ha �res (vagy hi�nyzik) akkor *.xls �s *.* az alap�rtelmezett
'Ezt megh�vj�k az al�bbi elj�r�sok:
'   Havi_Click
'   Szervezeti_Click
'   Szem�lyt�rzs_Click

    Dim fDialog As Office.FileDialog
    Dim varFile As Variant
    Dim i, n As Integer
    
    If Sz�vegMez�.Value <> "" Then 'Ha m�r van kiv�lasztott �tvonal a mez�ben,
        If Right(Sz�vegMez�.Value, 1) = "\" Or InStr(1, Utols�(Sz�vegMez�.Value, "\"), ".") = 0 Then '�s az egy k�nyvt�rra mutat, (mert \ jelre v�gz�dik vagy az utols� \ jel ut�n ".")
            Munkak�nyvt�r = Sz�vegMez�.Value 'akkor ez lesz a munkak�nyvt�r
        Else 'de ha egy f�jlra mutat,
            Munkak�nyvt�r = Replace(Sz�vegMez�.Value, Utols�(Sz�vegMez�.Value, "\"), "") 'akkor a f�jln�v r�szt csonkoljuk, s a marad�kot haszn�ljuk...
        End If
    End If ' egy�bk�nt pedig a param�terk�nt (Munkak�nyvt�r) megadott �tvonal lesz a bar�tunk.

    Set fDialog = Application.FileDialog(msoFileDialogFilePicker)
 
    With fDialog
 
      .AllowMultiSelect = False
             
      .Title = Felirat
 
      .Filters.Clear
      If f�jlt�pus = "" Then
        '.Filters.Add "MsExcel t�bla", "*.XLS*"
        '.Filters.Add "Minden fajta", "*.*"
        f�jlt�pus = "*.XSL*,*.*"
      End If
      n = StrCount(f�jlt�pus, ",") + 1
      For i = 1 To n
        .Filters.Add ffsplit(f�jlt�pus, i), ffsplit(f�jlt�pus, i)
      Next i
      If Right(Munkak�nyvt�r, 1) <> "\" Then
        Munkak�nyvt�r = Munkak�nyvt�r & "\"
      End If
      .InitialFileName = Munkak�nyvt�r & f�jln�v 'Hol ny�ljon meg
 
      If .Show = True Then
 
         For Each varFile In .SelectedItems
            Sz�vegMez�.Value = varFile
         Next
 
      End If
   End With
End Sub
Sub MappaV�laszt�(Sz�vegMez� As TextBox, Felirat As String, Optional Munkak�nyvt�r As String = "")
'Open k�nyvt�r ablakot nyit meg Felirat felirattal, s a kiv�lasztott �rt�ket a Sz�vegMez� beviteli mez�be teszi.
'Meg lehet adni kezd� mapp�t, vagy ak�r az alap�rtelmezetten megjelen� �llom�nyok neveit is helykit�lt�kkel (* �s ?)
'Ezt megh�vj�k az al�bbi elj�r�sok:
'   Kiemenet_Click()

    Dim fDialog As Office.FileDialog
    Dim varFile As Variant
 
    Sz�vegMez�.Value = ""

    Set fDialog = Application.FileDialog(msoFileDialogFolderPicker)
 
    With fDialog
 
      .AllowMultiSelect = False
             
      .Title = Felirat
 
      .Filters.Clear

      If Right(Munkak�nyvt�r, 1) <> "\" Then
        Munkak�nyvt�r = Munkak�nyvt�r & "\"
      End If
      .InitialFileName = Munkak�nyvt�r  'Hol ny�ljon meg
 
      If .Show = True Then
            For Each varFile In .SelectedItems
                Sz�vegMez�.Value = varFile
            Next
            If Sz�vegMez�.Value = "" Then
                Sz�vegMez�.Value = Munkak�nyvt�r
            End If
       End If
   End With
End Sub
Public Sub HaviT�blaImport(f�jln�v As String, �rlap As Object)
Dim a As Boolean
    �rlap.Folyamat.RowSource = ""
    a = fvHaviT�blaImport(f�jln�v, �rlap)
End Sub

Public Function fvHaviT�blaImport(ByVal f�jln�v As String, ByRef �rlap As Object, Optional ByVal lnCsoport As Long = 1) As Boolean
fvbe ("fvHaviT�blaImport")
'Licencia: MIT Ol�h Zolt�n 2022 (c)
    'Az Excel megnyit�s�hoz
    Dim objExcel        As Excel.Application
    Dim objBook         As Excel.Workbook
    Dim objSheet        As Excel.Worksheet
    Dim objRange        As Excel.Range
    
    Dim accT�bla         As String
    Dim xlT�blaEred     As String
    Dim xlV�gcella      As String
    
    Dim xlUtols�Oszlop  As String
    Dim intV�gcella     As Integer
    Dim xlHosszm�r�     As String
    
    Dim �rt�kek()       As Variant
    Dim intMez�         As Integer
    
    'Az adatb�zis megnyit�s�hoz
    Dim db              As DAO.Database     'Ez lesz az adatb�zisunk
    Dim strH�tt�rDb        As String     'Ez a h�tt�radatb�zis, ahol a t�bl�k laknak
    Dim rs              As DAO.Recordset    'A beolvasand� lapok �s ter�letek adatait tartalmaz� t�bl�nak
    Dim rsC�l           As DAO.Recordset    'Ahov� m�solunk
    Dim f�jl            As String
    
    Dim Eredm�ny        As Integer
    Dim t�bla           As String           'A t�bla : a t�bl�k jellemz�it t�rol� t�bla
    
    'A sz�veges kimenethez
    Dim �zenet As String
    
    'Sz�ml�l�shoz
    Dim sor As Integer, oszlop As Integer
    
    t�bla = "tImport�land�T�bl�k"
    strH�tt�rDb = "L:\Ugyintezok\Adatszolg�ltat�k\Adatb�zisok\H�tt�rt�rak\Ellen�rz�s_0.9.6_h�tt�r_.mdb.accdb"
    intV�gcella = 0
'On Error GoTo hiba
    
    Set objExcel = CreateObject("Excel.Application")
    Set db = CurrentDb()
    'Set h�tt�rdb =
    ' ha az �tvonal v�g�n nincs \, akkor hozz�f�zz�k, [de ha van, akkor meg nem :)]
    f�jl = f�jln�v
    ' megnyitjuk az Excel t�bl�t
    Set objBook = objExcel.Workbooks.Open(f�jl, ReadOnly:=True, IgnoreReadOnlyRecommended:=True, Editable:=False, Notify:=False)
    logba "Beolvasott �llom�ny:", f�jln�v, 2
    Set rs = db.OpenRecordset(t�bla)
    
        If lnCsoport = 1 Then 'Havi l�tsz�mjelent�s t�bla...
            xlT�blaEred = "Fedlap"
            Set objSheet = objBook.Worksheets(xlT�blaEred)
            objSheet.Select ' R�ugrunk a lapra
            Dim rHJH As DAO.Recordset
            Dim hat�lyID As Long
            
            Set rHJH = db.OpenRecordset("tHaviJelent�sHat�lya", dbOpenDynaset)
            rHJH.AddNew
            rHJH!hat�lya = objSheet.Range("a2").Value
            rHJH!f�jln�v = f�jl
            rHJH.Update
            
            rHJH.Bookmark = rHJH.LastModified
            hat�lyID = rHJH!hat�lyaID
            rHJH.Close
            Set rHJH = Nothing
        End If
    Do Until rs.EOF
        Erase �rt�kek
        If rs("Csoport") = lnCsoport Then
            
            accT�bla = rs("AccessN�v")
            xlT�blaEred = rs("EredetiN�v"): 'Debug.Print xlT�blaEred & " -- " & accT�bla
            Set objSheet = objBook.Worksheets(xlT�blaEred)
            xlV�gcella = Nz(rs("V�gcella"), "")
            If xlV�gcella = "" Then
                xlHosszm�r� = rs("Hosszm�r�Cella")
                xlUtols�Oszlop = rs("Utols�Oszlop")
                intV�gcella = objSheet.Range(xlHosszm�r� & 1).Column
                xlV�gcella = objSheet.Cells(objSheet.Cells.Rows.count, intV�gcella).End(xlUp).row
                xlV�gcella = xlUtols�Oszlop & xlV�gcella
                logba , "hosszcella: " & xlHosszm�r� & ", utols� oszl.: " & xlUtols�Oszlop & ", V�gcella: " & xlV�gcella, 3
            End If
            
                If DCount("[Name]", "MSysObjects", "[Name] = '" & accT�bla & "'") = 1 Then
                        CurrentDb.Execute "DELETE FROM [" & accT�bla & "]", dbFailOnError

                    Else
                        CurrentDb.Execute "DELETE FROM [" & accT�bla & "_tart]", dbFailOnError
                        DoCmd.CopyObject strH�tt�rDb, accT�bla, acTable, accT�bla & "_tart"
                    End If
                If CsakSz�m(rs("Kezd�Cella")) < CsakSz�m(xlV�gcella) Then
                    With objSheet
                        .Range(.Range(rs("Kezd�Cella")), .Range(xlV�gcella)).Name = accT�bla 'Elnevezz�k a ter�letet
                        sFoly �rlap, accT�bla & ":;" & .Range(accT�bla).Rows.count
                        logba , .Range(accT�bla).Rows.count, 3
                    End With
                    
            
                    'Elkezdj�k az adatok bet�lt�s�t
                    Set rsC�l = db.OpenRecordset(accT�bla)
            
                    �rt�kek = objSheet.Range(accT�bla).Value
                    logba , "Az " & accT�bla & " ter�letr�l az adatokat beolvastuk."
                    logba , "A c�lt�bla:" & rsC�l.Name
            
                    For sor = LBound(�rt�kek, 1) To UBound(�rt�kek, 1)
                        intMez� = 0
                        '�j rekord hozz�ad�sa kezd�dik...
                        rsC�l.AddNew
                        For oszlop = LBound(�rt�kek, 2) To UBound(�rt�kek, 2)
                            If rsC�l.Fields.count < oszlop Then
                                Exit For
                            End If
                            intMez� = oszlop - 1
            
                            rsC�l.Fields(intMez�) = konverter(rsC�l.Fields(intMez�), �rt�kek(sor, oszlop))
                            
                        Next oszlop
                        rsC�l.Fields(oszlop - 1) = hat�lyID
                        rsC�l.Update
                        '�j rekord hozz�ad�sa v�get �rt
                    Next sor
                    logba , "Az " & accT�bla & " nev� t�bl�ba az adatokat be�rtuk:" & sor & " sor."
                    logba , "Az " & accT�bla & " beolvas�sa megt�rt�nt."
                Else
                    logba , "Az " & accT�bla & " nev� t�bl�ba nem �rtunk adatokat, mert �res volt."
                    logba , "Az " & accT�bla & " beolvas�sa megt�rt�nt."
                End If

        End If
        rs.MoveNext
        intV�gcella = 0
    Loop
    logba , objBook.Name & " bez�r�sa ment�s n�lk�l...", 3
    fvHaviT�blaImport = True
    GoTo Tiszt�t�s
fvki
Exit Function

Tiszt�t�s:
    On Error Resume Next
    
    If Not rs Is Nothing Then rs.Close: Set rs = Nothing
    If Not rsC�l Is Nothing Then rsC�l.Close: Set rsC�l = Nothing
    If Not rHJH Is Nothing Then rHJH.Close: Set rHJH = Nothing
    If Not db Is Nothing Then db.Close: Set db = Nothing

    If Not objBook Is Nothing Then
        objBook.Close SaveChanges:=False
        Set objBook = Nothing
    End If
    If Not objExcel Is Nothing Then objExcel.Quit: Set objExcel = Nothing
    
    On Error GoTo 0
fvki
Exit Function

Hiba:
    logba , Err.Number & Err.Description, 0
    Hiba Err
    fvHaviT�blaImport = False
    ' Objektumok felszabad�t�sa, ha eddig m�g nem t�rt�nt volna meg...
    Resume Tiszt�t�s
End Function

Public Function fvLej�r�Hat�rid�kImport(f�jln�v As String, �rlap As Object) As Boolean
fvbe ("fvLej�r�Hat�rid�kImport")
'Licencia: MIT Ol�h Zolt�n 2022 (c)
    'Az Excel megnyit�s�hoz
    Dim objExcel        As Excel.Application
    Dim objBook         As Excel.Workbook
    Dim objSheet        As Excel.Worksheet
    Dim objRange        As Excel.Range
    
    Dim xlT�bla         As String
    Dim xlT�blaEred     As String
    Dim xlV�gcella      As String
    
    Dim xlUtols�Oszlop  As String
    Dim intV�gcella     As Integer
    Dim xlHosszm�r�     As String
    
    Dim �rt�kek()       As Variant
    Dim intMez�         As Integer
    
    'Az adatb�zis megnyit�s�hoz
    Dim db              As DAO.Database     'Ez lesz az adatb�zisunk
    Dim rs              As DAO.Recordset    'A beolvasand� lapok �s ter�letek adatait tartalmaz� t�bl�nak
    Dim rsC�l           As DAO.Recordset    'Ahov� m�solunk
    Dim f�jl            As String
    
    Dim Eredm�ny        As Integer
    Dim t�bla           As String           'A t�bla : a t�bl�k jellemz�it t�rol� t�bla
    
    'Sz�ml�l�shoz
    Dim sor, oszlop As Integer
    
    t�bla = "tImport�land�T�bl�k"
    intV�gcella = 0
'On Error GoTo hiba
    
    Set objExcel = CreateObject("Excel.Application")
    Set db = CurrentDb()
    ' ha az �tvonal v�g�n nincs \, akkor hozz�f�zz�k, [de ha van, akkor meg nem :)]
    f�jl = f�jln�v
    ' megnyitjuk az Excel t�bl�t
    Set objBook = objExcel.Workbooks.Open(f�jl, ReadOnly:=True, IgnoreReadOnlyRecommended:=True, Editable:=False, Notify:=False)
    
    Set rs = db.OpenRecordset(t�bla)
    rs.MoveLast
    rs.MoveFirst
    sFoly �rlap, "T�bla neve;Beolvasott sorok sz�ma"
    
    Do Until rs.EOF
    
        Erase �rt�kek
        xlT�bla = rs("AccessN�v")
        
        If xlT�bla = "tLej�r�Hat�rid�k" Then
            xlT�blaEred = rs("EredetiN�v"): Debug.Print xlT�blaEred & " -- " & xlT�bla
            
            Set objSheet = objBook.Worksheets(xlT�blaEred)
            objSheet.Select ' R�ugrunk a lapra
            If Nz(rs("V�gcella"), "") = "" Then
                xlHosszm�r� = rs("Hosszm�r�Cella")
                xlUtols�Oszlop = rs("Utols�Oszlop")
                '
                ' rs("Hosszm�r�Cella") -- a hosszm�r�sre haszn�lt oszlopot keresi ki az adatb�zisb�l.
                ' objBook.ActiveSheet.Range(rs("Hosszm�r�Cella")&1).Column  -- a hosszm�r� cella oszlop�nak a sz�m�t adja meg.
                ' Cells(Rows.Count, 1).End(xlUp).Row -- az els� oszlopban tal�lhat� cell�k sz�m�t adja
                ' Cells(Rows.Count, ActiveSheet.Range(rs("Hosszm�r�Cella")&1).Column).End(xlUp).Row -- a hosszm�r� cella oszlop�ban a legals� haszn�lt cella sor�nak a sz�ma?
                intV�gcella = objSheet.Range(xlHosszm�r� & 1).Column
                xlV�gcella = objSheet.Cells(objSheet.Cells.Rows.count, intV�gcella).End(xlUp).row
                xlV�gcella = xlUtols�Oszlop & xlV�gcella
            Else
                xlV�gcella = rs("V�gcella")
            End If
            With objSheet
                .Range(.Range(rs("Kezd�Cella")), .Range(xlV�gcella)).Name = xlT�bla 'Elnevezz�k a ter�letet
                sFoly �rlap, xlT�bla & ":;" & .Range(xlT�bla).Rows.count
                Debug.Print .Range(xlT�bla).Rows.count
                
            End With
            
            
            If DCount("[Name]", "MSysObjects", "[Name] = '" & xlT�bla & "'") = 1 Then
                                    sFoly �rlap, xlT�bla & ":;t�bla t�rl�se"
                CurrentDb.Execute ("DELETE * FROM " & xlT�bla)
                                    sFoly �rlap, xlT�bla & ":;t�bla t�r�lve"
                'DoCmd.Rename xlT�bla & RIC(Now()), acTable, xlT�bla
            Else
                DoCmd.CopyObject , xlT�bla, acTable, xlT�bla & "_tart"
            End If
    
            'Elkezdj�k az adatok bet�lt�s�t
            Set rsC�l = db.OpenRecordset(xlT�bla)
    
            �rt�kek = objSheet.Range(xlT�bla).Value
            sFoly �rlap, "Az " & xlT�bla & " ter�letr�l az adatokat; beolvastuk."
            sFoly �rlap, "A c�lt�bla:;" & rsC�l.Name
    
            For sor = LBound(�rt�kek, 1) To UBound(�rt�kek, 1)
                
                    intMez� = 0
                    '�j rekord hozz�ad�sa kezd�dik...
                    rsC�l.AddNew
                    For oszlop = LBound(�rt�kek, 2) To UBound(�rt�kek, 2)
                        If rsC�l.Fields.count < oszlop Then
                            Exit For
                        End If
                        intMez� = oszlop - 1
                        'Debug.Print sor & ":" & oszlop & " = "
                        'Debug.Print �rt�kek(sor, oszlop)
                        'Debug.Print " Type:" & rsC�l.Fields(intMez�).Type
                    'On Error GoTo Hiba
                        rsC�l.Fields(intMez�) = konverter(rsC�l.Fields(intMez�), �rt�kek(sor, oszlop))
                    On Error GoTo 0
                        
                    Next oszlop
                    rsC�l.Update
                    '�j rekord hozz�ad�sa v�get �rt
                
            Next sor
            sFoly �rlap, "Az " & xlT�bla & " nev� t�bl�ba az adatokat be�rtuk:;" & sor & " sor."
            sFoly �rlap, "Az " & xlT�bla & " beolvas�sa megt�rt�nt."
        End If
        rs.MoveNext
        intV�gcella = 0

    Loop
    logba , objBook.Name & " bez�r�sa ment�s n�lk�l...", 3
    objBook.Close SaveChanges:=False
    
fvLej�r�Hat�rid�kImport = True
    logba sFN, "Sikerrel lefutott!"
fvki
Exit Function


Hiba:
    If Err.Number = 3759 Then
        logba sFN, "hiba sz�ma:" & 3759, 0
        Resume Next
    End If
logba sFN, Err.Number & ", " & Err.Description, 0
fvLej�r�Hat�rid�kImport = False

End Function

Public Function tT�blaImport(strF�jl As String, �rlap As Form, t�blan�v As String)
fvbe ("tT�blaImport")
On Error GoTo ErrorHandler

    Dim importSpecName As String
    Dim strHiba As String
'    Dim strXML As String
'    Dim strR�giF�jl As String
'    Dim str�jF�jl As String
'    Dim intKezdPoz As Integer
'    Dim intV�gPoz As Integer
    Dim �zenet As String
    Dim v�lasz As Boolean
    
    importSpecName = t�blan�v 'pl.:"tAdatv�ltoztat�siIg�nyek"

    If strF�jl <> "" Then

                                                   ' sFoly �rlap, importSpecName & ":; import�l�s �res oszlopok t�rl�se..."
       ' UresOszlopokTorlese strF�jl 'A megadott �llom�nyb�l t�r�lj�k az �res oszlopokat
'#           �t�rjuk az XML-t:
                                                    sFoly �rlap, importSpecName & ":; mentett import �talak�t�sa"
        v�lasz = XML�talak�t�(importSpecName, strF�jl)
        

                                                    sFoly �rlap, importSpecName & ":; import�l�s ind�t�sa"
'#           Az �t�rt XML-lel pedig futtatjuk a mentett importot
        DoCmd.RunSavedImportExport importSpecName
                                                    sFoly �rlap, importSpecName & ":; import�l�s v�get �rt"
                                                    sFoly �rlap, importSpecName & ":; " & DCount("*", t�blan�v) & " sor."
    End If
   tT�blaImport = True
    
Kil�p�s:
    fvki
    Exit Function

ErrorHandler:
    strHiba = "Error: " & Err.Number & " - " & Err.Description

    MsgBox strHiba, vbExclamation + vbOKOnly, "Error"
    logba , strHiba
    tT�blaImport = False
    Resume Kil�p�s
End Function


Public Function SzervezetiT�blaImport(f�jln�v As String, �rlap As Object) As Boolean
fvbe ("SzervezetiT�blaImport")
    'MIT Ol�h Zolt�n 2022
    'Az Excel megnyit�s�hoz
    Dim objExcel       As Excel.Application
    Dim objBook         As Excel.Workbook
    Dim objSheet        As Excel.Worksheet
    Dim objRange        As Excel.Range
    Dim objRange2       As Excel.Range
    
    Dim accT�bla         As String
    Dim xlT�blaEred     As String
    Dim xlV�gcella      As String
    
    Dim xlUtols�Oszlop  As Integer
    Dim intV�gcella     As Integer
    Dim xlHosszm�r�     As Integer
    
    Dim �rt�kek()       As Variant
    Dim intMez�         As Integer
    
    'Az adatb�zis megnyit�s�hoz
    Dim db              As DAO.Database     'Ez lesz az adatb�zisunk
    Dim rs              As DAO.Recordset    'A beolvasand� lapok �s ter�letek adatait tartalmaz� t�bl�nak
    Dim rsC�l           As DAO.Recordset    'Ahov� m�solunk
    Dim f�jl            As String
    Dim archf�jl        As String           'A r�gi f�jl archiv�l�s ut�ni neve
    
    Dim Eredm�ny        As Integer
    Dim t�bla           As String           'A t�bla : a t�bl�k jellemz�it t�rol� t�bla
    
    'A sz�veges kimenethez
    Dim �zenet As String
    
    'Sz�ml�l�shoz
    Dim sor, oszlop     As Integer
    Dim ehj             As New ehjoszt
    Dim el�z�szakasz    As Integer
    Dim SzakaszSz�m     As Integer
    
    
'On Error GoTo Hiba
    accT�bla = "tSzervezeti"
    xlT�blaEred = "Szervezeti alapriport"
    
    Set objExcel = CreateObject("Excel.Application")
    Set db = CurrentDb()
    ' ha az �tvonal v�g�n nincs \, akkor hozz�f�zz�k, [de ha van, akkor meg nem :)]
    f�jl = f�jln�v
    If Not (vane(f�jl)) Then 'Ha nincs ilyen f�jl, akkor kisz�llunk...
        SzervezetiT�blaImport = False
        sFoly �rlap, accT�bla & ":;f�jl nem tal�lhat�, �tugorjuk"
        Exit Function
    End If
    ' megnyitjuk az Excel t�bl�t
    Set objBook = objExcel.Workbooks.Open(f�jl, ReadOnly:=True, IgnoreReadOnlyRecommended:=True, Editable:=False, Notify:=False)
    


    Set rsC�l = Nothing

'Az import�land� ter�letet az objRange-be tessz�k
    Set objSheet = objBook.Worksheets(xlT�blaEred)
    objSheet.Activate
    
    Set objRange = objSheet.Range("A2").CurrentRegion
        xlUtols�Oszlop = objRange.Columns.count
        xlHosszm�r� = objRange.Rows.count

    With objRange
        Set objRange2 = .Range(.Cells(2, 1), objRange.Cells(xlHosszm�r�, xlUtols�Oszlop + 0))  'leszedj�k az els� sort
    End With
    sFoly �rlap, accT�bla & ":;" & xlHosszm�r� & " sor"
                'Debug.Print "Sorok sz�ma:" & xlHosszm�r� & ", oszlopok sz�ma:" & xlUtols�Oszlop
   
    Erase �rt�kek

    If DCount("[Name]", "MSysObjects", "[Name] = '" & accT�bla & "'") = 1 Then 'Ha van m�r accT�bla nev� t�bla, akkor
        archf�jl = accT�bla & RIC(Now())
        DoCmd.CopyObject , archf�jl, acTable, accT�bla 'k�sz�t�nk egy tartal�k m�solatot
        db.Execute ("Delete * From [" & accT�bla & "];") 'majd (az accT�bla t�bl�t) ki�r�tj�k
        sFoly �rlap, accT�bla & ":;Az el�z� t�bl�t " & archf�jl & " n�ven archiv�ltuk."
    End If
    
    ehj.Ini 100
    'Elkezdj�k az adatok bet�lt�s�t
    Set rsC�l = db.OpenRecordset(accT�bla)
    �rt�kek = objRange2.Value
    el�z�szakasz = 0
    SzakaszSz�m = 8 '12,5%-konk�nt jelezz�k ki az �rt�ket
    ehj.oszlopszam = UBound(�rt�kek, 1) - (LBound(�rt�kek, 1) + 1) 'Itt az oszlopsz�m a sorokat jel�li :)
    For sor = LBound(�rt�kek, 1) + 1 To UBound(�rt�kek, 1)
        intMez� = 0
        '�j rekord hozz�ad�sa kezd�dik...
        rsC�l.AddNew
        For oszlop = LBound(�rt�kek, 2) - 1 To UBound(�rt�kek, 2)
            intMez� = oszlop
            If intMez� <> 0 Then
                rsC�l.Fields(intMez�) = konverter(rsC�l.Fields(intMez�), �rt�kek(sor, oszlop))
                'Debug.Print intMez�, rsC�l.Fields(intMez�).Name & ": " & �rt�kek(1, oszlop) & " - " & rsC�l.Fields(intMez�)
            End If
 
        Next oszlop
        If Int(ehj.Value / ehj.oszlopszam * SzakaszSz�m) > el�z�szakasz Then
            sFoly �rlap, accT�bla & ":;" & Int(ehj.Value / ehj.oszlopszam * 100) & "% elk�sz�lt..."
            el�z�szakasz = Int(ehj.Value / ehj.oszlopszam * SzakaszSz�m)
        End If
        rsC�l.Update
        '�j rekord hozz�ad�sa v�get �rt
        'Debug.Print (sor / xlHosszm�r�) * 100 & "%"
        ehj.Novel
    Next sor
    SzervezetiT�blaImport = True 'Visszat�r�si �rt�ke Igaz, ha nincs hiba
    
Kil�p�s:
    
    rsC�l.Close
    Set objRange = Nothing
    Set objRange2 = Nothing
    Set objSheet = Nothing
    Set objBook = Nothing
    Set objExcel = Nothing
fvki
Exit Function

Hiba:

    Hiba Err
    SzervezetiT�blaImport = False 'Visszat�r�si �rt�ke Hamis, ha hiba t�rt�nt.
    Resume Kil�p�s
End Function



Function ImportT�blaHibaJav�t�(ter�let As Excel.Range) As Integer
    'A kapott t�bla (Excel.Range) fejl�c�ben megkeresi az azonos nev�eket, �s a m�sodikt�l kezdve az oszlop sz�m�t hozz�f�zi.
    'Mindek�zben a neveket trim-eli.
    'Ha hiba nem t�rt�nt:0 �rt�kkel t�r vissza, egy�bk�nt a hibak�ddal
fvbe ("ImportT�blaHibaJav�t�")
    On Error GoTo Hiba
    Dim intOszlopok     As Integer  'Az oszlopok sz�ma
    Dim i, n            As Integer  'Sz�ml�l�
    Dim varOszlopNevek  As Variant   'Az oszlopok nevei
    Dim intOszlopSz�m   As Integer  'Az oszlopok sz�ma
    Dim gy�jt           As Collection
    Dim n�v             As Variant
    
    intOszlopSz�m = ter�let.Columns.count
    ReDim varOszlopNevek(1, intOszlopSz�m)
    
    Set gy�jt = New Collection
    
    varOszlopNevek = ter�let.Rows(1)
    
    For i = LBound(varOszlopNevek, 2) To UBound(varOszlopNevek, 2) 'V�gig l�pked�nk az �sszes elemen
        n�v = varOszlopNevek(1, i)
        gy�jt.Add n�v, n�v
        '�s megk�s�relj�k betenni egy sz�t�rba. Ha van azonos, akkor hib�ra fut, s a hibakeres� hozz�f�zi az i-t �s �jra megpr�b�lja.
        'Debug.Print i, n�v
    Next i
    
    For n = 1 To gy�jt.count
        ter�let.Cells(1, n) = Trim(gy�jt(n)) 'Visszatessz�k, de egy�ttal levessz�k a felesleges sz�k�z�ket.
    Next n
    
    ImportT�blaHibaJav�t� = 0
fvki
Exit Function
Hiba:
    If Err.Number = 457 Then
        gy�jt.Add n�v & i, n�v & i
        logba , n�v & i, 0
        Resume Next
    End If
    ImportT�blaHibaJav�t� = Err.Number
    
End Function
Public Sub t�blagy�rt�(Optional ByVal SzervezetiLek As String = "lk_�tvil�g�t�s_mind_02", Optional ByVal AdatLek As String = "lk__�tvil�g�t�shoz_Szem�lyt�rzs_02")
'Licencia: MIT Ol�h Zolt�n 2022 (c)
Dim db As Database
Dim rst As Recordset
Dim qdf As QueryDef
Dim sql As String
Dim �rt�k As Variant
Dim a As Integer
sql = "Select Distinct [Szervezeti egys�g] From  [" & SzervezetiLek & "] WHERE [Szervezeti egys�g] not like '' "
Set db = CurrentDb()
Set rst = qdf.OpenRecordset(sql)
rst.MoveLast
rst.MoveFirst
Do Until rst.EOF
    �rt�k = rst.Fields("Szervezeti egys�g").Value
    'Debug.Print �rt�k
    Call Kimutat�s("O:\�tvil�g�t�s\�tvil�g�t�s2" & �rt�k & ".xlsx", "SELECT * FROM [" & AdatLek & "] WHERE [Szervezeti egys�g] = '" & �rt�k & "';")
    'Debug.Print "O:\�tvil�g�t�s\�tvil�g�t�s2" & �rt�k & ".xlsx"
    rst.MoveNext
Loop
End Sub
Public Sub Besz�mol�K�sz�t�()
'Licencia: MIT Ol�h Zolt�n 2022 (c)
Dim db As Database
Dim rst As Recordset
Dim sql As String
Dim �rt�k As Variant
Dim a As Integer
sql = "Select Distinct [Szervezeti egys�g] From  lk_�tvil�g�t�s_mind_02 WHERE [Szervezeti egys�g] not like '' "
Set db = CurrentDb()
Set rst = db.OpenRecordset(sql, dbOpenDynaset)
rst.MoveLast
rst.MoveFirst
Do Until rst.EOF
    �rt�k = rst.Fields("Szervezeti egys�g").Value
    'Debug.Print �rt�k
    Call Besz�mol�T�bla("O:\�tvil�g�t�s\�tvil�g�t�s2" & �rt�k & ".xlsx", "SELECT * FROM lk__�tvil�g�t�shoz_Szem�lyt�rzs_02 WHERE [Szervezeti egys�g] = '" & �rt�k & "';")
    'Debug.Print "O:\�tvil�g�t�s\�tvil�g�t�s2" & �rt�k & ".xlsx"
    rst.MoveNext
Loop
End Sub

Sub Besz�mol�T�bla(f�jl As String, lek�rdez�s As String)
'****** (c) Ol�h Zolt�n 2022 - MIT Licence ****************
 
 'Az adatb�zishoz
    Dim db          As Database
    Dim qdf         As QueryDef
    Dim rs          As DAO.Recordset
    Dim �rlapn�v    As String
    
    'Excelhez
    Dim sor, oszlop     As Long
    Dim oApp            As Excel.Application
    Dim oWb             As Workbook
    Dim oWs1, oWs2      As Worksheet
    Dim oWc             As Chart
    
    'A l�peget�shez
    Dim maxoszlop, maxsor As Long
    Dim adat As Variant
    Dim mez� As Field
    'Az el�rehalad�s-jelz�h�z

    
    'Alapadatok **********************************
    sor = 1
    oszlop = 1

    Set db = CurrentDb()
    'Set qdf = db.
    Set rs = db.OpenRecordset(lek�rdez�s)
    
    Set oApp = CreateObject("Excel.Application")
    Set oWb = oApp.Workbooks.Add
    Set oWs1 = oWb.Worksheets.Add
    Set oWs2 = oWb.Worksheets.Add(, oWs1)
    
    oWs1.Name = "Teljes�tm�ny-�rt�kel�s"
    oWs1.Activate
    

    ' Tartalom ki�r�sa
    
    With rs
        rs.MoveFirst
        rs.MoveLast
        maxoszlop = .Fields.count  'A leend� oszlopok sz�ma, ah�ny mez� van a lek�rdez�sben �s m�g egy a sorsz�m miatt
        maxsor = .RecordCount
        'Az el�rehalad�s-jelz� el�k�sz�t�se

        .MoveFirst
        For sor = 1 To maxsor
            For oszlop = 1 To maxoszlop
                If oszlop = 1 Then
                    oWs1.Cells(sor + 1, oszlop).Value = sor
                Else
                    adat = .Fields(oszlop - 2).Value
                    With oWs1
                        .Cells(sor + 1, oszlop).Value = adat  'A sorsz�m oszlop miatt adunk hozz� egyet, �gy egyel od�bb tessz�k
                    End With
                End If
            Next oszlop
            .MoveNext
        Next sor
    End With
    With oWs1
        .Range(.Cells(1, 1), .Cells(maxsor + 1, maxoszlop)).Name = "Teljes�tm�ny_�rt�kel�s"
        .Range(.Cells(maxsor + 2, 1), .Cells(maxsor + 2, 1)).Value = "*Minden feladatot k�l�n sorban kell felt�ntetni!"
    End With
  
    'A fejl�c ut�lag j�n a tetej�re
    oszlop = 2
    With oWs1.Cells(1, 1)
                .Value = "Sorsz�m"
                .Font.Bold = True
                .Font.Name = "Calibri"
                .Font.Size = 11
                .Interior.Color = RGB(83, 142, 213)
                .Font.Color = RGB(255, 255, 255)
                .WrapText = True
                .VerticalAlignment = xlVAlignTop
                .HorizontalAlignment = xlHAlignCenter
    End With
    oWs1.Columns(oszlop).ColumnWidth = 10
    For Each mez� In rs.Fields
        With oWs1
            With .Cells(1, oszlop)
                .Value = Replace(mez�.Name, "_", ".")
                .Font.Bold = True
                .Font.Name = "Calibri"
                .Font.Size = 11
                .Interior.Color = RGB(83, 142, 213)
                .Font.Color = RGB(255, 255, 255)
                .WrapText = True
                .VerticalAlignment = xlVAlignTop
                .HorizontalAlignment = xlHAlignCenter
            End With
            Select Case oszlop
                Case 2, 3
                    .Columns(oszlop).ColumnWidth = 43
                Case 4
                    .Columns(oszlop).ColumnWidth = 36
                Case 5
                    .Columns(oszlop).ColumnWidth = 45
                    .Cells(1, oszlop).Value = "Az 1. sz�m� t�bl�zat alapj�n a korm�nytisztvisel� t�nylegesen ell�tand� fealdatai*"
                Case 6
                    .Columns(oszlop).ColumnWidth = 45
                    .Cells(1, oszlop).Value = "Az 1. sz. t�bl�zatban meghat�rozott teljes�tm�ny-k�vetelm�ny korm�nytisztvisel�re vonatkoz� sz�vegszer� �rt�kel�se"
                Case 7
                    .Columns(oszlop).ColumnWidth = 13 'Teljes�tm�ny-k�vetelm�ny
                    .Cells(1, oszlop).Value = "Teljes�tm�ny-k�vetelm�ny (felett / szinten / alatt)"
            End Select
        End With
        oszlop = oszlop + 1
    Next mez�
    oWs1.Range("G2:G1000").Validation.Add xlValidateList, xlValidAlertStop, xlEqual, "szint felett; szinten; szint alatt"
    oWs2.Name = "Adatok"
    oWs2.Range("A1").Value = "K�sz�lt:": oWs2.Range("B1").Value = Now()
    oWs2.Range("A2").Value = "Adatsor:": oWs2.Range("B2").Value = sor - 1
    
    'Takar�t�s
    oWb.SaveAs fileName:=f�jl, FileFormat:=xlOpenXMLWorkbook, AddToMru:=True, Local:=True
    oWb.Close
    'Debug.Print f�jl & " k�sz (" & sor & " sor) ."
    Set oWb = Nothing
'   Kill oWb
    
End Sub
Sub Kimutat�s(f�jl As String, lek�rdez�s As String)
'****** (c) Ol�h Zolt�n 2022 - MIT Licence ****************
 
 'Az adatb�zishoz
    Dim db          As Database
    Dim qdf         As QueryDef
    Dim rs          As DAO.Recordset
    Dim �rlapn�v    As String
    
    'Excelhez
    Dim sor, oszlop     As Long
    Dim oApp            As Excel.Application
    Dim oWb             As Workbook
    Dim oWs1, oWs2      As Worksheet
    Dim oWc             As Chart
    
    Dim maxoszlop, maxsor As Long
    Dim adat As Variant
    Dim mez� As Field
    'Az el�rehalad�s-jelz�h�z

    
    'Alapadatok **********************************
    sor = 1
    oszlop = 1

    Set db = CurrentDb()
    'Set qdf = db.
    Set rs = db.OpenRecordset(lek�rdez�s)
    
    Set oApp = CreateObject("Excel.Application")
    Set oWb = oApp.Workbooks.Add
    Set oWs1 = oWb.Worksheets.Add
    Set oWs2 = oWb.Worksheets.Add(, oWs1)
    
    oWs1.Name = "Teljes�tm�ny-�rt�kel�s"
    oWs1.Activate
    

    ' Tartalom ki�r�sa
    
    With rs
        rs.MoveFirst
        rs.MoveLast
        maxoszlop = .Fields.count  'A leend� oszlopok sz�ma, ah�ny mez� van a lek�rdez�sben �s m�g egy a sorsz�m miatt
        maxsor = .RecordCount
        'Az el�rehalad�s-jelz� el�k�sz�t�se

        .MoveFirst
        For sor = 1 To maxsor
            For oszlop = 1 To maxoszlop
                If oszlop = 1 Then
                    oWs1.Cells(sor + 1, oszlop).Value = sor
                Else
                    adat = .Fields(oszlop - 2).Value
                    With oWs1
                        .Cells(sor + 1, oszlop).Value = adat  'A sorsz�m oszlop miatt adunk hozz� egyet, �gy egyel od�bb tessz�k
                    End With
                End If
            Next oszlop
            .MoveNext
        Next sor
    End With
    With oWs1
        .Range(.Cells(1, 1), .Cells(maxsor + 1, maxoszlop)).Name = "Teljes�tm�ny_�rt�kel�s"
        .Range(.Cells(maxsor + 2, 1), .Cells(maxsor + 2, 1)).Value = "*Minden feladatot k�l�n sorban kell felt�ntetni!"
    End With
  
    'A fejl�c ut�lag j�n a tetej�re
    oszlop = 2
    With oWs1.Cells(1, 1)
                .Value = "Sorsz�m"
                .Font.Bold = True
                .Font.Name = "Calibri"
                .Font.Size = 11
                .Interior.Color = RGB(83, 142, 213)
                .Font.Color = RGB(255, 255, 255)
                .WrapText = True
                .VerticalAlignment = xlVAlignTop
                .HorizontalAlignment = xlHAlignCenter
    End With
    oWs1.Columns(oszlop).ColumnWidth = 10
    For Each mez� In rs.Fields
        With oWs1
            With .Cells(1, oszlop)
                .Value = Replace(mez�.Name, "_", ".")
                .Font.Bold = True
                .Font.Name = "Calibri"
                .Font.Size = 11
                .Interior.Color = RGB(83, 142, 213)
                .Font.Color = RGB(255, 255, 255)
                .WrapText = True
                .VerticalAlignment = xlVAlignTop
                .HorizontalAlignment = xlHAlignCenter
            End With
            Select Case oszlop
                Case 2, 3
                    .Columns(oszlop).ColumnWidth = 43
                Case 4
                    .Columns(oszlop).ColumnWidth = 36
                Case 5
                    .Columns(oszlop).ColumnWidth = 45
                    .Cells(1, oszlop).Value = "Az 1. sz�m� t�bl�zat alapj�n a korm�nytisztvisel� t�nylegesen ell�tand� fealdatai*"
                Case 6
                    .Columns(oszlop).ColumnWidth = 45
                    .Cells(1, oszlop).Value = "Az 1. sz. t�bl�zatban meghat�rozott teljes�tm�ny-k�vetelm�ny korm�nytisztvisel�re vonatkoz� sz�vegszer� �rt�kel�se"
                Case 7
                    .Columns(oszlop).ColumnWidth = 13 'Teljes�tm�ny-k�vetelm�ny
                    .Cells(1, oszlop).Value = "Teljes�tm�ny-k�vetelm�ny (felett / szinten / alatt)"
            End Select
        End With
        oszlop = oszlop + 1
    Next mez�
    oWs1.Range("G2:G1000").Validation.Add xlValidateList, xlValidAlertStop, xlEqual, "szint felett; szinten; szint alatt"
    oWs2.Name = "Adatok"
    oWs2.Range("A1").Value = "K�sz�lt:": oWs2.Range("B1").Value = Now()
    oWs2.Range("A2").Value = "Adatsor:": oWs2.Range("B2").Value = sor - 1
    
    'Takar�t�s
    oWb.SaveAs fileName:=f�jl, FileFormat:=xlOpenXMLWorkbook, AddToMru:=True, Local:=True
    oWb.Close
    'Debug.Print f�jl & " k�sz (" & sor & " sor) ."
    Set oWb = Nothing
'   Kill oWb
    
End Sub


Function �jOszlop(strOszlopN�v As String) As Integer
    Dim sz�veg As String
    Dim v�lasz As Variant
    Dim sz�m As Integer
On Error GoTo Hiba
Kezdet:
    sz�veg = strOszlopN�v & Chr(10) & "2 - Byte" & Chr(10) & "3 - Integer" & Chr(10) & "4 - Long" & Chr(10) & "5 - Currency" & Chr(10) & "6 - Single" & Chr(10) & "7 - Double" & Chr(10) & "8 - Date/Time" & Chr(10) & "10 - Text" & Chr(10) & "12 - Memo" & Chr(10) & "16 - Big Integer" & Chr(10) & "17 - VarBinary" & Chr(10) & "18 - Char" & Chr(10) & "19 - Numeric" & Chr(10) & "20 - Decimal" & Chr(10) & "21 - Float" & Chr(10) & "22 - Time" & Chr(10) & "23 - Time Stamp"
    v�lasz = InputBox(sz�veg, "�j oszlop", 10) 'Ha nem v�laszol, akkor 10 lesz az �rt�k.
    If StrPtr(v�lasz) = 0 Then 'M�gsem gombot nyomott
        Exit Function
    End If
    If Len(v�lasz) = 0 Then
        GoTo Kezdet
    End If
V�g:
    sz�m = CInt(v�lasz)
    MsgBox ("Eredm�ny:" & sz�m)
Exit Function
Hiba:
If Err.Number = 13 Then
    Select Case MsgBox(Err.Number & " sz�m� hiba." & Chr(10) & " Csak sz�m adhat� meg!", vbRetryCancel)
        Case 2
            Exit Function
        Case 4
            Resume Kezdet
        Case Else
            MsgBox ("!")
    End Select
End If
'    Resume Kezdet

End Function


Sub T�blaMez�k()
    Dim db As Database
    Dim rs As Recordset
    Dim rs2 As Recordset
    Dim tbla As Recordset
    Dim sql, sql2, sql3 As String
    Dim mez�sz�m As Long
    Dim mez�n�v As String
    'Dim mez�nevek() As Variant
    
    Dim t�blan�v As String
    
    
    sql = "SELECT Name FROM MSysObjects WHERE (Flags=0 AND Type = 1 AND Name not like '~*') OR (Type = 6 AND Name not like '~*')"
    
    Set db = CurrentDb()
    db.Execute ("Delete * from tT�blamez�k")
    Set tbla = db.OpenRecordset("select * from tT�blamez�k")
        
    Set rs = db.OpenRecordset(sql)
        rs.MoveLast
        rs.MoveFirst
    
    Do Until rs.EOF
        t�blan�v = rs.Fields("Name")
        sql2 = "SELECT TOP 1 * FROM [" & t�blan�v & "];"
        Set rs2 = db.OpenRecordset(sql2)
        'Debug.Print t�blan�v, rs2.Fields.Count
        For mez�sz�m = 0 To rs2.Fields.count - 1
            tbla.AddNew
            tbla.Fields("t�blan�v") = t�blan�v
            mez�n�v = rs2.Fields(mez�sz�m).Name
            tbla.Fields("mez�n�v") = mez�n�v
            tbla.Fields("sorsz�m") = mez�sz�m
            tbla.Fields("t�pusa") = rs2.Fields(mez�sz�m).Type
            If InStr(1, mez�n�v, "d�tum") Then
                'tbla.Fields = Date
            End If
            tbla.Update
            'Debug.Print mez�sz�m, rs2.Fields(mez�sz�m).Name
        Next mez�sz�m
        Set rs2 = Nothing
        rs.MoveNext
    Loop
    
End Sub
Public Sub HaviT�blaPlus( _
        ByVal f�jl As String, _
        Optional ByVal lnCsoport As Long = 1)
Debug.Print fvHaviimpT�bl�kImportPlus(f�jl, lnCsoport)
End Sub
Public Function _
    fvHaviimpT�bl�kImportPlus( _
        ByVal f�jl As String, _
        Optional ByVal lnCsoport As Long = 1) _
    As Boolean

fvbe ("fvHaviimpT�bl�kImportPlus")
    'Licencia: MIT Ol�h Zolt�n 2022 (c)
    '_____________________________________________________________________________________________________________________________
    '------------------------------------------ V�ltoz�k deklar�ci�ja -----------------------------------------------------------�
    'Az Excel megnyit�s�hoz
    '___________________________________|__________________________|______________________________|______________________________|
    '   Objects                         | Strings                  | Numbers                      | Variants                     |
    '___________________________________|__________________________|______________________________|______________________________|
    Dim objExcel   As Excel.Application, xlUtols�Oszlop   As String, intV�gcella       As Integer, �rt�kek()        As Variant, _
        objBook       As Excel.Workbook, xlHosszm�r�      As String, intMez�           As Integer, _
        objSheet     As Excel.Worksheet, accT�bl�k        As String, intUtols�Sor      As Integer, _
        objRange         As Excel.Range, xlT�bl�kEred     As String, _
        xlV�gcella       As Excel.Range, _
        xlKezd�Cella     As Excel.Range
    'Az adatb�zis megnyit�s�hoz
    '___________________________________|__________________________|______________________________|______________________________|
    '   Objects                         | Strings                  | Numbers                      | Variants                     |
    '___________________________________|__________________________|______________________________|______________________________|
    Dim objAccess  As Access.Application, impT�bl�k       As String, oszlop       As Integer, _
        db              As DAO.Database, strH�tt�rDb      As String, sor          As Integer, _
        rs              As DAO.Recordset, _
        rsC�l           As DAO.Recordset, _
        rsHat�ly        As DAO.Recordset     'Sz�ml�l�shoz
                                                                Dim hat�lyaID As Long
    'A sz�veges kimenethez
    '___________________________________|__________________________|______________________________|______________________________|
    '   Objects                         | Strings                  | Numbers                      | Variants                     |
    '___________________________________|__________________________|______________________________|______________________________|
                                     Dim �zenet          As String
    '___________________________________|__________________________|______________________________|______________________________|
    
    
    strH�tt�rDb = "L:\Ugyintezok\Adatszolg�ltat�k\Adatb�zisok\H�tt�rt�rak\Ellen�rz�sHavi_h�tt�rt�r.accdb"
'   Set objAccess = New Access.Application
    Set db = CurrentDb 'objAccess.DBEngine.OpenDatabase(strH�tt�rDb, False, False)
    impT�bl�k = "tImport�land�T�bl�k1"
    
    intV�gcella = 0
    'On Error GoTo hiba

    Set objExcel = CreateObject("Excel.Application")
    
    Set objBook = objExcel.Workbooks.Open(f�jl, ReadOnly:=True, IgnoreReadOnlyRecommended:=True, Editable:=False, Notify:=False)
    Set rs = db.OpenRecordset(impT�bl�k)
    
    rs.MoveLast
    rs.MoveFirst
    
    If DCount("*", "tHaviJelent�sHat�lya1", "f�jln�v = '" & f�jl & "'") > 0 Then
        Set rsHat�ly = db.OpenRecordset("SELECT hat�lyaID FROM tHaviJelent�sHat�lya1 WHERE f�jln�v = '" & f�jl & "'")
        If Not rsHat�ly.EOF Then
            hat�lyaID = rsHat�ly("hat�lyaID")
        End If
        rsHat�ly.Close
    Else
        Set rsHat�ly = db.OpenRecordset("tHaviJelent�sHat�lya1", dbOpenDynaset)
        rsHat�ly.AddNew
        rsHat�ly("hat�lya") = objBook.Worksheets("Fedlap").Range("a2").Value
        rsHat�ly("f�jln�v") = f�jl
        rsHat�ly.Update
        rsHat�ly.Bookmark = rsHat�ly.LastModified
        hat�lyaID = rsHat�ly("hat�lyaID")
        rsHat�ly.Close
    End If
    
    Do Until rs.EOF
        Erase �rt�kek
        If rs("Csoport") = lnCsoport Then
            accT�bl�k = rs("AccessN�v")
            xlT�bl�kEred = rs("EredetiN�v")
            
            Set objSheet = objBook.Worksheets(xlT�bl�kEred)
            With objSheet
                If .AutoFilterMode Then _
                    .AutoFilter.ShowAllData 'Kikapcsolja a sz�r�st az adott lapon???
                .Select
                logba sFN & " " & xlT�bl�kEred, "Adatok beolvas�s indul..."
                If Nz(rs("V�gcella"), "") = "" Then
                    xlHosszm�r� = rs("Hosszm�r�Cella")
                    xlUtols�Oszlop = rs("Utols�Oszlop")
                    intV�gcella = .Range(xlHosszm�r� & 1).Column
                    intUtols�Sor = .Cells(objSheet.Cells.Rows.count, intV�gcella).End(xlUp).row
                    Set xlV�gcella = .Range(xlUtols�Oszlop & intUtols�Sor)
                                    logba , "hosszcella: " & xlHosszm�r� & ", utols� oszl.: " & xlUtols�Oszlop & ", V�gcella: " & xlV�gcella, 3
                Else
                    Set xlV�gcella = .Range(rs("V�gcella"))
                End If
                    Set xlKezd�Cella = .Range(rs("Kezd�Cella"))
                    
                    If xlKezd�Cella.row < xlV�gcella.row Then 'Ha van adat a t�bl�ban ...
                        .Range(xlKezd�Cella, xlV�gcella).Name = accT�bl�k
                    
                                    logba , accT�bl�k & ":;" & .Range(accT�bl�k).Rows.count, 2
                
                
                        Set rsC�l = db.OpenRecordset(accT�bl�k, dbOpenDynaset)
                        �rt�kek = .Range(accT�bl�k).Value
                                    logba sFN & " " & xlT�bl�kEred, " ter�letr�l az adatokat beolvastuk."
                                    logba sFN & " " & xlT�bl�kEred, "Adatok ki�r�sa indul. C�l:" & accT�bl�k
            
                        For sor = LBound(�rt�kek, 1) To UBound(�rt�kek, 1)
                            intMez� = 0
                            '�j rekord hozz�ad�sa kezd�dik...
                            rsC�l.AddNew
                            For oszlop = LBound(�rt�kek, 2) To UBound(�rt�kek, 2)
                                If rsC�l.Fields.count < oszlop Then
                                    Exit For
                                End If
                                intMez� = oszlop - 1
                                rsC�l.Fields(intMez�) = konverter(rsC�l.Fields(intMez�), �rt�kek(sor, oszlop))
                            Next oszlop
                            rsC�l("hat�lyaID") = hat�lyaID  ' Add the hat�lyaID to the new record
                            rsC�l.Update
                            '�j rekord hozz�ad�sa v�get �rt
                        Next sor
                                    logba sFN & " " & xlT�bl�kEred, "Adatok ki�r�sa " & n�vel�vel(accT�bl�k) & "t�bl�ba v�get �rt."
                    Else 'Ha nincs adat a t�bl�ban ...
                        'nincs mit elnevezni,
                        'nincs mit ki�rni,
                        'amib�l az k�vetkezik, hogy ha nincs egy t�bl�ban egy hat�lynapra ID, akkor arra a napra nem volt adat...
                    End If
            End With
        End If
        
        rs.MoveNext
        intV�gcella = 0
    Loop
    
                                    logba sFN & " " & xlT�bl�kEred, objBook.Name & " bez�r�sa ment�s n�lk�l..."
    objBook.Close SaveChanges:=False
    
    fvHaviimpT�bl�kImportPlus = True
    Debug.Print f�jl
ki:
    Set objBook = Nothing
    Set objExcel = Nothing
fvki
    Exit Function
Hiba:
    MsgBox Hiba(Err)
    fvHaviimpT�bl�kImportPlus = False
    If intLoglevel >= 2 Then
        Resume Next
    Else
        Resume ki
    End If
End Function
