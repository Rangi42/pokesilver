	object_const_def
	const MRPOKEMONSHOUSE_GENTLEMAN
	const MRPOKEMONSHOUSE_OAK

MrPokemonsHouse_MapScripts:
	def_scene_scripts
	scene_script MrPokemonsHouseMeetMrPokemonScene, SCENE_MRPOKEMONSHOUSE_MEET_MR_POKEMON
	scene_script MrPokemonsHouseNoopScene,          SCENE_MRPOKEMONSHOUSE_NOOP

	def_callbacks

MrPokemonsHouseMeetMrPokemonScene:
	sdefer MrPokemonsHouseMrPokemonEventScript
	end

MrPokemonsHouseNoopScene:
	end

MrPokemonsHouseMrPokemonEventScript:
	showemote EMOTE_SHOCK, MRPOKEMONSHOUSE_GENTLEMAN, 15
	turnobject MRPOKEMONSHOUSE_GENTLEMAN, DOWN
	opentext
	writetext MrPokemonIntroText1
	waitbutton
	closetext
	applymovement PLAYER, MrPokemonsHouse_PlayerWalksToMrPokemon
	opentext
	writetext MrPokemonIntroText2
	promptbutton
	waitsfx
	giveitem MYSTERY_EGG
	writetext MrPokemonsHouse_GotEggText
	playsound SFX_KEY_ITEM
	waitsfx
	itemnotify
	setevent EVENT_GOT_MYSTERY_EGG_FROM_MR_POKEMON
	blackoutmod CHERRYGROVE_CITY
	writetext MrPokemonIntroText3
	promptbutton
	turnobject MRPOKEMONSHOUSE_GENTLEMAN, RIGHT
	writetext MrPokemonIntroText4
	promptbutton
	turnobject MRPOKEMONSHOUSE_GENTLEMAN, DOWN
	turnobject MRPOKEMONSHOUSE_OAK, LEFT
	writetext MrPokemonIntroText5
	waitbutton
	closetext
	sjump MrPokemonsHouse_OakScript

MrPokemonsHouse_MrPokemonScript:
	faceplayer
	opentext
	checkitem RED_SCALE
	iftrue .RedScale
	checkevent EVENT_GAVE_MYSTERY_EGG_TO_ELM
	iftrue .AlwaysNewDiscoveries
	writetext MrPokemonText_ImDependingOnYou
	waitbutton
	closetext
	end

.AlwaysNewDiscoveries:
	writetext MrPokemonText_AlwaysNewDiscoveries
	waitbutton
	closetext
	end

.RedScale:
	writetext MrPokemonText_GimmeTheScale
	yesorno
	iffalse .refused
	verbosegiveitem EXP_SHARE
	iffalse .full
	takeitem RED_SCALE
	sjump .AlwaysNewDiscoveries

.refused
	writetext MrPokemonText_Disappointed
	waitbutton
.full
	closetext
	end

MrPokemonsHouse_OakScript:
	playmusic MUSIC_PROF_OAK
	applymovement MRPOKEMONSHOUSE_OAK, MrPokemonsHouse_OakWalksToPlayer
	turnobject PLAYER, RIGHT
	opentext
	writetext MrPokemonsHouse_OakText1
	promptbutton
	waitsfx
	writetext MrPokemonsHouse_GetDexText
	playsound SFX_ITEM
	waitsfx
	setflag ENGINE_POKEDEX
	writetext MrPokemonsHouse_OakText2
	waitbutton
	closetext
	turnobject PLAYER, DOWN
	applymovement MRPOKEMONSHOUSE_OAK, MrPokemonsHouse_OakExits
	playsound SFX_EXIT_BUILDING
	disappear MRPOKEMONSHOUSE_OAK
	waitsfx
	special RestartMapMusic
	pause 15
	turnobject PLAYER, UP
	opentext
	writetext MrPokemonsHouse_MrPokemonHealText
	waitbutton
	closetext
	special FadeOutToBlack
	special ReloadSpritesNoPalettes
	playmusic MUSIC_HEAL
	special HealParty
	pause 60
	special FadeInFromBlack
	special RestartMapMusic
	opentext
	writetext MrPokemonText_ImDependingOnYou
	waitbutton
	closetext
	setevent EVENT_RIVAL_NEW_BARK_TOWN
	setscene SCENE_MRPOKEMONSHOUSE_NOOP
	setmapscene CHERRYGROVE_CITY, SCENE_CHERRYGROVECITY_MEET_RIVAL
	setmapscene ELMS_LAB, SCENE_ELMSLAB_MEET_OFFICER
	specialphonecall SPECIALCALL_ROBBED
	clearevent EVENT_COP_IN_ELMS_LAB
	checkevent EVENT_GOT_TOTODILE_FROM_ELM
	iftrue .RivalTakesChikorita
	checkevent EVENT_GOT_CHIKORITA_FROM_ELM
	iftrue .RivalTakesCyndaquil
	setevent EVENT_TOTODILE_POKEBALL_IN_ELMS_LAB
	end

