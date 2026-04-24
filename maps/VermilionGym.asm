	object_const_def
	const VERMILIONGYM_SURGE
	const VERMILIONGYM_GENTLEMAN
	const VERMILIONGYM_ROCKER
	const VERMILIONGYM_SUPER_NERD
	const VERMILIONGYM_GYM_GUIDE

VermilionGym_MapScripts:
	def_scene_scripts

	def_callbacks

VermilionGymSurgeScript:
	faceplayer
	opentext
	checkflag ENGINE_THUNDERBADGE
	iftrue .FightDone
	writetext LtSurgeIntroText
	waitbutton
	closetext
	winlosstext LtSurgeWinLossText, 0
	loadtrainer LT_SURGE, LT_SURGE1
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_LTSURGE
	setevent EVENT_BEAT_GENTLEMAN_GREGORY
	setevent EVENT_BEAT_GUITARIST_VINCENT
	setevent EVENT_BEAT_JUGGLER_HORTON
	opentext
	writetext ReceivedThunderBadgeText
	playsound SFX_GET_BADGE
	waitsfx
	setflag ENGINE_THUNDERBADGE
	writetext LtSurgeThunderBadgeText
	waitbutton
	closetext
	end

.FightDone:
	writetext LtSurgeFightDoneText
	waitbutton
	closetext
	end

TrainerGentlemanGregory:
	trainer GENTLEMAN, GREGORY, EVENT_BEAT_GENTLEMAN_GREGORY, GentlemanGregorySeenText, GentlemanGregoryBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext GentlemanGregoryAfterBattleText
	waitbutton
	closetext
	end

TrainerGuitaristVincent:
	trainer GUITARIST, VINCENT, EVENT_BEAT_GUITARIST_VINCENT, GuitaristVincentSeenText, GuitaristVincentBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext GuitaristVincentAfterBattleText
	waitbutton
	closetext
	end

TrainerJugglerHorton:
	trainer JUGGLER, HORTON, EVENT_BEAT_JUGGLER_HORTON, JugglerHortonSeenText, JugglerHortonBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext JugglerHortonAfterBattleText
	waitbutton
	closetext
	end

VermilionGymGuideScript:
	faceplayer
	opentext
	checkevent EVENT_BEAT_LTSURGE
	iftrue .VermilionGymGuideWinScript
	writetext VermilionGymGuideText
	waitbutton
	closetext
	end

.VermilionGymGuideWinScript:
	writetext VermilionGymGuideWinText
	waitbutton
	closetext
	end

VermilionGymTrashCan:
	jumptext VermilionGymTrashCanText

VermilionGymStatue:
	checkflag ENGINE_THUNDERBADGE
	iftrue .Beaten
	jumpstd GymStatue1Script
.Beaten:
	gettrainername STRING_BUFFER_4, LT_SURGE, LT_SURGE1
	jumpstd GymStatue2Script

LtSurgeIntroText:
	text "マチス『ヘーイ！"
	line "プア　リトル　ボーイ！"

	para "ミー<NI>たたかい<WO>いどむなんて"
	line "ユー<WA>みのほどしらず！"
	cont "ミー<NO>エレクトリック　#"
	cont "ナンバー　ワン　ねー！"

	para "せんじょうじゃ　まけたこと"
	line "アリマセーン！！"

	para "ユーも　てき<NO>ソルジャー　みたく"
	line "びりびり　シビレさせてあげるよ！"
	done

LtSurgeWinLossText:
	text "マチス『オー　ノー！"
	line "ユー　<WA>ストロング！"

	para "オッケー！"
	line "オレンジバッジ　やるヨ！"
	done

ReceivedThunderBadgeText:
	text "<PLAYER><WA>マチスから"
	line "オレンジバッジ<WO>もらっ<TA!>"
	done

LtSurgeThunderBadgeText:
	text "マチス『オレンジバッジ　も<TTE>ると"
	line "ユー<NO>#　スピード　アップ！"

	para "ミー<NI>かった　あかし　ネー！"
	line "たいせつ　する　グッド！"
	done

LtSurgeFightDoneText:
	text "マチス『ヘイ！　ボーイ！"
	line "がんば<TTE>　ますかー？"

	para "ミーと　#も"
	line "がんば<TTE>　マース！"
	done

