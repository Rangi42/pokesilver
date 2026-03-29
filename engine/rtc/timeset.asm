DEF TIMESET_UP_ARROW   EQU '♂' ; $ef
DEF TIMESET_DOWN_ARROW EQU '♀' ; $f5

InitClock:
; Ask the player to set the time.
	ldh a, [hInMenu]
	push af
	ld a, $1
	ldh [hInMenu], a

	ld a, FALSE
	ld [wSpriteUpdatesEnabled], a
	ld a, $10
	ld [wMusicFade], a
	ld a, LOW(MUSIC_NONE)
	ld [wMusicFadeID], a
	ld a, HIGH(MUSIC_NONE)
	ld [wMusicFadeID + 1], a
	ld c, 8
	call DelayFrames
	call RotateFourPalettesLeft
	call ClearTilemap
	call ClearSprites
	xor a
	ldh [hBGMapMode], a
	call LoadStandardFont
	ld de, TimeSetBackgroundGFX
	ld hl, vTiles2 tile $00
	lb bc, BANK(TimeSetBackgroundGFX), 1
	call Request1bpp
	ld de, TimeSetUpArrowGFX
	ld hl, vTiles2 tile $01
	lb bc, BANK(TimeSetUpArrowGFX), 1
	call Request1bpp
	ld de, TimeSetDownArrowGFX
	ld hl, vTiles2 tile $02
	lb bc, BANK(TimeSetDownArrowGFX), 1
	call Request1bpp
	call .ClearScreen
	call WaitBGMap
	call RotateFourPalettesRight
	ld hl, OakTimeWokeUpText
	call PrintText
	ld hl, wTimeSetBuffer
	ld bc, wTimeSetBufferEnd - wTimeSetBuffer
	xor a
	call ByteFill
	ld a, 10 ; default hour = 10 AM
	ld [wInitHourBuffer], a

.loop
	ld hl, OakTimeWhatTimeIsItText
	call PrintText
	hlcoord 12, 7
	lb bc, 2, 6
	call Textbox
	hlcoord 16, 7
	ld [hl], $1
	hlcoord 16, 10
	ld [hl], $2
	hlcoord 13, 9
	call DisplayHourOClock
	ld c, 10
	call DelayFrames

.SetHourLoop:
	call JoyTextDelay
	call SetHour
	jr nc, .SetHourLoop

	ld a, [wInitHourBuffer]
	ld [wStringBuffer2 + 1], a
	call .ClearScreen
	ld hl, OakTimeWhatHoursText
	call PrintText
	call YesNoBox
	jr nc, .HourIsSet
	call .ClearScreen
	jr .loop

.HourIsSet:
	ld hl, OakTimeHowManyMinutesText
	call PrintText
	hlcoord 12, 7
	lb bc, 2, 6
	call Textbox
	hlcoord 16, 7
	ld [hl], $1
	hlcoord 16, 10
	ld [hl], $2
	hlcoord 14, 9
	call DisplayMinutesWithMinString
	ld c, 10
	call DelayFrames

.SetMinutesLoop:
	call JoyTextDelay
	call SetMinutes
	jr nc, .SetMinutesLoop

	ld a, [wInitMinuteBuffer]
	ld [wStringBuffer2 + 2], a
	call .ClearScreen
	ld hl, OakTimeWhoaMinutesText
	call PrintText
	call YesNoBox
	jr nc, .MinutesAreSet
	call .ClearScreen
	jr .HourIsSet

.MinutesAreSet:
	call InitTimeOfDay
	ld hl, OakText_ResponseToSetTime
	call PrintText
	call WaitPressAorB_BlinkCursor
	pop af
	ldh [hInMenu], a
	ret

.ClearScreen:
	xor a
	ldh [hBGMapMode], a
	hlcoord 0, 0
	ld bc, SCREEN_AREA
	xor a
	call ByteFill
	ld a, $1
	ldh [hBGMapMode], a
	ret

SetHour:
	ldh a, [hJoyPressed]
	and PAD_A
	jr nz, .Confirm

	ld hl, hJoyLast
	ld a, [hl]
	and PAD_UP
	jr nz, .up
	ld a, [hl]
	and PAD_DOWN
	jr nz, .down
	call DelayFrame
	and a
	ret

.down
	ld hl, wInitHourBuffer
	ld a, [hl]
	and a
	jr nz, .DecreaseThroughMidnight
	ld a, 23 + 1
.DecreaseThroughMidnight:
	dec a
	ld [hl], a
	jr .okay

.up
	ld hl, wInitHourBuffer
	ld a, [hl]
	cp 23
	jr c, .AdvanceThroughMidnight
	ld a, -1
