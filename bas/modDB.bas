'E gy�tem�nyben, ha az MIT licencia eml�ttettik, (megjel�lve a szerz�t �s a m� sz�let�s�nek �v�t) azon az al�bbi felhaszn�l�si enged�lyt kell �rteni:

'Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"),
'to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software,
'and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
'The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
'THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
'FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
'WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
Option Compare Database


Function vFldT�pus(sql As String) As Variant
'#MIT Ol�h Zolt�n (c) 2023
'A kapott lek�rdez�st lefuttatja, s a kapott �rt�kp�r eredm�nyt egy t�mbben adja vissza

    Dim db1 As Database
    Dim rs1 As Recordset
    Dim vFieldTypes() As Variant
    Dim i As Integer
    Dim t1 As Single, _
        t2 As Single
    t1 = Timer()
    ' Set the database object
    Set db1 = CurrentDb
    
    ' Open the query that contains the fieldName and fieldType pairs
    Set rs1 = db1.OpenRecordset(sql)
    
    ' Check if there are records in the query result
    If Not rs1.EOF Then
        rs1.MoveLast
        rs1.MoveFirst
         
        ' Resize the array to hold the number of records
        ReDim vFieldTypes(1 To rs1.RecordCount, 1 To 4)
        
        ' Loop through the records and populate the array
        i = 1
        Do While Not rs1.EOF
            vFieldTypes(i, 1) = "" & rs1("Mez�Neve") & ""
            vFieldTypes(i, 2) = rs1("Mez�T�pusa")
            vFieldTypes(i, 3) = rs1("Grafikonra")
            vFieldTypes(i, 4) = rs1("Hashbe")
            rs1.MoveNext
            i = i + 1
        Loop
    End If
    
    ' Close the recordset
    rs1.Close
    
    ' Now, vFieldTypes array contains fieldName and fieldType pairs
    ' You can access them like this: vFieldTypes(row, column)
    
    ' For example, to access the first pair:
    'MsgBox "Field Name: " & vFieldTypes(1, 1) & vbCrLf & "Field Type: " & vFieldTypes(1, 2)
    vFldT�pus = vFieldTypes
    ' Clean up
    Set rs1 = Nothing
    Set db1 = Nothing
    t2 = Timer
    Debug.Print t2 - t1
End Function
Sub mez�T�pusok(lek As String, hfN�v As String)
'Licencia: MIT Ol�h Zolt�n 2022 (c)
' A lek nev� lek�rdez�sben felsorolt lek�rdez�seket sorra megnyitja,
' s a lek�rdez�s nev�t, tov�bb� a mez� nev�t �s t�pus�t egy hfN�v nev� csv t�bl�ba �rja.
' mez�T�pusok "lkEllen�rz�Lek�rdez�sek2","C:\Users\olahzolt\Desktop\F�jlok\mezo.csv"
fvbe ("mez�T�pusok")
    Dim db As DAO.Database
    Dim rk As Recordset
    'Dim hfn�v As String
    Dim hf As Object
    
    Set hf = CreateObject("Scripting.FileSystemObject").CreateTextFile(hfN�v, True)

    Set db = CurrentDb
    Set rk = db.OpenRecordset(lek)
    rk.MoveFirst
    hf.WriteLine "Lek�rdez�sNeve;Mez�Neve;Mez�T�nylegesT�pusa"
    
    Do Until rk.EOF
        Dim rklek As Recordset
        Set rklek = db.OpenRecordset(rk("Ellen�rz�Lek�rdez�s"))
        logba , rklek.Name, 3
        For Each mez� In rklek.Fields
            hf.WriteLine rklek.Name & ";" & mez�.Name & ";" & mez�.Type
            logba , rklek.Name & "; " & mez�.Name & "; " & mez�.Type, 4
        Next mez�
        rk.MoveNext
        Set rklek = Nothing
    Loop
    hf.Close
    Set hf = Nothing
    logba , "----------------", 3
fvki
End Sub

Public Function konverter(fMez� As Field, �rt�k As Variant)
'****** (c) Ol�h Zolt�n 2022 - MIT Licence ****************
fvbe ("konverter")
logba , CStr(fMez�.Type) & ";" & CStr(�rt�k), 4

If IsNull(�rt�k) Then
    konverter = Null
    Exit Function
