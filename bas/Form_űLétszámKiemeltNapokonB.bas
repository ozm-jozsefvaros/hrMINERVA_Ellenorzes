Option Compare Database

Private Sub Jogviszony_Change()
Me.�sszegz�s.Caption = �sszegz�
End Sub

Private Sub Kezd��v_Change()
    'Me.�sszegz�s.SetFocus
    Me.�sszegz�s.Caption = �sszegz�
    Debug.Print Me.Kezd��v
End Sub

Private Sub Parancsgomb1_Click()
Me.Requery
End Sub
Private Function �sszegz�()
Dim k�v As Integer, _
    kH� As Integer, _
    kNap As Integer, _
    v�v As Integer, _
    vH� As Integer, _
    vNap As Integer
    k�v = Year(Nz(Me.Kezd��v, Now()))
    kH� = Month(Nz(Me.Kezd��v, Now()))
    kNap = Day(Nz(Me.Kezd��v, Now()))
    v�v = Year(Nz(Me.V�ge�v, Now()))
    vH� = Month(Nz(Me.V�ge�v, Now()))
    vNap = Day(Nz(Me.V�ge�v, Now()))
    
�sszegz� = "Lek�rdezz�k " & _
            n�vel�vel(k�v) & ". �vi " & _
            kH� & ". h� " & _
            kNap & ". napja �s " & _
            n�vel�vel(v�v) & ". �vi " & _
            vH� & ". h� " & _
            vNap & ". napja k�z�tti id�szakban minden h�napnak " & _
            n�vel�vel(Nz(Me.V�lasztottNap, 1)) & ". napj�n " & _
            n�vel�vel(Nz(Me.Jogviszony, "Munkaviszony")) & " jogviszonyban, a korm�nyhivatalban foglalkoztatottak l�tsz�m�t."
End Function

Private Sub V�lasztottNap_Change()
Me.�sszegz�s.Caption = �sszegz�
End Sub

Private Sub V�ge�v_Change()
Me.�sszegz�s.Caption = �sszegz�
End Sub