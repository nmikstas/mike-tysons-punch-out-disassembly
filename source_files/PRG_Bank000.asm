;This bank contains the data for Glass Joe, Don Flamenco 1 and Don Flamenco 2.

.org $8000

.include "Mike_Tysons_Punchout_Defines.asm"

;----------------------------------------------------------------------------------------------------

;********** Layer 1 **********

;Glass Joe Data entry point.
L8000:  .word $8030             ;Sprite patterns pointer.
L8002:  .word $8AEF
L8004:  .word $8B23
L8006:  .word $92B6             ;Palette data pointer.
L8008:  .word NULL_PNTR         ;Unused.
L800A:  .word NULL_PNTR         ;Unused.
L800C:  .word NULL_PNTR         ;Unused.
L800E:  .word $9316             ;Fight data pointer.

;Don Flamenco 1 data entry point.
L8010:  .word $8036, $8B27, $8B5B, $92D6, $0000, $0000, $0000, $94C3

;Don Flamenco 2 data entry point. 
L8020:  .word $8036, $8B27, $8B5B, $92F6, $0000, $0000, $0000, $9523

;----------------------------------------------------------------------------------------------------

;********** Layer 2 **********

;Glass Joe.
L8030:  .word $803C, $8078, $807E

;----------------------------------------------------------------------------------------------------

;********** Layer 2 **********

;Don Flamenco 1 and 2.
L8036:  .word $8204, $8246, $824E

;----------------------------------------------------------------------------------------------------

;********** Layer 3 **********

;Glass Joe.
L803C:  .word $808C, $8099, $80A6, $80B3, $80C0, $80CD, $80DA, $80E3
L804C:  .word $80EC, $80F7, $8102, $810D, $8116, $811F, $8128, $8133
L805C:  .word $813C, $8147, $8150, $815B, $8164, $816D, $8176, $817F
L806C:  .word $8188, $8191, $819A, $81A3, $81AC, $81B5

L8078:  .word $81C0, $81C7, $81CE

L807E:  .word $81D9, $81E0, $81E7, $81EE, $81F5, $81FA, $81FF

;----------------------------------------------------------------------------------------------------

;Opponent sprite data tables. Glass Joe.

L808C:  .byte $F0, $A0              ;
L808E:  .word $840A, $8616          ;
L8092:  .byte $03                   ;
L8093:  .word $87A8, $87BB, $87C7   ;

L8099:  .byte $F0, $A0              ;
L809B:  .word $840A, $8627          ;
L809F:  .byte $03                   ;
L80A0:  .word $87A8, $87E4, $87C7   ;

L80A6:  .byte $F2, $9F              ;
L80A8:  .word $840A, $8616          ;
L80AC:  .byte $03                   ;
L80AD:  .word $87A8, $87BB, $87CF   ;

L80B3:  .byte $F2, $9F              ;
L80B5:  .word $840A, $8627          ;
L80B9:  .byte $03                   ;
L80BA:  .word $87A8, $87E4, $87CF   ;

L80C0:  .byte $F0, $A0              ;
L80C2:  .word $840A, $8737          ;
L80C6:  .byte $03                   ;
L80C7:  .word $87A8, $87FC, $87C7   ;

L80CD:  .byte $F0, $A0              ;
L80CF:  .word $840A, $864A          ;
L80D3:  .byte $03                   ;
L80D4:  .word $87A8, $8813, $87C7   ;

L80DA:  .byte $F2, $9F              ;
L80DC:  .word $85CA, $8749          ;
L80E0:  .byte $01                   ;
L80E1:  .word $883D                 ;

L80E3:  .byte $F0, $A4              ;
L80E5:  .word $840A, $865B          ;
L80E9:  .byte $01                   ;
L80EA:  .word $88C0                 ;

L80EC:  .byte $F2, $A1              ;
L80EE:  .word $840A, $8665          ;
L80F2:  .byte $02                   ;
L80F3:  .word $8860, $87CF          ;

L80F7:  .byte $02, $A1              ;
L80F9:  .word $8429, $8673          ;
L80FD:  .byte $02                   ;
L80FE:  .word $88F5, $8902          ;

L8102:  .byte $04, $A1              ;
L8104:  .word $8429, $8673          ;
L8108:  .byte $02                   ;
L8109:  .word $892B, $8902          ;

L810D:  .byte $E9, $A8              ;
L810F:  .word $84FE, $86F0          ;
L8113:  .byte $01                   ;
L8114:  .word $8A2A                 ;

L8116:  .byte $F2, $BA
L8118:  .word $851A, $8703          ;
L811C:  .byte $01
L811D:  .word $8A41

L811F:  .byte $00, $A2
L8121:  .word $8537, $8714          ;
L8125:  .byte $01
L8126:  .word $8A63

L8128:  .byte $F1, $AF
L812A:  .word $8448, $868C          ;
L812E:  .byte $02
L812F:  .word $8997, $8987

L8133:  .byte $FE, $A0
L8135:  .word $8460, $86A8          ;
L8139:  .byte $01
L813A:  .word $8975

L813C:  .byte $FE, $A0
L813E:  .word $8460, $86BA          ;
L8142:  .byte $02
L8143:  .word $89B2, $8989

L8147:  .byte $F6, $A0
L8149:  .word $84AF, $86A8
L814D:  .byte $01
L814E:  .word $8975

L8150:  .byte $F6, $A0
L8152:  .word $84AF, $86BA
L8156:  .byte $02
L8157:  .word $89B2, $8989

L815B:  .byte $E3, $A9
L815D:  .word $8554, $8721
L8161:  .byte $01
L8162:  .word $8A73

L8164:  .byte $0C, $B7
L8166:  .word $8479, $86D1
L816A:  .byte $01
L816B:  .word $89F6

L816D:  .byte $D9, $CF
L816F:  .word $848C, $86DE
L8173:  .byte $01
L8174:  .word $8A07

L8176:  .byte $DA, $C7
L8178:  .word $849D, $86E3
L817C:  .byte $01
L817D:  .word $8A17

L817F:  .byte $E3, $BB
L8181:  .word $856B, $872B
L8185:  .byte $01
L8186:  .word $8A84

L8188:  .byte $15, $A9
L818A:  .word $8580, $8721
L818E:  .byte $01
L818F:  .word $8A73

L8191:  .byte $FD, $B7
L8193:  .word $84C8, $86D1
L8197:  .byte $01
L8198:  .word $89F6

L819A:  .byte $1F, $CF
L819C:  .word $84DB, $86DE
L81A0:  .byte $01
L81A1:  .word $8A07

L81A3:  .byte $1E, $C7
L81A5:  .word $84EC, $86E3
L81A9:  .byte $01
L81AA:  .word $8A17

L81AC:  .byte $15, $BB
L81AE:  .word $8597, $872B
L81B2:  .byte $01
L81B3:  .word $8A84

L81B5:  .byte $00, $94
L81B7:  .word $85AC, $874E
L81BB:  .byte $02
L81BC:  .word $888A, $87C7

;
L81C0:  .byte $00
L81C1:  .word $863B
L81C3:  .byte $3C, $01
L81C5:  .word $87FC

L81C7:  .byte $00
L81C8:  .word $8698
L81CA:  .byte $3C, $01
L81CC:  .word $8813

L81CE:  .byte $01, $0A, $9F
L81D1:  .word $867D
L81D3:  .byte $00, $02
L81D5:  .word $8951, $8938

;Glass Joe, Don Flamenco.
L81D9:  .byte $01, $F2
L81DB:  .word $889F
L81DD:  .byte $01
L81DE:  .word $87CF

L81E0:  .byte $01, $F0
L81E2:  .word $88A0
L81E4:  .byte $01
L81E5:  .word $87C7

L81E7:  .byte $01, $F1
L81E9:  .word $889D
L81EB:  .byte $01
L81EC:  .word $87EE

L81EE:  .byte $01, $08
L81F0:  .word $84A1
L81F2:  .byte $01
L81F3:  .word $8938

L81F5:  .byte $00, $64
L81F7:  .byte $01
L81F8:  .word $89D4

L81FA:  .byte $00, $64
L81FC:  .byte $01
L81FD:  .word $89E1

;Glass Joe.
L81FF:  .byte $00, $38
L8201:  .byte $01
L8202:  .word $8AA0

;----------------------------------------------------------------------------------------------------

;********** Layer 3 **********

;Don Flamenco 1 and 2.
L8204:  .word $825C, $8269, $8276, $8283, $8290, $829D, $82AA, $82B3
L8214:  .word $82BE, $82CB, $82D6, $82E1, $82EC, $82F7, $8302, $830F
L8224:  .word $831A, $8327, $8332, $833F, $834A, $8355, $8360, $836B
L8234:  .word $8376, $8381, $838C, $8397, $83A2, $83AD, $83BA, $83C5
L8244:  .word $83D2

L8246:  .word $83DB, $83E4, $83ED, $8401

L824E:  .word $81D9, $81E0, $81E7, $81EE, $81F5, $81FA, $83FA

;----------------------------------------------------------------------------------------------------

;Opponent sprite data tables. Don Flamenco 1 and 2.

L825C:  .byte $F0, $A0              ;
L825E:  .word $840A, $8616          ;
L8262:  .byte $03                   ;
L8263:  .word $8774, $87BF, $87C7   ;

L8269:  .byte $F0, $A0              ;
L826B:  .word $840A, $8627          ;
L826F:  .byte $03                   ;
L8270:  .word $8791, $87E8, $87C7   ;

L8276:  .byte $F2, $9F              ;
L8278:  .word $840A, $8616          ;
L827C:  .byte $03                   ;
L827D:  .word $8774, $87BF, $87CF   ;

L8283:  .byte $F2, $9F
L8285:  .word $840A, $8627          ;
L8289:  .byte $03
L828A:  .word $8791, $87E8, $87CF

L8290:  .byte $F0, $A0
L8292:  .word $840A, $8737          ;
L8296:  .byte $03
L8297:  .word $8791, $8800, $87C7

