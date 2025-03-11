Option Compare Database
Global �llj As Boolean
Public hibat�bla As Recordset
Public �jhibat�bla As Recordset
Public futtat�shibat�bla As Recordset
Public futtat�sokt�bla As Recordset
Public tHib�k As Recordset
Public tFuttat�sokHib�k As Recordset
Public jelenDb As DAO.Database
Public teszt As Boolean ' False 'Ha ez True, akkor teszt �zemm�dban fut (nem futtatja a lek�rdez�seket)
Const cMez�T�pusa As Byte = 2
Const cGrafikonra As Byte = 3
Const cHashbe As Byte = 4
Sub OldalPanel(ByRef hf As Object, ByRef lkEll As DAO.Recordset, ByVal F�c�m As String, ByVal oldalc�m As String)
fvbe ("OldalPanel")
    With hf
        .WriteLine "<div id=""oldalpanel"" class=""oldalpanel"">"
        .WriteLine "<div ><h3>" & F�c�m & "</h3></div>"
        .WriteLine "    <h1 class=""oldal"">" & oldalc�m & "</h1>"
        .WriteLine "    <div id=""kereso"">"
        .WriteLine "        <div>"
        .WriteLine "            <input id=""pageSearch"" type=""text"" placeholder=""Minden t�bl�ban keres (min. 3 le�t�s)"">"
        .WriteLine "        </div>"
        .WriteLine "        <div class=""pageNumber"" style="""">"
        .WriteLine "            <table>"
        .WriteLine "                <thead><tr><td>A tal�latok sz�ma:</td></tr></thead>"
        .WriteLine "                <tbody><tr><td id=""talalatszam"">0</td></tr></tbody>"
        .WriteLine "            </table>"
        .WriteLine "        </div>"
        .WriteLine "    </div>"
        .WriteLine "    <h2>T�bl�k</h2>"
        
        Dim el�z�FejezetC�m As String
        el�z�FejezetC�m = ""
        Dim T�blaSz�m As Integer
        T�blaSz�m = 0
        Do Until lkEll.EOF
            T�blaSz�m = T�blaSz�m + 1
            Dim fejezetC�m As String
            fejezetC�m = lkEll("LapN�v")
            Dim fejezetmegj
            fejezetmegj = lkEll("Megjegyz�s")
            
            If el�z�FejezetC�m = "" Then 'els� fejezet
                el�z�FejezetC�m = fejezetC�m
                .WriteLine "    <ul class=""chapter-list"">" 'Megnyitjuk a fejezetek list�t
                .WriteLine "    <li class=""chapter-list-item"" title=""" & fejezetmegj & """><a href=#" & Replace(fejezetC�m, " ", "") & ">" & fejezetC�m & "</a></li>" 'Beillesztj�k az els� fejezetet
                .WriteLine "        <ul class=""table-list"">" 'Megnyitjuk az els� t�blalist�t
            End If
            
            If fejezetC�m <> el�z�FejezetC�m Then '�j fejezet
                el�z�FejezetC�m = fejezetC�m
                .WriteLine "        </ul>" 'Lez�rjuk az el�z� t�blalist�t
                .WriteLine "    <li class=""chapter-list-item"" title=""" & fejezetmegj & """><a href=#" & Replace(fejezetC�m, " ", "") & ">" & fejezetC�m & "</a></li>" ' Bejegyezz�k a k�vetkez� fejezetlista elemet
                .WriteLine "        <ul class=""table-list"">" 'Megnyitjuk az �j t�blalist�t
            End If
            
            Dim T�blac�m As String
            T�blac�m = lkEll("T�blac�m")
            Dim megj As String
            megj = Nz(lkEll("T�blaMegjegyz�s"), "")
            Dim vaneGraf As Variant
            vaneGraf = lkEll("vaneGraf")
            
            .WriteLine "        <li class=""table-list-item"" title=""" & megj & """>"
            If vaneGraf <> vbNullString Then
                Dim grIkon As String
                grIkon = "&#x1F4CA;" ' A grafikont jelz� ikon
                .WriteLine "            <div class=""linkIkon"" >"
                .WriteLine "                <a href=""#canv-table" & T�blaSz�m & """>" & grIkon & "</a>"
                .WriteLine "            </div>"
            Else
                .WriteLine "            <div class=""linkIkon"" ></div>"
            End If
            .WriteLine "                <div class=""table-linkdiv"">"
            .WriteLine "                    <a href=#table" & T�blaSz�m & " class=""table-link"">" & T�blac�m & "</a>"
            .WriteLine "                </div></li>"
            
            lkEll.MoveNext
        Loop
        .WriteLine "        </ul>" 'lez�rjuk az utols� t�blalist�t
        .WriteLine "    </ul>" 'lez�rjuk az utols� fejezetlist�t
        .WriteLine "</div>" 'lez�rjuk az oldalpanelt
        .WriteLine "</div>" 'lez�rjuk a g�rd�l� oldalpanelt
        .WriteLine "<div class=""fotartalom"">"
    End With
