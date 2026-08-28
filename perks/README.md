# Iconos de perks

Los 69 iconos de la lámina que entregó el diseñador, recortados de a uno.

La lámina **`img perks grilla.png`** (1536×1024) es el original y no se borra: los
recortes salen de ahí y se pueden volver a generar en cualquier momento con
`recortar.ps1`, que lee las coordenadas de `iconos.json`. Si el diseñador manda una
lámina nueva, hay que volver a detectar la grilla — las coordenadas guardadas son de
**esta** lámina.

## Qué hay

| Carpeta | Cuántos | Qué es |
|---|---|---|
| `comunes\` | 8 | Perks comunes (marco gris) |
| `infrecuentes\` | 6 | Perks infrecuentes (marco verde) |
| `raros\` | 8 | Perks raros (marco azul) |
| `epicos\` | 6 | Perks épicos (marco morado) |
| `legendarios\` | 8 | Perks legendarios (marco dorado) |
| `unicos\` | 6 | Perks únicos / especiales (marco rojo) |
| `meta\` | 8 | Perks meta / otros (marco teal) |
| `auras\` | 6 | Auras / soporte (marco teal) |
| `overlays\` | 6 | Marcadores opcionales para superponer: stack, mejora, temporal, área, aura, pasivo |
| `fondos\` | 6 | El marco vacío de cada rareza, sin icono adentro |
| `ejemplo\` | 1 | La muestra de «equipado» que trae la lámina, con su estrella |

`iconos.json` los lista todos con la etiqueta que la lámina trae escrita debajo y las
coordenadas `x`, `y`, `lado` dentro de la lámina.

## Cómo salió el recorte

Cada icono se recortó **cuadrado y centrado en el marco, con el resplandor incluido**.
El lado no es el mismo en todas las secciones (va de 63 a 110 px) porque el resplandor
de un marco dorado ocupa más que el de uno gris; recortar todos al mismo tamaño habría
cortado el de los legendarios o dejado aire en los comunes. Nada está reescalado: los
píxeles son los de la lámina.

La grilla se detectó por contraste —el fondo del póster es liso y la caja no—, no a ojo.

⚠ La lámina dice «32×32 PX» abajo a la izquierda: eso es la **referencia de estilo** con
la que el diseñador dibujó, no el tamaño de los archivos. Los recortes vienen al tamaño
de la lámina.

## Lo que falta decidir

⚠ **Estos iconos todavía no están mapeados a los 47 perks de `Client\Datos\perks.json`.**
La lámina usa seis rarezas (común, infrecuente, raro, épico, legendario, único) y el
juego usa cuatro tiers (`bronze`, `silver`, `gold`, `unique`). Los nombres coinciden
solo en parte: `perforacion`, `saqueo`, `concentracion`, `oportunista`, `inspiracion`,
`cadena` y `veneno` existen en las dos listas, pero la mayoría no, y sobran iconos de un
lado y faltan del otro. **Qué icono le toca a qué perk es una decisión de diseño**, y
cuando se tome, la clave que la escribe es la `key` de `perks.json`, no el nombre de
archivo de acá.

Los nombres de archivo salen de la etiqueta de la lámina, sin tildes y en camelCase. Dos
vienen con errata del diseñador y se conservan tal cual en `iconos.json`: «Contrataque»
(por Contraataque) y «Aura de Velocdad».
