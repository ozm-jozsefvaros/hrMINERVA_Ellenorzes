Option Compare Database

Sub ExportToExcelByDepartmentAndSubdepartment(sLek�rdez�sNeve As String)
    Dim db As DAO.Database
    Dim rs As DAO.Recordset
    Dim strSQL As String
    Dim sF�oszt�ly As String
    Dim sOszt�ly As String
    Dim intRowCount As Integer
    Dim bm As Variant  ' Variable to store bookmark
    

    ' Set the SQL query to retrieve the employee data
    'strSQL = "SELECT department, subdepartment, name, salary FROM YourQuery"
    
    ' Open the query as a recordset
    Set db = CurrentDb
    Set rs = db.OpenRecordset(sLek�rdez�sNeve)
    
    ' Loop through the recordset
    Do While Not rs.EOF
        ' Save current position
        bm = rs.Bookmark
        
        ' Retrieve department and subdepartment names
        sF�oszt�ly = rs("F�oszt�ly")
        
        
        ' Check if the department has more than 100 employees
        intRowCount = SorokSz�maF�oszt�lyok�nt(sF�oszt�ly, rs)
        
        If intRowCount <= 100 Then
            ' Export data to Excel for department only
            ExportToExcel sF�oszt�ly, False, rs
        Else
            ' Export data to Excel for department and subdepartment
            ExportToExcel sF�oszt�ly, True, rs
        End If
        
        ' Restore the record position
        rs.Bookmark = bm
        
        ' Move to the next record
        rs.MoveNext
    Loop
    
    ' Close the recordset and database
    rs.Close
    Set rs = Nothing
    Set db = Nothing
    
    MsgBox "Data exported to Excel files successfully!", vbInformation
End Sub

Function SorokSz�maF�oszt�lyok�nt(sF�oszt�ly As String, rsLek�rdez�s As Recordset) As Integer

    Dim intSorokSz�ma As Integer

    rsLek�rdez�s.Filter = "[F�oszt�ly] = '" & sF�oszt�ly & "'"
    If Not rsLek�rdez�s.EOF Then
        rsLek�rdez�s.MoveLast
        intSorokSz�ma = rsLek�rdez�s.RecordCount
    Else
        intSorokSz�ma = 0
    End If
    rsLek�rdez�s.Filter = "true"
    SorokSz�maF�oszt�lyok�nt = intSorokSz�ma
End Function

Sub ExportToExcel(sF�oszt�ly As String, bOszt�llyal As Boolean, rs As Recordset)
    Dim xlApp As Object
    Dim xlWorkbook As Object
    Dim xlWorksheet As Object
'    Dim rsExport As DAO.Recordset
'    Dim db As DAO.Database
'    Dim strSQL As String
    Dim i As Long
    Dim row As Integer

    ' Create a new Excel application
    Set xlApp = CreateObject("Excel.Application")
    xlApp.Visible = False
    Set xlWorkbook = xlApp.Workbooks.Add
    Set xlWorksheet = xlWorkbook.Worksheets(1)
    
    ' Set up the SQL to export the filtered data
    If bOszt�llyal Then
        strSQL = "SELECT department, subdepartment, name, salary FROM YourQuery WHERE department = '" & department & "'"
    Else
        strSQL = "SELECT department, name, salary FROM YourQuery WHERE department = '" & department & "'"
    End If
    
    ' Open the filtered recordset
    Set db = CurrentDb
    Set rsExport = db.OpenRecordset(strSQL)
    
    ' Write headers
    With xlWorksheet
        For i = 1 To rsExport.Fields.count
            .Cells(1, i).Value = rsExport.Fields(i - 1).Name
        Next i
        
        ' Write data rows
        row = 2
        Do While Not rsExport.EOF
            For i = 1 To rsExport.Fields.count
                .Cells(row, i).Value = rsExport.Fields(i - 1).Value
            Next i
            row = row + 1
            rsExport.MoveNext
        Loop
    End With
    
    ' Save file
    Dim filePath As String
    filePath = "C:\Path\To\Excel\Files\" & department & ".xlsx"
    xlWorkbook.SaveAs filePath
    
    ' Close workbook and Excel
    xlWorkbook.Close False
    xlApp.Quit
    
    ' Cleanup
    Set xlWorksheet = Nothing
    Set xlWorkbook = Nothing
    Set xlApp = Nothing
    rsExport.Close
    Set rsExport = Nothing
    Set db = Nothing
