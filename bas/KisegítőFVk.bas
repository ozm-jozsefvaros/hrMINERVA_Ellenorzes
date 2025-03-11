'E gy�tem�nyben, ha az MIT licencia eml�ttettik, (megjel�lve a szerz�t �s a m� sz�let�s�nek �v�t) azon az al�bbi felhaszn�l�si enged�lyt kell �rteni:

'Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"),
'to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software,
'and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
'The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
'THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
'FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
'WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
Option Compare Database
Public Const � As String = ";"
Function �(sz�veg, Optional t�vtart� As Variant = "")
'##########
'# Ol�h Zolt�n (c) 2024 MIT
    t�vtart� = Left(t�vtart�, 1)
    Select Case t�vtart�
        Case ";"
            Debug.Print sz�veg;
        Case ","
            Debug.Print sz�veg,
        Case Else
            Debug.Print sz�veg
    End Select
End Function
Function N�(�rt�k As Variant, �rt�kha�res As Variant) As Variant
'##########
'# Ol�h Zolt�n (c) 2024 MIT
'# Ha az �rt�k �res (Null, "" vagy 0), akkor az �rt�kha�res �rt�k�t adja vissza, egy�bk�nt az �rt�ket.
'# Akkor haszn�lhat�, ha nem tudjuk, hogy a vizsg�lt �rt�k hogyan �res, de szeretn�nk helyette egy m�sik �rt�ket.
'##########
    If IsObject(�rt�k) Then
        If IsEmpty(�rt�k) Then
            If IsObject(�rt�kha�res) Then
                Set N� = �rt�kha�res
            Else
                N� = �rt�kha�res
            End If
        Else
           Set N� = �rt�k
        End If
        Exit Function
    End If
    If IsNull(�rt�k) Or �rt�k = vbNullString Or �rt�k = 0 Then
        If IsObject(�rt�kha�res) Then
            Set N� = �rt�kha�res
        Else
            N� = �rt�kha�res
        End If
        Exit Function
    End If
    N� = �rt�k
End Function

Function �(ByRef n�velend� As Variant)
    On Error GoTo Hiba
        n�velend� = N�(n�velend�, 0)
        n�velend� = CLng(n�velend�) + 1
         � = n�velend�
    Exit Function
Hiba:
    Select Case Err.Number
        Case 13
            n�velend� = 1
        Case Else
            MsgBox Hiba(Err)
    End Select
   
End Function
Function �_(n�velend� As Long)

End Function
Function �(ByRef cs�kkentend� As Long)
    On Error GoTo Hiba
        cs�kkentend� = N�(cs�kkentend�, 0)
        cs�kkentend� = CLng(cs�kkentend�) - 1
        � = cs�kkentend�
    Exit Function
Hiba:
    Select Case Err.Number
        Case 13
            cs�kkentend� = 1
        Case Else
            MsgBox Hiba(Err)
    End Select
End Function
Function �(Optional ByRef megism�tlend� As Variant = Null)
If Not IsNull(megism�tlend�) Then _
    megism�tlend� = megism�tlend� & megism�tlend�
    � = megism�tlend�
End Function
Function t�mbDim(ByVal t�mb As Variant) As Integer
'#MIT Ol�h Zolt�n (c) 2024
'# Egy t�mb dimenzi�inak a sz�m�t adja vissza
    Dim dimSz�m As Long
    On Error GoTo Eredm�ny
    dimSz�m = 1
    Do While LBound(t�mb, dimSz�m) Or True
        � dimSz�m
    Loop: Exit Function
Eredm�ny:
    � dimSz�m
    t�mbDim = dimSz�m
End Function

Function vane(teljes�tvonal As String) As Boolean
    vane = (Dir(teljes�tvonal) <> vbNullString)
End Function

Function �tvonalK�sz�t�(ByVal �tvonal As String, ByVal f�jln�v As String)
'****** (c) Ol�h Zolt�n 2022 - MIT Licence ****************
Dim per As String
    per = Right(�tvonal, 1)
    'Debug.Print �tvonal, per
    
    If per <> "\" Then
        per = "\"
    Else
        per = ""
    End If
    'Debug.Print "per = " & per
    �tvonalK�sz�t� = �tvonal & per & f�jln�v
End Function