L829D:  .byte $F0, $A0
L829F:  .word $840A, $864A          ;
L82A3:  .byte $03
L82A4:  .word $8774, $8817, $87C7

L82AA:  .byte $F2, $9F
L82AC:  .word $85CA, $8749          ;
L82B0:  .byte $01
L82B1:  .word $8828

L82B3:  .byte $F0, $A4
L82B5:  .word $840A, $865B          ;
L82B9:  .byte $02
L82BA:  .word $88AD, $88D4

L82BE:  .byte $F2, $A1
L82C0:  .word $840A, $8665          ;
L82C4:  .byte $03
L82C5:  .word $8851, $886F, $87CF

L82CB:  .byte $02, $A1
L82CD:  .word $8429, $8673          ;
L82D1:  .byte $02
L82D2:  .word $88E7, $8904

L82D6:  .byte $04, $A1, $29, $84, $73, $86, $02, $1D, $89, $04, $89
L82E1:  .byte $E9, $A8, $FE, $84, $F0, $86, $02, $20, $8A, $33, $8A
L82EC:  .byte $F2, $BA, $1A, $85, $03, $87, $02, $3A, $8A, $43, $8A
L82F7:  .byte $00, $A2, $37, $85, $14, $87, $02, $53, $8A, $65, $8A
L8302:  .byte $F1, $AF, $48, $84, $8C, $86, $03, $8E, $89, $9E, $89, $87, $89
L830F:  .byte $FE, $A0, $60, $84, $A8, $86, $02, $65, $89, $84, $89
L831A:  .byte $FE, $A0, $60, $84, $BA, $86, $03, $A1, $89, $C2, $89, $89, $89
L8327:  .byte $F6, $A0, $AF, $84, $A8, $86, $02, $65, $89, $84, $89
L8332:  .byte $F6, $A0, $AF, $84, $BA, $86, $03, $A1, $89, $C2, $89, $89, $89
L833F:  .byte $E3, $A9, $54, $85, $21, $87, $02, $6C, $8A, $75, $8A
L834A:  .byte $0C, $B7, $79, $84, $D1, $86, $02, $EE, $89, $F8, $89
L8355:  .byte $D9, $CF, $8C, $84, $DE, $86, $02, $FF, $89, $09, $8A
L8360:  .byte $DA, $C7, $9D, $84, $E3, $86, $02, $10, $8A, $19, $8A
L836B:  .byte $E3, $BB, $6B, $85, $2B, $87, $02, $7E, $8A, $89, $8A
L8376:  .byte $15, $A9, $80, $85, $21, $87, $02, $6C, $8A, $75, $8A
L8381:  .byte $FD, $B7, $C8, $84, $D1, $86, $02, $EE, $89, $F8, $89
L838C:  .byte $1F, $CF, $DB, $84, $DE, $86, $02, $FF, $89, $09, $8A
L8397:  .byte $1E, $C7, $EC, $84, $E3, $86, $02, $10, $8A, $19, $8A
L83A2:  .byte $15, $BB, $97, $85, $2B, $87, $02, $7E, $8A, $89, $8A
L83AD:  .byte $00, $94, $AC, $85, $4E, $87, $03, $79, $88, $9A, $88, $C7, $87
L83BA:  .byte $F8, $8C, $D6, $85, $5D, $87, $02, $B1, $8A, $CF, $87
L83C5:  .byte $F8, $8C, $D6, $85, $5D, $87, $03, $A4, $8A, $BD, $8A, $CF, $87
L83D2:  .byte $07, $9E, $F9, $85, $6E, $87, $01, $C7, $8A

L83DB:  .byte $00, $3B, $86, $3C, $02, $A1, $87, $00, $88
L83E4:  .byte $00, $98, $86, $3C, $02, $84, $87, $17, $88

L83ED:  .byte $01, $0A, $9F, $7D, $86, $00, $03, $43, $89, $5D, $89, $38, $89

L83FA:  .byte $01, $F8, $88, $74, $01, $E0, $8A

L8401:  .byte $00, $98, $86, $38, $02, $8B, $87, $17, $88

;----------------------------------------------------------------------------------------------------

L840A:  .byte $23, $04, $E8, $04, $E8, $10, $F6, $04, $F2, $10, $F6, $04, $F2, $04, $E8, $04
L841A:  .byte $E8, $04, $E8, $04, $E8, $04, $E8, $04, $E8, $04, $E8, $02
L8426:  .word $81F8
L8428:  .byte $00

L8429:  .byte $22, $03, $F0, $10, $F7, $04, $F1, $10, $F7, $03, $F1, $05, $E8, $05, $E0, $05
L8439:  .byte $E0, $03, $E8, $03, $F0, $03, $F0, $03, $F0, $03, $F0, $02
L8445:  .word $85F0
L8447:  .byte $00

L8448:  .byte $22, $04, $F0, $10, $F3, $04, $F5, $04, $E8, $03, $F0, $03, $F0, $03, $F0, $03
L8458:  .byte $F0, $04, $E8, $04, $E8
L845E:  .word $818F
L845F:  .byte $00

L8460:  .byte $21, $05, $F0, $04, $E0, $04, $E8, $04, $E8, $05, $E0, $05, $E0, $03, $E8, $03
L8470:  .byte $F0, $03, $F0, $04, $E8, $04
L8476:  .word $86E8
L8478:  .byte $00

L8479:  .byte $21, $04, $E8, $05, $E8, $06, $D8, $05, $D8, $03, $F0, $02, $F8, $02, $F0, $01
L8489:  .word $8800
L848B:  .byte $00

L848C:  .byte $23, $05, $E0, $06, $E0, $05, $E8, $02, $E0, $10, $18, $02, $E0, $10
L849A:  .word $8718
L849C:  .byte $00

L849D:  .byte $21, $05, $F0, $05, $E8, $05, $E0, $06, $D8, $07, $D8, $02, $E0, $10, $18
L84AD:  .word $848F
L84AE:  .byte $00

L84AF:  .byte $A1, $95, $10, $94, $20, $94, $18, $94, $18, $95, $20, $95, $20, $93, $18, $93
L84BF:  .byte $10, $93, $10, $94, $18, $94
L84C5:  .word $8618
L84C7:  .byte $00

L84C8:  .byte $A1, $94, $18, $95, $18, $96, $28, $95, $28, $93, $10, $92, $08, $92, $10, $91
L84D8:  .word $8800
L84DA:  .byte $00

L84DB:  .byte $A3, $95, $20, $96, $20, $95, $18, $92, $20, $10, $E8, $92, $20, $10, $E8, $87
L84EB:  .byte $00

L84EC:  .byte $A1, $95, $10, $95, $18, $95, $20, $96, $28, $97, $28, $92, $20, $10, $E8, $8F
L84FC:  .byte $84, $00

L84FE:  .byte $21, $02, $F8, $10, $FC, $02, $FC, $10, $FC, $03, $FC, $03, $F0, $04, $E8, $05
L850E:  .byte $E8, $03, $F0, $03, $F0, $03, $F0, $03, $F0, $8F, $82, $00

L851A:  .byte $22, $03, $F0, $04, $F0, $03, $F0, $04, $E8, $04, $E8, $32, $F0, $00, $04, $F8
L852A:  .byte $32, $E8, $00, $04, $F8, $03, $E8, $01, $F0, $10, $10, $8E, $00

L8537:  .byte $21, $03, $F0, $31, $FD, $06, $36, $F3, $02, $05, $E0, $04, $E0, $04, $E8, $03
L8547:  .byte $E8, $03, $F0, $03, $F0, $04, $E8, $04, $E8, $02
L8551:  .word $88F0
L8553:  .byte $00

L8554:  .byte $21, $03, $F8, $03, $F0, $03, $F0, $03
L855C:  .byte $F0, $04, $F0, $05, $E0, $05, $E0, $02, $F8, $04, $F0, $04, $E8, $8E, $00

L856B:  .byte $21
L856C:  .byte $03, $F8, $A1, $04, $00, $04, $E8, $05, $E0, $05, $E0, $04, $E8, $04, $F0, $04
L857C:  .byte $E0, $8F, $81, $00

L8580:  .byte $A1, $93, $08, $93, $10, $93, $10, $93, $10, $94, $10, $95
L858C:  .byte $20, $95, $20, $92, $08, $94, $10, $94, $18, $8E, $00

L8597:  .byte $A1, $93, $08, $21, $94
L859C:  .byte $00, $94, $18, $95, $20, $95, $20, $94, $18, $94, $10, $94, $20, $8F, $81, $00
L85AC:  .byte $21, $03, $F0, $03, $F0, $A1, $03, $F8, $03, $F0, $04, $E8, $04, $E8, $03, $E8
L85BC:  .byte $04, $F0, $04, $E8, $04, $E8, $04, $E8, $04, $E8, $02, $F8, $84, $00

L85CA:  .byte $23, $04
L85CC:  .byte $E8, $10, $F4, $04, $F4, $10, $F4, $04, $F4, $00, $02, $00, $02, $F8, $03, $F0
L85DC:  .byte $03, $F0, $32, $FC, $04, $33, $F4, $04, $03, $F0, $03, $F0, $03, $F0, $A1, $03
L85EC:  .byte $F8, $04, $E8, $04, $E8, $04, $E8, $04, $E8, $02, $F8, $85, $00, $21, $01, $E8
L85FC:  .byte $32, $10, $00, $05, $E0, $05, $E0, $03, $E8, $03, $F0, $02, $F8, $02, $F8, $03
L860C:  .byte $F0, $03, $F0, $02, $F8, $03, $F0, $04, $F0, $00

L8616:  .byte $68, $84, $00, $00, $03, $03, $06, $41, $28, $85, $02, $01, $01, $01, $02, $14
L8626:  .byte $00

L8627:  .byte $68, $87, $00, $00, $03
L862C:  .byte $03, $00, $00, $00, $25, $41, $25, $85, $02, $01, $01, $01, $01, $15, $00, $68
L863C:  .byte $84, $00, $00, $03, $03, $03, $23, $83, $02, $01, $02, $29, $04, $00

