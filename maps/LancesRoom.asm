	object_const_def
	const LANCESROOM_LANCE
	const LANCESROOM_MARY
	const LANCESROOM_OAK

LancesRoom_MapScripts:
	def_scene_scripts
	scene_script LancesRoomLockDoorScene, SCENE_LANCESROOM_LOCK_DOOR
	scene_script LancesRoomNoopScene,     SCENE_LANCESROOM_APPROACH_LANCE

	def_callbacks
	callback MAPCALLBACK_TILES, LancesRoomDoorsCallback

LancesRoomLockDoorScene:
	sdefer LancesRoomDoorLocksBehindYouScript
	end

LancesRoomNoopScene:
	end

LancesRoomDoorsCallback:
	checkevent EVENT_LANCES_ROOM_ENTRANCE_CLOSED
	iffalse .KeepEntranceOpen
	changeblock 4, 22, $34 ; wall
.KeepEntranceOpen:
	checkevent EVENT_LANCES_ROOM_EXIT_OPEN
	iffalse .KeepExitClosed
	changeblock 4, 0, $0b ; open door
.KeepExitClosed:
	endcallback

LancesRoomDoorLocksBehindYouScript:
	applymovement PLAYER, LancesRoom_EnterMovement
	reanchormap $85
	playsound SFX_STRENGTH
	earthquake 80
	changeblock 4, 22, $34 ; wall
	refreshmap
	closetext
	setscene SCENE_LANCESROOM_APPROACH_LANCE
	setevent EVENT_LANCES_ROOM_ENTRANCE_CLOSED
	end

Script_ApproachLanceFromLeft:
	special FadeOutMusic
	applymovement PLAYER, MovementData_ApproachLanceFromLeft
	sjump LancesRoomLanceScript

Script_ApproachLanceFromRight:
	special FadeOutMusic
	applymovement PLAYER, MovementData_ApproachLanceFromRight
LancesRoomLanceScript:
	turnobject LANCESROOM_LANCE, LEFT
	opentext
	writetext LanceBattleIntroText
	waitbutton
	closetext
	winlosstext LanceBattleWinText, 0
	setlasttalked LANCESROOM_LANCE
	loadtrainer CHAMPION, LANCE
	startbattle
	dontrestartmapmusic
	reloadmapafterbattle
	setevent EVENT_BEAT_CHAMPION_LANCE
	opentext
	writetext LanceBattleAfterText
	waitbutton
	closetext
	playsound SFX_ENTER_DOOR
	changeblock 4, 0, $0b ; open door
	refreshmap
	closetext
	setevent EVENT_LANCES_ROOM_ENTRANCE_CLOSED
	musicfadeout MUSIC_BEAUTY_ENCOUNTER, 16
	pause 30
	showemote EMOTE_SHOCK, LANCESROOM_LANCE, 15
	turnobject LANCESROOM_LANCE, DOWN
	pause 10
	turnobject PLAYER, DOWN
	appear LANCESROOM_MARY
	applymovement LANCESROOM_MARY, LancesRoomMovementData_MaryRushesIn
	opentext
	writetext LancesRoomMaryOhNoOakText
	waitbutton
	closetext
	appear LANCESROOM_OAK
	applymovement LANCESROOM_OAK, LancesRoomMovementData_OakWalksIn
	follow LANCESROOM_MARY, LANCESROOM_OAK
	applymovement LANCESROOM_MARY, LancesRoomMovementData_MaryYieldsToOak
	stopfollow
	turnobject LANCESROOM_OAK, UP
	turnobject LANCESROOM_LANCE, LEFT
	opentext
	writetext LancesRoomOakCongratulationsText
	waitbutton
	closetext
	applymovement LANCESROOM_MARY, LancesRoomMovementData_MaryInterviewChampion
	turnobject PLAYER, LEFT
	opentext
	writetext LancesRoomMaryInterviewText
	waitbutton
	closetext
	applymovement LANCESROOM_LANCE, LancesRoomMovementData_LancePositionsSelfToGuidePlayerAway
	turnobject PLAYER, UP
	opentext
	writetext LancesRoomNoisyText
	waitbutton
	closetext
	follow LANCESROOM_LANCE, PLAYER
	turnobject LANCESROOM_MARY, UP
	turnobject LANCESROOM_OAK, UP
	applymovement LANCESROOM_LANCE, LancesRoomMovementData_LanceLeadsPlayerToHallOfFame
	stopfollow
	playsound SFX_EXIT_BUILDING
	disappear LANCESROOM_LANCE
	applymovement PLAYER, LancesRoomMovementData_PlayerExits
	playsound SFX_EXIT_BUILDING
	disappear PLAYER
	applymovement LANCESROOM_MARY, LancesRoomMovementData_MaryTriesToFollow
	showemote EMOTE_SHOCK, LANCESROOM_MARY, 15
	opentext
	writetext LancesRoomMaryNoInterviewText
	pause 30
	closetext
	applymovement LANCESROOM_MARY, LancesRoomMovementData_MaryRunsBackAndForth
	special FadeOutToWhite
	pause 15
	warp HALL_OF_FAME, 4, 13
	end

LancesRoom_EnterMovement:
	step UP
	step UP
	step UP
	step UP
	step_end

