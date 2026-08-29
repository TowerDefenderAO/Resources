# Vuelve a generar los recortes de iconos a partir de la lámina y de iconos.json.
#
#   powershell -ExecutionPolicy Bypass -File recortar.ps1
#
# No detecta nada: usa las coordenadas ya guardadas. Si la lámina cambia, hay que
# recalcular la grilla primero (ver README.md).
#
# ⚠ Este archivo se guarda en UTF-8 CON BOM a propósito: Windows PowerShell 5.1 lee
#   los .ps1 sin BOM como ANSI y se come los acentos.

Add-Type -AssemblyName System.Drawing

$raiz    = Split-Path -Parent $MyInvocation.MyCommand.Path
$indice  = Join-Path $raiz "iconos.json"
if (-not (Test-Path $indice)) { throw "falta iconos.json en $raiz" }

# El JSON lleva comentarios `//`, igual que los de Client\Data\. ConvertFrom-Json de
# PS 5.1 no los tolera, así que se sacan antes (solo los de línea entera, que son los
# únicos que hay).
$texto = [System.IO.File]::ReadAllText($indice, [System.Text.Encoding]::UTF8)
$texto = ($texto -split "`r?`n" | Where-Object { $_.TrimStart() -notmatch '^//' }) -join "`n"
$datos = $texto | ConvertFrom-Json

$lamina = Join-Path $raiz $datos.fuente
if (-not (Test-Path $lamina)) { throw "falta la lámina $($datos.fuente)" }
$bmp = New-Object System.Drawing.Bitmap $lamina

$n = 0
foreach ($seccion in $datos.secciones.PSObject.Properties) {
    $dir = Join-Path $raiz $seccion.Name
    if (-not (Test-Path $dir)) { New-Item -ItemType Directory -Path $dir | Out-Null }

    foreach ($icono in $seccion.Value.PSObject.Properties) {
        $i = $icono.Value
        $recorte = New-Object System.Drawing.Bitmap $i.lado, $i.lado
        $g = [System.Drawing.Graphics]::FromImage($recorte)
        $src = New-Object System.Drawing.Rectangle $i.x, $i.y, $i.lado, $i.lado
        $dst = New-Object System.Drawing.Rectangle 0, 0, $i.lado, $i.lado
        $g.DrawImage($bmp, $dst, $src, [System.Drawing.GraphicsUnit]::Pixel)
        $g.Dispose()
        $recorte.Save((Join-Path $raiz ($i.archivo -replace '/', '\')), [System.Drawing.Imaging.ImageFormat]::Png)
        $recorte.Dispose()
        $n++
    }
}
$bmp.Dispose()
Write-Output "$n iconos regenerados"
