Option Compare Database
Private gomb As CommandButton

Private Sub �nyr_MouseMove(Button As Integer, Shift As Integer, x As Single, Y As Single)
    Set gomb = Me.�nyr
    gomb.FontBold = True
End Sub
Private Sub Elb�r�latlan_MouseMove(Button As Integer, Shift As Integer, x As Single, Y As Single)
    Set gomb = Me.Elb�r�latlan
    gomb.FontBold = True
End Sub

Private Sub Ellen�rz�Lek�rdez�sek_Click()
    DoCmd.OpenForm "�Ellen�rz�Lek�rdez�sek2", acNormal
End Sub

Private Sub Havi_MouseMove(Button As Integer, Shift As Integer, x As Single, Y As Single)
    Set gomb = Me.Havi
    gomb.FontBold = True
End Sub

Private Sub Hi�nyosMez�t�pusokSz�ma_Click()
Dim sz�m As Long
Dim sql As String
Dim qdf As QueryDef
Dim rs As Recordset
sql = "SELECT Sum(lkEllen�rz�Lek�rdez�sekHi�nyosMez�t�pussal.CountOfAttribute-lkEllen�rz�Lek�rdez�sekHi�nyosMez�t�pussal.CountOfMez�Neve) AS T�pusHi�nyosMez�kSz�ma FROM lkEllen�rz�Lek�rdez�sekHi�nyosMez�t�pussal;"
Set qdf = CurrentDb.CreateQueryDef("", sql)
Set rs = qdf.OpenRecordset(dbOpenSnapshot)
    sz�m = Nz(rs.Fields("T�pusHi�nyosMez�kSz�ma"), 0)
    Me.Hi�nyosMez�t�pusokSz�ma.Caption = Replace("Hi�nyos mez�t�pusok: #&@ db.", "#&@", sz�m)
End Sub

Private Sub Int�zked�sek_Click()
    DoCmd.OpenForm "�R�giHib�kInt�zked�sek"
End Sub

Private Sub Lej�r�Hat�rid�k_Click()
    Dim f�jl As String
    f�jl = Nz(Me.FileLej�r�Hat�rid�k, "")
    
    F�jlV�laszt� Me.FileLej�r�Hat�rid�k, "A Lej�r� hat�rid�k kiv�laszt�sa", "L:\Ugyintezok\Adatszolg�ltat�k\Alapadatok\Lej�r� hat�rid�k", "Lejaro*"
    
    If Me.FileLej�r�Hat�rid�k = f�jl Then
        Me.FileLej�r�Hat�rid�kPipa = False
    End If
End Sub

Private Sub Lej�r�Hat�rid�k_MouseMove(Button As Integer, Shift As Integer, x As Single, Y As Single)
    Set gomb = Me.Lej�r�Hat�rid�k
    gomb.FontBold = True
End Sub

Private Sub Meghagy�s_Click()
    DoCmd.OpenForm formName:="�Meghagy�s"
End Sub

Private Sub Mindet_Click()
    If Me.Mindet = True Then
        Me.A_futtatand�_lek�rdez�sek_gy�jtem�nye__c�mke.Visible = False
        Me.Oszt�ly.Visible = False
    Else
        Me.A_futtatand�_lek�rdez�sek_gy�jtem�nye__c�mke.Visible = True
        Me.Oszt�ly.Visible = True
    End If
End Sub

Private Sub NexonAzonos�t�_MouseMove(Button As Integer, Shift As Integer, x As Single, Y As Single)
    Set gomb = Me.NexonAzonos�t�
    gomb.FontBold = True
End Sub
Private Sub Szem�lyt�rzs_MouseMove(Button As Integer, Shift As Integer, x As Single, Y As Single)
    Set gomb = Me.Szem�lyt�rzs
    gomb.FontBold = True
End Sub
Private Sub Szervezeti_MouseMove(Button As Integer, Shift As Integer, x As Single, Y As Single)
    Set gomb = Me.Szervezeti
    gomb.FontBold = True
End Sub
Private Sub Besorol�siEredm�nyadatok_MouseMove(Button As Integer, Shift As Integer, x As Single, Y As Single)
    Set gomb = Me.Besorol�siEredm�nyadatok
    gomb.FontBold = True
End Sub
Private Sub Hozz�tartoz�kGomb_MouseMove(Button As Integer, Shift As Integer, x As Single, Y As Single)
    Set gomb = Me.Hozz�tartoz�kGomb
    gomb.FontBold = True
End Sub