End If
Select Case TypeName(�rt�k)
    Case "String"
        Select Case fMez�.Type
            Case 1 To 8, 19 To 23            'A t�mbben tal�lhat� String t�pus� adatot nem alak�tjuk �t sz�mm�, az �rt�k�t 0-ra �ll�tjuk.
                     konverter = 0
            Case 10: konverter = CStr(�rt�k) 'Text
            Case 12: konverter = CVar(�rt�k) 'Memo
            Case 16: konverter = CLng(�rt�k) 'Big Integer
            Case 17: konverter = CVar(�rt�k) 'VarBinary
            Case 18: konverter = CStr(�rt�k) 'Char
            Case Else
                logba colFvN�v.item(1), "Nem lehet konvert�lni a" & n�vel�(�rt�k) & " " & �rt�k & " �rt�ket a" & n�vel�(fMez�.Type) & " " & fMez�.Name & " " & fMez�.Type & "t�pus�ba!", 2
                MsgBox "Nem lehet konvert�lni a" & n�vel�(�rt�k) & " " & �rt�k & " �rt�ket a" & n�vel�(fMez�.Type) & " " & fMez�.Name & " " & fMez�.Type & "t�pus�ba!"
        End Select
    Case Else
        Select Case fMez�.Type
            Case 1:  konverter = CBool(�rt�k) 'Boolean
            Case 2:  konverter = CByte(�rt�k) 'Byte
            Case 3:  konverter = CInt(�rt�k)  'Integer
            Case 4:  konverter = CLng(�rt�k)  'Long
            Case 5:  konverter = CCur(�rt�k)  'Currency
            Case 6:  konverter = CSng(�rt�k)  'Single
            Case 7:  konverter = CDbl(�rt�k)  'Double
            Case 8:  konverter = CDate(�rt�k) 'Date/Time
            Case 10: konverter = CStr(�rt�k)  'Text
            Case 12: konverter = CVar(�rt�k)  'Memo
            Case 16: konverter = CLng(�rt�k)  'Big Integer
            Case 17: konverter = CVar(�rt�k)  'VarBinary
            Case 18: konverter = CStr(�rt�k)  'Char
            Case 19: konverter = CLng(�rt�k)  'Numeric
            Case 20: konverter = CDec(�rt�k)  'Decimal
            Case 21: konverter = CDbl(�rt�k)  'Float
            Case 22: konverter = CDate(�rt�k) 'Time
            Case 23: konverter = CDate(�rt�k) 'Time Stamp
            Case Else
                logba colFvN�v.item(1), "Nem lehet konevert�lni a" & n�vel�(�rt�k) & " " & �rt�k & " �rt�ket a" & n�vel�(fMez�.Type) & " " & fMez�.Name & " " & fMez�.Type & "t�pus�ba!", 2
                MsgBox "Nem lehet konevert�lni a" & n�vel�(�rt�k) & " " & �rt�k & " �rt�ket a" & n�vel�(fMez�.Type) & " " & fMez�.Name & " " & fMez�.Type & "t�pus�ba!"
        End Select
End Select
fvki
End Function


Function mez�n�v(ByRef adatb�zis As DAO.Database, ByVal Mez�ListaT�bla As String, ByVal oszlopc�m As String) As String
    Dim sql As String
    Dim rekordok As Recordset
    Dim szRek As Long
    
On Error GoTo ErrorHandler
    
    sql = "SELECT TOP 1 [Mez�n�v]" _
        & " FROM [" & Mez�ListaT�bla & "]" _
        & " WHERE [Oszlopn�v]='" & oszlopc�m & "';"
    Set rekordok = adatb�zis.OpenRecordset(sql)
    
    If rekordok.EOF Then
        MsgBox Title:="Az oszlopn�v nincs " & n�vel�vel(Mez�ListaT�bla) & " t�bl�ban", _
               Prompt:=n�vel�vel(oszlopc�m, , , True) & "nem szerepel " & n�vel�vel(Mez�ListaT�bla) & " t�bl�ban!"
    Else
        rekordok.MoveLast
        szRek = rekordok.RecordCount
    End If

    Set rekordok = Nothing
Exit Function
 
ErrorHandler:
    logba colFvN�v.item(1), "Error #: " & Err.Number & vbCrLf & vbCrLf & Err.Description, 0
    MsgBox "Error #: " & Err.Number & vbCrLf & vbCrLf & Err.Description

End Function



