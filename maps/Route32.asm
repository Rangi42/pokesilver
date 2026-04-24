	object_const_def
	const ROUTE32_FISHER1
	const ROUTE32_FISHER2
	const ROUTE32_FISHER3
	const ROUTE32_YOUNGSTER1
	const ROUTE32_YOUNGSTER2
	const ROUTE32_YOUNGSTER3
	const ROUTE32_LASS1
	const ROUTE32_COOLTRAINER_M
	const ROUTE32_YOUNGSTER4
	const ROUTE32_FISHER4
	const ROUTE32_POKE_BALL1
	const ROUTE32_FISHER5
	const ROUTE32_FRIEDA
	const ROUTE32_POKE_BALL2

Route32_MapScripts:
	def_scene_scripts
	scene_script Route32Noop1Scene, SCENE_ROUTE32_COOLTRAINER_M_BLOCKS
	scene_script Route32Noop2Scene, SCENE_ROUTE32_OFFER_SLOWPOKETAIL
	scene_script Route32Noop3Scene, SCENE_ROUTE32_NOOP

	def_callbacks
	callback MAPCALLBACK_OBJECTS, Route32FriedaCallback

Route32Noop1Scene:
	end

Route32Noop2Scene:
	end

Route32Noop3Scene:
	end

Route32FriedaCallback:
	readvar VAR_WEEKDAY
	ifequal FRIDAY, .FriedaAppears
	disappear ROUTE32_FRIEDA
	endcallback

.FriedaAppears:
	appear ROUTE32_FRIEDA
	endcallback

Route32CooltrainerMScript:
	faceplayer
Route32CooltrainerMContinueScene:
	opentext
	checkevent EVENT_GOT_MIRACLE_SEED_IN_ROUTE_32
	iftrue .GotMiracleSeed
	checkflag ENGINE_ZEPHYRBADGE
	iffalse .DontHaveZephyrBadge
	checkevent EVENT_GOT_TOGEPI_EGG_FROM_ELMS_AIDE
	iftrue .GiveMiracleSeed
	writetext Route32CooltrainerMText_AideIsWaiting
	waitbutton
	closetext
	end

.GoToSproutTower: ; unreferenced
	writetext Route32CooltrainerMText_UnusedSproutTower
	waitbutton
	closetext
	end

.GiveMiracleSeed:
	writetext Route32CooltrainerMText_HaveThisSeed
	promptbutton
	verbosegiveitem MIRACLE_SEED
	iffalse .BagFull
	setevent EVENT_GOT_MIRACLE_SEED_IN_ROUTE_32
	sjump .GotMiracleSeed

.DontHaveZephyrBadge:
	writetext Route32CooltrainerMText_VioletGym
	waitbutton
	closetext
	end

.GotMiracleSeed:
	writetext Route32CooltrainerMText_ExperiencesShouldBeUseful
	waitbutton
.BagFull:
	closetext
	end

Route32CooltrainerMStopsYouScene:
	turnobject ROUTE32_COOLTRAINER_M, LEFT
	turnobject PLAYER, RIGHT
	opentext
	writetext Route32CooltrainerMText_WhatsTheHurry
	waitbutton
	closetext
	follow PLAYER, ROUTE32_COOLTRAINER_M
	applymovement PLAYER, Movement_Route32CooltrainerMPushesYouBackToViolet
	stopfollow
	turnobject PLAYER, DOWN
	scall Route32CooltrainerMContinueScene
	applymovement ROUTE32_COOLTRAINER_M, Movement_Route32CooltrainerMReset1
	applymovement ROUTE32_COOLTRAINER_M, Movement_Route32CooltrainerMReset2
	end

Route32RoarTMGuyScript:
	faceplayer
	opentext
	checkevent EVENT_GOT_TM05_ROAR
	iftrue .AlreadyHaveRoar
	writetext Text_RoarIntro
	promptbutton
	verbosegiveitem TM_ROAR
	iffalse .Finish
	setevent EVENT_GOT_TM05_ROAR
.AlreadyHaveRoar:
	writetext Text_RoarOutro
	waitbutton
.Finish:
	closetext
	end