GentlemanGregorySeenText:
	text "マチス　しょうさを"
	line "たおし<NI>きたのか！"
	cont "そう<WA>させないっ！"
	done

GentlemanGregoryBeatenText:
	text "もうしわけ　ありません！"
	line "マチス　しょうさ！"
	done

GentlemanGregoryAfterBattleText:
	text "ぐんたい<NI>いた　ころだ<⋯>"
	line "<WATASHI><WA>マチス　しょうさに"
	cont "いのち<WO>すくわれた<⋯>！"
	done

GuitaristVincentSeenText:
	text "でんき　つかい<NO>うでを"
	line "マチスさん<NI>みとめられ<TA!>"
	cont "オレ<NI>かてるかな！？"
	done

GuitaristVincentBeatenText:
	text "ひゅー！　しびれ<TA!>"
	done

GuitaristVincentAfterBattleText:
	text "ジム<NO>しかけ<GA>うごいてれば"
	line "おまえなんか　たおせたのに<⋯>！"
	done

JugglerHortonSeenText:
	text "おまえ<WA>オレ<GA>たおす！"
	line "かくごしろっ！"
	done

JugglerHortonBeatenText:
	text "ぐはあっ！"
	line "つよいっ！"
	done

JugglerHortonAfterBattleText:
	text "オレ<NI>かったから<TTE>"
	line "あんしん　するなよ<⋯>"
	cont "マチス　しょうさ<WA>つよいぜ<⋯>"
	done

VermilionGymGuideText:
	text "おーす！"
	line "みらい<NO>チャンピオン！"
	cont "あんた　ラッキーだよ！"

	para "いつも　マチス<WA>ようじんぶかく"
	line "トラップ<WO>しかけてるけど"
	cont "いま<WA>さいわい　こしょうちゅう！"

	para "こころ　おきなく"
	line "マチスと　たたか<TTE>くれ！"
	done

VermilionGymGuideWinText:
	text "エキサイティングな　しあいだ！"
	line "きんちょう　したぜ！"
	done

VermilionGymTrashCanText:
	text "ガサゴソ<⋯>！"
	line "なか<WA>ゴミ　ばっかり！"
	done

VermilionGym_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  4, 17, VERMILION_CITY, 7
	warp_event  5, 17, VERMILION_CITY, 7

	def_coord_events

	def_bg_events
	bg_event  1,  7, BGEVENT_READ, VermilionGymTrashCan
	bg_event  3,  7, BGEVENT_READ, VermilionGymTrashCan
	bg_event  5,  7, BGEVENT_READ, VermilionGymTrashCan
	bg_event  7,  7, BGEVENT_READ, VermilionGymTrashCan
	bg_event  9,  7, BGEVENT_READ, VermilionGymTrashCan
	bg_event  1,  9, BGEVENT_READ, VermilionGymTrashCan
	bg_event  3,  9, BGEVENT_READ, VermilionGymTrashCan
	bg_event  5,  9, BGEVENT_READ, VermilionGymTrashCan
	bg_event  7,  9, BGEVENT_READ, VermilionGymTrashCan
	bg_event  9,  9, BGEVENT_READ, VermilionGymTrashCan
	bg_event  1, 11, BGEVENT_READ, VermilionGymTrashCan
	bg_event  3, 11, BGEVENT_READ, VermilionGymTrashCan
	bg_event  5, 11, BGEVENT_READ, VermilionGymTrashCan
	bg_event  7, 11, BGEVENT_READ, VermilionGymTrashCan
	bg_event  9, 11, BGEVENT_READ, VermilionGymTrashCan
	bg_event  3, 15, BGEVENT_READ, VermilionGymStatue
	bg_event  6, 15, BGEVENT_READ, VermilionGymStatue

	def_object_events
	object_event  5,  2, SPRITE_SURGE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, VermilionGymSurgeScript, -1
	object_event  8,  8, SPRITE_GENTLEMAN, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 4, TrainerGentlemanGregory, -1
	object_event  4,  7, SPRITE_ROCKER, SPRITEMOVEDATA_STANDING_DOWN, 3, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 3, TrainerGuitaristVincent, -1
	object_event  0, 10, SPRITE_SUPER_NERD, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 4, TrainerJugglerHorton, -1
	object_event  7, 15, SPRITE_GYM_GUIDE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 1, VermilionGymGuideScript, -1
