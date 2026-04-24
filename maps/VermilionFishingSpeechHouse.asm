	object_const_def
	const VERMILIONFISHINGSPEECHHOUSE_FISHING_GURU

VermilionFishingSpeechHouse_MapScripts:
	def_scene_scripts

	def_callbacks

FishingDude:
	jumptextfaceplayer FishingDudeText

FishingDudesHousePhoto:
	jumptext FishingDudesHousePhotoText

FishingDudesHouseBookshelf: ; unreferenced
	jumpstd PictureBookshelfScript

FishingDudeText:
	text "わし<WA>つりオヤジ！"
	line "つりずき　きょうだい<NO>あに！"

	para "きみ<WA>４４ばんどうろ<NI>いた"
	line "つりびと<NO>ヒデノリ　し<TTE>る？"

	para "あいつ<GA>でんわで　おしえてくれる"
	line "つりじょうほう<WA>すごいよ"

	para "めずらしーい　#　つれまくり！"
	line "まさ<NI>いれぐい　だったよ！"
	done

FishingDudesHousePhotoText:
	text "つり<WO>している　ひとが"
	line "うつ<TTE>いる<⋯>"
	cont "すごく　たのしそうだ"
	done

VermilionFishingSpeechHouse_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  2,  7, VERMILION_CITY, 1
	warp_event  3,  7, VERMILION_CITY, 1

	def_coord_events

	def_bg_events
	bg_event  3,  0, BGEVENT_READ, FishingDudesHousePhoto

	def_object_events
	object_event  2,  4, SPRITE_FISHING_GURU, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, FishingDude, -1
