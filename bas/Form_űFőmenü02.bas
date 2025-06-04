Option Compare Database
Private gomb As CommandButton

Private Sub Ányr_MouseMove(Button As Integer, Shift As Integer, x As Single, Y As Single)
    Set gomb = Me.Ányr
    gomb.FontBold = True
End Sub
Private Sub Elbírálatlan_MouseMove(Button As Integer, Shift As Integer, x As Single, Y As Single)
    Set gomb = Me.Elbírálatlan
    gomb.FontBold = True
End Sub

Private Sub EllenõrzõLekérdezések_Click()
    DoCmd.OpenForm "ûEllenõrzõLekérdezések2", acNormal
End Sub

Private Sub Havi_MouseMove(Button As Integer, Shift As Integer, x As Single, Y As Single)
    Set gomb = Me.Havi
    gomb.FontBold = True
End Sub

Private Sub HiányosMezõtípusokSzáma_Click()
Dim szám As Long
Dim sql As String
Dim qdf As QueryDef
Dim rs As Recordset
sql = "SELECT Sum(lkEllenõrzõLekérdezésekHiányosMezõtípussal.CountOfAttribute-lkEllenõrzõLekérdezésekHiányosMezõtípussal.CountOfMezõNeve) AS TípusHiányosMezõkSzáma FROM lkEllenõrzõLekérdezésekHiányosMezõtípussal;"
Set qdf = CurrentDb.CreateQueryDef("", sql)
Set rs = qdf.OpenRecordset(dbOpenSnapshot)
    szám = Nz(rs.Fields("TípusHiányosMezõkSzáma"), 0)
    Me.HiányosMezõtípusokSzáma.Caption = Replace("Hiányos mezõtípusok: #&@ db.", "#&@", szám)
End Sub

Private Sub Intézkedések_Click()
    DoCmd.OpenForm "ûRégiHibákIntézkedések"
End Sub

Private Sub LejáróHatáridõk_Click()
    Dim fájl As String
    fájl = Nz(Me.FileLejáróHatáridõk, "")
    
    FájlVálasztó Me.FileLejáróHatáridõk, "A Lejáró határidõk kiválasztása", "L:\Ugyintezok\Adatszolgáltatók\Alapadatok\Lejáró határidõk", "Lejaro*"
    
    If Me.FileLejáróHatáridõk = fájl Then
        Me.FileLejáróHatáridõkPipa = False
    End If
End Sub

Private Sub LejáróHatáridõk_MouseMove(Button As Integer, Shift As Integer, x As Single, Y As Single)
    Set gomb = Me.LejáróHatáridõk
    gomb.FontBold = True
End Sub

Private Sub Meghagyás_Click()
    DoCmd.OpenForm formName:="ûMeghagyás"
End Sub

Private Sub Mindet_Click()
    If Me.Mindet = True Then
        Me.A_futtatandó_lekérdezések_gyûjteménye__címke.Visible = False
        Me.Osztály.Visible = False
    Else
        Me.A_futtatandó_lekérdezések_gyûjteménye__címke.Visible = True
        Me.Osztály.Visible = True
    End If
End Sub

Private Sub NexonAzonosító_MouseMove(Button As Integer, Shift As Integer, x As Single, Y As Single)
    Set gomb = Me.NexonAzonosító
    gomb.FontBold = True
End Sub
Private Sub Személytörzs_MouseMove(Button As Integer, Shift As Integer, x As Single, Y As Single)
    Set gomb = Me.Személytörzs
    gomb.FontBold = True
End Sub
Private Sub Szervezeti_MouseMove(Button As Integer, Shift As Integer, x As Single, Y As Single)
    Set gomb = Me.Szervezeti
    gomb.FontBold = True
End Sub
Private Sub BesorolásiEredményadatok_MouseMove(Button As Integer, Shift As Integer, x As Single, Y As Single)
    Set gomb = Me.BesorolásiEredményadatok
    gomb.FontBold = True
End Sub
Private Sub HozzátartozókGomb_MouseMove(Button As Integer, Shift As Integer, x As Single, Y As Single)
    Set gomb = Me.HozzátartozókGomb
    gomb.FontBold = True