Route32WannaBuyASlowpokeTailScript:
	turnobject ROUTE32_FISHER4, DOWN
	turnobject PLAYER, UP
	sjump _OfferToSellSlowpokeTail

SlowpokeTailSalesmanScript:
	faceplayer
_OfferToSellSlowpokeTail:
	setscene SCENE_ROUTE32_NOOP
	opentext
	writetext Text_MillionDollarSlowpokeTail
	yesorno
	iffalse .refused
	writetext Text_ThoughtKidsWereLoaded
	waitbutton
	closetext
	end

.refused
	writetext Text_RefusedToBuySlowpokeTail
	waitbutton
	closetext
	end

TrainerCamperRoland:
	trainer CAMPER, ROLAND, EVENT_BEAT_CAMPER_ROLAND, CamperRolandSeenText, CamperRolandBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext CamperRolandAfterText
	waitbutton
	closetext
	end

TrainerFisherJustin:
	trainer FISHER, JUSTIN, EVENT_BEAT_FISHER_JUSTIN, FisherJustinSeenText, FisherJustinBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext FisherJustinAfterText
	waitbutton
	closetext
	end

TrainerFisherRalph1:
	trainer FISHER, RALPH1, EVENT_BEAT_FISHER_RALPH, FisherRalph1SeenText, FisherRalph1BeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	checkevent EVENT_RALPH_READY_FOR_REMATCH
	iftrue .Rematch
	checkcellnum PHONE_FISHER_RALPH
	iftrue .NumberAccepted
	checkevent EVENT_RALPH_ASKED_FOR_PHONE_NUMBER
	iftrue .AskAgain
	writetext FisherRalphAfterText
	promptbutton
	setevent EVENT_RALPH_ASKED_FOR_PHONE_NUMBER
	scall .AskNumber1
	sjump .AskForNumber

.AskAgain:
	scall .AskNumber2
.AskForNumber:
	askforphonenumber PHONE_FISHER_RALPH
	ifequal PHONE_CONTACTS_FULL, .PhoneFull
	ifequal PHONE_CONTACT_REFUSED, .NumberDeclined
	gettrainername STRING_BUFFER_3, FISHER, RALPH1
	scall .RegisteredNumber
	sjump .NumberAccepted

.Rematch:
	scall .RematchStd
	winlosstext FisherRalph1BeatenText, 0
	checkflag ENGINE_FLYPOINT_LAKE_OF_RAGE
	iftrue .LoadFight2
	checkflag ENGINE_FLYPOINT_ECRUTEAK
	iftrue .LoadFight1
	loadtrainer FISHER, RALPH1
	startbattle
	reloadmapafterbattle
	clearevent EVENT_RALPH_READY_FOR_REMATCH
	end

.LoadFight1:
	loadtrainer FISHER, RALPH2
	startbattle
	reloadmapafterbattle
	clearevent EVENT_RALPH_READY_FOR_REMATCH
	end

.LoadFight2:
	loadtrainer FISHER, RALPH3
	startbattle
	reloadmapafterbattle
	clearevent EVENT_RALPH_READY_FOR_REMATCH
	end

.AskNumber1:
	jumpstd AskNumber1MScript
	end

.AskNumber2:
	jumpstd AskNumber2MScript
	end

.RegisteredNumber:
	jumpstd RegisteredNumberMScript
	end

.NumberAccepted:
	jumpstd NumberAcceptedMScript
	end

.NumberDeclined:
	jumpstd NumberDeclinedMScript
	end

.PhoneFull:
	jumpstd PhoneFullMScript
	end

.RematchStd:
	jumpstd RematchMScript
	end

TrainerFisherHenry:
	trainer FISHER, HENRY, EVENT_BEAT_FISHER_HENRY, FisherHenrySeenText, FisherHenryBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext FisherHenryAfterText
	waitbutton
	closetext
	end

