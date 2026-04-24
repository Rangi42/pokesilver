	object_const_def
	const AZALEAGYM_BUGSY
	const AZALEAGYM_BUG_CATCHER1
	const AZALEAGYM_BUG_CATCHER2
	const AZALEAGYM_BUG_CATCHER3
	const AZALEAGYM_TWIN1
	const AZALEAGYM_TWIN2
	const AZALEAGYM_GYM_GUIDE

AzaleaGym_MapScripts:
	def_scene_scripts

	def_callbacks

AzaleaGymBugsyScript:
	faceplayer
	opentext
	checkevent EVENT_BEAT_BUGSY
	iftrue .FightDone
	writetext BugsyText_INeverLose
	waitbutton
	closetext
	winlosstext BugsyText_ResearchIncomplete, 0
	loadtrainer BUGSY, BUGSY1
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_BUGSY
	opentext
	writetext Text_ReceivedHiveBadge
	playsound SFX_GET_BADGE
	waitsfx
	setflag ENGINE_HIVEBADGE
	readvar VAR_BADGES
	scall AzaleaGymActivateRockets
.FightDone:
	checkevent EVENT_GOT_TM49_FURY_CUTTER
	iftrue .GotFuryCutter
	setevent EVENT_BEAT_TWINS_AMY_AND_MAY
	setevent EVENT_BEAT_BUG_CATCHER_BENNY
	setevent EVENT_BEAT_BUG_CATCHER_AL
	setevent EVENT_BEAT_BUG_CATCHER_JOSH
	writetext BugsyText_HiveBadgeSpeech
	promptbutton
	verbosegiveitem TM_FURY_CUTTER
	iffalse .NoRoomForFuryCutter
	setevent EVENT_GOT_TM49_FURY_CUTTER
	writetext BugsyText_FuryCutterSpeech
	waitbutton
	closetext
	end

.GotFuryCutter:
	writetext BugsyText_BugMonsAreDeep
	waitbutton
.NoRoomForFuryCutter:
	closetext
	end

AzaleaGymActivateRockets:
	ifequal 7, .RadioTowerRockets
	ifequal 6, .GoldenrodRockets
	end

.GoldenrodRockets:
	jumpstd GoldenrodRocketsScript

.RadioTowerRockets:
	jumpstd RadioTowerRocketsScript

TrainerTwinsAmyandmay1:
	trainer TWINS, AMYANDMAY1, EVENT_BEAT_TWINS_AMY_AND_MAY, TwinsAmyandmay1SeenText, TwinsAmyandmay1BeatenText, 0, .AfterScript

.AfterScript:
	endifjustbattled
	opentext
	writetext TwinsAmyandmay1AfterBattleText
	waitbutton
	closetext
	end

TrainerTwinsAmyandmay2:
	trainer TWINS, AMYANDMAY2, EVENT_BEAT_TWINS_AMY_AND_MAY, TwinsAmyandmay2SeenText, TwinsAmyandmay2BeatenText, 0, .AfterScript

.AfterScript:
	endifjustbattled
	opentext
	writetext TwinsAmyandmay2AfterBattleText
	waitbutton
	closetext
	end

TrainerBugCatcherBenny:
	trainer BUG_CATCHER, BENNY, EVENT_BEAT_BUG_CATCHER_BENNY, BugCatcherBennySeenText, BugCatcherBennyBeatenText, 0, .AfterScript

.AfterScript:
	endifjustbattled
	opentext
	writetext BugCatcherBennyAfterBattleText
	waitbutton
	closetext
	end

TrainerBugCatcherAl:
	trainer BUG_CATCHER, AL, EVENT_BEAT_BUG_CATCHER_AL, BugCatcherAlSeenText, BugCatcherAlBeatenText, 0, .AfterScript

.AfterScript:
	endifjustbattled
	opentext
	writetext BugCatcherAlAfterBattleText
	waitbutton
	closetext
	end

