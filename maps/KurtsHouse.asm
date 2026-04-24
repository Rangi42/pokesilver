	object_const_def
	const KURTSHOUSE_KURT1
	const KURTSHOUSE_TWIN
	const KURTSHOUSE_SLOWPOKE
	const KURTSHOUSE_KURT2

KurtsHouse_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_OBJECTS, KurtsHouseKurtCallback

KurtsHouseKurtCallback:
	checkevent EVENT_CLEARED_SLOWPOKE_WELL
	iffalse .Done
	checkflag ENGINE_KURT_MAKING_BALLS
	iftrue .MakingBalls
	disappear KURTSHOUSE_KURT2
	appear KURTSHOUSE_KURT1
	endcallback

.MakingBalls:
	disappear KURTSHOUSE_KURT1
	appear KURTSHOUSE_KURT2
.Done:
	endcallback

Kurt1:
	faceplayer
	opentext
	checkevent EVENT_KURT_GAVE_YOU_LURE_BALL
	iftrue .GotLureBall
	checkevent EVENT_CLEARED_SLOWPOKE_WELL
	iftrue .ClearedSlowpokeWell
	writetext KurtsHouseKurtMakingBallsMustWaitText
	waitbutton
	closetext
	special FadeOutMusic
	setevent EVENT_AZALEA_TOWN_SLOWPOKETAIL_ROCKET
	readvar VAR_FACING
	ifequal UP, .RunAround
	turnobject PLAYER, DOWN
	playsound SFX_FLY
	applymovement KURTSHOUSE_KURT1, KurtsHouseKurtExitHouseMovement
	playsound SFX_EXIT_BUILDING
	disappear KURTSHOUSE_KURT1
	waitsfx
	special RestartMapMusic
	end

.RunAround:
	turnobject PLAYER, DOWN
	playsound SFX_FLY
	applymovement KURTSHOUSE_KURT1, KurtsHouseKurtGoAroundPlayerThenExitHouseMovement
	playsound SFX_EXIT_BUILDING
	disappear KURTSHOUSE_KURT1
	waitsfx
	special RestartMapMusic
	end

.ClearedSlowpokeWell:
	writetext KurtsHouseKurtHonoredToMakeBallsText
	promptbutton
	verbosegiveitem LURE_BALL
	iffalse .NoRoomForBall
	setevent EVENT_KURT_GAVE_YOU_LURE_BALL
.GotLureBall:
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
	iftrue .ThatTurnedOutGreat
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	iftrue .WaitForApricorns
	checkevent EVENT_GAVE_KURT_RED_APRICORN
	iftrue .GiveLevelBall
	checkevent EVENT_GAVE_KURT_BLU_APRICORN
	iftrue .GiveLureBall
	checkevent EVENT_GAVE_KURT_YLW_APRICORN
	iftrue .GiveMoonBall
	checkevent EVENT_GAVE_KURT_GRN_APRICORN
	iftrue .GiveFriendBall
	checkevent EVENT_GAVE_KURT_WHT_APRICORN
	iftrue .GiveFastBall
	checkevent EVENT_GAVE_KURT_BLK_APRICORN
	iftrue .GiveHeavyBall
	checkevent EVENT_GAVE_KURT_PNK_APRICORN
	iftrue .GiveLoveBall
	writetext KurtsHouseKurtBallsFromApricornsText
	promptbutton
	checkitem RED_APRICORN
	iftrue .AskApricorn
	checkitem BLU_APRICORN
	iftrue .AskApricorn
	checkitem YLW_APRICORN
	iftrue .AskApricorn
	checkitem GRN_APRICORN
	iftrue .AskApricorn
	checkitem WHT_APRICORN
	iftrue .AskApricorn
	checkitem BLK_APRICORN
	iftrue .AskApricorn
	checkitem PNK_APRICORN
	iftrue .AskApricorn
	closetext
	end

.AskApricorn:
	writetext KurtsHouseKurtAskYouHaveAnApricornText
	promptbutton
	special SelectApricornForKurt
	ifequal FALSE, .Cancel
	ifequal BLU_APRICORN, .Blu
	ifequal YLW_APRICORN, .Ylw
	ifequal GRN_APRICORN, .Grn
	ifequal WHT_APRICORN, .Wht
	ifequal BLK_APRICORN, .Blk
	ifequal PNK_APRICORN, .Pnk