Function p�rkeres�(ByRef t�mb As Variant, keresett As Variant, Optional hanyadik As Integer = 2) As Variant
'******************************************************************
'
' Ez a f�ggv�ny megkeresi a megadott �rt�ket (keresett) egy k�tdimenzi�s t�mb els� oszlop�ban, �s visszaadja
' a keresett elemhez tartoz� p�rj�t a t�mb egy m�sik oszlop�b�l (a hanyadik param�ter szerint).
'
' Param�terek:
' - t�mb (ByRef Variant): A k�tdimenzi�s t�mb, amelyben a keres�st v�gezz�k. Az els� oszlopban keresi a keresett �rt�ket.
' - keresett (Variant): Az az �rt�k, amelyet a t�mb els� oszlop�ban keres�nk.
' - hanyadik (Optional Integer): Az oszlop sz�ma, amelyb�l a keresett �rt�khez tartoz� p�rt visszaadjuk. Alap�rtelmezett �rt�ke 2.
'
' M�k�d�s:
' - A f�ggv�ny v�gigmegy a t�mb els� oszlop�n, �s ha megtal�lja a keresett �rt�ket, visszaadja annak p�rj�t a megadott oszlopb�l.
' - Ha nem tal�lja a keresett �rt�ket, akkor 0-t ad vissza.
'
' Visszat�r�si �rt�k:
' - Variant: A keresett �rt�khez tartoz� elem a megadott oszlopb�l, vagy 0, ha a keresett �rt�k nem tal�lhat�.
'
'******************************************************************
    For i = 1 To UBound(t�mb, 1)
        If t�mb(i, 1) = keresett Then
            p�rkeres� = t�mb(i, hanyadik)
            Exit Function ' Kil�p, ha tal�ltunk
        End If
    Next i
    'Ha nem tal�ltunk, �resen t�r vissza
    p�rkeres� = 0
End Function



Function LS(ByVal str1 As String, ByVal str2 As String) As Integer 'Levenshtein t�vols�g sz�m�t�sa
    Dim arrLev, intLen1 As Integer, intLen2 As Integer, i As Integer
    Dim j, arrStr1, arrStr2, intMini As Integer
 
    intLen1 = Len(str1)
    ReDim arrStr1(intLen1 + 1)
    intLen2 = Len(str2)
    ReDim arrStr2(intLen2 + 1)
    ReDim arrLev(intLen1 + 1, intLen2 + 1)
 
    arrLev(0, 0) = 0
    For i = 1 To intLen1
        arrLev(i, 0) = i
        arrStr1(i) = Mid(str1, i, 1)
    Next
 
    For j = 1 To intLen2
        arrLev(0, j) = j
        arrStr2(j) = Mid(str2, j, 1)
    Next
 
    For j = 1 To intLen2
        For i = 1 To intLen1
            If arrStr1(i) = arrStr2(j) Then
                arrLev(i, j) = arrLev(i - 1, j - 1)
            Else
                intMini = arrLev(i - 1, j) 'deletion
                If intMini > arrLev(i, j - 1) Then intMini = arrLev(i, j - 1) 'insertion
                If intMini > arrLev(i - 1, j - 1) Then intMini = arrLev(i - 1, j - 1) 'deletion
 
                arrLev(i, j) = intMini + 1
            End If
        Next
    Next
 
    LS = arrLev(intLen1, intLen2)
End Function


Function Lej�rat(perc As Integer) As Date
    Dim id� As Date
    
    id� = Now()
    Lej�rat = TimeSerial(Hour(id�), Minute(id�) + perc, Second(id�))
    
End Function
Function felhaszn�l�()
    felhaszn�l� = Environ("USERNAME")
End Function
Function szg�p()
    szg�p = Environ("Computername")
End Function
Function g�p()
    g�p = Environ("Computername")
End Function

Sub v�rakoz�s(Optional mp As Integer = 1)
'M�sodpercben megadott ideig v�rakozik, k�zben f�l mp-nk�nt visszaadja a vez�rl�st...
Dim tMost As Variant
Dim tK�v As Variant
    tV�r = Time
    tV�r = DateAdd("s", mp, tV�r)
    tK�v = DateAdd("s", 1, tMost)
    Do Until tMost >= tV�r
        tMost = Time
        If tMost > tK�v Then
            tK�v = DateAdd("s", 0.5, tMost)
            DoEvents
        End If
    Loop
End Sub
Sub Status(pstrStatus As String)
    
    Dim lvarStatus As Variant
    
    If pstrStatus = "" Then
        lvarStatus = SysCmd(acSysCmdClearStatus)
    Else
        lvarStatus = SysCmd(acSysCmdSetStatus, pstrStatus)
    End If
    
End Sub
