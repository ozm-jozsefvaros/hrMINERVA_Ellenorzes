Option Compare Database
Public Type v�ltoz�
    n�v As String
    �rt�k As Variant
End Type
Public v�lt1 As v�ltoz�
Public v�lt2 As v�ltoz�
Public v�lt3 As v�ltoz�

Function �resE(Ellen�rizend�V�ltoz� As v�ltoz�) As Boolean
    �resE = Nz(Ellen�rizend�V�ltoz�.�rt�k, vbNullString) = vbNullString _
            And Nz(Ellen�rizend�V�ltoz�.n�v, vbNullString) = vbNullString
'Dim v�lasz As Boolean
'    v�lasz = False
'        If Nz(Ellen�rizend�V�ltoz�.�rt�k, vbNullString) = vbNullString _
'            And Nz(Ellen�rizend�V�ltoz�.n�v, vbNullString) = vbNullString _
'            Then _
'                v�lasz = True
'
'    �resE = v�lasz
End Function
Function Hiba(error As ErrObject) As String
'******************************************************************
' Ez a f�ggv�ny kezeli a hib�kat, napl�zza a r�szleteket, �s visszaadja a hiba�zenetet.
' Az elj�r�s �sszegy�jti �s form�zza a hib�val kapcsolatos inform�ci�kat, bele�rtve a v�ltoz�k �rt�keit �s a megh�v�si hierarchi�t.
'
' Param�terek:
' - error: ErrObject - Az el�fordult hib�t le�r� objektum.
'
' Megh�vott elj�r�sok:
' 1. �resE(ByVal v�lt As Variant) As Boolean
'    - Le�r�s: Ellen�rzi, hogy a megadott v�ltoz� �res-e.
'    - Param�terek:
'      * v�lt: A vizsg�land� v�ltoz�.
'    - Visszat�r�si �rt�k: True, ha a v�ltoz� �res; k�l�nben False.
'
' 2. logba(ByVal Bejegyz�sT�rgya As String, ByVal bejegyz�s As String, ByVal logszint As Integer)
'    - Le�r�s: �zenetet �r a napl�ba.
'    - Param�terek:
'      * Bejegyz�sT�rgya: A napl�z�s t�rgya.
'      * bejegyz�s: A napl�z�sra ker�l� �zenet.
'      * logszint: A napl�z�s szintje.
'
' Visszat�r�si �rt�k:
' - String: A form�zott hiba�zenet.
'
' P�da a haszn�latra:
' hiba:
'   v�lt1.n�v = "intDb" ' az 1. v�ltoz� neve
'   v�lt1.�rt�k = "23" '<- az 1. v�ltoz� �rt�ke
'   ...
'   MsgBox hiba Err
'******************************************************************
'
Dim Bejegyz�s As String, _
    fvn�v As Variant
Dim n As Long
Dim Mind�res As Boolean
Mind�res = True


If intLoglevel >= 2 Then
    '# V�ltoz�k felsorol�sa
    If Not �resE(v�lt1) Then
        Mind�res = False
        Bejegyz�s = Bejegyz�s & _
                    v�lt1.n�v & ":  " & v�lt1.�rt�k & vbNewLine
    End If
    If Not �resE(v�lt2) Then
        Mind�res = False
        Bejegyz�s = Bejegyz�s & _
                    v�lt2.n�v & ":  " & v�lt2.�rt�k & vbNewLine
    End If
    If Not �resE(v�lt3) Then
        Mind�res = False
        Bejegyz�s = Bejegyz�s & _
                    v�lt3.n�v & ":  " & v�lt3.�rt�k & vbNewLine
    End If
    If Not Mind�res Then _
        Bejegyz�s = "V�ltoz�k:" & vbNewLine & Bejegyz�s
    ''# A megh�v�si hierarchi�ban feljebb l�v� f�ggv�nyek list�ja
    n = colFvN�v.count
    For Each fvn�v In colFvN�v
        n = n - 1
        Bejegyz�s = Bejegyz�s & vbNewLine & n & ": " & fvn�v
    Next fvn�v
End If
        Bejegyz�s = "A hiba sz�ma:  " & error.Number & vbNewLine & _
                    "A hiba le�r�sa:" & error.Description & vbNewLine & _
                    "Forr�sa:       " & error.Source & vbNewLine & _
                    "A fels�bb szint� megh�v� fv-ek:" & vbNewLine & _
                    Bejegyz�s

    Flush = True
    logba Bejegyz�sT�rgya:=sFN, _
          Bejegyz�s:=Bejegyz�s, _
          logszint:=0
    Hiba = Bejegyz�s
                    
End Function
 Public Sub Pr�ba()
10       fvbe ("Pr�ba")
20       Dim a As Integer

30       On Error GoTo Hiba
31      For i = 1 To 100
32             a = 1 / 0
33  Next
50 Hiba:
60       v�lt1.n�v = "a"
62       v�lt1.�rt�k = a
63       MsgBox Hiba(Err) & vbNewLine & Erl
59       fvki
90 End Sub