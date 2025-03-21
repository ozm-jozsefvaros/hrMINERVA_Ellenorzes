'E gy�tem�nyben, ha az MIT licencia eml�ttettik, (megjel�lve a szerz�t �s a m� sz�let�s�nek �v�t) azon az al�bbi felhaszn�l�si enged�lyt kell �rteni:

'Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"),
'to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software,
'and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
'The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
'THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
'FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
'WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
Option Compare Database

Function test()
    Debug.Print "teszt"
    caller "fvVane"
End Function
Sub caller(fvn�v)
fvn�v = RIC(fvn�v)
Dim fv As String
    If fvVane(fvn�v) Then
        Eval (fvn�v & "()")
    End If
End Sub
Function fvVane(ByVal fvn�v As String) As Boolean
    ' Check if a procedure with the given name exists in the current module
    
    For Each modul In Application.VBE.ActiveVBProject.VBComponents
        On Error Resume Next
            fvVane = Not IsNull(modul.CodeModule.ProcBodyLine(fvn�v, vbext_pk_Proc))
        On Error GoTo 0
    Next modul

End Function
Sub tSzem�lyekImport()
fvbe ("tSzem�lyekImport")
    On Error GoTo ErrorHandler

    Dim dlg As FileDialog
    Dim selectedFilePath As String
    Dim importSpecName As String
    Dim strXML As String
    Dim strR�giF�jl As String
    Dim str�jF�jl As String
    Dim intKezdPoz As Integer
    Dim intV�gPoz As Integer

    ' Replace "YourSavedImportSpecificationName" with the name of your saved import specification.
    importSpecName = "tSzem�lyek"


    ' Create a FileDialog object to allow the user to select a file.
    Set dlg = Application.FileDialog(msoFileDialogFilePicker)

    ' Set the title and filters for the dialog box.
    dlg.Title = "Szem�lt�rzs alapriport kiv�laszt�sa"
    dlg.Filters.Clear
    dlg.Filters.Add "All Files", "*.xlsx"

    ' Show the FileDialog and check if the user selected a file.
    If dlg.Show = -1 Then
        ' Get the selected file path and name.
        str�jF�jl = " Path=""" & dlg.SelectedItems(1) & """"
'            Debug.Print "1. �j f�jl:" & str�jF�jl & "##" '1
        UresOszlopokTorlese dlg.SelectedItems(1)

        '�t�rjuk az XML-t
        On Error Resume Next
            strXML = CurrentProject.ImportExportSpecifications.item(importSpecName).XML 'Itt megszerezz�k
            If Err.Number <> 0 Then
                MsgBox "Error updating the XML of the import specification.", vbExclamation + vbOKOnly, "Error"
            End If
        On Error GoTo ErrorHandler
        intKezdPoz = InStr(1, strXML, "Path=") 'majd megn�zz�k, hol kezd�dik az �tvonal
        intV�gPoz = InStr(intKezdPoz + 7, strXML, """") ' �s hogy hol a v�ge
'            Debug.Print "2. R�gi XML:##" & Mid(strXML, intKezdPoz, intV�gPoz) & "##" '2
        strR�giF�jl = Mid(strXML, intKezdPoz, intV�gPoz - intKezdPoz + 1) 'a k�t pont k�z�tti r�szt kiemelj�k
'            Debug.Print "3. R�gi f�jl:" & strR�giF�jl
        strXML = Replace(strXML, strR�giF�jl, str�jF�jl) 'No itt meg kicser�lj�k a r�gi f�jlnevet, az �jra
'            Debug.Print "4. �j XML:##" & Mid(strXML, intKezdPoz - 10, Len(str�jF�jl) + 16) & "##"
        CurrentProject.ImportExportSpecifications.item(importSpecName).XML = strXML
        ' Run the saved import specification with the selected file.
        DoCmd.RunSavedImportExport importSpecName

        ' Display a success message.
        'MsgBox "Import completed successfully!", vbInformation + vbOKOnly, "Import Completed"
    End If
    
