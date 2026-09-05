#!/usr/bin/env bash
# Copia los sonidos elegidos a Client\Data\audio\ con nombre estable.
# El nombre del destino ES la clave: <evento>_<n>.<ext>. El cargador arma la
# lista de variantes leyendo la carpeta, así que agregar una variante es copiar
# un archivo más, sin tocar código.
set -u

S="D:/Github/TowerDefender/Resources/Audio/Source"
D="D:/Github/TowerDefender/Client/Data/audio"

K_IF="$S/kenney-interface-sounds/x/Audio"
K_UI="$S/kenney-ui-audio/x/Audio"
K_IM="$S/kenney-impact-sounds/x/Audio"
K_RPG="$S/kenney-rpg-audio/x/Audio"
K_J="$S/kenney-music-jingles/x/Audio"
OGA_RPG="$S/oga-rpg-sound-pack/x/RPG Sound Pack"
OGA_80="$S/oga-80-cc0-rpg-sfx/x"

for c in attack impact tower enemy ui game; do mkdir -p "$D/sfx/$c"; done
mkdir -p "$D/music"

n=0
# cp1 <origen> <destino-relativo-a-$D>
cp1() {
  if [ ! -f "$1" ]; then echo "  FALTA: $1"; return 1; fi
  cp -f "$1" "$D/$2" && n=$((n+1))
}

echo "=== ATAQUES ==="
cp1 "$OGA_RPG/battle/swing3.wav"        sfx/attack/bow_1.wav
cp1 "$OGA_RPG/battle/swing2.wav"        sfx/attack/bow_2.wav
cp1 "$OGA_80/blade_01.ogg"              sfx/attack/sword_1.ogg
cp1 "$OGA_80/blade_02.ogg"              sfx/attack/sword_2.ogg
cp1 "$OGA_80/blade_03.ogg"              sfx/attack/sword_3.ogg
cp1 "$OGA_80/spell_01.ogg"              sfx/attack/magic_1.ogg
cp1 "$OGA_80/spell_02.ogg"              sfx/attack/magic_2.ogg
cp1 "$OGA_RPG/battle/magic1.wav"        sfx/attack/magic_3.wav
cp1 "$OGA_80/spell_fire_01.ogg"         sfx/attack/fire_1.ogg
cp1 "$OGA_80/spell_fire_02.ogg"         sfx/attack/fire_2.ogg
cp1 "$OGA_80/spell_fire_03.ogg"         sfx/attack/fire_3.ogg
cp1 "$K_IF/glass_001.ogg"               sfx/attack/ice_1.ogg
cp1 "$K_IF/glass_003.ogg"               sfx/attack/ice_2.ogg
cp1 "$K_IF/glass_005.ogg"               sfx/attack/ice_3.ogg
cp1 "$K_IF/glitch_001.ogg"              sfx/attack/lightning_1.ogg
cp1 "$K_IF/glitch_003.ogg"              sfx/attack/lightning_2.ogg
cp1 "$OGA_80/creature_slime_01.ogg"     sfx/attack/poison_1.ogg
cp1 "$OGA_80/creature_slime_03.ogg"     sfx/attack/poison_2.ogg
cp1 "$K_IM/impactMining_001.ogg"        sfx/attack/cannon_1.ogg
cp1 "$K_IM/impactMining_003.ogg"        sfx/attack/cannon_2.ogg
cp1 "$OGA_RPG/battle/swing.wav"         sfx/attack/melee_1.wav
cp1 "$OGA_RPG/battle/swing2.wav"        sfx/attack/melee_2.wav

echo "=== IMPACTOS ==="
cp1 "$K_IM/impactWood_light_000.ogg"    sfx/impact/arrow_1.ogg
cp1 "$K_IM/impactWood_light_002.ogg"    sfx/impact/arrow_2.ogg
cp1 "$K_IM/impactMetal_light_000.ogg"   sfx/impact/sword_1.ogg
cp1 "$K_IM/impactMetal_light_002.ogg"   sfx/impact/sword_2.ogg
cp1 "$K_IM/impactGeneric_light_000.ogg" sfx/impact/magic_1.ogg
cp1 "$K_IM/impactGeneric_light_002.ogg" sfx/impact/magic_2.ogg
cp1 "$OGA_80/spell_fire_05.ogg"         sfx/impact/fire_1.ogg
cp1 "$OGA_80/spell_fire_06.ogg"         sfx/impact/fire_2.ogg
cp1 "$K_IM/impactGlass_medium_000.ogg"  sfx/impact/ice_1.ogg
cp1 "$K_IM/impactGlass_medium_002.ogg"  sfx/impact/ice_2.ogg
cp1 "$K_IM/impactSoft_medium_000.ogg"   sfx/impact/soft_1.ogg
cp1 "$K_IM/impactSoft_medium_002.ogg"   sfx/impact/soft_2.ogg

