'E gy�tem�nyben, ha az MIT licencia eml�ttettik, (megjel�lve a szerz�t �s a m� sz�let�s�nek �v�t) azon az al�bbi felhaszn�l�si enged�lyt kell �rteni:

'Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"),
'to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software,
'and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
'The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
'THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
'FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
'WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
Option Compare Database
Public logconn As ADODB.Connection
Public logrst As ADODB.Recordset
Public logTmpRst As DAO.Recordset
Public Const logpath = "L:\Ugyintezok\Adatszolg�ltat�k\Adatb�zisok\H�tt�rt�rak\log.accdb"
Public dbn�v As String
Public FolyamatHASH As String
Public colFvN�v As New Collection
Public Const intLoglevel As Integer = 2 'Logol�s szintje: 0 = Hiba;
                                                         '1 = felhaszn�l�i t�j�koztat�s;
                                                         '2 = f�bb folyamat esem�nyek;
                                                         '3 = hibakeres�s 1. fok;
                                                         '4 = fv. szint� hibakeres�s
Public Const sNB = "Nincs bejegyz�s"
Public Flush As Boolean
Private Type GUID_TYPE
    Data1 As Long
    Data2 As Integer
    Data3 As Integer
    Data4(7) As Byte
End Type
#If VBA7 Then
    Private Declare PtrSafe Function CoCreateGuid Lib "ole32.dll" (guid As GUID_TYPE) As LongPtr
    Private Declare PtrSafe Function StringFromGUID2 Lib "ole32.dll" (guid As GUID_TYPE, ByVal lpStrGuid As LongPtr, ByVal cbMax As Long) As LongPtr
#Else
    Private Declare Function CoCreateGuid Lib "ole32.dll" (guid As GUID_TYPE) As Long
    Private Declare Function StringFromGUID2 Lib "ole32.dll" (guid As GUID_TYPE, ByVal lpStrGuid As Long, ByVal cbMax As Long) As Long
#End If
#If VBA7 Then
    ' For 64-bit systems
    Private Declare PtrSafe Sub Sleep Lib "kernel32" (ByVal dwMilliseconds As Long)
#Else
    ' For 32-bit systems
    Private Declare Sub Sleep Lib "kernel32" (ByVal dwMilliseconds As Long)
#End If

Const ozAccessCollision As Integer = 5
Const intKiir As Integer = 20  ' Number of records to write in a batch (preset)
Public colLogba() As Collection  ' Array of collections to hold log data
Public intSzamlalo As Integer


Function CreateGuidString()
    Dim guid As GUID_TYPE
    Dim strGuid As String
    #If VBA7 Then
        Dim retValue As LongPtr
    #Else
        Dim retValue As Long
    #End If
    Const guidLength As Long = 39 'registry GUID format with null terminator {xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx}

    retValue = CoCreateGuid(guid)
    If retValue = 0 Then
        strGuid = String$(guidLength, vbNullChar)
        retValue = StringFromGUID2(guid, StrPtr(strGuid), guidLength)
        If retValue = guidLength Then
            ' valid GUID as a string
            CreateGuidString = strGuid
        End If
    End If
End Function
Sub fvbe(fvn�v As String)
    If intLoglevel > 1 Then
        If fvn�v = "" Then fvn�v = "-"
        If colFvN�v.count = 0 Then
            colFvN�v.Add item:=fvn�v
        Else
            colFvN�v.Add item:=fvn�v, before:=1
        End If
        If intLoglevel > 3 Then
            logba , "bel�p�s", 4
        End If
    End If
End Sub
Function sFN() As String
If colFvN�v.count < 1 Then
    sFN = vbNullString
    Exit Function
End If
    If intLoglevel > 1 Then
        sFN = colFvN�v.item(1)
    Else
        sFN = vbNullString
    End If
End Function
Sub fvki()
If colFvN�v.count < 1 Then Exit Sub
    If intLoglevel > 1 Then
        colFvN�v.Remove 1
        If intLoglevel > 3 Then
            logba , "kil�p�s", 4
        End If
    End If
End Sub

Sub sFoly(�rlap As Form, �zenet As String, Optional id�tis As Boolean = True, Optional loglevel As Integer = 1)
'#MIT Ol�h Zolt�n (2023)
    Dim a As Boolean
    a = Foly(�rlap, �zenet, id�tis)
