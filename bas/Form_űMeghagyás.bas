Option Compare Database

Private Sub Ind�t_Click()
fvbe (Me.Name & "Ind�t_Click()")
    Dim db As DAO.Database
    Dim i As Integer
    Dim qdf As QueryDef
    Dim lek(3, 1) As Variant
    lek(1, 1) = "lkMeghagy�s03":    lek(1, 0) = "tMeghagy�s03"
    lek(2, 1) = "lkMeghagy�s�j01":   lek(2, 0) = "tMeghagy�s�jB01"
    lek(3, 1) = "lkMeghagy�s�j02":   lek(3, 0) = "tMeghagy�s�jB02"
    Me.Folyamat.RowSource = "T�bla ill. lek�rdez�s; Sor ill. esem�ny; Id�pont "
    logba , "Meghagy�s k�sz�t�se indul..."
    Set db = CurrentDb
    
    For i = 1 To UBound(lek, 1)
        If TableExists(lek(i, 0), False, db) Then
            db.Execute "DROP TABLE [" & lek(i, 0) & "];", dbFailOnError
        End If
        Set qdf = db.QueryDefs(lek(i, 1))
                    sFoly Me, n�vel�vel(lek(i, 1), , , True) & " lek�rdez�s:; indul..."
                    logba , n�vel�vel(lek(i, 1), , , True) & " lek�rdez�s:; indul..."
        qdf.Execute (dbInconsistent)
                    sFoly Me, n�vel�vel(lek(i, 1), , , True) & " lek�rdez�s:; lefutott."
                    logba , n�vel�vel(lek(i, 1), , , True) & " lek�rdez�s:; indul..."
        qdf.Close
        logba , SetNavPaneGroup(lek(i, 1), "Meghagy�s"), 3
        Set qdf = Nothing
    Next i
                    sFoly Me, "Az eredm�nyek megnyit�sa:;megkezdve..."
                    logba , "Az eredm�nyek megnyit�sa:;megkezdve..."
    DoCmd.OpenQuery "lkMeghagy�sEredm�ny", acViewNormal, acReadOnly
                    sFoly Me, "lkMeghagy�sEredm�ny:; megnyilt."
                    logba , "lkMeghagy�sEredm�ny:; megnyilt."
    DoCmd.OpenQuery "lkMeghagy�sM�trix", acViewNormal, acReadOnly
                    sFoly Me, "lkMeghagy�sM�trix:; megnyilt."
                    logba , "lkMeghagy�sM�trix:; megnyilt."
                    sFoly Me, "Az eredm�nyek megnyit�sa:; v�get �rt!"
                    logba , "Az eredm�nyek megnyit�sa:; v�get �rt!"
                    sFoly Me, "#########################;############", False
                    logba , "#########################;############"
    Me.Ind�t.Enabled = False
    Me.M�gse.Caption = "Kil�p�s"
fvki
End Sub