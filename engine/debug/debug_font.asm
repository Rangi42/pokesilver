Functionfb44a::
	call LoadFrame
	ld hl, wd55c
	bit 0, [hl]
	jr z, .asm_fb46d

	ld hl, vTiles2 tile $66
	ld de, Font + 118 * TILE_1BPP_SIZE ; '０'
	lb bc, BANK(Font), 10 ; '０' to '９'
	call Get1bpp
	ld hl, vTiles2 tile $70
	ld de, FontExtra
	lb bc, BANK(FontExtra), 6 ; 'Ａ' to 'Ｆ'
	call Get2bpp
	ret

.asm_fb46d:
	ld hl, vTiles2 tile $66
	ld de, Font + 118 * TILE_1BPP_SIZE ; '０'
	lb bc, BANK(Font), 10 ; '０' to '９'
	call Get1bpp
	ld hl, vTiles2 tile $70
	ld de, .BoldColonGFX
	lb bc, BANK(.BoldColonGFX), 1
	call Get1bpp
	ld hl, vTiles2 tile $71
	ld de, WeekdayKanjiGFX
	lb bc, BANK(WeekdayKanjiGFX), 9 ; '日' to '☎'
	call Get2bpp
	ret

.BoldColonGFX:
	INCBIN "gfx/debug/bold_colon.1bpp"
