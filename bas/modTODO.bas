'E gy�tem�nyben, ha az MIT licencia eml�ttettik, (megjel�lve a szerz�t �s a m� sz�let�s�nek �v�t) azon az al�bbi felhaszn�l�si enged�lyt kell �rteni:

'Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"),
'to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software,
'and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
'The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
'THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
'FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
'WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
Option Compare Database
Option Explicit
Const � As String = ";"



Sub prooba()
    Dim D�tum
    Dim i As Integer
    D�tum = "2024.05.11."
    Debug.Print Timer
    For i = 1 To 1000
        D�tum = dt�tal(D�tum)
    Next i
    Debug.Print Timer
    For i = 1 To 1000
        D�tum = Replace(DateValue(Format(Replace(D�tum, ".", "/"), "mm/dd/yyyy")), " ", "")
    Next i
    Debug.Print Timer
End Sub
Function XMLoszlopok(strXML As String) As Variant()
    Dim t�mb() As Variant
    Dim oszlSz�m, mez�sz�m, i, j As Long
    Dim sor, mez� As String
    
    oszlSz�m = StrCount(strXML, "<Column Name=")
    sor = ffsplit(strXML, "<Column Name", 2)
    mez�sz�m = StrCount(sor, " ")
    sor = ""
    ReDim t�mb(1 To oszlSz�m, 1 To mez�sz�m)
    
    For i = 1 To oszlSz�m
        sor = ffsplit(strXML, "<Column Name", i) 'Eredm�ny: ="Col1" FieldName="Ad�jel" Indexed="YESDUPLICATES" SkipColumn="false" DataType="Double" />
        For j = 1 To mez�sz�m
            mez� = ffsplit(sor, " ", j) 'Eredm�ny: FieldName="Ad�jel" vagy FieldName="Sz�let�si
            t�mb(i, j) = TrimX(ffsplit(mez�, "=", 2), """") 'Eredm�ny: "Ad�jel" majd Ad�jel
        Next j
    Next i
    
    XMLoszlopok = t�mb
    Debug.Print t�mbDim(t�mb)
End Function
Sub ParseAndLoadXMLToTable(strXMLneve As String)
    Dim xmlDoc As Object
    Dim i, j As Integer
    Set xmlDoc = CreateObject("MSXML2.DOMDocument.6.0")
    
    ' Load the XML string from ImportExportSpecification
    'Dim strXMLneve As String
    'strXMLneve = "YourXMLSpecificationName" ' Replace with the actual name of your specification
    xmlDoc.LoadXML CurrentProject.ImportExportSpecifications.item(strXMLneve).XML
    
    ' Check if XML was loaded successfully
    If xmlDoc.parseError.ErrorCode <> 0 Then
        MsgBox "Error parsing XML: " & xmlDoc.parseError.reason
        Exit Sub
    End If
    
    ' Select all child nodes with the base name "Column"
    Dim columnNodes As Object
    Set columnNodes = xmlDoc.DocumentElement.SelectNodes("Column")
    
    ' Assuming you have an existing table named "YourTableName" with fields matching the XML structure
    Dim tableName As String
    tableName = "XML�rt�kek" ' Replace with the actual name of your table
    
    ' Array to store values
    Dim columnArray() As Variant
    ReDim columnArray(1 To xmlDoc.DocumentElement.ChildNodes.Length, 1 To 5)
    
    ' Loop through each <Column> element
    Dim columnNode As Object
    For Each columnNode In xmlDoc.getElementsByTagName("columns").ChildNodes
        Dim columnIndex As Long
        columnIndex = columnNode.GetAttribute("baseName")
        
        ' Populate the array
        columnArray(columnIndex, 1) = columnNode.GetAttribute("FieldName")
        columnArray(columnIndex, 2) = columnNode.GetAttribute("Indexed")
        columnArray(columnIndex, 3) = columnNode.GetAttribute("SkipColumn")
        columnArray(columnIndex, 4) = columnNode.GetAttribute("DataType")
    Next columnNode
    
    ' Open the existing table for appending records
    Dim db As Object
    Set db = CurrentDb
    Dim rs As Object
    Set rs = db.OpenRecordset(tableName, dbOpenTable, dbAppendOnly)
    
    ' Loop through the array and add records to the table
    For i = 1 To UBound(columnArray, 1)
        rs.AddNew
        For j = 1 To UBound(columnArray, 2)
            rs.Fields(columnArray(i, 1)).Value = columnArray(i, j)
        Next j
        rs.Update
    Next i
    
    ' Close the recordset
    rs.Close
    
    ' Display a message indicating success
    MsgBox "XML data loaded into table successfully!"
End Sub

Function nFrom(strLek�rdNeve As String) As Integer
'#MIT Ol�h Zolt�n (c) 2023
'Megsz�molja, hogy a lek�rdez�s h�ny
    Dim nDarab, i As Integer
    Dim fDarab As Integer
    Dim strSzakasz As String
    Dim strSQL As String
    
    strSQL = CurrentDb.QueryDefs(strLek�rdNeve).sql
    nDarab = StrCount(strSQL, "From")
    For i = 1 To 2 'nDarab
        strSzakasz = ffsplit(strSQL, "FROM", i)
        
        strSzakasz = ffsplit(strSzakasz, "SELECT")
        Debug.Print strSzakasz
        strSzakasz = ffsplit(strSzakasz, "UNION")
        Debug.Print strSzakasz
        strSzakasz = ffsplit(strSzakasz, "WHERE")
        Debug.Print strSzakasz
        strSzakasz = ffsplit(strSzakasz, "GROUP BY")
        Debug.Print strSzakasz
        fDarab = fDarab + StrCount(strSzakasz, ",") + 1
        Debug.Print strSzakasz, fDarab
    Next i
    nFrom = fDarab
End Function
Public Function xlT�blaImport(ByVal strF�jl As String, ByVal t�blan�v As String) As Boolean '�rlap As Form,
    '##################################
    Dim objExcel As Excel.Application
    Dim objBook As Excel.Workbook
    Dim objSheet As Excel.Worksheet
    Dim objRange As Excel.Range
    Set objExcel = Excel.Application
    Set objBook = objExcel.Workbooks.Open(strF�jl, ReadOnly:=True, IgnoreReadOnlyRecommended:=True, Editable:=False, Notify:=False)
    Set objSheet = objBook.Worksheets(t�blan�v)
    Set objRange = objSheet.Range("A2").CurrentRegion
    Debug.Print
End Function


Sub ImportExcelData(ByVal excelFileName As String, t�blan�v As String)
    Dim eApp As Object
    Dim eWb As Object
    Dim eWs As Object
    Dim db As Database
    Dim rs As Recordset
    Dim strSQL As String
    Dim eRng As Object
    Dim iMez�k As Integer
    Dim iRekordok As Integer
    Dim oszl, sor As Integer ' sz�ml�l�k
    Dim mT�pusok() As Variant
    
    ' Excel
    Set eApp = CreateObject("Excel.Application")
    Set eWb = eApp.Workbooks.Open(excelFileName)
    Set eWs = eWb.Sheets("Szem�lyt�rzs alapriport")
    Set eRng = eWs.Range("tSzem�lyek")
    
    iMez�k = eRng.Columns.count
    iRekordok = eRng.Rows.count
    ' Access
    Set db = CurrentDb
    
    ' Mez� adatok
   mT�pusok() = vMez�kT�pusaImporthoz(eRng)
    
    
    For sor = 2 To iRekordok 'soronk�nt / rekordonk�nt l�pked�nk
    
        strSQL = "INSERT INTO [" & t�blan�v & "] ("
        
        For oszl = 1 To iMez�k
            strSQL = strSQL & "[" & eRng.Cells(1, oszl).Value & "]"
            If oszl < iMez�k Then
                strSQL = strSQL & ", "
            End If
        Next oszl
        
        strSQL = strSQL & ") VALUES ("
        
        For oszl = 1 To iMez�k
            strSQL = strSQL & "'" & eRng.Cells(sor, oszl).Value & "'"
            If oszl < iMez�k Then
                strSQL = strSQL & ", "
            End If
        Next oszl
    
        strSQL = strSQL & ");"
        
        db.Execute strSQL
    Next sor
    
    ' Close and clean up
    eWb.Close
    Set eWs = Nothing
    Set eWb = Nothing
    eApp.Quit
    Set eApp = Nothing
    Set db = Nothing
End Sub

'Sub sqliz�()
''FeladatKat:
'a = IIf([a korm�nytisztvisel� feldatk�re] = "oszt�lyvezet�", _
'        Switch( _
'            [F�oszt�ly] Like "Eg�szs�gbizt*" Or [Oszt�ly] Like "Eg�szs�gbizt*", "eg�szs�gbiztos�t�si", _
'            [F�oszt�ly] Like "Rehabil*" Or [Oszt�ly] Like "Rehab*", "rehabilit�ci�s", _
'            [F�oszt�ly] Like "N�peg�szs�g*" Or [Oszt�ly] Like "N�peg�szs�g*", "n�peg�szs�g�gyi"), _
'        Switch( _
'            [a korm�nytisztvisel� feladatk�re] Like "Eg�szs�gbizt*", "eg�szs�gbiztos�t�si", _
'            [a korm�nytisztvisel� feladatk�re] Like "Rehab*", "rehabilit�ci�s", _
'            [a korm�nytisztvisel� feladatk�re] Like "N�peg�szs�g*", "n�peg�szs�g�gyi") _
'        )
'End Sub

Sub jsonPr�ba()

    Dim json As Object
    Dim jsonString As String
    
    jsonString = DLookup("Pr�ba", "T�bla3", "Azonos�t�=2")
    Set json = ParseJson(jsonString) 'JsonConverter.ParseJson(jsonString)
    
    'Access values from the parsed JSON
    MsgBox "activetab: " & json("activetab")
    MsgBox "tag_states: " & json("tag_states")
    MsgBox "count: " & json("count")
End Sub
Sub ParseComplexJSON()
    Dim json As Object
    Dim jsonString As String
    Dim item As Variant
    Dim searchArray As Object

    jsonString = DLookup("Pr�ba", "T�bla3", "Azonos�t�=1")
    
    ' Parse the JSON string
    Set json = ParseJson(jsonString)

    ' Access and display "activetab"
    MsgBox "Active Tab: " & json("activetab")

    ' Check if "tag_states" is an empty object (dictionary)
    If json("tag_states").count = 0 Then
        MsgBox "Tag States is empty"
    End If

    ' Access the "data-prev-search" array
    Set searchArray = json("data-prev-search")
    
    ' Loop through the array and display each element's "text" and "count"
    For Each item In searchArray
        MsgBox "Search Text: " & item("text") & ", Count: " & item("count")
    Next item
End Sub

Sub t�blaUtols�Friss�t�se(t�blan�v As String)
    Dim db As Database
    Dim t�bla As TableDef
    Dim a As Integer
    Set db = CurrentDb
    a = 1
    For Each t�bla In db.TableDefs
        If t�bla.Name = t�blan�v Then
            Debug.Print vbNewLine & t�bla.LastUpdated
            Exit Sub
        Else
            � (".")
            If �(a) Mod 10 = 0 Then � vbNewLine
        End If
    Next
    
End Sub
Sub halad�s()
    Dim ehj As New ehjoszt
    
    Dim i, j, x
    ehj.Ini 100
    ehj.oszlopszam = 0
    
    For i = 0 To ehj.oszlopszam
    ehj.Novel
        
        For j = 0 To 100000000
            If j Mod 1000000 = 0 Then
                
            End If
        Next j
    Next i
End Sub
Sub Lek�rdez�s�r�()
'Licencia: MIT Ol�h Zolt�n 2022 (c)
    Dim db As DAO.Database
    Dim rs As Recordset
    Dim rs2 As Recordset
    Dim sql As String
    Dim sql2 As String
    Dim kSQL As String
    Dim lek�rd As String
    Dim �jn�v As String
    Dim x As Integer
    Dim Tal�lat, dbTal�lat As Integer
    Set db = CurrentDb
    sql = "SELECT AccessN�v, Hi�ny_lek�rdez�s FROM tImport�land�T�bl�k"
    Set rs = db.OpenRecordset(sql)
    
    Do Until rs.EOF
        sql2 = "SELECT Import, Eredeti  FROM tJav�tand�Mez�nevek WHERE T�bla ='" & rs!AccessN�v & "' AND NemK�telez� = false ;"
        Set rs2 = db.OpenRecordset(sql2)
        kSQL = ""
        Do Until rs2.EOF
            If kSQL <> "" Then kSQL = kSQL & ", " & Chr(10)
            �jn�v = RIC(Clean_NPC(rs2!eredeti.Value))
            If Len(�jn�v) > 64 Then
                �jn�v = Left(�jn�v, 60)
            End If
            dbTal�lat = 0
            Tal�lat = InStr(1, kSQL, �jn�v) 'Az �j n�v szerepelt-e m�r az el�z�ekben
            Do Until dbTal�lat >= Tal�lat 'Ha igen, akkor a Tal�lat nagyobb, mint a db tal�lat
                dbTal�lat = Tal�lat 'el�re toljuk a m�r�si pontot,
                Tal�lat = InStr(dbTal�lat, kSQL, �jn�v) 'megn�zz�k innen is,
            Loop 'hogy nagyobb �rt�ket kapunk-e, mint kor�bban (ami most a dbTal�lat)
            If dbTal�lat > 0 Then
                �jn�v = �jn�v & dbTal�lat + 1
            End If
            If InStr(1, kSQL, �jn�v) > 0 Then
                '�jn�v
                dbTal�lat = dbTal�lat + 1
            End If
            If Len(�jn�v) = 0 Then MsgBox "!": GoTo kij�rat
            kSQL = kSQL & rs!Hi�ny_lek�rdez�s.Value & ".[" & rs2!Import.Value & "] AS " & �jn�v
            rs2.MoveNext 'a k�vetkez� mez�re ugrunk
        Loop 'rs2

        kSQL = "SELECT " & kSQL & " FROM " & rs!Hi�ny_lek�rdez�s & ";"
        lek�rd = "oz_" & rs!Hi�ny_lek�rdez�s & "2"
        
        If Not IsNull(DLookup("Type", "MSYSObjects", "Name='" & lek�rd & "'")) Then
            db.QueryDefs(lek�rd).sql = kSQL
        Else
            db.CreateQueryDef lek�rd, kSQL
        End If
        'Debug.Print kSQL
        rs.MoveNext 'A k�vetkez� t�bl�ra ugrunk
    Loop 'rs

kij�rat:

End Sub
Sub pr�ba02(amibenKeres�nk As String, amitKeres�nk As String)
    Dim Eredm�ny As MatchCollection
   ' Debug.Print RegExp(amibenKeres�nk, amitKeres�nk).item(0).Value
End Sub
Sub Keres�(keresett)
Dim elem As QueryDef
Dim t�bla As TableDef
Dim mez� As Field
Dim modul As Module
    Debug.Print "Lek�rdez�sek:"
    For Each elem In CurrentDb.QueryDefs
        If InStr(1, elem.sql, keresett) > 0 Then
            Debug.Print elem.Name
        End If
    Next
    Debug.Print "---------"
    'Exit Sub
    Debug.Print "T�bl�k:"
    For Each t�bla In CurrentDb.TableDefs
        For Each mez� In t�bla.Fields
            If InStr(1, mez�.Name, keresett) > 0 Then
                Debug.Print t�bla.Name, mez�.Name
            End If
        Next
    Next
    Debug.Print "---------"
    Debug.Print "Modulok:"
    For Each modul In Application.Modules
        If InStr(1, modul.Lines(1, modul.CountOfLines), keresett) Then
            Debug.Print modul.Name
        End If
    Next
    Debug.Print "========="
End Sub
Sub n�vel�tesztel�()
Dim n As Integer
n = 1
Debug.Print �(n)
� n
Debug.Print n
� �(n), �: � �(n)


End Sub
Sub lek�rdez�sSorsz�moz�(lek�rdez�sN�v As String)
    Dim db As Database
    Dim qry As QueryDef
    Dim sql As String
    Dim rs As Recordset
    
  
    Set db = CurrentDb
    Set rs = db.OpenRecordset("lkSzem�lyek", dbOpenSnapshot)
    sql = "Select top 1 %%%# from msysobjects;"
    
    Set qry = db.CreateQueryDef(lek�rdez�sN�v, sql)
    
    DoCmd.OpenQuery lek�rdez�sN�v, acViewNormal, acReadOnly
       
End Sub