Option Compare Database

Private Sub FejezetekGomb_Click()
    DoCmd.OpenForm "�Lek�rdez�s fejezetek", acNormal, , , acFormEdit, acDialog
End Sub

Private Sub Keres�s_Change()
    Me.TimerInterval = 500
End Sub

Private Sub Form_Timer()
    Me.TimerInterval = 0
    Me.Requery
    Me.Keres�s.SetFocus
    Me.Keres�s.SelStart = Len(Me.Keres�s.text)
End Sub

Private Sub OldalakGomb_Click()
    DoCmd.OpenForm "�Oldalc�mek", acNormal, , , acFormEdit, acDialog
End Sub

Private Sub �jFejezet_Click()
    DoCmd.OpenForm "s�Lek�rdez�s t�pusok", acNormal, , , acFormAdd, acDialog
End Sub