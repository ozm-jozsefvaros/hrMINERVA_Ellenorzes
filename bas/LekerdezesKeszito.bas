Option Compare Database
'Option Explicit
' Collection to hold open tables
'Global Tables As New Collection
 
' GetTable() returns a table-type recordset by table name
'
'Function GetTable( _
'    TableName As String, _
'    Optional Index As String = "PrimaryKey" _
'    ) As DAO.Recordset
'
'    Dim recT As Recordset
'    Dim indx As Integer
'
'
'    ' do we already have a recordset?
'    For Each recT In Tables
'        If recT.Name = TableName Then Exit For
'    Next recT
'
'    ' if not, open it and add it to the collection
'    If recT Is Nothing Then
'
'        Set recT = CurrentDb(TableName).OpenRecordset
'        Tables.Add recT, recT.Name
'    End If
'    For indx = 0 To CurrentDb(TableName).Indexes.Count - 1
'        If CurrentDb(TableName).Indexes(indx).Primary Then
'            Index = CurrentDb(TableName).Indexes(indx).Name
'        End If
'    Next
'
'    If Len(Index) Then recT.Index = Index
'    Set GetTable = recT
'
'End Function

Sub Ellen�rz�s1(ByVal �rlapn�v As String)
' Ez a fv. az adathi�ny lek�rdez�seket futtatja (azET�pus=1 vagyis Hiba)
' �s a tEll v�ltoz�ban t�rolt nev� t�bl�ba �rja az eredm�nyt,
' majd a v�g�n megnyitja az eredm�nyt
fvbe ("Ellen�rz�s1")
'On Error GoTo Err_Ellen�rz�s
    Dim db                  As Database
    Dim lkEll               As Recordset    'A soron k�vetkez� ellen�rz� lek�rdez�s
    Dim ehj             As New ehjoszt      'A st�tusz megjelen�t�s�hez
    Dim sqlA                As String
    Dim lkEllLek, lkn�v     As String
    Dim tEll                As String       'Az ellen�rz�s t�bla neve
'    Dim lkEredm             As String       'Az eredm�ny lek�rdez�s neve
    Dim �rl                 As Form
    Set �rl = Application.Forms(�rlap)
    lkEllLek = "SELECT * FROM lkEllen�rz�Lek�rdez�sek2 WHERE azET�pus = 1 AND Kimenet = False AND azUnion = 1 ;"    'Ez a lek�rdez�s sorolja fel azokat a lek�rdez�seket, amelyeket le kell futtatnunk.
    tEll = "t__Ellen�rz�s_02"
'    lkEredm = "lk_Ellen�rz�s_03"
sFoly �rl, "Bet�lt�s:; Adathi�ny ellen�rz�s el�k�sz�t�se"
    
    Set db = CurrentDb()
    db.Execute ("Delete * From " & tEll & ";") 'Kit�r�lj�k a t�bla tartalm�t
    
    
    Set lkEll = db.OpenRecordset(lkEllLek)
    lkEll.MoveLast
    lkEll.MoveFirst
    
sFoly �rl, "Bet�lt�s:; " & lkEll.RecordCount & " db. lek�rdez�s indul..."
    ' A felsorolt lek�rdez�sek lefuttat�sa
    sqlA = ""
    ehj.Ini 100
    ehj.oszlopszam = lkEll.RecordCount
    Do Until lkEll.EOF
        lkn�v = lkEll("Ellen�rz�Lek�rdez�s")
        sqlA = sqlA & " INSERT INTO " & tEll
        sqlA = sqlA & "      SELECT " & lkn�v & ".*"
        sqlA = sqlA & "      FROM " & lkn�v & ";"
        db.Execute (sqlA)
        
        logba sFN & " - sqlA", sqlA, 4
        
        sqlA = ""
        
        
        lkEll.MoveNext
        ehj.Novel
    Loop
    'Az ad�azonos�t� jel (sz�veg) �talak�t�sa ad�jel-l� (dupla sz�m)
