Public Sub ExportQueriesAndProceduresToFiles()
fvbe ("ExportQueriesAndProceduresToFiles")
    Dim db As DAO.Database
    Dim qdf As DAO.QueryDef
    Dim strExportPath As String
    Dim mappa As String
    Dim strfilename As String
    Dim strDBnev As String 'az adatb�zis nev�nek
    Dim fso As Object
    Dim ts As Object
    Dim con As Object ' Container for modules
    Dim mdl As Object ' Module
    Dim mentett As ImportExportSpecification

    Dim objektumn�v As String
    Dim �zenet As String
    Dim sorokSz�ma As Long
    Const t�blaszerkezettel As Boolean = True
    
'   Dim mdls As Modules
    
'   On Error GoTo ErrorHandler
    
    ' Set the export path where the files will be saved
    strExportPath = "L:\Ugyintezok\Adatszolg�ltat�k\Adatb�zisok\F�jlok\" ' Change this to your desired export path
    
    Set db = CurrentDb
    Set fso = CreateObject("Scripting.FileSystemObject")
    strDBnev = Replace(ffsplit(db.Name, "\", StrCount(db.Name, "\") + 1), ".accdb", "")
    strExportPath = strExportPath & strDBnev & Year(Date) & Right(Replace("0" & Month(Date), "00", "0"), 2) & Right(Replace("0" & Day(Date), "00", "0"), 2) & "\"
    
    konyvtarzo strExportPath

' lek�rdez�sek ki�rat�sa
        If lek�rdez�sekki�rat�sa(strExportPath, db) Then
            �zenet = n�vel�vel(db.QueryDefs.count, False, True) & "db. lek�rdez�s ki�rat�sa siker�lt."
            logba , n�vel�vel(db.QueryDefs.count, False, True) & "db. lek�rdez�s ki�rat�sa siker�lt.", 1
        Else
            �zenet = "A lek�rdez�sek ki�rat�sa nem siker�lt."
            logba , "A lek�rdez�sek ki�rat�sa nem siker�lt", 1
        End If
    
' modulok ki�rat�sa Application.Modules gy�jtem�nyb�l
        sorokSz�ma = modulokki�rat�sa(strExportPath, db)
        If sorokSz�ma Then
            �zenet = �zenet & vbNewLine & n�vel�vel(Application.Modules.count) & "db. modul ki�rat�sa siker�lt. A sorok sz�ma �sszesen:" & sorokSz�ma
            logba , n�vel�vel(Application.Modules.count) & "db. modul ki�rat�sa siker�lt. A sorok sz�ma �sszesen:" & sorokSz�ma, 1
        Else
            �zenet = �zenet & vbNewLine & "A modulok ki�rat�sa nem siker�lt."
            logba , "A modulok ki�rat�sa nem siker�lt", 1
        End If
    
'Mentett ExportImport-ok ki�rat�sa
        If mentettexportimportXMLekki�rat�sa(strExportPath, db) Then
            �zenet = �zenet & vbNewLine & "A Mentett ExportImport-ok ki�rat�sa siker�lt."
            logba , "A Mentett ExportImport-ok ki�rat�sa siker�lt", 1
        Else
            �zenet = �zenet & vbNewLine & "A Mentett ExportImport-ok ki�rat�sa nem siker�lt."
            logba , "A Mentett ExportImport-ok ki�rat�sa nem siker�lt", 1
        End If

'T�blaszerkezet export
        If t�blaszerkezettel Then
            logba , "T�blaszerkezet-> SQL kezd�dik"
            mappa = "SQL\"
            strfilename = strExportPath & mappa & RIC(strDBnev) & "_" & "t�bl�k.sql" 'dif
            konyvtarzo strExportPath & mappa 'dif
            GenerateSQLBackup strfilename, db
        End If
    If MsgBox(�zenet & vbNewLine & "Az elk�sz�tett �llom�ny ebbe a mapp�ba ker�ltek:" & vbNewLine & _
            strExportPath & vbNewLine & _
            "Megnyissam a k�nyvt�rat?", vbYesNo) _
        Then
        CreateObject("Wscript.Shell").Run (strExportPath)
    End If
    Set fso = Nothing
    Set db = Nothing
Exit Sub
    
    
ErrorHandler:
    MsgBox "An error occurred: " & Err.Description, vbExclamation
    
End Sub
Function lek�rdez�sekki�rat�sa(strExportPath As String, db As Database) As Boolean
Dim hibasz�m As Integer
Dim ts As Object
Dim qdf As QueryDef
Dim strDBnev As String, _
    mappa As String, _
    strFileFame As String
Dim fso As Object



strDBnev = Replace(ffsplit(db.Name, "\", StrCount(db.Name, "\") + 1), ".accdb", "")
lek�rdez�sekki�rat�sa = False
On Error GoTo Hiba:

    mappa = "lk\"
    Set fso = CreateObject("Scripting.FileSystemObject")
    strfilename = strExportPath & mappa & RIC(strDBnev) & "_" & "lekerdezesek.sql" 'dif
    konyvtarzo strExportPath & mappa 'dif
    Set ts = fso.CreateTextFile(strfilename, True) 'dif
    For Each qdf In db.QueryDefs
        If Not qdf.Name Like "~*" Then ' Exclude system queries
            'konyvtarzo strExportPath & mappa 'dif
            'strFileName = strExportPath & mappa & qdf.Name & ".sql" 'dif
            'Set ts = fso.CreateTextFile(strFileName, True)
            ts.WriteLine "#/#/#/" 'dif
            ts.WriteLine qdf.Name 'dif
            ts.WriteLine "#/#/" 'dif
            ts.WriteLine qdf.sql 'dif
        End If
    Next qdf
    ts.Close 'dif
    Set ts = Nothing 'dif
lek�rdez�sekki�rat�sa = True
ki:
Exit Function
Hiba:
    lek�rdez�sekki�rat�sa = False
    MsgBox Hiba(Err)
    � hibasz�m
    If hibasz�m < 10 Then
        Resume Next
    End If
    
End Function

Function modulokki�rat�sa(strExportPath, db As Database) As Long
    Dim hibasz�m As Integer
    Dim ts As Object
    Dim qdf As QueryDef
    Dim strDBnev As String, _
        mappa As String, _
        strFileFame As String
    Dim sorokSz�ma As Long
    Dim mdl As Module
        
    strDBnev = Replace(ffsplit(db.Name, "\", StrCount(db.Name, "\") + 1), ".accdb", "")
    sorokSz�ma = 0
    On Error GoTo Hiba:
        mappa = "bas\"
    Set fso = CreateObject("Scripting.FileSystemObject")
        For i = 0 To Application.Modules.count - 1 ' mdl In Application.Modules
            Set mdl = Application.Modules(i)
            If Not mdl.Name Like "msys*" Then ' Exclude system modules
                konyvtarzo strExportPath & mappa
                strfilename = strExportPath & mappa & RIC(mdl.Name) & ".bas"
                Set ts = fso.CreateTextFile(strfilename, True)
                sorokSz�ma = sorokSz�ma + mdl.CountOfLines
                ts.Write mdl.Lines(1, mdl.CountOfLines)
                'Debug.Print mdl.ProcStartLine
                ts.Close
                Set ts = Nothing
            End If
        Next i
    modulokki�rat�sa = sorokSz�ma
    ki:
    Exit Function
    Hiba:
        
        Hiba Err
        � hibasz�m
        If hibasz�m < 10 Then
            Resume Next
        End If
        modulokki�rat�sa = 0
End Function

Function mentettexportimportXMLekki�rat�sa(strExportPath, db As Database) As Boolean
    Dim hibasz�m As Integer
    Dim ts As Object
    Dim qdf As QueryDef
    Dim strDBnev As String, _
        mappa As String, _
        strFileFame As String
        
        strDBnev = Replace(ffsplit(db.Name, "\", StrCount(db.Name, "\") + 1), ".accdb", "")
        mentettexportimportXMLekki�rat�sa = False
        On Error GoTo Hiba:
            mappa = "XML\"
            Set fso = CreateObject("Scripting.FileSystemObject")
            For i = 0 To CurrentProject.ImportExportSpecifications.count - 1
                Set mentett = CurrentProject.ImportExportSpecifications.item(i)
                With mentett
                    konyvtarzo strExportPath & mappa
                    strfilename = strExportPath & mappa & RIC(.Name) & ".XML"
                    Set ts = fso.CreateTextFile(strfilename, True)
                    ts.Write .XML
                    ts.Close
                    Set ts = Nothing
                End With
            Next i
        mentettexportimportXMLekki�rat�sa = True
    ki:
        Exit Function
    Hiba:
        mentettexportimportXMLekki�rat�sa = False
        Hiba Err
        � hibasz�m
        If hibasz�m < 10 Then
            Resume Next
        End If
        
End Function
Function f�gg�k(lekn�v)
    Dim db As DAO.Database
    Set db = CurrentDb
    Dim qdf As QueryDef

        For Each qdf In db.QueryDefs
            If Not qdf.Name Like "~*" Then ' Exclude system queries
                If InStr(1, qdf.sql, lekn�v) Then
                    f�gg�k = f�gg�k & qdf.Name & ","
                End If
            End If
        Next qdf
        f�gg�k = Left(f�gg�k, Len(f�gg�k) - 1)
    End Function
    Sub konyvtarzo(�tvonal As String)
    'Ha a megadott k�nyvt�r nem l�tezik, akkor l�tre hoz egyet.
        If Dir(�tvonal, vbDirectory) = "" Then
            MkDir �tvonal
        End If
End Sub




Sub ExportImportSpecXMLToFile(importSpecName As String, exportFilePath As String)
    On Error GoTo ErrorHandler
    
    Dim db As Database
    Dim impSpec As ImportExportSpecification
    Dim xmlData As String
    Dim fileNumber As Integer
    
    ' Open the current database.
    Set db = CurrentDb
    
    ' Get the ImportExportSpecification object by name.
    'Set impSpec = db.ImportExportSpecifications(importSpecName)
    
    ' Get the XML data of the import specification.
    xmlData = impSpec.XML
    
    ' Create a new text file for export.
    fileNumber = FreeFile
    Open exportFilePath For Output As #fileNumber
    
    ' Write the XML data to the file.
    Print #fileNumber, xmlData
    
    ' Close the file.
    Close #fileNumber
    
    ' Display a success message.
    MsgBox "Import specification XML exported to " & exportFilePath, vbInformation + vbOKOnly, "Export Completed"
    
    Exit Sub
    
ErrorHandler:
    ' Display an error message if something goes wrong.
    MsgBox "Error: " & Err.Description, vbExclamation + vbOKOnly, "Error"
End Sub
Sub meghagy�sLek()
    Dim db As DAO.Database
    Dim qdf As DAO.QueryDef
    Dim strExportPath As String
    Dim mappa As String
    Dim strfilename As String
    Dim strDBnev As String 'az adatb�zis nev�nek
    Dim fso As Object
    Dim ts As Object

    Dim mentett As ImportExportSpecification

    strExportPath = "C:\Users\olahzolt\Desktop\F�jlok\Meghagy�s\"
    
    Set db = CurrentDb
    Set fso = CreateObject("Scripting.FileSystemObject")
    strDBnev = Replace(ffsplit(db.Name, "\", StrCount(db.Name, "\") + 1), ".accdb", "")
    strExportPath = strExportPath & Year(Date) & Right(Replace("0" & Month(Date), "00", "0"), 2) & Right(Replace("0" & Day(Date), "00", "0"), 2) & "\"
    
    konyvtarzo strExportPath
    
    'mappa = "lk\"
    strfilename = strExportPath & mappa & strDBnev & "_" & "lekerdezesek.sql"
    konyvtarzo strExportPath & mappa
    Set ts = fso.CreateTextFile(strfilename, True)
    For Each qdf In db.QueryDefs
    
        If qdf.Name Like "*eghagy�s*" Then
Debug.Print qdf.Name
            'ts.Writeline "#/#/#/"
            'ts.Writeline qdf.Name
            'ts.Writeline "#/#/"
            ts.WriteLine qdf.sql
        End If
    Next qdf
    ts.Close 'dif
    Set ts = Nothing 'dif
    Debug.Print "K�sz!"
End Sub


Public Sub ExportDatabaseObjects()
fvbe ("ExportDatabaseObjects")
On Error GoTo Err_ExportDatabaseObjects
    
    Dim db As Database
    'Dim db As DAO.Database
    Dim td As TableDef
    Dim d As Document
    Dim c As Container
    Dim i As Integer
    Dim sExportLocation As String
    Dim strDBnev As String
    Dim n As Integer
    
    sExportLocation = "L:\Ugyintezok\Adatszolg�ltat�k\Adatb�zisok\F�jlok\" 'Do not forget the closing back slash! ie: C:\Temp\
    
    Set db = CurrentDb()
    strDBnev = Replace(ffsplit(db.Name, "\", StrCount(db.Name, "\") + 1), ".accdb", "")
    sExportLocation = sExportLocation & strDBnev & Year(Date) & Right(Replace("0" & Month(Date), "00", "0"), 2) & Right(Replace("0" & Day(Date), "00", "0"), 2) & "\"
    
    konyvtarzo sExportLocation
    
'    For Each td In db.TableDefs 'Tables
'        If Left(td.Name, 4) <> "MSys" Then
'            DoCmd.TransferText acExportDelim, , td.Name, sExportLocation & "Table_" & td.Name & ".txt", True, , 1250
'        End If
'    Next td
    
    Set c = db.Containers("Forms")
    For Each d In c.Documents
'        � n
'        Debug.Print d.Name, sExportLocation & "Form_" & RIC(d.Name, "_") & ".txt", n
        konyvtarzo sExportLocation & "Form\"
        Application.SaveAsText acForm, d.Name, sExportLocation & "Form\" & RIC(d.Name, "_") & ".txt"
    Next d

    Set c = db.Containers("Reports")
    For Each d In c.Documents
        konyvtarzo sExportLocation & "Report\"
        Application.SaveAsText acReport, d.Name, sExportLocation & "Report\" & RIC(d.Name, "_") & ".txt"
    Next d
    
    Set c = db.Containers("Scripts")
    For Each d In c.Documents
        konyvtarzo sExportLocation & "Macro\"
        Application.SaveAsText acMacro, d.Name, sExportLocation & "Macro\" & RIC(d.Name, "_") & ".txt"
    Next d
    
    Set c = db.Containers("Modules")
    For Each d In c.Documents
        konyvtarzo sExportLocation & "Module\"
        Application.SaveAsText acModule, d.Name, sExportLocation & "Module\" & RIC(d.Name, "_") & ".txt"
    Next d
    
    For i = 0 To db.QueryDefs.count - 1
        konyvtarzo sExportLocation & "Query\"
        Application.SaveAsText acQuery, db.QueryDefs(i).Name, sExportLocation & "Query\" & RIC(db.QueryDefs(i).Name, "_") & ".txt"
    Next i
    
    Set db = Nothing
    Set c = Nothing
    
    logba , "All database objects have been exported as a text file to " & sExportLocation, vbInformation
    
Exit_ExportDatabaseObjects:
fvki
    Exit Sub
    
Err_ExportDatabaseObjects:
    If Err.Number = 32584 Then
        Debug.Print "Nem tal�lta a k�vetkez� objektumot:" & d.Name
        Resume Next
    End If
    If Err.Number = 3270 Then
        Debug.Print d.Name
        Resume Next
    End If
    MsgBox Err.Number & " - " & Err.Description
    Resume Exit_ExportDatabaseObjects
fvki
End Sub
Sub GenerateSQLBackup(f�jln�v As String, db As DAO.Database)
fvbe ("GenerateSQLBackup")
    'Dim db As DAO.Database
    Dim tbl As DAO.TableDef
    Dim fld As DAO.Field
    Dim idx As DAO.Index
    Dim rel As DAO.Relation
    Dim strSQL As String
    Dim folyt As Boolean
    Dim outputFile As Integer
    Dim sz�ml As Integer
    Dim ehj As New ehjoszt
    Dim el�z�szakasz As Long, _
        SzakaszSz�m As Long
    
    ' Set database
    'Set db = CurrentDb
    
    ' Specify the path for the output SQL file
    filePath = f�jln�v '"C:\path\to\your\backup.sql"
    outputFile = FreeFile
    
    ' Open the output file
    Open filePath For Output As outputFile
    folyt = False
    ehj.Ini 100
    ehj.oszlopszam = db.TableDefs.count
    el�z�szakasz = 0
    SzakaszSz�m = 8 '12,5%-konk�nt jelezz�k ki az �rt�ket
                                                                                                logba , ehj.oszlopszam & " db. t�bla beolvas�sa", 1
    ' Loop through all tables
    sz�ml = 0
    For Each tbl In db.TableDefs
        On Error GoTo Hiba
        logba , tbl.Indexes.count, 3
        On Error GoTo 0
        If folyt = True Then
            folyt = False
        Else
            ' Skip system and temporary tables
                                                                                                logba , tbl.Name & " nev� t�bla feldolgoz�sa megkezdve...", 1
            If Left(tbl.Name, 4) <> "MSys" And Left(tbl.Name, 1) <> "~" Then
                ' Create table SQL
                strSQL = "CREATE TABLE [" & tbl.Name & "] (" & vbCrLf
                
                ' Loop through all fields in the table
                
                For Each fld In tbl.Fields
                    strSQL = strSQL & "[" & fld.Name & "] " & GetFieldType(fld) & " " & _
                             IIf(fld.Required, "NOT NULL", "NULL") & "," & vbCrLf
                                                                                                logba , strSQL, 4
                Next fld
                                                                                                logba , "Fields:" & tbl.Fields.count, 3
                ' Remove the last comma and add closing parenthesis
                strSQL = Left(strSQL, Len(strSQL) - 3) & vbCrLf & ");" & vbCrLf
                
                ' Write SQL to file
                Print #outputFile, strSQL
                
                ' Add indexes
                logba , tbl.Name & " t�bla indexeinek sz�ma:" & tbl.Indexes.count, 3
                For Each idx In tbl.Indexes
                    If Not idx.Primary Then
                        strSQL = "CREATE INDEX [" & idx.Name & "] ON [" & tbl.Name & "] ("
                        For Each fld In idx.Fields
                            strSQL = strSQL & "[" & fld.Name & "],"
                        Next fld
                        strSQL = Left(strSQL, Len(strSQL) - 1) & ");" & vbCrLf
                        Print #outputFile, strSQL
                                                                                                logba , strSQL, 4
                    End If
                Next idx
                                                                                                logba , tbl.Indexes.count, 3
                ' Add primary key constraint
                sz�ml = 0
                For Each idx In tbl.Indexes
                    If idx.Primary Then
                        strSQL = "ALTER TABLE [" & tbl.Name & "] ADD CONSTRAINT [PK_" & tbl.Name & "] PRIMARY KEY ("
                        For Each fld In idx.Fields
                            strSQL = strSQL & "[" & fld.Name & "],"
                        Next fld
                        strSQL = Left(strSQL, Len(strSQL) - 1) & ");" & vbCrLf
                        Print #outputFile, strSQL
                        � sz�ml
                        logba , tbl.Name & " t�bl�nak a megszor�t� felt�telei ki�rva", 3
                    End If
                Next idx
                                                                                                logba , tbl.Name & " nev� t�bla szerkezete ki�rva. Indexek sz�ma:" & tbl.Indexes.count & "; megszor�t� felt�telek sz�ma:" & sz�ml
            End If
        End If
    ehj.Novel
        If Int(ehj.Value / ehj.oszlopszam * SzakaszSz�m) > el�z�szakasz Then
                                                                                                logba , accT�bla & ":;" & Int(ehj.Value / ehj.oszlopszam * 100) & "% elk�sz�lt...", 1
            el�z�szakasz = Int(ehj.Value / ehj.oszlopszam * SzakaszSz�m)
            Debug.Print "DoEvents"
            DoEvents
        End If
    Next tbl
    Debug.Print "Relations:",
    ' Add relationships (foreign keys)
    ehj.Ini
    ehj.oszlopszam = db.Relations.count
    sz�ml = 0
                                                                                                logba , "Kapcsolatok sz�ma:" & ehj.oszlopszam, 1
    For Each rel In db.Relations
        If rel.Attributes = 0 Then ' Ignore internal relationships
            strSQL = "ALTER TABLE [" & rel.Table & "] ADD CONSTRAINT [" & rel.Name & "] FOREIGN KEY ("
            For Each fld In rel.Fields
                strSQL = strSQL & "[" & fld.Name & "],"
            Next fld
            strSQL = Left(strSQL, Len(strSQL) - 1) & ") REFERENCES [" & rel.ForeignTable & "] ("
            For Each fld In rel.Fields
                strSQL = strSQL & "[" & fld.ForeignName & "],"
            Next fld
            strSQL = Left(strSQL, Len(strSQL) - 1) & ");" & vbCrLf
            Print #outputFile, strSQL
                                                                                                logba , strSQL, 4
        End If
        
        ehj.Novel
    
                                                                                                logba , "A ki�rt rel�ci�k sz�ma:" & ehj.Value
        If Int(ehj.Value / ehj.oszlopszam * SzakaszSz�m) > el�z�szakasz Then
            logba , accT�bla & ":;" & Int(ehj.Value / ehj.oszlopszam * 100) & "% elk�sz�lt...", 1
            el�z�szakasz = Int(ehj.Value / ehj.oszlopszam * SzakaszSz�m)
            DoEvents
        End If
    Next rel
    � ehj.Value
    ' Close the file
    Close #outputFile
    
    ' Notify the user
    MsgBox "SQL backup created successfully at " & filePath
Exit Sub
Hiba:
    If Err.Number = 3044 Or Err.Number = 3110 Then
        folyt = True
        Resume Next
    End If

End Sub

' Function to determine the SQL data type based on Access field type
Function GetFieldType(fld As DAO.Field) As String
    Select Case fld.Type
        Case dbText
            GetFieldType = "TEXT(" & fld.Size & ")"
        Case dbMemo
            GetFieldType = "MEMO"
        Case dbByte
            GetFieldType = "BYTE"
        Case dbInteger
            GetFieldType = "SHORT"
        Case dbLong
            GetFieldType = "LONG"
        Case dbSingle
            GetFieldType = "SINGLE"
        Case dbDouble
            GetFieldType = "DOUBLE"
        Case dbCurrency
            GetFieldType = "CURRENCY"
        Case dbDate
            GetFieldType = "DATETIME"
        Case dbBoolean
            GetFieldType = "YESNO"
        Case dbDecimal
            GetFieldType = "DECIMAL" '(" & fld.Precision & "," & fld.Scale & ")"
        Case dbGUID
            GetFieldType = "GUID"
        Case dbBinary
            GetFieldType = "BINARY"
        Case Else
            GetFieldType = "UNKNOWN"
    End Select
End Function
Sub projektekki�rat�sa(strExportPath)
    Dim objektumn�v As String
    Dim projekt As CurrentProject
    Dim accObj As AccessObject
    Dim strfilename As String
    
        Set projekt = Application.CurrentProject
        mappa = "Forms\"
logba , "Forms kezd�dik", 1
        For Each accObj In projekt.AllForms
            objektumn�v = accObj.Name
            strfilename = strExportPath & mappa & RIC(accObj.Name) & ".txt"
            konyvtarzo strExportPath & mappa
            Application.SaveAsText acForm, objektumn�v, strfilename
                                    logba , "�rlap neve:" & accObj.Name, 3
        Next accObj

End Sub
Sub riportokki�rat�sa(strExportPath)
    Dim accObj As AccessObject
    Dim objektumn�v As String
    Dim strfilename As String
    
logba , "Reports kezd�dik", 1
        mappa = "Jelent�sek\"
        For Each accObj In projekt.AllReports
            objektumn�v = accObj.Name
            strfilename = strExportPath & mappa & RIC(accObj.Name) & ".txt"
            konyvtarzo strExportPath & mappa
            Application.SaveAsText acTable, objektumn�v, strfilename
                                    logba , "�rlap neve:" & accObj.Name, 3
        Next accObj
End Sub
