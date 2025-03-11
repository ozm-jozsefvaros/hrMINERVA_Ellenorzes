Option Compare Database
Private Function AlapadatInit() As Recordset
    Dim db As DAO.Database
    Dim rst As Recordset
    Set db = CurrentDb
    Set rst = db.OpenRecordset("Select * From tAlapadatok")
    If rst.BOF <> True Then
        rst.MoveLast
        rst.MoveFirst
    End If
    'Debug.Print "Ini"; rst.RecordCount
    Set AlapadatInit = rst
    'Debug.Print AlapadatInit.RecordCount
End Function
Private Sub AlapadatCls(rst)
    Dim db As DAO.Database
    Set db = rst.Parent
    Set rst = Nothing
    Set db = Nothing
End Sub
Function AlapadatLek(objekt As String, tuln�v As String) As String
    Dim rst As Recordset
    Set rst = AlapadatInit()
    rst.MoveFirst
    Do While Not rst.EOF
        If rst!Tulajdons�gNeve = tuln�v And rst!Objektum = objekt Then
            AlapadatLek = Nz(rst!Tulajdons�g�rt�k, "")
            Exit Do
        End If
        rst.MoveNext
    Loop
End Function
Function Alapadat�r(objekt As String, tuln�v As String, �rt�k As Variant) As Boolean
On Error GoTo Hiba
    Dim rst As Recordset
    Dim besz�r�s As Boolean
    besz�r�s = False
    
    Set rst = AlapadatInit()
    rst.MoveFirst
    Do While Not rst.EOF
        If rst!Tulajdons�gNeve = tuln�v And rst!Objektum = objekt Then
            rst.Edit
            rst!Tulajdons�g�rt�k = �rt�k
            rst.Update
            besz�r�s = True
            Exit Do
        End If
        rst.MoveNext
    Loop
    If Not besz�r�s Then
        rst.AddNew
        rst!Tulajdons�gNeve = tuln�v
        rst!Objektum = objekt
        rst!Tulajdons�g�rt�k = �rt�k
        rst.Update
    End If
    Alapadat�r = True
    Exit Function
Hiba:
    Alapadat�r = False
    Debug.Print Err.Number, Err.Description, Err.Source, Err.LastDllError
    MsgBox "Hiba az alapadat r�gz�t�se sor�n:" & Err.Description & " | " & Err.Source, vbOKOnly, "Hiba"
End Function