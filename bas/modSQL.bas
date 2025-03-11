'E gy�tem�nyben, ha az MIT licencia eml�ttettik, (megjel�lve a szerz�t �s a m� sz�let�s�nek �v�t) azon az al�bbi felhaszn�l�si enged�lyt kell �rteni:

'Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"),
'to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software,
'and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
'The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
'THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
'FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
'WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
Option Compare Database
Public adatb�zis As Database
Public hierarchiaF�jlSz�ma As Integer
Sub lkInit(Optional ByRef Lek�rdez�sNeve As String = "")

    If adatb�zis Is Nothing Then
        Set adatb�zis = CurrentDb
    End If
    If hierarchiaF�jlSz�ma = 0 Then
        hierarchiaF�jlSz�ma = FreeFile
        f�jl = "L:\Ugyintezok\Adatszolg�ltat�k\Adatb�zisok\F�jlok\hiereachia." & Format(Now(), "yyyy-mm-dd-hh-nn-ss") & ".txt"
        Open f�jl For Output As #hierarchiaF�jlSz�ma
        If Lek�rdez�sNeve <> vbNullString Then Print #hierarchiaF�jlSz�ma, Lek�rdez�sNeve & ":"
    End If
        
End Sub
Sub lkClose()
    If Not adatb�zis Is Nothing Then
        Set adatb�zis = Nothing
    End If
    If hierarchiaF�jlSz�ma <> 0 Then
        Close #hierarchiaF�jlSz�ma
    End If
End Sub
Sub teljesLek�rdez�sHierarchia()
Dim gy�k�rt�bl�k As Variant, _
    mindenlev�l As Variant
Dim i As Integer

mindenlev�l = levelek

lkInit
    gy�k�rt�bl�k = gy�kerek()
    For i = LBound(gy�k�rt�bl�k) To UBound(gy�k�rt�bl�k)
        Print #hierarchiaF�jlSz�ma, Num2Roman(i + 1) & ". " & gy�k�rt�bl�k(i)
        lek�rdez�sGyemekKeres� (gy�k�rt�bl�k(i))
    Next i
lkClose
End Sub
Sub Lek�rdez�sSz�l�Keres�(lek�rdez�sN�v As String)
    Lek�rdez�sHierarchiaKeres� lek�rdez�sN�v:=lek�rdez�sN�v, _
                               gy�k�rfel�:=True, _
                               bek:=vbTab
End Sub
Sub lek�rdez�sGyemekKeres�(lek�rdez�sN�v As String)
    Lek�rdez�sHierarchiaKeres� lek�rdez�sN�v:=lek�rdez�sN�v, _
                                gy�k�rfel�:=False, _
                                bek:=vbTab
End Sub
Sub Lek�rdez�sHierarchiaKeres�(lek�rdez�sN�v As String, Optional bek As String = "", Optional m�lys�g As Integer = 1, Optional ByVal gy�k�rfel� As Boolean = False)
Dim a As String, _
    n�v As String
Dim i As Integer, _
    j As Integer, _
    n As Integer
Dim qdfs As QueryDefs
Dim t�bl�k() As Variant

    lkInit lek�rdez�sN�v
    
    'If j = 0 Then Print #hierarchiaF�jlSz�ma, lek�rdez�sN�v
    If m�lys�g > 20 Then Exit Sub
    j = 1
    t�bl�k = Lek�rdez�sekT�bl�k(lek�rdez�sN�v, gy�k�rfel�)
    For n = LBound(t�bl�k) To UBound(t�bl�k)
        n�v = t�bl�k(n)
        If n�v <> "" Then
            Print #hierarchiaF�jlSz�ma, bek & j & "." & n�v
            Lek�rdez�sHierarchiaKeres� n�v, bek & vbTab, m�lys�g + 1, gy�k�rfel�
        End If
        � j
        Debug.Print ".";
    Next n
    
    If m�lys�g = 1 Then
        Close #hierarchiaF�jlSz�ma
        hierarchiaF�jlSz�ma = 0
    End If
End Sub