Private Sub T�glalap99_MouseMove(Button As Integer, Shift As Integer, x As Single, Y As Single)
    If Not gomb Is Nothing Then
        gomb.FontBold = False
        Set gomb = Nothing
    End If
End Sub

Private Sub V�gzetts�gekGomb_MouseMove(Button As Integer, Shift As Integer, x As Single, Y As Single)
    Set gomb = Me.V�gzetts�gekGomb
    gomb.FontBold = True
End Sub


'Private Sub btnMouseOver(gomb As CommandButton)
'
'
'End Sub
Private Sub T�rzs_MouseMove(Button As Integer, Shift As Integer, x As Single, Y As Single)
    If Not gomb Is Nothing Then
        gomb.FontBold = False
        Set gomb = Nothing
    End If
End Sub

Private Sub Ellen�rz�s_AfterUpdate()
    
End Sub

Private Sub AlapadatokGomb_Click()
    DoCmd.OpenForm ("�Alapadatok")
End Sub

Private Sub Beolvas�s_Click()
    If Me.Beolvas�s Then Me.El�k�sz�t�s = True
End Sub

Private Sub Hozz�tartoz�kGomb_Click()
    Dim objHoz As Object

    Set objHoz = CreateObject("Access.Application")
    
    objHoz.OpenCurrentDatabase ("L:\Ugyintezok\Adatszolg�ltat�k\Adatb�zisok\Hozz�tartoz�k.accdb")
    'objHoz.Visible = True
    objHoz.UserControl = True
    objHoz.DoCmd.OpenForm "�F�men�"
End Sub
Private Sub Kimutat�s_AfterUpdate()
    
End Sub
Private Sub Form_Open(Cancel As Integer)
    
    Me.Stop.Visible = False
    Me.FilePipa = False
    Me.FileSzem�lyPipa = False
    Me.FileSzervezetPipa = False
    Me.FileLej�r�Hat�rid�kPipa = False
    Me.FileElb�r�latlanPipa = False
    Me.FileNexonAzonos�t�Pipa = False
    Me.FileBesorol�siEredm�nyadatokPipa = False
    Me.Folyamat.RowSource = "T�bla ill. lek�rdez�s; Sor ill. esem�ny"
    Me.Beolvas�s = False
    Me.El�k�sz�t�s = False
    Me.A_futtatand�_lek�rdez�sek_gy�jtem�nye__c�mke.Visible = False
    Me.Oszt�ly.Visible = False
'
    Me.Refresh
End Sub
Private Sub �nyr_Click()
    Dim objK1K2 As Object

    Set objK1K2 = CreateObject("Access.Application")
    
    objK1K2.OpenCurrentDatabase ("L:\Ugyintezok\Adatszolg�ltat�k\Adatb�zisok\K1K2\K1K2_2211.accdb")
    objK1K2.Visible = True
    objK1K2.UserControl = True
    objK1K2.DoCmd.OpenForm "�Megnyit�s_�nyr"
End Sub
Private Sub Havi_Click()
    Dim f�jl As String
    
    f�jl = Nz(Me.File, "")
    
    F�jlV�laszt� Me.File, "A Havi l�tsz�mjelent�s kiv�laszt�sa", "L:\Ugyintezok\Adatszolg�ltat�k\Alapadatok\Havi l�tsz�mjelent�s", "*Havi*"
    
    If Me.File <> f�jl Then
        Me.FilePipa = False
    End If
    Me.Refresh
End Sub
'Private Sub H�tt�rk�pGomb_Click()
'    Dim F�jl As String
'    F�jl = Nz(Me.h�tt�rk�p, "")
'    F�jlV�laszt� Me.h�tt�rk�p, "A h�tt�rk�pnek a kiv�laszt�sa", "file://///Teve1-jkf-hrf2-oes/vol1/Human/HRF/Ugyintezok/Adatszolg%C3%A1ltat%C3%B3k/HRELL/css/", , "*.jpg, *.png"
'    Alapadat�r "html", "H�tt�rk�p", Me.h�tt�rk�p.Value
'End Sub

Private Sub Stop_Click()
    
        �llj = True
        Me.Eredm�ny.SetFocus
        Me.Stop.Visible = False
    
End Sub

Private Sub Szervezeti_Click()
    Dim f�jl As String
    f�jl = Nz(Me.FileSzervezet, "")
   
    F�jlV�laszt� Me.FileSzervezet, "A Szervezeti alapriport kiv�laszt�sa", "L:\Ugyintezok\Adatszolg�ltat�k\Alapadatok\Szervezet", "Szervezeti alapriport *"
    If Me.FileSzervezet <> f�jl Then
        Me.FileSzervezetPipa = False
    End If