End Sub

Sub ExcelKimenet( _
                             sLek�rdez�sNeve As String, _
                             sHova As String, _
                    Optional sF�csoport As String = "F�oszt�ly", _
                    Optional sAlcsoport As String = "Oszt�ly", _
                    Optional t�mbParam�terek As Variant)
    Dim db As DAO.Database
    Dim rs As DAO.Recordset
    Dim lek As QueryDef
    Dim xlApp As Excel.Application
    Dim xlBook As Excel.Workbook
    Dim xlSheet As Excel.Worksheet
    Dim curPath As String, _
        curHead As String, _
        curDept As String, _
        �zenet As String
    Dim mez� As Field
    Dim sor As Long, _
        oszlop As Long, _
        maxoszlop As Long
    Dim oszt�lysz�m As Integer
    Dim cella As Excel.Range
    Dim iDim As Integer, _
        i As Integer

    Set db = CurrentDb
    Set lek = db.QueryDefs(sLek�rdez�sNeve)
    For i = LBound(t�mbParam�terek, 1) To UBound(t�mbParam�terek, 1)
        lek.Parameters(t�mbParam�terek(1, 0)) = t�mbParam�terek(1, 1)
    Next i
    Set rs = lek.OpenRecordset
    If IsArrayAllocated(t�mbParam�terek) Then
        iDim = nDim(t�mbParam�terek)
    End If
    Debug.Print "Lek. indul...", Now()
    Set xlApp = CreateObject("Excel.Application")
    xlApp.Visible = False 'change to True for debugging
    
    curPath = hova & "\" 'modify as needed
    curHead = ""
    curDept = ""
    row = 1
    �zenet = "K�sz�lt: " & Format(Date, "YYYY. �vi MMMM. \h� DD. \napj�\n.")
    'rs.Sort = "F�oszt�ly,Oszt�ly"
    If Not (rs.BOF And rs.EOF) Then
        Do While Not rs.EOF
            If rs.Fields(sF�csoport) <> curHead Then  'new head department
                If Not xlBook Is Nothing Then 'save and close previous workbook
                    Call igaz�t�sok(xlSheet, sor, maxoszlop, �zenet) ' Ment�s el�tt egy kis cs�noz�s
                    xlBook.SaveAs curPath & curHead & ".xlsx"
                    xlBook.Close
                End If
                Set xlBook = xlApp.Workbooks.Add 'create new workbook
                Set xlSheet = xlBook.Worksheets(1) 'use first worksheet
                curHead = rs.Fields(sF�csoport) 'update current head department
                
                Debug.Print curHead
                curDept = "" 'reset current department
                sor = 1 'reset row number
                oszlop = 1
                For Each mez� In rs.Fields
                     xlSheet.Cells(sor, oszlop) = mez�.Name
                     � oszlop
                Next mez�
                maxoszlop = rs.Fields.count
                sor = 2
            End If

            If rs!Oszt�ly <> curDept Then '�j F�oszt�ly
                � oszt�lysz�m
                curDept = rs!Oszt�ly
            End If
                With xlSheet
                    Select Case (oszt�lysz�m + 1) Mod 2
                        Case 1
                            .Range(.Cells(sor, 1), .Cells(sor, maxoszlop)).Interior.ColorIndex = 2
                        Case 0
                            .Range(.Cells(sor, 1), .Cells(sor, maxoszlop)).Interior.ColorIndex = 15
                    End Select

                    For oszlop = 0 To rs.Fields.count - 1
                        Set cella = .Cells(sor, oszlop + 1)
                        cella.Value = rs.Fields(oszlop)
                        Select Case rs.Fields(oszlop).Name
                            Case "F�oszt�ly"
                                cella.Font.Bold = True
                                cella.Font.Italic = False
                            Case "Oszt�ly"
                                cella.Font.Italic = True
                                cella.Font.Bold = False
                            Case Else
                                cella.Font.Italic = False
                                cella.Font.Bold = False
                        End Select
                    Next oszlop
                End With
            
            � sor 'increment row number
            rs.MoveNext 'move to next record
        Loop
        'V�gs� igaz�t�sok a munkalapon
        Call igaz�t�sok(xlSheet, sor, maxoszlop, �zenet)

        If Not xlBook Is Nothing Then 'save and close last workbook
            xlBook.SaveAs curPath & curHead & ".xlsx"
            xlBook.Close
        End If
    Else
        Debug.Print "�res volt a lek�rdez�s..."
    End If
    
    xlApp.Quit 'quit Excel application
    rs.Close 'close recordset
    db.Close 'close database
    Set xlSheet = Nothing 'clear objects
    Set xlBook = Nothing
    Set xlApp = Nothing
    Set rs = Nothing
    Set db = Nothing
    Debug.Print "Lefutott:", Now()