Function vMez�kT�pusaImporthoz(eRng As Excel.Range) As Variant
'# Ol�h Zolt�n (c)2024 MIT
'# A tartom�ny c�msor�t v�gign�zz�k, s egy t�mbbe �sszegy�jtj�k az al�bbi adatokat:
    '# - oszlopsz�m
    '# - a mez�Neve <- a lkMez�k�sT�pusuk lek�rdez�sb�l
    '# - a mez�T�pusa <- lkMez�k�sT�pusuk lek�rdez�sb�l
    '# - skip (�t kell-e ugrani) <- lkMez�k�sT�pusuk lek�rdez�sb�l
    '# Az lkMez�k�sT�pusuk egy lek�rdez�s, ami az al�bbi mez�ket adja vissza:
    '# oszlopn�v - az excel tartom�ny (eRng) c�msor�ban szerepl� lehets�ges sz�vegek, oszlopnevek
    '# mez�n�v - az adatt�bla mez�nevei,
    '# T�pus - egy eg�sz sz�m
    '# Skip - Boolean �rt�k
    '# DbType - a JetSQL szerinti mez�t�pus
    Dim i As Integer
    Dim arr() As Variant
    Dim oszlopszam As Integer
    Dim Mez�Neve As String
    Dim Mez�T�pusa As String
    Dim skip As Boolean
    Dim rs As DAO.Recordset
    
    ' Initialize the array
    ReDim arr(1 To eRng.Columns.count, 1 To 5)
    
    ' Open the query
    Set rs = CurrentDb.OpenRecordset("lkMez�k�sT�pusuk")
    
    ' Loop through each column in the range
    For i = 1 To eRng.Columns.count
        ' Get the column number
        oszlopszam = i
        
        ' Find the corresponding record in the query
        rs.FindFirst "[oszlopn�v] = '" & eRng.Cells(1, i).Value & "'"
        
        If Not rs.NoMatch Then
            ' Get the field name, field type, and whether to skip from the query
            Mez�Neve = rs!mez�n�v
            Mez�T�pusa = rs!T�pus
            skip = rs!skip
        Else
            ' If no matching record is found, use default values
            Mez�Neve = ""
            Mez�T�pusa = ""
            skip = True
        End If
        
        ' Store the information in the array
        arr(i, 1) = oszlopszam
        arr(i, 2) = Mez�Neve
        arr(i, 3) = Mez�T�pusa
        arr(i, 4) = skip
        arr(i, 5) = rs!DbType
    Next i
    
    ' Close the recordset
    rs.Close
    Set rs = Nothing
    
    ' Return the array
    vMez�kT�pusaImporthoz = arr
End Function
Public Function tSzem�lyekImport02(strF�jl As String, �rlap As Form, Optional t�bla As String = "tSzem�lyek", Optional ByVal beolvasand�LapSz�m As Integer = 1)
    'On Error GoTo ErrorHandler
fvbe ("tSzem�lyekImport02")
    Dim importSpecName As String
    Dim db As DAO.Database
    Dim qdf As DAO.QueryDef
    Dim prm As DAO.Parameter
    Dim xlWB As Workbook
    
    Dim �zenet As String
    Dim v�lasz As Boolean
    Dim Huba As Boolean
    
    Set db = CurrentDb
    Huba = False
    
    importSpecName = t�bla & "_import"

    If strF�jl <> "" Then

                                                    sFoly �rlap, importSpecName & ":; import�l�s �res oszlopok t�rl�se...", True, 1
        If t�bla = "tSzem�lyek" Then 'Ha szem�lyt�rzs,
            UresOszlopokTorlese strF�jl, t�bla 'a megadott �llom�nyb�l t�r�lj�k az �res oszlopokat, de
        Else 'ha nem,
            UresOszlopokTorlese strF�jl, t�bla, False, False, "A2", beolvasand�LapSz�m 'akkor nem t�r�lj�k az �res oszlopkat, nem illeszt�nk be ad�sz�mot, �s megadjuk a kezd� cell�t
        End If
                                                    sFoly �rlap, importSpecName & ":; import�l�s �res oszlopok t�rl�se k�sz!"

                                                    sFoly �rlap, importSpecName & ":; import�l�s ind�t�sa"
'#           Kit�r�lj�k a kor�bbi f�jlhoz l�trehozott kapcsolatot, ha van ilyen
On Error Resume Next
        If Len(CurrentDb.TableDefs(importSpecName).Connect) > 0 Then
            DoCmd.DeleteObject acTable, importSpecName
On Error GoTo 0
                                                    sFoly �rlap, importSpecName & ":; a kor�bbi kapcsolat t�r�lve"
        End If