End Sub

Private Sub Téglalap99_MouseMove(Button As Integer, Shift As Integer, x As Single, Y As Single)
    If Not gomb Is Nothing Then
        gomb.FontBold = False
        Set gomb = Nothing
    End If
End Sub

Private Sub VégzettségekGomb_MouseMove(Button As Integer, Shift As Integer, x As Single, Y As Single)
    Set gomb = Me.VégzettségekGomb
    gomb.FontBold = True
End Sub


'Private Sub btnMouseOver(gomb As CommandButton)
'
'
'End Sub
Private Sub Törzs_MouseMove(Button As Integer, Shift As Integer, x As Single, Y As Single)
    If Not gomb Is Nothing Then
        gomb.FontBold = False
        Set gomb = Nothing
    End If
End Sub

Private Sub Ellenõrzés_AfterUpdate()
    
End Sub

Private Sub AlapadatokGomb_Click()
    DoCmd.OpenForm ("ûAlapadatok")
End Sub

Private Sub Beolvasás_Click()
    If Me.Beolvasás Then Me.Elõkészítés = True
End Sub

Private Sub HozzátartozókGomb_Click()
    Dim objHoz As Object

    Set objHoz = CreateObject("Access.Application")
    
    objHoz.OpenCurrentDatabase ("L:\Ugyintezok\Adatszolgáltatók\Adatbázisok\Hozzátartozók.accdb")
    'objHoz.Visible = True
    objHoz.UserControl = True
    objHoz.DoCmd.OpenForm "ûFõmenü"
End Sub
Private Sub Kimutatás_AfterUpdate()
    
End Sub
Private Sub Form_Open(Cancel As Integer)
    
    Me.Stop.Visible = False
    Me.FilePipa = False
    Me.FileSzemélyPipa = False
    Me.FileSzervezetPipa = False
    Me.FileLejáróHatáridõkPipa = False
    Me.FileElbírálatlanPipa = False
    Me.FileNexonAzonosítóPipa = False
    Me.FileBesorolásiEredményadatokPipa = False
    Me.Folyamat.RowSource = "Tábla ill. lekérdezés; Sor ill. esemény"
    Me.Beolvasás = False
    Me.Elõkészítés = False
    Me.A_futtatandó_lekérdezések_gyûjteménye__címke.Visible = False
    Me.Osztály.Visible = False
'
    Me.Refresh
End Sub
Private Sub Ányr_Click()
    Dim objK1K2 As Object

    Set objK1K2 = CreateObject("Access.Application")
    
    objK1K2.OpenCurrentDatabase ("L:\Ugyintezok\Adatszolgáltatók\Adatbázisok\K1K2\K1K2_2211.accdb")
    objK1K2.Visible = True
    objK1K2.UserControl = True
    objK1K2.DoCmd.OpenForm "ûMegnyitás_Ányr"
End Sub
Private Sub Havi_Click()
    Dim fájl As String
    
    fájl = Nz(Me.File, "")
    
    FájlVálasztó Me.File, "A Havi létszámjelentés kiválasztása", "L:\Ugyintezok\Adatszolgáltatók\Alapadatok\Havi létszámjelentés", "*Havi*"
    
    If Me.File <> fájl Then
        Me.FilePipa = False
    End If
    Me.Refresh
End Sub
'Private Sub HáttérképGomb_Click()
'    Dim Fájl As String
'    Fájl = Nz(Me.háttérkép, "")
'    FájlVálasztó Me.háttérkép, "A háttérképnek a kiválasztása", "file://///Teve1-jkf-hrf2-oes/vol1/Human/HRF/Ugyintezok/Adatszolg%C3%A1ltat%C3%B3k/HRELL/css/", , "*.jpg, *.png"
'    AlapadatÍr "html", "Háttérkép", Me.háttérkép.Value
'End Sub

Private Sub Stop_Click()
    
        állj = True
        Me.Eredmény.SetFocus
        Me.Stop.Visible = False
    
End Sub

