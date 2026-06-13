; This file is INCLUDEd twice in different ROM banks:
; once for Credits_Copyright (see data/credits_strings.asm),
; and once for CopyrightString (see engine/menus/intro_menu.asm).

	db   $60                               ; ©
	db   $61, $62, $63, $61, $62, $64      ; 1995-1999
	db   $65, $66, $67, $68, $69, $6a      ; Nintendo
	next $60                               ; ©
	db   $61, $62, $63, $61, $62, $64      ; 1995-1999
	db   $6b, $6c, $6d, $6e, $6f, $70      ; Creatures
	db   $71, $72                          ; inc.
	next $60                               ; ©
	db   $61, $62, $63, $61, $62, $64      ; 1995-1999
	db   $73, $74, $75, $76, $77, $78, $79 ; GAME FREAK
	db   $71, $72                          ; inc.
	db   "@"
