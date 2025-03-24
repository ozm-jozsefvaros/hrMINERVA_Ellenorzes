Option Explicit

Private stream As Object
Private filePath As String

' Initialize the stream and set the file path
Public Sub Init(ByVal path As String)
    Set stream = CreateObject("ADODB.Stream")
    filePath = path
    
    stream.Type = 2  ' adTypeText (Text mode)
    stream.Charset = "UTF-8" ' Set UTF-8 encoding
    stream.Open
End Sub

' Equivalent to .WriteText but with a newline
Public Sub WriteLine(ByVal text As String)
    stream.WriteText text, 1  ' 1 means append a newline
End Sub

' Equivalent to .WriteText without a newline (optional)
Public Sub WriteText(ByVal text As String)
    stream.WriteText text
End Sub

' Save and close the file
Public Sub Cl()
    If Not stream Is Nothing Then
        stream.SaveToFile filePath, 2 'adSaveCreateOverWrite 'And adSaveCreateNotExist  ' 2 = Overwrite mode
        stream.Close
        Set stream = Nothing
    End If
End Sub
' Flush method to save progress without closing the stream
Public Sub Flush()
    If Not stream Is Nothing Then
        stream.SaveToFile filePath, adSaveCreateOverWrite And adSaveCreateNotExist  ' Save without closing
        stream.Position = stream.Size  ' Move to end to avoid overwriting
    End If
End Sub
Public Sub SetEncoding(ByVal encoding As String)
    If Not stream Is Nothing Then
        stream.Close ' Close the stream before changing the encoding
    End If
    stream.Charset = encoding ' Set the new encoding
    stream.Open ' Reopen the stream with the new encoding
End Sub

' Get the current encoding
Public Function GetEncoding() As String
    If Not stream Is Nothing Then
        GetEncoding = stream.Charset ' Return the current encoding
    Else
        GetEncoding = "Stream not initialized"
    End If
End Function