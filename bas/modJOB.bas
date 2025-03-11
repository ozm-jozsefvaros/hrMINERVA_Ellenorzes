Option Compare Database
Option Explicit

' Function to read a UTF-8 text file
Function ReadTextFile_UTF8(filePath As String) As String
    Dim stream As Object
    Set stream = CreateObject("ADODB.Stream")
    
    With stream
        .Type = 2 ' adTypeText
        .Charset = "UTF-8"
        .Open
        .LoadFromFile filePath
        ReadTextFile_UTF8 = .ReadText
        .Close
    End With
    
    Set stream = Nothing
End Function

' Function to write a UTF-8 text file
Sub WriteTextFile_UTF8(filePath As String, content As String)
    Dim stream As Object
    Set stream = CreateObject("ADODB.Stream")
    
    With stream
        .Type = 2 ' adTypeText
        .Charset = "UTF-8"
        .Open
        .WriteText content
        .SaveToFile filePath, 2 ' adSaveCreateOverWrite
        .Close
    End With
    
    Set stream = Nothing
End Sub
Sub GenerateFõosztályHTML_UTF8_II()
fvbe ("GenerateFõosztályHTML_UTF8_II")
    Dim db As DAO.Database
    Dim rsJson As DAO.Recordset
    Dim rstMMK As DAO.Recordset 'tMunkakörökMellékletbeKerültek
    Dim mellékletek As DAO.Recordset
    Dim JsonTömb As Variant
    
    Dim dict As Object ' Dictionary a Fõosztályok és JSON adatok tárolására
    
    Dim strFõosztály As Variant, strJson As String
    Dim strHtmlMinta As String, _
        strHtmlKimenet As String, _
        strKimenetÚtvonal As String, _
        strMintaÚtvonal As String
    
    Dim n As Integer, maxloop As Integer
    Dim mellékletAz As Long
    Dim most As Date
    
    maxloop = 0 ' Legfeljebb ennyi HTML-t generálunk, ha 0, akkor mindet feldolgozzuk
logba , "A HTML állományok készítése indul:"
    ' Adatbázis és rekordkészlet inicializálása
    Set db = CurrentDb
    Set rsJson = db.OpenRecordset("SELECT Fõosztály, json FROM lkMunkakörökFõosztályJSON", dbOpenSnapshot)
    Set rstMMK = db.OpenRecordset("tMunkakörökMellékletbeKerültek", dbOpenDynaset)
logba , "Lekérdezés lefutott:"
    Set dict = CreateObject("Scripting.Dictionary")
    most = Now()
logba , "Fõosztályok és JSON adatok egy lépésben történõ összegyûjtése indul", 2
    Do While Not rsJson.EOF
        strFõosztály = rsJson!Fõosztály
        strJson = rsJson!json
        
        ' Ha a fõosztály még nincs a Dictionary-ben, hozzáadjuk
        If Not dict.Exists(strFõosztály) Then
            dict.Add strFõosztály, strJson
        Else
            ' Ha már létezik, hozzácsatoljuk az új JSON adatokat
            dict(strFõosztály) = dict(strFõosztály) & strJson
        End If
        rsJson.MoveNext
    Loop
    rsJson.Close
    Set rsJson = Nothing
logba , "Fõosztályok és JSON adatok egy lépésben történõ összegyûjtése kész", 2
    ' HTML sablon beolvasása
    strMintaÚtvonal = "L:\Ugyintezok\Adatszolgáltatók\Adatbázisok\Szakterületi\AdatgyûjtõHTML02.html"
    strKimenetÚtvonal = "L:\Ugyintezok\Adatszolgáltatók\Adatbázisok\Szakterületi\Kész\"
    strHtmlMinta = ReadTextFile_UTF8(strMintaÚtvonal)

