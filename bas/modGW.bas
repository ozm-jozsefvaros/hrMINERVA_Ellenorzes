Option Compare Database
Private Const c�mzett = 0 'egwTo
Private Const m�solat = 1 'egwCC
Private Const titkos = 2 'egwBC


Function Groupwise_Mail(ByRef myRecipients() As String, ByRef myAttachments() As String, ByVal mySubject As String, ByVal myBodytext As String, ByRef ClientMessageId As String, ByRef DeliveredDate As Date, Optional ByRef ccRecipients As Variant, Optional ByRef bccRecipients As Variant)
'Forr�s: https://www.access-programmers.co.uk/forums/threads/create-groupwise-email-with-access.64031/post-413157
'Szerz�: reclusivemonkey;  Registered User. � From West Yorkshire, U.K.
'Publik�lta: 2005. aug. 19.
'###
fvbe ("Groupwise_Mail")
    ' Declare the objects
    Dim objGroupWise As Object
    Dim objAccount As Object
    Dim objMessages As Object
    Dim objMessage As Object
    Dim objMailBox As Object
    Dim objRecipients As Object
    Dim objRecipient As Object
    Dim Recipient As Variant
    Dim ccRecipient As Variant
    Dim bccRecipient As Variant
    Dim objAttachment As Object
    Dim objAttachments As Object
    Dim Attachment As Variant
    Dim objMessageSent As Variant

    

    On Error GoTo Errorhandling

    ' Now build the GroupWise message object
    Set objGroupWise = CreateObject("NovellGroupWareSession")
    Set objAccount = objGroupWise.Login
    Set objMailBox = objAccount.MailBox
    Set objMessages = objMailBox.messages
    Set objMessage = objMessages.Add("GW.MESSAGE.MAIL", "Draft")

    ' Add each of the Recipients
    Set objRecipients = objMessage.Recipients
    For Each Recipient In myRecipients
        If Recipient <> vbNullString Then
            Set objRecipient = objRecipients.Add(Recipient)
        End If
    Next Recipient
    If Not IsEmpty(ccRecipient) Then 'If UBound(ccRecipients, 1) - LBound(ccRecipients, 1) Then
        For Each ccRecipient In ccRecipients
            If ccRecipient <> vbNullString Then
                Set objRecipient = objRecipients.Add(ccRecipient, , m�solat)
            End If
        Next ccRecipient
    End If
    If Not IsEmpty(bccRecipient) Then 'If UBound(bccRecipients, 1) - LBound(bccRecipients, 1) Then
        For Each bccRecipient In bccRecipients
            If bccRecipient <> vbNullString Then
                Set objRecipient = objRecipients.Add(bccRecipient, , titkos)
            End If
        Next bccRecipient
    End If
    ' Add each of the attachments
    Set objAttachments = objMessage.Attachments
    For Each Attachment In myAttachments
        If Attachment <> vbNullString Then _
            Set objAttachment = objAttachments.Add(Attachment) 'Ha �res lenne a csatolm�ny (p�ld�ul hib�s indexel�s miatt: 0-t�l indul!), nem akad meg...
    Next Attachment

    ' Add the Subject/Body Text
    With objMessage
        .Subject = mySubject
        .BodyText = myBodytext
        
    End With

    ' Send it
    Set objMessageSent = objMessage.Send
'Debug.Print
    ClientMessageId = objMessage.ClientMessageId
    DeliveredDate = objMessage.DeliveredDate
ExitHere:
    Set objGroupWise = Nothing
    Set objAccount = Nothing
    Set objMailBox = Nothing
    Set objMessages = Nothing
    Set objMessage = Nothing
    Set objRecipients = Nothing
    Set objAttachments = Nothing
    Set objRecipient = Nothing
    Set objAttachment = Nothing
fvki
    Exit Function

Errorhandling:
    MsgBox Hiba(Err)
    Resume ExitHere

