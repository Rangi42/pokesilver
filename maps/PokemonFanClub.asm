	object_const_def
	const POKEMONFANCLUB_CHAIRMAN
	const POKEMONFANCLUB_RECEPTIONIST
	const POKEMONFANCLUB_CLEFAIRY_GUY
	const POKEMONFANCLUB_TEACHER
	const POKEMONFANCLUB_FAIRY
	const POKEMONFANCLUB_ODDISH

PokemonFanClub_MapScripts:
	def_scene_scripts

	def_callbacks

PokemonFanClubChairmanScript:
	faceplayer
	opentext
	checkevent EVENT_LISTENED_TO_FAN_CLUB_PRESIDENT
	iftrue .HeardSpeech
	checkevent EVENT_LISTENED_TO_FAN_CLUB_PRESIDENT_BUT_BAG_WAS_FULL
	iftrue .HeardSpeechButBagFull
	writetext PokemonFanClubChairmanDidYouVisitToHearAboutMyMonText
	yesorno
	iffalse .NotListening
	writetext PokemonFanClubChairmanRapidashText
	promptbutton
.HeardSpeechButBagFull:
	writetext PokemonFanClubChairmanIWantYouToHaveThisText
	promptbutton
	verbosegiveitem RARE_CANDY
	iffalse .BagFull
	setevent EVENT_LISTENED_TO_FAN_CLUB_PRESIDENT
	writetext PokemonFanClubChairmanItsARareCandyText
	waitbutton
	closetext
	end

.HeardSpeech:
	writetext PokemonFanClubChairmanMoreTalesToTellText
	waitbutton
	closetext
	end

.NotListening:
	writetext PokemonFanClubChairmanHowDisappointingText
	waitbutton
.BagFull:
	closetext
	end

PokemonFanClubReceptionistScript:
	jumptextfaceplayer PokemonFanClubReceptionistText

PokemonFanClubClefairyGuyScript:
	faceplayer
	opentext
	checkevent EVENT_GOT_LOST_ITEM_FROM_FAN_CLUB
	iftrue .GotLostItem
	checkevent EVENT_RETURNED_MACHINE_PART
	iftrue .FoundClefairyDoll
	writetext PokemonFanClubClefairyGuyClefairyIsSoAdorableText
	waitbutton
	closetext
	end

.FoundClefairyDoll:
	writetext PokemonFanClubClefairyGuyMakingDoWithADollIFoundText
	checkevent EVENT_MET_COPYCAT_FOUND_OUT_ABOUT_LOST_ITEM
	iftrue .MetCopycat
	waitbutton
	closetext
	end

.MetCopycat:
	promptbutton
	writetext PokemonFanClubClefairyGuyTakeThisDollBackToGirlText
	promptbutton
	waitsfx
	giveitem LOST_ITEM
	iffalse .NoRoom
	disappear POKEMONFANCLUB_FAIRY
	writetext PokemonFanClubPlayerReceivedDollText
	playsound SFX_KEY_ITEM
	waitsfx
	itemnotify
	setevent EVENT_GOT_LOST_ITEM_FROM_FAN_CLUB
	closetext
	end

.GotLostItem:
	writetext PokemonFanClubClefairyGuyGoingToGetARealClefairyText
	waitbutton
	closetext
	end

.NoRoom:
	writetext PokemonFanClubClefairyGuyPackIsJammedFullText
	waitbutton
	closetext
	end

PokemonFanClubTeacherScript:
	jumptextfaceplayer PokemonFanClubTeacherText

PokemonFanClubClefairyDollScript:
	jumptext PokemonFanClubClefairyDollText

PokemonFanClubBayleefScript:
	opentext
	writetext PokemonFanClubBayleefText
	cry BAYLEEF
	waitbutton
	closetext
	end

PokemonFanClubListenSign:
	jumptext PokemonFanClubListenSignText

PokemonFanClubBraggingSign:
	jumptext PokemonFanClubBraggingSignText

PokemonFanClubChairmanDidYouVisitToHearAboutMyMonText:
	text "#　だいすき　クラブの"
	line "かいちょう<WA>わし　じゃ！"

	para "そだてた　#は"
	line "１５０ぴき<WO>こえとる！"

	para "#<NI>かんしては"
	line "ホント　うるさい　ですぞ！"

	para "きみ<WA>わし<NO>#　じまんを"
	line "きき<NI>きた<NO>かね？"
	done

PokemonFanClubChairmanRapidashText:
	text "そうか！"
	line "で<WA>さっそく　はじめるか！"

	para "あのな<⋯>　わし<NO>おきにいりの"
	line "ギャロップがな<⋯>　<⋯>"

	para "<⋯>　でな<⋯>　が<⋯>"
	line "<⋯>　<⋯>　かわいくてな<⋯>"
	cont "たまらん<⋯>　くう<⋯>"
	cont "<⋯>　さらに<⋯>　もう<⋯>"
	cont "すごすぎ<⋯>　<⋯>　で<⋯>"
	cont "<⋯>　そう　おもうか<⋯>"
	cont "<⋯>　はー！"

	para "<⋯>　<⋯>　だきしめて<⋯>"
	line "ねるときも<⋯>"
	cont "おフロのときも<⋯>"
	cont "<⋯>　じゃろ<⋯>　<⋯>"
	cont "<⋯>　<⋯>　すばらし<⋯>！"
	cont "<⋯>　うつくし<⋯>"
	cont "<⋯>　<⋯>　ありゃ！"
	cont "もう　こんな　じかんか！"
	cont "ちょっと　しゃべり　すぎたわい！"
	done