logba , "HTML fájlok létrehozása indul (most:" & most & ") Timer:" & Timer
    For Each strFõosztály In dict.Keys
        strJson = dict(strFõosztály)

        ' Sablonba helyettesítés
        strHtmlKimenet = Replace(Replace(strHtmlMinta, "÷NevekLista", strJson), "÷Orgname", strFõosztály)
        
        ' Fájl mentése UTF-8 kódolással
        WriteTextFile_UTF8 strKimenetÚtvonal & strFõosztály & CsakSzámJegy(most) & ".html", strHtmlKimenet
        Set mellékletek = db.OpenRecordset("tMunkakörKörlevélMellékletÚtvonalak", dbOpenDynaset)
        With mellékletek
            .AddNew
            .Fields("FõosztályNeve") = strFõosztály
            .Fields("Útvonal") = strKimenetÚtvonal & strFõosztály & CsakSzámJegy(most) & ".html"
            .Fields("Készült") = most
            .Update

        End With
        ' Ha van maxloop beállítva, akkor leállunk, ha elértük
        If maxloop <> 0 Then
            n = n + 1
            If n >= maxloop Then Exit For
        End If
    Next
    
    ' Takarítás
    Set dict = Nothing
    Set db = Nothing
    
logba , "A HTML állományok elkészültek! (most:" & most & ")  Timer:" & Timer


fvki
End Sub

Sub MunkakörKörlevél()
fvbe ("MunkakörKörlevél")
    Dim címzett(0) As String
    Dim melléklet(0) As String
    Dim tárgy As String
    Dim szövegtörzs As String
    Dim mintaszöveg As String
    Dim db As DAO.Database
    Dim rs As DAO.Recordset
    Dim cél As DAO.Recordset
    Dim startTime As Long
    Dim ClientMessageId As String 'Ebben fogjuk visszakapni az üzenet azonosítót
    Dim DeliveredDate As Date
    
    ClientMessageId = ""
    DeliveredDate = Date
    Const késleltetés = 100
    Const strMintaÚtvonal = "L:\Ugyintezok\Adatszolgáltatók\Adatbázisok\Szakterületi\KörlevélMinta.html"
    mintaszöveg = ReadTextFile_UTF8(strMintaÚtvonal)
    
    Set db = CurrentDb
    
    Set rs = db.OpenRecordset("lkMunkakörökKörlevélCímzettek01", dbOpenSnapshot)
    Set rs = db.OpenRecordset("tTesztMunkakörökKörlevélCímzettek01", dbOpenSnapshot)
    'Set cél = db.OpenRecordset("tMunkakörElküldöttLevelek", dbOpenDynaset)
    
    If Not rs.EOF Then
        rs.MoveLast
        rs.MoveFirst

        
        Do Until rs.EOF
            címzett(0) = rs.Fields("Hivatali email")
            melléklet(0) = rs.Fields("Útvonal")
            tárgy = "Az egészségügyi alkalmassági vizsgálat alá esõ foglalkoztatottak névsorának pontosítása (" & rs.Fields("Fõosztály") & ")"
            
            szövegtörzs = Replace(mintaszöveg, "\u247\'f7NevCimMegszolitas", MindenSzóNagyKezdõBetûvel(drelõre(zárojeltelenítõ(rs!név))) & " " & rs!cím & " " & rs!megszólítás)
            
        'Debug.Print címzett(0); melléklet(0); tárgy; vbNewLine & Left(szövegtörzs, 2000)
        
            Call Groupwise_Mail(címzett(), melléklet(), tárgy, szövegtörzs, ClientMessageId, DeliveredDate)
            Debug.Print ClientMessageId, DeliveredDate
            With cél
                .AddNew
                    .Fields("ClientMessageId") = ClientMessageId
                    .Fields("deliveredDate") = DeliveredDate
                    .Fields("Adójel") = rs.Fields("Adójel")
                    .Fields("BFKHKód") = rs.Fields("BFKHFõosztKód")
                    .Fields("username") = felhasználó 'Environ("USERNAME")
                .Update
            End With
            rs.MoveNext
        Loop
        startTime = Timer
        Do While Timer < startTime + (késleltetés / 1000)
            DoEvents
        Loop
    End If
    

    Set rs = Nothing
    Set db = Nothing
fvki
Exit Sub
Hiba:
    MsgBox Hiba(Err)
End Sub