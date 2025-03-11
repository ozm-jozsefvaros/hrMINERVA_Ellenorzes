'E gy�tem�nyben, ha az MIT licencia eml�ttettik, (megjel�lve a szerz�t �s a m� sz�let�s�nek �v�t) azon az al�bbi felhaszn�l�si enged�lyt kell �rteni:

'Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"),
'to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software,
'and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
'The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
'THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
'FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
'WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
Option Compare Database

Function XML�talak�t�(strXMLneve As String, �jPath As String) As Boolean
    Dim strXML As String
    Dim strR�giF�jl As String
    Dim str�jF�jl As String
    Dim intKezdPoz As Integer
    Dim intV�gPoz As Integer
'on error goto hiba


'#           Az eg�sz tag-et (z�rad�kot?) cser�lj�k az XML-ben
        str�jF�jl = " Path=""" & �jPath & """"
'           Debug.Print "1. �j f�jl:" & str�jF�jl & "##" '1
        strXML = xmltiszt�t�(XMLsz�veg(strXMLneve, False)) 'itt megszerezz�k �s megtiszt�tjuk

        intKezdPoz = InStr(1, strXML, "Path=") 'majd megn�zz�k, hol kezd�dik az �tvonal
        intV�gPoz = InStr(intKezdPoz + 7, strXML, """") ' �s hogy hol a v�ge
'          Debug.Print "2. R�gi XML:##" & Mid(strXML, intKezdPoz, intV�gPoz) & "##" '2
        strR�giF�jl = Mid(strXML, intKezdPoz, intV�gPoz - intKezdPoz + 1) 'a k�t pont k�z�tti r�szt kiemelj�k
'           Debug.Print "3. R�gi f�jl:" & strR�giF�jl
        strXML = Replace(strXML, strR�giF�jl, str�jF�jl) 'no itt meg kicser�lj�k a r�gi f�jlnevet, az �jra
'           Debug.Print "4. �j XML:##" & Mid(strXML, intKezdPoz - 10, Len(str�jF�jl) + 16) & "##"
        CurrentProject.ImportExportSpecifications.item(strXMLneve).XML = strXML '�s v�g�l visszat�ltj�k a rendszerbe
XML�talak�t� = True
Exit Function
Hiba:

End Function

Public Function xmltiszt�t�(ByVal sz�veg As String) As String
    Dim vMir�lMire(2, 1) As Variant
    Dim n As Integer
    
    vMir�lMire(0, 0) = " =": vMir�lMire(0, 1) = "="
    vMir�lMire(1, 0) = "= ": vMir�lMire(1, 1) = "="
    For i = LBound(vMir�lMire, 1) To UBound(vMir�lMire, 1)
        n = 0
        If vMir�lMire(i, 0) <> "" Then
            Do While InStr(1, sz�veg, vMir�lMire(i, 0))
                sz�veg = Replace(sz�veg, vMir�lMire(i, 0), vMir�lMire(i, 1))
                n = n + 1
                If n > 100 Then Exit Do
            Loop
        End If
    Next i
    Do While InStr(1, sz�veg, "  path") > 0
        sz�veg = Replace(sz�veg, "  Path", " Path")
    Loop
    
    xmltiszt�t� = sz�veg
End Function
Function XMLsz�veg(strXMLneve As String, Optional elej�t As Boolean = True, Optional mennyit As Long = 2000) As String
On Error GoTo Hiba:
    If elej�t Then
        XMLsz�veg = Left(CurrentProject.ImportExportSpecifications.item(strXMLneve).XML, mennyit)
    Else
        XMLsz�veg = CurrentProject.ImportExportSpecifications.item(strXMLneve).XML
    End If
Exit Function
Hiba:
    If Err.Number = 31602 Then
        XMLsz�veg = vbNullString
        Exit Function
    End If
    Resume Next
End Function