End Function
Sub TestEmailFunc()
Dim m�solatotkapnak(0) As String, _
    titkosm�solatotkapnak(0) As String


    ReDim TestEmails(0) As String

    TestEmails(0) = "olah.zoltan3@bfkh.gov.hu"

    ReDim TestAttachments(0) As String

    TestAttachments(0) = "L:\Ugyintezok\Adatszolg�ltat�k\HRELL\Ellen�rz�s.html"

    Dim TestSubject As String
    TestSubject = "Test Email Function"

    Dim TestBody As String
    TestBody = "Hey, its all working now Me!"

    Groupwise_Mail myRecipients:=TestEmails(), _
                   myAttachments:=TestAttachments(), _
                   mySubject:=TestSubject, _
                   myBodytext:=TestBody, _
                   ClientMessageId:="", _
                   DeliveredDate:=Date, _
                   ccRecipients:=m�solatotkapnak(), _
                   bccRecipients:=titkosm�solatotkapnak()

End Sub
Function GroupwiseRead() As Integer

fvbe ("GroupwiseRead")
    'GW Objektumok:
    Dim objGroupWise As Object, _
        objAccount As Object, _
        objMailBox As Object, _
        objMailBoxC�l As Object, _
        objMessages As Object, _
        objMessage As Object
    Dim db As DAO.Database
    Dim �zenetaz As Long
    Dim str�zenet As String, _
        strSor As String, _
        mappaN�v As String, _
        c�lmappaN�v As String
    Dim D�tum As Date
    Dim �zenetT�bla As DAO.Recordset, _
        visszajelz�sT�bla As DAO.Recordset
    
    'El�rehalad�s-jelz�h�z
    Dim sor             As Integer, _
        oszlop          As Integer, _
        el�z�szakasz    As Integer, _
        SzakaszSz�m     As Integer
    Dim ehj             As New ehjoszt
    
    'Sz�ml�l�
    Dim n As Integer
    Dim i As Long, _
        j As Long

    'On Error GoTo Hiba
    mappaN�v = "Visszajelz�s"
    c�lmappaN�v = "Beolvasott visszajelz�s"
    'A Groupwise megnyit�sa
                                                logba , "Bejelentkez�s a GroupWise-ba", 2
    Set objGroupWise = CreateObject("NovellGroupWareSession")
    Set objAccount = objGroupWise.Login
                                                logba , "A mappa keres�se megkezdve...", 2
'    For Each elem In objAccount.AllFolders
'        If elem.Name = mappaN�v Then
'            Set objMailBox = elem
'                                                logba , "A keresett mapp�t megtal�ltuk!", 2
'            Exit For
'        End If
'    Next
    Set objMailBox = GWMappa(mappaN�v, objAccount)
    Set objMailBoxC�l = GWMappa(c�lmappaN�v, objAccount)
    
    If objMailBox Is Nothing Then
                                                logba , "Nem tal�ltuk " & n�vel�vel(mappaN�v) & " mapp�t!", 0
       GoTo ExitHere
       Exit Function
    End If
    'Set objMailBox = objAccount.MailBox
    Set objMessages = objMailBox.messages
ehj.Ini 100
SzakaszSz�m = 8
ehj.oszlopszam = objMessages.count
    Set �zenetT�bla = CurrentDb.OpenRecordset("tBej�v��zenetek", dbOpenDynaset)
    Set visszajelz�sT�bla = CurrentDb.OpenRecordset("tBej�v�Visszajelz�sek", dbOpenDynaset)
