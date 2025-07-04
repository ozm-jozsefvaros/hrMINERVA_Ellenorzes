'E gy�tem�nyben, ha az MIT licencia eml�ttettik, (megjel�lve a szerz�t �s a m� sz�let�s�nek �v�t) azon az al�bbi felhaszn�l�si enged�lyt kell �rteni:

'Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"),
'to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software,
'and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
'The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
'THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
'FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
'WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
Option Compare Database
Function BFKH(k�d As String) As String
fvbe ("BFKH")
'#MIT Ol�h Zolt�n (c) 2022, 2024
'# Minden k�t pont k�z�tt, ha csak egy karakter van, besz�r el�je egy 0-t. Pl.:BFKH.1.2. -> BKFH.01.02.
'# C�l: Az �gy kialak�tott szervezeti egys�g azonos�t� ABC sorba rendezve �rtelmes sorrendet ad...
    Dim intN As Integer, i As Integer, intPoz As Integer
    Dim str�tm As String, _
        strElv As String, _
        szakasz As String
    
    strElv = "."
    str�tm = ""
    intN = StrCount(k�d, strElv)
    
    For i = 1 To intN
        szakasz = ffsplit(k�d, strElv, i)
        Select Case i
            Case 1 'els�
                str�tm = szakasz
            Case Else 'a k�zb�ls�k
                If Len(szakasz) = 1 Then 'If Len(ffsplit(k�d, strElv, i)) = 1 Then
                    str�tm = str�tm & ".0" & szakasz 'str�tm = str�tm & ".0" & ffsplit(k�d, strElv, i)
                Else
                    str�tm = str�tm & "." & szakasz 'str�tm = str�tm & "." & ffsplit(k�d, strElv, i)
                End If
        End Select
                
    Next i
    BFKH = str�tm
fvki
End Function
Function tBFKH(ByVal strHivatalVagyF�oszt�ly As Variant) As String
'#MIT Ol�h Zolt�n (c) 2024

    If IsNull(strHivatalVagyF�oszt�ly) Then
        tBFKH = ""
        Exit Function
    End If
    tBFKH = Replace(strHivatalVagyF�oszt�ly, "Budapest F�v�ros Korm�nyhivatala", "BFKH")
End Function
Public Function ffsplit(ByVal mez� As Variant, Optional ByVal elv�laszt� As String = ",", Optional ByVal sz�m As Integer = 1) As String
'Licencia: MIT Ol�h Zolt�n 2022 (c)
'A megadott 'elv�laszt�'-val tagolt 'mez�' karakterl�ncban a Sz�m-nak megfelel� sorsz�m� tagot adja vissza.
'Ha a megadott 'mez�' �rt�k null, �res karakterl�ncot ad vissza.
'Ha a megadott �rt�k nem tartalmazza az 'elv�laszt�'-t, a megadott �rt�ket adja vissza
'Ha Sz�m nagyobb, mint ah�ny darabra oszthat� az elv�laszt�val a mez�, akkor az utols� �rt�ket adja.
fvbe ("ffsplit")
    Dim temp() As String
    Dim n As Integer
    
    On Error GoTo Hiba
    
    If IsNull(mez�) Then
        ffsplit = ""
        Exit Function
    End If
    n = StrCount(mez�, elv�laszt�)
    If n < 1 Then
        ffsplit = mez�
        Exit Function
    End If
    ReDim temp(n)
    logba , mez� & ", " & n, 4

    temp = Split(mez�, elv�laszt�)
    If sz�m > n + 1 Then
        sz�m = n + 1
    End If
    ffsplit = Trim(temp(sz�m - 1))
    logba , temp(sz�m - 1), 4
fvki
Exit Function
Hiba:
    v�lt1.n�v = "mez�"
    v�lt1.�rt�k = mez�
    v�lt2.n�v = "elv�laszt�"
    v�lt2.�rt�k = elv�laszt�
    v�lt3.n�v = "sz�m"
    v�lt3.�rt�k = sz�m
    MsgBox (Hiba(Err))
