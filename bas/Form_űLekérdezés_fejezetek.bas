Option Compare Database

Private Sub Kombin�ltLista11_AfterUpdate()

    If Me.Kombin�ltLista11 = 0 Then
        Me.FilterOn = False
    Else
        
        Me.Filter = "[Oszt�ly]= " & Me.Kombin�ltLista11
        Me.FilterOn = True
    End If
End Sub