.RivalTakesChikorita:
	setevent EVENT_CHIKORITA_POKEBALL_IN_ELMS_LAB
	end

.RivalTakesCyndaquil:
	setevent EVENT_CYNDAQUIL_POKEBALL_IN_ELMS_LAB
	end

MrPokemonsHouse_ForeignMagazines:
	jumptext MrPokemonsHouse_ForeignMagazinesText

MrPokemonsHouse_BrokenComputer:
	jumptext MrPokemonsHouse_BrokenComputerText

MrPokemonsHouse_StrangeCoins:
	jumptext MrPokemonsHouse_StrangeCoinsText

MrPokemonsHouse_PlayerWalksToMrPokemon:
	step RIGHT
	step UP
	step_end

MrPokemonsHouse_OakWalksToPlayer:
	step DOWN
	step LEFT
	step LEFT
	step_end

MrPokemonsHouse_OakExits:
	step DOWN
	step LEFT
	turn_head DOWN
	step_sleep 2
	step_end

MrPokemonIntroText1:
	text "やあやあ"
	line "きみ<GA><PLAYER>くん　だね"

	para "ウツギはかせ　から"
	line "れんらく<GA>あ<TTE>　ま<TTE>たんだ"
	done

MrPokemonIntroText2:
	text "これ<GA>ウツギはかせに"
	line "しらべて　もらいたい　も<NO>だよ！"
	done

MrPokemonsHouse_GotEggText:
	text "<PLAYER><WA>#じいさん　から"
	line "ふしぎなタマゴ<WO>あずかっ<TA!>"
	done

MrPokemonIntroText3:
	text "#<WO>あずか<TTE>　そだててる"
	line "ふうふ<GA>いるんだがの"
	cont "そこで　もらった　も<NO>なんだよ"

	para "もしかしたら<⋯>　と　おも<TTE>"
	line "ウツギはかせ<NI>メールおくったんだ"

	para "#しんか<NO>けんきゅう　なら"
	line "ウツギはかせ<GA>いちばん！"
	done

MrPokemonIntroText4:
	text "なにせ　こ<NO>オーキドはかせも"
	line "みとめる　ほど　だからのう"
	done

MrPokemonIntroText5:
	text "わし<NO>そうぞう<GA>あた<TTE>るか<⋯>"
	line "ウツギはかせ　なら　わかる　ハズだ！"
	done

MrPokemonsHouse_MrPokemonHealText:
	text "ウツギはかせ<NO>ところに"
	line "もどる　つもり　なんだろう？"

	para "すこし　#を"
	line "やすませる<GA>よかろう！"
	done

MrPokemonText_ImDependingOnYou:
	text "それじゃ　よろしく　たのむよ！"
	done

MrPokemonText_AlwaysNewDiscoveries:
	text "よのなか<WA>おもしろい　のう！"
	line "いろんな　はっけん<GA>あるからの！"
	done