; .Red
	setevent EVENT_GAVE_KURT_RED_APRICORN
	sjump .GaveKurtApricorns

.Blu:
	setevent EVENT_GAVE_KURT_BLU_APRICORN
	sjump .GaveKurtApricorns

.Ylw:
	setevent EVENT_GAVE_KURT_YLW_APRICORN
	sjump .GaveKurtApricorns

.Grn:
	setevent EVENT_GAVE_KURT_GRN_APRICORN
	sjump .GaveKurtApricorns

.Wht:
	setevent EVENT_GAVE_KURT_WHT_APRICORN
	sjump .GaveKurtApricorns

.Blk:
	setevent EVENT_GAVE_KURT_BLK_APRICORN
	sjump .GaveKurtApricorns

.Pnk:
	setevent EVENT_GAVE_KURT_PNK_APRICORN
	sjump .GaveKurtApricorns

.GaveKurtApricorns:
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	setflag ENGINE_KURT_MAKING_BALLS
.WaitForApricorns:
	writetext KurtsHouseKurtItWillTakeADayText
	waitbutton
	closetext
	end

.Cancel:
	writetext KurtsHouseKurtThatsALetdownText
	waitbutton
	closetext
	end

.KurtMakingBallsScript:
	writetext KurtsHouseKurtDontBotherMeText
	waitbutton
	closetext
	end

._ThatTurnedOutGreat:
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
.ThatTurnedOutGreat:
	writetext KurtsHouseKurtTurnedOutGreatText
	waitbutton
.NoRoomForBall:
	closetext
	end

.GiveLevelBall:
	checkflag ENGINE_KURT_MAKING_BALLS
	iftrue .KurtMakingBallsScript
	writetext KurtsHouseKurtJustFinishedYourBallText
	promptbutton
	verbosegiveitem LEVEL_BALL
	iffalse .NoRoomForBall
	clearevent EVENT_GAVE_KURT_RED_APRICORN
	sjump ._ThatTurnedOutGreat

.GiveLureBall:
	checkflag ENGINE_KURT_MAKING_BALLS
	iftrue .KurtMakingBallsScript
	writetext KurtsHouseKurtJustFinishedYourBallText
	promptbutton
	verbosegiveitem LURE_BALL
	iffalse .NoRoomForBall
	clearevent EVENT_GAVE_KURT_BLU_APRICORN
	sjump ._ThatTurnedOutGreat

.GiveMoonBall:
	checkflag ENGINE_KURT_MAKING_BALLS
	iftrue .KurtMakingBallsScript
	writetext KurtsHouseKurtJustFinishedYourBallText
	promptbutton
	verbosegiveitem MOON_BALL
	iffalse .NoRoomForBall
	clearevent EVENT_GAVE_KURT_YLW_APRICORN
	sjump ._ThatTurnedOutGreat

.GiveFriendBall:
	checkflag ENGINE_KURT_MAKING_BALLS
	iftrue .KurtMakingBallsScript
	writetext KurtsHouseKurtJustFinishedYourBallText
	promptbutton
	verbosegiveitem FRIEND_BALL
	iffalse .NoRoomForBall
	clearevent EVENT_GAVE_KURT_GRN_APRICORN
	sjump ._ThatTurnedOutGreat

.GiveFastBall:
	checkflag ENGINE_KURT_MAKING_BALLS
	iftrue .KurtMakingBallsScript
	writetext KurtsHouseKurtJustFinishedYourBallText
	promptbutton
	verbosegiveitem FAST_BALL
	iffalse .NoRoomForBall
	clearevent EVENT_GAVE_KURT_WHT_APRICORN
	sjump ._ThatTurnedOutGreat