fvki
End Sub
Sub fejl�c(ByRef hf As Object, ByVal oldalc�m As String, ByVal h�tt�rk�p As String)
fvbe ("fejl�c")
    With hf
        .WriteLine "<!DOCTYPE html>"
        .WriteLine "<html>"
        .WriteLine "<head>"
        .WriteLine "<meta charset=""utf-8"">"
        .WriteLine "<title>" & oldalc�m & "</title>"
        
        .WriteLine "<link rel=""icon"" href=""./css/MinervaHR_logo6.png"">"
        .WriteLine "<link rel=""stylesheet"" href=""./css/hrell.css"">"
        .WriteLine "<link rel=""stylesheet"" href=""./css/pagenumber.css"">"
        .WriteLine "<script src=""./js/hrell.js""></script>"
        .WriteLine "<script src=""https://kvotariport.kh.gov.hu/static/quotarep/js/chart.bundle.min.js""></script>"
        .WriteLine "</head>"
        .WriteLine "<body style='" & h�tt�rk�p & "'>"
        .WriteLine "<div id=""fejlec"">   <a href=""file:///L:/Ugyintezok/Adatszolg%C3%A1ltat%C3%B3k/HRELL/Ind%C3%ADt%C3%B3pult.html"" ><button id=""inditopultButton"">Ind�t�pult</button> </a>" & _
                    "   <div id=""browser-warning"">Ennek az oldalnak a haszn�lat�hoz a Firefox b�ng�sz�t aj�nljuk!</br>M�s b�ng�sz�k a visszajelz�seket nem, vagy csak hi�nyosan k�ldik el." & _
                    "       <button class=""close-btn"" onclick=""closeWarning()"">�</button>" & _
                    "   </div>" & _
                    "</div>"
        .WriteLine "<div class=""fokeret"">" 'f�keret
        .WriteLine "<div id=""gordulooldalpanel"">"
    End With
fvki
End Sub
Function F�jlMegnyit�sa(ByVal filePath As String) As Object
fvbe ("F�jlMegnyit�sa")
    Dim f�jl As New UTF8FileWriter
    
    'Dim fileSystem As Object
    'Set fileSystem = CreateObject("Scripting.FileSystemObject")
    f�jl.Init (filePath)
    Set F�jlMegnyit�sa = f�jl
