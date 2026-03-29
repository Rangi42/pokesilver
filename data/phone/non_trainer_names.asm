NonTrainerCallerNames:
; entries correspond to PHONECONTACT_* constants (see constants/trainer_constants.asm)
	table_width 2
	dw .none
	dw .mom
	dw .bikeshop
	dw .bill
	dw .elm
	assert_table_length NUM_NONTRAINER_PHONECONTACTS + 1

.none:     db "ーーーーーーーーーー@"
.mom:      db "おかあさん@"
.bill:     db "マサキ@"
.elm:      db "ウツギはかせ@"
.bikeshop: db "ミラクルサイクル　てんしゅ@"