L864A:  .byte $68, $84, $00, $00, $03, $03, $0B, $23, $86, $02, $02, $01, $01, $01, $02, $14
L865A:  .byte $00

L865B:  .byte $6C, $01, $64, $82, $00, $02, $2C, $47, $0E, $00

L8665:  .byte $6D, $84, $00, $00, $03, $03, $0A, $23, $83, $00, $02, $02, $13, $00

L8673:  .byte $66, $02, $63, $83, $00, $02, $02, $2B, $16, $00, $66, $02, $63, $09, $25, $88
L8683:  .byte $02, $01, $01, $01, $01, $00, $02, $01, $00

L868C:  .byte $67, $85, $00, $02, $00, $00, $00, $23, $41, $23, $11, $00, $68, $84, $00, $00
L869C:  .byte $03, $03, $0B, $23, $86, $02, $02, $01, $01, $01, $02, $00

L86A8:  .byte $69, $02, $66, $8C, $01, $02, $01, $01, $01, $01, $02, $01, $02, $01, $01, $01
L86B8:  .byte $11, $00

L86BA:  .byte $66, $85
L86BC:  .byte $00, $03, $03, $03, $00, $69, $8C, $01, $01, $01, $00, $00, $00, $02, $01, $01
L86CC:  .byte $02, $02, $02, $0E, $00, $69, $22, $88, $02, $01, $00, $00, $01, $02, $02, $02
L86DC:  .byte $0B, $00, $62, $23, $61, $14, $00, $69, $08, $88, $02, $01, $00, $00, $00, $00
L86EC:  .byte $01, $01, $08, $00

L86F0:  .byte $64, $84, $00, $03, $03, $00, $23, $89, $02, $01, $01, $02, $01, $01, $01, $02
L8700:  .byte $01, $0F, $00

L8703:  .byte $64, $86, $00, $00, $03, $03, $00, $02, $28, $43, $84, $00, $00, $02, $02, $0D
L8713:  .byte $00

L8714:  .byte $65, $88, $00, $03, $03, $00, $00, $02
L871C:  .byte $02, $03, $28, $17, $00, $70, $84, $00, $00, $02, $01, $03, $42, $0D, $00, $65
L872C:  .byte $09, $87, $02, $01, $00, $00, $00, $02, $02, $0F, $00

L8737:  .byte $68, $8D, $00, $00, $03, $03, $00, $00, $00, $01, $01, $01, $02, $01, $02, $29
L8747:  .byte $16, $00

L8749:  .byte $68, $01, $64
L874C:  .byte $01, $00, $42, $62, $87, $01, $03, $03, $00, $00, $00, $03, $0C, $41, $23, $15
L875C:  .byte $00, $84, $02, $02, $02, $01, $07, $62, $0A, $86, $01, $01, $00, $00, $02, $02
L876C:  .byte $12, $00, $42, $23, $0A, $26, $13, $00

L8774:  .byte $2F, $FF, $53, $54, $FF, $FF, $55, $56, $FF, $FF, $57, $58, $FF, $FF, $FF, $59
L8784:  .byte $23, $5A, $FF, $FF, $30, $1D, $00

L878B:  .byte $24, $05, $8F, $FF, $FF, $00

L8791:  .byte $2F, $FF, $53, $54, $FF, $FF, $55, $56, $FF, $FF, $57, $58, $FF, $FF, $FF, $59
L87A1:  .byte $23, $97, $FF, $FF, $30, $1D, $00

L87A8:  .byte $2F, $FF, $DD, $DE, $FF, $FF, $DF, $E0, $E1, $FF, $E2, $E3, $E4, $FB, $FF, $E5
L87B8:  .byte $30, $1D, $00

L87BB:  .byte $23, $08, $FF, $FF, $0C, $09, $24, $FF, $15, $16, $17, $00

L87C7:  .byte $0E, $18, $24, $FF, $26, $FF, $27, $00

L87CF:  .byte $28, $FF, $29, $2A, $2B, $FF, $2C, $2D, $2E, $2A, $FF, $20, $50, $FF, $FF, $24
L87DF:  .byte $51, $FF, $52, $FF, $00

L87E4:  .byte $23, $2F, $FF, $FF, $0E, $30, $22, $16
L87EC:  .byte $28, $00, $08, $43, $2A, $FF, $4B, $4C, $FF, $FF, $4D, $4E, $FF, $4F, $FF, $00
L87FC:  .byte $23, $2F, $FF, $FF, $2C, $09, $3E, $32, $33, $0D, $3F, $36, $37, $11, $40, $3A
L880C:  .byte $3B, $24, $FF, $3D, $16, $28, $00

L8813:  .byte $23, $08, $FF, $FF, $2D, $30, $41, $0B, $0C
L881C:  .byte $34, $42, $0F, $10, $38, $12, $13, $14, $3C, $03, $15, $00, $2A, $FF, $91, $92
L882C:  .byte $FF, $FF, $93, $94, $FF, $FF, $FF, $28, $95, $96, $FF, $FF, $FF, $61, $62, $FF
L883C:  .byte $00

L883D:  .byte $23, $FF, $5B, $5C, $82, $2D, $5D, $5E, $FF, $FB, $FF, $5F, $60, $FF, $FB
L884C:  .byte $FF, $61, $62, $FF, $00, $85, $26, $53, $54, $FF, $FF, $55, $56, $83, $24, $03
L885C:  .byte $04, $FF, $FF, $00

L8860:  .byte $85, $2D, $71, $72, $FF, $FF, $73, $74, $FF, $FF, $FF, $75
L886C:  .byte $76, $FF, $FB, $24, $77, $78, $79, $0C, $0C, $7A, $30, $1D, $00, $2F, $63, $64
L887C:  .byte $53, $54, $65, $55, $56, $67, $FF, $57, $58, $69, $59, $01, $6B, $00, $2F, $63
L888C:  .byte $64, $DD, $DE, $65, $DF, $66, $67, $FB, $E2, $68, $69, $E5, $6A, $6B, $2F, $30
L889C:  .byte $41, $6C, $6D, $34, $35, $6E, $6F, $38, $39, $70, $3C, $3D, $16, $17, $30, $1D
L88AC:  .byte $00, $82, $2F, $28, $FF, $FF, $29, $2A, $2B, $FF, $2C, $2D, $2E, $FF, $FF, $2F
L88BC:  .byte $30, $31, $81, $00

L88C0:  .byte $24, $FF, $FF, $01, $02, $2E, $FF, $03, $04, $05, $FF, $06
L88CC:  .byte $07, $08, $FB, $FF, $09, $0A, $0B, $FB, $08, $0C, $81, $0F, $14, $2A, $FF, $23
L88DC:  .byte $24, $FF, $FF, $25, $26, $FF, $27, $FF, $30, $1C, $00, $81, $05, $86, $29, $FF
L88EC:  .byte $C3, $8E, $06, $07, $FF, $C7, $C8, $8B, $00

L88F5:  .byte $81, $05, $BE, $28, $FB, $C3, $C4, $C5, $C6, $FB, $C7, $C8, $00

L8902:  .byte $21, $C9, $0A, $CA, $28, $FF, $D4, $D5, $D6, $FF
L890C:  .byte $D7, $D8, $D9, $06, $29, $28, $20, $50, $FF, $24, $51, $FF, $FF, $52, $30, $1D
L891C:  .byte $00, $81, $05, $86, $29, $FF, $FF, $8E, $8C, $07, $FF, $DB, $DC, $8B, $00

L892B:  .byte $81
L892C:  .byte $05, $BE, $28, $FB, $FF, $C4, $DA, $C6, $FB, $DB, $DC, $00, $07, $B5, $27, $20
L893C:  .byte $21, $BC, $24, $25, $BD, $FF, $00, $81, $05, $86, $29, $FF, $FF, $8E, $8C, $07
L894C:  .byte $FF, $FF, $A3, $90, $00, $06, $9A, $29, $FB, $FF, $A0, $A1, $A2, $FB, $FF, $A3
L895C:  .byte $A4, $81, $0E, $A5, $23, $D7, $B3, $B4, $00, $2E, $C2, $FF, $C3, $C4, $C5, $FF
L896C:  .byte $FF, $C6, $C7, $C8, $FF, $C9, $CA, $CB, $00, $2E, $01, $FF, $02, $03, $04, $FF
L897C:  .byte $FF, $05, $06, $07, $FF, $08, $09, $0A, $81, $0E, $0B, $03, $19, $0E, $1C, $30
L898C:  .byte $1E, $00, $81, $06, $57, $24, $FF, $41, $5D, $5E, $00, $07, $3A, $24, $FB, $41
L899C:  .byte $42, $43, $08, $44, $00, $2F, $FF, $C2, $FF, $C3, $C4, $C5, $2A, $FF, $C6, $C7
L89AC:  .byte $C8, $FF, $CF, $D0, $D1, $00, $2F, $FF, $01, $FF, $02, $03, $04, $2A, $FF, $05
L89BC:  .byte $06, $07, $FF, $2B, $2C, $2D, $2E, $2E, $2F, $30, $FF, $FF, $31, $32, $33, $FF
L89CC:  .byte $FF, $34, $35, $36, $FF, $03, $37, $00, $2B, $4C, $20, $21, $FF, $4D, $24, $25
L89DC:  .byte $FF, $4F, $28, $29, $00, $2B, $51, $52, $21, $22, $23, $54, $FF, $26, $27, $56
L89EC:  .byte $FF, $00, $26, $5F, $60, $65, $66, $61, $62, $00, $06, $63, $09, $69, $0F, $72
L89FC:  .byte $30, $1E, $00, $26, $CC, $CD, $A4, $A5, $A6, $CE, $00, $06, $A2, $09, $A8, $0B
L8A0C:  .byte $B1, $30, $1E, $00, $05, $BC, $23, $86, $87, $C1, $00, $08, $81, $0F, $89, $0A
L8A1C:  .byte $98, $30, $1E, $00, $04, $47, $26, $FF, $4B, $4C, $FF, $4D, $4E, $00