fvki
End Function
Function Utols�(ByVal sz�veg As Variant, Optional ByVal elv�laszt� As String = "", Optional ByVal vissza As Integer = 0) As String
'Licencia: MIT Ol�h Zolt�n 2023 (c)
'Ez a fv az elv�laszt�-val tagolt megadott sz�veg utols� tagj�t adja eredm�ny�l.
'Ha a vissza �rt�k meg van adva, akkor az utols�t�l vissza �rt�kkel visszasz�mol, s annak a helynek az �rt�k�t adja vissza.
'Hasonl�t az InStrRev f�ggv�nyre, de:
'   az elv�laszt� nem k�telez� elem, megpr�b�lja kital�lni;
'   a 'vissza' param�ter az ism�tl�d� elemek sz�m�t jelenti, s nem a h�tulr�l sz�m�tott karakterek sz�m�t;
'   a 'vissza' param�ter lehet negat�v �s pozit�v is; �s Null is, de ekkor �res �rt�kkel t�r vissza (az InStrRev ilyenkor hib�ra fut)

    Dim db As Integer
    Dim i As Integer 'sz�ml�l�
    
    If elv�laszt� = "" Then
        Dim elv�laszt�k(7) As Variant
        elv�laszt�k(0) = ","
        elv�laszt�k(1) = ";"
        elv�laszt�k(2) = "."
        elv�laszt�k(3) = ":"
        elv�laszt�k(4) = "|"
        elv�laszt�k(5) = "\"
        elv�laszt�k(6) = "/"
        elv�laszt�k(7) = "-"
    
        For i = 0 To UBound(elv�laszt�k)
            If InStr(1, sz�veg, elv�laszt�k(i)) > 0 Then
                elv�laszt� = elv�laszt�k(i)
                Exit For
            End If
        Next i
    End If
    If elv�laszt� = "" Then
        Utols� = ""
        Exit Function ' ha mindezek ellen�re �res, akkor �res �rt�kkel t�r�nk vissza
    End If
    db = StrCount(sz�veg, elv�laszt�) + 1
    If IsNull(vissza) Then vissza = 0
    vissza = Abs(vissza)
    If vissza >= db Or vissza < 0 Then
        Utols� = ""
        Exit Function
    End If
    Utols� = ffsplit(sz�veg, elv�laszt�, db - vissza)

End Function
Function strV�ge(ByVal sz�veg As Variant, Optional ByVal elv�laszt� As String = "", Optional ByVal szakaszokSz�ma As Integer = 1) As String
'Licencia: MIT Ol�h Zolt�n & Br�nyi Bal�zs 2024 (c)
Dim i As Integer
Dim Kimenet As String
sz�veg = TrimX(sz�veg, elv�laszt�)
szakaszokSz�ma = Abs(szakaszokSz�ma)
If szakaszokSz�ma = 0 Then szakaszokSz�ma = 1

For i = szakaszokSz�ma To 1 Step -1
    If i = szakaszokSz�ma Then
        Kimenet = Utols�(sz�veg, elv�laszt�, i - 1)
    Else
        Kimenet = Kimenet & elv�laszt� & Utols�(sz�veg, elv�laszt�, i - 1)
    End If
Next i
strV�ge = Kimenet & elv�laszt�
End Function
Function strLev�g(ByVal sz�veg As Variant, Optional ByVal elv�laszt� As String = "", Optional ByVal lev�gand�SzakaszokSz�ma As Integer = 1)
Dim i As Integer
Dim max As Integer
Dim Kimenet As String

sz�veg = TrimX(sz�veg, elv�laszt�)
max = StrCount(sz�veg, elv�laszt�) + 1
lev�gand�SzakaszokSz�ma = Abs(lev�gand�SzakaszokSz�ma)

If lev�gand�SzakaszokSz�ma = 0 Then lev�gand�SzakaszokSz�ma = 1
If lev�gand�SzakaszokSz�ma > max Then lev�gand�SzakaszokSz�ma = max

For i = 1 To max - lev�gand�SzakaszokSz�ma
    If i = 1 Then
        Kimenet = ffsplit(sz�veg, elv�laszt�, i)
    Else
        Kimenet = Kimenet & elv�laszt� & ffsplit(sz�veg, elv�laszt�, i)
    End If
