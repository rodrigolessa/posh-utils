#runs Notepad.exe using the Static Start method and opens a file test.txt
[Diagnostics.Process]::Start("notepad.exe","test.txt")