Function Lek�rdez�sekT�bl�k(Lek�rdez�sNeve As String, Optional ByVal gy�k�rfel� As Boolean = False) As Variant
    Dim adat As DAO.Recordset
    Dim lek�rd As QueryDef
    Dim sqlString As String
    'Dim db As DAO.Database
    Dim Kimenet() As Variant
    Dim n As Integer
    
    ' inicializ�ljuk az adatb�zis, ha kell
    If adatb�zis Is Nothing Then
        Call lkInit
    End If
    
    If gy�k�rfel� Then
        sqlString = "SELECT DISTINCT MSysQueries.Name1 as N�v " & _
                    "   FROM MSysQueries " & _
                    "       INNER JOIN MSysObjects ON MSysQueries.ObjectId = MSysObjects.Id " & _
                    "           WHERE MSysQueries.Name1 IS NOT NULL " & _
                    "               AND MSysQueries.Attribute = 5 " & _
                    "               AND MSysObjects.Name = [lek�rdez�sN�v]"
    Else
        sqlString = "SELECT DISTINCT MSysObjects.Name as N�v " & _
                    "   FROM MSysQueries INNER JOIN MSysObjects ON MSysQueries.ObjectId = MSysObjects.Id " & _
                    "       WHERE (((MSysObjects.Name) Is Not Null) AND ((MSysQueries.Attribute)=5) AND ((MSysQueries.Name1)=[lek�rdez�sN�v]));"
    End If
    Set lek�rd = adatb�zis.CreateQueryDef("", sqlString)
    lek�rd("lek�rdez�sN�v") = Lek�rdez�sNeve
    Set adat = lek�rd.OpenRecordset(dbOpenSnapshot)
    
    If adat.RecordCount > 0 Then
        ReDim Kimenet(adat.RecordCount - 1)
    Else
        ReDim Kimenet(0)
    End If
    If Not adat.EOF Then
        n = 0
        Do While Not adat.EOF
            Kimenet(n) = Nz(adat!n�v, "")
            � n
            adat.MoveNext
        Loop
    End If
    
    adat.Close
    Set adat = Nothing
    Lek�rdez�sekT�bl�k = Kimenet
End Function
Function levelek() As Variant
fvbe ("levelek")
Dim db As Database
Dim qdKk As QueryDefs
Dim qdK As QueryDef, _
    qdB As QueryDef
Dim n�vK As String
Dim Kimenet() As Variant, _
    t�bl�k() As Variant
Dim n As Long
Dim lev�l As Boolean

Set db = CurrentDb
Set qdKk = db.QueryDefs

For Each qdK In qdKk

    lev�l = True
    n�vK = qdK.Name
    If Left(n�vK, 1) <> "~" Then 'ideiglenes lek�rdez�sekre nem futtatjuk, mert azokhoz nincs hozz�f�r�s�nk.
        t�bl�k = Lek�rdez�sekT�bl�k(qdK.Name)
        If UBound(t�bl�k) - LBound(t�bl�k) = 0 Then 'Ha nincs gyermeke, akkor lev�l
            ReDim Preserve Kimenet(n) 'megn�velj�k a t�mb�t
            Kimenet(n) = n�vK '�s bele�rjuk a tal�lt nevet
            � n
        End If
    End If
    � ".", Null
Next qdK
levelek = Kimenet
logba , Str(n - 1), 4
End Function
Function nSelect(strLek�rdNeve As String) As Integer
'#MIT Ol�h Zolt�n (c) 2023
'Megsz�molja, hogy egy lek�rdez�sben h�ny Select utas�t�s van.
'TODO: az id�z�jelben l�v� Select karaktersorozatok kisz�r�se: csak az ffsplit-tel kimetszett p�ratlan sorsz�m� r�szekben keresni
    nSelect = StrCount(CurrentDb.QueryDefs(strLek�rdNeve).sql, "SELECT")
End Function
Function LekSQL(lekn�v As String) As String
'#MIT Ol�h Zolt�n (c) 2023
    Dim dbLekSTR As DAO.Database
    
    Set dbLekSTR = CurrentDb
    LekSQL = dbLekSTR.QueryDefs(lekn�v).sql
    Set dbLekSTR = Nothing
    
End Function
Function SQLSz�p�t�(sql As String) As String
'#MIT Ol�h Zolt�n (c) 2023
    Dim k�dsz�k As Variant
    Dim bek As Integer
    Dim strbek As String
    Dim zrjl As Integer ' z�r�jelszint
    Dim ijl As Integer ' id�z�jel szint
    Dim i As Integer
    Dim ker As String
    strbek = "     "
    k�dsz�k = "SELECT;FROM;WHERE;GROUP BY;ORDER BY;"

    For i = 1 To StrCount(k�dsz�k, ";") + 1
        ker = ffsplit(k�dsz�k, ";", i)

        sql = Replace(sql, ker, vbNewLine & sz�vegF�z�(strbek, bek) & ker)
        If ker = "SELECT" Then
            bek = bek + 1
        End If

    Next i
    sql = Replace(sql, vbNewLine & vbNewLine, vbNewLine)
    SQLSz�p�t� = sql
