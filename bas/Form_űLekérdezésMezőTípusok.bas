Option Compare Database

Private Sub Kombin�ltLista13_AfterUpdate()
    If Nz(Me.Kombin�ltLista13, "") = "" Then
        Me.Filter = ""
        Me.FilterOn = True
    Else
        Me.Filter = "[Lek�rdez�sNeve] like '*" & Me.Kombin�ltLista13 & "*'"
        Me.FilterOn = True
    End If
    
End Sub

Private Sub Lekr�dez�sNeve_AfterUpdate()
    Me.Mez�Neve.Requery
End Sub