End Sub
Private Sub Szem�lyt�rzs_Click()
    Dim f�jl As String
    f�jl = Nz(Me.FileSzem�ly, "")
    
    F�jlV�laszt� Me.FileSzem�ly, "A Szem�lyt�rzs alapriport kiv�laszt�sa", "L:\Ugyintezok\Adatszolg�ltat�k\Alapadatok\Szem�ly", "*Szem�lyt�rzs alapriport*"
    
    If Me.FileSzem�ly = f�jl Then
        Me.FileSzem�lyPipa = False
    End If
    
End Sub
Private Sub Elb�r�latlan_Click()
    Dim f�jl As String
    f�jl = Nz(Me.FileElb�r�latlan, "")
    
    F�jlV�laszt� Me.FileElb�r�latlan, "Az elb�r�latlan ig�nyek jegyz�k kiv�laszt�sa", "L:\Ugyintezok\Adatszolg�ltat�k\Alapadatok\Elb�r�latlan ig�nyek (Adatv�ltoz�sok)", "Adatv�ltoz�si ig�nyek"
    
    If Me.FileElb�r�latlan = f�jl Then
        Me.FileElb�r�latlanPipa = False
    End If
    
End Sub
Private Sub NexonAzonos�t�_Click()
    Dim f�jl As String
    f�jl = Nz(Me.FileNexonAzonos�t�, "")
    
    F�jlV�laszt� Me.FileNexonAzonos�t�, "A Nexon azonos�t�t tartalmaz� Szem�lyt�rzs kiv�laszt�sa", "L:\Ugyintezok\Adatszolg�ltat�k\Alapadatok\Szem�ly", "Szem�lyt�rzs*(*"
    
    If Me.FileNexonAzonos�t� = f�jl Then
        Me.FileNexonAzonos�t�Pipa = False
    End If
End Sub
Private Sub Besorol�siEredm�nyadatok_Click()
    Dim f�jl As String
    f�jl = Nz(Me.FileBesorol�siEredm�nyadatok, "")
    
    F�jlV�laszt� Me.FileBesorol�siEredm�nyadatok, "A Besorol�si eredm�nyadatokat tartalmaz� �llom�ny kiv�laszt�sa", "L:\Ugyintezok\Adatszolg�ltat�k\Alapadatok\Besorol�si eredm�ny", "*Beso*"
    
    If Me.FileBesorol�siEredm�nyadatok = f�jl Then
        Me.FileBesorol�siEredm�nyadatokPipa = False
    End If
End Sub
'Private Sub Kimenet_Click() '####
'    Dim F�jl As String
'    F�jl = Nz(Me.FileKimenet, "")
'    MappaV�laszt� Me.FileKimenet, "A kimenet hely�nek kiv�laszt�sa", "\\Teve1-jkf-hrf2-oes\vol1\Human\HRF\Ugyintezok\Adatszolg�ltat�k\HRELL"
'    Alapadat�r "html", "kimenet", Me.FileKimenet
'End Sub
Private Sub Eredm�ny_Click()
'####################
'####
'####  START gomb
'####
'####################

    Dim V As Integer
    Dim v�lasz As Boolean
    Dim ehj As New ehjoszt
    
    ehj.Ini
    
    
    V = 0
    �llj = False
    Me.Stop.Visible = True
    Me.Folyamat.RowSource = "T�bla ill. lek�rdez�s; Sor ill. esem�ny; Id�pont "
    Me.FilePipa = False
    Me.FileSzervezetPipa = False
    Me.FileSzem�lyPipa = False
    Me.FileLej�r�Hat�rid�kPipa = False
    Me.FileElb�r�latlanPipa = False
    Me.FileNexonAzonos�t�Pipa = False
    Me.FileBesorol�siEredm�nyadatokPipa = False
    
    '## Ha a jel�l�n�gyzetek Null �rt�ken �llnak, hamis �rt�kre �ll�tjuk �ket.
    If IsNull(Me.Beolvas�s) Then: Me.Beolvas�s = False
    If IsNull(Me.El�k�sz�t�s) Then: Me.El�k�sz�t�s = False


    '## Csak akkor fut le, ha legal�bb egy jel�l�n�gyzet igaz.
    If Me.Beolvas�s Or Not IsNull(Me.Oszt�ly) Or Not IsNull(Me.El�k�sz�t�s) Then
    '## Beolvas�s
        If Me.Beolvas�s Then
        ehj.oszlopszam = 8
            If Me.File.Value <> "" Then
                v�lasz = fvHaviT�blaImport(Me.File.Value, Me)
                If v�lasz Then
                    ehj.Novel
                    Me.FilePipa = True
                                    sFoly Me, "A havi l�tsz�mjelent�s:; beolvastatott."
                Else
                                    sFoly Me, "A havi l�tsz�mjelent�s:; a beolvas�s sikertelen."
                End If
            Else
                                    sFoly Me, "A havi l�tsz�mjelent�s:; a beolvas�s �tugorva."
            End If

            If Me.FileSzervezet.Value <> "" Then
                If SzervezetiT�blaImport(Me.FileSzervezet.Value, Me) Then
                    ehj.Novel
                    Me.FileSzervezetPipa = True
                                    sFoly Me, "A szervezeti t�bla:; beolvastatott."
                Else
                                    sFoly Me, "A szervezeti t�bla:; a beolvas�s sikertelen."
                End If
            Else
                                    sFoly Me, "A szervezeti t�bla:; a beolvas�s �tugorva."
            End If

            If Me.FileSzem�ly.Value <> "" Then
                If tSzem�lyekImport02(Me.FileSzem�ly.Value, Me) Then
                    ehj.Novel
                    Me.FileSzem�lyPipa = True
                                    sFoly Me, "A szem�lyt�rzs t�bla:; beolvastatott."
                    
                Else
                                    sFoly Me, "A szem�lyt�rzs t�bla:; a beolvas�s sikertelen."
                End If
            Else
                                    sFoly Me, "A szem�lyt�rzs t�bla:; a beolvas�s �tugorva."
            End If