Kil�p�s:
    ' Clean up the FileDialog object.
    Set dlg = Nothing
    fvki
    Exit Sub

ErrorHandler:
    ' Display an error message if something goes wrong.
    MsgBox "Error: " & Err.Description, vbExclamation + vbOKOnly, "Error"
    logba , "Error: " & Err.Description & "(" & Err.Number & ")", 0
    Resume Kil�p�s
End Sub
Public Sub Szem�lyt�rzsImport(f�jln�v As String, �rlap As Object)
fvbe ("Szem�lyt�rzsImport")
'(c) Ol�h Zolt�n 2022. Licencia: MIT

    'Az Excel megnyit�s�hoz
    Dim objExcel        As Excel.Application
    Dim objBook         As Excel.Workbook
    Dim objSheet        As Excel.Worksheet
    Dim objRange        As Excel.Range
    
    Dim xlT�bla, kieg   As String
    Dim xlT�blaEred     As String
    
    Dim �rt�kek()       As Variant
    Dim intMez�         As Integer

    
    'Az adatb�zis megnyit�s�hoz
    Dim db              As DAO.Database     'Ez lesz az adatb�zisunk
    Dim rsC�l           As DAO.Recordset    'Ahov� m�solunk

    Dim f�jl            As String
    Dim helyzet         As Variant          'A felt�ltend� rekord el�r�s�hez
    Dim mez�            As String           'A mez� nev�nek �tmeneti t�rol�s�ra �s tiszt�t�s�ra
    
    
    Dim Eredm�ny        As Integer
    Dim Mez�ListaT�bla  As String           'A t�bla : a t�bla mez�inek (eredeti oszlopc�m, mez�n�v, t�pus) jellemz�it t�rol� t�bla
    
    'A sz�veges kimenethez
    Dim �zenet          As String
    
    'Sz�ml�l�shoz
    Dim sor, oszlop     As Integer
    Dim ehj             As New ehjoszt
    
    Dim v�lasz          As Integer
On Error GoTo Hiba
    
    Set objExcel = CreateObject("Excel.Application")
    Set db = CurrentDb()
    Mez�ListaT�bla = "tSzem�lyMez�k"

    
    ' azt felt�telezz�k, hogy a f�jln�v j�, helyes �s alkalmas
    f�jl = f�jln�v
    ' megnyitjuk az Excel t�bl�t
'''
    sFoly �rlap, "Adatforr�s megnyit�sa:; megkezdve..."
   
    
    Set objBook = objExcel.Workbooks.Open(f�jl, ReadOnly:=True, IgnoreReadOnlyRecommended:=True, Editable:=False, Notify:=False)

'''
    sFoly �rlap, "Adatforr�s megnyit�sa:; megt�rt�nt!"
    
    
        Erase �rt�kek
        xlT�bla = "tSzem�lyek"
        xlT�blaEred = "Szem�lyt�rzs alapriport"
        Set objSheet = objBook.Worksheets(xlT�blaEred)
        objSheet.Select ' R�ugrunk a lapra
        
'''
    sFoly �rlap, "�res oszlopok t�rl�se:; megkezdve..."
    
        
'        Call UresOszlopokTorlese(objSheet)
'''
    sFoly �rlap, "�res oszlopok t�rl�se:; befejezve!"
   
        With objSheet
            .UsedRange.Name = xlT�bla 'Elnevezz�k a ter�letet
'''
            sFoly �rlap, "Beolvasand� sorok sz�ma:;" & .Range(xlT�bla).Rows.count
            'Debug.Print �zenet
            
            
        End With
        
        If DCount("[Name]", "MSysObjects", "[Name] = '" & xlT�bla & "'") = 1 Then
            kieg = RIC(Now())
            DoCmd.Rename xlT�bla & kieg, acTable, xlT�bla
'''
            sFoly �rlap, n�vel�vel(xlT�bla, , , True) & " �tneveztetett:; " & xlT�bla & kieg
           
    
        End If
