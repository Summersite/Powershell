function GetDirs($path = $pwd, [Byte]$ToDepth = 255, [Byte]$CurrentDepth = 0)
{
    $CurrentDepth++
    If ($CurrentDepth -le $ToDepth) {
        foreach ($item in Get-ChildItem $path)
        {
            if (Test-Path $item.FullName -PathType Container)
            {
                "." * $CurrentDepth + $item.FullName
                GetDirs $item.FullName -ToDepth $ToDepth -CurrentDepth $CurrentDepth
            }
        }
    }
}


$StartLevel = 1 # 0 = include base folder, 1 = sub-folders only, 2 = start at 2nd level
$Depth = 6      # How many levels deep to scan
$Path = "."     # starting path

For ($i=$StartLevel; $i -le $Depth; $i++) {
    $Levels = "\*" * $i
    (Resolve-Path $Path$Levels).ProviderPath | Get-Item | Where PsIsContainer |
    Select FullName
}