.GiveHeavyBall:
	checkflag ENGINE_KURT_MAKING_BALLS
	iftrue .KurtMakingBallsScript
	writetext KurtsHouseKurtJustFinishedYourBallText
	promptbutton
	verbosegiveitem HEAVY_BALL
	iffalse .NoRoomForBall
	clearevent EVENT_GAVE_KURT_BLK_APRICORN
	sjump ._ThatTurnedOutGreat

.GiveLoveBall:
	checkflag ENGINE_KURT_MAKING_BALLS
	iftrue .KurtMakingBallsScript
	writetext KurtsHouseKurtJustFinishedYourBallText
	promptbutton
	verbosegiveitem LOVE_BALL
	iffalse .NoRoomForBall
	clearevent EVENT_GAVE_KURT_PNK_APRICORN
	sjump ._ThatTurnedOutGreat

KurtsGranddaughter:
	faceplayer
	opentext
	checkevent EVENT_FAST_SHIP_FIRST_TIME
	iftrue .Dad
	checkevent EVENT_CLEARED_SLOWPOKE_WELL
	iftrue .SlowpokeBack
	checkevent EVENT_AZALEA_TOWN_SLOWPOKETAIL_ROCKET
	iftrue .Lonely
	writetext KurtsGranddaughterSlowpokeGoneText
	waitbutton
	closetext
	end

.SlowpokeBack:
	writetext KurtsGranddaughterSlowpokeBackText
	waitbutton
	closetext
	end

.Lonely:
	writetext KurtsGranddaughterLonelyText
	waitbutton
	closetext
	end

.Dad:
	writetext KurtsGranddaughterDadText
	waitbutton
	closetext
	end

KurtsHouseSlowpoke:
	faceplayer
	opentext
	writetext KurtsHouseSlowpokeText
	cry SLOWPOKE
	waitbutton
	closetext
	end

KurtsHouseOakPhoto:
	jumptext KurtsHouseOakPhotoText

KurtsHouseCelebiStatue:
	jumptext KurtsHouseCelebiStatueText

KurtsHouseBookshelf:
	jumpstd DifficultBookshelfScript

KurtsHouseRadio:
	jumpstd Radio2Script

KurtsHouseKurtExitHouseMovement:
	big_step DOWN
	big_step DOWN
	big_step DOWN
	big_step DOWN
	big_step DOWN
	step_end

KurtsHouseKurtGoAroundPlayerThenExitHouseMovement:
	big_step RIGHT
	big_step DOWN
	big_step DOWN
	big_step DOWN
	big_step DOWN
	big_step DOWN
	step_end

KurtsHouseKurtMakingBallsMustWaitText:
	text "おう　おまえ<WA>だれや？"

	para "そうか　<PLAYER>　いうんか"
	line "ボール<WO>つく<TTE>ほしいんか？"
	cont "わるい<GA>それどころ　ちゃうんや"

	para "<ROCKET>　し<TTE>るか？"
	line "いや　しらなくてもええ"
	cont "はなし<WO>すすめるぞ"

	para "<ROCKET>　いうのは"
	line "#<WO>むりやり　わるさにつかう"
	cont "ろくでもない　れんちゅうや"

	para "３ねんまえに"
	line "かいさん　したはず　なんやが<⋯>"

	para "とにかく　そいつらが"
	line "いどで　ヤドン<NO>シッポを"
	cont "き<TTE><WA>うりさばいとるんや"

	para "だから　わし<GA>い<TTE>"
	line "ちと　こらしめたるんや！"

	para "よーし！　ま<TTE>ろ　ヤドン！"
	line "おとこガンテツ<GA>たすけたるぞ！"
	done

KurtsHouseKurtHonoredToMakeBallsText:
	text "ガンテツ『おう　<PLAYER>"
	line "いどで<NO>おまえさん<NO>はたらき"
	cont "そりゃもう　みごと<NO>ひとこと！"

	para "わし<WA>おまえさん<GA>きにいっ<TA!>"
	line "おまえみたいな　<TRAINER>にやったら"
	cont "ボール<WO>つく<TTE>やりたいわい"

	para "いま　てもと<NI>あるのは"
	line "これだけや<GA>とりあえず　も<TTE>け！"
	done