End Sub
Function Foly(�rlap As Form, �zenet As String, Optional id�tis As Boolean = True, Optional loglevel As Integer = 1) As Boolean
'#MIT Ol�h Zolt�n (2023)
Dim x
Dim i As Integer
Dim most As Date
Dim oszlopsz�less�g As Integer
Dim esem�ny As String
Dim �zenetT�rgya As String
oszlopsz�less�g = OszlopSz�less�gKarakter("folyamat", 2, �rlap)
esem�ny = ffsplit(�zenet, ";", 2)
�zenetT�rgya = ffsplit(�zenet, ";", 1)
most = Now()

'El�sz�r a logt�bl�ba �rjuk ki
 logba �zenetT�rgya, esem�ny, loglevel
If loglevel <= 1 Then DoEvents
If loglevel = 1 Then
'Azut�n a log list�ba
    If id�tis Then
        If StrCount(�zenet, ";") = 1 And �rlap.Folyamat.ListCount = 0 Then
            �zenet = �zenet & "; Id�pont"
        Else
            If StrCount(�zenet, ";") = 1 Then
                �zenet = �zenet & "; " & most
            End If
        End If
    End If
    If Len(esem�ny) > oszlopsz�less�g Or InStr(1, esem�ny, vbNewLine) > 0 Then
        For i = 1 To StrCount(esem�ny, vbNewLine)
            If i = 1 Then
                �rlap.Folyamat.AddItem item:=�zenetT�rgya & ";" & ffsplit(esem�ny, vbNewLine, i)
                If id�tis Then
                    �rlap.Folyamat.AddItem item:=�zenetT�rgya & ";" & ffsplit(esem�ny, vbNewLine, i) & ";" & most
                End If
            Else
                �rlap.Folyamat.AddItem item:=";" & ffsplit(esem�ny, vbNewLine, i)
            End If
        Next i
    Else
        �rlap.Folyamat.AddItem item:=�zenet
    End If
    �rlap.Repaint
    �rlap.Folyamat.Selected(�rlap.Folyamat.ListCount - 1) = True
    �rlap.Folyamat.Requery
End If


End Function
Sub loginit()
Dim �j As Boolean
Dim i As Integer
�j = False
    If logconn Is Nothing Then
        Set logconn = New ADODB.Connection 'OpenDatabase(logpath)
        logconn.ConnectionString = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" & logpath
        logconn.Open
        logconn.CursorLocation = adUseClient
        �j = True
    End If
    If logrst Is Nothing Then
        Set logrst = New ADODB.Recordset
        logrst.Open "Select * From [tlog]", logconn, adOpenForwardOnly, adLockBatchOptimistic
        �j = True
    End If
        dbn�v = CurrentDb.Name
    'Ideiglenes t�bla, ami csak a mem�ri�ban l�tezik
    If logTmpRst Is Nothing Then
        CreateTempTableFromPersistentTable 'Ebbe fogjuk �rni az �zeneteket, s innen �rjuk majd ki �ket egy kupacban
        Set logTmpRst = CurrentDb.OpenRecordset("Select * From [tTmpLog] Where 1=0;", dbOpenDynaset) 'Egy 0 soros t�bla j�n l�tre, amibe lehet �rni, �s amib�l lehet olvasni.
    End If
    If FolyamatHASH = vbNullString Then
        FolyamatHASH = CreateGuidString()
        �j = True
    End If
    If �j Then: logba "Log:", "Indul", 4
        intSzamlalo = 0
    
End Sub

Sub logba(Optional Bejegyz�sT�rgya As String = vbNullString, Optional Bejegyz�s As String = sNB, Optional logszint As Integer = 1)
Dim legkor�bbiBejegyz�s As Date

If logszint > intLoglevel Then Exit Sub
    Call loginit
    
    If Bejegyz�sT�rgya = vbNullString Then
        If sFN = vbNullString Then
            Bejegyz�sT�rgya = dbn�v
        Else
            Bejegyz�sT�rgya = sFN
        End If
    End If
    With logTmpRst
        .AddNew
            !Bejegyz�sT�rgya = Bejegyz�sT�rgya
            !Bejegyz�s = Bejegyz�s
            ![bejegyz�s id�pontja] = Now()
            !FolyamatHASH = FolyamatHASH
            !felhaszn�l� = Environ("Username")
            !sz�m�t�g�p = Environ("Computername")
            !adatb�zis = dbn�v
            !logszint = logszint
        .Update
        .Sort = "[bejegyz�s id�pontja]"
        .MoveFirst
        legkor�bbiBejegyz�s = ![bejegyz�s id�pontja]
        Debug.Print legkor�bbiBejegyz�s
    End With

    If logTmpRst.RecordCount >= intKiir Or DateDiff("s", legkor�bbiBejegyz�s, Now()) > 5 Or Flush Then
        Debug.Print "Ki�r�"
        logki�r�
    End If
    