i = 1
    Do Until i > objMessages.count
        �zenetaz = 0
        Set objMessage = objMessages.item(i)
        With objMessage
            If InStr(1, .Subject.PlainText, "###Adatszolg visszajelzes###") > 0 Then
                �zenetaz = Bej�v��zenetekT�bl�ba(.CommonMessageId, .Sender.EmailAddress, .DeliveredDate, �zenetT�bla)
                If �zenetaz Then
                    str�zenet = ffsplit(.BodyText.PlainText, "#$", 2) 'A k�t #$ k�z�tti r�szt keress�k a sz�vegt�rzsben.
                    For j = 1 To StrCount(str�zenet, vbNewLine) + 1
                        strSor = ffsplit(str�zenet, vbNewLine, j) 'Vessz�k a k�vetkez� sort
                        If strSor <> "" Then
                            If StrCount(strSor, ":") > 1 Then
                                    D�tum = ffsplit(strSor, ":", 3)
                            End If
                            Bej�v�Visszajelz�sekT�bl�ba _
                                �zenetaz:=�zenetaz, _
                                HASH:=ffsplit(strSor, ":", 1), _
                                Visszajelz�sK�d:=ffsplit(strSor, ":", 2), _
                                Hat�ly:=dt�tal(D�tum), _
                                visszajelz�sT�bla:=visszajelz�sT�bla ' Ha a sor nem �res, be�rjuk a visszajelz�sek t�bl�ba
                               
                            � n 'Megsz�moljuk a be�rt sorokat
                            D�tum = 0
                        End If
                    Next j
                End If
                'Azt�n a napl�ba is be�rjuk...
                logba , .CommonMessageId & vbNewLine & _
                        .BodyText.PlainText & vbNewLine & _
                        .Sender.EmailAddress & vbNewLine & _
                        .DeliveredDate, 4
                '�thelyezz�k a Beolvasott visszajelz�sek mapp�ba
                objMessages.Move i, objMailBoxC�l.messages
            Else
                � i
            End If
        End With
        ehj.Novel
        If Int(ehj.Value / ehj.oszlopszam * SzakaszSz�m) > el�z�szakasz Then
            logba , accT�bla & ":;" & Int(ehj.Value / ehj.oszlopszam * 100) & "% elk�sz�lt...", 1
            el�z�szakasz = Int(ehj.Value / ehj.oszlopszam * SzakaszSz�m)
        End If
    Loop 'i
ehj.Torol
ExitHere:

    Set objGroupWise = Nothing
    Set objAccount = Nothing
    Set objMailBox = Nothing
    Set objMessages = Nothing
    Set objMessage = Nothing
'return:
    GroupwiseRead = n
fvki
    Exit Function

Hiba:
    MsgBox Hiba(Err)
    Resume ExitHere

End Function
Private Function GWMappa(ByVal mappaN�v As String, ByRef GWAccount As Object) As Object
Dim elem As Object
        For Each elem In GWAccount.AllFolders
        If elem.Name = mappaN�v Then
            Set GWMappa = elem
                                                logba , "A keresett mapp�t (" & mappaN�v & ") megtal�ltuk!", 2
            Exit For
        End If
    Next
End Function
Private Function Bej�v��zenetekT�bl�ba(CommonMessageId As String, SenderEmailAddress As String, DeliveredDate As Date, �zenetT�bla As DAO.Recordset) As Long
fvbe ("Bej�v��zenetekT�bl�ba")
    'On Error GoTo ErrorHandler
    Dim vissza
    'Dim �zenetT�bla As DAO.Recordset
    Dim recordExists As Boolean

    'Set �zenetT�bla = CurrentDb.OpenRecordset("tBej�v��zenetek", dbOpenDynaset)
    vissza = 0
        With �zenetT�bla
            .AddNew
            ![CommonMessageId] = CommonMessageId
            ![SenderEmailAddress] = SenderEmailAddress
            ![DeliveredDate] = DeliveredDate
            On Error GoTo ErrorHandler
            .Update
            On Error GoTo 0
            .Bookmark = .LastModified
            vissza = ![az�zenet]
        End With

ki:
    '�zenetT�bla.Close
    'Set �zenetT�bla = Nothing
    Bej�v��zenetekT�bl�ba = vissza
    fvki
Exit Function

ErrorHandler:
    If Err.Number = 3022 Then
        �zenetT�bla.CancelUpdate
    Else
        MsgBox Hiba(Err)
        Resume ki
    End If
    GoTo ki
End Function
Sub Bej�v�Visszajelz�sekT�bl�ba(�zenetaz As Long, HASH As String, Visszajelz�sK�d As Integer, Hat�ly As Date, ByRef visszajelz�sT�bla As DAO.Recordset)
    'Dim tabla As Recordset
    Dim azVisszajelz�s As Integer
    'Set tabla = CurrentDb.OpenRecordset("tBej�v�Visszajelz�sek", dbOpenDynaset)
    With visszajelz�sT�bla
        .AddNew
        ![az�zenet] = �zenetaz
        ![HASH] = HASH
        ![Visszajelz�sK�d] = Visszajelz�sK�d
        ![Hat�ly] = Hat�ly
        azVisszajelz�s = .AbsolutePosition
        Debug.Print (azVisszajelz�s)
        .Update
        '.Close
    End With
    'Set tabla = Nothing
End Sub