'#          Majd l�trehozunk ugyanezen a n�ven egy �j kapcsolatot az �j f�jllal
        DoCmd.TransferSpreadsheet acLink, 10, importSpecName, strF�jl, True, t�bla 'TODO : �j param�ter az UresOszlopokTorlese-hez: ter�letn�v
        '#xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
                                                    sFoly �rlap, importSpecName & ":; t�bla csatol�sa k�sz"
        db.Execute ("lkh�tt�rt�r_" & t�bla & "_t�rl�") ' t�r�lj�k a m�r megl�v� adatokat
                                                    sFoly �rlap, importSpecName & ":; kor�bbi adatok t�rl�se k�sz"
                                                    sFoly �rlap, importSpecName & ":; adatok �tt�lt�se h�tt�rt�rba indul..."
        'Debug.Print InsertIntoSelectK�sz�t�2(t�bla, importSpecName, �rlap)
        Set qdf = db.CreateQueryDef("", InsertIntoSelectK�sz�t�2(t�bla, importSpecName, �rlap)) 'CurrentDb.QueryDefs("lkh�tt�rt�r_" & t�bla & "_�tt�lt�s").sql)
        For Each prm In qdf.Parameters
            prm.Value = Null  ' Null �rt�ket kapnak a c�lt�bl�b�l hi�nyz� oszlopok mez�i
            sFoly �rlap, "A hi�nyz� " & prm.Name & " nev� mez�; " & prm.Value & " �rt�kre be�ll�tva!"
        Next prm

        ' Execute the query
        On Error GoTo ErrorHandler
            qdf.Execute dbConsistent
        On Error GoTo 0
Debug.Print
'        db.Execute ("lkh�tt�rt�r_" & t�bla & "_�tt�lt�s") '�tt�ltj�k az adatokat a h�tt�rt�rba

                                                    sFoly �rlap, importSpecName & ":; import�l�s v�get �rt"
                                                    sFoly �rlap, importSpecName & ":; " & DCount("*", "tSzem�lyek") & " sor."
    End If
    tSzem�lyekImport02 = True
    Set qdf = Nothing
Kil�p�s:
    fvki
    Exit Function

ErrorHandler:
    If DBEngine.Errors.count > 0 Then
        For Each errLoop In DBEngine.Errors
            sFoly �rlap, _
                    importSpecName & "Hiba (" & errLoop.Number & ");" & errLoop.Description
        Next errLoop
        Resume Next
    End If
        

    ' Szabv�nyos hiba�zenet el��ll�t�sa
    If Err.Number = 3709 Then
        logba colFvN�v.item(1), importSpecName & ":;az import�l�s hib�ra futott, megpr�b�ljuk jav�tani..." & "Error: " & Err.Number & " - " & Err.Description
        Huba = True
        Resume 0
    End If
    Hiba Err
'    logba colFvN�v.Item(1), "Error: " & Err.Number & " - " & Err.Description
'    MsgBox "Error: " & Err.Number & " - " & Err.Description, vbExclamation + vbOKOnly, "Error"
    tSzem�lyekImport02 = False
    Resume Kil�p�s
End Function
Function CreateTableK�sz�t�(t�blan�v As String, fromT�blaN�v As Variant, Optional adatb�zis As String = "L:\Ugyintezok\Adatszolg�ltat�k\Adatb�zisok\H�tt�rt�rak\Ellen�rz�s_0.9.6_h�tt�r_.mdb.accdb")
    Dim kdb As DAO.Database
    Dim tbl As TableDef
    Dim fld As Field
    Dim sql As String
    If IsNull(fromT�blaN�v) Or fromT�blaN�v = vbNullString Then fromT�blaN�v = t�blan�v
    sql = "CREATE TABLE [" & t�blan�v & "] (" & vbNullString
    If adatb�zis = "" Then
        Set kdb = CurrentDb
    Else
        Set kdb = OpenDatabase(adatb�zis)
    End If
    Set tbl = kdb.TableDefs(t�blan�v)
    For Each fld In tbl.Fields
        sql = sql & "[" & fld.Name & "] " & FieldTypeName(fld) & ", " & vbNewLine
    Next fld
    sql = Left(sql, Len(sql) - 4) & ");"