KurtsHouseKurtBallsFromApricornsText:
	text "ガンテツ『わし<WA>ぼんぐり　つか<TTE>"
	line "とくせい<NO>ボール<WO>つくっとる"

	para "そこいら<NO>ぼんぐり<NO>き<WO>しらべ"
	line "み<WO>あつめてくると　ええぞ"
	cont "そしたら　わし<GA>ボールつくったる"
	done

KurtsHouseKurtAskYouHaveAnApricornText:
	text "ガンテツ『おおっ"
	line "ぼんぐり　もっとるやないか！"

	para "よっしゃ　ボール　つくったるわ！"
	done

KurtsHouseKurtItWillTakeADayText:
	text "ガンテツ『ボール<NI>するまで"
	line "１にちほど　かかるからの"
	cont "また　とり<NI>くる<GA>ええぞ"
	done

KurtsHouseKurtThatsALetdownText:
	text "ガンテツ『そうか<⋯>"
	line "なんか　がっかり　したわい"
	done

KurtsHouseKurtDontBotherMeText:
	text "ガンテツ『いま　つくっとるわい"
	line "じゃま<WO>するでないわっ！"
	done

KurtsHouseKurtJustFinishedYourBallText:
	text "ガンテツ『おお　<PLAYER>か"
	line "いまな　ボール<GA>できたばかりや"
	cont "も<TTE>いく<GA>ええぞ！"
	done

KurtsHouseKurtTurnedOutGreatText:
	text "ガンテツ『かいしん<NO>できじゃ！"

	para "それで　つかまえられるか　どうか"
	line "#と　しょうぶ　してみい！"
	done

KurtsGranddaughterSlowpokeGoneText:
	text "ヤドン　いなくなっちゃった<⋯>"
	line "どうしよう<⋯>"
	cont "わるい　ひと<NI>つれさられたの？"
	done

KurtsGranddaughterLonelyText:
	text "おじいちゃん　どこ　いったの<⋯>？"
	line "あたし　さみしいよう<⋯>"
	done

KurtsGranddaughterSlowpokeBackText:
	text "おとうさん<NI>もらった"
	line "あたし<NO>ヤドン　かえ<TTE>き<TA!>"
	cont "シッポも　また　はえてくるの！"
	done

KurtsGranddaughterDadText:
	text "おとうさん　シルフ<TTE>　かいしゃで"
	line "あたらしい　モンスターボールの"
	cont "けんきゅう　してるの"

	para "そのあいだ　あたしは"
	line "おじいちゃんと　ヤドンと　おるすばん"
	done

KurtsHouseSlowpokeText:
	text "ヤドン『<⋯>　<⋯>　やあん？"
	done

KurtsHouseOakPhotoText:
	text "<⋯>　わかいころ<NO>オーキドはかせ？"
	done

KurtsHouseCelebiStatueText:
	text "もりのかみさま<WO>まつ<TTE>ある"
	done

KurtsHouse_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  3,  7, AZALEA_TOWN, 4
	warp_event  4,  7, AZALEA_TOWN, 4

	def_coord_events

	def_bg_events
	bg_event  6,  1, BGEVENT_READ, KurtsHouseRadio
	bg_event  8,  0, BGEVENT_READ, KurtsHouseOakPhoto
	bg_event  9,  0, BGEVENT_READ, KurtsHouseOakPhoto
	bg_event  5,  1, BGEVENT_READ, KurtsHouseBookshelf
	bg_event  2,  1, BGEVENT_READ, KurtsHouseBookshelf
	bg_event  3,  1, BGEVENT_READ, KurtsHouseBookshelf
	bg_event  4,  1, BGEVENT_READ, KurtsHouseCelebiStatue

	def_object_events
	object_event  3,  2, SPRITE_KURT, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, Kurt1, EVENT_KURTS_HOUSE_KURT_1
	object_event  5,  3, SPRITE_TWIN, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, KurtsGranddaughter, -1
	object_event  6,  3, SPRITE_SLOWPOKE, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, KurtsHouseSlowpoke, EVENT_KURTS_HOUSE_SLOWPOKE
	object_event 14,  3, SPRITE_KURT, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, Kurt1, EVENT_KURTS_HOUSE_KURT_2
