Option Compare Database





Private Sub Kereső_AfterUpdate()
'    Me.FilterOn = False
'    Me.Filter = "[lekérdezésNeve] = '" & Me.Kereső.Value & "'"
'    Me.FilterOn = True
Me.Requery

End Sub