CreateTableK�sz�t� = sql
End Function
'Function InsertIntoSelectK�sz�t�(t�blan�v, fromt�blan�v, Optional adatb�zis As String = "L:\Ugyintezok\Adatszolg�ltat�k\Adatb�zisok\H�tt�rt�rak\Ellen�rz�s_0.9.6_h�tt�r_.mdb.accdb")
'    Dim kdb, db As DAO.Database
'    Dim tbl, tb As TableDef
'    Dim fld, fl As Field
'    Dim sql As String
'
'    sql = "INSERT INTO [" & t�blan�v & "] IN '" & adatb�zis & "' " & vbNewLine
'    sql = sql & "SELECT "
'    Set kdb = OpenDatabase(adatb�zis)
'    Set tbl = kdb.TableDefs(t�blan�v)
'    For Each fld In tbl.Fields
'        sql = sql & "[" & fromt�blan�v & "].[" & fld.Name & "] as [" & fld.Name & "]," & vbNewLine
'    Next fld
'    sql = Left(sql, Len(sql) - 3) & vbNewLine
'    sql = sql & " FROM [" & fromt�blan�v & "];"
'
'InsertIntoSelectK�sz�t� = sql
'End Function
Function InsertIntoSelectK�sz�t�2(t�blan�v As String, forr�sT�blaN�v As String, Optional �rlap As Form, Optional Ment As Boolean = False, Optional adatb�zis As String = "L:\Ugyintezok\Adatszolg�ltat�k\Adatb�zisok\H�tt�rt�rak\Ellen�rz�s_0.9.6_h�tt�r_.mdb.accdb")
    Dim kdb As DAO.Database
    Dim c�lT�bla, forr�sT�bla As DAO.TableDef
    Dim lek As QueryDef
    Dim c�lMez� As DAO.Field
    Dim forr�sMez� As DAO.Field
    Dim sql As String
    Dim c�lMez�k As Collection
    Dim c�lT�pus As Integer
    Dim hi�nyz�Mez�k As String
    Dim mez�Megtal�lva As Boolean, _
        nincsm�gilyent�bla As Boolean
    
    ' Gy�jtem�ny a c�lt�bla mez�neveinek t�rol�s�ra
    Set c�lMez�k = New Collection
    hi�nyz�Mez�k = ""
    
    sql = "INSERT INTO [" & t�blan�v & "] IN '" & adatb�zis & "' " & vbNewLine
    sql = sql & "SELECT "
    
    ' Nyisd meg az adatb�zist
    Set kdb = CurrentDb 'OpenDatabase(adatb�zis)
    
    ' Szerezd meg a c�lt�bla mez�it
    Set c�lT�bla = kdb.TableDefs(t�blan�v)
    For Each c�lMez� In c�lT�bla.Fields
        c�lMez�k.Add c�lMez�.Type, c�lMez�.Name ' Add hozz� kulcs alapj�n
    Next c�lMez�
    
    ' Szerezd meg a forr�st�bla mez�it �s �p�tsd az SQL-t
    Set forr�sT�bla = kdb.TableDefs(forr�sT�blaN�v)
    For Each forr�sMez� In forr�sT�bla.Fields
        mez�Megtal�lva = False
        
        ' Ellen�rizd, hogy a forr�smez� neve l�tezik-e a c�lt�bl�ban
        On Error Resume Next
        mez�Megtal�lva = Not IsError(c�lMez�k(forr�sMez�.Name))
        On Error GoTo 0
        
        If mez�Megtal�lva Then
            c�lT�pus = c�lT�bla.Fields(forr�sMez�.Name).Type
            If forr�sMez�.Type <> c�lT�pus _
                And c�lT�pus = 8 Then
                sql = sql & "     dt�tal([" & forr�sT�blaN�v & "].[" & forr�sMez�.Name & "],""�hn"",0) AS [" & forr�sMez�.Name & "]," & vbNewLine
                logba
            Else
                sql = sql & "     [" & forr�sT�blaN�v & "].[" & forr�sMez�.Name & "] AS [" & forr�sMez�.Name & "]," & vbNewLine
            End If
        Else
            hi�nyz�Mez�k = hi�nyz�Mez�k & forr�sMez�.Name & vbNewLine
        End If
    Next forr�sMez�
    
    ' T�vol�tsd el az utols� vessz�t �s �j sort
    sql = Left(sql, Len(sql) - 3) & vbNewLine
    sql = sql & " FROM [" & forr�sT�blaN�v & "];"
    
    ' Ha vannak hi�nyz� mez�k, �rjuk ki �ket
    If hi�nyz�Mez�k <> "" And Not �rlap Is Nothing Then
        sFoly �rlap, forr�sT�blaN�v & ";A k�vetkez� mez�k nem tal�lhat�k a c�lt�bl�ban, ez�rt kihagy�sra ker�ltek:" & vbNewLine & hi�nyz�Mez�k
    End If
    
    If Ment Then
        On Error Resume Next
        nincsm�gilyent�bla = IsError(kdb.QueryDefs("lkH�tt�rt�r_" & t�blan�v & "_�tt�lt�s").Name)
        On Error GoTo 0
        If nincsm�gilyent�bla Then
            Set lek = kdb.CreateQueryDef("lkH�tt�rt�r_" & t�blan�v & "_�tt�lt�s", sql)
        Else
            kdb.QueryDefs("lkH�tt�rt�r_" & t�blan�v & "_�tt�lt�s").sql = sql
        End If
        Debug.Print sql
        Exit Function
    End If
    
    ' Eredm�ny
    InsertIntoSelectK�sz�t�2 = sql
