Option Compare Database

Private Sub Kombin�ltLista27_AfterUpdate()

End Sub

Private Sub Form_Open(Cancel As Integer)
'    Dim tmpObjTip As TempVars
'    Dim tmpObj  As TempVars
'    Dim tmpTulNeve  As TempVars
'    TempVars!tmpObjTip = vbNullString
'    TempVars!tmpObj = vbNullString
'    TempVars!tmpTulNeve = vbNullString
    
    Me.Requery
End Sub

Private Sub Keres�ObjT�pus_AfterUpdate()
    'TempVars!tmpObjTip = Me.ObjektumT�pus.Name
    Me.Requery
End Sub



Private Sub Objektum_AfterUpdate()
    Me.Refresh
End Sub

Private Sub ObjektumT�pus_AfterUpdate()
    Me.Refresh
End Sub

Private Sub Tulajdons�g�rt�k_DblClick(Cancel As Integer)
    If IsNull(Me.T�pus) Then _
        Exit Sub
    
    Select Case Me.T�pus
        Case "mappa"
            MappaV�laszt� Me.Tulajdons�g�rt�k, Me.Tulajdons�gNeve, Me.Tulajdons�g�rt�k
            
        Case "sz�n"
            Dim sz�n�rt�k As String
            sz�n�rt�k = Me.Tulajdons�g�rt�k.Value
            If Left(sz�n�rt�k, 1) <> "#" Then
                sz�n�rt�k = "#" & sz�n�rt�k
            End If
            If Len(sz�n�rt�k) <> 7 Then
                MsgBox "Hib�s sz�n�rt�k. A sz�n�rt�k 7 jegy� hexadecim�lis sz�m, el�tte # jellel", vbOKOnly, "Hiba"
                Me.Tulajdons�g�rt�k.SetFocus
                Exit Sub
            End If
            logba , Alapadat�r("html", Me.Tulajdons�gNeve, Me.Tulajdons�g�rt�k.Value), 3
            'Me.Tulajdons�g�rt�k.BackColor = Num2Num(Right(AlapadatLek("html", Me.Tulajdons�gNeve), 6), nnHex, nnDecimal)
    End Select
End Sub