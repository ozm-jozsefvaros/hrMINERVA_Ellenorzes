
Option Explicit
Private piSk�la As Integer
Private pdblValue As Integer
Private pOszlopSzam As Long
Private idoKezdes As Date

Public Sub Ini(Optional sk�la As Integer = 100)
        Dim xxx As String
        Dim i As Long
    xxx = ""
    piSk�la = sk�la
    'Application.DisplayStatusBar = True
    'Application.StatusBar = xxx
    Status (xxx)
    For i = 1 To piSk�la
        xxx = xxx & "-"
    Next
    xxx = xxx & "   0%"
    'Application.StatusBar = xxx
    Status (xxx)
    
    idoKezdes = Now()
    
End Sub
Public Property Get oszlopszam() As Long
    oszlopszam = pOszlopSzam
End Property
Public Property Let oszlopszam(ByVal lMax As Long)
    pOszlopSzam = lMax
End Property
Public Property Get Value() As Double
    Value = pdblValue
End Property
Public Property Let Value(ByVal dblVal As Double)
    If Me.oszlopszam >= dblVal Then
        pdblValue = dblVal
    End If
End Property
Public Sub Novel()
    Me.Value = pdblValue + 1
    Frissit
End Sub
Private Sub Frissit()
fvbe ("Friss�t")
    Dim dbl�ll�s As Double
    Dim dblXsz�m As Double
    Dim n As Long
    Dim xxx As String
    Dim oszlopszam As Long
    oszlopszam = Me.oszlopszam
    If oszlopszam Then
        dbl�ll�s = Me.Value / oszlopszam 'A jelenlegi �ll�s
    Else
        dbl�ll�s = 1
        oszlopszam = 1
    End If
    dblXsz�m = Round(piSk�la * dbl�ll�s, 0) ' Eg�sz sz�mra kerek�tve a ki�rand� X-ek sz�ma
    If dblXsz�m > Round(piSk�la * (Me.Value - 1) / oszlopszam) Then
        xxx = ""
        For n = 1 To piSk�la
            If n <= dblXsz�m Then
                xxx = xxx & "x"
            Else
                xxx = xxx & "-"
            End If
        Next
        Select Case Len(dblXsz�m)
            Case 1
                xxx = xxx & "   "
            Case 2
                xxx = xxx & "  "
            Case 3
                xxx = xxx & " "
        End Select
        xxx = xxx & dblXsz�m & "%" & hatralevoIdo(dbl�ll�s)
        'Application.StatusBar = xxx
        Status (xxx)
    End If
    logba , dbl�ll�s & "," & piSk�la & "," & dblXsz�m, 4
    If dblXsz�m = piSk�la Then Me.Torol
    DoEvents
fvki
End Sub
Public Sub Torol()
    'Application.StatusBar = ""
    Status ("")
End Sub
Private Function hatralevoIdo(dbl�ll�s As Double) As String
Dim ido As Long, _
    �ra As Long, _
    perc As Long, _
    mp  As Long
Dim Kimenet As String
Dim befejez�s As Date

    ido = Int(DateDiff("s", idoKezdes, Now()) / dbl�ll�s) * (1 - dbl�ll�s)
    befejez�s = Format(DateAdd("s", ido, Now()), "hh:mm:ss")
    �ra = Int(ido / (60 * 60))
    perc = Int((ido - (�ra * 60 * 60)) / 60)
    mp = ido - ((�ra * 60 * 60) + perc * 60)
    '�ra
    If �ra > 0 Then
        Kimenet = Right(0 & �ra, 2) & ":"
    End If
    'perc
    Kimenet = Kimenet & Right(0 & perc, 2) & ":"
    'm�sodperc
    Kimenet = Kimenet & Right(0 & mp, 2)
hatralevoIdo = " H�tral�v� id�:" & Kimenet & ". V�rhat� befejez�s:" & befejez�s & "."
End Function