TrainerPicnickerLiz1:
	trainer PICNICKER, LIZ1, EVENT_BEAT_PICNICKER_LIZ, PicnickerLiz1SeenText, PicnickerLiz1BeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	checkevent EVENT_LIZ_READY_FOR_REMATCH
	iftrue .Rematch
	checkcellnum PHONE_PICNICKER_LIZ
	iftrue .NumberAccepted
	checkevent EVENT_LIZ_ASKED_FOR_PHONE_NUMBER
	iftrue .AskAgain
	writetext PicnickerLiz1AfterText
	promptbutton
	setevent EVENT_LIZ_ASKED_FOR_PHONE_NUMBER
	scall .AskNumber1
	sjump .AskForNumber

.AskAgain:
	scall .AskNumber2
.AskForNumber:
	askforphonenumber PHONE_PICNICKER_LIZ
	ifequal PHONE_CONTACTS_FULL, .PhoneFull
	ifequal PHONE_CONTACT_REFUSED, .NumberDeclined
	gettrainername STRING_BUFFER_3, PICNICKER, LIZ1
	scall .RegisteredNumber
	sjump .NumberAccepted

.Rematch:
	scall .RematchStd
	winlosstext PicnickerLiz1BeatenText, 0
	checkevent EVENT_CLEARED_ROCKET_HIDEOUT
	iftrue .LoadFight2
	checkflag ENGINE_FLYPOINT_ECRUTEAK
	iftrue .LoadFight1
	loadtrainer PICNICKER, LIZ1
	startbattle
	reloadmapafterbattle
	clearevent EVENT_LIZ_READY_FOR_REMATCH
	end

.LoadFight1:
	loadtrainer PICNICKER, LIZ2
	startbattle
	reloadmapafterbattle
	clearevent EVENT_LIZ_READY_FOR_REMATCH
	end

.LoadFight2:
	loadtrainer PICNICKER, LIZ3
	startbattle
	reloadmapafterbattle
	clearevent EVENT_LIZ_READY_FOR_REMATCH
	end

.AskNumber1:
	jumpstd AskNumber1FScript
	end

.AskNumber2:
	jumpstd AskNumber2FScript
	end

.RegisteredNumber:
	jumpstd RegisteredNumberFScript
	end

.NumberAccepted:
	jumpstd NumberAcceptedFScript
	end

.NumberDeclined:
	jumpstd NumberDeclinedFScript
	end

.PhoneFull:
	jumpstd PhoneFullFScript
	end

.RematchStd:
	jumpstd RematchFScript
	end

TrainerYoungsterAlbert:
	trainer YOUNGSTER, ALBERT, EVENT_BEAT_YOUNGSTER_ALBERT, YoungsterAlbertSeenText, YoungsterAlbertBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext YoungsterAlbertAfterText
	waitbutton
	closetext
	end

TrainerYoungsterGordon:
	trainer YOUNGSTER, GORDON, EVENT_BEAT_YOUNGSTER_GORDON, YoungsterGordonSeenText, YoungsterGordonBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext YoungsterGordonAfterText
	waitbutton
	closetext
	end

TrainerBirdKeeperPeter:
	trainer BIRD_KEEPER, PETER, EVENT_BEAT_BIRD_KEEPER_PETER, BirdKeeperPeterSeenText, BirdKeeperPeterBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext BirdKeeperPeterAfterText
	waitbutton
	closetext
	end

FriedaScript:
	faceplayer
	opentext
	checkevent EVENT_GOT_POISON_BARB_FROM_FRIEDA
	iftrue .Friday
	readvar VAR_WEEKDAY
	ifnotequal FRIDAY, .NotFriday
	checkevent EVENT_MET_FRIEDA_OF_FRIDAY
	iftrue .MetFrieda
	writetext MeetFriedaText
	promptbutton
	setevent EVENT_MET_FRIEDA_OF_FRIDAY
.MetFrieda:
	writetext FriedaGivesGiftText
	promptbutton
	verbosegiveitem POISON_BARB
	iffalse .Done
	setevent EVENT_GOT_POISON_BARB_FROM_FRIEDA
	writetext FriedaGaveGiftText
	waitbutton
	closetext
	end

.Friday:
	writetext FriedaFridayText
	waitbutton
.Done:
	closetext
	end

.NotFriday:
	writetext FriedaNotFridayText
	waitbutton
	closetext
	end