L8A2A:  .byte $04, $01
L8A2C:  .byte $26, $FB, $05, $06, $FB, $07, $08, $0D, $09, $0C, $16, $30, $1F, $00, $06, $4F
L8A3C:  .byte $23, $FF, $55, $56, $00, $09, $24, $0C, $2D, $28, $46, $46, $39, $3A, $3B, $3C
L8A4C:  .byte $46, $FF, $09, $3D, $30, $1F, $00, $26, $57, $FF, $58, $59, $5A, $FF, $04, $5B
L8A5C:  .byte $25, $BD, $BE, $5F, $60, $61, $00, $0F, $B3, $0F, $C2, $0E, $D1, $30, $1F, $00
L8A6C:  .byte $04, $62, $23, $FF, $66, $67, $00, $07, $71, $0A, $78, $0F, $82, $06, $91, $30
L8A7C:  .byte $1F, $00, $05, $68, $22, $FF, $6D, $00, $05, $97, $22, $FB, $9C, $2E, $9D, $9E
L8A8C:  .byte $9F, $7F, $80, $A0, $A1, $83, $84, $A2, $A3, $A4, $88, $89, $0D, $A5, $22, $FF
L8A9C:  .byte $B2, $30, $1F, $00, $22, $FA, $FC, $00, $04, $E6, $29, $54, $98, $99, $56, $EA
L8AAC:  .byte $EB, $58, $02, $8D, $00, $04, $E6, $29, $54, $98, $99, $56, $EA, $EB, $58, $FF
L8ABC:  .byte $FF, $0C, $EC, $24, $FB, $3D, $F8, $F9, $30, $1D, $00, $2D, $22, $23, $57, $6E
L8ACC:  .byte $6F, $58, $59, $5A, $70, $DF, $5B, $5C, $5D, $08, $E0, $21, $C8, $0F, $E8, $03
L8ADC:  .byte $F7, $30, $1F, $00, $03, $43, $2B, $2B, $47, $48, $2D, $2E, $FF, $4B, $50, $FF
L8AEC:  .byte $FF, $4D, $00

;----------------------------------[ Opponent State Data Pointers ]----------------------------------

;Glass Joe state data pointers.
L8AEF:  .word $0000, $8B71, $8E93, $8D8A, $8D8A, $8CAC, $8CAC, $8D43
L8AFF:  .word $8D43, $8D98, $8D98, $8DAE, $8DAE, $8EAC, $8F46, $8FE6
L8B0F:  .word $901F, $8DB9, $8DE1, $8E37, $8E4A, $8C4D, $8BC2, $0000
L8B1F:  .word $0000, $905B

L8B23:  .word $90FD, $91BA

;Don Flamenco state data pointers.
L8B27:  .word $0000, $8B5F, $8E93, $8D8A, $8D8A, $8CAC, $8CAC, $8D43
L8B37:  .word $8D43, $8D98, $8D98, $8DAE, $8DAE, $8EAC, $8F46, $8FE6
L8B47:  .word $901F, $8DCE, $8DF6, $8E65, $8E78, $8C44, $8BB9, $8CE3
L8B57:  .word $8B97, $909E

L8B5B:  .word $90A3, $91BA

;--------------------------------------[ Opponent State Data ]---------------------------------------

;Don Flamenco.
L8B5F:  .byte $F7, $08, $08, $08, $08, $00, ST_WRITE_BYTE, $BB, $00, $00, $16, $C0, $87, $B6, $F1, $71
L8B6F:  .byte $8B, $0C

;Glass Joe round 1 initial wait state.
L8B71:  .byte ST_WRITE_BYTE, $AC, $01, $00, ST_WRITE_BYTE, $BB, $00, $00, $16, $C0, $87, $B6, $05, $C4
L8B7F:  .byte $0C, $C2
L8B81:  .byte $1F, $C2, $87, $B6, $16, $C4, $84, $B6, $62, $01, $1F, $C0, $84, $B6, $16, $C4
L8B91:  .byte $87, $B6, $62, $01, $3F, $10, ST_CALL_FUNC, $9E, $92, $80, $04, $1A, $08, $87, $B6, $02
L8BA1:  .byte $82, $EC, $31, $08, $86, $08, $08, $01, $82, $EC, $31, $07, $86, $06, $08, $EC
L8BB1:  .byte $31, $06, $86, $0F, $08, $80, $08, $F4, ST_CALL_FUNC, $A4, $92, $F5, $02, $F1, $C2, $8B
L8BC1:  .byte $05

;Glass Joe straight left punch state.
L8BC2:  .byte ST_CALL_FUNC, $A4, $92, $F5, $01, $80, $01, $16, $08, $87
L8BCC:  .byte $B6, $F9, $71, $4E, $02, $C0, $F3, $71, $07, $CC, ST_WRITE_BYTE, $9C, $84, $80, $05, $02
L8BDC:  .byte $C2, $71, $C2, $0F, $08, $F2, $50, $0D, $6B, $EC, $29, $F7, $06, $06, $06, $06
L8BEC:  .byte $00, $02, $0E, $75, $D2, $F6, $01, $07, $F0, $3B, $4C, $4C, $80, $21, $71, $3E
L8BFC:  .byte $FF, $80, $02, $EC, $81, $80, $0C, ST_CALL_FUNC, $AA, $92, $FE, $92, $4A, $00, $20, $04
L8C0C:  .byte $FC, $F4, ST_CALL_FUNC, $AA, $92, $92, $4A, $00
L8C15:  .byte $28, $04  ;Straight punch combo data.
L8C17:  .byte $80, $0C, $71, $3C, $80, $16
L8C1C:  .byte $F2, $50, $0B, $64, $F2, $50, $0C, $64, $FC, $F4, $92, $4A, $00, $20, $04, $FC
L8C2C:  .byte $F4, $F2, $59, $00, $23, $80, $FF, $F2, $03, $20, $7A, ST_WRITE_BYTE, $9C, $84, $80, $04
L8C3C:  .byte $01, $C2, $70, $C2, $06, $08, $3F, $23, ST_CALL_FUNC, $9E, $92, $F5, $02, $F1, $4D, $8C
L8C4C:  .byte $05

;**********Glass Joe Right hook punch state**********
GJRighHook:

;Index #$00.
L8C4D:  .byte ST_CALL_FUNC      ;Call state data subroutine
L8C4E:  .word DefenseStats3     ;Defense data pointer.

;Index #$03.
L8C50:  .byte ST_REPEAT         ;Load sub-state repeat.
L8C51:  .byte $01               ;No repeat for this sub-state.

;Index #$05.
L8C52:  .byte ST_TIMER          ;Load timer for this sub-state.
L8C53:  .byte $01               ;This sub-state only lasts 1 frame.

;Index #$07.
L8C54:  .byte ST_SPRITES_XY+6   ;Load sprites, change position, 6 frames for this sub-state.
L8C55:  .byte $0A               ;Sprite data index.
L8C56:  .byte $89               ;Sprite X base location.
L8C57:  .byte $B6               ;Sprite Y base location.

;Index #$0B.
L8C58:  .byte ST_PUNCH          ;Indicate opponent is punching.

;Index #$0C.
L8C59:  .byte ST_DEFENSE        ;Load opponent's defense data from following 4 bytes.
l8C5A:  .byte $06, $00          ;Face punch defense values.
l8C5C:  .byte $08, $08          ;Stomach punch defense values.
L8C5E:  .byte $00               ;End data.

;Index #$12.
L8C5F:  .byte ST_WRITE_BYTE     ;Write a byte to zero page memory.
L8C60:  .byte GameStatusBB      ;address $BB.
L8C61:  .byte OPP_RGHT_HOOK     ;Indicate a right hook is being thrown.
L8C62:  .byte $00               ;End data.

;Index #$16.
L8C63:  .byte ST_SPRITES+3      ;Load sprites, 3 frames for this sub-state.
L8C64:  .byte $16               ;Sprite data index.

;Index #$18.
L8C65:  .byte ST_SPRTS_MOVE+5   ;2 frames between movements, 2 movement segments.
L8C66:  .byte $DF               ;X=X-3 per segment, Y=Y-1 per segment.

;Index #$1A.
L8C67:  .byte ST_WRITE_BYTE     ;Write a byte to zero page memory.
L8C68:  .byte OppOutlineTimer   ;Change opponent's outline color to indicate its time to dodge.
L8C69:  .byte $84               ;Change outline color for 4 frames.

;Index #$1D.
L8C6A:  .byte ST_VAR_TIME       ;Set sub-state time to a variable amount.

;Index #$1E.
L8C6B:  .byte ST_CHK_REPEAT     ;Check if repeat counter is active.
L8C6C:  .byte $24               ;Jump to index #$24 is repeat counter is active.

L8C6D:  .byte ST_CHK_BRANCH     ;Check memory value and branch if a match is found.
L8C6E:  .byte MacStatus         ;
L8C6F:  .byte MAC_SUPER_PUNCH   ;Is Little Mac throwing a super punch? 
L8C70:  .byte $59               ;If so, jump to index #$59.

;Index #$24.
L8C71:  .byte ST_AUD_INIT       ;Initialize music/SFX.
L8C72:  .byte $25               ;SQ2 SFX, SQ2_OPP_PUNCH2.

;Index #$26.
L8C73:  .byte ST_PUNCH_SIDE     ;Indicate which side of Little Mac the punch is approaching.
L8C74:  .byte MAC_LEFT_SIDE     ;Punch is coming in on Little Mac's left side.
L8C75:  .byte $07               ;Punch damage. Added to base damage.
L8C76:  .byte $00               ;End data.

;Index #$2A.
L8C77:  .byte ST_WRITE_BYTE     ;Write a byte to zero page memory.
L8C78:  .byte GameStatusBB      ;address $BB.
L8C79:  .byte NO_ACTION         ;Indicate memory address is idle.
L8C7A:  .byte $00               ;End data.

;Index #$2E.
L8C7B:  .byte ST_SPRITES_XY+1   ;Load sprites, change position, 1 frame for this sub-state.
L8C7C:  .byte $18               ;Sprite data index.
L8C7D:  .byte $7E               ;Sprite X base location.
L8C7E:  .byte $B3               ;Sprite Y base location.