End Function
Sub T�blak�sz�t�(adatb�zis As DAO.Database, ByVal forr�sT�bla As String, ByVal c�lT�bla As String)
'(c) Ol�h Zolt�n 2022. Licencia: MIT
' A forr�st�bl�ban tal�lhat� mez�nevek-nek �s t�pus-nak megfelel� mez�kkel hoz l�tre egy c�lt�bla nev� t�bl�t
fvbe ("T�blak�sz�t�")

    Dim db              As DAO.Database     'Ez lesz az adatb�zisunk
    Dim sqlMez�k        As String           'A mez�nevek lek�rdez�s�hez
    Dim sqlTgy          As String           'A tSzem�ly t�bl�t k�sz�t� lek�rdez�shez
    Dim rsSorSz�m       As Integer
    Dim rsMez�k         As DAO.Recordset    'A mez�nevek t�bl�ja
    Dim strMez�N�v     As String
    
    Dim strHiba As String
    Dim strHibael�z� As String 'hiba�zenet
    Dim n As Long 'hib�k sz�ma
    Dim ism�tl�d�Hib�k As Boolean
    ism�tl�d�Hib�k = False
    
    
    
On Error GoTo Hiba
    'Alap�rt�kek be�ll�t�sa
    Set db = adatb�zis
    sqlMez�k = "SELECT [" & forr�sT�bla & "].[Az]" _
             & ", [" & forr�sT�bla & "].[Oszlopn�v]" _
             & ", [" & forr�sT�bla & "].[T�pus]" _
             & ", [" & forr�sT�bla & "].[Mez�n�v]" _
             & ", (SELECT Count([Az])" _
             & "     FROM [" & forr�sT�bla & "] as Tmp " _
             & "     WHERE   [Tmp].[Az] <= [" & forr�sT�bla & "].[Az]" _
             & "        AND [Tmp].[T�pus] = [" & forr�sT�bla & "].[T�pus]" _
             & "        AND [Tmp].[Mez�n�v] = [" & forr�sT�bla & "].[Mez�n�v]" _
             & "  )" _
             & " FROM [" & forr�sT�bla & "] " _
             & " WHERE " _
             & "  (SELECT Count([Az])" _
             & "     FROM [" & forr�sT�bla & "] as Tmp " _
             & "     WHERE   [Tmp].[Az] <= [" & forr�sT�bla & "].[Az]" _
             & "        AND [Tmp].[T�pus] = [" & forr�sT�bla & "].[T�pus]" _
             & "        AND [Tmp].[Mez�n�v] = [" & forr�sT�bla & "].[Mez�n�v]" _
             & "  ) = 1;"

    Set rsMez�k = db.OpenRecordset(sqlMez�k)
    rsMez�k.MoveLast
    rsMez�k.MoveFirst
    sqlTgy = "CREATE TABLE " & c�lT�bla & "([az" & c�lT�bla & "] COUNTER, CONSTRAINT [PrimaryKey] PRIMARY KEY ([az" & c�lT�bla & "]) );"
    db.Execute (sqlTgy)
    sqlTgy = ""
    For rsSorSz�m = 0 To rsMez�k.RecordCount - 1
        sqlTgy = "ALTER TABLE [" & c�lT�bla & "] ADD COLUMN [" & rsMez�k.Fields("Mez�n�v") & "] "  'A mez�n�v
        Select Case rsMez�k.Fields("T�pus")               'ut�na j�n t�pus
            Case 10
                sqlTgy = sqlTgy & "VARCHAR; "
            Case 8
                sqlTgy = sqlTgy & "DATETIME; "
            Case 5
                sqlTgy = sqlTgy & "MONEY; "
            Case 4
                sqlTgy = sqlTgy & "INTEGER; "             'LONG
            Case Else
                sqlTgy = sqlTgy & "CHAR; "                'ha semmi m�s nincs, legyen sz�veg
        End Select

        strMez�N�v = Clean_NPC(sqlTgy)
        If Len(strMez�N�v) > 60 Then
            strMez�N�v = Left(strMez�N�v, 60) & rsSorSz�m
        End If
        db.Execute (strMez�N�v)

        rsMez�k.MoveNext

logba , rsSorSz�m & ";" & Len(rsMez�k.Fields("Mez�n�v")) & " " & strMez�N�v, 4
    Next rsSorSz�m

ki:
    If ism�tl�d�Hib�k Then logba , n & " alkalommal ism�tl�d�tt ez a hiba:" & strHiba, 0
    fvki
Exit Sub
Hiba:
    strHibael�z� = strHiba
    strHiba = Err.Number & ": " & Err.Description & " - " & Err.Source
    If strHibael�z� = strHiba Then
        ism�tl�d�Hib�k = True
        n = n + 1
        Resume Next
    End If
    If n > 0 Then
        logba , strHiba, 0
        Resume Next
    End If
    If MsgBox("A k�vetkez� hib�ba �tk�zt�nk:" & vbNewLine & strHiba & vbNewLine & "Folytassuk?", vbYesNo, "Hiba: folytassuk?") = vbYes Then
        logba , strHiba, 0
        n = n + 1
        Resume Next
    Else
        logba , strHiba, 0
        GoTo ki
    End If