End Sub
Sub ExportTableDataToExcel()
    Dim db As DAO.Database
    Dim rs As DAO.Recordset
    Dim xlApp As Object
    Dim xlBook As Object
    Dim xlSheet As Object
    Dim curPath As String
    Dim curHead As String
    Dim curDept As String
    Dim row As Long

    Set db = CurrentDb()
    Debug.Print "Lek. indul...", Now()
    Set rs = db.OpenRecordset("SELECT * FROM lkEnged�lyezett�sL�tsz�mKimenet02 ORDER BY F�oszt�ly, Oszt;") 'tesztel�shez: WHERE [F�oszt�ly] Like 'Nyugd*' OR [F�oszt�ly] Like 'Eg�sz*'
    Debug.Print "Lek. v�ge...", Now()
    Set xlApp = CreateObject("Excel.Application")
    xlApp.Visible = False 'change to True for debugging
    
    curPath = "L:\Ugyintezok\Adatszolg�ltat�k\Kimenet" & "\" 'modify as needed
    curHead = ""
    curDept = ""
    row = 1
    rs.Sort = "F�oszt�ly,Oszt�ly"
    If Not (rs.BOF And rs.EOF) Then
        Do While Not rs.EOF
            If rs!F�oszt�ly <> curHead Then 'new head department
                If Not xlBook Is Nothing Then 'save and close previous workbook
                    Call igaz�t�sok(xlSheet, row) ' Ment�s el�tt egy kis cs�noz�s
                    xlBook.SaveAs curPath & curHead & ".xlsx"
                    xlBook.Close
                End If
                Set xlBook = xlApp.Workbooks.Add 'create new workbook
                Set xlSheet = xlBook.Worksheets(1) 'use first worksheet
                curHead = rs!F�oszt�ly 'update current head department
                Debug.Print curHead
                curDept = "" 'reset current department
                row = 1 'reset row number
                xlSheet.Range("A" & row & ":F" & row).Merge 'merge cells for department name
                xlSheet.Range("A" & row).Value = rs!F�oszt�ly 'write department name
                xlSheet.Range("A" & row).Font.Bold = True 'format department name
                xlSheet.Range("A" & row).Interior.ColorIndex = 37
                xlSheet.Range("A" & row).HorizontalAlignment = xlCenter
                row = 2
            End If

            If rs!Oszt <> curDept Then 'new department
                If row > 2 Then 'skip a row after previous department
                    xlSheet.Range("A" & row & ":F" & row).Interior.ColorIndex = 52
                    row = row + 1
                End If

                'row = row + 1 'Oszt�ly megnevez�se
                xlSheet.Range("A" & row).Value = rs!Oszt
                xlSheet.Range("A" & row & ":F" & row).Interior.ColorIndex = 15
                row = row + 1 ' t�bla fejl�c (�vsz�mok stb.)
                xlSheet.Range("B" & row).Value = "2021.01.01." 'write year headers
                xlSheet.Range("C" & row).Value = "2022.01.01."
                xlSheet.Range("D" & row).Value = "2023.01.01."
                xlSheet.Range("E" & row).Value = "2024. �vre a feladatell�t�s�hoz sz�ks�ges, javasolt l�tsz�m"
                xlSheet.Range("F" & row).Value = "utols� SZMSZ szerint enged�lyezett l�tsz�m"
                With xlSheet.Range("B" & row & ":F" & row)
                    .Font.Bold = True 'format year headers
                    .WrapText = True
                End With
                xlSheet.Rows(row).HorizontalAlignment = xlHAlignCenter
                
                row = row + 1 'J�hetnek az adatok
                curDept = rs!Oszt 'update current department
            End If
            xlSheet.Range("A" & row).Value = "szem�lyi �llom�ny l�tsz�ma:" 'write number of employees label
            xlSheet.Range("B" & row).Value = rs!L2021 'write number of employees data
            xlSheet.Range("C" & row).Value = rs!L2022
            xlSheet.Range("D" & row).Value = rs!L2023
            
            row = row + 1 'increment row number
            xlSheet.Range("A" & row).Value = "tart�san t�voll�v�k l�tsz�ma:" 'write permanently absent employees label
            xlSheet.Range("B" & row).Value = rs!TT2021 'write permanently absent employees data
            xlSheet.Range("C" & row).Value = rs!TT2022
            xlSheet.Range("D" & row).Value = rs!TT2023
            xlSheet.Range("E" & row & ":F" & row).Interior.ColorIndex = 15
            row = row + 1
            xlSheet.Range("A" & row).Value = "�gysz�m"
            xlSheet.Range("E" & row & ":F" & row).Interior.ColorIndex = 15
            row = row + 1 'increment row number
            rs.MoveNext 'move to next record
        Loop
        'V�gs� igaz�t�sok a munkalapon
        Call igaz�t�sok(xlSheet, row)

        If Not xlBook Is Nothing Then 'save and close last workbook
            xlBook.SaveAs curPath & curHead & ".xlsx"
            xlBook.Close
        End If
    Else
        Debug.Print "�res volt a lek�rdez�s..."
    End If
    
    xlApp.Quit 'quit Excel application
    rs.Close 'close recordset
    db.Close 'close database
    Set xlSheet = Nothing 'clear objects
    Set xlBook = Nothing
    Set xlApp = Nothing
    Set rs = Nothing
    Set db = Nothing
    Debug.Print "Lefutott:", Now()
End Sub
Sub igaz�t�sok(ByRef xlSheet As Excel.Worksheet, ByVal row As Long, Optional maxoszlop As Long = 6, Optional �zenet As String = "A sz�rk�vel jel�lt cell�k �rtelemszer�en nem kit�ltend�k")
Dim oszlop As Long
Dim xlOszlop As Excel.Range
'        With xlSheet.UsedRange.Borders
'            .LineStyle = xlContinuous
'            .Weight = xlThin
'        End With
        xlSheet.ListObjects.Add(xlSrcRange, xlSheet.UsedRange, , xlYes, , "TableStyleMedium21").Name = "Adatok"
        For oszlop = 1 To maxoszlop
            Set xlOszlop = xlSheet.Columns(oszlop)
            xlOszlop.AutoFit
        Next oszlop
        Debug.Print row
        With xlSheet.Range("A" & row)
            .Value = �zenet
            .Font.Italic = True
        End With
End Sub