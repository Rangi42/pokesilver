	object_const_def
	const WILLSROOM_WILL

WillsRoom_MapScripts:
	def_scene_scripts
	scene_script WillsRoomLockDoorScene, SCENE_WILLSROOM_LOCK_DOOR
	scene_script WillsRoomNoopScene,     SCENE_WILLSROOM_NOOP

	def_callbacks
	callback MAPCALLBACK_TILES, WillsRoomDoorsCallback

WillsRoomLockDoorScene:
	sdefer WillsRoomDoorLocksBehindYouScript
	end

WillsRoomNoopScene:
	end

WillsRoomDoorsCallback:
	checkevent EVENT_WILLS_ROOM_ENTRANCE_CLOSED
	iffalse .KeepEntranceOpen
	changeblock 4, 14, $2a ; wall
.KeepEntranceOpen:
	checkevent EVENT_WILLS_ROOM_EXIT_OPEN
	iffalse .KeepExitClosed
	changeblock 4, 2, $16 ; open door
.KeepExitClosed:
	endcallback

WillsRoomDoorLocksBehindYouScript:
	applymovement PLAYER, WillsRoom_EnterMovement
	reanchormap $85
	playsound SFX_STRENGTH
	earthquake 80
	changeblock 4, 14, $2a ; wall
	refreshmap
	closetext
	setscene SCENE_WILLSROOM_NOOP
	setevent EVENT_WILLS_ROOM_ENTRANCE_CLOSED
	waitsfx
	end

WillScript_Battle:
	faceplayer
	opentext
	checkevent EVENT_BEAT_ELITE_4_WILL
	iftrue WillScript_AfterBattle
	writetext WillScript_WillBeforeText
	waitbutton
	closetext
	winlosstext WillScript_WillBeatenText, 0
	loadtrainer WILL, WILL1
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_ELITE_4_WILL
	opentext
	writetext WillScript_WillDefeatText
	waitbutton
	closetext
	playsound SFX_ENTER_DOOR
	changeblock 4, 2, $16 ; open door
	refreshmap
	closetext
	setevent EVENT_WILLS_ROOM_EXIT_OPEN
	waitsfx
	end

WillScript_AfterBattle:
	writetext WillScript_WillDefeatText
	waitbutton
	closetext
	end

WillsRoom_EnterMovement:
	step UP
	step UP
	step UP
	step UP
	step_end

WillScript_WillBeforeText:
	text "ようこそ　#　リーグへ！"

	para "ボク<NO>なまえ<WA>イツキ"

	para "せかい<WO>たびしてまわり"
	line "エスパー#の"
	cont "しゅぎょう<NI>あけくれた"

	para "そして　ようやく"
	line "してんのう<NO>ひとり<NI>なったんだ"

	para "ボク<WA>もっと　つよくなる！"
	line "ここで　まけるわけに<WA>いかない！"
	done

WillScript_WillBeatenText:
	text "<⋯>　まいったよ"
	done

WillScript_WillDefeatText:
	text "まけたから　とい<TTE>"
	line "ボク<NO>やること<WA>かわらない"
	cont "<TRAINER><NO>ちょうてん<NI>たつため"
	cont "たたかい　つづけるだけ"

	para "きみ<WA>つぎ<NI>すすんで"
	line "ほんとう<NO>してんのう<NO>こわさ"
	cont "たしかめる<GA>いい！"
	done

WillsRoom_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  5, 17, INDIGO_PLATEAU_POKECENTER_1F, 4
	warp_event  4,  2, KOGAS_ROOM, 1
	warp_event  5,  2, KOGAS_ROOM, 2

	def_coord_events

	def_bg_events

	def_object_events
	object_event  5,  7, SPRITE_WILL, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, WillScript_Battle, -1
