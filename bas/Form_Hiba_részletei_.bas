Option Compare Database


Private Sub Form_Current()
Dim t�mb() As Variant
Me.Hiba.RowSource = "Mez�; Tartalom"
t�mb = sz�tbont�(Me.M�sodik_mez�, Me.Lek�rdez�sNeve)
    For i = LBound(t�mb) To UBound(t�mb)
        Me.Hiba.AddItem t�mb(i, 1) & ":;" & t�mb(i, 2)
    Next i
End Sub


Private Sub hiba_Click()
    Me.Hiba.Requery
End Sub