MACRO landmark
; x, y, name
	db \1 + 8, \2 + 16
	dw \3
ENDM

Landmarks:
; entries correspond to constants/landmark_constants.asm
	table_width 4
	landmark  -8, -16, SpecialMapName
	landmark 140, 100, NewBarkTownName
	landmark 128, 100, Route29Name
	landmark 100, 100, CherrygroveCityName
	landmark 100,  80, Route30Name
	landmark  96,  60, Route31Name
	landmark  84,  60, VioletCityName
	landmark  85,  58, SproutTowerName
	landmark  84,  92, Route32Name
	landmark  76,  76, RuinsOfAlphName
	landmark  84, 124, UnionCaveName
	landmark  82, 124, Route33Name
	landmark  68, 124, AzaleaTownName
	landmark  70, 122, SlowpokeWellName
	landmark  52, 120, IlexForestName
	landmark  52, 112, Route34Name
	landmark  52,  92, GoldenrodCityName
	landmark  50,  92, RadioTowerName
	landmark  52,  76, Route35Name
	landmark  52,  60, NationalParkName
	landmark  64,  60, Route36Name
	landmark  68,  52, Route37Name
	landmark  68,  44, EcruteakCityName
	landmark  70,  42, TinTowerName
	landmark  66,  42, BurnedTowerName
	landmark  52,  44, Route38Name
	landmark  36,  48, Route39Name
	landmark  36,  60, OlivineCityName
	landmark  38,  62, LighthouseName
	landmark  28,  64, Route40Name
	landmark  28,  92, WhirlIslandsName
	landmark  28, 100, Route41Name
	landmark  20, 100, CianwoodCityName
	landmark  92,  44, Route42Name
	landmark  84,  44, MtMortarName
	landmark 108,  44, MahoganyTownName
	landmark 108,  36, Route43Name
	landmark 108,  28, LakeOfRageName
	landmark 120,  44, Route44Name
	landmark 130,  38, IcePathName
	landmark 132,  44, BlackthornCityName
	landmark 132,  36, DragonsDenName
	landmark 132,  64, Route45Name
	landmark 112,  72, DarkCaveName
	landmark 124,  88, Route46Name
	landmark 148,  68, SilverCaveName
	assert_table_length KANTO_LANDMARK
	landmark  52, 108, PalletTownName
	landmark  52,  92, Route1Name
	landmark  52,  76, ViridianCityName
	landmark  52,  64, Route2Name
	landmark  52,  52, PewterCityName
	landmark  64,  52, Route3Name
	landmark  76,  52, MtMoonName
	landmark  88,  52, Route4Name
	landmark 100,  52, CeruleanCityName
	landmark 100,  44, Route24Name
	landmark 108,  36, Route25Name
	landmark 100,  60, Route5Name
	landmark 108,  76, UndergroundName
	landmark 100,  76, Route6Name
	landmark 100,  84, VermilionCityName
	landmark  88,  60, DiglettsCaveName
	landmark  88,  68, Route7Name
	landmark 116,  68, Route8Name
	landmark 116,  52, Route9Name
	landmark 132,  52, RockTunnelName
	landmark 132,  56, Route10Name
	landmark 132,  60, PowerPlantName
	landmark 132,  68, LavenderTownName
	landmark 140,  68, LavRadioTowerName
	landmark  76,  68, CeladonCityName
	landmark 100,  68, SaffronCityName
	landmark 116,  84, Route11Name
	landmark 132,  80, Route12Name
	landmark 124, 100, Route13Name
	landmark 116, 112, Route14Name
	landmark 104, 116, Route15Name
	landmark  68,  68, Route16Name
	landmark  68,  92, Route17Name
	landmark  80, 116, Route18Name
	landmark  92, 116, FuchsiaCityName
	landmark  92, 128, Route19Name
	landmark  76, 132, Route20Name
	landmark  68, 132, SeafoamIslandsName
	landmark  52, 132, CinnabarIslandName
	landmark  52, 120, Route21Name
	landmark  36,  68, Route22Name
	landmark  28,  52, VictoryRoadName
	landmark  28,  44, Route23Name
	landmark  28,  36, IndigoPlateauName
	landmark  28,  92, Route26Name
	landmark  20, 100, Route27Name
	landmark  12, 100, TohjoFallsName
	landmark  20,  68, Route28Name
	landmark 140, 116, FastShipName
	assert_table_length NUM_LANDMARKS