End Function
Function gy�kerek() As Variant
Dim db As Database
Dim qdKk As QueryDefs
Dim qdK As QueryDef, qdB As QueryDef
Dim n�vK As String
Dim qdKSQL As String
Dim n�vB As String
Dim Kimenet() As Variant
Dim n As Long
Dim bRoot As Boolean

Set db = CurrentDb
Set qdKk = db.QueryDefs
For Each qdK In qdKk
    n�vK = qdK.Name
    If Not Left(n�vK, 4) = "~sq_" Then
        qdKSQL = qdK.sql
        bRoot = True
        For Each qdB In qdKk
            n�vB = qdB.Name
            If InStr(1, qdKSQL, n�vB) Then 'Ha a vizsg�lt lek�rdez�s neve szerepel a k�ls� SQL-j�ben,
                bRoot = False 'akkor a k�ls� m�r biztosan nem gy�k�r
                Exit For ' �s akkor m�r tov�bb keresg�lni sem �rdemes
            End If
        Next qdB
        If bRoot Then 'Ha az egyik lek�rdez�snek a neve sem szerepel a k�ls� lek�rdez�sben,
            
            ReDim Preserve Kimenet(n)
            Kimenet(n) = n�vK 'akkor a k�ls� lek�rdez�s egy gy�k�r.
            � n ' = n + 1
            logba , n�vK, 3
        End If
    End If
Next qdK
logba , Str(n), 4
gy�kerek = Kimenet
End Function

Function fvCaseSelect(ByVal vizsg�land�, _
                        ByVal els�Eset, _
                        ByVal els�Eredm�ny, _
                        Optional ByVal m�sodEset = "else", _
                        Optional ByVal m�sodEredm�ny = "", _
                        Optional ByVal harmadEset = "else", _
                        Optional ByVal harmadEredm�ny = "", _
                        Optional ByVal negyedEset = "else", _
                        Optional ByVal negyedEredm�ny = "")
Dim Kimenet

    If IsNull(m�sodEset) _
    Then m�sodEset = "else"
    
    If IsNull(harmadEset) _
    Then harmadEset = "else"
    
    If IsNull(vizsg�land�) _
        Or IsNull(els�Eset) _
        Or IsNull(els�Eredm�ny) _
        Or IsNull(m�sodEredm�ny) _
        Or IsNull(harmadEredm�ny) _
    Then
        Exit Function
    End If
    
    If m�sodEset = "else" Then
        Select Case vizsg�land�
            Case els�Eset
                Kimenet = els�Eredm�ny
            Case Else
                Kimenet = m�sodEredm�ny
        End Select
    ElseIf harmadEset = "else" Then
        Select Case vizsg�land�
            Case els�Eset
                Kimenet = els�Eredm�ny
            Case m�sodEset
                Kimenet = m�sodEredm�ny
            Case Else
                Kimenet = harmadEredm�ny
        End Select
    Else
        Select Case vizsg�land�
            Case els�Eset
                Kimenet = els�Eredm�ny
            Case m�sodEset
                Kimenet = m�sodEredm�ny
            Case harmadEset
                Kimenet = harmadEredm�ny
            Case Else
                Kimenet = negyedEredm�ny
        End Select
    End If
    fvCaseSelect = Kimenet
End Function
Function sTrim(sz�veg As String, Optional elv�laszt� As String = ",")
Dim elvhossz As Integer

elvhossz = Len(elv�laszt�)
    If Right(sz�veg, elvhossz) = elv�laszt� Then
        sz�veg = Left(sz�veg, Len(sz�veg) - elvhossz)
        sz�veg = sTrim(sz�veg, elv�laszt�)
    End If
    sTrim = sz�veg