'''
        sFoly �rlap, "Az �j " & xlT�bla & " elk�sz�t�se:; megkezdve..."
        
        
        Call T�blak�sz�t�(db, Mez�ListaT�bla, xlT�bla)

'''
        sFoly �rlap, "Az �j " & xlT�bla & " elk�sz�lt:; siker�lt!"
       

        'Elkezdj�k az adatok bet�lt�s�t
        Set rsC�l = db.OpenRecordset(xlT�bla)

        �rt�kek = objSheet.Range(xlT�bla).Value
        
        ehj.Ini (100)
        'Sorok sz�ma: !!!!
        ehj.oszlopszam = UBound(�rt�kek, 1) - (LBound(�rt�kek, 1)) ' Az oszlopsz�m itt a sorok sz�m�t jel�li!
'''
        sFoly �rlap, "A beolvasand� oszlopok sz�ma:;" & UBound(�rt�kek, 2) - (LBound(�rt�kek, 2) + 1)
        

        For sor = LBound(�rt�kek, 1) + 1 To UBound(�rt�kek, 1)
            intMez� = 0
            '�j rekord hozz�ad�sa kezd�dik...
            rsC�l.AddNew
            rsC�l.Update
            helyzet = rsC�l.LastModified
            
            For oszlop = LBound(�rt�kek, 2) + 1 To UBound(�rt�kek, 2)

                intMez� = oszlop
                rsC�l.Bookmark = helyzet
                rsC�l.Edit
                mez� = Clean_NPC(Trim(Left(�rt�kek(1, oszlop), 64))) 'A nem nyomtathat� karaktereket kisz�rj�k
                rsC�l.Fields(mez�) = konverter(rsC�l.Fields(mez�), �rt�kek(sor, oszlop))
                'Debug.Print mez�, rsC�l.Fields(mez�).Value
                rsC�l.Update
            Next oszlop
            ehj.Novel
            '�j rekord hozz�ad�sa v�get �rt
            
        Next sor
'''
    sFoly �rlap, n�vel�vel(f�jl, , , True) & " adatai beolvastattak; " & n�vel�vel(xlT�bla) & "t�bl�ba!"
    fvki
Exit Sub
Hiba:
If Err.Number = 3265 Then
    v�lasz = �jOszlop(mez�)
End If

End Sub


Sub MoveTableAndCreateLink()
'# Ol�h Zolt�n (c) 2023 Licencia: MIT
'
    Dim forr�sDB As DAO.Database
    Dim targetDB As DAO.Database
    Dim tableName As String
    Dim newTableName As String
    Dim linkTableName As String
    
    ' Set the source and target database file paths
    Dim sourceDBPath As String
    Dim targetDBPath As String
    
    sourceDBPath = "C:\Path\To\Source\Database.accdb"
    targetDBPath = "C:\Path\To\Target\Database.accdb"
    
    ' Set the table name you want to move
    tableName = "TableNameToMove"
    
    ' Set the new table name in the target database
    newTableName = "NewTableName"
    
    ' Set the linked table name in the source database
    linkTableName = "LinkedTableName"
    
    ' Open the source and target databases
    Set forr�sDB = OpenDatabase(sourceDBPath)
    Set targetDB = OpenDatabase(targetDBPath)
    
    ' Copy the table from the source to the target database
    DoCmd.TransferDatabase acExport, "Microsoft Access", targetDBPath, acTable, tableName, newTableName
    
    ' Close the source and target databases
    forr�sDB.Close
    targetDB.Close
    
    ' Open the source database again
    Set forr�sDB = OpenDatabase(sourceDBPath)
    
    ' Create a link to the table in the target database
    Dim tdf As DAO.TableDef
    Set tdf = forr�sDB.CreateTableDef(linkTableName)
    tdf.Connect = ";DATABASE=" & targetDBPath
    tdf.SourceTableName = newTableName
    forr�sDB.TableDefs.Append tdf
    
    ' Refresh the linked table to get the latest data
    DoCmd.RunCommand acCmdRefresh
    
    ' Close the source database
    forr�sDB.Close
    
    ' Clean up
    Set forr�sDB = Nothing
    Set targetDB = Nothing
    Set tdf = Nothing
End Sub