sFoly �rl, "Bet�lt�s:; ad�jel konverzi�"
    db.Execute (GetQuerySQL("lk_Ellen�rz�s_02_t�bl�ba_ad�jelKonverzi�"))
sFoly �rl, "Bet�lt�s:; el�k�sz�t�s v�get �rt"

Err_Kimenet:
    Exit Sub
    
Err_Ellen�rz�s:
    Select Case Err.Number
    Case 3417
        sqlA = GetQuerySQL(lkn�v)
        logba , Err.Number, 0
        Resume 0
    Case Else
        MsgBox Err.Number & Err.Description
        logba , Err.Number & Err.Description, 0
        'Resume Next
    End Select
fvki
End Sub
Sub Ellen�rz�s2(�rlap As Form, Optional Kimenet As Boolean = True)
' Ez a fv. az adathi�ny lek�rdez�seket futtatja (azET�pus = 1 vagyis Hiba)
' �s a tEll v�ltoz�ban t�rolt nev� t�bl�ba �rja az eredm�nyt,
' majd a v�g�n megnyitja a
fvbe ("Ellen�rz�s2")
On Error GoTo Err_Ellen�rz�s
    Dim db                  As Database
    Dim lkEll               As Recordset    'A soron k�vetkez� ellen�rz� lek�rdez�s
    Dim sqlA                As String
    Dim lkEllLek, lkn�v     As String
    Dim tEll                As String       'Az ellen�rz�s t�bla neve
    Dim lkEredm             As String       'Az eredm�ny lek�rdez�s neve
    Dim �zenet              As String       'Az �zenetek sz�m�ra
    
    If Kimenet Then
        lkEllLek = "SELECT * FROM lkEllen�rz�Lek�rdez�sek2 WHERE Oszt�ly ='kimutat�s' Order By Oszt�ly Asc;"    'Ez a lek�rdez�s sorolja fel azokat a lek�rdez�seket, amelyeket le kell futtatnunk.
    Else
        lkEllLek = "SELECT * FROM lkEllen�rz�Lek�rdez�sek2 WHERE Oszt�ly ='hiba' Order By Oszt�ly Asc;"
    End If
    
    sFoly �rlap, "Ellen�rz�s:; Futtatand� lek�rdez�sek bet�lt�se"
    Set db = CurrentDb()
    Set lkEll = db.OpenRecordset(lkEllLek)
    lkEll.MoveLast
    lkEll.MoveFirst
    
    sFoly �rlap, "Ellen�rz�s:; " & lkEll.RecordCount & " db. lek�rdez�s indul..."
    
    ' A felsorolt lek�rdez�sek lefuttat�sa
    sqlA = ""
    Do Until lkEll.EOF
        lkn�v = lkEll("Ellen�rz�Lek�rdez�s")
        DoCmd.OpenQuery lkn�v, acViewNormal, acReadOnly
    sFoly �rlap, "Ellen�rz�s:;" & lkEll("LapN�v")
        lkEll.MoveNext
        DoCmd.OpenForm �rlap.Name, acNormal
    Loop
    'Az ad�azonos�t� jel (sz�veg) �talak�t�sa ad�jel-l� (dupla sz�m)

Err_Kimenet:
    fvki
    Exit Sub
    
Err_Ellen�rz�s:
    Select Case Err.Number
    Case 3417
        sqlA = GetQuerySQL(lkn�v)
        logba , Err.Number, 0
        Resume 0
    Case Else
        MsgBox Err.Number & Err.Description
        logba , Err.Number & Err.Description & sqlA, 0
        'Resume Next
    End Select
End Sub

Private Function GetQuerySQL(MyQueryName As String) As String
Dim QD As DAO.QueryDef
 
Set QD = CurrentDb.QueryDefs(MyQueryName)
GetQuerySQL = QD.sql
 
End Function