TrainerBugCatcherJosh:
	trainer BUG_CATCHER, JOSH, EVENT_BEAT_BUG_CATCHER_JOSH, BugCatcherJoshSeenText, BugCatcherJoshBeatenText, 0, .AfterScript

.AfterScript:
	endifjustbattled
	opentext
	writetext BugCatcherJoshAfterBattleText
	waitbutton
	closetext
	end

AzaleaGymGuideScript:
	faceplayer
	checkevent EVENT_BEAT_BUGSY
	iftrue .AzaleaGymGuideWinScript
	opentext
	writetext AzaleaGymGuideText
	waitbutton
	closetext
	end

.AzaleaGymGuideWinScript:
	opentext
	writetext AzaleaGymGuideWinText
	waitbutton
	closetext
	end

AzaleaGymStatue:
	checkflag ENGINE_HIVEBADGE
	iftrue .Beaten
	jumpstd GymStatue1Script
.Beaten:
	gettrainername STRING_BUFFER_4, BUGSY, BUGSY1
	jumpstd GymStatue2Script

BugsyText_INeverLose:
	text "ぼく　ツクシ！"
	line "むし#<NO>ことなら"
	cont "だれにも　まけないよ！"

	para "なんた<TTE>　しょうらいは"
	line "むし#　けんきゅうで"
	cont "えらい　はかせ<NI>なるんだから！"

	para "というわけで　ぼくの"
	line "けんきゅう<NO>せいか　みせてあげるよ"
	done

BugsyText_ResearchIncomplete:
	text "うわ　すごい！"
	line "きみ　#<NI>くわしいんだね！"

	para "あーあ"
	line "ぼく<NO>けんきゅうも　まだまだだ！"

	para "うん！　わかったよ"
	line "こ<NO>バッジ<WO>も<TTE>い<TTE>よ！"
	done

Text_ReceivedHiveBadge:
	text "<PLAYER><WA>ツクシから"
	line "インセクトバッジ<WO>もらっ<TA!>"
	done

BugsyText_HiveBadgeSpeech:
	text "インセクトバッジの"
	line "こうか<WA>し<TTE>る？"

	para "インセクトバッジをね　つけてると"
	line "ひとから　もらった　#でも"
	cont "レベル　３０まで<NO>#が"
	cont "すなお<NI>なるよ！"

	para "あとね　いあいぎり<WO>おぼえた"
	line "#<WA>たたか<TTE>いないときでも"
	cont "そ<NO>わざ<WO>つかえるんだよ！"

	para "それと　これ<WO>も<TTE>い<TTE>！"
	done

BugsyText_FuryCutterSpeech:
	text "<TM>４９<NO>なかみは"
	line "れんぞくぎり　だよ！"

	para "<KOUGEKI><GA>はずれない　かぎり"
	line "いりょく<GA>どんどん　あがる！"

	para "たたかい<GA>ながく　なるほど"
	line "ゆうり<NI>なるんだ！"

	para "どう　すごい　でしょ！？"
	line "ぼく<NO>はっけん　なんだよ"
	done

BugsyText_BugMonsAreDeep:
	text "むし#<WA>おく<GA>ふかいんだ"
	line "まだまだ　けんきゅう　することが"
	cont "いっぱい　あるんだよ"

	para "きみも　すきな　#"
	line "て<TTE>いてき<NI>しらべたら　どう？"
	done

BugCatcherBennySeenText:
	text "むし#<WA>しんか<GA>はやい！"
	line "わかる？　それだけ"
	cont "はやく　つよくなる<TTE>　ことだよ！"
	done

BugCatcherBennyBeatenText:
	text "しんか　させただけじゃ　だめかあ"
	done

BugCatcherBennyAfterBattleText:
	text "#<GA>しんか　すると"
	line "パワーアップ　するの<WA>ほんとだよ！"
	done

