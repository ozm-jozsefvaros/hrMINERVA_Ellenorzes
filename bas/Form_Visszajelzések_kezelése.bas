Option Compare Database

Private Sub Form_Current()
    Me.Hiba_r�szletei_.Requery
End Sub

Private Sub Parancsgomb33_Click()
    DoCmd.OpenForm "�Int�zked�sek", acNormal, , , acFormAdd, acDialog
    Me.Requery
End Sub

Private Sub �jVisszajelz�s_Click()
Dim GR As Integer
GR = GroupwiseRead

Me.�jVisszajelz�s.Caption = Replace("�j visszajelz�sek ($)", "$", GR)
Me.Requery
    
End Sub