;Index #$32.
L8C7F:  .byte ST_PNCH_ACTIVE    ;Indicate a punch is active.
L8C80:  .byte $45               ;Index to jump to if punch was blocked.
L8C81:  .byte $49               ;Index to jump to if punch was ducked.
L8C82:  .byte $49               ;Index to jump to if punch was dodged.

;Index #$36 - Punch landed.
L8C83:  .byte ST_TIMER          ;Load timer for this sub-state.
L8C84:  .byte $04               ;This sub-state lasts 4 frames.

;Index #$38.
L8C85:  .byte ST_SPRT_MV_NU+4   ;Move sprites. Sub-state lasts for 4 frames.
L8C86:  .byte $22               ;Right 2 pixels, down 2 pixels.

;Index #$3A.
L8C87:  .byte ST_SPRT_MV_NU+2   ;Move sprites. Sub-state lasts for 2 frames.
L8C88:  .byte $22               ;Right 2 pixels, down 2 pixels.

;Index #$3C.
L8C89:  .byte ST_SPRITES+2      ;Load sprites, 2 frames for this sub-state.
L8C8A:  .byte $1A               ;Sprite data index.

;Index #$3E.
L8C8B:  .byte ST_SPRTS_MOVE+9   ;2 frames between movements, 3 movement segments.
L8C8C:  .byte $2F               ;X=X+2 per segment, Y=Y-1 per segment.

;Index #$40.
L8C8D:  .byte ST_SPRT_MV_NU+$F  ;Move sprites. Sub-state lasts for 15 frames.
L8C8E:  .byte $1C               ;Right 1 pixels, up 4 pixels.

;Index #$42.
L8C8F:  .byte ST_TIMER          ;Load timer for this sub-state.
L8C90:  .byte $05               ;This sub-state lasts 5 frames.

;Index #$44.
L8C91:  .byte ST_END            ;End of state.

;Index #$45 - Punch blocked.
L8C92:  .byte $F1
L8C93:  .word $8BC2
L8C95:  .byte $3B

;Index #$49 - Punch dodged or ducked.
L8CA6:  .byte $FB
L8CA7:  .byte ST_CALL_FUNC, $B0, $92, $66, $14, $04
L8C9D:  .byte $1A, $62, $1F, $62, $1F

;Index #$59
L8CA2:  .byte $62, $1E, $FC, $F4, ST_CHK_BRANCH, $59, $00, $24, $80, ST_END

;**********Glass Joe, Don Flamenco Face punch block**********

L8CAC:  .byte ST_CHK_BRANCH, $AB, $01, $17, $80, $02, $11, $12, $87, $B6, $EC, $10, $80, $05, $12, $14
L8CBC:  .byte $87, $B5, $1C, $C6, $87, $B3, $FF, $14, $12, $80, $B4, $EC, $10, $80, $08, $F9
L8CCC:  .byte $11, $3C, $7C, $B2, ST_WRITE_BYTE, $AB, $00, $14, $CC, $78, $B2, ST_WRITE_BYTE, $9C, $84
L8CDA:  .byte $80, $04
L8CDC:  .byte $FE, $80, $07, $F1, $E3, $8C, $12

L8CE3:  .byte $F9, ST_DEFENSE, $06, $20, $20, $00, $00, $11, $3C
L8CEC:  .byte $7C, $B2, ST_WRITE_BYTE, $9C, $84, $1F, $CC, $78, $B2, ST_CALL_FUNC, $98, $92, $EC, $25
L8CFA:  .byte $F2, $03
L8CFC:  .byte $20, $55, $12, $16, $77, $B4, $75, $14, $F6, $00, $0F, $11, $18, $7B, $B0, $F0
L8D0C:  .byte $35, $36, $42, $63, $22, $02, $40, $7D, $2F, $80, $1D, $FF, $FF, ST_CALL_FUNC, $9E, $92
L8D1C:  .byte $63, $22, $02, $40, $7D, $2F, $80, $10, $F4, ST_WRITE_BYTE, $4A, $68, ST_CALL_FUNC, $AA
L8D2A:  .byte $92, $63
L8D2C:  .byte $22, $02, $40, $7D, $2F, $80, $20, ST_WRITE_BYTE, $4A, $01, $FC, $F4, $11, $16, $77, $B4
L8D3C:  .byte $74, $14, $F6, $00, $17, $3F, $24

;Glass Joe stomach punch block.
L8D43:  .byte $F2, $AB, $01, $23, $F2, $BB, $02, $17, $80
L8D4C:  .byte $02, $11, $10, $87, $B6, $EC, $10, $80, $07, $1C, $C2, $89, $B3, $FF, $80, $04
L8D5C:  .byte $EC, $10, $06, $10, $61, $2D, $00, $0C, $C2, $FF, $14, $10, $87, $B4, $EC, $10
L8D6C:  .byte $80, $04, $14, $12, $80, $B4, $F9, $11, $3C, $7C, $B2, ST_WRITE_BYTE, $AB, $00, $14, $CC
L8D7C:  .byte $78, $B2, ST_WRITE_BYTE, $9C, $84, $80, $04, $FE, $80, $07, $F1, $E3, $8C, $12

;Glass Joe and Don Flamenco dodge.
L8D8A:  .byte ST_CALL_FUNC, $92, $92, $14, $08, $87, $B6, $01, $14, $01, $84, $7C, $20, $FF

L8D98:  .byte $F2, $50, $0D, $0F, ST_CALL_FUNC, $A4, $92, $80, $02, $1F, $08, $87, $B6, $3F
L8DA8:  .byte $09, ST_DEFENSE, $05, $00, $00, $00, $3F, $07

L8DAE:  .byte ST_CALL_FUNC, $AA, $92, $80, $02, $1F, $0A, $87, $B6, $3F, $05

L8DB9:  .byte $EC, $80, ST_CALL_FUNC, $AA, $92, $EC, $20, ST_WRITE_BYTE, $4A, $80, $00, $EC, $39, $51
L8DC7:  .byte $22, $85
L8DC9:  .byte $B2, $F1, $F6, $8D, $0F, $EC, $80, ST_CALL_FUNC, $AA, $92, $EC, $20, ST_WRITE_BYTE, $4A
L8DD7:  .byte $60, $00
L8DD9:  .byte $51, $22, $85, $B2, $F1, $F6, $8D, $0F


L8DE1:  .byte $EC, $80, ST_CALL_FUNC, $AA, $92, $EC, $20, ST_WRITE_BYTE, $4A, $80, $00, $EC, $39, $11
L8DEF:  .byte $1E, $91
L8DF1:  .byte $B2, $F1, $F6, $8D, $0F

;Glass Joe stunned state.
L8DF6:  .byte $EC, $80, ST_CALL_FUNC, $AA, $92, $EC, $20, ST_WRITE_BYTE, $4A, $60, $00, $11, $1E, $91
L8E04:  .byte $B2, $F2
L8E06:  .byte $68, $03, $1F, $F2, $4B, $08, $3C, $F2, $4B, $06, $3C, $80, $08, $3F, $23, $F2
L8E16:  .byte $4B, $01, $35, $80, $06, $11, $0A, $86, $B6, $01, $C0, $01, $0C, $63, $0C, $FC
L8E26:  .byte ST_WRITE_BYTE, $68, $00, $00, $F4, ST_WRITE_BYTE, $68, $00, $80, $08, $3F, $23, $FA, $68
L8E34:  .byte $03, $3F
L8E36:  .byte $23

L8E37:  .byte $EC, $80, ST_CALL_FUNC, $A4, $92, $EC, $4C, ST_WRITE_BYTE, $4A, $60, $00, $18, $1C, $80
L8E45:  .byte $B3, $F1
L8E47:  .byte $4A, $8E, $0F

;Glass Joe stomach hit, part 1.
L8E4A:  .byte $EC, $80, ST_CALL_FUNC, $A4, $92, $EC, $4C, ST_WRITE_BYTE, $4A, $60, $00, $18, $1C, $8A
L8E58:  .byte $B3, $11
L8E5A:  .byte $0A, $86, $B6, $01, $C0, $0F, $0C, $01, $08, $FC, $F4, $EC, $80, ST_CALL_FUNC, $A4, $92
L8E6A:  .byte $EC, $4C, ST_WRITE_BYTE, $4A, $50, $00, $18, $1C, $80, $B3, $F1, $78, $8E, $0F

;Glass Joe stomach hit, part 2.
L8E78:  .byte $EC, $80, ST_CALL_FUNC, $A4, $92, $EC, $4C, ST_WRITE_BYTE, $4A, $50, $00, $18, $1C, $8A
L8E86:  .byte $B3, $11
L8E88:  .byte $0A, $86, $B6, $01, $C0, $0F, $0C, $01, $08, $FC, $F4

;Glass Joe, Don Flamenco 1 and 2.
L8E93:  .byte $F2, $05, $01, $15, $51, $22, $87, $B6, $EC
L8E9C:  .byte $1D, $7C, $EE, $51, $24, $7C, $AB, $7C, $EE, $80, $20, $FF, $F1, $AC, $8E, $1A

L8EAC:  .byte $EC, $80, $38, $1A, $51, $22, $87, $B6, $EC, $20, $70, $EE, $F2, $05, $01, $33
L8EBC:  .byte $7C, $EE, $92, $44, $03, $6C, $40, $80, $14, $FF, $51, $22, $87, $B6, $EC, $4C
L8ECC:  .byte $70, $EE, $F2, $05, $01, $33, $51, $24, $81, $B0, $78, $EE, $92, $44, $03, $62
L8EDC:  .byte $40, $3F, $17, $7C, $EF, $EC, $09, $7C, $EF, $51, $24, $6D, $A7, $7C, $EF, $7C
L8EEC:  .byte $EF, $11, $26, $57, $9C, $7C, $EF, $7D, $EF, $5F, $32, $37, $8D, $80, $18, $7B
L8EFC:  .byte $1F, $67, $2F, $66, $2F, $64, $2F, $72, $2F, $71, $2F, $58, $34, $57, $81, $F5
L8F0C:  .byte $01, ST_CALL_FUNC, $59, $92, $80, $01, $F2, $BB, $01, $64, $EC, $39, $4F, $36, $EC, $39
L8F1C:  .byte $80, $10, $F2, $BB, $02, $5B, $4F, $38, $80, $10, $0F, $06, ST_WRITE_BYTE, $BB, $04, $0F
L8F2C:  .byte $80, $94, $D0, $04, $87, $96, $06, $03, ST_CALL_FUNC, $42, $92, $01, $02, ST_WRITE_BYTE
L8F2A:  .byte $BB, $00
L8F3C:  .byte $80, $01, $F2, $BB, $00, $90, $F1, $FD, $90, $54