DoEvents
            If Me.FileLej�r�Hat�rid�k.Value <> "" Then
                If fvLej�r�Hat�rid�kImport(Me.FileLej�r�Hat�rid�k.Value, Me) Then
                    ehj.Novel
                    Me.FileLej�r�Hat�rid�kPipa = True
                                    sFoly Me, "A Lej�r� hat�rid�k:; beolvastatott."
                Else
                                    sFoly Me, "A Lej�r� hat�rid�k:; a beolvas�s sikertelen."
                End If
            Else
                                    sFoly Me, "A Lej�r� hat�rid�k:; a beolvas�s �tugorva."
            End If
            
            If Me.FileElb�r�latlan.Value <> "" Then
                MegnyitMentBez�r (Me.FileElb�r�latlan.Value) 'Megnyitjuk, elmentj�k �s bez�rjuk - ez csak vaj�kol�s, de m�k�dik...
                If tT�blaImport(Me.FileElb�r�latlan.Value, Me, "tAdatv�ltoztat�siIg�nyek") Then
                    ehj.Novel
                    Me.FileElb�r�latlanPipa = True
                                    sFoly Me, "A tAdatv�ltoztat�siIg�nyek t�bla:; beolvastatott."
                Else
                                    sFoly Me, "A tAdatv�ltoztat�siIg�nyek t�bla:; a beolvas�s sikertelen."
                End If
            Else
                                    sFoly Me, "Az tAdatv�ltoztat�siIg�nyek t�bla:; a beolvas�s �tugorva."
            End If
            
            
            Me.Refresh
            
            If Me.FileNexonAzonos�t�.Value <> "" Then
                MegnyitMentBez�r (Me.FileNexonAzonos�t�.Value) 'Megnyitjuk, elmentj�k �s bez�rjuk - ez csak "vaj�kol�s", de m�k�dik...
                If tT�blaImport(Me.FileNexonAzonos�t�.Value, Me, "tNexonAzonos�t�k") Then
                    ehj.Novel
                    Me.FileNexonAzonos�t�Pipa = True
                                    sFoly Me, "A tNexonAzonos�t�k t�bla:; beolvastatott."
                Else
                                    sFoly Me, "A tNexonAzonos�t�k t�bla:; a beolvas�s sikertelen."
                End If
            Else
                                    sFoly Me, "Az tNexonAzonos�t�k t�bla:; a beolvas�s �tugorva."
            End If
DoEvents
            If Me.FileBesorol�siEredm�nyadatok.Value <> "" Then
                If tSzem�lyekImport02(Me.FileBesorol�siEredm�nyadatok.Value, Me, "tBesorol�siEredm�nyadatok", 1) Then
                    ehj.Novel
                    Me.FileBesorol�siEredm�nyadatokPipa = True
                                    sFoly Me, "A besorol�sok t�bla:; beolvastatott."
                Else
                                    sFoly Me, "A besorol�sok t�bla:; a beolvas�s sikertelen."
                End If
                                    