Private Sub Szervezeti_Click()
    Dim fájl As String
    fájl = Nz(Me.FileSzervezet, "")
   
    FájlVálasztó Me.FileSzervezet, "A Szervezeti alapriport kiválasztása", "L:\Ugyintezok\Adatszolgáltatók\Alapadatok\Szervezet", "Szervezeti alapriport *"
    If Me.FileSzervezet <> fájl Then
        Me.FileSzervezetPipa = False
    End If

End Sub
Private Sub Személytörzs_Click()
    Dim fájl As String
    fájl = Nz(Me.FileSzemély, "")
    
    FájlVálasztó Me.FileSzemély, "A Személytörzs alapriport kiválasztása", "L:\Ugyintezok\Adatszolgáltatók\Alapadatok\Személy", "*Személytörzs alapriport*"
    
    If Me.FileSzemély = fájl Then
        Me.FileSzemélyPipa = False
    End If
    
End Sub
Private Sub Elbírálatlan_Click()
    Dim fájl As String
    fájl = Nz(Me.FileElbírálatlan, "")
    
    FájlVálasztó Me.FileElbírálatlan, "Az elbírálatlan igények jegyzék kiválasztása", "L:\Ugyintezok\Adatszolgáltatók\Alapadatok\Elbírálatlan igények (Adatváltozások)", "Adatváltozási igények"
    
    If Me.FileElbírálatlan = fájl Then
        Me.FileElbírálatlanPipa = False
    End If
    
End Sub
Private Sub NexonAzonosító_Click()
    Dim fájl As String
    fájl = Nz(Me.FileNexonAzonosító, "")
    
    FájlVálasztó Me.FileNexonAzonosító, "A Nexon azonosítót tartalmazó Személytörzs kiválasztása", "L:\Ugyintezok\Adatszolgáltatók\Alapadatok\Személy", "Személytörzs*(*"
    
    If Me.FileNexonAzonosító = fájl Then
        Me.FileNexonAzonosítóPipa = False
    End If
End Sub
Private Sub BesorolásiEredményadatok_Click()
    Dim fájl As String
    fájl = Nz(Me.FileBesorolásiEredményadatok, "")
    
    FájlVálasztó Me.FileBesorolásiEredményadatok, "A Besorolási eredményadatokat tartalmazó állomány kiválasztása", "L:\Ugyintezok\Adatszolgáltatók\Alapadatok\Besorolási eredmény", "*Beso*"
    
    If Me.FileBesorolásiEredményadatok = fájl Then
        Me.FileBesorolásiEredményadatokPipa = False
    End If
End Sub
'Private Sub Kimenet_Click() '####
'    Dim Fájl As String
'    Fájl = Nz(Me.FileKimenet, "")
'    MappaVálasztó Me.FileKimenet, "A kimenet helyének kiválasztása", "\\Teve1-jkf-hrf2-oes\vol1\Human\HRF\Ugyintezok\Adatszolgáltatók\HRELL"
'    AlapadatÍr "html", "kimenet", Me.FileKimenet
'End Sub
Private Sub Eredmény_Click()
'####################
'####
'####  START gomb
'####
'####################

    Dim V As Integer
    Dim válasz As Boolean
    Dim ehj As New ehjoszt
    
    ehj.Ini
    
    
    V = 0
    állj = False
    Me.Stop.Visible = True
    Me.Folyamat.RowSource = "Tábla ill. lekérdezés; Sor ill. esemény; Idõpont "
    Me.FilePipa = False
    Me.FileSzervezetPipa = False
    Me.FileSzemélyPipa = False
    Me.FileLejáróHatáridõkPipa = False
    Me.FileElbírálatlanPipa = False
    Me.FileNexonAzonosítóPipa = False
    Me.FileBesorolásiEredményadatokPipa = False
    
    '## Ha a jelölõnégyzetek Null értéken állnak, hamis értékre állítjuk õket.
    If IsNull(Me.Beolvasás) Then: Me.Beolvasás = False
    If IsNull(Me.Elõkészítés) Then: Me.Elõkészítés = False


    '## Csak akkor fut le, ha legalább egy jelölõnégyzet igaz.
    If Me.Beolvasás Or Not IsNull(Me.Osztály) Or Not IsNull(Me.Elõkészítés) Then
    '## Beolvasás
        If Me.Beolvasás Then
        ehj.oszlopszam = 8
            If Me.File.Value <> "" Then
                válasz = fvHaviTáblaImport(Me.File.Value, Me)
                If válasz Then
                    ehj.Novel
                    Me.FilePipa = True
                                    sFoly Me, "A havi létszámjelentés:; beolvastatott."
                Else
                                    sFoly Me, "A havi létszámjelentés:; a beolvasás sikertelen."
                End If
            Else
                                    sFoly Me, "A havi létszámjelentés:; a beolvasás átugorva."
            End If

            If Me.FileSzervezet.Value <> "" Then
                If SzervezetiTáblaImport(Me.FileSzervezet.Value, Me) Then
                    ehj.Novel
                    Me.FileSzervezetPipa = True
                                    sFoly Me, "A szervezeti tábla:; beolvastatott."
                Else
                                    sFoly Me, "A szervezeti tábla:; a beolvasás sikertelen."
                End If
            Else
                                    sFoly Me, "A szervezeti tábla:; a beolvasás átugorva."
            End If

            If Me.FileSzemély.Value <> "" Then
                If tSzemélyekImport02(Me.FileSzemély.Value, Me) Then
                    ehj.Novel
                    Me.FileSzemélyPipa = True
                                    sFoly Me, "A személytörzs tábla:; beolvastatott."
                    
                Else
                                    sFoly Me, "A személytörzs tábla:; a beolvasás sikertelen."
                End If
            Else
                                    sFoly Me, "A személytörzs tábla:; a beolvasás átugorva."
            End If