Next i
strLev�g = Kimenet
End Function
Public Function StrCount(ByVal sz�veg As Variant, ByVal keresett As Variant) As Integer
'------------------------------------------------------------------
' Purpose: Counts the numbers of times an item occurs
' in a string.
' Coded by: raskew
' Arguments: TheStr: The string to be searched.
' TheItem: The item to search for.
' Returns: The number of occurences as an integer.
'
' Note: To test: Type '? StrCount(""The quick brown fox jumped over
' the lazy dog"", ""the"") in the debug window.
' The function returns 2.
'####################################################################
'# M�dos�totta: Ol�h Zolt�n (2024) MIT
'# Dim I As Integer <- felesleges
'# If Instr(1,strHold,itemhold) > 0 then <-nem ezt kell vizsg�lni
'# hossz bevezet�s: �ttekinthet�bb, s tal�n gyorsabb is
'# A Null �rt�kek eset�n 0 eredm�nnyel t�r visssza,
'# variant: �gy sz�mokra is haszn�lhat�
'####################################################################
'------------------------------------------------------------------

Dim j As Integer
Dim placehold As Integer
Dim varHold As Variant
Dim itemhold As Variant
Dim hossz As Long

    varHold = Nz(sz�veg, "") 'Itt sz�rj�k ki a Null �rt�keket
    itemhold = Nz(keresett, "")
    hossz = Len(itemhold) 'El�re kisz�m�tjuk, t�bbsz�r haszn�ljuk
    j = 0
    
    If hossz > 0 Then ' A nullhossz� keresett sz�veg nagyon sok tal�latot eredm�nyez XD
        While InStr(1, varHold, itemhold) > 0
            placehold = InStr(1, varHold, itemhold)
            j = j + 1
            varHold = Mid(varHold, placehold + hossz)
        Wend
    End If
    StrCount = j
End Function
Function TrimX(ByVal tiszt�tand� As Variant, ByVal mit�l As Variant) As String
'Licencia: MIT Ol�h Zolt�n 2024 (c)
    If IsNull(tiszt�tand�) Or IsNull(mit�l) Then
        TrimX = vbNullString
        Exit Function
    End If
    If Left(tiszt�tand�, 1) = mit�l Then
        tiszt�tand� = Right(tiszt�tand�, Len(tiszt�tand�) - 1)
    End If
    If Right(tiszt�tand�, 1) = mit�l Then
        tiszt�tand� = Left(tiszt�tand�, Len(tiszt�tand�) - 1)
    End If
    TrimX = tiszt�tand�
End Function
Function z�r�jeltelen�t�(ByVal n�v As Variant) As String
    z�r�jeltelen�t� = z�rojeltelen�t�(n�v)
End Function
Function z�rojeltelen�t�(ByVal n�v As Variant) As String
'Licencia: MIT Ol�h Zolt�n 2023 (c)
    Dim zjh As String 'A z�r�jel helye
    zjh = 0
    n�v = Nz(n�v, "")
    zjh = InStr(1, n�v, "(")
    If zjh > 0 Then
           z�rojeltelen�t� = Trim(Left(n�v, zjh - 1))
    Else
        z�rojeltelen�t� = n�v
    End If
End Function
Function n�vel�(sz� As Variant) As String
'Licencia: MIT Ol�h Zolt�n 2022 (c)
    'A n�vel� m�sodik bet�j�t z-re �ll�tja, vagy semmire
    Dim mag�nhangz�k As String
    Dim keresett As String
    
    If IsNumeric(sz�) Then
        n�vel� = ""
        Select Case Left(CStr(sz�), 1)
            Case "1"
                Select Case sz�
                    Case 1 To 9, 100 To 199, 1000 To 1999, 100000 To 1999999
                        n�vel� = "z"
                End Select
            Case "5"
                n�vel� = "z"
        End Select
        Exit Function
    End If
    
    mag�nhangz�k = "a�e�i�o���u���A�E�I�O���U���"
    keresett = Left(Nz(sz�, ""), 1)
    Select Case keresett
        Case 0 To 9
            Select Case keresett
                Case 1, 5
                    n�vel� = "z"
                Case Else
                    n�vel� = ""
            End Select
            Exit Function
    End Select
    If InStr(1, mag�nhangz�k, Left(sz�, 1)) > 0 Then
        n�vel� = "z"
    Else
        n�vel� = ""
    End If
    
End Function

Function n�vel�vel(sz� As Variant, Optional ez As Boolean = False, Optional hat�roz�i As Boolean = False, Optional nagybet� As Boolean) As String
'Licencia: MIT Ol�h Zolt�n 2022 (c)
    If ez Then
        n�vel�vel = "e"
        If nagybet� Then
            n�vel�vel = UCase(n�vel�vel)
        End If
        If hat�roz�i Then
            n�vel�vel = n�vel�vel & "me"
        End If
    Else
        n�vel�vel = "a"
        If nagybet� Then
            n�vel�vel = UCase(n�vel�vel)
        End If
        If hat�roz�i Then
            n�vel�vel = n�vel�vel & "ma"
        End If
    End If
    n�vel�vel = n�vel�vel & n�vel�(sz�) & " " & sz�
End Function
Function drh�tra(n�v As String) As String
'Licencia: MIT Ol�h Zolt�n 2023 (c)
'Megkeresi a n�v elej�n a "Dr. " sz�vegr�szt �s a v�g�re teszi
    Dim drv As Boolean
    drv = False
    
    If LCase(Left(n�v, 3)) = "dr." Then
        n�v = Trim(Right(n�v, Len(n�v) - 3)) & " dr."
    End If
    drh�tra = n�v
    n�v = ""
End Function
Function drel�re(n�v As String, Optional nagybet� As Boolean = False) As String
'Licencia: MIT Ol�h Zolt�n 2023 (c)
'Megkeresi a n�v elej�n a "Dr. " sz�vegr�szt �s a v�g�re teszi
    Dim drv As Boolean
    drv = False
    
    If LCase(Right(n�v, 3)) = "dr." Then
        If nagybet� Then
            n�v = "Dr. " & Trim(Left(n�v, Len(n�v) - 3))
        Else
            n�v = "dr. " & Trim(Left(n�v, Len(n�v) - 3))
        End If
    End If
    drel�re = n�v
    n�v = ""
End Function
Function MindenSz�NagyKezd�Bet�vel(sz�veg As String) As String
    Dim x As Object
    Set x = CreateObject("Scripting.Dictionary")
    Dim arrWords() As String
    Dim i As Integer
    
    ' Split the text into words using space as a delimiter
    arrWords = Split(sz�veg, " ")
    
    ' Loop through each word
    For i = LBound(arrWords) To UBound(arrWords)
        If Len(arrWords(i)) > 0 Then
            ' Capitalize the first letter and concatenate with the rest of the word
            arrWords(i) = UCase(Left(arrWords(i), 1)) & Mid(arrWords(i), 2)
        End If
    Next i
    
    ' Join the words back into a single string

MindenSz�NagyKezd�Bet�vel = Join(arrWords, " ")
End Function
Function drLev�laszt(n�v As Variant, Optional el�tagot As Boolean = True) As String
'Licencia: MIT Ol�h Zolt�n 2023 (c)
'# Hib�s eredm�nyt ad az al�bbi esetekben:
'# dr. Kov�cs J�nosn� Horv�th Etelka dr.",False <-- Megold�s: csak az els�t kell meghagyni

Dim el�tag As String
    If IsNull(n�v) Then
        drLev�laszt = ""
        Exit Function
    End If
    n�v = Trim(n�v)
    el�tag = "dr." ' Ha csak m�s eredm�nyre nem jutunk

    Select Case ffsplit(n�v, " ", 1) 'Megvizsg�ljuk az els� sz�t, Dr-e
        Case "Dr."
            n�v = Trim(Mid(n�v, 4, Len(n�v) - 3))
        Case "Dr"
            n�v = Trim(Mid(n�v, 3, Len(n�v) - 2))
        Case Else
            Select Case ffsplit(n�v, " ", StrCount(n�v, " ") + 1) 'Ha az els� sz� nem Dr, akkor az utols� az-e
                Case "Dr."
                    n�v = Trim(Left(n�v, Len(n�v) - 4))
                Case "Dr"
                    n�v = Trim(Left(n�v, Len(n�v) - 3))
                Case Else 'ha sem el�l, sem h�tul nincs...
                    If ffsplit(n�v, ".", 1) = "dr" Then 'akkor m�g lehet, hogy a Dr.Kov�cs esete �ll fenn?
                        n�v = Trim(Mid(n�v, 4, Len(n�v) - 3))
                    Else
                        el�tag = ""
                    End If
             End Select
    End Select
    If el�tagot Then
        drLev�laszt = el�tag
    Else
        drLev�laszt = n�v
    End If

End Function
Function sz�vegF�z�(sz�veg As String, sz�m As Integer) As String
'#MIT Ol�h Zolt�n (c) 2023
'Print sz�vegF�z�("V", 3)
'VVV
    Dim n As Integer
    If sz�m < 1 Then Exit Function
    For n = 1 To sz�m
        sz�vegF�z� = sz�vegF�z� & sz�veg
    Next n
End Function
Function Irsz(c�m As Variant) As String
'#MIT Ol�h Zolt�n (c) 2023
'Ha a c�m els� 4 karaktere az ir�ny�t�sz�m, akkor azt adja vissza
    'Left(IIf(Len(Nz([Munkav�gz�s helye - c�m];""))<3;"000";Nz([Munkav�gz�s helye - c�m];"000"));3)*1
    If IsNull(c�m) Or Len(c�m) < 4 Then
        Irsz = "0000"
        Exit Function
    End If
    Irsz = Left(Trim(c�m), 4)
    If Not IsNumeric(Irsz) Then
        Irsz = "0000"
    End If
End Function
Function Ker�let(Irsz As Variant) As Integer
'#MIT (c) Ol�h Zolt�n  2023-2024
    Dim n, hossz As Integer
    hossz = Nz(Len(Irsz), 0)
    If IsNull(Irsz) Or hossz < 3 Or hossz > 4 Then
        Ker�let = 0
        Exit Function
    End If
    If Left(Irsz, 1) = 1 Then ' Csak Budapest
        Select Case hossz
            Case 4
                Ker�let = Mid(Irsz, 2, 2)
            Case 3
                Ker�let = Right(Irsz, 2)
            Case Else
                Ker�let = 0
                Exit Function
        End Select
    Else
        Ker�let = 0
    End If
End Function
Public Function dt�tal(strD�tum As Variant, Optional Sorrend As String = "�hn", Optional nullaEset�n As Date = 0) As Date
' (c) Ol�h Zolt�n 2024 MIT
' A megadott sz�veget (strD�tum) �talak�tja d�tumm�.
' �rv�nyes elv�laszt�k: . vagy - vagy /
' Ha az elv�laszt�val elv�lasztott �rt�keknek nincs megadva a sorrendje, akkor az �v, h�, nap sorrendet felt�telezi.
' Ha
' Ha a strD�tum �rt�ke Null vagy semmi, tov�bb�, ha a sorrend els� h�rom karaktere az �, h �s n bet�kb�l nem pontosan egyet-egyet tartalmaz,
' akkor 1-et ad vissza.
' Kell hozz� az ffsplit() fv., ahhoz meg a StrCount() f�ggv�ny.
    Dim dtV�l as string,
        dtV�laszt�k as string,
        strDate As String
    Dim �v as string, _
        h� as string, _
        nap As String
    Dim i as integer, _
        j as integer, _
        darab as integer, _
        ih� as integer, _
        inap as integer,
        i�v As Integer
    Dim Kimenet As Date
On Error GoTo Hiba
    If IsNumeric(strD�tum) Then
        If strD�tum < 100000 Then
            dt�tal = CDate(strD�tum)
            Exit Function
        End If
    End If
On Error Resume Next
    Kimenet = DateValue(Format(Replace(strD�tum, ".", "/"), "mm/dd/yyyy"))
    If Replace(Kimenet, " ", "") = strD�tum Then
        dt�tal = Kimenet
        Exit Function
    End If
On Error GoTo 0
NemD�tum:
    Sorrend = Left(Sorrend, 3)
    If (StrCount(Sorrend, "�") <> 1) Or (StrCount(Sorrend, "h") <> 1) Or (StrCount(Sorrend, "n") <> 1) Then
        dt�tal = nullaEset�n
        Exit Function
    End If
    
            logba , CStr(Nz(strD�tum, nullaEset�n)), 3
    If IsNull(strD�tum) Or strD�tum = "" Or strD�tum = 0 Then
        dt�tal = nullaEset�n
        Exit Function
    End If
    
    dtV�laszt�k = ".-/"
    For j = 2 To 0 Step -1
        For i = 1 To Len(dtV�laszt�k)
            dtV�l = Mid(dtV�laszt�k, i, 1)
            strDate = strD�tum
            If Left(strDate, 1) = dtV�l Then: strDate = Right(strDate, Len(strDate) - 1)
            If Right(strDate, 1) = dtV�l Then: strDate = Left(strDate, Len(strDate) - 1)
            
            darab = StrCount(strDate, dtV�l)
            If darab >= j Then Exit For
        Next i
        If darab >= j Then Exit For
    Next j
    'TODO Mi van ha csupa sz�m van? Pl.:20110101
    If InStr(1, Sorrend, "�") > darab + 1 Then
        �v = "" & Year(Now())
    Else
         �v = Left(ffsplit(strD�tum, dtV�l, InStr(1, Sorrend, "�")), 4) 'TODO Mi van ha t�bb, mint 4 jegy� az �v?
    End If
    If InStr(1, Sorrend, "h") > darab + 1 Then
        h� = "01"
    Else
         h� = Left(ffsplit(strD�tum, dtV�l, InStr(1, Sorrend, "h")), 4)
    End If
    If InStr(1, Sorrend, "n") > darab + 1 Then
        nap = "01"
    Else
         nap = Left(ffsplit(strD�tum, dtV�l, InStr(1, Sorrend, "n")), 4)
    End If
   

    i�v = CsakSz�m(�v)
    ih� = CsakSz�m(h�)
    inap = CsakSz�m(nap)
    If CInt(ih�) > 12 Then: h� = "12": ih� = 12
    If CInt(ih�) < 1 Then: h� = "01": ih� = 1
    If nap = "" Then: nap = 1
    ' A t�l nagy nap �rt�ket att�l f�gg�en vizsg�ljuk meg, hogy melyik h�napr�l van sz�
    Select Case CInt(ih�)
        Case 1, 3, 5, 7, 8, 10, 12
            If CInt(inap) > 31 Then: nap = "31"
        Case 4, 6, 9, 11
            If CInt(inap) > 30 Then: nap = "30"
        Case 2
            If CInt(inap) > Day(DateSerial(�v, 3, 1) - 1) Then
                nap = CStr(Day(DateSerial(�v, 3, 1) - 1))
            End If
        Case Else
            dt�tal = 1
            Exit Function
    End Select
    If CInt(inap) < 1 Then: h� = "01"
    
    dt�tal = DateSerial(CsakSz�m(�v), CsakSz�m(h�), CsakSz�m(nap))
Exit Function
Hiba:
    Select Case Err.Number
        Case 6, 13
            GoTo NemD�tum
    End Select
End Function
Function CsakSz�m(sz�veg As Variant) As Long
If IsNull(sz�veg) Or sz�veg = "" Then: CsakSz�m = 0: Exit Function
'Todo: negat�v sz�mok kezel�se
On Error GoTo Hiba
    Dim jel As String
    Dim jel2 As String
    Dim p As Integer
    Dim hossz As Integer
    Dim maxhossz As Long
    
    hossz = Len(sz�veg)
    maxhossz = 10
    For p = 1 To hossz
        jel2 = ""
        jel2 = CInt(Mid(sz�veg, p, 1))
        If Len(jel2) > 0 Then
            jel = jel & jel2
            � maxhossz '
            If maxhossz <= 0 Then
                Exit For
            End If
        End If
    Next p
    If maxhossz <= 0 And jel > "2147483647" Then
        jel = 0
    End If
    CsakSz�m = CLng(jel)
Exit Function
Hiba:
    If Err.Number = 13 Then
        Resume Next
    End If
    MsgBox Hiba(Err)
End Function
Function CsakSz�mJegy(sz�veg As Variant) As String
If IsNull(sz�veg) Or sz�veg = "" Then: CsakSz�mJegy = 0: Exit Function
'Todo: negat�v sz�mok kezel�se
On Error GoTo Hiba
    Dim jel As String

    Dim p As Integer
    Dim hossz As Integer
    Dim maxhossz As Long
    
    hossz = Len(sz�veg)
    maxhossz = 10
    For p = 1 To hossz

        jel = jel & CInt(Mid(sz�veg, p, 1))

    Next p
    
    CsakSz�mJegy = jel
Exit Function
Hiba:
    If Err.Number = 13 Then
        Resume Next
    End If
    MsgBox Hiba(Err)
End Function
Function sz�tbont�(mez� As Variant, lek�rdez�s As Variant) As Variant
    If IsNull(mez�) Then Exit Function
    If IsNull(lek�rdez�s) Then Exit Function
    If mez� = vbNullString Then Exit Function
    If lek�rdez�s = vbNullString Then Exit Function
    Dim n As Long
    Dim Kimenet() As Variant
    Dim db As DAO.Database
    Dim qdf As QueryDef
    Dim mez�sz�m As Long
    
    Set db = CurrentDb
    Set qdf = db.QueryDefs(lek�rdez�s)
    With qdf
        mez�sz�m = StrCount(mez�, "|")
        ReDim Kimenet(1 To mez�sz�m, 1 To 2)
        For n = 1 To mez�sz�m
            Kimenet(n, 1) = .Fields(n - 1).Name
            Kimenet(n, 2) = Trim(ffsplit(mez�, "|", n))
        Next n
    End With
    sz�tbont� = Kimenet
End Function
Function CalcStrNumber(strInput As String) As Long
    Dim i As Integer
    Dim total As Long
    total = 0
    
    ' Loop through each character in the string
    For i = 1 To Len(strInput)
        ' Add ASCII value of each character to total
        total = total + Asc(Mid(strInput, i, 1))
    Next i
    
    CalcStrNumber = total
End Function
Function telefonsz�mjav�t�(telefonsz�m As Variant) As String
Dim poz As Integer
Dim eredeti As String
    If IsNull(telefonsz�m) Or telefonsz�m = vbNullString Then
        telefonsz�mjav�t� = vbNullString
        Exit Function
    End If
    eredeti = telefonsz�m
    '(1)1234-543 / 12345
    '06-1-896-2474
    '+3618962378
    '06-20/123-4567
    'Nem nyomtathat� karakterek elt�vol�t�sa:
    If InStr(telefonsz�m, Chr(9)) > 0 Then telefonsz�m = Replace(telefonsz�m, Chr(9), vbNullString)
    If InStr(telefonsz�m, Chr(10)) > 0 Then telefonsz�m = Replace(telefonsz�m, Chr(10), vbNullString)
    If InStr(telefonsz�m, Chr(13)) > 0 Then telefonsz�m = Replace(telefonsz�m, Chr(13), vbNullString)
    If InStr(telefonsz�m, Chr(16)) > 0 Then telefonsz�m = Replace(telefonsz�m, Chr(16), vbNullString)
    'Ha a / az el�h�v�sz�mot hat�rolja:
    poz = InStr(1, telefonsz�m, "/")
    If poz > 0 And poz <= 6 Then
        telefonsz�m = Left(telefonsz�m, poz - 1) & Replace(telefonsz�m, "/", "", poz - 1, 1)
    End If
    'Lev�gjuk a mell�ket
    telefonsz�m = ffsplit(telefonsz�m, "/", 1)
    'El�tiszt�t�s
    telefonsz�m = Replace(Replace(telefonsz�m, "(", ""), ")", "")
    'Ha +szal kezd�dik
    Select Case Left(telefonsz�m, 1)
        Case "+"
            Select Case Left(telefonsz�m, 3)
                Case "+36"
                    telefonsz�m = Right(telefonsz�m, Len(telefonsz�m) - 3)
                Case Else 'k�lf�ldi sz�m
                    telefonsz�mjav�t� = telefonsz�m
                    Exit Function
            End Select
        Case "0"
            Select Case Left(telefonsz�m, 2)
                Case "06" 'El�h�v�
                    telefonsz�m = Right(telefonsz�m, Len(telefonsz�m) - 2)
                Case "00" 'k�lf�ldi sz�m
                    telefonsz�mjav�t� = telefonsz�m
                    Exit Function
            End Select
    End Select
    
    
    '�talak�tjuk csak sz�mokra
    telefonsz�m = CsakSz�mJegy(telefonsz�m)
    'Ha t�l r�vid, akkor �res stringet adunk vissza �s kil�p�nk
    If Len(telefonsz�m) < 7 Then
        telefonsz�mjav�t� = "Hib�s sz�m:" & eredeti
        Exit Function
    End If
    'Ha h�tjegy�, akkor budapesti
    If Len(telefonsz�m) = 7 Then
        telefonsz�m = "1" & telefonsz�m
    End If
    
    'Ha az els� sz�mjegy 6, de a telefonsz�m t�bb, mint 7 jegy�
    If Len(telefonsz�m) > 7 Then
        Select Case Left(telefonsz�m, 2)
            Case "61" To "69"
                telefonsz�m = "+3" & telefonsz�m
            Case "06"
                telefonsz�m = "+36" & Right(telefonsz�m, Len(telefonsz�m) - 2)
            Case Else
                telefonsz�m = "+36" & telefonsz�m
        End Select
    Else
        
    End If
    'Form�zzuk
    Select Case Left(telefonsz�m, 4)
        Case "+361" 'Ez budapesti vezet�kes telefonsz�m
            telefonsz�m = "(" & Left(telefonsz�m, 4) & ") " & Mid(telefonsz�m, 5, 3) & "-" & Mid(telefonsz�m, 8, 4)
        Case Else 'Mobil vagy nem budapesti vezet�kes
            Select Case Left(telefonsz�m, 5)
                Case "+3620", "+3621", "+3630", "+3631", "+3640", "+3650", "+3651", "+3655", "+3660", "+3670", "+3680", "+3690", "+3691" 'Mobil
                    telefonsz�m = "(" & Left(telefonsz�m, 5) & ") " & Mid(telefonsz�m, 6, 3) & "-" & Mid(telefonsz�m, 9, 4)
                Case Else 'Vid�ki vezet�kes
                        telefonsz�m = "(" & Left(telefonsz�m, 5) & ") " & Mid(telefonsz�m, 6, 3) & "-" & Mid(telefonsz�m, 9, 3)
            End Select
    End Select
    'TODO:Kell ez egy�ltal�n?
    telefonsz�mjav�t� = telefonsz�m
End Function
Function teljav�t�(telsz�m As Variant) As String
'Mintaalap� feldolgoz�s
Dim i As Integer
Dim poz As Integer
Dim eredeti As String
Dim telefonsz�m As String
    If IsNull(telsz�m) Then
        teljav�t� = vbNullString
        Exit Function
    End If
    If IsArray(telsz�m) Then
        teljav�t� = vbnullsrting
        Exit Function
    End If
    If telsz�m = vbNullString Then
        teljav�t� = vbNullString
        Exit Function
    End If
    eredeti = CStr(telefonsz�m)
    On Error GoTo Hiba:
    telefonsz�m = CStr(telsz�m)
    telefonsz�m = Replace(telefonsz�m, "/", "$")
    telefonsz�m = Replace(telefonsz�m, " ", "$")
    telefonsz�m = Replace(telefonsz�m, "-", "$")
    telefonsz�m = Replace(telefonsz�m, "(", "$")
    telefonsz�m = Replace(telefonsz�m, ")", "$")
    telefonsz�m = Replace(telefonsz�m, "+", "$")
    telefonsz�m = Dupl�tlan�t�(telefonsz�m)
    teljav�t� = telefonsz�m
    
Exit Function
Hiba:
    If Err.Number = 1033 Then
        Resume Next
    Else
        MsgBox Hiba(Err)
    End If
End Function
Function Dupl�tlan�t�(sz�veg As String, Optional mit As String = "$") As String
    Do While StrCount(sz�veg, mit & mit) > 0
        sz�veg = Replace(sz�veg, mit & mit, mit)
    Loop
    Dupl�tlan�t� = sz�veg
End Function
Function felt�lt�(telefonsz�m As String) As String
Dim i As Integer
Dim kar As String
Dim Kimenet As String
telefonsz�m = teljav�t�(telefonsz�m)
    For i = 1 To Len(telefonsz�m)
        kar = Mid(telefonsz�m, i, 1)
        If kar <> "$" Then
            If kar = CStr(CsakSz�m(kar)) Then
                kar = "1"
            Else
                kar = vbNullString
            End If
        End If
        Kimenet = Kimenet & kar
    Next i
    felt�lt� = Kimenet
End Function
Function RegExExec(sz�veg As String, minta As String, Optional KisNagybet�NemSz�m�t As Boolean = True, Optional MindenTal�lat As Boolean = True) As MatchCollection
'FirstIndex - A read-only value that contains the position within the original string where the match occurred. _
              This index uses a zero-based offset to record positions, meaning that the first position in a string is 0.
'Length - A read-only value that contains the total length of the matched string.
'Value - A read-only value that contains the matched value or text. It is also the default value when accessing the Match object.
   Dim Matches    ' Create variable.

   With New RegExp
    .Pattern = minta   ' Set pattern.
    .IgnoreCase = KisNagybet�NemSz�m�t   ' Set case insensitivity.
    .Global = MindenTal�lat   ' Set global applicability.
    Set RegExExec = .Execute(sz�veg)   ' Execute search.
   End With
End Function
Function RegExTest(sz�veg As String, minta As String) As Boolean


End Function