.AdvanceThroughMidnight:
	inc a
	ld [hl], a

.okay
	hlcoord 13, 9
	call DisplayHourOClock
	call WaitBGMap
	and a
	ret

.Confirm:
	scf
	ret

DisplayHourOClock:
	ld a, [wInitHourBuffer]
	ld c, a
	ld e, l
	ld d, h
	jp PrintHour

SetMinutes:
	ldh a, [hJoyPressed]
	and PAD_A
	jr nz, .a_button
	ld hl, hJoyLast
	ld a, [hl]
	and PAD_UP
	jr nz, .d_up
	ld a, [hl]
	and PAD_DOWN
	jr nz, .d_down
	call DelayFrame
	and a
	ret

.d_down
	ld hl, wInitMinuteBuffer
	ld a, [hl]
	and a
	jr nz, .decrease
	ld a, 59 + 1
.decrease
	dec a
	ld [hl], a
	jr .finish_dpad

.d_up
	ld hl, wInitMinuteBuffer
	ld a, [hl]
	cp 59
	jr c, .increase
	ld a, -1
.increase
	inc a
	ld [hl], a
.finish_dpad
	hlcoord 14, 9
	call DisplayMinutesWithMinString
	call WaitBGMap
	and a
	ret
.a_button
	scf
	ret

DisplayMinutesWithMinString:
	push hl
	ld de, wInitMinuteBuffer
	call PrintTwoDigitNumber
	pop hl
	inc hl
	inc hl
	inc hl
	ld de, String_min
	call PlaceString
	ret

PrintTwoDigitNumber:
	push hl
	ld a, '　'
	ld [hli], a
	ld [hl], a
	pop hl
	lb bc, 1, 2
	call PrintNum
	ret

OakTimeWokeUpText:
	text "⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯"
	line "⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯"

	para "うーん　むにゃ　むにゃ⋯⋯"
	line "なんじゃ　こんな　じかんに⋯⋯"
	cont "すまんが　とけいを　みて　くれんか⋯"
	prompt

OakTimeWhatTimeIsItText:
	text "いまは　なんじ　じゃ？"
	done

String_oclock:
	db "じ@"

OakTimeWhatHoursText:
	text "なに！　@"
	text_asm
	hlcoord 5, 14
	call DisplayHourOClock
	ld hl, .OakTimeHoursQuestionMarkText
	ret

.OakTimeHoursQuestionMarkText:
	text "　じゃと？"
	done

OakTimeHowManyMinutesText:
	text "それで　なんぷん　なのじゃ？"
	done

String_min:
	db "ふん@"

OakTimeWhoaMinutesText:
	text "なんと！　@"
	text_asm
	hlcoord 6, 14
	call DisplayMinutesWithMinString
	ld hl, .OakTimeMinutesQuestionMarkText
	ret

.OakTimeMinutesQuestionMarkText:
	text "？"
	done

OakText_ResponseToSetTime:
	text_asm
	hlcoord 1, 14
	call DisplayHourOClock
	hlcoord 7, 14
	call DisplayMinutesWithMinString
	ld a, [wInitHourBuffer]
	cp MORN_HOUR
	jr c, .nite
	cp DAY_HOUR + 1
	jr c, .morn
	cp NITE_HOUR
	jr c, .day
.nite
	ld hl, .OakTimeSoDarkText
	ret
.morn
	ld hl, .OakTimeOversleptText
	ret
.day
	ld hl, .OakTimeYikesText
	ret

.OakTimeOversleptText:
	text "！"
	line "いかん！　ねすごした　ようじゃ"
	done

.OakTimeYikesText:
	text "！"
	line "まずい！　だいぶ　ねすごした！"
	done

.OakTimeSoDarkText:
	text "！"
	line "どうりで　くらい　はずじゃ！"
	done

TimeSetBackgroundGFX:
INCBIN "gfx/new_game/timeset_bg.1bpp"
TimeSetUpArrowGFX:
INCBIN "gfx/new_game/up_arrow.1bpp"
TimeSetDownArrowGFX:
INCBIN "gfx/new_game/down_arrow.1bpp"

SetDayOfWeek:
	ldh a, [hInMenu]
	push af
	ld a, $1
	ldh [hInMenu], a
	ld de, TimeSetUpArrowGFX
	ld hl, vTiles0 tile TIMESET_UP_ARROW
	lb bc, BANK(TimeSetUpArrowGFX), 1
	call Request1bpp
	ld de, TimeSetDownArrowGFX
	ld hl, vTiles0 tile TIMESET_DOWN_ARROW
	lb bc, BANK(TimeSetDownArrowGFX), 1
	call Request1bpp
	xor a
	ld [wTempDayOfWeek], a