MovementData_ApproachLanceFromLeft:
	step UP
	step UP
	step UP
	turn_head RIGHT
	step_end

MovementData_ApproachLanceFromRight:
	step UP
	step LEFT
	step UP
	step UP
	turn_head RIGHT
	step_end

LancesRoomMovementData_MaryRushesIn:
	big_step UP
	big_step UP
	big_step UP
	big_step UP
	turn_head DOWN
	step_end

LancesRoomMovementData_OakWalksIn:
	step UP
	step UP
	step UP
	step_end

LancesRoomMovementData_MaryYieldsToOak:
	step LEFT
	turn_head RIGHT
	step_end

LancesRoomMovementData_MaryInterviewChampion:
	big_step UP
	turn_head RIGHT
	step_end

LancesRoomMovementData_LancePositionsSelfToGuidePlayerAway:
	step UP
	step LEFT
	turn_head DOWN
	step_end

LancesRoomMovementData_LanceLeadsPlayerToHallOfFame:
	step UP
	step_end

LancesRoomMovementData_PlayerExits:
	step UP
	step_end

LancesRoomMovementData_MaryTriesToFollow:
	step UP
	step RIGHT
	turn_head UP
	step_end

LancesRoomMovementData_MaryRunsBackAndForth:
	big_step RIGHT
	big_step RIGHT
	big_step LEFT
	big_step LEFT
	big_step LEFT
	big_step RIGHT
	big_step RIGHT
	big_step RIGHT
	big_step LEFT
	big_step LEFT
	turn_head UP
	step_end

LanceBattleIntroText:
	text "ワタル『ま<TTE>いたよ！"

	para "<PLAYER>くん！"

	para "きみ<NO>じつりょく　なら　いずれ"
	line "ここまで　くること<WA>わか<TTE>いた"

	para "なにも　いうこと<WA>ない！"

	para "ただ　どちら<GA>つよいか"
	line "たたか<TTE>　きめるだけ！"

	para "さいきょう<NO><TRAINER>　として"
	line "リーグ　チャンピオン　として"

	para "ドラゴンつかい<NO>ワタル"
	line "いざ　まいる！"
	done

LanceBattleWinText:
	text "<⋯>　おわった"

	para "だけど　ふしぎな　きぶん　だよ"

	para "きっと　まけた　くやしさより"
	line "いい　チャンピオン<NO>たんじょうに"
	cont "たちあえた　よろこび<NO>ほうが"
	cont "おおきいから　かな"
	done

LanceBattleAfterText:
	text "<⋯>　ふう"

	para "つよく　なったね"
	line "<PLAYER>くん"
	cont "ほんとう<NI>つよく　なったよ"

	para "<TRAINER><NO>きみが"
	line "ただしくて　つよい　こころ<WO>もてば"
	cont "#も　それ<NI>こたえてくれる"

	para "そうして　<TRAINER>も　#も"
	line "どんどん　つよくな<TTE>　いくんだ<⋯>"
	done

LancesRoomMaryOhNoOakText:
	text "クルミ『あー　おわっちゃったあ！"
	line "もー　はかせ<GA>おそいからですよう！"
	done

LancesRoomOakCongratulationsText:
	text "オーキド『おお　<PLAYER>くん！"
	line "ひさしぶり　じゃのう"
	cont "いやあ　たくましくなった"

	para "#　リーグ　せいは"
	line "ほんとう<NI>すごい　ことじゃ！"

	para "きみ<GA>#への"
	line "しんらいと　あいじょう<WO>わすれずに"
	cont "こつこつと　や<TTE>きた"
	cont "けっか<GA>みのったのじゃよ"

	para "いやあ　#たちも　えらいぞ"
	line "#も　<TRAINER>のこと"
	cont "しんじているから　がんばれるのじゃ！"

	para "<PLAYER>くん"
	line "ほんとう<NI>おめでとう！"
	done

LancesRoomMaryInterviewText:
	text "クルミ『じゃー　あたらしい"
	line "チャンピオン<NO>インタビューですう"
	done

LancesRoomNoisyText:
	text "ワタル『<⋯>　なんだか"
	line "さわがしく　な<TTE>きたな<⋯>"

	para "<PLAYER>くん　ちょっと！"

	para "ついて　きてくれないか"
	done

LancesRoomMaryNoInterviewText:
	text "クルミ『あー　インタビュー"
	line "まだ　ですようー"
	done

LancesRoom_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  4, 23, KARENS_ROOM, 3
	warp_event  5, 23, KARENS_ROOM, 4
	warp_event  4,  0, HALL_OF_FAME, 1
	warp_event  5,  0, HALL_OF_FAME, 2

	def_coord_events
	coord_event  4,  5, SCENE_LANCESROOM_APPROACH_LANCE, Script_ApproachLanceFromLeft
	coord_event  5,  5, SCENE_LANCESROOM_APPROACH_LANCE, Script_ApproachLanceFromRight

	def_bg_events

	def_object_events
	object_event  5,  2, SPRITE_LANCE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, LancesRoomLanceScript, -1
	object_event  4,  7, SPRITE_TEACHER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_LANCES_ROOM_OAK_AND_MARY
	object_event  4,  7, SPRITE_OAK, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_LANCES_ROOM_OAK_AND_MARY