DoEvents
            If Me.FileLejáróHatáridõk.Value <> "" Then
                If fvLejáróHatáridõkImport(Me.FileLejáróHatáridõk.Value, Me) Then
                    ehj.Novel
                    Me.FileLejáróHatáridõkPipa = True
                                    sFoly Me, "A Lejáró határidõk:; beolvastatott."
                Else
                                    sFoly Me, "A Lejáró határidõk:; a beolvasás sikertelen."
                End If
            Else
                                    sFoly Me, "A Lejáró határidõk:; a beolvasás átugorva."
            End If
            
            If Me.FileElbírálatlan.Value <> "" Then
                MegnyitMentBezár (Me.FileElbírálatlan.Value) 'Megnyitjuk, elmentjük és bezárjuk - ez csak vajákolás, de mûködik...
                If tTáblaImport(Me.FileElbírálatlan.Value, Me, "tAdatváltoztatásiIgények") Then
                    ehj.Novel
                    Me.FileElbírálatlanPipa = True
                                    sFoly Me, "A tAdatváltoztatásiIgények tábla:; beolvastatott."
                Else
                                    sFoly Me, "A tAdatváltoztatásiIgények tábla:; a beolvasás sikertelen."
                End If
            Else
                                    sFoly Me, "Az tAdatváltoztatásiIgények tábla:; a beolvasás átugorva."
            End If
            
            
            Me.Refresh
            
            If Me.FileNexonAzonosító.Value <> "" Then
                MegnyitMentBezár (Me.FileNexonAzonosító.Value) 'Megnyitjuk, elmentjük és bezárjuk - ez csak "vajákolás", de mûködik...
                If tTáblaImport(Me.FileNexonAzonosító.Value, Me, "tNexonAzonosítók") Then
                    ehj.Novel
                    Me.FileNexonAzonosítóPipa = True
                                    sFoly Me, "A tNexonAzonosítók tábla:; beolvastatott."
                Else
                                    sFoly Me, "A tNexonAzonosítók tábla:; a beolvasás sikertelen."
                End If
            Else
                                    sFoly Me, "Az tNexonAzonosítók tábla:; a beolvasás átugorva."
            End If
DoEvents
            If Me.FileBesorolásiEredményadatok.Value <> "" Then
                If tSzemélyekImport02(Me.FileBesorolásiEredményadatok.Value, Me, "tBesorolásiEredményadatok", 1) Then
                    ehj.Novel
                    Me.FileBesorolásiEredményadatokPipa = True
                                    sFoly Me, "A besorolások tábla:; beolvastatott."
                Else
                                    sFoly Me, "A besorolások tábla:; a beolvasás sikertelen."
                End If
                                    