Route32GreatBall:
	itemball GREAT_BALL

Route32Potion:
	itemball POTION

Route32Sign:
	jumptext Route32SignText

Route32RuinsSign:
	jumptext Route32RuinsSignText

Route32UnionCaveSign:
	jumptext Route32UnionCaveSignText

Route32PokecenterSign:
	jumpstd PokecenterSignScript

Route32HiddenGreatBall:
	hiddenitem GREAT_BALL, EVENT_ROUTE_32_HIDDEN_GREAT_BALL

Route32HiddenSuperPotion:
	hiddenitem SUPER_POTION, EVENT_ROUTE_32_HIDDEN_SUPER_POTION

Movement_Route32CooltrainerMPushesYouBackToViolet:
	step UP
	step UP
	step_end

Movement_Route32CooltrainerMReset1:
	step DOWN
	step_end

Movement_Route32CooltrainerMReset2:
	step RIGHT
	step_end

Route32CooltrainerMText_WhatsTheHurry:
	text "かーっ！！"
	line "またれいーっ！！"
	done

Route32CooltrainerMText_AideIsWaiting:
	text "<PLAYER>と<WA>おぬし<NO>ことだな？"
	line "おぬし<WO>さがしとる"
	cont "メガネ<NO>おとこ<GA>おったぞ"

	para "#センターで"
	line "おぬし<WO>ま<TTE>いるだろう"
	cont "い<TTE>みなさい！"
	done

Route32CooltrainerMText_UnusedSproutTower:
	text "マダツボミのとう　に<WA>いったのか？"
	line "キキョウによれば　マダツボミのとうで"
	cont "しゅぎょう　する"

	para "<TRAINER><NO>じょうしき　ではないか"
	line "い<TTE>みなさい！"
	done

Route32CooltrainerMText_VioletGym:
	text "#ジム　に<WA>いったのか？"
	line "#ジム<NI>よ<TTE>"
	cont "おのれと　#<WO>きたえる"

	para "<TRAINER><NO>じょうしき　ではないか"
	line "い<TTE>みなさい！"
	done

Route32CooltrainerMText_HaveThisSeed:
	text "うむ　いい#<WO>つれておる"
	line "それも　これも　キキョウで"
	cont "いろいろ　きたえたからだろう"

	para "とく<NI>#ジム　での"
	line "しゅぎょう<WA>ため<NI>なったはず"

	para "よし！　キキョウにきた　きねんだ"
	line "これ<WO>も<TTE>いきなさい"

	para "#<NI>もたせると"
	line "くさタイプ<NO>わざ<NO>いりょくが"
	cont "あがる　という　しろものだ！"
	done

Route32CooltrainerMText_ExperiencesShouldBeUseful:
	text "キキョウで<NO>けいけんは"
	line "そなた<NO>たび<NI>やくだつであろう"
	done

Text_MillionDollarSlowpokeTail:
	text "うまくて　えいようまんてんの"
	line "おいしいシッポ<WA>いらない？"

	para "いまなら　たった<NO>１００まん円"
	line "どう　かうでしょ？"
	done

Text_ThoughtKidsWereLoaded:
	text "おかね　たりないぞ！"

	para "ちっ！　さいきん<NO>こどもは"
	line "かねもちだと　おも<TTE>たが<⋯>"
	done

Text_RefusedToBuySlowpokeTail:
	text "いらないのか！"
	line "じゃあ　あっち　いっ<TA!>　いっ<TA!>"
	done

FisherJustinSeenText:
	text "うわっ！"

	para "おどろかすから　えもの<GA>にげたぞ！"
	done

FisherJustinBeatenText:
	text "どぼん！"
	done

FisherJustinAfterText:
	text "あわてず　さわがず<⋯>"

	para "つりも　#も"
	line "ごくい<WA>いっしょ　だな"
	done

FisherRalph1SeenText:
	text "つりも　とくい　だが"
	line "#<WA>もっと　とくい　だよ！"
	done

FisherRalph1BeatenText:
	text "しかけ<WO>あせった<⋯>"
	done

FisherRalphAfterText:
	text "つり<WA>いっしょう<NO>たのしみ！"
	line "#<WA>いっしょう<NO>ともだち！"
	done

