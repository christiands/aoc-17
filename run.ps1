param(
    [parameter(Mandatory=$true)]
    [string]$FileName
    )

dmd ".\src\$FileName.d"
Invoke-Expression ".\$FileName.exe"
rm ".\$FileName.exe"
rm ".\$FileName.obj"