echo "=== TORRES ==="
cp1 "$OGA_RPG/inventory/armor-light.wav" sfx/tower/place_1.wav
cp1 "$OGA_RPG/inventory/chainmail1.wav"  sfx/tower/place_2.wav
cp1 "$K_J/Pizzicato jingles/jingles_PIZZI09.ogg" sfx/tower/upgrade_1.ogg
cp1 "$K_RPG/handleCoins.ogg"             sfx/tower/sell_1.wav.ogg
cp1 "$K_J/Steel jingles/jingles_STEEL07.ogg"     sfx/tower/unlock_1.ogg
cp1 "$K_UI/rollover2.ogg"                sfx/tower/select_1.ogg

echo "=== ENEMIGOS ==="
cp1 "$OGA_80/creature_hurt_01.ogg"      sfx/enemy/hurt_1.ogg
cp1 "$OGA_80/creature_hurt_02.ogg"      sfx/enemy/hurt_2.ogg
cp1 "$OGA_RPG/NPC/gutteral beast/mnstr3.wav" sfx/enemy/hurt_3.wav
cp1 "$OGA_80/creature_die_01.ogg"       sfx/enemy/death_1.ogg
cp1 "$OGA_RPG/NPC/shade/shade5.wav"     sfx/enemy/death_2.wav
cp1 "$OGA_RPG/NPC/slime/slime4.wav"     sfx/enemy/death_3.wav
cp1 "$OGA_80/creature_roar_01.ogg"      sfx/enemy/boss_1.ogg
cp1 "$OGA_80/creature_roar_03.ogg"      sfx/enemy/boss_2.ogg
cp1 "$K_IM/impactBell_heavy_000.ogg"    sfx/enemy/leak_1.ogg

echo "=== UI ==="
cp1 "$K_UI/click1.ogg"                  sfx/ui/click_1.ogg
cp1 "$K_UI/click3.ogg"                  sfx/ui/click_2.ogg
cp1 "$K_UI/rollover1.ogg"               sfx/ui/hover_1.ogg
cp1 "$K_UI/rollover4.ogg"               sfx/ui/hover_2.ogg
cp1 "$K_IF/confirmation_001.ogg"        sfx/ui/confirm_1.ogg
cp1 "$K_IF/confirmation_003.ogg"        sfx/ui/confirm_2.ogg
cp1 "$K_IF/back_001.ogg"                sfx/ui/cancel_1.ogg
cp1 "$K_IF/back_003.ogg"                sfx/ui/cancel_2.ogg
cp1 "$K_IF/error_002.ogg"               sfx/ui/error_1.ogg
cp1 "$K_IF/error_006.ogg"               sfx/ui/error_2.ogg
cp1 "$K_RPG/handleCoins2.ogg"           sfx/ui/buy_1.ogg
cp1 "$OGA_80/item_coins_01.ogg"         sfx/ui/coins_1.ogg
cp1 "$OGA_80/item_coins_03.ogg"         sfx/ui/coins_2.ogg
cp1 "$K_J/Pizzicato jingles/jingles_PIZZI15.ogg" sfx/ui/reward_1.ogg
cp1 "$K_IF/open_001.ogg"                sfx/ui/menu_open_1.ogg
cp1 "$K_IF/close_001.ogg"               sfx/ui/menu_close_1.ogg

echo "=== JUEGO ==="
cp1 "$K_J/Steel jingles/jingles_STEEL00.ogg"     sfx/game/wave_start_1.ogg
cp1 "$K_J/Pizzicato jingles/jingles_PIZZI06.ogg" sfx/game/wave_end_1.ogg
cp1 "$K_IF/pluck_001.ogg"               sfx/game/skill_ready_1.ogg
cp1 "$K_IF/tick_002.ogg"                sfx/game/cooldown_ready_1.ogg

echo "=== MUSICA ==="
cp1 "$S/oga-medieval-exploration/Exploration_0.mp3"          music/menu.mp3
cp1 "$S/oga-medieval-the-old-tower-inn/Loop_The_Old_Tower_Inn.wav" music/calm.wav
cp1 "$S/oga-medieval-market-day/Loop_Market_Day_0.mp3"       music/normal.mp3
cp1 "$S/oga-medieval-battle/battle_8.mp3"                    music/intense.mp3
cp1 "$S/oga-boss-battle-music/Juhani_Junkala_-_Epic_Boss_Battle_%5BSeamlessly_Looping%5D.wav" music/boss.wav
cp1 "$S/oga-medieval-victory-theme/victory_0.mp3"            music/victory.mp3
cp1 "$S/oga-medieval-defeat-theme/defeat_0.mp3"              music/defeat.mp3

# el nombre raro que quedó de arriba
[ -f "$D/sfx/tower/sell_1.wav.ogg" ] && mv -f "$D/sfx/tower/sell_1.wav.ogg" "$D/sfx/tower/sell_1.ogg"

echo
echo "copiados: $n"
du -sh "$D" "$D/sfx" "$D/music"