DoEvents        'Az el�z� munkaviszonyok beolvas�sa:
                If tSzem�lyekImport02(Me.FileBesorol�siEredm�nyadatok.Value, Me, "tEl�z�Munkahelyek", 2) Then
                    sFoly Me, "Az el�z� munkaviszonyok t�bla:;beolvastatott!!"
                End If
            Else
                                    sFoly Me, "A besorol�sok t�bla:; a beolvas�s �tugorva."
            End If
            
             'Az ellen�rz�s k�l�n jel�l� n�gyzetet kapott...
            
        End If
                                    sFoly Me, "A beolvasott f�jlok sz�ma:; " & V
    '## Beolvas�s v�ge
    '# El�k�sz�t�s kezdete

        If Me.El�k�sz�t�s Then
                ehj.oszlopszam = ehj.oszlopszam + 1
                                   sFoly Me, "Bet�lt�s:; ellen�rz�s el�k�sz�t�se megkezdve."
                Ellen�rz�s1 (Me.Name) 'Ellen�rz�s el�k�sz�t�se
                ehj.Novel
                                        sFoly Me, "Beolvas�s:; ellen�rz�s el�k�sz�t�se befejezve."
                Me.Refresh
        End If
    '## HTML elk�sz�t�se indul!!
    Dim i As Integer
        If Me.Mindet Then
            ehj.oszlopszam = ehj.oszlopszam + Me.Oszt�ly.ListCount
            For i = 0 To Me.Oszt�ly.ListCount - 1
                subHTMLKimenet Me, Me.Oszt�ly.ItemData(i)
                ehj.Novel
            Next i
        Else
            
            If Not (IsNull(Me.Oszt�ly) Or IsNull(Me)) Then
                ehj.oszlopszam = ehj.oszlopszam + 1
                subHTMLKimenet Me, Me.Oszt�ly ' Me.Oszt�ly
                ehj.Novel
            End If
                                        sFoly Me, "##########################;########", False
        End If
    End If
    
    '## A kimutat�snak �s az ellen�rz�s folytat�s�nak a v�ge
'## Innen akkor is fut, ha egy jel�l� n�gyzet sem igaz
                                    sFoly Me, "############# v�ge #######;# fine #", False
    Me.Stop.Visible = False
End Sub

Private Sub sz�n_Click()
'    Call Sz�nGomb_Click
End Sub

Private Sub Sz�nGomb_Click()
fvbe ("Sz�nGomb_Click()")
'    Dim iSz�n As Long
'        iSz�n = DialogColor()
'        Me.Sz�nv�laszt�.Value = "#" & Hex(iSz�n)
'        logba , Alapadat�r("html", "H�tt�rsz�n", "#" & Hex(iSz�n)), 3
'        Me.sz�n.BackColor = iSz�n
'        Me.sz�n.SetFocus
'        Me.sz�n.Text = ""
'        Me.Sz�nGomb.SetFocus
fvki
End Sub

Private Sub Sz�nv�laszt�_AfterUpdate()
fvbe ("Sz�nv�laszt�_AfterUpdate()")
'    Dim sz�n�rt�k As String
'    sz�n�rt�k = Me.Sz�nv�laszt�.Value
'    If Left(sz�n�rt�k, 1) <> "#" Then
'        sz�n�rt�k = "#" & sz�n�rt�k
'    End If
'    If Len(sz�n�rt�k) <> 7 Then
'        MsgBox "Hib�s sz�n�rt�k. A sz�n�rt�k 7 jegy� hexadecim�lis sz�m, el�tte # jellel", vbOKOnly, "Hiba"
'        Me.Sz�nv�laszt�.SetFocus
'        Exit Sub
'    End If
'    logba , Alapadat�r("html", "H�tt�rsz�n", Me.Sz�nv�laszt�.Value), 3
'    Me.sz�n.BackColor = Num2Num(Right(AlapadatLek("html", "H�tt�rsz�n"), 6), nnHex, nnDecimal)
fvki
End Sub



Private Sub V�gzetts�gekGomb_Click()
    Dim objHoz As Object

    Set objHoz = CreateObject("Access.Application")
    
    objHoz.OpenCurrentDatabase ("L:\Ugyintezok\Adatszolg�ltat�k\Adatb�zisok\V�gzetts�gek.accdb")
    'objHoz.Visible = True
    objHoz.UserControl = True
    objHoz.DoCmd.OpenForm "�F�men�"
End Sub