L8F46:  .byte $EC, $80, $F2, $BB, $02, $37
L8F4C:  .byte $38, $1E, $11, $1E, $87, $B6, $EC, $20, $F2, $05, $01, $54, $70, $2E, $7C, $2E
L8F5C:  .byte $92, $44, $03, $99, $40, $80, $14, $FF, $11, $1E, $87, $B6, $EC, $4C, $F2, $05
L8F6C:  .byte $01, $54, $70, $2E, $11, $20, $8D, $B0, $78, $2E, $92, $44, $03, $A3, $40, $3F
L8F7C:  .byte $1B, $12, $1E, $80, $B6, $EC, $20, $7C, $1E, $92, $44, $03, $88, $44, $3F, $1B
L8F8C:  .byte $EC, $09, $5F, $32, $A6, $99, $66, $2F, $66, $2F, $66, $2F, $3F, $66, $74, $2E
L8F9C:  .byte $13, $20, $8F, $AF, $EC, $09, $7A, $2F, $52, $30, $99, $AA, $7D, $2F, $F5, $02
L8FAC:  .byte $EC, $09, $61, $6F, $00, $0F, $28, $6A, $EE, $73, $FF, $72, $FF, $71, $FF, $63
L8FBC:  .byte $EE, $F3, $46, $78, $FF, $70, $EE, $18, $2A, $A7, $81, $F5, $01, ST_CALL_FUNC, $59, $92
L8FCC:  .byte $80, $01, $F2, $BB, $01, $86, $EC, $39, $0F, $2C, $EC, $39, $80, $10, $F2, $BB
L8FDC:  .byte $02, $7D, $0F, $2E, $80, $10, $F1, $AC, $8E, $7A

L8FE6:  .byte $EC, $80, $12, $1C, $83, $B6
L8FEC:  .byte $EC, $4C, $F2, $05, $01, $17, $70, $FF, $75, $FF, $92, $44, $03, $7C, $54, $3F
L8FFC:  .byte $4E, $74, $EE, $12, $C8, $78, $AE, $78, $FF, $F5, $06, $EC, $09, $80, $02, $61
L900C:  .byte $60, $00, $03, $CA, $61, $8E, $00, $01, $C8, $70, $DF, $F3, $21, $61, $F0, $F1
L901C:  .byte $AC, $8E, $49

L901F:  .byte $EC, $80, $12, $1C, $87, $B6, $EC, $4C, $F2, $05, $01, $18, $70
L902C:  .byte $1F, $75, $1F, $92, $44, $03, $8C, $54, $80, $0F, $FF, $74, $1F, $12, $CA, $8F
L903C:  .byte $B1, $78, $1F, $F5, $06, $EC, $09, $80, $02, $63, $90, $00, $03, $C8, $61, $7E
L904C:  .byte $00, $01, $CA, $70, $2F, $F3, $22, $61, $11, $F5, $01, $F1, $46, $8F, $66

L905B:  .byte $EC
L905C:  .byte $2D, ST_CALL_FUNC, $11, $92, $80, $08, $F5, $02, $38, $0D, $F5, $04, $08, $06, $01, $80
L906C:  .byte $EC, $31, $05, $CC, $F3, $0D, $80, $18, $61, $F1, $00, $04, $C0, $E9, $01, $80
L907C:  .byte $05, $61, $D1, $00, $01, $C4, ST_CALL_FUNC, $9E, $92, $7A, $E5, $70, $05, ST_DEFENSE
L907A:  .byte $00, $00
L908C:  .byte $00, $00, $00, ST_WRITE_BYTE, $BA, $FF, $00

L9093:  .byte $04, $C0, ST_WRITE_BYTE, $BA, $01, $80, $0C, ST_WRITE_BYTE, $BA
L909C:  .byte $00, $F4, ST_WRITE_BYTE, $BD, $03, $00, $F4

;Don Flamenco additional state data.

L90A3:  .byte $F2, $06, $01, $0F, $94, $9D, $04, $26, $30
L90AC:  .byte $8F, $80, $F1, $FD, $90, $00, $01, $3E, $F2, $1B, $00, $0F, $80, $20, $EC, $83
L90BC:  .byte $EC, $4A, $80, $15, $F5, $0A, $0C, $CC, $61, $F2, $00, $08, $3E, $F3, $1F, $F5
L90CC:  .byte $03, $0C, $CC, $61, $1E, $00, $08, $3E, $F3, $2A, $0F, $CC, $0F, $3E, $94, $9D
L90DC:  .byte $04, $26, $30, $8F, $80, $0F, $3C, $80, $0F, $08, $16, $08, $18, $EC, $25, $1F
L90EC:  .byte $40, $DF, $7A, $80, $20, $EC, $30, $80, $20, $EC, $07, $08, $00, $F1, $FD, $90
L90FC:  .byte $1A

;Glass Joe additonal state data.

L90FD:  .byte $01, $02, $F2, $1B
L9101:  .byte $00, $00, $F2, $06
L9105:  .byte $04, $85, $F2, $06
L9109:  .byte $01, $6F, $F5, $01
L910D:  .byte ST_CALL_FUNC, $D1, $91, $EC, $30, $F5, $01
L9114:  .byte ST_CALL_FUNC, $D1, $91, $EC, $2A, $F5, $01, ST_CALL_FUNC
L911C:  .byte $D1, $91, $F5, $05, ST_CALL_FUNC
L9121:  .byte $EA, $91, $02, $02, $61, ST_CALL_FUNC, $00, $03, $C4, $63, $F0
L912C:  .byte $62, $F1, $02, $06, $65, $03, $02, $04, $61, ST_CALL_FUNC, $00, $03, $C4, $63, $F0, $62
L913C:  .byte $F1, $02, $00, $65, $03, $F8, $EC, $7E, $F5, $01, ST_CALL_FUNC, $D1, $91, $F2, $BB, $00
L914C:  .byte $47, $F2, $BB, $FF, $85, $F8, ST_WRITE_BYTE, $68, $00, $01, $80, $F5, $02, ST_CALL_FUNC
L915A:  .byte $6D, $92
L915C:  .byte $08, $80, $FF, $D0, $80, $66, $FF, $80, $20, $EC, $1A, ST_WRITE_BYTE, $00, $FE, $80, $FF
L916C:  .byte $80, $20, $EC, $83, $01, $3A, $EC, $46, $80, $FF, $80, $96, $EC, $30, $80, $20
L917C:  .byte $EC, $07, $08, $00, $3F, $1A, $F1, $86, $91, $00, $80, $01, $F2, $BB, $00, $00
L918C:  .byte $F2, $BB, $01, $27, $F5, $02, ST_CALL_FUNC, $3B, $92, $E8, $73, $01, $02, $2F, $F8, $F5
L919C:  .byte $07, $F2, $06, $04, $1D, $F5, $0B, ST_CALL_FUNC, $3B, $92, ST_WRITE_BYTE, $BB, $ED, $80
L91AA:  .byte $FF, $80
L91AC:  .byte $FF, $08, $0A, $01, $C0, $06, $0C, $3F, $2B, ST_WRITE_BYTE, $8E, $01, $3F, $14

L91BA:  .byte $1F, $08, $87, $B6, $94, $D0, $04, $87, $96, $06, $04, ST_CALL_FUNC, $42, $92, $01, $02
L91CA:  .byte ST_WRITE_BYTE, $BB, $00, $F1, $FD, $90, $47

L91D1:  .byte $02, $02, $04, $C4, $63, $01  ;

L91D7:  .byte $61, $0F, $00, $07, $06, $02, $04, $04, $C4, $63, $01, $61, $0F, $00, $07, $00
L91E7:  .byte $F3, $00, ST_RETURN_FUNC

L91EA:  .byte $02, $02, $61, $D0, $00, $03  ;

L91F0:  .byte $C4, $63, $F0, $62, $F1, $61, $EF, $00, $02, $06, $65, $F2, $02, $04, $61, $E0
L9200:  .byte $00, $03, $C4, $63, $D0, $62, ST_RETURN_FUNC, $61, $0F, $00, $02, $00, $65, $F2, $F3, $00
L9210:  .byte ST_RETURN_FUNC

L9211:  .byte $F9, ST_DEFENSE, $20, $20, $20, $20  ;

L9217:  .byte $00, $11, $0A, $87, $B6, $E9, $00, $F5, $02, $01, $82, $61, $2E, $00, $02, $C4
L9227:  .byte $61, $29, $61, $1B, $61, $1D, $00, $02, $80, $61, $0F, $01, $C0, $61, $01, $63
L9237:  .byte $01, $F3, $0F, ST_RETURN_FUNC

L923B:  .byte $08, $02, $08, $3A, $F3, $00  ;

L9241:  .byte ST_RETURN_FUNC

L9242:  .byte $04, $C4, $00, $A4, $16, $07  ;

L9248:  .byte $C0, $00, $A7, $16, $04, $C4, $00, $A4, $16, $07, $C2, $00, $A7, $16, $3F, $00
L9258:  .byte ST_RETURN_FUNC

L9259:  .byte $64, $0C, $EC, $05, $68, $04  ;

L925F:  .byte $63, $0D, $66, $03, $62, $0E, $64, $02, $F3, $0A, ST_WRITE_BYTE, $BB, $01, ST_RETURN_FUNC

L926D:  .byte $61, $02, $00, $03, $C4, $62  ;