End Sub
Sub logki�r�()
    Const maxpr�b�lkoz�s = 5
    Const k�sleltet�s = 100 'ms-ban
    Dim pr�b�lkoz�s As Integer
    Dim i As Integer
On Error GoTo Hibapont
Kezd:
    logconn.BeginTrans
    
    logTmpRst.MoveFirst
    Do Until logTmpRst.EOF
        With logTmpRst
            logrst.AddNew
            logrst![Bejegyz�sT�rgya] = ![Bejegyz�sT�rgya]
            logrst![Bejegyz�s] = ![Bejegyz�s]
            logrst![bejegyz�s id�pontja] = ![bejegyz�s id�pontja]
            logrst![FolyamatHASH] = ![FolyamatHASH]
            logrst![felhaszn�l�] = ![felhaszn�l�]
            logrst![sz�m�t�g�p] = ![sz�m�t�g�p]
            logrst![adatb�zis] = ![adatb�zis]
            logrst![logszint] = ![logszint]
            logrst.Update
            .MoveNext
        End With
    Loop
    logconn.CommitTrans
    logrst.UpdateBatch adAffectAllChapters 'Ha itt �tk�zik egy m�sik ki�r�ssal, akkor a Hibapont-t�l folytatja
    Debug.Print "Commit"
        'Ki�r�tj�k
        With logTmpRst
            .MoveFirst
            Debug.Print "T�r�l"
            Do Until .EOF
                .Delete
                .MoveNext
            Loop
        End With
    intSzamlalo = 0
    Flush = False
ki:
Exit Sub
Hibapont:
Debug.Print "Err.Number"
    If Err.Number = ozAccessCollision Then '�tk�z�s eset�n
    
        If pr�b�lkoz�s < maxpr�b�lkoz�s Then '�jra pr�b�lkozunk
            startTime = Timer
            Do While Timer < startTime + (k�sleltet�s / 1000)
                DoEvents
            Loop
            'Sleep k�sleltet�s '
            logconn.RollbackTrans
            � pr�b�lkoz�s 'Eggyel n�velj�k, mint a C++. Z�r�jelet nem tesz�nk!
            Resume Kezd
        Else
            GoTo ki 'el�rt�k a pr�b�lkoz�sok megengedett sz�m�t, tov�bbl�p�nk. Majd m�skor ki�rjuk, nemde?
        End If
    Else
        MsgBox Err.Number & " :" & Err.Description
        GoTo ki
        
    End If
    
End Sub

Sub logclose()
On Error GoTo Hiba
Dim Huba As Integer
    If Not logrst Is Nothing Then
        logba "Log:", "lez�r"
        Set logrst = Nothing
        If Not logrst Is Nothing Then Err.Raise 999
    End If
    If Not logconn Is Nothing Then
        Set logconn = Nothing
        If Not logconn Is Nothing Then Err.Raise 998
    End If
    If FolyamatHASH <> vbNullString Then
        FolyamatHASH = vbNullString
    End If
    
Hiba:
    If Err.Number = 999 Then
        logba "Log:", "A logt�bla nem z�rhat�!", 0
        Huba = 999
        Resume Next
    End If
    If Err.Number = 998 Then
        If Huba = 999 Then
            logba "Log:", "A logkapcsolat sem z�rhat�!", 0
            MsgBox "A logt�bla �s a logkapcsolat nem z�rhat�!", , "Log:"
        Else
            MsgBox "A logt�bla z�r�sa siker�lt, de a logkapcsolat nem z�rhat�!", , "Log:"
        End If
        Resume Next
    End If
End Sub

