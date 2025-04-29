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
    On Error GoTo EncodingError ' Enable error handling

    Dim pos As Long
    If Not stream Is Nothing Then
        ' Save the current position if the stream is open
        If stream.Position > 0 Then
            pos = stream.Position
            stream.Position = 0 ' Reset position to the beginning
        End If
        
        ' Change the encoding
        stream.Charset = encoding
        
        ' Restore the position if it was moved
        If pos > 0 Then
            stream.Position = pos
        End If
    Else
        MsgBox "Stream is not initialized. Cannot set encoding.", vbExclamation, "Encoding Error"
    End If
    Exit Sub

EncodingError:
    MsgBox Hiba(err)
    Err.Clear ' Clear the error
End Sub

' Get the current encoding
Public Function GetEncoding() As String
    On Error GoTo EncodingError ' Enable error handling

    If Not stream Is Nothing Then
        GetEncoding = stream.Charset ' Return the current encoding
    Else
        GetEncoding = "Stream not initialized" ' Feedback if the stream is not initialized
    End If
    Exit Function ' Exit cleanly if no error occurs

EncodingError:
    MsgBox Hiba(err)
    GetEncoding = "Error retrieving encoding" ' Return a fallback value in case of an error
    Err.Clear ' Clear the error
End Function