L9273:  .byte $02, $02, $C0, $67, $04, $61, $02, $00, $03, $C4, $62, $02, $02, $C2, $67, $04
L9283:  .byte $F3, $00, ST_RETURN_FUNC, $61, $02, $00, $03, $C4, $62, $02, $02, $C2, $67, $04
L9291:  .byte ST_RETURN_FUNC

DefenseStats1:
L9292:  .byte ST_DEFENSE        ;Load opponent's defense data from following 4 bytes.
L9293:  .byte $FF, $FF          ;Face punch defense values.
L9295:  .byte $FF, $FF          ;Stomach punch defense values.
L9297:  .byte ST_RETURN_FUNC    ;Return from function call.

DefenseStats2:
L9298:  .byte ST_DEFENSE        ;Load opponent's defense data from following 4 bytes.
L9299:  .byte $20, $20          ;Face punch defense values.
L929B:  .byte $20, $20          ;Stomach punch defense values.
L929D:  .byte ST_RETURN_FUNC    ;Return from function call.

DefenseStats3:
L929E:  .byte ST_DEFENSE        ;Load opponent's defense data from following 4 bytes.
L929F:  .byte $08, $08          ;Face punch defense values.
L92A1:  .byte $08, $08          ;Stomach punch defense values.
L92A3:  .byte ST_RETURN_FUNC    ;Return from function call.

DefenseStats4:
L92A4:  .byte ST_DEFENSE        ;Load opponent's defense data from following 4 bytes.
L92A5:  .byte $08, $08          ;Face punch defense values.
L92A7:  .byte $00, $00          ;Stomach punch defense values.
L92A9:  .byte ST_RETURN_FUNC    ;Return from function call.

DefenseStats5:
L92AA:  .byte ST_DEFENSE        ;Load opponent's defense data from following 4 bytes.
L92AB:  .byte $00, $00          ;Face punch defense values.
L92AD:  .byte $08, $08          ;Stomach punch defense values.
L92AF:  .byte ST_RETURN_FUNC    ;Return from function call.

DefenseStats6:
L92B0:  .byte ST_DEFENSE        ;Load opponent's defense data from following 4 bytes.
L92B1:  .byte $00, $00          ;Face punch defense values.
L92B3:  .byte $00, $00          ;Stomach punch defense values.
L92B5:  .byte ST_RETURN_FUNC    ;Return from function call.

;------------------------------------------[ Palette Data ]------------------------------------------

;Glass Joe arena palette data. Background palette first, then sprite palette.
L92B6:  .byte $11, $30, $38, $8F, $11, $16, $38, $8F, $11, $30, $26, $8F, $11, $2A, $8F, $36
L92C6:  .byte $11, $35, $30, $08, $11, $35, $16, $08, $11, $16, $30, $08, $11, $35, $27, $08

;Don Flamenco 1 arena palette data. Background palette first, then sprite palette.
L92D6:  .byte $1A, $30, $32, $8F, $1A, $16, $32, $8F, $1A, $30, $27, $8F, $1A, $2C, $8F, $36
L92E6:  .byte $1A, $26, $30, $8F, $1A, $26, $22, $8F, $1A, $22, $30, $8F, $1A, $16, $1A, $8F

;Don Flamenco 2 arena palette data. Background palette first, then sprite palette.
L92F6:  .byte $1C, $30, $3A, $8F, $1C, $16, $3A, $8F, $1C, $30, $27, $8F, $1C, $2A, $8F, $36
L9306:  .byte $1C, $26, $30, $8F, $1C, $26, $2B, $8F, $1C, $2B, $30, $8F, $1C, $16, $1A, $8F

;----------------------------------------------------------------------------------------------------

;Fight data - Glass Joe. Loaded into $05A0 through $05FF.

L9316:  .byte $E0, $E0, $E0, $00, $20, $00

L931C:  .byte $20               ;Starting number of hearts, round 1(base 10).
L931D:  .byte $15               ;Normal heart recovery, round 1(base 10).
L931E:  .byte $09               ;Reduced heart recovery, round 1(base 10).
L931F:  .byte $20               ;Starting number of hearts, round 2(base 10).
L9320:  .byte $15               ;Normal heart recovery, round 2(base 10).
L9321:  .byte $09               ;Reduced heart recovery, round 2(base 10).
L9322:  .byte $15               ;Starting number of hearts, round 3(base 10).
L9323:  .byte $10               ;Normal heart recovery, round 3(base 10).
L9324:  .byte $05               ;Reduced heart recovery, round 3(base 10).
L9325:  .byte $04               ;Base damage if opponent lands a hit on Little Mac.
L9326:  .byte $14               ;Number of hits that must be landed before stars will be given.

L9327:  .byte $08, $08, $08, $08, $00, $00, $00

L932E:  .byte $40               ;Opponent reaction time to move guard up and down.

L932F:  .byte $20, $9C, $8C, $80, $00, $06, $08

L9336:  .word $0000, $9376      ;Combo data.

L933A:  .byte $00, $03, $00, $00, $00, $00, $05, $00, $00, $00, $DF, $7A

L9346:  .word $937E             ;Little Mac knock down data.

L9348:  .byte $00, $08, $00

L934B:  .word $93C6             ;Opponent knock down data.

L934D:  .byte $1F, $00, $00, $04, $F9, $05, $6D, $05, $F8

;Random opponent stand up times after knock down. #$9B=2 through #$A1=8.
L9356:  .byte $9B, $9C, $9D, $9E, $9F, $A1, $9C, $9D

L935E:  .word $940E, $9452

L9363:  .byte $26               ;Opponent outline color when Little Mac should dodge.
L9364:  .byte $08               ;Normal opponent outline color.

L9365:  .word $93F6

;Opponent messages.
L9366:  .byte $A1               ;"This is my last match! I'm too old for fighting!"
L9367:  .byte $A2               ;"Make it quick! I want to retire..."
L9368:  .byte $A3               ;"Watch the jaw!! Don't hit my jaw!"
L9369:  .byte $A4               ;"Do I have time to take a nap before the fight?"
L936A:  .byte $A4               ;"Do I have time to take a nap before the fight?"
L936B:  .byte $A3               ;"Watch the jaw!! Don't hit my jaw!"
L936C:  .byte $A2               ;"Make it quick! I want to retire..."
L936D:  .byte $A1               ;"This is my last match! I'm too old for fighting!"

;Trainer and Little Mac messages.
L936E:  .byte $8A               ;"Listen Mac!! Dodge his punch then counter-punch!"
L936F:  .byte $82               ;"Put him away!"
L9370:  .byte $83               ;"Stick and move, stick and move!"
L9371:  .byte $84               ;"Watch his left!"
L9372:  .byte $85               ;"One two, one two punch Mac!"
L9373:  .byte $8C               ;"Listen Mac!! Catch him off-guard to stun him! Then unload on him!"
L9374:  .byte $8B               ;"Listen Mac!! Give him a fast upper-cut when he's stunned!"
L9375:  .byte $8A               ;"Listen Mac!! Dodge his punch then counter-punch!"

;----------------------------------------------------------------------------------------------------

;Glass Joe.
L9376:  .byte $36               ;Combo timer byte.
L9377:  .byte $05               ;Combo total hits byte.

L9378:  .byte $48, $06, $7F, $08, $FF, $01

L937E:  .byte $11, $00, $07, $25, $39, $25, $39, $25, $39, $25, $39, $25, $10, $00
L938C:  .byte $07, $12, $26, $12, $26, $12, $26, $12, $26, $12, $0F, $00, $08, $02, $33, $02
L939C:  .byte $33, $02, $33, $02, $33, $02, $0E, $00, $09, $01, $32, $01, $32, $01, $32, $01
L93AC:  .byte $32, $01, $01, $00, $7F, $00, $00, $00, $00, $00, $00, $00, $00, $00, $01, $00
L93BC:  .byte $7F, $00, $00, $00, $00, $00, $00, $00, $00, $00

L93C6:  .byte $E0, $1C, $0A, $0A, $0A, $0A
L93CC:  .byte $0A, $0A, $60, $1C, $06, $06, $06, $06, $06, $06, $00, $1C, $05, $05, $05, $05
L93DC:  .byte $05, $05, $00, $1C, $01, $01, $01, $01, $01, $01, $00, $1C, $01, $00, $01, $00
L93EC:  .byte $01, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L93FC:  .byte $00, $00

L93FE:  .byte $20, $20, $20, $08, $20, $40, $10, $10, $10, $10, $20, $20, $40, $40
L940C:  .byte $40, $08, $C0, $FF, $00, $0D, $00, $FF, $20, $0D, $00, $FF, $20, $04, $02, $FF
L941C:  .byte $60, $0D, $00, $FF, $60, $02, $08, $D0, $98, $D3, $FF, $00, $02, $04, $E2, $BA
L942C:  .byte $05, $8C, $8C, $0C, $E0, $C0, $FF, $00, $02, $06, $FE, $06, $82, $FE, $26, $82
L943C:  .byte $FE, $66, $82, $D0, $A2, $D3, $0C, $E0, $C0, $FE, $06, $84, $FE, $26, $84, $FE
L944C:  .byte $66, $84, $D0, $A2, $D3, $0B, $5C, $94, $69, $94, $6D, $94, $6F, $94, $71, $94
L945C:  .byte $73, $94, $9A, $94, $00, $18, $81, $50, $80, $FF, $80, $00, $00, $9A, $94, $96
L946C:  .byte $94, $78, $94, $9B, $94, $B9, $94, $F1, $80, $FF, $1F, $01, $F1, $80, $40, $1A
L947C:  .byte $0F, $04, $95, $8F, $04, $96, $87, $04, $95, $1F, $17, $04, $95, $8F, $04, $95
L948C:  .byte $8F, $04, $95, $87, $18, $01, $80, $80, $1F, $01, $01, $99, $01, $95, $F0, $F1
L949C:  .byte $80, $20, $1A, $0F, $04, $95, $87, $04, $95, $83, $04, $96, $1F, $17, $04, $95
L94AC:  .byte $87, $04, $96, $87, $04, $95, $87, $18, $01, $80, $20, $1F, $01, $F1, $82, $0C
L94BC:  .byte $95, $08, $95, $08, $95, $1F, $01

