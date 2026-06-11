Debug_UpdateToolgear:: ; unreferenced except in _DEBUG builds
IF DEF(_DEBUG)

pushc toolgear

	ld a, [wUnusedReanchorBGMapFlags]
	bit 0, a
	ret z
	hlbgcoord 0, 1, wDebugToolgearBuffer
	ld bc, SCREEN_WIDTH
	ld a, '　'
	call ByteFill
	ld hl, wd55c
	bit 0, [hl]
	jr z, .Clock

; coordinates
	ld hl, wXCoord
	debgcoord 4, 1, wDebugToolgearBuffer
	ld c, 1
	call .PrintCoord

	ld hl, wYCoord
	debgcoord 8, 1, wDebugToolgearBuffer
	ld c, 1
	call .PrintCoord
	ret

.Clock
	ld hl, wCurDay
	debgcoord 0, 1, wDebugToolgearBuffer
	call .PrintNum
	ld a, '：'
	ldbgcoord_a 4, 1, wDebugToolgearBuffer

	ld hl, hHours
	debgcoord 5, 1, wDebugToolgearBuffer
	call .PrintNum
	ld a, '：'
	ldbgcoord_a 7, 1, wDebugToolgearBuffer
	; bug: should colon coordinates be (7, 1) and (10, 1)?

	ld hl, hMinutes
	debgcoord 8, 1, wDebugToolgearBuffer
	call .PrintNum

	ld hl, hSeconds
	debgcoord 11, 1, wDebugToolgearBuffer
	call .PrintNum

	call GetWeekday
	add '日'
	ldbgcoord_a 14, 1, wDebugToolgearBuffer

	ld a, '⚡'
	ldbgcoord_a 16, 1, wDebugToolgearBuffer
	inc a ; '☎'
	ldbgcoord_a 17, 1, wDebugToolgearBuffer

	; leftover code from SW97, which had a blinking colon
	ldh a, [hSeconds]
	and 1
	ret z
	ret

.PrintCoord:
	ld a, [hli]
	ld b, a
	swap a
	call .PrintDigit
	ld a, b
	call .PrintDigit
	dec c
	jr nz, .PrintCoord
	ret

.PrintNum:
	ld a, [hli]
	ld b, 0
.mod
	inc b
	sub 10
	jr nc, .mod
	dec b
	add 10
	push af
	ld a, b
	call .PrintDigit
	pop af
	call .PrintDigit
	ret

.PrintDigit:
	and %1111
	add '０'
	ld [de], a
	inc de
	ret

popc

ELSE
	ret ; dummy
ENDC
