	object_const_def
	const AZALEAPOKECENTER1F_NURSE
	const AZALEAPOKECENTER1F_GENTLEMAN
	const AZALEAPOKECENTER1F_FISHING_GURU
	const AZALEAPOKECENTER1F_POKEFAN_F

AzaleaPokecenter1F_MapScripts:
	def_scene_scripts
	scene_script AzaleaPokecenter1FNoopScene ; unusable

	def_callbacks

AzaleaPokecenter1FNoopScene:
	end

AzaleaPokecenter1FNurseScript:
	jumpstd PokecenterNurseScript

AzaleaPokecenter1FGentlemanScript:
	jumptextfaceplayer AzaleaPokecenter1FGentlemanText

AzaleaPokecenter1FFishingGuruScript:
	jumptextfaceplayer AzaleaPokecenter1FFishingGuruText

AzaleaPokecenter1FPokefanFScript:
	jumptextfaceplayer AzaleaPokecenter1FPokefanFText

AzaleaPokecenter1FGentlemanText:
	text "きみの#　ひでんと　よばれる　"
	line "わざ<WA>おぼえてるかね"

	para "#<WA>ひんし<NO>ときでも"
	line "たたかう　げんき<GA>ない　だけで"
	cont "ひでん<WA>つかえるそうだよ"
	done

AzaleaPokecenter1FFishingGuruText:
	text "マサキの<PC>　つかうと"
	line "１つ<NO>ボックス<NI>３０ぴきまで"
	cont "#　あずけられるぞ！"
	done

AzaleaPokecenter1FPokefanFText:
	text "あなた　ぼんぐり<TTE>　ごぞんじ？"

	para "ぼんぐり<NO>きのみ<WO>わ<TTE>"
	line "なかみ<WO>とりだして"
	cont "とくしゅな　そうち<WO>うめこむの"

	para "すると　#<WO>つかまえることが"
	line "できるよう<NI>なるの！"

	para "モンスターボール<GA>うられるまで"
	line "みんな　ぼんぐり　つか<TTE>"
	cont "#<WO>つかまえてたのよ"
	done

AzaleaPokecenter1F_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  3,  7, AZALEA_TOWN, 1
	warp_event  4,  7, AZALEA_TOWN, 1
	warp_event  0,  7, POKECENTER_2F, 1

	def_coord_events

	def_bg_events

	def_object_events
	object_event  3,  1, SPRITE_NURSE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, AzaleaPokecenter1FNurseScript, -1
	object_event  9,  6, SPRITE_GENTLEMAN, SPRITEMOVEDATA_WALK_UP_DOWN, 0, 1, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, AzaleaPokecenter1FGentlemanScript, -1
	object_event  6,  1, SPRITE_FISHING_GURU, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, AzaleaPokecenter1FFishingGuruScript, -1
	object_event  1,  4, SPRITE_POKEFAN_F, SPRITEMOVEDATA_WANDER, 1, 2, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, AzaleaPokecenter1FPokefanFScript, -1