MrPokemonsHouse_OakText1:
	text "オーキド『ほっほ！"
	line "キミ<GA><PLAYER>くん　か！"

	para "わし<WA>オーキド"
	line "#　けんきゅうか　じゃよ！"

	para "ふるい　ともだちの"
	line "#じいさん<WO>たずねて　みたら"
	cont "ウツギくん<NO>ところ　から"
	cont "おつかい<GA>くると　きいて"
	cont "ま<TTE>たんじゃよ！"

	para "ほほうっ！"
	line "めずらしい　#<WO>も<TTE>るな！"

	para "それに<⋯>　<⋯>"

	para "ふむ　なるほど！"

	para "ウツギくん<GA>#<WO>あげて"
	line "キミ<NI>おつかい<WO>たのんだ　りゆう"
	cont "なっとく　したよ！"

	para "わしや　ウツギくん<NO>ような"
	line "けんきゅうしゃ<NI>と<TTE>　#は"
	cont "だいじな　ともだち　じゃからな！"

	para "キミならば　#<WO>だいじに"
	line "そだてて　くれそうだと　いうことじゃ"

	para "<⋯>　そうじゃ！"

	para "キミ<WO>みこんで　わしからも"
	line "ひとつ　おねがい　しようかの！"

	para "じつはな<⋯>"

	para "ほれ！"
	line "こ<NO>#ずかん　じゃ！"

	para "みつけた　#<NO>データが"
	line "じどうてき<NI>かきこまれて"
	cont "ページ<GA>ふえていく　という"
	cont "ハイテクな　ずかん　なのじゃよ！"
	done

MrPokemonsHouse_GetDexText:
	text "<PLAYER><WA>オーキドはかせから"
	line "#ずかん<WO>もらっ<TA!>"
	done

MrPokemonsHouse_OakText2:
	text "たくさん<NO>#と　であい"
	line "こ<NO>ずかんを"
	cont "かんぺき<NI>してほしいのじゃ！"

	para "おっと！"
	line "ながい<WO>した　ようじゃ！"

	para "これから　コガネシティへ　い<TTE>"
	line "いつも<NO>ラジオばんぐみの"
	cont "しゅうろく<WO>せねば　ならんのだ！"

	para "それじゃ　<PLAYER>くん！"
	line "よろしく　たのんだぞ！"
	done

MrPokemonText_GimmeTheScale:
	text "ん？　そ<NO>ウロコは？"
	line "なぬ！　あかい　ギャラドス！？"

	para "そっ　それ<WA>めずらしい！"
	line "ほ　ほしいのう<⋯>"

	para "<PLAYER>くん"
	line "わし<GA>オーキドはかせから　もらった"
	cont "こ<NO>がくしゅうそうちと"
	cont "こうかん　してくれんかね？"
	done

MrPokemonText_Disappointed:
	text "そうか　そりゃ　ざんねんだ"
	line "かなり　めずらしいモノ　なんだが<⋯>"
	done

MrPokemonsHouse_ForeignMagazinesText:
	text "せかいじゅう<NO>ざっしが"
	line "いっぱい　ならんでいる！"

	para "<⋯>　<⋯>"
	line "タイトル<GA>よめない<⋯>"
	done

MrPokemonsHouse_BrokenComputerText:
	text "おおきな　コンピュータ！"
	line "<⋯>　こわれてる　みたい"
	done

MrPokemonsHouse_StrangeCoinsText:
	text "みたこと<NO>ない　コインが"
	line "いっぱい　ちらば<TTE>る！"
	cont "どこか<NO>くに<NO>おかね　かな？"
	done

MrPokemonsHouse_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  2,  7, ROUTE_30, 2
	warp_event  3,  7, ROUTE_30, 2

	def_coord_events

	def_bg_events
	bg_event  0,  1, BGEVENT_READ, MrPokemonsHouse_ForeignMagazines
	bg_event  1,  1, BGEVENT_READ, MrPokemonsHouse_ForeignMagazines
	bg_event  6,  1, BGEVENT_READ, MrPokemonsHouse_BrokenComputer
	bg_event  7,  1, BGEVENT_READ, MrPokemonsHouse_BrokenComputer
	bg_event  6,  4, BGEVENT_READ, MrPokemonsHouse_StrangeCoins

	def_object_events
	object_event  3,  5, SPRITE_GENTLEMAN, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, MrPokemonsHouse_MrPokemonScript, -1
	object_event  6,  5, SPRITE_OAK, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_MR_POKEMONS_HOUSE_OAK