End Sub

Function ListTdfFields(t�blan�v As Variant) As Variant
'#################################################
'#
'# Ol�h Zolt�n (c) 2024 MIT
'#
'# Egy t�mb�t ad vissza, amelyiknek a
'# 0. dimenzi�ja tartalmazza a mez� nev�t,
'# 1. dimenzi�ja pedig a mez� t�pus�t
'# a t�blan�v nev� t�bl�ra �rtend�.
'#
'#################################################
If IsNull(t�blan�v) Then Exit Function
    Dim db As DAO.Database
    Dim tdf As DAO.TableDef
    Dim fld As DAO.Field
    Dim t�mb() As Variant
    Dim i As Long
    i = 0
    
    Set db = CurrentDb

    Set tdf = db.TableDefs(t�blan�v)
    ReDim t�mb(tdf.Fields.count, 1)

    For Each fld In tdf.Fields
        t�mb(i, 0) = fld.Name
        t�mb(i, 1) = fld.Type
        i = i + 1
    Next fld
    
    ListTdfFields = t�mb()
    
    Set tdf = Nothing
    Set db = Nothing
End Function
Function Els�dlegesKulcsMez�(ByVal t�blan�v As Variant, Optional adatb�zis As Variant = "", Optional o�rlap As Form) As String
'# Megkeresi, hogy az adott t�bl�ban van-e els�dleges mez�,
'# ha van, visszaadja a nev�t,
'# ha nincs, �res string-gel t�r vissza


    Dim db As DAO.Database
    Dim tdf As DAO.TableDef
    Dim fld As DAO.Field
    Dim log As Boolean
    If Not IsNull(o�rlap) Then: log = True
    
    ' Ha nincs megadva t�blan�v, vbNullString-et adunk vissza
    If t�blan�v = "" Or IsNull(t�blan�v) Then
        Els�dlegesKulcsMez� = vbNullString
        Exit Function
    End If
    
    ' Ha nincs megadva adatb�zisn�v, haszn�ljuk a CurrentDb-t
    If dbName = "" Or IsNull(adatb�zis) Then
        Set db = CurrentDb
    Else
        ' Ellenkez� esetben megpr�b�ljuk megnyitni a megadott adatb�zist
        On Error Resume Next
        Set db = OpenDatabase(adatb�zis)
        On Error GoTo 0
        
        ' Ha nem siker�l megnyitni az adatb�zist, hib�t jelz�nk �s kil�p�nk
        If db Is Nothing Then
            If log Then: sFoly o�rlap, t�blan�v & ":; nincs adatb�zisn�v"
            Els�dlegesKulcsMez� = vbNullString
            Exit Function
        End If
    End If
    
    ' Megpr�b�ljuk megnyitni a t�bl�t
    On Error Resume Next
    Set tdf = db.TableDefs(t�blan�v)
    On Error GoTo 0
    
    ' Ha nem siker�l megnyitni a t�bl�t, hib�t jelz�nk, �s kil�p�nk
    If tdf Is Nothing Then
        If log Then: sFoly o�rlap, t�blan�v & "Nem siker�lt megnyitni a t�bl�t."
        Els�dlegesKulcsMez� = vbNullString
        Exit Function
    End If
    
    ' Keres�nk egy mez�t, amely els�dleges kulcsk�nt van meghat�rozva
    For Each fld In tdf.Fields
        If fld.Attributes And dbAutoIncrField Then
            Els�dlegesKulcsMez� = fld.Name
            Exit Function
        End If
    Next fld
    
    ' Ha nem tal�ltunk els�dleges kulcsot, vbNullString-et adunk vissza
    Els�dlegesKulcsMez� = vbNullString
End Function

