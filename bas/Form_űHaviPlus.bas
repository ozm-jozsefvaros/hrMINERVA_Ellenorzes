Option Compare Database

Private Sub Beolvas�s_Click()
    HaviT�blaPlus (Me.File)
    MsgBox Me.File & " beolvas�sa lefutott."
    Me.Lista13.Requery
End Sub

Private Sub File_AfterUpdate()
Me.Lista13.Requery
End Sub

Private Sub FileKeres�_Click()
    Dim f�jl As String
    
    f�jl = Nz(Me.File, "")
    
    F�jlV�laszt� Me.File, "A Havi l�tsz�mjelent�s kiv�laszt�sa", "L:\Ugyintezok\Adatszolg�ltat�k\Alapadatok\Havi l�tsz�mjelent�s", "*"
  

End Sub