.loop
	hlcoord 0, 12
	lb bc, 4, 18
	call Textbox
	call LoadStandardMenuHeader
	ld hl, .OakTimeWhatDayIsItText
	call PrintText
	hlcoord 13, 7
	lb bc, 2, 5
	call Textbox
	hlcoord 16, 7
	ld [hl], TIMESET_UP_ARROW
	hlcoord 16, 10
	ld [hl], TIMESET_DOWN_ARROW
	hlcoord 14, 9
	call .PlaceWeekdayString
	call ApplyTilemap
	ld c, 10
	call DelayFrames
.loop2
	call JoyTextDelay
	call .GetJoypadAction
	jr nc, .loop2
	call ExitMenu
	call UpdateSprites
	ld hl, .ConfirmWeekdayText
	call PrintText
	call YesNoBox
	jr c, .loop
	ld a, [wTempDayOfWeek]
	ld [wStringBuffer2], a
	call InitDayOfWeek
	call LoadStandardFont
	pop af
	ldh [hInMenu], a
	ret

.GetJoypadAction:
	ldh a, [hJoyPressed]
	and PAD_A
	jr z, .not_A
	scf
	ret

.not_A
	ld hl, hJoyLast
	ld a, [hl]
	and PAD_UP
	jr nz, .d_up
	ld a, [hl]
	and PAD_DOWN
	jr nz, .d_down
	call DelayFrame
	and a
	ret

.d_down
	ld hl, wTempDayOfWeek
	ld a, [hl]
	and a
	jr nz, .decrease
	ld a, SATURDAY + 1

.decrease
	dec a
	ld [hl], a
	jr .finish_dpad

.d_up
	ld hl, wTempDayOfWeek
	ld a, [hl]
	cp 6
	jr c, .increase
	ld a, SUNDAY - 1

.increase
	inc a
	ld [hl], a

.finish_dpad
	xor a
	ldh [hBGMapMode], a
	hlcoord 14, 8
	lb bc, 2, 5
	call ClearBox
	hlcoord 14, 9
	call .PlaceWeekdayString
	call WaitBGMap
	and a
	ret

.PlaceWeekdayString:
	push hl
	ld a, [wTempDayOfWeek]
	ld e, a
	ld d, 0
	ld hl, .WeekdayStrings
	add hl, de
	add hl, de
	ld a, [hli]
	ld d, [hl]
	ld e, a
	pop hl
	call PlaceString
	ret

.WeekdayStrings:
; entries correspond to wCurDay constants (see constants/ram_constants.asm)
	dw .Sunday
	dw .Monday
	dw .Tuesday
	dw .Wednesday
	dw .Thursday
	dw .Friday
	dw .Saturday
	dw .Sunday

.Sunday:    db "にちようび@"
.Monday:    db "げつようび@"
.Tuesday:   db "かようび@"
.Wednesday: db "すいようび@"
.Thursday:  db "もくようび@"
.Friday:    db "きんようび@"
.Saturday:  db "どようび@"

.OakTimeWhatDayIsItText:
	text "きょうは　なんようび？"
	done

.ConfirmWeekdayText:
	text_asm
	hlcoord 1, 14
	call .PlaceWeekdayString
	ld hl, .OakTimeIsItText
	ret

.OakTimeIsItText:
	text "　で　まちがいないわね？"
	done

PrintHour:
	push hl
	ld l, e
	ld h, d
	push bc
	push hl
	call GetTimeOfDayString
	call PlaceString
	pop hl
	inc hl
	inc hl
	inc hl
	pop bc
	push hl
	call AdjustHourForAMorPM
	ld [wTextDecimalByte], a
	ld de, wTextDecimalByte
	call PrintTwoDigitNumber
	pop hl
	inc hl
	inc hl
	ld de, String_oclock
	call PlaceString
	pop hl
	ret

GetTimeOfDayString:
	ld a, c
	cp MORN_HOUR
	jr c, .nite
	cp DAY_HOUR
	jr c, .morn
	cp NITE_HOUR
	jr c, .day
.nite
	ld de, .nite_string
	ret
.morn
	ld de, .morn_string
	ret
.day
	ld de, .day_string
	ret

.nite_string: db "よる@"
.morn_string: db "あさ@"
.day_string:  db "ひる@"

AdjustHourForAMorPM:
; Convert the hour stored in c (0-23) to a 0-11 value
	ld a, c
	cp NOON_HOUR
	ret c
	sub NOON_HOUR
	ret

.midnight ; unreferenced
	ld a, NOON_HOUR
	ret
