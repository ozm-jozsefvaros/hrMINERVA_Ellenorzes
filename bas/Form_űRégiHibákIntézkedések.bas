Option Compare Database



Private Sub Fenn�llE_AfterUpdate()
Me.Requery
End Sub

Private Sub Form_Current()
    Me.Hiba_r�szletei_.Requery
End Sub

Private Sub Form_Load()
Me.Keres� = "*"
Me.Requery
End Sub

Private Sub Keres�_AfterUpdate()
'    Me.FilterOn = False
'    Me.Filter = "[lek�rdez�sNeve] = '" & Me.Keres�.Value & "'"
'    Me.FilterOn = True
Me.Requery

End Sub