'_________________________________________________________________________________________________________
'#########################################################################################################
'###################                                                                       ###############
'###################            ITT l�trehozzuk az ideiglenes t�bl�t                       ###############
'###################                                                                       ###############
'#########################################################################################################
'^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
'Forr�s: chatopenAI
Sub CreateTempTableFromPersistentTable()
    Dim db As DAO.Database
    Dim rsTemp As DAO.Recordset
    Dim cn As ADODB.Connection
    Dim rsPersistent As ADODB.Recordset
    Dim fld As ADODB.Field
    Dim tableName As String
    Dim tempTableName As String
    Dim createTableSQL As String

    tableName = "tLog"
    tempTableName = "tTmpLog" ' ideiglenes t�bla

    Set db = CurrentDb
    If TableExists(tempTableName) Then
        db.Execute "DROP TABLE " & tempTableName
    End If
    
    Set rsPersistent = New ADODB.Recordset
    rsPersistent.Open tableName, logconn, adOpenStatic, adLockReadOnly
    createTableSQL = "CREATE TABLE " & tempTableName & " ("

    For Each fld In rsPersistent.Fields
        createTableSQL = createTableSQL & "[" & fld.Name & "] " & GetFieldType(fld) & ", "
    Next fld

    createTableSQL = Left(createTableSQL, Len(createTableSQL) - 2) & ")"

    db.Execute createTableSQL

    rsPersistent.Close
    Set rsPersistent = Nothing
    Set cn = Nothing
    Set db = Nothing

    Debug.Print "Temporary table created successfully."
End Sub

Function GetFieldType(fld As ADODB.Field) As String
    Select Case fld.Type
        Case adBigInt: GetFieldType = "BIGINT"
        Case adBinary: GetFieldType = "BINARY"
        Case adBoolean: GetFieldType = "YESNO"
        Case adChar: GetFieldType = "CHAR(" & fld.DefinedSize & ")"
        Case adCurrency: GetFieldType = "CURRENCY"
        Case adDate: GetFieldType = "DATETIME"
        Case adDBDate: GetFieldType = "DATETIME"
        Case adDBTime: GetFieldType = "DATETIME"
        Case adDBTimeStamp: GetFieldType = "DATETIME"
        Case adDecimal: GetFieldType = "DECIMAL"
        Case adDouble: GetFieldType = "DOUBLE"
        Case adGUID: GetFieldType = "GUID"
        Case adInteger: GetFieldType = "INTEGER"
        Case adLongVarBinary: GetFieldType = "LONGBINARY"
        Case adLongVarChar: GetFieldType = "LONGTEXT"
        Case adNumeric: GetFieldType = "NUMERIC"
        Case adSingle: GetFieldType = "SINGLE"
        Case adSmallInt: GetFieldType = "SMALLINT"
        Case adTinyInt: GetFieldType = "BYTE"
        Case adUnsignedBigInt: GetFieldType = "UNSIGNED BIG INT"
        Case adUnsignedInt: GetFieldType = "UNSIGNED INT"
        Case adUnsignedSmallInt: GetFieldType = "UNSIGNED SMALL INT"
        Case adUnsignedTinyInt: GetFieldType = "BYTE"
        Case adVarBinary: GetFieldType = "VARBINARY"
        Case adVarChar: GetFieldType = "TEXT(" & fld.DefinedSize & ")"
        Case adVariant: GetFieldType = "VARIANT"
        Case adVarWChar: GetFieldType = "TEXT(" & fld.DefinedSize & ")"
        Case adWChar: GetFieldType = "TEXT(" & fld.DefinedSize & ")"
        Case adLongVarWChar: GetFieldType = "LONGTEXT"
        Case Else: GetFieldType = "TEXT(255)" ' Default to TEXT if the type is unknown
    End Select
End Function
Function OszlopSz�less�gKarakter(listBoxName As String, columnIndex As Integer, �rlap As Form) As Double
fvbe ("OszlopSz�less�gKarakter")
    On Error GoTo ErrorHandler

    Dim ctl As Control
    Dim columnWidthTwips As Long
    Dim charWidthTwips As Double
    Dim formName As String

'    ' Access the form containing the ListBox
'    If formName = "" Then
'        ' Use the active form if no form name is provided
'        Set formObj = Screen.ActiveForm
'    Else
'        Set formObj = Forms(formName)
'    End If

    ' Get the ListBox control
    Set ctl = �rlap.Controls(listBoxName)

    ' Retrieve the column width in twips
    columnWidthTwips = Split(ctl.ColumnWidths, ";")(columnIndex - 1)
    
    ' Estimate character width based on font size (assumes average of 120 twips per character for 10pt font)
    ' Adjust 120 as per the actual font and size for better precision
    charWidthTwips = ctl.FontSize * 12

    ' Convert column width to characters
    OszlopSz�less�gKarakter = columnWidthTwips / charWidthTwips
fvki
Exit Function

ErrorHandler:
    Hiba error
    'MsgBox "Error: " & Err.Description, vbExclamation, "Get Column Width"
    OszlopSz�less�gKarakter = -1
    fvki
End Function