End Function
Function sBubor�k(strHash As String, db As Database) As String
    Dim lek As QueryDef
    Dim rekordok As Recordset
    Dim sor As Record
    Dim sorsz�m As Long
    Dim Kimenet As String
    
    Set lek = db.CreateQueryDef("", "SELECT lk�zenetekVisszajelz�sek01.Hash, lk�zenetekVisszajelz�sek01.SenderEmailAddress, lk�zenetekVisszajelz�sek01.DeliveredDate, tVisszajelz�sT�pusok.Visszajelz�sK�d, tVisszajelz�sT�pusok.Visszajelz�sSz�vege, lk�zenetekVisszajelz�sek01.Hat�ly FROM lk�zenetekVisszajelz�sek01 WHERE (((lk�zenetekVisszajelz�sek01.HASH) = [Azonos�t�HASH])) ORDER BY lk�zenetekVisszajelz�sek01.Hash, lk�zenetekVisszajelz�sek01.DeliveredDate;")
    lek("Azonos�t�HASH") = strHash
    Set rekordok = lek.OpenRecordset(dbOpenSnapshot)
    
        Kimenet = "<table class=""buborektabla"">" & vbNewLine & _
                  "     <thead>" & vbNewLine & _
                  "         <tr class=""buborekfejsor""><th class=""buborekcella"">Visszajelz�s id�pontja</th><th class=""buborekcella"">Visszajelz�</th><th class=""buborekcella"">�llapot</th><th class=""buborekcella"">Hat�lya</th></tr>" & vbNewLine & _
                  "     </thead>" & vbNewLine & _
                  "     <tbody>" & vbNewLine
        
        If rekordok.RecordCount Then
            rekordok.MoveFirst
        Else
            Kimenet = Kimenet & "         <tr class=""buboreksor""><td class=""buborekcella"" colspan=""4"">M�g nincs t�rt�net...</td></tr>"
        End If
        Do While Not rekordok.EOF
            Kimenet = Kimenet & "         <tr class=""buboreksor"">" & vbNewLine
                Kimenet = Kimenet & "           <td class=""buborekcella"">" & rekordok("delivereddate") & "</td><td class=""buborekcella"">" & rekordok("SenderEmailAddress") & "</td><td class=""buborekcella"">" & rekordok("Visszajelz�sSz�vege") & "</td><td class=""buborekcella"">" & rekordok("hat�ly") & "</td>" & vbNewLine
            Kimenet = Kimenet & "         </tr>" & vbNewLine
            rekordok.MoveNext
        Loop
        
        Kimenet = Kimenet & "     </tbody>" & vbNewLine & "</table>"
    sBubor�k = Kimenet
End Function
Sub tegnapiLek()
Dim a As Date
    For i = 0 To CurrentDb.QueryDefs.count - 9
        a = CurrentDb.QueryDefs(i).DateCreated
        If a > Date - 5 Then
            Debug.Print a, CurrentDb.QueryDefs(i).Name
        End If
    Next
    � "---"
End Sub

Sub lek�rdez�sekbenCser�l�(keresend�Sz�veg As String, Optional ByVal csereSz�veg As String = "-")
Dim a As String
Dim i As Integer, _
    j As Integer

    For i = 0 To CurrentDb.QueryDefs.count - 1
        a = CurrentDb.QueryDefs(i).sql
        If InStr(1, a, keresend�Sz�veg) > 0 Then
            � j
            If csereSz�veg <> "-" Then
                'CurrentDb.QueryDefs(i).sql = Replace(a, keresend�Sz�veg, csereSz�veg)
            End If
            Debug.Print j & ";" & CurrentDb.QueryDefs(i).Name '& vbNewLine
        Else
            'Debug.Print ".";
        End If
    Next
End Sub

Sub adatm�dos�t�(t�blan�v As String, mez�n�v As String, WHERE As String, �j�rt�k As Variant)
Dim dbm�d As Database, sql As String, lek As QueryDef
    Set dbm�d = CurrentDb
    sql = "UPDATE [" & t�blan�v & "]" & vbNewLine & _
          " SET [" & mez�n�v & "] = " & �j�rt�k & vbNewLine & _
          " WHERE " & WHERE & ";"
    Set lek = dbm�d.CreateQueryDef("", sql)
    lek.Execute
    Debug.Print sql
    Set lek = Nothing
    Set dbm�d = Nothing
End Sub

Function lek�rdez�sKeres�(lek�rdez�sN�vR�szlet As String, Optional ByRef lista As Variant) As Long
Dim sz�m As Long
    For Each qry In CurrentDb.QueryDefs
        If InStr(1, qry.Name, lek�rdez�sN�vR�szlet) Then
            � sz�m
            ReDim lista(sz�m)
            lista(sz�m) = qry.Name
        End If
    Next
lek�rdez�sKeres� = sz�m
End Function
Function sqlbenKeres�(keresettSz�veg As String) As Variant
Dim Kimenet() As String
Dim qry As QueryDef
Dim sz�ml�l� As Integer

For Each qry In CurrentDb.QueryDefs
    If InStr(1, qry.sql, keresettSz�veg) Then
        � sz�ml�l�
        ReDim Preserve Kimenet(sz�ml�l�)
        Kimenet(sz�ml�l�) = qry.Name
        Debug.Print qry.Name
    End If
Next qry
sqlbenKeres� = Kimenet
End Function