BugCatcherAlSeenText:
	text "かっこよくて　つよい"
	line "むし#<NO>みりょく"
	cont "おしえてやるぜ！"
	done

BugCatcherAlBeatenText:
	text "きみ<NO>つよさ<WO>おしえられたぜ！"
	done

BugCatcherAlAfterBattleText:
	text "こんな<NI>かっこいいのに"
	line "むし#　きらい<TTE>　いう"
	cont "おんなのこ　けっこう　いるんだよ"
	cont "どうしてだか　わかんないや"
	done

BugCatcherJoshSeenText:
	text "ヤドン<WO>たすけたんだ<TTE>？"
	line "なかなか　やるな"

	para "でも　おれ<NO>#も"
	line "そだ<TTE>るから　かなり　つよいぜ！"
	done

BugCatcherJoshBeatenText:
	text "ぐぐぐ<⋯>"
	done

BugCatcherJoshAfterBattleText:
	text "もっと　つよい　わざを"
	line "おしえないと　かてないのかなあ"
	done

TwinsAmyandmay1SeenText:
	text "クミ『おにいちゃん"
	line "リーダー<NI>ちょうせん　ですかー？"
	cont "そんな<NO>むりむり　ですー"
	done

TwinsAmyandmay1BeatenText:
	text "クミとルミ『あらあら　ですー"
	done

TwinsAmyandmay1AfterBattleText:
	text "クミ『おにいちゃん　つよいですー"
	done

TwinsAmyandmay2SeenText:
	text "ルミ『おにいちゃん"
	line "リーダー<NI>ちょうせん　ですかー？"
	cont "じゃあ　さっそく　たたかうですー"
	done

TwinsAmyandmay2BeatenText:
	text "クミとルミ『あらあら　ですー"
	done

TwinsAmyandmay2AfterBattleText:
	text "ルミ『むし#さん　まけちゃった"
	line "ざんねん　ですー"
	done

AzaleaGymGuideText:
	text "オッス"
	line "チャレンジャー！"

	para "ツクシ<WA>まだ　おさないけれど"
	line "むし#<NO>ちしき　なら"
	cont "おとなにだ<TTE>　まけてない！"

	para "アドバイス<GA>ないと　つらいだろ？"
	line "よーし　まかせとけ！"

	para "そうだな！"
	line "むし#<WA>ほのお<GA>きらいだ！"

	para "あと　ひこうタイプ<NO>わざも"
	line "こうか　ばつぐん　だな！"
	done

AzaleaGymGuideWinText:
	text "やるじゃないか！"
	line "わかい　<TRAINER>どうしの"
	cont "はげしい　バトル<⋯>"

	para "#せかいの"
	line "みらい<WA>あかるいな！"
	done

AzaleaGym_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  4, 15, AZALEA_TOWN, 5
	warp_event  5, 15, AZALEA_TOWN, 5

	def_coord_events

	def_bg_events
	bg_event  3, 13, BGEVENT_READ, AzaleaGymStatue
	bg_event  6, 13, BGEVENT_READ, AzaleaGymStatue

	def_object_events
	object_event  5,  7, SPRITE_BUGSY, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, AzaleaGymBugsyScript, -1
	object_event  5,  3, SPRITE_BUG_CATCHER, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_TRAINER, 2, TrainerBugCatcherBenny, -1
	object_event  8,  8, SPRITE_BUG_CATCHER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_TRAINER, 3, TrainerBugCatcherAl, -1
	object_event  0,  2, SPRITE_BUG_CATCHER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_TRAINER, 3, TrainerBugCatcherJosh, -1
	object_event  4, 10, SPRITE_TWIN, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 1, TrainerTwinsAmyandmay1, -1
	object_event  5, 10, SPRITE_TWIN, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 1, TrainerTwinsAmyandmay2, -1
	object_event  7, 13, SPRITE_GYM_GUIDE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, AzaleaGymGuideScript, -1
