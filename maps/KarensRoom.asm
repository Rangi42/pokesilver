	object_const_def
	const KARENSROOM_KAREN

KarensRoom_MapScripts:
	def_scene_scripts
	scene_script KarensRoomLockDoorScene, SCENE_KARENSROOM_LOCK_DOOR
	scene_script KarensRoomNoopScene,     SCENE_KARENSROOM_NOOP

	def_callbacks
	callback MAPCALLBACK_TILES, KarensRoomDoorsCallback

KarensRoomLockDoorScene:
	sdefer KarensRoomDoorLocksBehindYouScript
	end

KarensRoomNoopScene:
	end

KarensRoomDoorsCallback:
	checkevent EVENT_KARENS_ROOM_ENTRANCE_CLOSED
	iffalse .KeepEntranceOpen
	changeblock 4, 14, $2a ; wall
.KeepEntranceOpen:
	checkevent EVENT_KARENS_ROOM_EXIT_OPEN
	iffalse .KeepExitClosed
	changeblock 4, 2, $16 ; open door
.KeepExitClosed:
	endcallback

KarensRoomDoorLocksBehindYouScript:
	applymovement PLAYER, KarensRoom_EnterMovement
	reanchormap $85
	playsound SFX_STRENGTH
	earthquake 80
	changeblock 4, 14, $2a ; wall
	refreshmap
	closetext
	setscene SCENE_KARENSROOM_NOOP
	setevent EVENT_KARENS_ROOM_ENTRANCE_CLOSED
	waitsfx
	end

KarenScript_Battle:
	faceplayer
	opentext
	checkevent EVENT_BEAT_ELITE_4_KAREN
	iftrue KarenScript_AfterBattle
	writetext KarenScript_KarenBeforeText
	waitbutton
	closetext
	winlosstext KarenScript_KarenBeatenText, 0
	loadtrainer KAREN, KAREN1
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_ELITE_4_KAREN
	opentext
	writetext KarenScript_KarenDefeatText
	waitbutton
	closetext
	playsound SFX_ENTER_DOOR
	changeblock 4, 2, $16 ; open door
	refreshmap
	closetext
	setevent EVENT_KARENS_ROOM_EXIT_OPEN
	waitsfx
	end

KarenScript_AfterBattle:
	writetext KarenScript_KarenDefeatText
	waitbutton
	closetext
	end

KarensRoom_EnterMovement:
	step UP
	step UP
	step UP
	step UP
	step_end

KarenScript_KarenBeforeText:
	text "あたくし　してんのう<NO>カリン！"

	para "あなた<GA><PLAYER>ね"
	line "ふうん　なかなか　おもしろそうね"

	para "あたくし<GA>あいしてるのは"
	line "あくタイプ<NO>#！"

	para "ワイルドで　タフな　かんじ"
	line "すてき　でしょ？"
	cont "それ<NI>とー<TTE>も　つよいのよ"

	para "あなた　あいて<NI>なるのかしら？"
	line "がんば<TTE>　あたくしを"
	cont "たのしませて　ほしいものね"

	para "じゃ　はじめましょ！"
	done

KarenScript_KarenBeatenText:
	text "フウン　やるじゃない"
	line "そーゆー<NO>すてき　よ"
	done

KarenScript_KarenDefeatText:
	text "つよい　#"

	para "よわい　#"

	para "そんな<NO>ひと<NO>か<TTE>"

	para "ほんとう<NI>つよい　<TRAINER>なら"
	line "すきな　#で"
	cont "かてるよう<NI>がんばるべき"

	para "いいわよ　あなた"
	line "だいじなこと　わか<TTE>るわね"

	para "さき<NI>すすみなさい"
	line "チャンピオン<GA>あなた<WO>ま<TTE>るわ"
	done

KarensRoom_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  4, 17, BRUNOS_ROOM, 3
	warp_event  5, 17, BRUNOS_ROOM, 4
	warp_event  4,  2, LANCES_ROOM, 1
	warp_event  5,  2, LANCES_ROOM, 2

	def_coord_events

	def_bg_events

	def_object_events
	object_event  5,  7, SPRITE_KAREN, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, KarenScript_Battle, -1
