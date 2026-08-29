# Iconos de perks

Los 69 iconos de la lámina que entregó el diseñador, recortados de a uno y ya
asignados a los 47 perks de `Client\Data\perks.json`.

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

`iconos.json` los lista a todos con la etiqueta que la lámina trae escrita debajo, las
coordenadas dentro de la lámina, y el perk que los usa. El bloque `porPerk` es el mismo
mapeo al revés —entra la `key` del perk, sale el archivo—, y está ordenado por el `id`
de `perks.json` de menor a mayor, que es como se ve de un vistazo si falta uno. El 25 no
está y no es un olvido: quedó libre al borrarse «misilMagico».

⚠ **`iconos.json` lo lee el juego.** `Client\Scripts\IconLoader.cs` entra por
`porPerk`, saca la ruta del recorte y lo carga de disco —igual que
`GraphicsLoader.cs` con `graficos.json`—. Dejó de ser papeleo del pipeline de arte:
si acá se rompe algo, los perks se dibujan sin icono. Se cargan los **recortes**, no la
lámina; y un perk sin icono no es un error, devuelve `null` y la pantalla sigue con el
texto de siempre.

Hoy los dibujan tres pantallas: la mochila (los quince lugares y los seis slots de la
clase mirada), la tienda rotativa y la tarjeta del Oro que ofrece el jefe.

## El mapeo

**Los 47 perks tienen icono.** 35 iconos están en uso; los otros 34 no.

⚠ **El color del marco NO es el tier.** La lámina tiene seis rarezas (común,
infrecuente, raro, épico, legendario, único) y el juego tiene cuatro tiers (`bronze`,
`silver`, `gold`, `unique`), así que el match se hizo por lo que el dibujo **significa**,
no por el color. Escarcha es `gold` y su copo de nieve tiene marco verde; Onda de Frío es
`unique` y sus cristales tienen marco morado. Si el marco tiene que coincidir con el
tier, hay que rehornear cada icono componiéndolo sobre `fondos\<rareza>.png` — la lámina
está diseñada para eso, y por eso trae los marcos vacíos y los overlays aparte.

⚠ **Los 16 perks numéricos comparten cuatro dibujos.** `filo`, `temple`, `empunadura`,
`sana`, `ira` y `furia` son todos +daño y la lámina tiene una sola espada; lo mismo con
las seis de cadencia y las cuatro de alcance. Es correcto que compartan: son el mismo
efecto con distinta magnitud. Lo que los distingue en pantalla es el número y el marco,
no el dibujo.

Cada entrada de `porPerk` lleva un campo `match`:

| `match` | Qué quiere decir |
|---|---|
| `exacto` | El dibujo dice lo que el perk hace. No hay nada que revisar. |
| `compartido` | Varios perks del mismo efecto reusan el dibujo. |
| `aproximado` | Elegido leyendo el dibujo, sin equivalente directo. **Revisable.** |

Los 13 `aproximado`, con el porqué en `iconos.json`: `golpeCertero`, `debilidad`,
`quebranto`, `perforacion`, `iraDeDios`, `apocalipsis`, `tormentaDivina`, `ceguera`,
`fuerza`, `marcaDeCaza`, `golpeSismico`, `primerImpacto`, `preparacion`.

⚠ **Una trampa de nombres:** el icono `infrecuentes\perforacion.png` lo usa el perk
`sobrepenetracion`, no el perk `perforacion`. El unique `perforacion` sale de fusionar
Concentración + Sobrepenetración, así que la flecha que atraviesa le corresponde al
componente; al unique le tocó `epicos\dobleDisparo.png`.

## Iconos sin perk

**4 reservados para los NPCs atacantes** (`"uso": "npcAtacante"`). No son huérfanos:
esos perks todavía no existen en los datos.

| Icono | Etiqueta |
|---|---|
| `comunes\vida` | Vida + |
| `comunes\armadura` | Armadura + |
| `comunes\regeneracion` | Regeneración |
| `infrecuentes\evasion` | Evasión |

**17 libres** (`"uso": "libre"`), para los perks que se agreguen:

| Icono | Etiqueta | Qué sugiere el dibujo |
|---|---|---|
| `comunes\oro` | Oro + | Moneda. Un bronze/silver de economía. |
| `raros\fortificacion` | Fortificación | Escudo. |
| `raros\aura` | Aura | Cruz verde en anillo. |
| `raros\revitalizar` | Revitalizar | Corazón con cruz. |
| `raros\vinculo` | Vínculo | Cadena azul. Un segundo Chain, o un enlace entre defensores. |
| `epicos\cadena` | Cadena | Cadena morada. Lo mismo, en morado. |
| `legendarios\codicia` | Codicia | Pila de monedas. El gold de economía que `saqueo` ya ocupa. |
| `legendarios\metamorfosis` | Metamorfosis | Mariposa. |
| `meta\robustez` | Robustez | Escudo con corazón. |
| `meta\teletransporte` | Teletransporte | Espiral. |
| `meta\sinergia` | Sinergia | Tres orbes. |
| `auras\auraDeDano` | Aura de Daño | Los seis de auras van juntos: son la familia |
| `auras\auraDeVelocidad` | Aura de Velocdad | de soporte de área que el juego todavía |
| `auras\auraDeArmadura` | Aura de Armadura | no tiene. `inspiracion` es la única aura |
| `auras\auraDeRegeneracion` | Aura de Regeneración | que existe hoy, y usa el icono de las |
| `auras\auraDeOro` | Aura de Oro | notas musicales, no uno de estos. |
| `auras\auraDeRango` | Aura de Rango | |

**13 que no son perks por diseño** (`"uso": "decoracion"`): los 6 de `overlays\`, los 6
de `fondos\` y el de `ejemplo\`.

## Perks sin icono propio

Ninguno. Los 47 resuelven, aunque 16 comparten dibujo y 13 son `aproximado`.

## Dónde NO vive esto

⚠ **El mapeo no está en `perks.json` a propósito.** El hash de `/run/start` cubre el
**texto crudo** de los siete JSON de balance, comentarios incluidos: agregarle un campo
`icon` a `perks.json` cambiaría el hash y **eso es temporada nueva del ranking**, por una
decisión puramente cosmética. El icono es presentación, no entrada de la simulación, así
que vive acá, en `Resources\`, fuera del hash — igual que `Data\lang\`, por la misma
razón.

## Cómo salió el recorte

Cada icono se recortó **cuadrado y centrado en el marco, con el resplandor incluido**.
El lado no es el mismo en todas las secciones (va de 63 a 110 px) porque el resplandor
de un marco dorado ocupa más que el de uno gris; recortar todos al mismo tamaño habría
cortado el de los legendarios o dejado aire en los comunes. Nada está reescalado: los
píxeles son los de la lámina.

La grilla se detectó por contraste —el fondo del póster es liso y la caja no—, no a ojo.

⚠ La lámina dice «32×32 PX» abajo a la izquierda: eso es la **referencia de estilo** con
la que el diseñador dibujó, no el tamaño de los archivos.

Los nombres de archivo salen de la etiqueta de la lámina, sin tildes y en camelCase. Dos
vienen con errata del diseñador y se conservan tal cual en `iconos.json`: «Contrataque»
(por Contraataque) y «Aura de Velocdad».