PokemonFanClubChairmanIWantYouToHaveThisText:
	text "わし<NO>#　じまんを"
	line "おとなしく　きいてた　おれいに"
	cont "<⋯>これ<WA>きもち　じゃ！"
	done

PokemonFanClubChairmanItsARareCandyText:
	text "#<GA>つよくなる"
	line "ふしぎな　アメ　じゃ！"

	para "いっしょ<NI>たたか<TTE>"
	line "つよくなる　ほうが"
	cont "わし<WA>すきなのでな"

	para "そ<NO>アメ<WA>きみ<NI>あげよう！"
	done

PokemonFanClubChairmanMoreTalesToTellText:
	text "やー　やー　<PLAYER>くん！"

	para "また　わし<NO>#　じまんを"
	line "きき<NI>きた<NO>かね！"

	para "<⋯>　え？　ちがう？"
	line "なんじゃ<⋯>　つまらん"
	done

PokemonFanClubChairmanHowDisappointingText:
	text "なんじゃ　つまらん<⋯>"
	line "きく　き<NI>なったら　きてくれい！"
	done

PokemonFanClubReceptionistText:
	text "うち<NO>かいちょうは"
	line "ホント　#<NI>うるさいの！"
	done

PokemonFanClubClefairyGuyClefairyIsSoAdorableText:
	text "ゆび<WO>ふ<TTE>る"
	line "しぐさ　と　いったら<⋯>"
	cont "むふー！"
	cont "ピッピ　たまらーん！"
	done

PokemonFanClubClefairyGuyMakingDoWithADollIFoundText:
	text "ピッピ<GA>だいすき　だけど"
	line "どうしても　つかまえられなくて"

	para "しょうがない　から"
	line "ひろった　ピッピにんぎょうで"
	cont "ガマン　してるんだ<⋯>"
	done

PokemonFanClubClefairyGuyTakeThisDollBackToGirlText:
	text "そうか　こ<NO>にんぎょうを"
	line "おとした　おんなのこが"
	cont "かなしんで　いるんだ<⋯>"

	para "わかったよ！"
	line "ピッピにんぎょう<WO>そのこに"
	cont "かえしてあげて！"

	para "ぼく<WA>じぶん<NO>ちからで"
	line "ピッピと　ともだち<NI>なるよ！"
	done

PokemonFanClubPlayerReceivedDollText:
	text "<PLAYER>は"
	line "ピッピにんぎょう<WO>あずかっ<TA!>"
	done

PokemonFanClubClefairyGuyGoingToGetARealClefairyText:
	text "ほんもの<NO>ピッピと"
	line "ぜったい<NI>ともだち<NI>なるぞ！"
	done

PokemonFanClubClefairyGuyPackIsJammedFullText:
	text "きみ<NO>リュック"
	line "いっぱい　だよ！"
	done

PokemonFanClubTeacherText:
	text "みて　みて！"
	line "<WATASHI><NO>ベイリーフ！"

	para "あたま<NO>はっぱが"
	line "すっごく　キュート！"
	done

PokemonFanClubClefairyDollText:
	text "ピッピだ！"
	line "<⋯>　？"

	para "なんだ　ピッピにんぎょう　だ！"
	done

PokemonFanClubBayleefText:
	text "ベイリーフ『り　りーふ！"
	done

PokemonFanClubListenSignText:
	text "かいぬし<NO>じまん　ばなしには"
	line "しずか<NI>みみ<WO>かたむけよう！"
	done

PokemonFanClubBraggingSignText:
	text "ひと<NO>じまん　ばなしは"
	line "１０ばい　にして　かえそう！"
	done

PokemonFanClub_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  2,  7, VERMILION_CITY, 3
	warp_event  3,  7, VERMILION_CITY, 3

	def_coord_events

	def_bg_events
	bg_event  7,  0, BGEVENT_READ, PokemonFanClubListenSign
	bg_event  9,  0, BGEVENT_READ, PokemonFanClubBraggingSign

	def_object_events
	object_event  3,  1, SPRITE_GENTLEMAN, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, PokemonFanClubChairmanScript, -1
	object_event  4,  1, SPRITE_RECEPTIONIST, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, PokemonFanClubReceptionistScript, -1
	object_event  2,  3, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, PokemonFanClubClefairyGuyScript, -1
	object_event  7,  2, SPRITE_TEACHER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, PokemonFanClubTeacherScript, -1
	object_event  2,  4, SPRITE_FAIRY, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, PokemonFanClubClefairyDollScript, EVENT_VERMILION_FAN_CLUB_DOLL
	object_event  7,  3, SPRITE_ODDISH, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, PokemonFanClubBayleefScript, -1
