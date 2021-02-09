param($add)

$reg='Registry::HKEY_CURRENT_USER\Environment'

$path=(Get-Item -Path $reg).GetValue('Path')

if (-not $path.Contains($add)) {
    $path="$add;$path"
    New-ItemProperty -Force -Path $reg -Name Path -PropertyType ExpandString -Value $path
}