Route32UnusedFisher1SeenText: ; unreferenced
	text "おなじ　#しか　つれない<⋯>"
	line "きばらし<NI>ちょっと　たたかうか<⋯>"
	done

Route32UnusedFisher1BeatenText: ; unreferenced
	text "ダメな　ときは"
	line "な<NI>や<TTE>も　ダメかあ"
	done

Route32UnusedFisher1AfterText: ; unreferenced
	text "となり<NO>つりびと"
	line "なんで　いい　#<GA>つれるの？"
	done

Route32UnusedFisher2SeenText: ; unreferenced
	text "きょう<WA>ぜっこうちょう　だな"
	line "おーし　ちょっと　たたかうか！"
	done

Route32UnusedFisher2BeatenText: ; unreferenced
	text "あらら"
	line "しょうぶ<WA>ダメかあ"
	done

Route32UnusedFisher2AfterText: ; unreferenced
	text "いい　#<WO>つりたきゃ"
	line "いい　つりざお<WO>つかわないと！"
	done

FisherHenrySeenText:
	text "わし<NO>#"
	line "とれたて<NO>ぴちぴち！"
	done

FisherHenryBeatenText:
	text "ばしゃばしゃ"
	done

FisherHenryAfterText:
	text "つかまえた　ばかりじゃ"
	line "そだてた　#に<WA>かなわんなあ"
	done

YoungsterAlbertSeenText:
	text "みかけない　かお　だな"
	line "おまえ　つよいの？"
	done

YoungsterAlbertBeatenText:
	text "つよい　なあ！"
	done

YoungsterAlbertAfterText:
	text "おれ<WA>じぶん<NO>すきな　#で"
	line "さいきょう<WO>めざすッ！"

	para "つよいから<TTE>　みんなと　おなじ"
	line "#<WA>つかわないぜ"
	done

YoungsterGordonSeenText:
	text "くさむらで　いい#　みつけ<TA!>"
	line "なんか　や<TTE>くれそうだぜ！"
	done

YoungsterGordonBeatenText:
	text "あーあ"
	line "かてると　おもったのに"
	done

YoungsterGordonAfterText:
	text "くさむら　あるいてると"
	line "くっつきむし　いっぱい　なんだよな"
	done

CamperRolandSeenText:
	text "そ<NO>しせん<⋯>"
	line "なんだか　き<NI>なるなあ"
	done

CamperRolandBeatenText:
	text "うーん　ざんねん"
	done

CamperRolandAfterText:
	text "たたかいたく　なかったら"
	line "しせん<WO>あわさなければ　いいんだよ"
	done

PicnickerLiz1SeenText:
	text "<⋯>　そうそう"
	line "でね　そうなのよー"

	para "えっ　なに？　#しょうぶ？"
	line "もう　でんわ　してるのに"
	cont "いいわ　さっさと　おわらせちゃうから"
	done

PicnickerLiz1BeatenText:
	text "もう！　むき<NI>なんないでよ！"
	line "おんなのこ　あいてに！"
	done

PicnickerLiz1AfterText:
	text "たのしく　おはなし　してたのに"
	done

BirdKeeperPeterSeenText:
	text "おや　そ<NO>バッジは<⋯>"

	para "キキョウ<NO>ジムバッジ！"
	line "おまえ　ハヤトさん<NI>かったのか！"
	done

BirdKeeperPeterBeatenText:
	text "じぶん<NO>みじゅくさ　わかったよ"
	done

BirdKeeperPeterAfterText:
	text "キキョウ<NO>#ジムで"
	line "きたえなおすと　するか"
	done

Route32UnusedText: ; unreferenced
	text "つり<NO>じゃま！"
	line "<TTE>　おこられちゃったよ<⋯>"
	done

Text_RoarIntro:
	text "うおおおっ！"

	para "ほえると　みんな　にげだすけど"
	line "きみ<WA>きてくれたあああっ！"
	cont "かんどう　だあああっ！"
	cont "これ<WO>も<TTE>い<TTE>よおおおっ！"
	done

