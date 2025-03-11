Option Compare Database

Public Function TextToMD5Hex(sz�veg As String) As String
'Forr�s: https://stackoverflow.com/q/33704692
'Licence: https://creativecommons.org/licenses/by-sa/3.0/
'Nov 14, 2015 at 3:05 - user3791372
'�t�rva: 2024
    Dim enc
    Dim bytes
    Dim b�jtok() As Byte
    Dim outstr As String
    Dim pos As Integer
    Set enc = CreateObject("System.Security.Cryptography.MD5CryptoServiceProvider")
    '�talak�tjuk a sz�veget b�jtok l�ncolat�v�
    b�jtok = sz�veg
    bytes = b�jtok
    'Ha
    If UBound(bytes) = 0 Or IsNull(bytes) Then
        FileToMD5Hex = vbNullString
        Exit Function
    End If
    bytes = enc.ComputeHash_2((bytes))
    'Convert the byte array to a hex string
    For pos = 1 To LenB(bytes)
        outstr = outstr & LCase(Right("0" & Hex(AscB(MidB(bytes, pos, 1))), 2))
    Next
    TextToMD5Hex = outstr
    Set enc = Nothing
    
End Function