fvki
End Function
'###KEZDET:fejl�c###
Sub subHTMLKimenet(o�rl As Object, oldal As Integer)
 fvbe ("subHTMLKimenet")
    'On Error GoTo Err_Export
    'Const teszt As Boolean
    
    teszt = o�rl.Pr�ba.Value 'Ha ez True, akkor teszt �zemm�dban fut (nem futtatja a lek�rdez�seket)
        If teszt Then _
            logba , "Tesztfuttat�s indul, �res t�bl�k k�sz�lnek!!!", 1
    '# Adatb�zishoz k�t�d� v�ltoz�k

    Dim db As DAO.Database
    Dim qdf As DAO.QueryDef
    Dim lkEll As DAO.Recordset ' A soron k�vetkez� ellen�rz� lek�rdez�s
    Dim queryName As String
    Dim sqlA, sqlB As String
    Dim qWhere As String
    
    Dim intSorokSz�ma As Integer 'a rekordok sz�ma
    Dim intOszlopokSz�ma As Integer 'az mez�k sz�ma
    Dim rowIndex As Integer ' Track the current row index
    Dim columnIndex As Integer ' Track the current column index
    
    '# F�jlkezel�ssel kapcsolatos v�ltoz�k
    Dim hfN�v As String, _
        mappa As String
    Dim f�jlobj As Object
    Dim hf As Object 'A f�jl, amibe dolgozunk
    Dim mfn�v As String 'A f�jl m�solat neve
    
    '#A visszajelz�sek kezel�s�hez kapcsol�d� v�ltoz�k
    Dim lekVisszJelT�pus As QueryDef
    Dim VisszJelT�pusok As Recordset
    Dim VisszT�pCsop As Long
    
    '# A HTML oldal v�ltoz�i
    Dim F�c�m As String, _
        h�tt�rk�p As String, _
        h�tt�rsz�n As String, _
        oldalc�m As String, _
        fejezetC�m As String, _
        fejezetmegj As String, _
        T�blac�m As String, _
        megj As String, _
        CheckBox As String, _
        form�zott As String
    Dim el�z�FejezetC�m As String
    Dim str�resT�bla As String 'ClassName az �res t�bl�k eset�n
    Dim FejezetV�lt As Boolean
    Dim T�blaSz�m As Integer '->> "<table id=""table" & T�blaSz�m...
    Dim most As Date 'tR�giHib�k t�bl�ba ker�l� id�pont
    
    'Sz�ml�l�shoz - folyamatjelz�
    Dim sor, oszlop     As Integer
    Dim ehj             As New ehjoszt
    Dim el�z�szakasz    As Integer
    Dim SzakaszSz�m     As Integer


    h�tt�rk�p = AlapadatLek("HTML", "h�tt�rk�p")
    If vane(h�tt�rk�p) Then
        h�tt�rk�p = "background-image: url(""" & h�tt�rk�p & """);background-repeat: repeat-y;background-size: 100% auto;"
    Else
        h�tt�rk�p = ""
    End If

    F�c�m = AlapadatLek("HTML", "f�c�m")
    Dim blKellVisszajelzes As Boolean
    
    Dim gr�ft�pus As Variant, _
        meztip As Variant
    'Dim v�lasz As Integer
    Dim vaneGraf As String, _
        strHash As String, _
        strDropdown As String ', _
'        grIkon As String
'    grIkon = "&#x1F4CA;" ' A grafikont jelz� ikon �thelyezve: OldalPanel()
    
    
    Dim maxsor As Integer 'Ha a t�bla enn�l t�bb sorb�l �ll, akkor a t�bl�t egy�ltal�n nem �rjuk ki.
    maxsor = 1100 'TODO: Az ellen�rz� lek�rdez�sek t�bl�ba felvenni, hogy az adott lek�rdez�s eset�n mi legyen a maxsor. De maradhatna itt alap�rtelmez�s...
    
    qWhere = oldal 'o�rl.Oszt�ly
    hfN�v = DLookup("F�jln�v", "tLek�rdez�sOszt�lyok", "[azOszt�ly]=" & oldal)
   
    oldalc�m = DLookup("Oldalc�m", "tLek�rdez�sOszt�lyok", "[azOszt�ly]=" & oldal)
    VisszT�pCsop = Nz(DLookup("azVisszaJelz�sT�pusCsoport", "tLek�rdez�sOszt�lyok", "[Oldalc�m]=""" & oldalc�m & """"), 0)
    o�rl.Refresh
    oldalc�m = oldalc�m & " (" & o�rl.HaviHat�lya & ")" 'Date & ")" 'Az oldalc�m a d�tummal egy�tt az igazi, ami pedig a havi jelent�s hat�lya


    If teszt Then
        mappa = �tvonalK�sz�t�(AlapadatLek("HTML", "pr�ba�tvonal"), "")
    Else
        mappa = �tvonalK�sz�t�(AlapadatLek("HTML", "kimenet"), "")
    End If
    '### Az adatb�zis megnyit�sa
    Set db = CurrentDb()
    '### A visszajelz�sek kezel�s�hez sz�ks�ges adatok beszerz�se

        Set lekVisszJelT�pus = db.CreateQueryDef("", "SELECT tVisszajelz�sT�pusok.[Visszajelz�sK�d], tVisszajelz�sT�pusok.[Visszajelz�sSz�vege] " & _
                                        " From [tVisszajelz�sT�pusok]" & _
                                        " Where [VisszaJelz�sT�pusCsoport] = " & VisszT�pCsop & _
                                        " ORDER BY tVisszajelz�sT�pusok.[Visszajelz�sK�d] DESC;")
        Set VisszJelT�pusok = lekVisszJelT�pus.OpenRecordset(dbOpenSnapshot)
    '### A lefuttatand� lek�rdez�sek tulajdons�gainak beszerz�se -----------
    Set qdf = db.QueryDefs("parlkEllen�rz�Lek�rdez�sek")
    qdf.Parameters("qWhere") = qWhere
    Set lkEll = qdf.OpenRecordset
    If lkEll.EOF Then
        sFoly o�rl, "A v�lasztott gy�jtem�nyben:;nincsenek lek�rdez�sek!", , 0
        sFoly o�rl, "Ez�rt a fut�s:;v�get �rt...", , 0
        fvki
        Exit Sub
    End If
    '### A f�jln�v meghat�roz�sa -------------------------------------------
   
    hfN�v2 = mappa & "html\" & hfN�v & "_" & Format(Now(), "yyyy-mm-dd-hh-nn-ss") & ".html"
    mfn�v = mappa & hfN�v & ".html"  ' A m�solat ezen a n�ven k�sz�l majd
    
    '#######################################################################
    '### A html f�jl megnyit�sa --------------------------------------------
    '#######################################################################
    Set hf = F�jlMegnyit�sa(hfN�v2)
    most = Now
    
    '### A html fejr�sz meg�r�sa -------------------------------------------
    fejl�c hf, oldalc�m, h�tt�rk�p

    '#############################
    '### Oldalpanel fel�p�t�se ###
    '#############################
    'lkell.MoveLast
    lkEll.MoveFirst
    T�blaSz�m = 0
    OldalPanel hf, lkEll, F�c�m, oldalc�m

    T�blac�m = ""
    megj = ""
    vaneGraf = ""
    '##############################################
    '### A lek�rdez�senk�nti t�bl�k fel�p�t�se ####
    '##############################################
lkEll.MoveLast
lkEll.MoveFirst
ehj.Ini 100
ehj.oszlopszam = lkEll.RecordCount

T�blaSz�m = 0

fejezetC�m = ""
'el�z�FejezetC�m = ""
hf.WriteLine "<form id=""urlap"" >"
hf.WriteLine "<button id=""visszajelzesGomb"" class=""elkuldgomb"" type=""submit"">Visszajelz�s...</button>"
Do Until lkEll.EOF 'K�ls� loop kezdete: v�gigj�rjuk a t�bl�kat ###
        T�blaSz�m = T�blaSz�m + 1
        queryName = lkEll("Ellen�rz�Lek�rdez�s")
        blKellVisszajelzes = lkEll("KellVisszajelzes")

'TODO:        If Not param�terLek(queryName) Then

        T�blac�m = lkEll("T�blac�m")
              hf.WriteLine "<div class=""tablediv "">"
        '## A Fejezetc�m ki�rat�sa, ha v�ltozott
        If fejezetC�m <> lkEll("LapN�v") Then
            fejezetC�m = lkEll("LapN�v")
            fejezetmegj = Nz(lkEll("Megjegyz�s"), "")
            hf.WriteLine "    <h2 id=""" & Replace(fejezetC�m, " ", "") & """ class=""fejezetcim"" title=""" & fejezetmegj & """ >" & fejezetC�m & "</h2>"
        End If
        megj = Nz(lkEll("T�blaMegjegyz�s"), "")
        vaneGraf = lkEll("vaneGraf")
        
        sFoly o�rl, n�vel�vel(T�blac�m, , , True) & ":; �ssze�ll�t�sa indul..."
        sqlA = "SELECT * FROM [" & queryName & "]" & _
                    IIf(teszt, "WHERE false", "") ' Ha teszt �zemm�dban vagyunk, �res t�bl�kat k�sz�t�nk
'TODO:
        'A mezTip t�mbben elt�roljuk a mez�neveket �s a hozz�juk tartoz� kimeneti t�pust (hogy mire kell form�zni)
        meztip = vFldT�pus("SELECT [Mez�Neve],[Mez�T�pusa],[Grafikonra], [Hashbe] FROM tLek�rdez�sMez�T�pusok WHERE [Lek�rdez�sNeve]='" & queryName & "';")
        'Debug.Print queryName & " : "; LBound(mezTip) & vbTab & UBound(mezTip)
        
        ' A lek�rdez�s futtat�sa
        Dim rs As DAO.Recordset
        Set rs = db.OpenRecordset(sqlA)
        
        '## A hib�k feljegyz�se a t�bl�ba
        If blKellVisszajelzes Then
            
            R�giHib�kT�bl�ba rs, queryName, VisszT�pCsop, meztip, most
            tHib�kba rs, queryName, Nz(lkEll("azHibaCsoport"), 1), meztip, most
        End If
        
            DoEvents
            If �llj Then Exit Sub
        '## Sorok sz�m�nak a ki�rat�sa
        If Not (rs.EOF And rs.BOF) Then
            rs.MoveLast
            rs.MoveFirst
        End If
        intSorokSz�ma = rs.RecordCount
        If intSorokSz�ma = 0 Then
            str�resT�bla = "uresTabla"
        Else
            str�resT�bla = ""
        End If

        sFoly o�rl, n�vel�vel(T�blac�m, , , True) & ":;" & intSorokSz�ma & " sor"

        ' Index kezd��rt�kei
        rowIndex = 1
        columnIndex = 1
        intOszlopokSz�ma = rs.Fields.count
        ' A t�bl�t mag�ba foglal� keretnek �s a t�bla fejl�c�nek a ki�r�sa ###
        
        With hf
            If vaneGraf <> vbNullString Then
                .WriteLine "<table id=""table" & T�blaSz�m & """ charttype=""" & vaneGraf & """ class=""collapsible-table " & str�resT�bla & " "">"
            Else
                .WriteLine "<table id=""table" & T�blaSz�m & """ class=""collapsible-table " & str�resT�bla & " "">"
            End If
            .WriteLine "<thead class=""collapsible-header tablehead " & str�resT�bla & " ""> "
            '## A t�bla fejl�ce .........................................................
            .WriteLine "<tr>"
            letoltoHTML = "<button class=""export-button"" type=""button"" onclick=""exportTableToCSV('table" & T�blaSz�m & "', '" & T�blac�m & ".csv')"">Let�lt�s...</button>"
            Dim t�blatitle As String
            t�blatitle = " title=""" & megj & """ "
            Select Case intOszlopokSz�ma
                Case 1
                    'Ha a t�bla egy oszlopos, akkor a keres� a k�vetkez� sorba ker�l.
                    .WriteLine "<th class=""" & str�resT�bla & """" & t�blatitle & ">" & T�blac�m & " </th>"  '
                    .WriteLine "</tr><tr>"
                    'A t�bla is kap egy sorsz�mot
                    .WriteLine "<th " & intOszlopokSz�ma & ">" & letoltoHTML & " <input type=""text"" id=""filterInputtable" & T�blaSz�m & """ placeholder=""Keresend� sz�veg""></th>"
                Case 2
                    'Ha a t�bla 2 oszlopos, akkor az egyik oszlop a c�m�, a m�sik a keres��.
                    .WriteLine "<th class=""" & str�resT�bla & """" & t�blatitle & ">" & T�blac�m & " </th>"
                    'A t�bla is kap egy sorsz�mot
                    .WriteLine "<th >" & letoltoHTML & "<input type=""text"" id=""filterInputtable" & T�blaSz�m & """ placeholder=""Keresend� sz�veg""></th>"
                Case Else
                    'Ha a t�bla t�bb oszlopos, akkor az utols� k�t oszlopot fenntartjuk a keres�nek.
                    .WriteLine "<th colspan=""" & intOszlopokSz�ma - 2 & """ class = """ & str�resT�bla & """" & t�blatitle & ">" & T�blac�m & " </th>"
                    'A t�bla is kap egy sorsz�mot
                    .WriteLine "<th colspan="" 2"">" & letoltoHTML & " <input type=""text"" id=""filterInputtable" & T�blaSz�m & """ placeholder=""Keresend� sz�veg""></th>"
            End Select
            .WriteLine "</tr>"
            '## A t�bla fejl�c�nek els� sora v�get �rt.
        
            '## A t�bla felj�c�nek m�sodik vagy harmadik sora k�sz�l -- az oszlopnevekkel
            .WriteLine "<tr class=""collapsible-header elsosor " & str�resT�bla & " "">"
        End With
        For Each fld In rs.Fields 'A t�bla sorait vessz�k egyenk�nt ###
            
            ' A fejl�c p�ros �s p�ratlan oszlopainak megjel�l�se
            Dim headerClassName As String
            If columnIndex Mod 2 = 0 Then
                headerClassName = "po" ' Even column
            Else
                headerClassName = "ptlo" ' Odd column
            End If
            If str�resT�bla <> "" Then
                headerClassName = str�resT�bla
            End If
            ' A jel�l�n�gyzet �ssze�ll�t�sa
            CheckBox = ""
            If vaneGraf <> vbNullString Then
                gr�ft�pus = p�rkeres�(meztip, fld.Name, cGrafikonra)
                If IsNull(gr�ft�pus) Then
                CheckBox = ""
                Else
                CheckBox = "<input type=""checkbox"" class=""columnCheckbox"" data-table=""" & T�blaSz�m & """ data-column="" " & columnIndex & " "" " & gr�ft�pus & ">" 'p�rkeres�(mezTip, fld.Name, 3)
                End If
            End If
            ' CSS oszt�ly n�v a fentiek szerint
            hf.WriteLine "<th class='" & headerClassName & "'>" & fld.Name & CheckBox & "</th>"
            
            ' Oszlopsz�m n�vel�se
            columnIndex = columnIndex + 1
        Next fld
                If blKellVisszajelzes Then
                    hf.WriteLine "<td class=""rejtettOszlop"">&nbsp;</td>"
                    hf.WriteLine "<td class=""valaszOszlop"">Visszajelz�s</td>"
                End If
                hf.WriteLine "</tr>"
                    '## Elk�sz�lt a fejl�c m�sodik sora
                hf.WriteLine "</thead>"
                    '## Lez�rva a fejl�c ................................................
                    
                    '## Kezd�dik a t�blatest ............................................
                hf.WriteLine "<tbody>"
                ' Loop through the recordset and write rows and columns
                If intSorokSz�ma = 0 Then
                    hf.WriteLine "<tr class=""collapsible-content  " & str�resT�bla & """ >"
                    hf.WriteLine "<td colspan=""" & intOszlopokSz�ma & """> Ez a t�bla nem tartalmaz adatot. </td>"
                    hf.WriteLine "</tr>"
                End If
                
                If intSorokSz�ma > maxsor Then
                    sFoly o�rl, n�vel�vel(T�blac�m, , , True) & ":; A sorok sz�ma t�bb, mint " & maxsor & ", ez�rt �tugorjuk."
                    hf.WriteLine "<tr class=""collapsible-content  " & str�resT�bla & """ >"
                    hf.WriteLine "<td colspan=""" & intOszlopokSz�ma & """> Ez a t�bla t�bb, mint " & maxsor & " sort tartalmazna, ez�rt ink�bb egyet sem... </td>"
                    hf.WriteLine "</tr>"
                    GoTo Toval�p
                End If
        
        If rs.RecordCount Then rs.MoveFirst
        Do Until rs.EOF 'Bels�, sor szint� loop
            hf.WriteLine "<tr class=""collapsible-content "">"


            '#####################################################
            '## A t�blatest sor�nak �ssze�ll�t�sa
            '#####################################################
            columnIndex = 1
            
            For Each fld In rs.Fields
                ' St�lus oszt�lyok meghat�roz�sa oszlop �s sor alapj�n
                Dim className As String
                
                If rowIndex Mod 2 = 0 Then
                    If columnIndex Mod 2 = 0 Then
                        className = "ps" ' P�ros sor (+ p�ratlan oszlop is)
                    Else
                        className = "ptls" ' P�ros sor (+ p�ratlan oszlop)
                    End If
                Else
                    If columnIndex Mod 2 = 0 Then
                        className = "po" '
                    Else
                        className = "ptlo" '
                    End If
                End If
                If str�resT�bla <> "" Then
                    className = str�resT�bla
                End If
                ' T�blamez� a st�lus oszt�ly nev�vel
                If columnIndex = 1 Then
                    className = "elsooszlop " & className
                End If
                If columnIndex = rs.Fields.count Then
                    className = "utolsooszlop " & className
                End If

                    form�zott = formazo(p�rkeres�(meztip, fld.Name, cMez�T�pusa), fld.Value, className)

                hf.WriteLine form�zott '#**
                ' Debug.Print
                � columnIndex '= columnIndex + 1
            Next fld
            If blKellVisszajelzes Then 'Ha kell visszajelz�s,
                If VisszT�pCsop <> 0 Then
                    
                    Select Case VisszT�pCsop
                        Case 1 'Hibacsoport
                            strHash = TextToMD5Hex(egyes�tettMez�k(rs, rs.Bookmark, meztip)) ' & queryName) 'Nem kell a queryName el�tt elv�laszt�, mert az �sszef�z�s v�g�n marad egy :) !
                            hf.WriteLine "<td class=""rejtettOszlop""  > " & Nz(DLookup("azIntfajta", "lkR�giHib�kUtols�Int�zked�s", "[HASH]='" & strHash & "'"), "0") & "</td>"
                            strDropdown = "<select name=""" & strHash & """>" & vbNewLine
                            strDropdown = strDropdown & "<option value=""0"" selected>-</option>" & vbNewLine
                            Do Until VisszJelT�pusok.EOF
                                strDropdown = strDropdown & "<option value=""" & VisszJelT�pusok![Visszajelz�sK�d] & """ >" & VisszJelT�pusok![Visszajelz�sSz�vege] & "</option>" & vbNewLine
                                VisszJelT�pusok.MoveNext
                            Loop
                            VisszJelT�pusok.MoveFirst
                            strDropdown = strDropdown & "</select>" & vbNewLine
                        Case 2 '�res �ll�shely
                            strHash = TextToMD5Hex(rs![�ll�shely azonos�t�])
                            
                            'Leg�rd�l� men�
                            strDropdown = "<div class=""tooltip"" >" & vbNewLine
                            strDropdown = strDropdown & "<select name=""" & strHash & """>" & vbNewLine
                            strDropdown = strDropdown & "<option value=""0"" selected>-</option>" & vbNewLine
                            Do Until VisszJelT�pusok.EOF
                                strDropdown = strDropdown & "<option value=""" & VisszJelT�pusok![Visszajelz�sK�d] & """ >" & VisszJelT�pusok![Visszajelz�sSz�vege] & "</option>" & vbNewLine
                                VisszJelT�pusok.MoveNext
                            Loop
                            VisszJelT�pusok.MoveFirst
                            strDropdown = strDropdown & "</select>" & vbNewLine
                            strDropdown = strDropdown & "   <div class=""left"">" & vbNewLine & _
                                                        "       <h3>A visszajelz�sek t�rt�nete</h3>" & vbNewLine & _
                                                                sBubor�k(strHash, db) & vbNewLine & _
                                                        "           <i></i>" & vbNewLine & _
                                                        "    </div>" & vbNewLine & _
                                                        "</div>"
                            'D�tum v�laszt�
                            
                            strDropdown = strDropdown & "<div class=""tooltip valaszDatum""  > <input type=""date""  class=""valaszDatumInput"" ></div>" 'name=""" & strHash & """
                    End Select
                End If
                
                hf.WriteLine "<td class=""valaszOszlop""  > " & strDropdown & "</td>"
            End If
            hf.WriteLine "</tr>"
            
            ' A sorsz�m�l� n�vel�se
            rowIndex = rowIndex + 1
            
            rs.MoveNext
        Loop ' Bels� loop v�ge
Toval�p:
        With hf
            .WriteLine "</table>"
            '.writeline "<script>"
                    '.writeline " handleFilter('table" & T�blaSz�m & "');"
            '.writeline "</script>"
            .WriteLine "<span class=""megjegyzes"">" & megj & "</span>"
            .WriteLine "</div>"
            .WriteLine "<br/>"
        End With
        sFoly o�rl, n�vel�vel(T�blac�m, , , True) & ":; elk�sz�lt."
        ' A rekordk�szlet lez�r�sa
        rs.Close

        ' Ugr�s a k�vetkez� lek�rdez�sre
        lkEll.MoveNext
        ehj.Novel
Loop 'K�ls� loop

tesztpont:
    l�bl�c hf
    ' Close the HTML file
    hf.Cl
    Set f�jlobj = CreateObject("Scripting.FileSystemObject")
    f�jlobj.CopyFile hfN�v2, mfn�v, True 'True = fel�l�rja. Ez az alap�rtelmezett, itt csak az �ttekinthet�s�g �rdek�ben marad.
    
    ' Open the HTML file in the default web browser
    Shell "explorer.exe " & mfn�v, vbNormalFocus
    
    If Not teszt And Not o�rl.Mindet Then
        Call GenMailto(mfn�v, oldalc�m)
        sFoly o�rl, "E-mail �zenet:;�ssze�ll�tva. F�jln�v:" & mfn�v, True, 2
    End If
    
    CloseHibaT�bla
    fvki
    Exit Sub
    
Err_Export:
    MsgBox "Error: " & Err.Description, vbExclamation, "Error"
    logba , "Error: " & Err.Description & "," & vbExclamation & "," & "Error", 0
    fvki
End Sub
Function Visszajelz�sT�pusLista(db As Database, oldalc�m As String)
    Dim lekVisszJelT�pus As QueryDef
    Dim VisszJelT�pusok As Recordset
    Dim ViszT�pCsop As Long
    
    Dim Kimenet As String
    
    VisszT�pCsop = Nz(DLookup("azVisszaJelz�sT�pusCsoport", "tLek�rdez�sOszt�lyok", "[Oldalc�m]=""" & oldalc�m & """"), 0)
    If VisszT�pCsop = 0 Then Exit Function 'Az "If hibae Then" helyett
    
        Set lekVisszJelT�pus = db.CreateQueryDef("", "SELECT tVisszajelz�sT�pusok.[Visszajelz�sK�d], tVisszajelz�sT�pusok.[Visszajelz�sSz�vege] " & _
                                        " From [tVisszajelz�sT�pusok]" & _
                                        " Where [VisszaJelz�sT�pusCsoport] = " & VisszT�pCsop & _
                                        " ORDER BY tVisszajelz�sT�pusok.[Visszajelz�sK�d];")
        Set VisszJelT�pusok = lekVisszJelT�pus.OpenRecordset(dbOpenSnapshot)
                    'Ezzel mi legyen???
                    '                strHash = TextToMD5Hex(egyes�tettMez�k(rs, rs.Bookmark))
                    '                hf.writeline "<td class=""rejtettOszlop""  > " & Nz(DLookup("azIntfajta", "lkR�giHib�kUtols�Int�zked�s", "[HASH]='" & strHash & "'"), "0") & "</td>"
                    '                strDropdown = "<select name=""" & strHash & """>"
        Kimenet = "<option value=""0"" selected>-</option>" & vbNewLine
        Do Until VisszJelT�pusok.EOF
            Kimenet = Kimenet & "<option value=""" & VisszJelT�pusok![Visszajelz�sK�d] & """ >" & VisszJelT�pusok![Visszajelz�sSz�vege] & "</option>" & vbNewLine
            VisszJelT�pusok.MoveNext
        Loop
                    '                hf.writeline "<td class=""valaszOszlop""  > " & strDropdown & "</td>"
    
    Visszajelz�sT�pusLista = Kimenet
End Function
Sub l�bl�c(ByRef hf As Object)
    With hf
        .WriteLine "</form>"
        .WriteLine "<button id=""tetejereGomb"">Vissza a tetej�re</button>"
        .WriteLine "<script src=""./js/hrellv�g.js""></script>"
        .WriteLine "</div>" 'f�tartalom
        .WriteLine "</div>" 'f�keret
        .WriteLine "</body>"
        .WriteLine "</html>"
    End With
End Sub

Sub GenMailto(ByVal f�jln�v As String, ByVal oldalc�m As String, Optional teszt As Boolean = False)
fvbe ("GenMailto")
'# Megh�vja ezt: fvReferenseknekLev�l(f�jln�v, oldalc�m,  teszt )
'#
'# K�sz�t egy HTML �llom�nyt (sz�veges f�jlt),
'# amiben a javascript az oldal bet�lt�s�re indul,
'# s miut�n megnyitja a HTML hivatkoz�st, v�r egy picit, majd bez�rja a b�ng�sz� ablakot.
'# Az utols� sorban megynitjuk ezt a HTML f�jlt az alap�rtelmezett b�ng�sz�ben, s ezzel elindul a fenti folyamat.

    'Hova tegy�k az �llom�nyt
    Dim filePath As String
    filePath = "\\Teve1-jkf-hrf2-oes\vol1\Human\HRF\Ugyintezok\Adatszolg�ltat�k\HRELL\levelek\" & oldalc�m & Format(Now(), "yyyy-mm-dd-hh-nn-ss") & ".html"
    
    'A HTML �llom�ny megkezd�se
    Dim fileNumber As Integer
    fileNumber = FreeFile
    Open filePath For Output As fileNumber
    
    'A HTML tartalom
    Print #fileNumber, "<html>"
    Print #fileNumber, "<head><title>" & oldalc�m & "</title>"
    Print #fileNumber, "<script type='text/javascript'>"
    Print #fileNumber, "function onLoad() {"
    Print #fileNumber, "  document.getElementById('mailtoLink').click();"
    Print #fileNumber, "  setTimeout(function() { window.close(); }, 2000);"
    Print #fileNumber, "}"
    Print #fileNumber, "</script>"
    Print #fileNumber, "</head>"
    Print #fileNumber, "<body onload='onLoad()'>"
    Print #fileNumber, "<a id='mailtoLink' href='" & fvReferenseknekLev�l(f�jln�v, oldalc�m, teszt) & "'>Kattints ide az e-mailhez...</a>"
    Print #fileNumber, "</body>"
    Print #fileNumber, "</html>"
    
    'Close the file
    Close fileNumber
    
    Shell "explorer.exe " & filePath, vbNormalFocus
fvki
End Sub
Function fvReferenseknekLev�l(ByVal f�jln�v As String, ByVal oldalc�m As String, Optional teszt As Boolean = False) As String
fvbe ("fvReferenseknekLev�l")
    Const nLN As String = "%0d%0a"
    Dim tart As String
    Dim c�mTO As String
    Dim c�mCC As String
    Dim a As Boolean
    
    tart = tart & "Kedves Koll�g�k!" & nLN & nLN
    tart = tart & "Az al�bbi helyen tal�lj�tok a leg�jabb adatok alapj�n elk�sz�tett " & oldalc�m & " t�bl�kat:" & nLN & nLN
    tart = tart & "file://" & f�jln�v '& "%22"
    c�mTO = fvRefLevC�m(1)
        If teszt Then c�mTO = "example@example.com"
    c�mCC = fvRefLevC�m(2)
        If teszt Then c�mCC = "cc@example.com"
    'logba sFN & "E-mail c�mek:", c�mTO, 2
    logba sFN & "CC:", c�mCC, 2
    logba sFN & "oldalc�m:", oldalc�m, 2
    
    fvReferenseknekLev�l = "mailto:" & c�mTO & _
                            "?cc=" & c�mCC & _
                            "&subject=" & oldalc�m & _
                            "&body=" & tart
fvki
End Function
Function fvRefLevC�m(T�pus As Integer) As String
'Lek�rdezz�k az lkReferensek lek�rdez�sb�l
fvbe ("fvRefLevC�m")
Dim db As DAO.Database
Dim rs As Recordset
Dim c�m As String
Dim reksz As Integer

Select Case T�pus
    Case 1 'TO:
        felt�tel = " VanTer�lete = True and TT = False and Vezet�=false"
    Case 2 'CC:
        felt�tel = " TT = False and Vezet�=true"
    Case 3 'BCC:
        fvRefLevC�m = vbNullString
End Select

    Set db = CurrentDb
    logba sFN & "; lkReferensek", "Lek�rdez�s indul", 3
    Set rs = db.OpenRecordset("Select [Hivatali email] From lkReferensek WHERE " & felt�tel & ";")
    logba sFN & "; lkReferensek", "Lek�rdez�s lefutott", 3
    rs.MoveFirst
    reksz = 1
    Do Until rs.EOF
        If rs("Hivatali email") <> "" Then
            If reksz = 1 Then
                c�m = c�m & rs("Hivatali email")
                        logba , c�m, 4
            Else
                c�m = c�m & ";" & rs("Hivatali email")
                        logba , c�m, 4
            End If
        End If
        reksz = reksz + 1
        rs.MoveNext
    Loop
    If T�pus = 2 Then c�m = c�m & ";branyi.balazs@bfkh.gov.hu;olah.zoltan3@bfkh.gov.hu"
    reksz = reksz + 2
    logba sFN & "; Referensek sz�ma:", CStr(reksz), 3
    fvRefLevC�m = c�m
fvki
End Function

Function formazo(mez�T�pus As Integer, �rt�k As Variant, Optional className As String = "") As String
fvbe ("formazo")
    Dim hibakeres As Boolean
    
    Select Case mez�T�pus
        Case dbCurrency
        '5
            form�z = Format(�rt�k, "# ### ### ##0\ \F\t")
            className = className & " jobbrazart "
        Case dbLong
        '4
            form�z = Format(�rt�k, "# ### ### ##0\ ")
            className = className & " jobbrazart "
        Case dbInteger
        '3
            form�z = Format(�rt�k, "0\ ")
            className = className & " jobbrazart "
        Case dbDouble
        '7
            form�z = Format(�rt�k, "# ### ### ##0.00")
            className = className & " jobbrazart "
        Case dbText
        '10
            form�z = Format(�rt�k, "\ @")
            className = className & " balrazart "
        Case Else
            form�z = Nz(�rt�k, "") 'form�zatlan
            className = className & " balrazart " '
            hibakeres = True
    End Select
    formazo = "<td class='" & className & "'>" & form�z & "</td>"
    'If hibakeres Then: Debug.Print formazo
fvki
End Function
Public Sub InitHibaT�bla()
'On Error GoTo Hiba:
    If jelenDb Is Nothing Then _
        Set jelenDb = CurrentDb
        
    If hibat�bla Is Nothing Then _
        Set hibat�bla = jelenDb.OpenRecordset("tR�giHib�k", dbOpenDynaset)
    If �jhibat�bla Is Nothing Then _
        Set �jhibat�bla = jelenDb.OpenRecordset("tHib�k", dbOpenDynaset)
    If futtat�shibat�bla Is Nothing Then _
        Set futtat�shibat�bla = jelenDb.OpenRecordset("tFuttat�sokHib�k", dbOpenDynaset)
    If futtat�sokt�bla Is Nothing Then _
        Set futtat�sokt�bla = jelenDb.OpenRecordset("tLek�rdez�sFuttat�sok", dbOpenDynaset)

    Exit Sub
Hiba:
'MsgBox Err.Number, Err.Description
End Sub

Private Sub CloseHibaT�bla()
    If Not hibat�bla Is Nothing Then _
        Set hibat�bla = Nothing
    If Not �jhibat�bla Is Nothing Then _
        Set �jhibat�bla = Nothing
    If Not futtat�shibat�bla Is Nothing Then _
        Set futtat�shibat�bla = Nothing
    If Not futtat�sokt�bla Is Nothing Then _
        Set futtat�sokt�bla = Nothing
        
    If Not jelenDb Is Nothing Then _
        Set jelenDb = Nothing
        
End Sub
Private Function R�giHib�kT�bl�ba(HtmlKimenetRs As Recordset, lekn�v As String, VisszT�pCsop As Long, meztip As Variant, most As Date) As Long
fvbe ("R�giHib�kT�bl�ba")
    Dim vissza
    On Error GoTo ErrorHandler
    
    InitHibaT�bla

    Do While Not HtmlKimenetRs.EOF
        Dim unitedField As String
        Dim hashedText As String
        Dim recordExists As Boolean
        Dim LCounter As Integer
        Dim k�nyvjelz� As Variant
        

        k�nyvjelz� = HtmlKimenetRs.Bookmark
        unitedField = egyes�tettMez�k(HtmlKimenetRs, k�nyvjelz�, meztip)
        hashedText = TextToMD5Hex(unitedField)
        HtmlKimenetRs.Bookmark = k�nyvjelz�
        If Nz(unitedField, "") <> "" Then
        With hibat�bla
            .AddNew
            ![Els� mez�] = hashedText
            ![M�sodik mez�] = unitedField
            ![Els� Id�pont] = most
            ![Utols� Id�pont] = most
            ![Lek�rdez�sNeve] = lekn�v
            .Update
        End With
        End If
        HtmlKimenetRs.MoveNext
    Loop

    R�giHib�kT�bl�ba = vissza
fvki
Exit Function


ErrorHandler:

    If Err.Number = 3022 Then
        With hibat�bla
            .CancelUpdate
            .FindFirst "[Els� Mez�] like '" & hashedText & "'"
            .Edit
            ![Utols� Id�pont] = most
            ![Lek�rdez�sNeve] = lekn�v
            .Update
        End With
    Else
        v�lt1.n�v = "Hash:"
        v�lt1.�rt�k = hashedText
        v�lt2.n�v = "unitedField"
        v�lt2.�rt�k = unitedField
        MsgBox Hiba(Err) 'Err.Number & vbNewLine & Err.Description & vbNewLine & "Hash:" & hashedText & vbNewLine & "UnitedField:" & unitedField
    End If
Resume Next
End Function
Private Function tHib�kba(HtmlKimenetRs As Recordset, lekn�v As String, hibacsoport As Long, meztip As Variant, most As Date) As Long
fvbe ("tHib�kba")
    Dim vissza
    Dim azFuttat�s As Long
    On Error GoTo ErrorHandler
    
    InitHibaT�bla
        ' a tlek�rdez�sekFuttat�sok t�bl�ba feljegyezz�k, hogy az adott futtat�s megt�rt�nt. Megszerezz�k az "azFuttat�st", ami az eg�sz lek�rdez�sre vonatkozik.
        With futtat�sokt�bla
            .AddNew
            ![id�pont] = most
            ![Lek�rdez�sNeve] = lekn�v
            .Update
        End With
        azFuttat�s = CurrentDb.OpenRecordset("SELECT @@Identity")(0)
        
    If Not HtmlKimenetRs.BOF Then HtmlKimenetRs.MoveFirst
    
    Do While Not HtmlKimenetRs.EOF
        Dim unitedField As String
        Dim hashedText As String
        Dim recordExists As Boolean
        Dim LCounter As Integer
        Dim k�nyvjelz� As Variant
        
        k�nyvjelz� = HtmlKimenetRs.Bookmark
        unitedField = egyes�tettMez�k(HtmlKimenetRs, k�nyvjelz�, meztip)
        hashedText = TextToMD5Hex(unitedField)
        HtmlKimenetRs.Bookmark = k�nyvjelz�
        If Nz(unitedField, "") <> "" Then 'TODO ha �res a lek�rdez�s - 0 hiba van - hib�ra fut
            If DCount("hash", "thib�k", "[HASH] = '" & hashedText & "'") = 0 Then
                With �jhibat�bla
                    .AddNew
                    ![HASH] = hashedText
                    ![hibacsoport] = hibacsoport
                    ![hibasz�veg] = unitedField
                    .Update
                End With
            End If
            With futtat�shibat�bla
                .AddNew
                ![azFuttat�s] = azFuttat�s
                ![HASH] = hashedText
                .Update
            End With
        End If
        HtmlKimenetRs.MoveNext
    Loop

    tHib�kba = vissza
fvki
Exit Function

ErrorHandler:

    If Err.Number = 3022 Then
        With �jhibat�bla
            'Debug.Print
        End With
    Else
        v�lt1.n�v = "Hash:"
        v�lt1.�rt�k = hashedText
        v�lt2.n�v = "unitedField"
        v�lt2.�rt�k = unitedField
        MsgBox Hiba(Err) 'Err.Number & vbNewLine & Err.Description & vbNewLine & "Hash:" & hashedText & vbNewLine & "UnitedField:" & unitedField
    End If
Resume Next
End Function
Function egyes�tettMez�k(rs As Recordset, poz�ci� As Variant, meztip As Variant) As Variant
'mezTip tartalmazza a boole-i �rt�ket arr�l, hogy a mez�t bele kell-e tenni a Hash-be avagy sem
Dim egyMez As String
        egyMez = ""
        rs.Bookmark = poz�ci�
        For LCounter = 0 To rs.Fields.count - 1
            If p�rkeres�(meztip, rs(LCounter).Name, cHashbe) Then '�j:2024.11.11
                    egyMez = egyMez & Replace(Nz(rs(LCounter).Value, ""), "'", "''") & "|"
            End If '�j:2024.11.11
        Next LCounter
        egyes�tettMez�k = egyMez '!!Ehhez m�g hozz� kell f�zni - a megh�v� elj�r�sban - a lek�rdez�s nev�t!!!
End Function
Function oldalakFejezetek(db As Database) As String
' Az ind�t�pult html k�dj�t hozza l�tre
End Function