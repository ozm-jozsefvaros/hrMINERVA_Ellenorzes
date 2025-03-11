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
Sub GenerateF�oszt�lyHTML_UTF8_II()
fvbe ("GenerateF�oszt�lyHTML_UTF8_II")
    Dim db As DAO.Database
    Dim rsJson As DAO.Recordset
    Dim rstMMK As DAO.Recordset 'tMunkak�r�kMell�kletbeKer�ltek
    Dim mell�kletek As DAO.Recordset
    Dim JsonT�mb As Variant
    
    Dim dict As Object ' Dictionary a F�oszt�lyok �s JSON adatok t�rol�s�ra
    
    Dim strF�oszt�ly As Variant, strJson As String
    Dim strHtmlMinta As String, _
        strHtmlKimenet As String, _
        strKimenet�tvonal As String, _
        strMinta�tvonal As String
    
    Dim n As Integer, maxloop As Integer
    Dim mell�kletAz As Long
    Dim most As Date
    
    maxloop = 0 ' Legfeljebb ennyi HTML-t gener�lunk, ha 0, akkor mindet feldolgozzuk
logba , "A HTML �llom�nyok k�sz�t�se indul:"
    ' Adatb�zis �s rekordk�szlet inicializ�l�sa
    Set db = CurrentDb
    Set rsJson = db.OpenRecordset("SELECT F�oszt�ly, json FROM lkMunkak�r�kF�oszt�lyJSON", dbOpenSnapshot)
    Set rstMMK = db.OpenRecordset("tMunkak�r�kMell�kletbeKer�ltek", dbOpenDynaset)
logba , "Lek�rdez�s lefutott:"
    Set dict = CreateObject("Scripting.Dictionary")
    most = Now()
logba , "F�oszt�lyok �s JSON adatok egy l�p�sben t�rt�n� �sszegy�jt�se indul", 2
    Do While Not rsJson.EOF
        strF�oszt�ly = rsJson!F�oszt�ly
        strJson = rsJson!json
        
        ' Ha a f�oszt�ly m�g nincs a Dictionary-ben, hozz�adjuk
        If Not dict.Exists(strF�oszt�ly) Then
            dict.Add strF�oszt�ly, strJson
        Else
            ' Ha m�r l�tezik, hozz�csatoljuk az �j JSON adatokat
            dict(strF�oszt�ly) = dict(strF�oszt�ly) & strJson
        End If
        rsJson.MoveNext
    Loop
    rsJson.Close
    Set rsJson = Nothing
logba , "F�oszt�lyok �s JSON adatok egy l�p�sben t�rt�n� �sszegy�jt�se k�sz", 2
    ' HTML sablon beolvas�sa
    strMinta�tvonal = "L:\Ugyintezok\Adatszolg�ltat�k\Adatb�zisok\Szakter�leti\Adatgy�jt�HTML02.html"
    strKimenet�tvonal = "L:\Ugyintezok\Adatszolg�ltat�k\Adatb�zisok\Szakter�leti\K�sz\"
    strHtmlMinta = ReadTextFile_UTF8(strMinta�tvonal)

logba , "HTML f�jlok l�trehoz�sa indul (most:" & most & ") Timer:" & Timer
    For Each strF�oszt�ly In dict.Keys
        strJson = dict(strF�oszt�ly)

        ' Sablonba helyettes�t�s
        strHtmlKimenet = Replace(Replace(strHtmlMinta, "�NevekLista", strJson), "�Orgname", strF�oszt�ly)
        
        ' F�jl ment�se UTF-8 k�dol�ssal
        WriteTextFile_UTF8 strKimenet�tvonal & strF�oszt�ly & CsakSz�mJegy(most) & ".html", strHtmlKimenet
        Set mell�kletek = db.OpenRecordset("tMunkak�rK�rlev�lMell�klet�tvonalak", dbOpenDynaset)
        With mell�kletek
            .AddNew
            .Fields("F�oszt�lyNeve") = strF�oszt�ly
            .Fields("�tvonal") = strKimenet�tvonal & strF�oszt�ly & CsakSz�mJegy(most) & ".html"
            .Fields("K�sz�lt") = most
            .Update

        End With
        ' Ha van maxloop be�ll�tva, akkor le�llunk, ha el�rt�k
        If maxloop <> 0 Then
            n = n + 1
            If n >= maxloop Then Exit For
        End If
    Next
    
    ' Takar�t�s
    Set dict = Nothing
    Set db = Nothing
    
logba , "A HTML �llom�nyok elk�sz�ltek! (most:" & most & ")  Timer:" & Timer


fvki
End Sub

Sub Munkak�rK�rlev�l()
fvbe ("Munkak�rK�rlev�l")
    Dim c�mzett(0) As String
    Dim mell�klet(0) As String
    Dim t�rgy As String
    Dim sz�vegt�rzs As String
    Dim mintasz�veg As String
    Dim db As DAO.Database
    Dim rs As DAO.Recordset
    Dim c�l As DAO.Recordset
    Dim startTime As Long
    Dim ClientMessageId As String 'Ebben fogjuk visszakapni az �zenet azonos�t�t
    Dim DeliveredDate As Date
    
    ClientMessageId = ""
    DeliveredDate = Date
    Const k�sleltet�s = 100
    Const strMinta�tvonal = "L:\Ugyintezok\Adatszolg�ltat�k\Adatb�zisok\Szakter�leti\K�rlev�lMinta.html"
    mintasz�veg = ReadTextFile_UTF8(strMinta�tvonal)
    
    Set db = CurrentDb
    
    Set rs = db.OpenRecordset("lkMunkak�r�kK�rlev�lC�mzettek01", dbOpenSnapshot)
    Set rs = db.OpenRecordset("tTesztMunkak�r�kK�rlev�lC�mzettek01", dbOpenSnapshot)
    'Set c�l = db.OpenRecordset("tMunkak�rElk�ld�ttLevelek", dbOpenDynaset)
    
    If Not rs.EOF Then
        rs.MoveLast
        rs.MoveFirst

        
        Do Until rs.EOF
            c�mzett(0) = rs.Fields("Hivatali email")
            mell�klet(0) = rs.Fields("�tvonal")
            t�rgy = "Az eg�szs�g�gyi alkalmass�gi vizsg�lat al� es� foglalkoztatottak n�vsor�nak pontos�t�sa (" & rs.Fields("F�oszt�ly") & ")"
            
            sz�vegt�rzs = Replace(mintasz�veg, "\u247\'f7NevCimMegszolitas", MindenSz�NagyKezd�Bet�vel(drel�re(z�rojeltelen�t�(rs!n�v))) & " " & rs!c�m & " " & rs!megsz�l�t�s)
            
        'Debug.Print c�mzett(0); mell�klet(0); t�rgy; vbNewLine & Left(sz�vegt�rzs, 2000)
        
            Call Groupwise_Mail(c�mzett(), mell�klet(), t�rgy, sz�vegt�rzs, ClientMessageId, DeliveredDate)
            Debug.Print ClientMessageId, DeliveredDate
            With c�l
                .AddNew
                    .Fields("ClientMessageId") = ClientMessageId
                    .Fields("deliveredDate") = DeliveredDate
                    .Fields("Ad�jel") = rs.Fields("Ad�jel")
                    .Fields("BFKHK�d") = rs.Fields("BFKHF�osztK�d")
                    .Fields("username") = felhaszn�l� 'Environ("USERNAME")
                .Update
            End With
            rs.MoveNext
        Loop
        startTime = Timer
        Do While Timer < startTime + (k�sleltet�s / 1000)
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