;----------------------------------------------------------------------------------------------------

;********** Layer 2 **********

;Don Flamenco 1.
L94C3:  .byte $F0, $F0, $F0, $07, $28, $00, $10, $07, $03, $07, $05, $02, $07, $04, $02, $07
L94D3:  .byte $01, $01, $04, $04, $0F, $00, $00, $00, $01, $01, $81, $81, $01, $00, $06, $08

L94E3:  .word $9583, $958E

L94E7:  .byte $60, $03, $00, $00, $00, $01, $00, $00, $00, $02, $DF, $7A

L94F3:  .word $95AA

L94F5:  .byte $00, $5F, $00, $3A, $96, $1F, $00, $00, $04, $F9, $05, $6D, $05, $F8
L9503:  .byte $9B, $9C, $9E, $9E, $9F, $A1, $9C, $9C, $CA, $96, $45, $97, $16, $8F, $9A, $96
L9513:  .byte $C5, $C6, $C7, $C8, $C8, $C7, $C6, $C5, $85, $86, $82, $83, $82, $83, $85, $86

;----------------------------------------------------------------------------------------------------

;********** Layer 2 **********

;Don Flamenco 2.
L9523:  .byte $F0, $F8, $F8, $10, $40, $00, $15, $10, $05, $10, $08, $03, $08, $08, $02, $0C
L9533:  .byte $01, $07, $03, $03, $01, $00, $00, $00, $18, $0A, $88, $81, $18, $00, $06, $08

L9543:  .word $9588, $9598

L9547:  .byte $20, $02, $00, $00, $00, $00, $05, $00, $00, $20, $DF, $7A

L9553:  .word $95F2

L9555:  .byte $00, $0C, $00, $6A, $96, $2F, $00, $00, $05, $F8, $05, $F8, $05, $F8
L9563:  .byte $9B, $9C, $9D, $9E, $9F, $A1, $9C, $9D, $FA, $96, $4B, $97, $8F, $8F, $B2, $96
L9573:  .byte $B4, $C5, $B4, $C6, $C7, $B4, $C8, $B4, $82, $86, $83, $86, $87, $82, $86, $83

;----------------------------------------------------------------------------------------------------

L9583:  .byte $FE, $FE, $FD, $FF, $02

L9588:  .byte $FE, $01, $01, $00, $FF, $01
L958E:  .byte $39, $01, $4B, $04, $56, $06, $7F, $07, $FF, $01
L9598:  .byte $39, $01, $46, $02, $4A, $03, $4C, $04, $54, $08, $56, $0A, $58, $0C, $7F, $10

L95A8:  .byte $FF, $01, $10, $00
L95AC:  .byte $07, $25, $25, $25, $25, $25, $25, $3A, $3A, $3A, $0F, $00, $07, $13, $13, $13
L95BC:  .byte $13, $13, $13, $37, $37, $37, $0E, $00, $0A, $44, $44, $44, $44, $44, $44, $14
L95CC:  .byte $14, $14, $01, $00, $7F, $00, $00, $00, $00, $00, $00, $00, $00, $00, $01, $00
L95DC:  .byte $7F, $00, $00, $00, $00, $00, $00, $00, $00, $00, $01, $00, $7F, $00, $00, $00
L95EC:  .byte $00, $00, $00, $00, $00, $00, $0F, $00, $07, $36, $26, $36, $26, $36, $26, $36
L95FC:  .byte $16, $3A, $0E, $00, $0C, $62, $61, $62, $61, $62, $61, $62, $42, $36, $01, $00
L960C:  .byte $7F, $00, $00, $00, $00, $00, $00, $00, $00, $00, $01, $00, $7F, $00, $00, $00
L961C:  .byte $00, $00, $00, $00, $00, $00, $01, $00, $7F, $00, $00, $00, $00, $00, $00, $00
L962C:  .byte $00, $00, $01, $00, $7F, $00, $00, $00, $00, $00, $00, $00, $00, $00, $E0, $02
L963C:  .byte $0B, $09, $0B, $0B, $0A, $0A, $E0, $00, $0A, $08, $0A, $0A, $09, $09, $60, $03
L964C:  .byte $07, $05, $07, $07, $06, $06, $60, $01, $06, $04, $06, $06, $05, $05, $60, $01
L965C:  .byte $05, $03, $05, $05, $02, $00, $60, $00, $00, $02, $04, $00, $03, $03, $61, $00
L966C:  .byte $0A, $09, $08, $0A, $09, $0A, $60, $07, $0A, $09, $05, $0A, $09, $0A, $60, $06
L967C:  .byte $0A, $0A, $04, $09, $09, $09, $60, $05, $09, $09, $09, $09, $04, $09, $60, $00
L968C:  .byte $05, $00, $05, $05, $05, $05, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L969C:  .byte $00, $00, $00, $00, $00, $00, $08, $20, $20, $20, $20, $40, $10, $10, $08, $20
L96AC:  .byte $20, $20, $08, $40, $40, $40, $D0, $D0, $D0, $D0, $D0, $D0, $D0, $D0, $10, $08
L96BC:  .byte $04, $08, $10, $04, $04, $40, $20, $08, $04, $08, $08, $40, $20, $20, $C0, $FF
L96CC:  .byte $00, $0D, $00, $FF, $20, $0D, $00, $FF, $20, $04, $02, $FF, $60, $0D, $00, $FF
L96DC:  .byte $60, $04, $04, $D0, $E0, $0C, $E0, $C0, $FD, $05, $0E, $61, $FD, $65, $0E, $61
L96EC:  .byte $D0, $66, $FE, $66, $53, $0C, $E0, $C0, $FE, $66, $4C, $D0, $E0, $0B, $C0, $FF
L96FC:  .byte $00, $0D, $00, $FE, $0A, $80, $FF, $20, $0D, $00, $FF, $20, $04, $02, $FF, $60
L970C:  .byte $0D, $00, $FF, $60, $04, $04, $D0, $66, $FF, $B8, $05, $06, $FE, $0A, $FF, $D3
L971C:  .byte $FD, $00, $D1, $97, $0C, $E0, $C0, $D0, $48, $D3, $FF, $00, $0D, $00, $FD, $05
L972C:  .byte $08, $31, $FD, $65, $08, $31, $FE, $0A, $F0, $0C, $E0, $C0, $FD, $00, $E4, $97
L973C:  .byte $FE, $06, $32, $FE, $66, $32, $D0, $E0, $0B, $53, $97, $60, $97, $64, $97, $68
L974C:  .byte $97, $75, $97, $79, $97, $7D, $97, $82, $97, $98, $97, $00, $0F, $69, $38, $FF
L975C:  .byte $FF, $FF, $FF, $00, $9A, $94, $9A, $94, $8F, $97, $9A, $94, $A2, $97, $9A, $94
L976C:  .byte $00, $09, $39, $38, $80, $80, $F8, $00, $00, $9A, $94, $CB, $97, $8F, $97, $BC
L977C:  .byte $97, $01, $01, $81, $81, $01, $F1, $80, $10, $01, $98, $81, $20, $08, $81, $10
L978C:  .byte $04, $1F, $01, $F1, $01, $95, $01, $95, $01, $95, $1F, $01, $F1, $01, $99, $02
L979C:  .byte $97, $F2, $BD, $03, $03, $F0, $F1, $80, $10, $F3, $03, $01, $96, $F2, $BD, $04
L97AC:  .byte $16, $88, $01, $95, $80, $01, $18, $0E, $80, $40, $1F, $03, $F4, $05, $1F, $0C
L97BC:  .byte $F1, $F3, $08, $01, $99, $02, $97, $F2, $BD, $03, $0C, $F0, $F4, $05, $F0, $F1
L97CC:  .byte $01, $98, $04, $98, $F0, $F1, $80, $10, $01, $98, $81, $20, $08, $81, $10, $04
L97DC:  .byte $F2, $BC, $01, $01, $02, $96, $1F, $0F, $F1, $01, $96, $01, $95, $01, $95, $01
L97EC:  .byte $96, $1F, $01

;Unused.
L97EF:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L97FF:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L980F:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L981F:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L982F:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L983F:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L984F:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L985F:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L986F:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L987F:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L988F:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L989F:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L98AF:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L98BF:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L98CF:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L98DF:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L98EF:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L98FF:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L990F:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L991F:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L992F:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L993F:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L994F:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L995F:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L996F:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L997F:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L998F:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L999F:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L99AF:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L99BF:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L99CF:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L99DF:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L99EF:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L99FF:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9A0F:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9A1F:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9A2F:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9A3F:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9A4F:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9A5F:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9A6F:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9A7F:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9A8F:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9A9F:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9AAF:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9ABF:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9ACF:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9ADF:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9AEF:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9AFF:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9B0F:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9B1F:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9B2F:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9B3F:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9B4F:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9B5F:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9B6F:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9B7F:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9B8F:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9B9F:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9BAF:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9BBF:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9BCF:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9BDF:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9BEF:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9BFF:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9C0F:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9C1F:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9C2F:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9C3F:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9C4F:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9C5F:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9C6F:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9C7F:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9C8F:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9C9F:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9CAF:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9CBF:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9CCF:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9CDF:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9CEF:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9CFF:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9D0F:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9D1F:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9D2F:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9D3F:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9D4F:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9D5F:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9D6F:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9D7F:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9D8F:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9D9F:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9DAF:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9DBF:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9DCF:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9DDF:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9DEF:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9DFF:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9E0F:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9E1F:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9E2F:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9E3F:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9E4F:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9E5F:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9E6F:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9E7F:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9E8F:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9E9F:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9EAF:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9EBF:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9ECF:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9EDF:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9EEF:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9EFF:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9F0F:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9F1F:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9F2F:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9F3F:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9F4F:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9F5F:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9F6F:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9F7F:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9F8F:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9F9F:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9FAF:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9FBF:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9FCF:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9FDF:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9FEF:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9FFF:  .byte $00