Text_RoarOutro:
	text "うおおおっ！"
	line "なかみ<WA>ほえる！"
	cont "ほえると　#も　にげだすよ"
	done

MeetFriedaText:
	text "カネコ『やっほー！"

	para "あたし　きんようび<NO>カネコ！"
	line "よろしくねー！"
	done

FriedaGivesGiftText:
	text "はい　どくバリ！"
	line "キミ<NI>あげるよっ！"
	done

FriedaGaveGiftText:
	text "カネコ『どくタイプのわざ<WO>おぼえた"
	line "#<NI>もたせて　ごらん！"

	para "あっ！"

	para "と　びっくり！"

	para "わざ<NO>いりょく<GA>つよくなるんだ！"
	done

FriedaFridayText:
	text "カネコ『ども　ども！"
	line "キミ<TTE>　なんようび<GA>すき？"

	para "あたし<WA>きんようびだな！"
	line "ぜったい！"

	para "そう　おもわない？"
	done

FriedaNotFridayText:
	text "カネコ『きょう<WA>きんようびじゃ"
	line "ないのー？"
	cont "つまんないー"
	done

Route32SignText:
	text "<KOKO_WA>３２<ROUTE>"
	line "キキョウシティ　<⋯>　ヒワダタウン"
	done

Route32RuinsSignText:
	text "アルフ<NO>いせき"
	line "ひがしがわ　いりぐち"
	done

Route32UnionCaveSignText:
	text "このさき　つながり<NO>どうくつ"
	done

Route32_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event 11, 73, ROUTE_32_POKECENTER_1F, 1
	warp_event  4,  2, ROUTE_32_RUINS_OF_ALPH_GATE, 3
	warp_event  4,  3, ROUTE_32_RUINS_OF_ALPH_GATE, 4
	warp_event  6, 79, UNION_CAVE_1F, 4

	def_coord_events
	coord_event 18,  8, SCENE_ROUTE32_COOLTRAINER_M_BLOCKS, Route32CooltrainerMStopsYouScene
	coord_event  7, 71, SCENE_ROUTE32_OFFER_SLOWPOKETAIL, Route32WannaBuyASlowpokeTailScript

	def_bg_events
	bg_event 13,  5, BGEVENT_READ, Route32Sign
	bg_event  9,  1, BGEVENT_READ, Route32RuinsSign
	bg_event 10, 84, BGEVENT_READ, Route32UnionCaveSign
	bg_event 12, 73, BGEVENT_READ, Route32PokecenterSign
	bg_event 12, 67, BGEVENT_ITEM, Route32HiddenGreatBall
	bg_event 11, 40, BGEVENT_ITEM, Route32HiddenSuperPotion

	def_object_events
	object_event  8, 49, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_TRAINER, 1, TrainerFisherJustin, -1
	object_event 12, 56, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_TRAINER, 3, TrainerFisherRalph1, -1
	object_event  6, 48, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_TRAINER, 1, TrainerFisherHenry, -1
	object_event 13, 23, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 3, TrainerYoungsterAlbert, -1
	object_event  4, 65, SPRITE_YOUNGSTER, SPRITEMOVEDATA_SPINCLOCKWISE, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 3, TrainerYoungsterGordon, -1
	object_event  1, 56, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_TRAINER, 4, TrainerCamperRoland, -1
	object_event 10, 30, SPRITE_LASS, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_TRAINER, 1, TrainerPicnickerLiz1, -1
	object_event 19,  8, SPRITE_COOLTRAINER_M, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, Route32CooltrainerMScript, -1
	object_event 11, 82, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 3, TrainerBirdKeeperPeter, -1
	object_event  7, 70, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, SlowpokeTailSalesmanScript, EVENT_SLOWPOKE_WELL_ROCKETS
	object_event  6, 53, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, Route32GreatBall, EVENT_ROUTE_32_GREAT_BALL
	object_event 15, 13, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, Route32RoarTMGuyScript, -1
	object_event 12, 67, SPRITE_LASS, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, FriedaScript, EVENT_ROUTE_32_FRIEDA_OF_FRIDAY
	object_event  3, 30, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, Route32Potion, EVENT_ROUTE_32_POTION