DoEvents        'Az elõzõ munkaviszonyok beolvasása:
                If tSzemélyekImport02(Me.FileBesorolásiEredményadatok.Value, Me, "tElõzõMunkahelyek", 2) Then
                    sFoly Me, "Az elõzõ munkaviszonyok tábla:;beolvastatott!!"
                End If
            Else
                                    sFoly Me, "A besorolások tábla:; a beolvasás átugorva."
            End If
            
             'Az ellenõrzés külön jelölõ négyzetet kapott...
            
        End If
                                    sFoly Me, "A beolvasott fájlok száma:; " & V
    '## Beolvasás vége
    '# Elõkészítés kezdete

        If Me.Elõkészítés Then
                ehj.oszlopszam = ehj.oszlopszam + 1
                                   sFoly Me, "Betöltés:; ellenõrzés elõkészítése megkezdve."
                Ellenõrzés1 (Me.Name) 'Ellenõrzés elõkészítése
                ehj.Novel
                                        sFoly Me, "Beolvasás:; ellenõrzés elõkészítése befejezve."
                Me.Refresh
        End If
    '## HTML elkészítése indul!!
    Dim i As Integer
        If Me.Mindet Then
            ehj.oszlopszam = ehj.oszlopszam + Me.Osztály.ListCount
            For i = 0 To Me.Osztály.ListCount - 1
                subHTMLKimenet Me, Me.Osztály.ItemData(i)
                ehj.Novel
            Next i
        Else
            
            If Not (IsNull(Me.Osztály) Or IsNull(Me)) Then
                ehj.oszlopszam = ehj.oszlopszam + 1
                subHTMLKimenet Me, Me.Osztály ' Me.Osztály
                ehj.Novel
            End If
                                        sFoly Me, "##########################;########", False
        End If
    End If
    
    '## A kimutatásnak és az ellenõrzés folytatásának a vége
'## Innen akkor is fut, ha egy jelölõ négyzet sem igaz
                                    sFoly Me, "############# vége #######;# fine #", False
    Me.Stop.Visible = False
End Sub

Private Sub szín_Click()
'    Call SzínGomb_Click
End Sub

Private Sub SzínGomb_Click()
fvbe ("SzínGomb_Click()")
'    Dim iSzín As Long
'        iSzín = DialogColor()
'        Me.Színválasztó.Value = "#" & Hex(iSzín)
'        logba , AlapadatÍr("html", "Háttérszín", "#" & Hex(iSzín)), 3
'        Me.szín.BackColor = iSzín
'        Me.szín.SetFocus
'        Me.szín.Text = ""
'        Me.SzínGomb.SetFocus
fvki
End Sub

Private Sub Színválasztó_AfterUpdate()
fvbe ("Színválasztó_AfterUpdate()")
'    Dim színérték As String
'    színérték = Me.Színválasztó.Value
'    If Left(színérték, 1) <> "#" Then
'        színérték = "#" & színérték
'    End If
'    If Len(színérték) <> 7 Then
'        MsgBox "Hibás színérték. A színérték 7 jegyû hexadecimális szám, elõtte # jellel", vbOKOnly, "Hiba"
'        Me.Színválasztó.SetFocus
'        Exit Sub
'    End If
'    logba , AlapadatÍr("html", "Háttérszín", Me.Színválasztó.Value), 3
'    Me.szín.BackColor = Num2Num(Right(AlapadatLek("html", "Háttérszín"), 6), nnHex, nnDecimal)
fvki
End Sub



Private Sub VégzettségekGomb_Click()
    Dim objHoz As Object

    Set objHoz = CreateObject("Access.Application")
    
    objHoz.OpenCurrentDatabase ("L:\Ugyintezok\Adatszolgáltatók\Adatbázisok\Végzettségek.accdb")
    'objHoz.Visible = True
    objHoz.UserControl = True
    objHoz.DoCmd.OpenForm "ûFõmenü"
End Sub


