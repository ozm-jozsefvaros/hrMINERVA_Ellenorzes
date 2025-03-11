Option Compare Database

Sub CountProcedures()
    Dim db As DAO.Database
    Dim cnt As Container
    Dim doc As Document
    Dim modName As String
    Dim totalProcedures As Long, _
        procCount As Long, _
        qryCount As Long, _
        sorokSz�ma As Long, _
        sorokSz�ma�ssz As Long
    
    ' Initialize the database object
    Set db = CurrentDb
    
    ' Loop through all the modules in the database
    For Each cnt In db.Containers
        If cnt.Name = "Modules" Then
            For Each doc In cnt.Documents
                modName = doc.Name
                procCount = CountProceduresInModule(modName, sorokSz�ma)
                totalProcedures = totalProcedures + procCount
                sorokSz�ma�ssz = sorokSz�ma�ssz + sorokSz�ma
                ' Display count for each module
                Debug.Print "Modul: " & modName & " -> Elj�r�sok sz�ma: " & procCount & " Sorok sz�ma:" & sorokSz�ma
            Next doc
        End If
    Next cnt
    ' Display total procedures in the database
    Debug.Print "Elj�r�sok sz�ma �sszesen: " & totalProcedures & " Sorok sz�ma mind�sszesen:" & sorokSz�ma�ssz
    For Each qry In db.QueryDefs
        If Left(qry.Name, 1) <> "~" Then
            � qryCount
        End If
    Next qry
    Debug.Print "Lek�rdez�sek sz�ma:" & qryCount
End Sub

Function CountProceduresInModule(moduleName As String, ByRef sorokSz�ma As Long) As Long
    Dim codeMod As Object ' VBA.CodeModule
    Dim procCount As Long
    Dim i As Long
    Dim lineText As String
    
    ' Open the module by its name
    Set codeMod = Application.VBE.VBProjects(1).VBComponents(moduleName).CodeModule
    sorokSz�ma = codeMod.CountOfLines
    ' Loop through lines of the module to find procedures
    For i = 1 To codeMod.CountOfLines
        lineText = Trim(codeMod.Lines(i, 1))
        
        ' Check for procedure declarations with specified keywords
        If IsProcedureLine(lineText) Then
            procCount = procCount + 1
        End If
    Next i
    
    ' Return the count
    CountProceduresInModule = procCount
End Function

Function IsProcedureLine(lineText As String) As Boolean
    Dim keywords As Variant
    Dim keyword As Variant
    Dim isProcedure As Boolean
    
    ' Define possible procedure declaration patterns
    keywords = Array("Sub ", "Public Sub ", "Private Sub ", "Friend Sub ", "Static Sub ", _
                     "Function ", "Public Function ", "Private Function ", "Friend Function ", "Static Function ", _
                     "Property ", "Public Property ", "Private Property ", "Friend Property ", "Static Property ")
    
    ' Check if line starts with any of the keywords
    For Each keyword In keywords
        If InStr(1, lineText, keyword, vbTextCompare) = 1 Then
            isProcedure = True
            Exit For
        End If
    Next keyword
    
    ' Return result
    IsProcedureLine = isProcedure
End Function

