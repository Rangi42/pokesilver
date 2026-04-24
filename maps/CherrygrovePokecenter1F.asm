	object_const_def
	const CHERRYGROVEPOKECENTER1F_NURSE
	const CHERRYGROVEPOKECENTER1F_FISHER
	const CHERRYGROVEPOKECENTER1F_GENTLEMAN
	const CHERRYGROVEPOKECENTER1F_TEACHER

CherrygrovePokecenter1F_MapScripts:
	def_scene_scripts

	def_callbacks

CherrygrovePokecenter1FNurseScript:
	jumpstd PokecenterNurseScript

CherrygrovePokecenter1FFisherScript:
	jumptextfaceplayer CherrygrovePokecenter1FFisherText

CherrygrovePokecenter1FGentlemanScript:
	jumptextfaceplayer CherrygrovePokecenter1FGentlemanText

CherrygrovePokecenter1FTeacherScript:
	faceplayer
	opentext
	checkevent EVENT_GAVE_MYSTERY_EGG_TO_ELM
	iftrue .CommCenterOpen
	writetext CherrygrovePokecenter1FTeacherText
	waitbutton
	closetext
	end

.CommCenterOpen:
	writetext CherrygrovePokecenter1FTeacherText_CommCenterOpen
	waitbutton
	closetext
	end

CherrygrovePokecenter1FFisherText:
	text "#　なんびき　あずけても　"
	line "ただ　なの<WA>うれしいなあ"
	done

CherrygrovePokecenter1FGentlemanText:
	text "あそこ<NI>おかれた　<PC>は"
	line "#<TRAINER>なら　だれでも"
	cont "じゆう<NI>つか<TTE>　いいのだよ！"
	done

CherrygrovePokecenter1FTeacherText:
	text "２かい<NO>つうしんセンターは"
	line "つい　さいきん　できたの"

	para "でも　まだ"
	line "ちょうせいちゅう　です<TTE>"
	done

CherrygrovePokecenter1FTeacherText_CommCenterOpen:
	text "２かい<NO>つうしんセンターは"
	line "つい　さいきん　できたの"

	para "あたし　さっそく"
	line "#こうかん　しちゃっ<TA!>"
	done

CherrygrovePokecenter1F_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  3,  7, CHERRYGROVE_CITY, 2
	warp_event  4,  7, CHERRYGROVE_CITY, 2
	warp_event  0,  7, POKECENTER_2F, 1

	def_coord_events

	def_bg_events

	def_object_events
	object_event  3,  1, SPRITE_NURSE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, CherrygrovePokecenter1FNurseScript, -1
	object_event  2,  3, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, CherrygrovePokecenter1FFisherScript, -1
	object_event  8,  6, SPRITE_GENTLEMAN, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, CherrygrovePokecenter1FGentlemanScript, -1
	object_event  1,  6, SPRITE_TEACHER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, CherrygrovePokecenter1FTeacherScript, -1
