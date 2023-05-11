cd .

set exename=python-3.8.8-amd64.exe
set downurl=https://registry.npmmirror.com/-/binary/python/3.8.8/python-3.8.8-amd64.exe
powershell curl -o "%exename%" "%downurl%"

start cmd /k "%exename%"

del /F /S /Q "%exename%"