NewBarkTownName:     db "ワカバタウン@"
CherrygroveCityName: db "ヨシノシティ@"
VioletCityName:      db "キキョウシティ@"
AzaleaTownName:      db "ヒワダタウン@"
GoldenrodCityName:   db "コガネシティ@"
EcruteakCityName:    db "エンジュシティ@"
OlivineCityName:     db "アサギシティ@"
CianwoodCityName:    db "タンバシティ@"
MahoganyTownName:    db "チョウジタウン@"
BlackthornCityName:  db "フスベシティ@"
LakeOfRageName:      db "いかりのみずうみ@"
SilverCaveName:      db "シロガネやま@"
SproutTowerName:     db "マダツボミのとう@"
RuinsOfAlphName:     db "アルフのいせき@"
UnionCaveName:       db "つながりのどうくつ@"
SlowpokeWellName:    db "ヤドンのいど@"
RadioTowerName:      db "ラジオとう@"
PowerPlantName:      db "はつでんしょ@"
NationalParkName:    db "しぜんこうえん@"
TinTowerName:        db "スズのとう@"
LighthouseName:      db "アサギのとうだい@"
WhirlIslandsName:    db "うずまきじま@"
MtMortarName:        db "スリバチやま@"
DragonsDenName:      db "りゅうのあな@"
IcePathName:         db "こおりのぬけみち@"
HauntedHouseName:    db "オバケやしき@" ; unreferenced
PalletTownName:      db "マサラタウン@"
ViridianCityName:    db "トキワシティ@"
PewterCityName:      db "ニビシティ@"
CeruleanCityName:    db "ハナダシティ@"
LavenderTownName:    db "シオンタウン@"
VermilionCityName:   db "クチバシティ@"
CeladonCityName:     db "タマムシシティ@"
SaffronCityName:     db "ヤマブキシティ@"
FuchsiaCityName:     db "セキチクシティ@"
CinnabarIslandName:  db "グレンじま@"
IndigoPlateauName:   db "セキエイこうげん@"
VictoryRoadName:     db "チャンピオンロード@"
MtMoonName:          db "おつきみやま@"
RockTunnelName:      db "イワヤマトンネル@"
LavRadioTowerName:   db "シオンラジオとう@"
SilphCoName:         db "シルフカンパニー@" ; unreferenced
SafariZoneName:      db "サファリゾーン@" ; unreferenced
SeafoamIslandsName:  db "ふたごじま@"
PokemonMansionName:  db "#やしき@" ; unreferenced
CeruleanCaveName:    db "ハナダのどうくつ@" ; unreferenced
Route1Name:          db "１<ROUTE>@"
Route2Name:          db "２<ROUTE>@"
Route3Name:          db "３<ROUTE>@"
Route4Name:          db "４<ROUTE>@"
Route5Name:          db "５<ROUTE>@"
Route6Name:          db "６<ROUTE>@"
Route7Name:          db "７<ROUTE>@"
Route8Name:          db "８<ROUTE>@"
Route9Name:          db "９<ROUTE>@"
Route10Name:         db "１０<ROUTE>@"
Route11Name:         db "１１<ROUTE>@"
Route12Name:         db "１２<ROUTE>@"
Route13Name:         db "１３<ROUTE>@"
Route14Name:         db "１４<ROUTE>@"
Route15Name:         db "１５<ROUTE>@"
Route16Name:         db "１６<ROUTE>@"
Route17Name:         db "１７<ROUTE>@"
Route18Name:         db "１８<ROUTE>@"
Route19Name:         db "１９ばん　すいどう@"
Route20Name:         db "２０ばん　すいどう@"
Route21Name:         db "２１ばん　すいどう@"
Route22Name:         db "２２<ROUTE>@"
Route23Name:         db "２３<ROUTE>@"
Route24Name:         db "２４<ROUTE>@"
Route25Name:         db "２５<ROUTE>@"
Route26Name:         db "２６<ROUTE>@"
Route27Name:         db "２７<ROUTE>@"
Route28Name:         db "２８<ROUTE>@"
Route29Name:         db "２９<ROUTE>@"
Route30Name:         db "３０<ROUTE>@"
Route31Name:         db "３１<ROUTE>@"
Route32Name:         db "３２<ROUTE>@"
Route33Name:         db "３３<ROUTE>@"
Route34Name:         db "３４<ROUTE>@"
Route35Name:         db "３５<ROUTE>@"
Route36Name:         db "３６<ROUTE>@"
Route37Name:         db "３７<ROUTE>@"
Route38Name:         db "３８<ROUTE>@"
Route39Name:         db "３９<ROUTE>@"
Route40Name:         db "４０ばん　すいどう@"
Route41Name:         db "４１ばん　すいどう@"
Route42Name:         db "４２<ROUTE>@"
Route43Name:         db "４３<ROUTE>@"
Route44Name:         db "４４<ROUTE>@"
Route45Name:         db "４５<ROUTE>@"
Route46Name:         db "４６<ROUTE>@"
DarkCaveName:        db "くらやみのほらあな@"
IlexForestName:      db "ウバメのもり@"
BurnedTowerName:     db "やけたとう@"
FastShipName:        db "こうそくせん@"
ViridianForestName:  db "トキワのもり@" ; unreferenced
DiglettsCaveName:    db "ディグダのあな@"
TohjoFallsName:      db "トージョウのたき@"
UndergroundName:     db "ちかつうろ@"
SpecialMapName:      db "スペシャル@"