Function Mez�Vane(ByVal mez�n�v As Variant, ByVal t�blan�v As Variant, Optional adatb�zis As Variant = "", Optional o�rlap As Form) As Boolean
'# Megkeresi, hogy az adott t�bl�ban van-e els�dleges mez�, ha van visszaadja a nev�t, ha nincs �res string-gel t�r vissza
    Dim log As Boolean
        If Not IsNull(o�rlap) Then: log = True
    Dim db As DAO.Database
    Dim tdf As DAO.TableDef
    Dim fld As DAO.Field
    
    
    If IsNull(mez�n�v) Or mez�n�v = "" Then
        If log Then: sFoly o�rlap, t�blan�v & ":; nincs mez�n�v megadva"
        Exit Function
    End If
    
    
    ' Ha nincs megadva t�blan�v, vbNullString-et adunk vissza
    If t�blan�v = "" Or IsNull(t�blan�v) Then
        Mez�Vane = False
        Exit Function
    End If
    
    ' Ha nincs megadva adatb�zisn�v, haszn�ljuk a CurrentDb-t
    If dbName = "" Or IsNull(adatb�zis) Then
        Set db = CurrentDb
    Else
        ' Ellenkez� esetben megpr�b�ljuk megnyitni a megadott adatb�zist
        On Error Resume Next
        Set db = OpenDatabase(adatb�zis)
        On Error GoTo 0
        
        ' Ha nem siker�l megnyitni az adatb�zist, hib�t jelz�nk �s kil�p�nk
        If db Is Nothing Then
            If log Then: sFoly o�rlap, t�blan�v & ":; nincs adatb�zisn�v megadva"
            Mez�Vane = False
            Exit Function
        End If
    End If
    
    ' Megpr�b�ljuk megnyitni a t�bl�t
    On Error Resume Next
    Set tdf = db.TableDefs(t�blan�v)
    On Error GoTo 0
    
    ' Ha nem siker�l megnyitni a t�bl�t, hib�t jelz�nk �s kil�p�nk
    If tdf Is Nothing Then
        If log Then: sFoly o�rlap, t�blan�v & "Nem siker�lt megnyitni a t�bl�t."
        Mez�Vane = False
        Exit Function
    End If
    
    ' Keres�nk egy mez�t, amely els�dleges kulcsk�nt van meghat�rozva
    For Each fld In tdf.Fields
        If fld.Name = mez�n�v Then
            Mez�Vane = True
            Exit Function
        End If
    Next fld
    
    ' Ha nem tal�ltunk els�dleges kulcsot, vbNullString-et adunk vissza
    Mez�Vane = False
End Function
Function RenameColumn(R�giMezoNev As Variant, UjMezoNev As Variant, Optional tablaNev As Variant = "", Optional adatbazisNev As Variant = "", Optional o�rlap As Form) As Boolean
   Dim log As Boolean
        If Not IsNull(o�rlap) Then: log = True
        RenameColumn = False
    Dim db As Database
    Dim tblDef As TableDef
    Dim fld As Field
    
    
    On Error Resume Next
    If IsNull(mezoNev) Then: Exit Function

    
    If adatbazisNev = "" Or IsNull(adatbazisNev) Then
        Set db = CurrentDb
    Else
        Set db = OpenDatabase(adatbazisNev)
    End If
    
    If tablaNev = "" Or IsNull(tablaNev) Then: Exit Function
    
    Set tblDef = db.TableDefs(tablaNev)
    
    ' Ellen�rizz�k, hogy l�tezik-e a megadott mez�n�v a t�bl�ban
    For Each fld In tblDef.Fields
        If fld.Name = mezoNev Then
            ' Megv�ltoztatjuk a mez� nev�t
            tblDef.Fields(mezoNev).Name = UjMezoNev
            
            ' Friss�tj�k a t�bladefin�ci�t
            db.TableDefs.Refresh
            
            ' Igaz �rt�kkel t�r vissza
            RenameColumn = True
            Exit Function
        End If
    Next fld
    
    ' Ha a mez� n�v nem tal�lhat� a t�bl�ban
    RenameColumn = False
    
    ' Bez�rja az adatb�zis kapcsolat�t
    db.Close
End Function
Sub t�blamez�tulajdons�g�t�ll�t�(t�bla, mez�, propName, propValue, propType)
    Dim db As Database
    'Dim t�bla As TableDef
    'Dim mez� As Field
    Dim prop As Property
    'Dim propName As String
    'Dim propValue As String
    'Dim propType As Integer
    Dim propExists As Boolean
    
    ' Initialize variables
    Set db = CurrentDb
    Set t�bla = db.TableDefs(t�bla)
    Set mez� = t�bla.Fields(mez�)
'    propName = "Format"
'    propValue = "yyyy\.mm\.dd\."
'    propType = dbText
    propExists = False
    
    ' Check if the property already exists
    On Error Resume Next
    propValue = mez�.Properties(propName).Value
    If Err.Number = 0 Then
        propExists = True
    End If
    On Error GoTo 0
    
    ' Add or update the property
    If propExists Then
        mez�.Properties(propName).Value = propValue
    Else
        Set prop = db.CreateProperty(propName, propType, propValue)
        mez�.Properties.Append prop
    End If
    
    ' Print success message
    Debug.Print "Property set successfully."
    Set t�bla = Nothing
    Set db = Nothing
End Sub
