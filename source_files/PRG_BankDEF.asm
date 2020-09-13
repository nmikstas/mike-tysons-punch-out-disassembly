.org $A000

.include "Mike_Tysons_Punchout_Defines.asm"

;--------------------------------------[ Forward Declarations ]--------------------------------------

.alias DoBusyPassword           $803F
.alias DoCircuitPassword        $8042
.alias DoCreditsPassword        $8048
.alias DoTysonPassword          $804E

;-----------------------------------------[ Start of code ]------------------------------------------

RESET:
IRQ:
LA000:  SEI                     ;Disable interrupts.
LA001:  CLD                     ;Put processor in binary mode.

LA002:  LDX #$FF                ;Manually reset stack pointer.
LA004:  TXS                     ;

LA005:  JMP DoReset             ;($A1C4)Continue with the game reset.

NMI:
LA008:  PHA                     ;
LA009:  TXA                     ;
LA00A:  PHA                     ;Save A, X and Y on the stack.
LA00B:  TYA                     ;
LA00C:  PHA                     ;

LA00D:  LDX GameStatus
LA00F:  BNE $A017

LA011:  LDA PPUStatus
LA014:  JMP $A5C3

LA017:  BPL $A01F

LA019:  LDA PPUStatus
LA01C:  JMP $A6E5

LA01F:  CPX #$02
LA021:  BEQ _ExitNMI

LA023:  BCS $A02E

LA025:  LDA PPUStatus
LA028:  JSR $A9D1

_ExitNMI:
LA02B:  JMP ExitNMI             ;($A6DF)Exit NMI interrupt routine.

LA02E:  JSR PushPRGBank08       ;($AA40)
LA031:  JSR $8000

LA034:  JSR PopPRGBank          ;($AA6A)
LA037:  JMP ExitNMI             ;($A6DF)Exit NMI interrupt routine.

LA03A:  JSR $A06B
LA03D:  JSR $A09A

LA040:  LDA $E0
LA042:  JSR $A06B
LA045:  LDX #$0C
LA047:  JSR $A065

LA04A:  NOP
LA04B:  DEX
LA04C:  BNE $A047
LA04E:  NOP
LA04F:  NOP
LA050:  NOP
LA051:  LDA $15
LA053:  LDX #$00
LA055:  STA PPUScroll
LA058:  STX PPUScroll
LA05B:  NOP
LA05C:  NOP
LA05D:  NOP
LA05E:  LDA $06DE
LA061:  CMP #$1E
LA063:  BNE $A042
LA065:  RTS

LA066:  LDA #$00
LA068:  NOP
LA069:  BEQ $A07E
LA06B:  LDY #$02
LA06D:  BNE $A071
LA06F:  LDY #$00
LA071:  LDX $06DE
LA074:  LDA $06C0,X
LA077:  BPL $A066
LA079:  LDA $E0
LA07B:  LDA $06C1,X
LA07E:  CLC
LA07F:  ADC $06C2,X
LA082:  STA $06C2,X
LA085:  STA $13,Y
LA088:  LDA $06C0,X
LA08B:  ROL
LA08C:  LDA $06C0,X
LA08F:  ROL
LA090:  STA $06C0,X
LA093:  INX
LA094:  INX
LA095:  INX
LA096:  STX $06DE
LA099:  RTS

LA09A:  LDA PPU1Load
LA09C:  AND #$18
LA09E:  CMP #$18
LA0A0:  BNE $A0D0
LA0A2:  LDA $12
LA0A4:  BNE $A0D0
LA0A6:  LDA $22
LA0A8:  BNE $A0D0
LA0AA:  LDX $15
LA0AC:  LDA PPU0Load
LA0AE:  AND #$FC
LA0B0:  ORA $16
LA0B2:  STA PPU0Load
LA0B4:  TAY
LA0B5:  LDA PPUStatus
LA0B8:  AND #$40
LA0BA:  BNE $A0B5
LA0BC:  LDA PPUStatus
LA0BF:  AND #$40
LA0C1:  BEQ $A0BC
LA0C3:  NOP
LA0C4:  NOP
LA0C5:  STX PPUScroll
LA0C8:  LDA #$00
LA0CA:  STA PPUScroll
LA0CD:  STY PPUControl0
LA0D0:  RTS

LA0D1:  .byte $00, $00, $02, $00, $05, $30, $00, $10, $01, $00, $02, $10, $03, $30, $05, $20
LA0E1:  .byte $04, $10, $03, $20, $00, $20, $03, $10, $04, $30, $05, $40, $FF, $FF, $FF, $FF
LA0F1:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $03, $00, $01, $00, $02, $10, $05, $20, $04, $10
LA101:  .byte $03, $20, $00, $20, $03, $10, $04, $30, $05, $40, $FF, $FF, $01, $00, $81, $00
LA111:  .byte $02, $00, $01, $00, $03, $01, $00, $00, $04, $03, $81, $00, $05, $03, $01, $00
LA121:  .byte $06, $04, $01, $00, $07, $05, $00, $00, $08, $07, $81, $00, $09, $07, $01, $00
LA131:  .byte $0A, $08, $01, $00, $0B, $09, $01, $00, $0C, $0A, $01, $00, $0D, $0A, $00, $00
LA141:  .byte $0E, $0E, $00, $00, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LA151:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $0E, $0E, $00, $00, $15, $1D, $00, $00
LA161:  .byte $16, $1D, $00, $00, $17, $1D, $00, $00, $18, $1D, $00, $00, $19, $1D, $00, $00
LA171:  .byte $1A, $1D, $00, $00, $1B, $1D, $00, $00, $1C, $1D, $00, $00, $1D, $1D, $00, $00
LA181:  .byte $FF, $FF, $FF, $FF, $00, $03, $07, $0C, $14, $0D, $00, $80, $32, $31, $30, $23
LA191:  .byte $22, $21, $20, $15, $14, $13, $12, $11, $10, $00, $FF, $FF, $FF, $FF, $FF, $20
LA1A1:  .byte $48, $47, $46, $45, $44, $43, $42, $41, $40, $FF, $4E, $49, $4E, $54, $45, $4E
LA1B1:  .byte $44, $4F, $2E, $31, $39, $38, $37, $52, $44, $33, $FF, $02, $E0, $FF, $04, $E0
LA1C1:  .byte $01, $01, $20

DoReset:
LA1C4:  LDA #%00010000          ;bg pt=$1000, sprt pt=$0000, base nt=$2000, row write, disable NMI.
LA1C6:  STA PPUControl0         ;
LA1C9:  LDA #%00000110          ;Turn off screen, enable bg and sprites on left 8 pixel columns.
LA1CB:  STA PPUControl1         ;

LA1CE:  LDA PPUStatus           ;Wait for the vblank period.
LA1D1:  BPL DoReset             ;

LA1D3:* LDA PPUStatus           ;Wait for the vblank period.
LA1D6:  BPL -                   ;

LA1D8:  LDA #%00010000          ;bg pt=$1000, sprt pt=$0000, base nt=$2000, row write, disable NMI.
LA1DA:  STA PPUControl0         ;
LA1DD:  LDA #%00000110          ;Turn off screen, enable bg and sprites on left 8 pixel columns.
LA1DF:  STA PPUControl1         ;

LA1E2:  JSR LoadPRGBank07       ;($AA54)

LA1E5:  LDA #$00
LA1E7:  STA $013E

LA1EA:  STA DMCCntrl0           ;Disable the DMC audio channel.
LA1ED:  STA DMCCntrl1           ;

LA1F0:  LDA #$40                ;Set APU into 4-step mode with interrupt disabled.
LA1F2:  STA APUCommonCntrl1     ;

LA1F5:  LDA #$0F                ;Turn on SQ1, SQ2, TRI and noise channels.
LA1F7:  STA APUCommonCntrl0     ;

LA1FA:  LDX #$00
LA1FC:  LDY #$0F
LA1FE:  LDA $0160,Y
LA201:  CMP $A1AB,Y
LA204:  BNE $A211

LA206:  DEY
LA207:  BPL $A1FE
LA209:  JSR $8030
LA20C:  BEQ $A215
LA20E:  LDX $013F

LA211:  TXS
LA212:  TXA
LA213:  BPL $A234
LA215:  LDX #$01
LA217:  LDY #$80
LA219:  LDA #$00
LA21B:  STA $E0
LA21D:  STX $E1
LA21F:  STA ($E0),Y
LA221:  INY
LA222:  BNE $A21F
LA224:  INX
LA225:  CPX #$08
LA227:  BNE $A21D
LA229:  LDX #$00
LA22B:  STX $E1
LA22D:  STA ($E0),Y
LA22F:  INY
LA230:  BNE $A22D
LA232:  BEQ $A25A
LA234:  LDX #$07
LA236:  LDY #$00
LA238:  TYA
LA239:  STA $E0
LA23B:  STX $E1
LA23D:  STA ($E0),Y
LA23F:  INY
LA240:  BNE $A23D
LA242:  DEX
LA243:  BPL $A23B

LA245:  LDY #$0F

LA247:  LDA $A1AB,Y
LA24A:  STA $0160,Y
LA24D:  DEY
LA24E:  BPL $A247

LA250:  TSX
LA251:  STX $013F
LA254:  LDX #$FF
LA256:  TXS
LA257:  JSR $801E

LA25A:  LDA #$10
LA25C:  STA PPUControl0
LA25F:  STA PPU0Load

LA261:  LDA #PPU_LEFT_EN        ;
LA263:  STA PPUControl1         ;Enable background and sprites in left column, disable screen.
LA266:  STA PPU1Load            ;

LA268:  LDA #$00
LA26A:  JSR $AA6E
LA26D:  LDA #$8F
LA26F:  LDY #$21
LA271:  STA ThisBkgPalette,Y
LA274:  DEY
LA275:  BPL $A271
LA277:  LDA #$01
LA279:  STA GameEngStatus
LA27B:  LDA PPUStatus
LA27E:  LDA PPU0Load
LA280:  ORA #$80
LA282:  STA PPU0Load
LA284:  STA PPUControl0
LA287:  LDA #$FF
LA289:  STA GameStatus
LA28B:  JSR $AF02
LA28E:  LDA $013F
LA291:  BNE $A2AC
LA293:  JSR LoadPRGBank06       ;($AA50)
LA296:  LDA #$02
LA298:  STA GameStatus
LA29A:  JSR $9000
LA29D:  LDA #$FF
LA29F:  STA GameStatus
LA2A1:  JMP $A505
LA2A4:  JSR $A4C6
LA2A7:  LDX #$FF
LA2A9:  TXS
LA2AA:  BNE $A2B8
LA2AC:  LDX #$FF
LA2AE:  TXS
LA2AF:  INX
LA2B0:  STX $013E
LA2B3:  LDA #$04
LA2B5:  STA $04C6
LA2B8:  JSR $AA1D
LA2BB:  LDA #$00
LA2BD:  STA GameStatus
LA2BF:  STA $04C8
LA2C2:  JSR $AA6E

LA2C5:  LDA PPU1Load            ;
LA2C7:  ORA #PPU_LEFT_EN        ;Enable background and sprites in left column.
LA2C9:  STA PPU1Load            ;

LA2CB:  LDA #$80
LA2CD:  STA $F0
LA2CF:  STA $F1
LA2D1:  STA $F3

LA2D3:  LDA #SPRT_BKG_OFF       ;Disable sprites and background.
LA2D5:  STA SprtBkgUpdt         ;

LA2D7:  JSR $AF02
LA2DA:  JSR $B6CB
LA2DD:  LDA #$05
LA2DF:  JSR $BC5F
LA2E2:  LDX #$00
LA2E4:  STX $04C0
LA2E7:  STX $04C1
LA2EA:  JSR $AE9B

LA2ED:  LDA #SPRT_BKG_ON        ;Enable sprites and background.
LA2EF:  STA SprtBkgUpdt         ;

LA2F1:  LDA #$FF
LA2F3:  STA GameStatus
LA2F5:  LDA #$40
LA2F7:  STA $04C7
LA2FA:  JSR $AF02
LA2FD:  DEC $04C7
LA300:  BNE $A365
LA302:  LDA #$40
LA304:  STA $04C7
LA307:  DEC $04C6
LA30A:  BNE $A365
LA30C:  LDA #$00
LA30E:  STA $04
LA310:  JSR $BF7E
LA313:  JMP $A4CC
LA316:  JSR LoadPRGBank0C       ;($AA64)
LA319:  LDA #$05
LA31B:  JSR $BC5F
LA31E:  LDY #$97
LA320:  LDA #$0D
LA322:  JSR $BFF6
LA325:  JSR LoadPRGBank07       ;($AA54)
LA328:  JSR $801B
LA32B:  LDX #$00
LA32D:  STX $04C0
LA330:  BEQ $A2FA
LA332:  JSR LoadPRGBank0C       ;($AA64)
LA335:  LDA #$06
LA337:  JSR $BC5F
LA33A:  LDY #$6E
LA33C:  LDA #$0D
LA33E:  JSR $BFF6
LA341:  JSR LoadPRGBank07       ;($AA54)
LA344:  JSR $8024
LA347:  JSR $8021
LA34A:  LDX #$00
LA34C:  STX $04C1
LA34F:  STX $04C2
LA352:  BEQ $A2FA
LA354:  LDA DPad1Status         ;($D2)
LA356:  LDX #$00
LA358:  CMP #$08
LA35A:  BEQ $A35E
LA35C:  LDX #$FF
LA35E:  STX $04C0
LA361:  BNE $A332
LA363:  BEQ $A316
LA365:  LDA DPad1History        ;($D3)
LA367:  BPL $A3BB
LA369:  AND #$7F
LA36B:  STA DPad1History        ;($D3)
LA36D:  JSR $A4C6
LA370:  LDA DPad1Status         ;($D2)
LA372:  AND #$03
LA374:  BEQ $A354
LA376:  LDA $04C0
LA379:  BEQ $A3DF
LA37B:  LDX $04C1
LA37E:  LDA $04C2
LA381:  BEQ $A3A5
LA383:  LDA DPad1Status         ;($D2)
LA385:  AND #$03
LA387:  CMP #$01
LA389:  BEQ $A3AA
LA38B:  DEC $0120,X
LA38E:  LDA $0120,X
LA391:  BPL $A395
LA393:  LDA #$09
LA395:  LDY #$0B
LA397:  STA $0120,X
LA39A:  STY $F0
LA39C:  JSR LoadPRGBank07       ;($AA54)
LA39F:  JSR $8027
LA3A2:  JMP $A2FA
LA3A5:  INC $04C2
LA3A8:  BNE $A395
LA3AA:  INC $0120,X
LA3AD:  LDA $0120,X
LA3B0:  CMP #$0A
LA3B2:  BNE $A395
LA3B4:  LDA #$00
LA3B6:  STA $0120,X
LA3B9:  BEQ $A395
LA3BB:  LDA $04C0
LA3BE:  BEQ $A3DF
LA3C0:  LDA A1History           ;($D5)
LA3C2:  BPL $A3CA
LA3C4:  AND #$7F
LA3C6:  STA A1History           ;($D5)
LA3C8:  BPL $A3D2
LA3CA:  LDA B1History           ;($D7)
LA3CC:  BPL $A3DF
LA3CE:  AND #$7F
LA3D0:  STA B1History           ;($D7)
LA3D2:  LDX $04C1
LA3D5:  LDA $04C2
LA3D8:  BEQ $A3A5
LA3DA:  BNE $A400
LA3DC:  JMP $A473
LA3DF:  LDA Strt1History        ;($D9)
LA3E1:  BPL $A3A2
LA3E3:  AND #$7F
LA3E5:  STA Strt1History        ;($D9)
LA3E7:  LDA $04C0
LA3EA:  BEQ $A3DC
LA3EC:  LDA $04C2
LA3EF:  BNE $A400
LA3F1:  JSR LoadPRGBank07       ;($AA54)

LA3F4:  JSR DoCircuitPassword   ;($8042)Check if user entered another world circuit password.
LA3F7:  BEQ $A46A

LA3F9:  JSR $8030
LA3FC:  BNE $A427
LA3FE:  BEQ $A44E
LA400:  INC $04C1
LA403:  LDX $04C1
LA406:  CPX #$0A
LA408:  BEQ $A443
LA40A:  JSR $A4C6
LA40D:  LDA #$00
LA40F:  LDY #$09
LA411:  JMP $A397
LA414:  LDA #$0A
LA416:  STA $04C6
LA419:  LDA #$12
LA41B:  STA $F0
LA41D:  LDA #$30
LA41F:  JSR $AF04
LA422:  DEC $04C6
LA425:  BNE $A419

LA427:  JSR $A4C6
LA42A:  JMP $A316

LA42D:  JSR DoBusyPassword      ;($803F)Check for busy signal passwords.
LA430:  BEQ $A414

LA432:  JSR $8045
LA435:  BEQ $A467

LA437:  JSR DoCreditsPassword   ;($8048)Check for end credits password.
LA43A:  BEQ $A463

LA43C:  JSR DoTysonPassword     ;($804E)Check for Mike Tyson password.
LA43F:  BEQ $A457

LA441:  BNE $A427

LA443:  JSR LoadPRGBank07       ;($AA54)
LA446:  JSR $8033
LA449:  BNE $A42D
LA44B:  JSR $8036
LA44E:  JSR $8039
LA451:  LDX $0136
LA454:  INX
LA455:  BNE $A475
LA457:  JSR $804B
LA45A:  LDA #$02
LA45C:  STA $0173
LA45F:  LDX #$05
LA461:  BNE $A475

LA463:  LDX #$07
LA465:  BNE $A475
LA467:  JSR $8036

LA46A:  LDA #$01
LA46C:  STA $013E
LA46F:  LDX #$04
LA471:  BNE $A475
LA473:  LDX #$00

LA475:  STX $0B
LA477:  LDA $A185,X
LA47A:  STA $01

LA47C:  LDA #SND_OFF            ;Stop any playing music.
LA47E:  STA MusicInit           ;

LA480:  JSR $AEA5
LA483:  JSR LoadPRGBank0C       ;($AA64)
LA486:  LDA #$81
LA488:  STA $04B0
LA48B:  JSR $AF02
LA48E:  JSR $BC1F
LA491:  LDA $04B0
LA494:  BNE $A48B
LA496:  LDX #$A0
LA498:  JSR $AF3A
LA49B:  LDX #$0C
LA49D:  STX OppBaseAnimIndex
LA49F:  JSR $C850
LA4A2:  LDA #$02
LA4A4:  JSR $AF04
LA4A7:  LDX OppBaseAnimIndex
LA4A9:  INX
LA4AA:  INX
LA4AB:  CPX #$14
LA4AD:  BNE $A49D
LA4AF:  INC $14
LA4B1:  LDA #$60
LA4B3:  JSR $AF04
LA4B6:  JSR $BF7E
LA4B9:  LDA $01
LA4BB:  BMI $A4C0
LA4BD:  JMP $A829
LA4C0:  JSR $BD42
LA4C3:  JMP $A2B5

LA4C6:  LDY #$10
LA4C8:  STY $04C6
LA4CB:  RTS

LA4CC:  JSR $B70B
LA4CF:  JSR $AEA5

LA4D2:  LDA #SPRT_BKG_ON        ;Enable sprites and background.
LA4D4:  STA SprtBkgUpdt         ;

LA4D6:  LDA #$FF
LA4D8:  STA GameStatus
LA4DA:  LDA #$03
LA4DC:  STA MusicInit
LA4DE:  JSR $AF02
LA4E1:  LDA #$F1
LA4E3:  JSR $BDA2
LA4E6:  LDY #$03
LA4E8:  LDA $A1BA,Y
LA4EB:  STA $06BF,Y
LA4EE:  DEY
LA4EF:  BNE $A4E8
LA4F1:  JSR $BDB5
LA4F4:  JSR $AF02
LA4F7:  LDA $15
LA4F9:  BEQ $A4F1
LA4FB:  LDA #$F2
LA4FD:  JSR $BDA2
LA500:  JSR $BF7E
LA503:  BEQ $A509
LA505:  LDA #$02
LA507:  STA $04
LA509:  JSR $B6A1

LA50C:  LDA PPU1Load            ;
LA50E:  ORA #PPU_LEFT_EN        ;Enable background and sprites in left column.
LA510:  STA PPU1Load            ;

LA512:  LDA #SPRT_BKG_ON        ;Enable sprites and background.
LA514:  STA SprtBkgUpdt         ;

LA516:  LDA #$FF
LA518:  STA GameStatus
LA51A:  LDA $013F
LA51D:  BNE $A528
LA51F:  LDA #$02
LA521:  STA MusicInit
LA523:  LDA #$80
LA525:  JSR $AF04
LA528:  LDA #$FF
LA52A:  JSR $AF04
LA52D:  JSR $BF7E
LA530:  LDX $013F
LA533:  BNE $A53F
LA535:  LDA #$01
LA537:  STA $013F
LA53A:  LDA #$06
LA53C:  JMP $A2B5
LA53F:  LDA #$13
LA541:  STA $01
LA543:  LDX #$FF
LA545:  TXS
LA546:  JSR $AA1D
LA549:  LDY #$70
LA54B:  LDX #$01
LA54D:  LDA #$00
LA54F:  STA $E0
LA551:  STX $E1
LA553:  STA ($E0),Y
LA555:  INY
LA556:  BNE $A553
LA558:  INX
LA559:  CPX #$08
LA55B:  BNE $A551
LA55D:  LDY #$40
LA55F:  LDX #$B0
LA561:  JSR $AEF8
LA564:  JSR $AAE5
LA567:  JSR $AB4E
LA56A:  JSR $AB58
LA56D:  LDA #$80
LA56F:  STA $04
LA571:  STA $04B0

LA574:  LDA #GAME_ENG_RUN       ;
LA576:  STA GameEngStatus       ;Run the main game engine.
LA578:  STA GameStatus          ;

LA57A:  JSR $AF02
LA57D:  LDA $00
LA57F:  CMP #$01
LA581:  BNE $A57A
LA583:  LDA #$02
LA585:  JSR $AF04

LA588:  LDA #SPRT_BKG_ON        ;Enable sprites and background.
LA58A:  STA SprtBkgUpdt         ;

LA58C:  LDA #$01
LA58E:  STA $22
LA590:  JSR $AF02
LA593:  LDX $00
LA595:  BPL $A590
LA597:  JSR $BF7E
LA59A:  JSR $A750
LA59D:  JSR $AA1D
LA5A0:  LDA #$FF
LA5A2:  STA GameStatus
LA5A4:  LDY #$30
LA5A6:  LDX #$C0
LA5A8:  JSR $AEF8
LA5AB:  STA $22
LA5AD:  JSR $AA6E
LA5B0:  LDA #$DF
LA5B2:  AND PPU0Load
LA5B4:  STA PPU0Load
LA5B6:  STA PPUControl0
LA5B9:  LDA #$20
LA5BB:  JSR $AF04
LA5BE:  LDA #$08
LA5C0:  JMP $A2B5

LA5C3:  LDX #$02
LA5C5:  STX $1A
LA5C7:  LDY #$00
LA5C9:  LDA $17
LA5CB:  BEQ $A5DC
LA5CD:  STY SPRAddress
LA5D0:  STX SPRDMAReg
LA5D3:  STY $17
LA5D5:  LDA $A9
LA5D7:  STA $C000
LA5DA:  DEC $1A
LA5DC:  LDA $60
LA5DE:  BEQ $A5EC
LA5E0:  BMI $A5EC
LA5E2:  JSR $AA9F
LA5E5:  LDA $69
LA5E7:  STA $E000
LA5EA:  DEC $1A
LA5EC:  LDA $1A
LA5EE:  BEQ $A63E

LA5F0:  LDA UpdatePalFlag
LA5F3:  BEQ $A606

LA5F5:  LDA PPU0Load
LA5F7:  AND #$FB
LA5F9:  STA PPUControl0
LA5FC:  JSR $AF0B
LA5FF:  LDA #$00
LA601:  STA UpdatePalFlag
LA604:  DEC $1A

LA606:  LDA $0410
LA609:  BPL $A613
LA60B:  LDX PPU0Load
LA60D:  STX PPUControl0
LA610:  JSR $C24A
LA613:  LDA PPU0Load
LA615:  AND #$FB
LA617:  STA PPUControl0
LA61A:  LDA FrameCounter        ;($1E)
LA61C:  AND #$03
LA61E:  BEQ $A62C
LA620:  CMP #$02
LA622:  BEQ $A63B
LA624:  BCC $A635
LA626:  JSR $C041
LA629:  JMP $A63E
LA62C:  JSR $C079
LA62F:  JSR $C09D
LA632:  JMP $A63E
LA635:  JSR $C0BB
LA638:  JMP $A63E
LA63B:  JSR $C0E0
LA63E:  JSR ChkEnDisSprtBkg     ;($AF73)Enable/disable sprites and background.
LA641:  JSR $A9DF
LA644:  INC FrameCounter        ;($1E)
LA646:  LDA TransTimer
LA648:  BEQ $A64C
LA64A:  DEC TransTimer
LA64C:  JSR PushPRGBank07       ;($AA3C)
LA64F:  JSR $8012
LA652:  LDA $04
LA654:  BMI $A659
LA656:  JMP $A73D

LA659:  JSR PollControllers     ;($AF8D)Get raw controller button presses.
LA65C:  LDA GameEngStatus       ;Is main game engine enabled and running?
LA65E:  BEQ MainGameEngine      ;If so, branch to run main game engine loop.

LA660:  JSR GetJoy1Buttons      ;($AFBD)Get controller 1 current buttons status.
LA663:  JSR $A09A
LA666:  JMP $A6D9

;-------------------------------------[ Main Game Engine Loop ]--------------------------------------

MainGameEngine:
LA669:  LDA #$01
LA66B:  STA GameStatus

LA66D:  JSR $8009
LA670:  JSR $800C
LA673:  JSR $8006
LA676:  JSR $8003
LA679:  JSR $8000

LA67C:  JSR GetJoy1Buttons      ;($AFBD)Get controller 1 current buttons status.
LA67F:  JSR GetJoy2Buttons      ;($B034)Get controller 2 current buttons status.

LA682:  LDX $04
LA684:  INX
LA685:  BEQ $A68D

LA687:  JSR $A75B
LA68A:  JSR $A750

LA68D:  JSR PushPRGBank08       ;($AA40)
LA690:  JSR $8000
LA693:  JSR $A09A
LA696:  JSR PushFightBank       ;($AA48)
LA699:  JSR $B069
LA69C:  JSR $B10A
LA69F:  JSR $C291
LA6A2:  JSR $B196
LA6A5:  JSR $C3D9
LA6A8:  JSR $C4E7
LA6AB:  JSR PushFightBank       ;($AA48)
LA6AE:  JSR $C890
LA6B1:  JSR $AA87
LA6B4:  JSR PushPRGBank07       ;($AA3C)
LA6B7:  JSR $800F
LA6BA:  JSR $8015
LA6BD:  JSR PushFightBank       ;($AA48)
LA6C0:  JSR $B457
LA6C3:  JSR SetOppOutlineClr    ;($C440)Set opponent outline color.
LA6C6:  JSR $B530
LA6C9:  JSR $A774
LA6CC:  JSR $A7C4

LA6CF:  PLA                     ;
LA6D0:  TAY                     ;
LA6D1:  PLA                     ;Restore A, X and Y from stack.
LA6D2:  TAX                     ;
LA6D3:  PLA                     ;

LA6D4:  LDX #$00                ;
LA6D6:  STX GameStatus          ;Indicate main game engine is running.
LA6D8:  RTI                     ;

;----------------------------------------------------------------------------------------------------

LA6D9:  JSR $A774
LA6DC:  JSR $A7A6

ExitNMI:
LA6DF:  PLA
LA6E0:  TAY
LA6E1:  PLA
LA6E2:  TAX
LA6E3:  PLA
LA6E4:  RTI

;----------------------------------------------------------------------------------------------------

LA6E5:  LDY #$00
LA6E7:  LDA $17
LA6E9:  BEQ $A6F5
LA6EB:  STY SPRAddress
LA6EE:  LDX #$02
LA6F0:  STX SPRDMAReg
LA6F3:  NOP
LA6F4:  NOP
LA6F5:  JSR ChkEnDisSprtBkg     ;($AF73)Enable/disable sprites and background.
LA6F8:  INC FrameCounter        ;($1E)
LA6FA:  LDA TransTimer
LA6FC:  BEQ $A700
LA6FE:  DEC TransTimer
LA700:  LDA $0410
LA703:  BPL $A708
LA705:  JSR $C24A

LA708:  LDA UpdatePalFlag
LA70B:  BEQ $A721

LA70D:  LDA PPU0Load
LA70F:  AND #$FB
LA711:  STA PPUControl0

LA714:  JSR $AF0B

LA717:  LDA PPU0Load
LA719:  STA PPUControl0

LA71C:  LDA #$00
LA71E:  STA UpdatePalFlag

LA721:  JSR $A9DF
LA724:  JSR PushPRGBank07       ;($AA3C)
LA727:  JSR $8012

LA72A:  JSR PushPRGBank08       ;($AA40)
LA72D:  JSR $8000

LA730:  JSR PopPRGBank          ;($AA6A)
LA733:  LDA $04
LA735:  BMI $A6D9
LA737:  CMP #$02
LA739:  BEQ $A6D9
LA73B:  BNE $A740
LA73D:  JSR $A09A
LA740:  JSR PollControllers     ;($AF8D)Get raw controller button presses.
LA743:  JSR GetJoy1Buttons      ;($AFBD)Get controller 1 current buttons status.
LA746:  LDA $04
LA748:  BNE $A74D
LA74A:  JSR $A75B
LA74D:  JMP $A6D9

LA750:  LDA #SND_OFF
LA752:  STA $F0
LA754:  STA $F1
LA756:  STA MusicInit
LA758:  STA $F3
LA75A:  RTS

LA75B:  LDA Strt1History        ;($D9)
LA75D:  BMI $A760
LA75F:  RTS
LA760:  AND #$7F
LA762:  STA Strt1History        ;($D9)
LA764:  LDY #$30
LA766:  LDX #$A0
LA768:  JSR $AEF8
LA76B:  LDA #$DF
LA76D:  AND PPU0Load
LA76F:  STA PPU0Load
LA771:  JMP $A2A4
LA774:  LDA $04C8
LA777:  BEQ $A7A5
LA779:  LDA FrameCounter        ;($1E)
LA77B:  AND #$07
LA77D:  BNE $A7A5
LA77F:  LDA $04C8
LA782:  SEC
LA783:  SBC #$10
LA785:  STA $04C8
LA788:  LDX #$1F
LA78A:  LDA ThisBkgPalette,X
LA78D:  BMI $A79D
LA78F:  CMP $04C8
LA792:  BCC $A79D
LA794:  SBC #$10
LA796:  BCS $A79A
LA798:  LDA #$8F
LA79A:  STA ThisBkgPalette,X
LA79D:  DEX
LA79E:  BPL $A78A
LA7A0:  LDA #PAL_UPDATE
LA7A2:  STA UpdatePalFlag
LA7A5:  RTS
LA7A6:  LDA $03D8
LA7A9:  BPL $A7C3
LA7AB:  LDA Sel1History         ;($DB)
LA7AD:  BPL $A7C3
LA7AF:  AND #$7F
LA7B1:  STA Sel1History         ;($DB)
LA7B3:  LDA #$01
LA7B5:  STA $03D8
LA7B8:  LDA #$11
LA7BA:  STA $020B
LA7BD:  STA $0233
LA7C0:  JSR $A800
LA7C3:  RTS
LA7C4:  RTS
LA7C5:  LDA Sel1History         ;($DB)
LA7C7:  BPL $A7FF
LA7C9:  AND #$7F
LA7CB:  STA Sel1History         ;($DB)
LA7CD:  LDA OppCurState
LA7CF:  STA $03FA
LA7D2:  LDA MacStatus           ;($50)
LA7D4:  STA $03FB
LA7D7:  LDA RoundTmrStart       ;($0300)
LA7DA:  STA $03FC
LA7DD:  LDA $03FD
LA7E0:  STA OppCurState
LA7E2:  LDA $03FE
LA7E5:  STA MacStatus           ;($50)
LA7E7:  LDA $03FF
LA7EA:  STA RoundTmrStart       ;($0300)
LA7ED:  LDA $03FA
LA7F0:  STA $03FD
LA7F3:  LDA $03FB
LA7F6:  STA $03FE
LA7F9:  LDA $03FC
LA7FC:  STA $03FF
LA7FF:  RTS
LA800:  LDX RoundNumber
LA802:  DEX
LA803:  TXA
LA804:  ASL
LA805:  ASL
LA806:  ASL
LA807:  STA $E8
LA809:  LDA $18
LA80B:  JSR $AEF1
LA80E:  AND #$07
LA810:  CLC
LA811:  ADC $E8
LA813:  TAY
LA814:  LDA SelRefillPtrLB      ;($05EE)
LA817:  STA $E8
LA819:  LDA SelRefillPtrUB      ;($05EF)
LA81C:  STA $E9
LA81E:  JSR PushFightBank       ;($AA48)
LA821:  LDA ($E8),Y
LA823:  STA SelectRefill        ;($03D9)
LA826:  JMP PopPRGBank          ;($AA6A)
LA829:  LDX #$FF
LA82B:  TXS
LA82C:  JSR $AA1D
LA82F:  LDY #$70
LA831:  LDA $0B
LA833:  BEQ $A837
LA835:  LDY #$80
LA837:  LDX #$01
LA839:  LDA #$00
LA83B:  STA $E0
LA83D:  STX $E1
LA83F:  STA ($E0),Y
LA841:  INY
LA842:  BNE $A83F
LA844:  INX
LA845:  CPX #$08
LA847:  BNE $A83D
LA849:  LDY #$40
LA84B:  LDX #$B0
LA84D:  JSR $AEF8
LA850:  JSR $AAE5
LA853:  JSR $AB4E
LA856:  JSR $BAE3
LA859:  LDX RoundNumber
LA85B:  DEX
LA85C:  BEQ $A864
LA85E:  JSR $BBC3
LA861:  JMP $A867
LA864:  JSR $BBAA
LA867:  LDA #$FF
LA869:  STA GameStatus

LA86B:  LDA PPU1Load            ;
LA86D:  ORA #PPU_LEFT_EN        ;Enable background and sprites in left column.
LA86F:  STA PPU1Load            ;

LA871:  LDA #SPRT_BKG_ON        ;Enable sprites and background.
LA873:  STA SprtBkgUpdt         ;

LA875:  JSR $AF02
LA878:  JSR $AEA5
LA87B:  LDA $03D8
LA87E:  BNE $A885
LA880:  LDA #$80
LA882:  STA $03D8
LA885:  LDX RoundNumber
LA887:  DEX
LA888:  BEQ $A8A6
LA88A:  LDA $04BE
LA88D:  JSR $AA26
LA890:  LDA #$20
LA892:  STA $04C6
LA895:  JSR $BE1A
LA898:  JSR $AF02
LA89B:  DEC $04C6
LA89E:  BNE $A895
LA8A0:  LDA $04BF
LA8A3:  JSR $AA26
LA8A6:  JSR $BFF2
LA8A9:  JSR $BE1A
LA8AC:  JSR $AF02
LA8AF:  LDA Strt1History        ;($D9)
LA8B1:  BPL $A8A9
LA8B3:  AND #$7F
LA8B5:  STA Strt1History        ;($D9)
LA8B7:  LDA $03D8
LA8BA:  AND #$01
LA8BC:  STA $03D8
LA8BF:  LDA #$01
LA8C1:  STA $F3
LA8C3:  LDY #$03
LA8C5:  LDA $A1BD,Y
LA8C8:  STA $06BF,Y
LA8CB:  DEY
LA8CC:  BNE $A8C5
LA8CE:  JSR $BDB5
LA8D1:  JSR $AF02
LA8D4:  LDA $15
LA8D6:  BEQ $A8CE
LA8D8:  LDA #$40
LA8DA:  JSR $AF04
LA8DD:  JSR $BF7E
LA8E0:  JSR $AB58
LA8E3:  LDA #$FF
LA8E5:  STA $04
LA8E7:  LDA #$00
LA8E9:  STA GameEngStatus
LA8EB:  STA GameStatus
LA8ED:  JSR $AF02
LA8F0:  LDA $00
LA8F2:  CMP #$01
LA8F4:  BNE $A8ED
LA8F6:  LDA #$02
LA8F8:  JSR $AF04

LA8FB:  LDA #SPRT_BKG_ON        ;Enable sprites and background.
LA8FD:  STA SprtBkgUpdt         ;

LA8FF:  LDA #$01
LA901:  LDY RoundNumber
LA903:  CPY #$04
LA905:  BNE $A909
LA907:  STA $F3
LA909:  STA $22
LA90B:  JSR $AF02
LA90E:  LDX $00
LA910:  BPL $A90B
LA912:  JSR $BF7E
LA915:  JSR $AA1D
LA918:  LDA #$FF
LA91A:  STA GameStatus
LA91C:  LDY #$40
LA91E:  LDX #$B0
LA920:  JSR $AEF8
LA923:  STA $30
LA925:  STA $38
LA927:  STA $22
LA929:  JSR $AA6E
LA92C:  LDA #$DF
LA92E:  AND PPU0Load
LA930:  STA PPU0Load
LA932:  STA PPUControl0
LA935:  LDA #$20
LA937:  JSR $AF04
LA93A:  LDA $09
LA93C:  STA $08
LA93E:  LDX $00
LA940:  INX
LA941:  BEQ $A9AA
LA943:  INX
LA944:  BEQ $A977
LA946:  INX
LA947:  BEQ $A952
LA949:  INX
LA94A:  BEQ $A977
LA94C:  INX
LA94D:  BEQ $A952
LA94F:  INX
LA950:  BEQ $A97C
LA952:  INC $03C0
LA955:  LDY #$03
LA957:  JSR $AAAB
LA95A:  LDX #$02
LA95C:  JSR $AE28
LA95F:  LDA $09
LA961:  BMI $A9B5
LA963:  JSR Div16               ;($BF99)Shift upper nibble to lower nibble.
LA966:  TAY
LA967:  LDA $0173
LA96A:  CMP $A9CD,Y
LA96D:  BCS $A9B5
LA96F:  LDA #$00
LA971:  JSR $ACB1
LA974:  JMP $A850
LA977:  LDY #$05
LA979:  JSR $AAAB
LA97C:  LDY #$01
LA97E:  JSR $AAAB
LA981:  LDX #$01
LA983:  JSR $AE28
LA986:  LDA $09
LA988:  BEQ $A996
LA98A:  BMI $A9C5
LA98C:  AND #$0F
LA98E:  BEQ $A9C1
LA990:  LDA $08
LA992:  AND #$0F
LA994:  BNE $A96F
LA996:  LDA #$00
LA998:  STA $03C0
LA99B:  LDA #$02
LA99D:  JSR $ACB1
LA9A0:  LDA $09
LA9A2:  BEQ $A9B8
LA9A4:  JSR $AD0F
LA9A7:  JMP $A850
LA9AA:  INC RoundNumber
LA9AC:  LDA RoundNumber
LA9AE:  CMP #$04
LA9B0:  BEQ $A9CB
LA9B2:  JMP $A853
LA9B5:  JMP $AC5B
LA9B8:  JSR $AC6F
LA9BB:  JSR $AC38
LA9BE:  JMP $A850
LA9C1:  LDA #$01
LA9C3:  BNE $A971
LA9C5:  JSR $B757
LA9C8:  JMP $A2AC
LA9CB:  JMP $A8E0

LA9CE:  .byte $03, $03, $03

LA9D1:  JSR $A9DF
LA9D4:  INC FrameCounter        ;($1E)
LA9D6:  LDA TransTimer
LA9D8:  BEQ $A9DC
LA9DA:  DEC TransTimer
LA9DC:  JMP $A09A
LA9DF:  LDA PPUStatus
LA9E2:  LDY #$00
LA9E4:  LDA $12
LA9E6:  STA $F000
LA9E9:  LDA $13
LA9EB:  STA PPUScroll
LA9EE:  LDA $20
LA9F0:  STA PPUScroll
LA9F3:  LDA PPU0Load
LA9F5:  AND #$FC
LA9F7:  ORA $14
LA9F9:  STA PPU0Load
LA9FB:  LDA $21
LA9FD:  ASL
LA9FE:  ORA PPU0Load
LAA00:  STA PPU0Load
LAA02:  STA PPUControl0
LAA05:  RTS
LAA06:  LDA #$01
LAA08:  BNE $AA0C
LAA0A:  LDA #$00
LAA0C:  STA $12
LAA0E:  LDA #$00
LAA10:  STA $13
LAA12:  STA $14
LAA14:  STA $15
LAA16:  STA $16
LAA18:  STA $20
LAA1A:  STA $21
LAA1C:  RTS
LAA1D:  LDA #$01
LAA1F:  STA $04
LAA21:  STA GameEngStatus
LAA23:  STA GameStatus
LAA25:  RTS
LAA26:  STA $04B0
LAA29:  JSR $BE09
LAA2C:  JSR $BE1A
LAA2F:  JSR $AF02
LAA32:  LDA $04B0
LAA35:  BNE $AA29
LAA37:  RTS

;----------------------------------------------------------------------------------------------------

PushPRGBank06:
LAA38:  LDA #$06
LAA3A:  BNE PushPRGBank

PushPRGBank07:
LAA3C:  LDA #$07
LAA3E:  BNE PushPRGBank

PushPRGBank08:
LAA40:  LDA #$08
LAA42:  BNE PushPRGBank

PushPRGBank0B:
LAA44:  LDA #$0B
LAA46:  BNE PushPRGBank

PushFightBank:
LAA48:  LDA FightBank           ;($02)

PushPRGBank:
LAA4A:  STA BankSelect
LAA4D:  STA CurrPRGBank         ;($0D)
LAA4F:  RTS

LoadPRGBank06:
LAA50:  LDA #$06
LAA52:  BNE LoadPRGBank

LoadPRGBank07:
LAA54:  LDA #$07
LAA56:  BNE LoadPRGBank

LoadPRGBank08:
LAA58:  LDA #$08
LAA5A:  BNE LoadPRGBank

LoadPRGBank09:
LAA5C:  LDA #$09
LAA5E:  BNE LoadPRGBank

LoadPRGBank0A:
LAA60:  LDA #$0A
LAA62:  BNE LoadPRGBank

LoadPRGBank0C:
LAA64:  LDA #$0C

LoadPRGBank:
LAA66:  STA SavedPRGBank        ;($0E)
LAA68:  BNE PushPRGBank

PopPRGBank:
LAA6A:  LDA SavedPRGBank        ;($0E)
LAA6C:  BNE PushPRGBank

;----------------------------------------------------------------------------------------------------

LAA6E:  LDX #$00
LAA70:  TAY
LAA71:  BEQ $AA75

LAA73:  LDY #$03

LAA75:  LDA $AA81,Y
LAA78:  STA $80,X
LAA7A:  INY
LAA7B:  INX
LAA7C:  CPX #$03
LAA7E:  BNE $AA75
LAA80:  RTS

LAA81:  .byte $08, $01, $FF, $10, $02, $FE

LAA87:  JSR PushPRGBank0B       ;($AA44)
LAA8A:  JSR $8003
LAA8D:  JSR $8006
LAA90:  JSR $8009
LAA93:  JMP PushFightBank       ;($AA48)
LAA96:  JSR PushPRGBank0B       ;($AA44)
LAA99:  JSR $8009
LAA9C:  JMP PushFightBank       ;($AA48)
LAA9F:  JSR PushPRGBank0B       ;($AA44)
LAAA2:  JSR $8000
LAAA5:  JMP PushFightBank       ;($AA48)
LAAA8:  ROL $04C3
LAAAB:  CLC
LAAAC:  LDA #$01
LAAAE:  JSR $AAB4
LAAB1:  DEY
LAAB2:  LDA #$00
LAAB4:  ADC $0170,Y
LAAB7:  CMP #$0A
LAAB9:  BCC $AABD
LAABB:  LDA #$00
LAABD:  STA $0170,Y
LAAC0:  RTS
LAAC1:  LDY #$00
LAAC3:  LDX #$04
LAAC5:  LDA PointsTotal,Y       ;($03E8)
LAAC8:  CMP $05C8,Y
LAACB:  BNE $AAD1
LAACD:  INY
LAACE:  DEX
LAACF:  BNE $AAC5
LAAD1:  LDY #$01
LAAD3:  BCS $AAD6
LAAD5:  INY
LAAD6:  LDX #$01
LAAD8:  STX $C0
LAADA:  TYA
LAADB:  CLC
LAADC:  ADC #$A9
LAADE:  STA $C1
LAAE0:  LDX #$EA
LAAE2:  STX CurrentCount
LAAE4:  RTS
LAAE5:  JSR $AA1D
LAAE8:  STA RoundNumber
LAAEA:  JSR $AE89
LAAED:  LDA $01
LAAEF:  ASL
LAAF0:  TAY
LAAF1:  LDA $A0D1,Y
LAAF4:  STA FightBank           ;($02)
LAAF6:  JSR PushFightBank       ;($AA48)
LAAF9:  LDA $A0D2,Y
LAAFC:  STA FightOffset         ;($03)
LAAFE:  LDY #$20
LAB00:  LDA #$00
LAB02:  STA $03C0,Y
LAB05:  DEY
LAB06:  BNE $AB02
LAB08:  STA $03B1
LAB0B:  CLC
LAB0C:  LDA #$0E
LAB0E:  ADC FightOffset         ;($03)
LAB10:  TAX
LAB11:  JSR $BF9E
LAB14:  LDX #$60
LAB16:  LDY #$00
LAB18:  LDA ($E0),Y
LAB1A:  STA $05A0,Y
LAB1D:  INY
LAB1E:  DEX
LAB1F:  BNE $AB18
LAB21:  LDA $05E8,X
LAB24:  STA $31,X
LAB26:  INX
LAB27:  CPX #$04
LAB29:  BNE $AB21
LAB2B:  LDA StarCountReset
LAB2E:  STA StarCountDown
LAB31:  LDA $05B2
LAB34:  STA $0348
LAB37:  LDA #$03
LAB39:  STA $0310
LAB3C:  LDA #$01
LAB3E:  STA VulnerableTimer
LAB41:  STA $04FE
LAB44:  LDX #$80
LAB46:  STX $03E7
LAB49:  INX
LAB4A:  STX HealthPoints        ;($0390)
LAB4D:  RTS
LAB4E:  LDA #$00
LAB50:  STA $8F
LAB52:  STA OppKDRound          ;($03CA)
LAB55:  JMP $AA6E
LAB58:  JSR $AA1D
LAB5B:  LDY #$40
LAB5D:  LDX #$B0
LAB5F:  JSR $AEF8
LAB62:  JSR $BF3C
LAB65:  LDA $05CC
LAB68:  JSR $AA6E
LAB6B:  LDA $05CC
LAB6E:  BEQ $AB72
LAB70:  LDA #$20
LAB72:  ORA PPU0Load
LAB74:  STA PPU0Load
LAB76:  LDA #$01
LAB78:  JSR $C118
LAB7B:  LDA #$02
LAB7D:  JSR $C118
LAB80:  LDA RoundNumber
LAB82:  CMP #$04
LAB84:  BNE $AB8B
LAB86:  LDA #$03
LAB88:  JSR $C118
LAB8B:  JSR $AF43
LAB8E:  LDX #$05
LAB90:  JSR $BF55
LAB93:  JSR $AEA5
LAB96:  LDA $05CE
LAB99:  STA OppBaseXSprite
LAB9B:  LDA $05CF
LAB9E:  STA OppBaseYSprite
LABA0:  LDY #$01
LABA2:  LDA #$B0
LABA4:  STY $14
LABA6:  STY $16
LABA8:  STA $15
LABAA:  SEC
LABAB:  SBC $05CC
LABAE:  STA $13
LABB0:  DEC $0310
LABB3:  LDA #$C0
LABB5:  STA $0311
LABB8:  LDX #$00
LABBA:  STX RoundTmrStart       ;($0300)
LABBD:  STX $05
LABBF:  STX VulnerableTimer
LABC2:  STX $04FE
LABC5:  STX $04FF
LABC8:  STX OppAnimSeg
LABCA:  STX $36
LABCC:  STX $35
LABCE:  DEX
LABCF:  STX $39
LABD1:  LDX #$81
LABD3:  STX $40
LABD5:  DEX
LABD6:  STX $37
LABD8:  LDX #$01
LABDA:  STX PointsStatus        ;($03E0)
LABDD:  JSR LoadPRGBank07       ;($AA54)
LABE0:  JSR $8006
LABE3:  LDA #$00
LABE5:  STA MacCurrentHP
LABE8:  STA MacDisplayedHP
LABEB:  STA $0399
LABEE:  STA $039A
LABF1:  JSR $8006
LABF4:  JSR $C041
LABF7:  LDA MacCurrentHP
LABFA:  CMP MacDisplayedHP
LABFD:  BNE $ABF1
LABFF:  LDA $0399
LAC02:  CMP $039A
LAC05:  BNE $ABF1
LAC07:  JSR $AE5F
LAC0A:  LDX #$20
LAC0C:  LDY #$93
LAC0E:  JSR $AF2E
LAC11:  LDA RoundNumber
LAC13:  CMP #$04
LAC15:  BCC $AC1D
LAC17:  JSR $AAC1
LAC1A:  LDA #$03
LAC1C:  CLC
LAC1D:  ADC #$BF
LAC1F:  STA PPUIOReg
LAC22:  JSR PushFightBank       ;($AA48)
LAC25:  JSR $AF5B
LAC28:  LDA #PAL_UPDATE
LAC2A:  STA UpdatePalFlag
LAC2D:  LDA #$30
LAC2F:  STA $00
LAC31:  LDA #$01
LAC33:  STA $30
LAC35:  STA $38
LAC37:  RTS
LAC38:  JSR $B88A

LAC3B:  LDA #SPRT_BKG_ON        ;Enable sprites and background.
LAC3D:  STA SprtBkgUpdt         ;

LAC3F:  LDA #$FF
LAC41:  STA GameStatus
LAC43:  LDA #$0E
LAC45:  STA MusicInit
LAC47:  LDA #$20
LAC49:  JSR $AF04
LAC4C:  LDY #$00
LAC4E:  LDA #$24
LAC50:  JSR $ADDA
LAC53:  LDA #$20
LAC55:  JSR $AF04
LAC58:  JMP $BF7E
LAC5B:  JSR $B8C1

LAC5E:  LDA #SPRT_BKG_ON        ;Enable sprites and background.
LAC60:  STA SprtBkgUpdt         ;

LAC62:  LDA #$FF
LAC64:  STA GameStatus
LAC66:  JSR $AE91
LAC69:  JSR $BF7E
LAC6C:  JMP $A2AC
LAC6F:  JSR LoadPRGBank07       ;($AA54)
LAC72:  JSR $803C
LAC75:  JSR $802A
LAC78:  JSR $802D
LAC7B:  JSR $B8FF

LAC7E:  LDA #SPRT_BKG_ON        ;Enable sprites and background.
LAC80:  STA SprtBkgUpdt         ;

LAC82:  LDA #$FF
LAC84:  STA GameStatus
LAC86:  LDA #$04
LAC88:  STA MusicInit
LAC8A:  LDY #$03
LAC8C:  LDA $A1C0,Y
LAC8F:  STA $06BF,Y
LAC92:  DEY
LAC93:  BNE $AC8C
LAC95:  JSR $BDB5
LAC98:  JSR $AF02
LAC9B:  LDA $15
LAC9D:  BEQ $AC95
LAC9F:  LDX #$05
LACA1:  JSR $ADD1
LACA4:  LDA #$04
LACA6:  STA MusicInit
LACA8:  JSR $ADC5
LACAB:  JSR $BF7E
LACAE:  JMP $AE84
LACB1:  STA $03D3
LACB4:  JSR $B957

LACB7:  LDA #SPRT_BKG_ON        ;Enable sprites and background.
LACB9:  STA SprtBkgUpdt         ;

LACBB:  LDA #$FF
LACBD:  STA GameStatus
LACBF:  LDX #$01
LACC1:  LDA $00
LACC3:  AND #$01
LACC5:  BNE $ACCF
LACC7:  LDA $08
LACC9:  AND #$0F
LACCB:  BNE $ACCF
LACCD:  LDX #$05
LACCF:  JSR $ADD1
LACD2:  JSR $BFD1
LACD5:  JSR $ADC5
LACD8:  LDA $03D3
LACDB:  CMP #$01
LACDD:  BNE $AD09
LACDF:  LDY #$03
LACE1:  LDA $A1BA,Y
LACE4:  STA $06BF,Y
LACE7:  DEY
LACE8:  BNE $ACE1
LACEA:  JSR $BDB1
LACED:  JSR $AF02
LACF0:  LDA $15
LACF2:  BEQ $ACEA
LACF4:  LDA #$08
LACF6:  STA MusicInit
LACF8:  LDA #$20
LACFA:  JSR $AF04
LACFD:  LDY #$10
LACFF:  LDA #$24
LAD01:  JSR $ADDA
LAD04:  LDA #$38
LAD06:  JSR $AF04
LAD09:  JSR $BF7E
LAD0C:  JMP $AE84
LAD0F:  JSR $BA74
LAD12:  JSR $AEA5

LAD15:  LDA #SPRT_BKG_ON        ;Enable sprites and background.
LAD17:  STA SprtBkgUpdt         ;

LAD19:  LDA #$FF
LAD1B:  STA GameStatus
LAD1D:  LDA #$1A
LAD1F:  STA MusicInit
LAD21:  JSR $C013
LAD24:  JSR $BE1A
LAD27:  LDA $06C2
LAD2A:  CMP #$3F
LAD2C:  BNE $AD21
LAD2E:  LDA #$00
LAD30:  TAX
LAD31:  STA $06C0,X
LAD34:  INX
LAD35:  INX
LAD36:  INX
LAD37:  CPX #$1E
LAD39:  BNE $AD31
LAD3B:  STA $17
LAD3D:  LDY #$00
LAD3F:  LDX #$0F
LAD41:  LDA #$FD
LAD43:  JSR $BF66
LAD46:  LDX #$01
LAD48:  LDA #$FE
LAD4A:  JSR $BF66
LAD4D:  LDA #$00
LAD4F:  STA $0413,Y
LAD52:  LDA #$20
LAD54:  STA $0411
LAD57:  LDA #$70
LAD59:  STA $0412
LAD5C:  LDA #$81
LAD5E:  STA $0410
LAD61:  JSR $C013
LAD64:  LDX #$F3
LAD66:  JSR $ADB6
LAD69:  JSR LoadPRGBank07       ;($AA54)
LAD6C:  JSR $803C
LAD6F:  JSR $802A
LAD72:  JSR $802D
LAD75:  LDX #$50
LAD77:  STX $04B3
LAD7A:  LDX #$01
LAD7C:  STX $04B4
LAD7F:  LDX #$00
LAD81:  STX $04B2
LAD84:  INX
LAD85:  JSR $ADB6
LAD88:  LDX #$F4
LAD8A:  JSR $ADB6
LAD8D:  JSR $C013
LAD90:  LDA Strt1History        ;($D9)
LAD92:  BPL $AD8D
LAD94:  AND #$7F
LAD96:  STA Strt1History        ;($D9)
LAD98:  LDA #$40
LAD9A:  STA $04C8
LAD9D:  JSR $C013
LADA0:  LDA $04C8
LADA3:  BNE $AD9D
LADA5:  LDA #$08
LADA7:  JSR $AF04

LADAA:  LDA #SPRT_BKG_OFF       ;Disable sprites and background.
LADAC:  STA SprtBkgUpdt         ;

LADAE:  LDA #$08
LADB0:  JSR $AF04
LADB3:  JMP $AE84
LADB6:  STX $04B0
LADB9:  JSR $C013
LADBC:  JSR $BE09
LADBF:  LDA $04B0
LADC2:  BNE $ADB9
LADC4:  RTS
LADC5:  JSR $AF02
LADC8:  LDA Strt1History        ;($D9)
LADCA:  BPL $ADC5
LADCC:  AND #$7F
LADCE:  STA Strt1History        ;($D9)
LADD0:  RTS
LADD1:  LDA #$40
LADD3:  JSR $AF04
LADD6:  DEX
LADD7:  BNE $ADD1
LADD9:  RTS
LADDA:  STA $04A3
LADDD:  STY $04A2
LADE0:  LDY $04A2
LADE3:  LDA $AE08,Y
LADE6:  STA $048A
LADE9:  INY
LADEA:  TYA
LADEB:  AND #$0F
LADED:  CMP #$0C
LADEF:  BNE $ADF5
LADF1:  TYA
LADF2:  AND #$F0
LADF4:  TAY
LADF5:  STY $04A2
LADF8:  LDA #PAL_UPDATE
LADFA:  STA UpdatePalFlag
LADFD:  LDA #$06
LADFF:  JSR $AF04
LAE02:  DEC $04A3
LAE05:  BNE $ADE0
LAE07:  RTS

LAE08:  .byte $38, $29, $3A, $2B, $3C, $21, $32, $23, $34, $25, $36, $27, $00, $00, $00, $00
LAE18:  .byte $38, $29, $3A, $2B, $3C, $21, $32, $23, $34, $25, $36, $27, $00, $00, $00, $00

LAE28:  LDA $01
LAE2A:  ASL
LAE2B:  ASL
LAE2C:  TAY
LAE2D:  DEX
LAE2E:  BNE $AE3D
LAE30:  LDA $A10D,Y
LAE33:  STA $01
LAE35:  JSR $AE89
LAE38:  LDX #$00
LAE3A:  STX $0A
LAE3C:  RTS
LAE3D:  LDA $0A
LAE3F:  BEQ $AE4B
LAE41:  LDA $A10F,Y
LAE44:  BMI $AE3C
LAE46:  LDA $A10E,Y
LAE49:  BPL $AE33
LAE4B:  LDA $A10F,Y
LAE4E:  BEQ $AE46
LAE50:  LDX #$01
LAE52:  BNE $AE3A
LAE54:  ADC MacNextHP
LAE57:  BEQ $AE5B
LAE59:  BPL $AE70
LAE5B:  LDA #$01
LAE5D:  BNE $AE70
LAE5F:  CLC
LAE60:  LDA SelectRefill        ;($03D9)
LAE63:  BEQ $AE7F
LAE65:  BMI $AE54
LAE67:  ADC MacNextHP
LAE6A:  CMP #$5F
LAE6C:  BCC $AE70
LAE6E:  LDA #$5F
LAE70:  STA MacMaxHP
LAE73:  LDA #$00
LAE75:  STA SelectRefill        ;($03D9)
LAE78:  LDA $0398
LAE7B:  STA $039E
LAE7E:  RTS
LAE7F:  ADC MacNextHP
LAE82:  BCC $AE70
LAE84:  LDA #$80
LAE86:  STA MusicInit
LAE88:  RTS
LAE89:  LDY $01
LAE8B:  LDA $A18D,Y
LAE8E:  STA $09
LAE90:  RTS
LAE91:  LDX #$06
LAE93:  JSR $AF02
LAE96:  LDA $F0,X
LAE98:  BNE $AE93
LAE9A:  RTS
LAE9B:  LDA PPU0Load
LAE9D:  AND #$FB
LAE9F:  STA PPU0Load
LAEA1:  STA PPUControl0
LAEA4:  RTS
LAEA5:  LDA PPU0Load
LAEA7:  ORA #$04
LAEA9:  BNE $AE9F

LAEAB:  STA $EF
LAEAD:  LDA #$0F
LAEAF:  STA $EE
LAEB1:  LDA $EF
LAEB3:  CMP $EE
LAEB5:  BEQ $AEC7
LAEB7:  LDA $18
LAEB9:  JSR $AEF1
LAEBC:  AND $EE
LAEBE:  STA $EE
LAEC0:  LDA $EF
LAEC2:  CMP $EE
LAEC4:  BNE $AEC7
LAEC6:  CLC
LAEC7:  RTS

LAEC8:  STA $EF
LAECA:  LDA #$7F
LAECC:  BNE $AEAF
LAECE:  STA $EF
LAED0:  LDA #$FF
LAED2:  BNE $AEAF

;----------------------------------------------------------------------------------------------------

;This function is used to call a function indirectly from a function pointer table.

IndFuncJump:
LAED4:  STY DatIndexTemp        ;Save index to next data byte.

LAED7:  ASL                     ;*2. Function pointers are 2 bytes.
LAED8:  TAY                     ;Transfer index to desired function pointer to Y.

LAED9:  PLA                     ;
LAEDA:  STA IndJumpPtrLB        ;Pull the return value off the stack as it is the base -->
LAEDC:  PLA                     ;address for the function pointer table.
LAEDD:  STA IndJumpPtrUB        ;

LAEDF:  INY                     ;
LAEE0:  LDA (IndJumpPtr),Y      ;
LAEE2:  PHA                     ;
LAEE3:  INY                     ;Get jump address from table and load it into IndJumpPtr
LAEE4:  LDA (IndJumpPtr),Y      ;
LAEE6:  STA IndJumpPtrUB        ;
LAEE8:  PLA                     ;
LAEE9:  STA IndJumpPtrLB        ;

LAEEB:  LDY DatIndexTemp        ;Restore the data index.
LAEEE:  JMP (_IndJumpPtr)       ;Indirect jump do desired function.

;----------------------------------------------------------------------------------------------------

LAEF1:  ROR $18
LAEF3:  ROR $18
LAEF5:  ROR $18
LAEF7:  RTS

LAEF8:  LDA #$00
LAEFA:  STA $0000,Y
LAEFD:  INY
LAEFE:  DEX
LAEFF:  BNE $AEFA
LAF01:  RTS
LAF02:  LDA #$01
LAF04:  STA TransTimer
LAF06:  LDA TransTimer
LAF08:  BNE $AF06
LAF0A:  RTS

LAF0B:  LDX #$3F
LAF0D:  LDY #$00
LAF0F:  JSR $AF2E
LAF12:  LDA ThisBkgPalette,Y
LAF15:  STA PPUIOReg
LAF18:  INY
LAF19:  CPY #$20
LAF1B:  BNE $AF12
LAF1D:  LDA #$3F
LAF1F:  STA PPUAddress
LAF22:  LDA #$00
LAF24:  STA PPUAddress
LAF27:  STA PPUAddress
LAF2A:  STA PPUAddress
LAF2D:  RTS

LAF2E:  LDA PPUStatus
LAF31:  STX PPUAddress
LAF34:  STY PPUAddress
LAF37:  RTS

LAF38:  LDX #$00
LAF3A:  LDA #$F8
LAF3C:  STA $0200,X
LAF3F:  INX
LAF40:  BNE $AF3C
LAF42:  RTS
LAF43:  LDY #$0B
LAF45:  LDA $AF4F,Y
LAF48:  STA $0200,Y
LAF4B:  DEY
LAF4C:  BPL $AF45
LAF4E:  RTS

LAF4F:  .byte $5D, $00, $20, $FC, $00, $FD, $20, $00, $00, $FE, $20, $00

LAF5B:  CLC
LAF5C:  LDA #$06
LAF5E:  ADC FightOffset         ;($03)
LAF60:  TAX
LAF61:  JSR $BF9E
LAF64:  JSR $BED9
LAF67:  LDA $048D
LAF6A:  STA $04A1
LAF6D:  LDA #$20
LAF6F:  STA $048D
LAF72:  RTS

;----------------------------------------------------------------------------------------------------

ChkEnDisSprtBkg:
LAF73:  LDA SprtBkgUpdt         ;Does the sprites and background state need to be updated?
LAF75:  BPL SprtBkgUpdEnd       ;If not, branch to exit.

LAF77:  AND #$01                ;Get enable/disable bit.
LAF79:  STA SprtBkgUpdt         ;Does sprites/background need to be disabled?
LAF7B:  BEQ SprtBkgOff          ;If so, branch.

SprtBkgOn:
LAF7D:  LDA PPU1Load            ;Enable sprites and background.
LAF7F:  ORA #$18                ;
LAF81:  BNE UpdatePPUCntrl1     ;Branch always.

SprtBkgOff:
LAF83:  LDA PPU1Load            ;Disable sprites and background.
LAF85:  AND #$E7                ;

UpdatePPUCntrl1:
LAF87:  STA PPU1Load            ;Update sprites/background state.
LAF89:  STA PPUControl1         ;

SprtBkgUpdEnd:
LAF8C:  RTS                     ;End updating the sprites and background visibility.

;--------------------------------------[ Controller Functions ]--------------------------------------

PollControllers:
LAF8D:  LDY #$00                ;Reset controller poll counter.

PollLoop:
LAF8F:  LDX #$01                ;
LAF91:  STX CPUJoyPad1          ;Tell hardware to poll both controllers.
LAF94:  DEX                     ;
LAF95:  STX CPUJoyPad1          ;

LAF98:  JSR Read1Controller     ;($AFA4)Read first controller.
LAF9B:  INX                     ;Prepare to read second controller buttons.
LAF9C:  JSR Read1Controller     ;($AFA4)Read second controller.

LAF9F:  CPY #$08                ;Have 8 controller reads been done(4 for each controller)?
LAFA1:  BNE PollLoop            ;If not, branch to read another controller.
LAFA3:  RTS                     ;

Read1Controller:
LAFA4:  LDA #$08                ;Prepare to read 8 bits from the controller.
LAFA6:  STA GenByteE1           ;

ControllerReadLoop:
LAFA8:  PHA                     ;Save current bits read from controller onto stack.

LAFA9:  LDA CPUJoyPad1,X        ;
LAFAC:  STA GenByteE0           ;Read input bit from controller and from expansion -->
LAFAE:  LSR                     ;controller(Famicom only) and save bit into carry.
LAFAF:  ORA GenByteE0           ;
LAFB1:  LSR                     ;

LAFB2:  PLA                     ;Pull previous bits read from stack.
LAFB3:  ROL                     ;Rotate in the new bit read.

LAFB4:  DEC GenByteE1           ;Have 8 bits been read from controller?
LAFB6:  BNE ControllerReadLoop  ;If not, branch to read another bit.

LAFB8:  STA JoyRawReads,Y       ;Save the controller button presses.

LAFBB:  INY                     ;This controller poll is complete. return.
LAFBC:  RTS                     ;

GetJoy1Buttons:
LAFBD:  LDY #$06                ;Prepare to read the 4 polls from controller 1.
LAFBF:  LDX #$00                ;
LAFC1:  JSR VerifyJoyRead       ;($B021)Verify joy pad reads by ignoring any DMC conflicts.

LAFC4:  LDA Joy1Buttons
LAFC6:  AND #LO_NIBBLE
LAFC8:  JSR Buttons1Status      ;($B001)Get button presses and update button history.

LAFCB:  LDX #$02
LAFCD:  LDA Joy1Buttons
LAFCF:  AND #$80
LAFD1:  JSR Buttons1Status      ;($B001)Get button presses and update button history.

LAFD4:  LDX #$04
LAFD6:  LDA Joy1Buttons
LAFD8:  AND #$40
LAFDA:  JSR Buttons1Status      ;($B001)Get button presses and update button history.

LAFDD:  LDX #$06
LAFDF:  LDA Joy1Buttons
LAFE1:  AND #$10
LAFE3:  JSR Buttons1Status      ;($B001)Get button presses and update button history.

LAFE6:  LDX #$08
LAFE8:  LDA Joy1Buttons
LAFEA:  AND #$20
LAFEC:  JSR Buttons1Status      ;($B001)Get button presses and update button history.

LAFEF:  LDA MacStatus           ;($50)
LAFF1:  AND #$7F
LAFF3:  CMP #MAC_BLOCK
LAFF5:  BNE Joy1BtnsEnd

LAFF7:  LDX #$08

LAFF9:* JSR DPad1NoRelMask      ;($B016)
LAFFC:  DEX
LAFFD:  DEX
LAFFE:  BNE -

Joy1BtnsEnd:
LB000:  RTS

Buttons1Status:
LB001:  CMP Button1Status,X
LB003:  BNE DPad1NotReleased

LB005:  TAY
LB006:  BEQ $B01D

LB008:  LDA Button1History,X
LB00A:  ROR
LB00B:  BCS $B013
LB00D:  LDA #$81
LB00F:  ORA Button1History,X
LB011:  STA Button1History,X
LB013:  RTS

DPad1NotReleased:
LB014:  STA Button1Status,X     ;Store dpad 1 status.

DPad1NoRelMask:
LB016:  LDA #$7F                ;Indicate dpad not released before direction was changed.

LB018:* AND Button1History,X    ;
LB01A:  STA Button1History,X    ;Update button history.
LB01C:  RTS                     ;

ClrDPad1History:
LB01D:  LDA #$7E                ;Prepare to clear dpad history.
LB01F:  BNE -                   ;

VerifyJoyRead:
LB021:  LDA JoyRawReads,Y       ;Get the last controller buttons poll.

VerifyJoyLoop:
LB024:  STA GenByteE0           ;Store the polled data for comparison.

LB026:  DEY                     ;Move to the next polled byte.
LB027:  DEY                     ;

LB028:  BMI VerifyJoyExit       ;Have all 4 polled bytes been checked? If so, branch.

LB02A:  LDA JoyRawReads,Y       ;Have 2 consecutive polls been identical?
LB02D:  CMP GenByteE0           ;
LB02F:  BNE VerifyJoyLoop       ;If so, branch. Valid button presses have been read.

LB031:  STA Joy1Buttons,X       ;Save the verified button press data.

VerifyJoyExit:
LB033:  RTS                     ;Done verifying the polled data from the controller.

GetJoy2Buttons:
LB034:  LDY #$07                ;Prepare to read the 4 polls from controller 2.
LB036:  LDX #$01                ;
LB038:  JSR VerifyJoyRead       ;($B021)Verify joy pad reads by ignoring any DMC conflicts.

LB03B:  DEX
LB03C:  LDA Joy2Buttons
LB03E:  AND #$0F
LB040:  JSR $B049

LB043:  LDX #$02
LB045:  LDA Joy2Buttons
LB047:  AND #$C0

LB049:  CMP $DC,X
LB04B:  BNE $B05C
LB04D:  TAY
LB04E:  BEQ $B065
LB050:  LDA $DD,X
LB052:  ROR
LB053:  BCS $B05B
LB055:  LDA #$81
LB057:  ORA $DD,X
LB059:  STA $DD,X
LB05B:  RTS

LB05C:  STA $DC,X
LB05E:  LDA #$7F
LB060:  AND $DD,X
LB062:  STA $DD,X
LB064:  RTS

;----------------------------------------------------------------------------------------------------

LB065:  LDA #$7E
LB067:  BNE $B060
LB069:  LDA $30
LB06B:  BEQ $B0C7
LB06D:  LDY #$00
LB06F:  LDA ($31),Y
LB071:  CMP #$D0
LB073:  BCS $B07D
LB075:  CMP $0311
LB078:  BNE $B0C7
LB07A:  INY
LB07B:  LDA ($31),Y
LB07D:  INY
LB07E:  CMP #$E0
LB080:  BCS $B088
LB082:  AND #$87
LB084:  STA $37
LB086:  BNE $B0AA
LB088:  CMP #$F0
LB08A:  BCS $B0BB
LB08C:  CMP #$E0
LB08E:  BEQ $B0AA
LB090:  AND #$0F
LB092:  STA $E0
LB094:  LDA ($31),Y
LB096:  INY
LB097:  STA $E1
LB099:  LDA ($31),Y
LB09B:  INY
LB09C:  STA $E2
LB09E:  LDX #$00
LB0A0:  LDA ($31),Y
LB0A2:  INY
LB0A3:  STA ($E1,X)
LB0A5:  INX
LB0A6:  DEC $E0
LB0A8:  BNE $B0A0
LB0AA:  LDA ($31),Y
LB0AC:  BEQ $B07A
LB0AE:  TYA
LB0AF:  CLC
LB0B0:  ADC $31
LB0B2:  STA $31
LB0B4:  LDA $32
LB0B6:  ADC #$00
LB0B8:  STA $32
LB0BA:  RTS

LB0BB:  TAX
LB0BC:  INX
LB0BD:  BEQ $B0C8
LB0BF:  INX
LB0C0:  BEQ $B0F1
LB0C2:  INX
LB0C3:  BEQ $B0F5
LB0C5:  BNE $B0AA
LB0C7:  RTS

LB0C8:  LDA ($31),Y
LB0CA:  INY
LB0CB:  TAX
LB0CC:  LDA ($31),Y
LB0CE:  INY
LB0CF:  STA $E2
LB0D1:  LDA ($31),Y
LB0D3:  INY
LB0D4:  STY $E3
LB0D6:  TAY
LB0D7:  LDA ($33),Y
LB0D9:  INY
LB0DA:  STA $E0
LB0DC:  LDA ($33),Y
LB0DE:  STA $E1
LB0E0:  LDY #$00
LB0E2:  LDA ($E0),Y
LB0E4:  STA $0500,X
LB0E7:  INY
LB0E8:  INX
LB0E9:  DEC $E2
LB0EB:  BNE $B0E2
LB0ED:  LDY $E3
LB0EF:  BNE $B0AA
LB0F1:  LDA #$01
LB0F3:  BNE $B0F7
LB0F5:  LDA #$02
LB0F7:  STA $E0
LB0F9:  LDA ($31),Y
LB0FB:  INY
LB0FC:  TAX
LB0FD:  LDA ($31),Y
LB0FF:  INY
LB100:  STA $0500,X
LB103:  INX
LB104:  DEC $E0
LB106:  BNE $B0FD
LB108:  BEQ $B0AA
LB10A:  LDA OppCurState
LB10C:  AND #$7F
LB10E:  CMP #$01
LB110:  BNE $B124
LB112:  LDA $36
LB114:  BMI $B124
LB116:  BEQ $B125
LB118:  LSR
LB119:  BCS $B12B
LB11B:  LSR
LB11C:  BCS $B12F
LB11E:  LSR
LB11F:  BCS $B133
LB121:  LSR
LB122:  BCS $B137
LB124:  RTS
LB125:  LDA $37
LB127:  BPL $B124
LB129:  BMI $B139
LB12B:  LDA #$01
LB12D:  BPL $B139
LB12F:  LDA #$07
LB131:  BNE $B139
LB133:  LDA #$06
LB135:  BNE $B139
LB137:  LDA #$02
LB139:  AND #$07
LB13B:  STA $35
LB13D:  AND #$06
LB13F:  ASL
LB140:  ASL
LB141:  ASL
LB142:  ASL
LB143:  TAX
LB144:  STA $EE
LB146:  LDA $35
LB148:  AND #$01
LB14A:  ASL
LB14B:  ADC $EE
LB14D:  TAY
LB14E:  LDA $0500,Y
LB151:  STA $3B
LB153:  LDA $0501,Y
LB156:  STA $3C
LB158:  LDY #$00
LB15A:  STY $3A
LB15C:  STY $37
LB15E:  INY
LB15F:  STY $39
LB161:  LDA $0504,X
LB164:  STA $0584
LB167:  LDA $0505,X
LB16A:  STA $0580
LB16D:  STA VariableStTime
LB170:  LDA $0506,X
LB173:  AND #$07
LB175:  STA $0582
LB178:  LDA $0506,X
LB17B:  AND #$F8
LB17D:  LSR
LB17E:  LSR
LB17F:  LSR
LB180:  STA $0583
LB183:  LDY #$00
LB185:  LDA $0507,X
LB188:  STA $0585,Y
LB18B:  INX
LB18C:  INY
LB18D:  CPY #$08
LB18F:  BNE $B185
LB191:  LDA #$80
LB193:  STA $36
LB195:  RTS
LB196:  LDA $38
LB198:  BEQ $B1CD
LB19A:  LDX OppCurState
LB19C:  DEX
LB19D:  BNE $B1CD
LB19F:  DEC $39
LB1A1:  BNE $B1CD
LB1A3:  INC $39
LB1A5:  LDY $3A
LB1A7:  LDA ($3B),Y
LB1A9:  AND #$0F
LB1AB:  TAX
LB1AC:  LDA ($3B),Y
LB1AE:  INC $3A
LB1B0:  INY
LB1B1:  CMP #$80
LB1B3:  BCS $B1F4
LB1B5:  JSR Div16               ;($BF99)Shift upper nibble to lower nibble.
LB1B8:  JSR IndFuncJump         ;($AED4)Indirect jump to desired function below.

LB1BB:  .word $B1C1, $B1CE, $B1DF

LB1C1:  STX $39
LB1C3:  INC $3A
LB1C5:  LDA ($3B),Y
LB1C7:  STA OppCurState
LB1C9:  LDA #$01
LB1CB:  STA OppStateTimer
LB1CD:  RTS
LB1CE:  TXA
LB1CF:  JSR $AEAB
LB1D2:  BCC $B1DC
LB1D4:  LDA ($3B),Y
LB1D6:  TAY
LB1D7:  STY $3A
LB1D9:  JMP $B1A5
LB1DC:  INY
LB1DD:  BNE $B1D7
LB1DF:  STX $39
LB1E1:  LDA $18
LB1E3:  JSR $AEF1
LB1E6:  AND #$07
LB1E8:  CLC
LB1E9:  ADC $3A
LB1EB:  TAY
LB1EC:  LDA #$08
LB1EE:  ADC $3A
LB1F0:  STA $3A
LB1F2:  BNE $B1C5
LB1F4:  CMP #$F0
LB1F6:  BCS $B23C
LB1F8:  CMP #$90
LB1FA:  BCS $B21E
LB1FC:  TXA
LB1FD:  CMP #$01
LB1FF:  BEQ $B210
LB201:  BCS $B21A
LB203:  LDA ($3B),Y
LB205:  INY
LB206:  STY $3A
LB208:  STA $39
LB20A:  RTS
LB20B:  LDA ($3B),Y
LB20D:  INY
LB20E:  BNE $B205
LB210:  LDA $18
LB212:  JSR $AEF1
LB215:  BMI $B20B
LB217:  INY
LB218:  BNE $B203
LB21A:  ASL
LB21B:  ASL
LB21C:  BNE $B208
LB21E:  STX $E0
LB220:  LDA ($3B),Y
LB222:  STA $E1
LB224:  INY
LB225:  LDA ($3B),Y
LB227:  STA $E2
LB229:  INY
LB22A:  LDX #$00
LB22C:  LDA ($3B),Y
LB22E:  STA ($E1,X)
LB230:  INY
LB231:  INC $E1
LB233:  DEC $E0
LB235:  BNE $B22C
LB237:  STY $3A
LB239:  JMP $B1A5

LB23C:  TXA
LB23D:  JSR IndFuncJump         ;($AED4)Indirect jump to desired function below.

LB240:  .word $B24A, $B250, $B259, $B26A, $B273 

LB24A:  LDA $0584
LB24D:  JMP $B139

LB250:  LDA $36
LB252:  AND #$7F
LB254:  STA $36
LB256:  JMP $B1A5

LB259:  LDA ($3B),Y
LB25B:  INY
LB25C:  TAX
LB25D:  LDA ($3B),Y
LB25F:  INY
LB260:  CMP $00,X
LB262:  BNE $B267
LB264:  JMP $B1D4
LB267:  JMP $B1DC

LB26A:  LDA ($3B),Y
LB26C:  INC $3A
LB26E:  STA $3D
LB270:  JMP $B1A5

LB273:  DEC $3D
LB275:  BEQ $B267
LB277:  JMP $B1D4

LB27A:  JSR PushFightBank       ;($AA48)
LB27D:  JSR $B2EB
LB280:  JMP PushPRGBank07       ;($AA3C)
LB283:  JSR PushFightBank       ;($AA48)
LB286:  STA $AFFF

LB289:  JSR $B3A3

LB28C:  JMP PushPRGBank07       ;($AA3C)
LB28F:  JSR PushFightBank       ;($AA48)
LB292:  JSR $B3EB
LB295:  JMP PushPRGBank07       ;($AA3C)
LB298:  LDY #$04
LB29A:  LDA $B39E,Y
LB29D:  STA $00C0,Y
LB2A0:  DEY
LB2A1:  BPL $B29A
LB2A3:  INC $8F
LB2A5:  INC MacKDFight          ;($03D0)
LB2A8:  LDX RoundNumber
LB2AA:  INC $03DC,X
LB2AD:  LDA $8F
LB2AF:  CMP #$03
LB2B1:  BEQ $B2E2
LB2B3:  LDA $05D0
LB2B6:  STA $E6
LB2B8:  LDA $05D1
LB2BB:  STA $E7
LB2BD:  LDY $03C1
LB2C0:  LDA ($E6),Y
LB2C2:  STA $03C4
LB2C5:  STA $05D2
LB2C8:  INY
LB2C9:  LDA $03B1
LB2CC:  CMP ($E6),Y
LB2CE:  INY
LB2CF:  BCS $B2D5
LB2D1:  LDA #$7F
LB2D3:  BNE $B2D7
LB2D5:  LDA ($E6),Y
LB2D7:  STA $03C3
LB2DA:  STY $03C1
LB2DD:  LDA #$43
LB2DF:  STA $70
LB2E1:  RTS
LB2E2:  LDA #$00
LB2E4:  STA $C0
LB2E6:  RTS
LB2E7:  DEX
LB2E8:  BEQ $B298
LB2EA:  RTS
LB2EB:  LDX $05
LB2ED:  DEX
LB2EE:  BNE $B2E7
LB2F0:  LDY #$0A
LB2F2:  LDA $B393,Y
LB2F5:  STA $00C0,Y
LB2F8:  DEY
LB2F9:  BPL $B2F2
LB2FB:  INC OppKDRound          ;($03CA)
LB2FE:  INC OppKDFight          ;($03D1)
LB301:  LDA OppKDRound          ;($03CA)
LB304:  CMP #$03
LB306:  BEQ $B2E2
LB308:  LDA #$00
LB30A:  LDX $BA
LB30C:  STA $BA
LB30E:  INX
LB30F:  BEQ $B2EA
LB311:  LDA OppRefillPtr        ;($05D5)
LB314:  STA $E6
LB316:  LDA OppRefillPtrUB      ;($05D6)
LB319:  STA $E7
LB31B:  LDY MacKDRound          ;($03C9)
LB31E:  LDA ($E6),Y
LB320:  BNE $B32A
LB322:  LDX MacStatus           ;($50)
LB324:  CPX #MAC_SUPER_PUNCH
LB326:  BEQ $B33F
LB328:  BNE $B342
LB32A:  BPL $B338
LB32C:  LDX RoundNumber
LB32E:  DEX
LB32F:  BNE $B342
LB331:  LDX RoundMinute         ;($0302)
LB334:  BNE $B342
LB336:  AND #$7F
LB338:  CMP MacNextHP
LB33B:  BEQ $B33F
LB33D:  BCS $B342
LB33F:  INY
LB340:  BNE $B356
LB342:  LDA $18
LB344:  JSR $AEF1
LB347:  AND #$07
LB349:  CMP #$06
LB34B:  BCC $B34F
LB34D:  AND #$01
LB34F:  CLC
LB350:  ADC #$02
LB352:  ADC MacKDRound          ;($03C9)
LB355:  TAY
LB356:  LDA ($E6),Y
LB358:  BEQ $B2EA
LB35A:  LDX #$07
LB35C:  JSR $B439
LB35F:  LDA ($E6),Y
LB361:  JSR Div16               ;($BF99)Shift upper nibble to lower nibble.
LB364:  BEQ $B37A
LB366:  CMP #$01
LB368:  BEQ $B372
LB36A:  CMP #$07
LB36C:  BEQ $B372
LB36E:  CMP #$09
LB370:  BNE $B375
LB372:  STA SpecialKD           ;($03CB)
LB375:  CLC
LB376:  ADC #$99
LB378:  BNE $B387
LB37A:  LDA $18
LB37C:  JSR $AEF1
LB37F:  JSR Div16               ;($BF99)Shift upper nibble to lower nibble.

LB382:  LSR
LB383:  TAY
LB384:  LDA OppGetUpTable,Y     ;($05E0)
LB387:  STA OppGetUpCount
LB389:  LDA MacKDRound          ;($03C9)
LB38C:  CLC
LB38D:  ADC #$08
LB38F:  STA MacKDRound          ;($03C9)
LB392:  RTS

LB393:  .byte $0F, $99, $E3, $C1, $00, $07, $EA, $FA, $7D, $05, $EA, $0F, $99, $80, $05, $EA

LB3A3:  LDX $05C4
LB3A6:  BNE $B3AC
LB3A8:  LDX #$80
LB3AA:  BNE $B3CB
LB3AC:  LDY #$00
LB3AE:  LDX #$00
LB3B0:  LDA ($4E),Y
LB3B2:  BMI $B3B9
LB3B4:  CMP $03B0
LB3B7:  BNE $B3CB
LB3B9:  INY
LB3BA:  LDA ($4E),Y
LB3BC:  BMI $B3C2
LB3BE:  CMP MacPunchType
LB3C0:  BNE $B3CB
LB3C2:  INY
LB3C3:  STY $4D
LB3C5:  LDA MacPunchType
LB3C7:  STA $03B0
LB3CA:  INX
LB3CB:  STX $4C
LB3CD:  LDA ComboDataPtrLB      ;($05C2)
LB3D0:  STA $E6
LB3D2:  LDA ComboDataPtrUB      ;($05C3)
LB3D5:  STA $E7
LB3D7:  LDY #$00
LB3D9:  LDA ComboTimer
LB3DB:  CMP ($E6),Y
LB3DD:  BEQ $B3E5
LB3DF:  BCC $B3E5
LB3E1:  INY
LB3E2:  INY
LB3E3:  BNE $B3DB
LB3E5:  INY
LB3E6:  LDA ($E6),Y
LB3E8:  STA ComboCountDown
LB3EA:  RTS
LB3EB:  LDY $4D
LB3ED:  LDA ($4E),Y
LB3EF:  BMI $B408
LB3F1:  LDA MacPunchType
LB3F3:  AND #$83
LB3F5:  CMP ($4E),Y
LB3F7:  BEQ $B400
LB3F9:  LDA $4C
LB3FB:  AND #$FE
LB3FD:  STA $4C
LB3FF:  RTS
LB400:  INC $4D
LB402:  LDA MacPunchType
LB404:  STA $03B0
LB407:  RTS
LB408:  TAX
LB409:  INX
LB40A:  BEQ $B412
LB40C:  INX
LB40D:  BEQ $B407
LB40F:  INX
LB410:  BEQ $B419
LB412:  INY
LB413:  LDA ($4E),Y
LB415:  STA $4D
LB417:  BNE $B3EB
LB419:  LDA $03B0
LB41C:  EOR #$01
LB41E:  CMP MacPunchType
LB420:  BEQ $B400
LB422:  BNE $B3F9
LB424:  LDX #$01
LB426:  BNE $B42E
LB428:  LDX #$02
LB42A:  BNE $B42E
LB42C:  LDX #$03
LB42E:  STA $E7
LB430:  TXA
LB431:  AND MacPunchType
LB433:  CLC
LB434:  ADC $E7
LB436:  STA OppCurState
LB438:  RTS
LB439:  LDA $0398
LB43C:  STA $039E
LB43F:  LDA MacNextHP
LB442:  STA MacMaxHP
LB445:  LDA ($E6),Y
LB447:  AND #$0F
LB449:  ASL
LB44A:  ASL
LB44B:  ASL
LB44C:  STA MacMaxHP,X
LB44F:  RTS
LB450:  RTS
LB451:  JMP $B4F4
LB454:  JMP $B4FB
LB457:  LDA $CF
LB459:  BEQ $B450
LB45B:  LDA $03C3
LB45E:  BMI $B451
LB460:  BEQ $B450
LB462:  LDA A1History           ;($D5)
LB464:  BPL $B46F
LB466:  AND #$7F
LB468:  STA A1History           ;($D5)
LB46A:  LDA B1History           ;($D7)
LB46C:  JMP $B473
LB46F:  LDA B1History           ;($D7)
LB471:  BPL $B454
LB473:  AND #$7F
LB475:  STA B1History           ;($D7)
LB477:  DEC $03C3
LB47A:  LDA $03C3
LB47D:  BEQ $B489
LB47F:  CMP #$05
LB481:  BCC $B4DC
LB483:  LDA #$3A
LB485:  STA $70
LB487:  BNE $B4E4
LB489:  LDA $C1
LB48B:  SEC
LB48C:  SBC #$99
LB48E:  CLC
LB48F:  ADC $03C1
LB492:  TAY
LB493:  LDA $05D0
LB496:  STA $E6
LB498:  LDA $05D1
LB49B:  STA $E7
LB49D:  LDX #$00
LB49F:  JSR $B439
LB4A2:  LDA ($E6),Y
LB4A4:  AND #$30
LB4A6:  LSR
LB4A7:  LSR
LB4A8:  LSR
LB4A9:  STA $E0
LB4AB:  LSR
LB4AC:  ADC $E0
LB4AE:  BNE $B4B2
LB4B0:  LDA #$01
LB4B2:  STA NewHeartsLD
LB4B5:  LDA #$00
LB4B7:  STA NewHeartsUD
LB4BA:  LDA ($E6),Y
LB4BC:  ROL
LB4BD:  ROL
LB4BE:  ROL
LB4BF:  AND #$01
LB4C1:  STA $03C5
LB4C4:  LDA ($E6),Y
LB4C6:  ROL
LB4C7:  ROL
LB4C8:  AND #$01
LB4CA:  BEQ $B4CF
LB4CC:  STA SpecialKD           ;($03CB)
LB4CF:  LDA #$02
LB4D1:  STA $36
LB4D3:  LDA $03C1
LB4D6:  CLC
LB4D7:  ADC #$0A
LB4D9:  STA $03C1
LB4DC:  SEC
LB4DD:  LDA #$48
LB4DF:  SBC $03C3
LB4E2:  STA $70
LB4E4:  LDA $60
LB4E6:  BNE $B526
LB4E8:  LDA $70
LB4EA:  STA $61
LB4EC:  LDA #$81
LB4EE:  STA $60
LB4F0:  JSR $AA96
LB4F3:  RTS
LB4F4:  AND #$7F
LB4F6:  STA $03C3
LB4F9:  BPL $B4E4
LB4FB:  LDA $03C3
LB4FE:  CMP #$05
LB500:  BCC $B516
LB502:  LDA A1Status            ;($D4)
LB504:  BNE $B4F3
LB506:  LDA B1Status            ;($D6)
LB508:  BNE $B4F3
LB50A:  LDA $70
LB50C:  CMP #$3A
LB50E:  BNE $B4F3
LB510:  LDA #$43
LB512:  STA $70
LB514:  BNE $B4E4
LB516:  DEC $03C4
LB519:  BNE $B4F3
LB51B:  LDA $05D2
LB51E:  STA $03C4
LB521:  INC $03C3
LB524:  BNE $B4DC
LB526:  LDA $03C3
LB529:  ORA #$80
LB52B:  STA $03C3
LB52E:  RTS
LB52F:  RTS
LB530:  LDA $00
LB532:  BMI $B52F
LB534:  AND #$0F
LB536:  TAX
LB537:  LDA $00
LB539:  JSR Div16               ;($BF99)Shift upper nibble to lower nibble.
LB53C:  JSR IndFuncJump         ;($AED4)Indirect jump to desired function below.

LB53F:  .word $B549, $B5A8, $B5A8, $B5A9, $B63E

LB549:  LDA RoundTmrCntrl
LB54C:  BMI $B581
LB54E:  LDA OppCurState
LB550:  BEQ $B580
LB552:  LDA IncStars
LB555:  BEQ $B559
LB557:  BPL $B580
LB559:  LDA $05
LB55B:  BNE $B586
LB55D:  LDA OppStateStatus
LB55F:  AND $51
LB561:  ROR
LB562:  BCS $B575
LB564:  LDA OppStateStatus
LB566:  CMP #$82
LB568:  BNE $B580
LB56A:  LDA $51
LB56C:  CMP #$83
LB56E:  BNE $B580
LB570:  JSR $B65A
LB573:  BNE $B580
LB575:  ROL
LB576:  CMP #$83
LB578:  BNE $B580
LB57A:  JSR $B651
LB57D:  JSR $B65A

LB580:  RTS

LB581:  LDA #$40
LB583:  STA $00
LB585:  RTS
LB586:  CMP #$02
LB588:  BEQ $B599
LB58A:  LDA $51
LB58C:  CMP #$83
LB58E:  BNE $B580
LB590:  LDA #$C1
LB592:  STA MacStatus           ;($50)
LB594:  LDA #$81
LB596:  STA $51
LB598:  RTS

LB599:  LDA OppStateStatus
LB59B:  CMP #STAT_FINISHED
LB59D:  BNE $B580

LB59F:  LDA #$C1
LB5A1:  STA OppCurState
LB5A3:  LDA #$81
LB5A5:  STA OppStateStatus
LB5A7:  RTS

LB5A8:  RTS
LB5A9:  LDA #$01
LB5AB:  STA MacCanPunch
LB5AD:  LDA RoundNumber
LB5AF:  CMP #$04
LB5B1:  BCC $B5B6
LB5B3:  JMP $B621
LB5B6:  ASL
LB5B7:  ADC RoundNumber
LB5B9:  TAX
LB5BA:  CMP #$03
LB5BC:  BEQ $B5CB
LB5BE:  LDA HeartTable,X        ;($05A3)
LB5C1:  JSR Div16               ;($BF99)Shift upper nibble to lower nibble.
LB5C4:  CMP CurHeartsUD
LB5C7:  BEQ $B5DF
LB5C9:  BCC $B5EC
LB5CB:  LDA HeartTable,X        ;($05A3)
LB5CE:  JSR Div16               ;($BF99)Shift upper nibble to lower nibble.
LB5D1:  STA CurHeartsUD
LB5D4:  LDA HeartTable,X        ;($05A3)
LB5D7:  AND #$0F
LB5D9:  STA CurHeartsLD
LB5DC:  JMP $B5EC
LB5DF:  LDA HeartTable,X        ;($05A3)
LB5E2:  AND #$0F
LB5E4:  CMP CurHeartsLD
LB5E7:  BCC $B5EC
LB5E9:  STA CurHeartsLD
LB5EC:  INX
LB5ED:  LDY #$00
LB5EF:  LDA HeartTable,X        ;($05A3)
LB5F2:  JSR Div16               ;($BF99)Shift upper nibble to lower nibble.
LB5F5:  STA HeartRecover,Y
LB5F8:  INY
LB5F9:  LDA HeartTable,X        ;($05A3)
LB5FC:  AND #$0F
LB5FE:  STA HeartRecover,Y
LB601:  INY
LB602:  INX
LB603:  CPY #$04
LB605:  BNE $B5EF
LB607:  LDA RoundNumber
LB609:  ASL
LB60A:  TAX
LB60B:  LDA ClockRateTable,X    ;($05D8)
LB60E:  STA ClockRateUB         ;($0308)
LB611:  LDA $05D9,X
LB614:  STA ClockRateLB         ;($0309)
LB617:  LDA $05C0
LB61A:  STA $4E
LB61C:  LDA $05C1
LB61F:  STA $4F
LB621:  LDX #$80
LB623:  STX RoundTmrStart       ;($0300)
LB626:  STX $0340
LB629:  INX
LB62A:  STX $0320
LB62D:  LDA #$C0
LB62F:  STA MacStatus           ;($50)
LB631:  STA OppCurState
LB633:  LDA #$81
LB635:  STA $51
LB637:  STA OppStateStatus
LB639:  LDA #$01
LB63B:  STA $00
LB63D:  RTS
LB63E:  LDA RoundTimerUB        ;($0306)
LB641:  BNE $B650
LB643:  LDA ClockDispStatus     ;($030A)
LB646:  BNE $B650
LB648:  LDA #$03
LB64A:  STA $05
LB64C:  LDA #$FF
LB64E:  STA $00
LB650:  RTS
LB651:  LDA #STAT_NONE
LB653:  STA OppStateStatus
LB655:  LDA #$81
LB657:  STA OppCurState
LB659:  RTS
LB65A:  LDA #$82
LB65C:  SEC
LB65D:  SBC MacCanPunch
LB65F:  STA MacStatus           ;($50)
LB661:  LDA #$80
LB663:  STA $51
LB665:  RTS
LB666:  JSR $BD9B
LB669:  JSR $BF3C
LB66C:  LDA #$03
LB66E:  STA GameStatus
LB670:  LDX #$08
LB672:  LDA #$07
LB674:  JSR $BF55
LB677:  LDX #$04
LB679:  STX $B000
LB67C:  LDA #$48
LB67E:  STA $13
LB680:  LDX #$10
LB682:  JSR $BF9E
LB685:  LDY #$12
LB687:  STY $E2
LB689:  LDY #$50
LB68B:  LDX #$06
LB68D:  JSR $BEE1
LB690:  LDA #PAL_UPDATE
LB692:  STA UpdatePalFlag
LB695:  LDY #$03
LB697:  LDA $B6C7,Y
LB69A:  STA $0208,Y
LB69D:  DEY
LB69E:  BPL $B697
LB6A0:  RTS
LB6A1:  JSR $B666
LB6A4:  JSR LoadPRGBank09       ;($AA5C)
LB6A7:  JSR $800E
LB6AA:  LDX #$20
LB6AC:  LDY #$09
LB6AE:  JSR $AF2E
LB6B1:  LDA #$FE
LB6B3:  STA PPUIOReg
LB6B6:  LDA #$01
LB6B8:  LDX #$05
LB6BA:  JSR $BF21
LB6BD:  LDA #$00
LB6BF:  LDX #$02
LB6C1:  JSR $BF0D
LB6C4:  JMP LoadPRGBank0C       ;($AA64)

LB6C7:  .byte $00, $FE, $00, $00

LB6CB:  JSR $BD9B
LB6CE:  JSR $BF3C
LB6D1:  LDA #$03
LB6D3:  STA GameStatus
LB6D5:  LDA #$04
LB6D7:  LDX #$04
LB6D9:  JSR $BF55
LB6DC:  LDA #$FE
LB6DE:  JSR $BFAE
LB6E1:  JSR $BFB2
LB6E4:  LDA #$23
LB6E6:  LDX #$0C
LB6E8:  JSR $BF21
LB6EB:  LDA #$0C
LB6ED:  STA OppBaseAnimIndex
LB6EF:  JSR $C850
LB6F2:  LDA #$14
LB6F4:  LDX #$02
LB6F6:  JSR $BF0D
LB6F9:  LDA #$8F
LB6FB:  LDY #$00
LB6FD:  STA ThisBkgPalette,Y
LB700:  INY
LB701:  CPY #$20
LB703:  BNE $B6FD
LB705:  LDA #$00
LB707:  JSR $BC5F
LB70A:  RTS
LB70B:  JSR $BF36
LB70E:  LDA #$00
LB710:  LDX #$05
LB712:  JSR $BF55
LB715:  LDX #$06
LB717:  JSR $BF9E
LB71A:  LDY #$20
LB71C:  STY $E2
LB71E:  LDX #$00
LB720:  JSR $BEE1
LB723:  LDA #PAL_UPDATE
LB725:  STA UpdatePalFlag
LB728:  LDA #$FD
LB72A:  JSR $BFAE
LB72D:  LDA #$FD
LB72F:  JSR $BFAA
LB732:  LDA #$48
LB734:  STA OppBaseXSprite
LB736:  LDA #$A0
LB738:  STA OppBaseYSprite
LB73A:  LDA #$30
LB73C:  LDX #$04
LB73E:  JSR $BF21
LB741:  LDA #$00
LB743:  LDX #$03
LB745:  JSR $BF0D
LB748:  LDA #$F8
LB74A:  STA $13
LB74C:  LDA #$01
LB74E:  STA $14

LB750:  LDA PPU1Load
LB752:  AND #$F9
LB754:  STA PPU1Load
LB756:  RTS

LB757:  JSR $B666
LB75A:  JSR LoadPRGBank09       ;($AA5C)
LB75D:  LDA #$FF
LB75F:  JSR $BFAE
LB762:  JSR $BFB2
LB765:  LDA #$06
LB767:  LDX #$05
LB769:  JSR $BF21
LB76C:  LDA #$01
LB76E:  JSR $C113
LB771:  LDA #$00
LB773:  LDX #$01
LB775:  JSR $BF0D
LB778:  JSR LoadPRGBank07       ;($AA54)
LB77B:  JSR $805A
LB77E:  JSR LoadPRGBank0C       ;($AA64)

LB781:  LDA #SPRT_BKG_ON        ;Enable sprites and background.
LB783:  STA SprtBkgUpdt         ;

LB785:  LDA #$FF
LB787:  STA GameStatus
LB789:  JSR $AF04
LB78C:  LDA #$C0
LB78E:  JSR $AF04
LB791:  LDY #$04
LB793:  JSR $B870
LB796:  LDA #$10
LB798:  JSR $AF04
LB79B:  LDY #$09
LB79D:  JSR $B870
LB7A0:  LDA #$10
LB7A2:  JSR $AF04
LB7A5:  JSR $BF7E
LB7A8:  LDA #$B8
LB7AA:  STA OppBaseXSprite
LB7AC:  LDA #$20
LB7AE:  STA OppBaseYSprite
LB7B0:  LDA #$D0
LB7B2:  STA $20
LB7B4:  LDA #$01
LB7B6:  STA $21
LB7B8:  LDY #$00
LB7BA:  STY OppKDFight          ;($03D1)
LB7BD:  STY $03D4
LB7C0:  LDA $B866,Y
LB7C3:  STA $05CD
LB7C6:  STY $03D4
LB7C9:  LDA #$03
LB7CB:  STA GameStatus
LB7CD:  JSR $AF38
LB7D0:  JSR LoadPRGBank09       ;($AA5C)
LB7D3:  LDA #$0B
LB7D5:  LDX #$04
LB7D7:  JSR $BF21
LB7DA:  JSR $BCBE

LB7DD:  LDA #SPRT_BKG_ON        ;Enable sprites and background.
LB7DF:  STA SprtBkgUpdt         ;

LB7E1:  LDA #$FF
LB7E3:  STA GameStatus
LB7E5:  JSR $AF04
LB7E8:  LDA #$18
LB7EA:  JSR $AF04
LB7ED:  JSR $BF7E
LB7F0:  LDY $03D4
LB7F3:  INY
LB7F4:  CPY #$0A
LB7F6:  BNE $B7C0
LB7F8:  LDA #$03
LB7FA:  STA GameStatus
LB7FC:  JSR $AF38
LB7FF:  LDA #$00
LB801:  LDX #$07
LB803:  JSR $BF55
LB806:  LDA #$01
LB808:  STA $14
LB80A:  LDA #$00
LB80C:  STA $20
LB80E:  STA $21
LB810:  LDX #$10
LB812:  JSR $BF9E
LB815:  LDY #$20
LB817:  STY $E2
LB819:  LDX #$00
LB81B:  LDY #$00
LB81D:  JSR $BEE1
LB820:  LDA #$01
LB822:  STA ThisSprtPalette
LB825:  LDA #PAL_UPDATE
LB827:  STA UpdatePalFlag
LB82A:  LDA #$54
LB82C:  STA OppBaseXSprite
LB82E:  LDA #$B9
LB830:  STA OppBaseYSprite
LB832:  JSR $B695
LB835:  LDA #$1A
LB837:  LDX #$01
LB839:  JSR $BF0D
LB83C:  JSR LoadPRGBank09       ;($AA5C)
LB83F:  LDA #$0F
LB841:  JSR $C113
LB844:  LDX #$26
LB846:  LDY #$B4
LB848:  JSR $BE96
LB84B:  JSR $AEA5

LB84E:  LDA #SPRT_BKG_ON        ;Enable sprites and background.
LB850:  STA SprtBkgUpdt         ;

LB852:  LDA #$FF
LB854:  STA GameStatus
LB856:  LDA #$70
LB858:  JSR $AF04
LB85B:  LDA #$F5
LB85D:  JSR $BDA2
LB860:  LDA #$03
LB862:  STA GameStatus
LB864:  BNE $B860

LB866:  .byte $00, $06, $14, $02, $04, $08, $0A, $10, $0C, $0E, $A2, $10, $B9, $80, $B8, $9D 
LB876:  .byte $21, $02, $88, $CA, $CA, $CA, $CA, $10, $F3, $60, $7B, $7C, $76, $77, $7D, $74
LB886:  .byte $75, $76, $77, $78

LB88A:  JSR $BF3C
LB88D:  LDA #$07
LB88F:  LDX #$04
LB891:  JSR $BF55
LB894:  LDX #$10
LB896:  JSR $BF9E
LB899:  LDY #$20
LB89B:  STY $E2
LB89D:  LDX #$00
LB89F:  LDY #$00
LB8A1:  JSR $BEE1
LB8A4:  LDA #PAL_UPDATE
LB8A6:  STA UpdatePalFlag
LB8A9:  LDA #$FE
LB8AB:  JSR $BFAE
LB8AE:  LDA #$56
LB8B0:  LDX #$02
LB8B2:  JSR $BF21
LB8B5:  LDA #$18
LB8B7:  LDX #$01
LB8B9:  JSR $BF0D
LB8BC:  LDA #$01
LB8BE:  STA $17
LB8C0:  RTS
LB8C1:  JSR $BD9B
LB8C4:  JSR $BF3C
LB8C7:  LDA #$03
LB8C9:  STA GameStatus
LB8CB:  LDA #$07
LB8CD:  LDX #$07
LB8CF:  JSR $BF55
LB8D2:  LDX #$10
LB8D4:  JSR $BF9E
LB8D7:  LDY #$20
LB8D9:  STY $E2
LB8DB:  LDX #$00
LB8DD:  LDY #$30
LB8DF:  JSR $BEE1
LB8E2:  LDA #PAL_UPDATE
LB8E4:  STA UpdatePalFlag
LB8E7:  LDA #$FD
LB8E9:  JSR $BFAE
LB8EC:  LDA #$37
LB8EE:  LDX #$02
LB8F0:  JSR $BF21
LB8F3:  LDA #$22
LB8F5:  LDX #$01
LB8F7:  JSR $BF0D
LB8FA:  LDA #$01
LB8FC:  STA $17
LB8FE:  RTS
LB8FF:  JSR $BF36
LB902:  LDA #$FE
LB904:  STA $13
LB906:  LDX #$01
LB908:  STX $14
LB90A:  LDA #$03
LB90C:  JSR $BF55
LB90F:  STA $B000
LB912:  LDA #$FF
LB914:  JSR $BFAE
LB917:  JSR $BFAA
LB91A:  LDX #$08
LB91C:  JSR $BF9E
LB91F:  JSR $BED9
LB922:  LDA #PAL_UPDATE
LB924:  STA UpdatePalFlag
LB927:  JSR $BEED
LB92A:  LDA #$45
LB92C:  LDX #$04
LB92E:  JSR $BF21
LB931:  JSR $AEA5
LB934:  LDA #$49
LB936:  LDX #$02
LB938:  JSR $BF21
LB93B:  JSR $AE9B
LB93E:  LDX #$28
LB940:  LDY #$2F
LB942:  JSR $AF2E
LB945:  LDY #$00
LB947:  LDA $0150,Y
LB94A:  STA PPUIOReg
LB94D:  INY
LB94E:  CPY #$0C
LB950:  BNE $B947
LB952:  LDA #$01
LB954:  STA $17
LB956:  RTS
LB957:  JSR $BD9B
LB95A:  JSR $BF36
LB95D:  LDA #$03
LB95F:  STA GameStatus
LB961:  LDA #$07
LB963:  LDX #$04
LB965:  LDY $03D3
LB968:  CPY #$02
LB96A:  BNE $B96E
LB96C:  LDX #$07
LB96E:  JSR $BF55
LB971:  LDX #$10
LB973:  JSR $BF9E
LB976:  LDY #$20
LB978:  STY $E2
LB97A:  LDX #$00
LB97C:  LDY #$00
LB97E:  JSR $BEE1
LB981:  LDY $03D3
LB984:  CPY #$02
LB986:  BNE $B993
LB988:  LDA #$04
LB98A:  STA $E2
LB98C:  LDY #$20
LB98E:  LDX #$10
LB990:  JSR $BEE1
LB993:  LDA #PAL_UPDATE
LB995:  STA UpdatePalFlag
LB998:  LDA #$FD
LB99A:  JSR $BFAE
LB99D:  LDA #$FE
LB99F:  JSR $BFAA
LB9A2:  LDA #$39
LB9A4:  LDX #$02
LB9A6:  JSR $BF21
LB9A9:  LDA #$18
LB9AB:  LDX $03D3
LB9AE:  CPX #$02
LB9B0:  BNE $B9D3
LB9B2:  LDA #$58
LB9B4:  JSR $C113
LB9B7:  LDA $09
LB9B9:  JSR Div16               ;($BF99)Shift upper nibble to lower nibble.
LB9BC:  BNE $B9C3
LB9BE:  LDA #$44
LB9C0:  JSR $C113
LB9C3:  LDA #$1A
LB9C5:  LDX #$01
LB9C7:  JSR $BF0D
LB9CA:  LDA $09
LB9CC:  JSR Div16               ;($BF99)Shift upper nibble to lower nibble.
LB9CF:  ASL
LB9D0:  CLC
LB9D1:  ADC #$1C
LB9D3:  LDX #$01
LB9D5:  JSR $BF0D
LB9D8:  LDA #$01
LB9DA:  STA $17
LB9DC:  LDX $00
LB9DE:  INX
LB9DF:  INX
LB9E0:  BEQ $BA0C
LB9E2:  INX
LB9E3:  BEQ $B9EE
LB9E5:  INX
LB9E6:  BEQ $BA07
LB9E8:  INX
LB9E9:  BEQ $B9EE
LB9EB:  INX
LB9EC:  BEQ $B9FF
LB9EE:  LDA #$3E
LB9F0:  JSR $C113
LB9F3:  LDA $0A
LB9F5:  BEQ $BA20
LB9F7:  LDA #$3F
LB9F9:  JSR $C113
LB9FC:  JMP $BA38
LB9FF:  LDA #$3D
LBA01:  JSR $C113
LBA04:  JMP $BA20
LBA07:  LDA #$3C
LBA09:  JSR $C113
LBA0C:  LDX #$21
LBA0E:  LDY #$8D
LBA10:  JSR $BC8E
LBA13:  LDX #$21
LBA15:  LDY #$96
LBA17:  JSR $AF2E
LBA1A:  LDX RoundNumber
LBA1C:  INX
LBA1D:  STX PPUIOReg
LBA20:  LDX $03D3
LBA23:  CPX #$02
LBA25:  BEQ $BA49
LBA27:  LDX #$22
LBA29:  LDY #$1D
LBA2B:  JSR $AF2E
LBA2E:  LDA $09
LBA30:  AND #$0F
LBA32:  TAX
LBA33:  INX
LBA34:  INX
LBA35:  STX PPUIOReg
LBA38:  LDA #$54
LBA3A:  LDX $013E
LBA3D:  BNE $BA51
LBA3F:  LDA $09
LBA41:  JSR Div16               ;($BF99)Shift upper nibble to lower nibble.
LBA44:  CLC
LBA45:  ADC #$40
LBA47:  BNE $BA51
LBA49:  LDA $09
LBA4B:  JSR Div16               ;($BF99)Shift upper nibble to lower nibble.
LBA4E:  CLC
LBA4F:  ADC #$41
LBA51:  JSR $C113
LBA54:  LDX $03D3
LBA57:  DEX
LBA58:  BNE $BA73
LBA5A:  LDA #$59
LBA5C:  LDX #$03
LBA5E:  JSR $BF21
LBA61:  LDA #$55
LBA63:  LDX $013E
LBA66:  BNE $BA70
LBA68:  LDA $09
LBA6A:  JSR Div16               ;($BF99)Shift upper nibble to lower nibble.
LBA6D:  CLC
LBA6E:  ADC #$5B
LBA70:  JSR $C113
LBA73:  RTS
LBA74:  JSR $BF3C
LBA77:  LDA #$04
LBA79:  LDX #$05
LBA7B:  JSR $BF55
LBA7E:  LDX #$0C
LBA80:  JSR $BF9E
LBA83:  JSR $BED9
LBA86:  LDA $08
LBA88:  CMP #$30
LBA8A:  BNE $BA93
LBA8C:  TYA
LBA8D:  CLC
LBA8E:  ADC #$10
LBA90:  TAY
LBA91:  BNE $BA9C
LBA93:  LDX #$00
LBA95:  LDA #$10
LBA97:  STA $E2
LBA99:  JSR $BEE1
LBA9C:  LDA #PAL_UPDATE
LBA9E:  STA UpdatePalFlag
LBAA1:  JSR $BEED
LBAA4:  LDX #$00
LBAA6:  INY
LBAA7:  LDA ($E0),Y
LBAA9:  INY
LBAAA:  STA $06C0,X
LBAAD:  INX
LBAAE:  LDA #$FF
LBAB0:  STA $06C0,X
LBAB3:  INX
LBAB4:  STA $06C0,X
LBAB7:  INX
LBAB8:  CPX #$1E
LBABA:  BNE $BAA7
LBABC:  LDA #$FE
LBABE:  STA $06DC
LBAC1:  JSR $AEA5
LBAC4:  LDA #$14
LBAC6:  LDX #$02
LBAC8:  JSR $BF21
LBACB:  JSR $AE9B
LBACE:  LDA #$16
LBAD0:  LDX #$0D
LBAD2:  JSR $BF21
LBAD5:  LDA #$06
LBAD7:  LDX #$03
LBAD9:  JSR $BF0D

LBADC:  LDA PPU1Load
LBADE:  AND #$F9
LBAE0:  STA PPU1Load
LBAE2:  RTS

LBAE3:  JSR $BF36
LBAE6:  LDA #$FD
LBAE8:  JSR $BFAA
LBAEB:  LDX #$06
LBAED:  JSR $BF9E
LBAF0:  LDY #$20
LBAF2:  STY $E2
LBAF4:  LDX #$00
LBAF6:  JSR $BEE1
LBAF9:  LDA #$10
LBAFB:  LDX #$00
LBAFD:  JSR $BEFF
LBB00:  LDA #$03
LBB02:  LDX #$31
LBB04:  JSR $BEFF
LBB07:  LDA #$01
LBB09:  LDX #$03
LBB0B:  JSR $BF21
LBB0E:  LDA #$2F
LBB10:  JSR $C113
LBB13:  JSR $BCBE
LBB16:  LDA #$52
LBB18:  LDX $013E
LBB1B:  BNE $BB25
LBB1D:  LDA $09
LBB1F:  JSR Div16               ;($BF99)Shift upper nibble to lower nibble.
LBB22:  CLC
LBB23:  ADC #$05
LBB25:  JSR $C113
LBB28:  LDX #$20
LBB2A:  LDY #$7D
LBB2C:  JSR $AF2E
LBB2F:  LDA $09
LBB31:  AND #$0F
LBB33:  BNE $BB4A
LBB35:  LDA #$53
LBB37:  LDX $013E
LBB3A:  BNE $BB44
LBB3C:  LDA $09
LBB3E:  JSR Div16               ;($BF99)Shift upper nibble to lower nibble.
LBB41:  CLC
LBB42:  ADC #$10
LBB44:  JSR $C113
LBB47:  JMP $BB4F
LBB4A:  TAX
LBB4B:  INX
LBB4C:  STX PPUIOReg
LBB4F:  LDA $09
LBB51:  BEQ $BB68
LBB53:  AND #$0F
LBB55:  BNE $BB5F
LBB57:  LDA #$0C
LBB59:  JSR $C113
LBB5C:  JMP $BB68
LBB5F:  LDA $0A
LBB61:  BEQ $BB68
LBB63:  LDA #$0D
LBB65:  JSR $C113
LBB68:  LDA RoundNumber
LBB6A:  CLC
LBB6B:  ADC #$08
LBB6D:  JSR $C113
LBB70:  LDX #$21
LBB72:  LDY #$C2
LBB74:  JSR $BE96
LBB77:  LDX #$22
LBB79:  LDY #$34
LBB7B:  JSR $AF2E
LBB7E:  LDA #$E4
LBB80:  STA $E0
LBB82:  LDA #$06
LBB84:  STA $E1
LBB86:  JSR $BEA1
LBB89:  LDX #$23
LBB8B:  LDY #$2B
LBB8D:  JSR $AF2E
LBB90:  LDX $09
LBB92:  BEQ $BB9E
LBB94:  INX
LBB95:  INX
LBB96:  TXA
LBB97:  AND #$0F
LBB99:  STA PPUIOReg
LBB9C:  BNE $BBA3
LBB9E:  LDA #$35
LBBA0:  JSR $C113
LBBA3:  LDA #$00
LBBA5:  LDX #$03
LBBA7:  JMP $BF0D
LBBAA:  JSR LoadPRGBank09       ;($AA5C)
LBBAD:  LDA #$04
LBBAF:  JSR $C105
LBBB2:  LDA #$0B
LBBB4:  LDY #$0C
LBBB6:  LDX #$0D
LBBB8:  JSR $BEC9
LBBBB:  LDA #PAL_UPDATE
LBBBD:  STA UpdatePalFlag
LBBC0:  JMP LoadPRGBank0C       ;($AA64)
LBBC3:  LDA MacKDFight          ;($03D0)
LBBC6:  BEQ $BBD2
LBBC8:  LDA #$04
LBBCA:  DEX
LBBCB:  BEQ $BBCF
LBBCD:  LDA #$34
LBBCF:  JSR $C113
LBBD2:  LDA #$0E
LBBD4:  LDX #$02
LBBD6:  JSR $BF21
LBBD9:  LDA #$00
LBBDB:  LDX MacKDFight          ;($03D0)
LBBDE:  BEQ $BBE2
LBBE0:  LDA #$04
LBBE2:  STA $E0
LBBE4:  LDA $18
LBBE6:  AND #$03
LBBE8:  ORA $E0
LBBEA:  TAY
LBBEB:  LDA TrainerMessages,Y   ;($05F8)
LBBEE:  STA $04BE
LBBF1:  JSR $AEF1
LBBF4:  LDA $18
LBBF6:  AND #$07
LBBF8:  TAY
LBBF9:  LDA OppMessages,Y       ;($05F0)
LBBFC:  STA $04BF
LBBFF:  JSR $AEF1
LBC02:  RTS
LBC03:  AND #$7F
LBC05:  STA $04B0
LBC08:  LDX #$0E
LBC0A:  JSR $BF9E
LBC0D:  LDY #$00
LBC0F:  STY $04B2
LBC12:  LDA ($E0),Y
LBC14:  INY
LBC15:  STA $04B3
LBC18:  LDA ($E0),Y
LBC1A:  STA $04B4
LBC1D:  BNE $BC2B
LBC1F:  LDA $04B0
LBC22:  BEQ $BC8D
LBC24:  BMI $BC03
LBC26:  DEC $04B1
LBC29:  BNE $BC8D
LBC2B:  LDY $04B2
LBC2E:  LDA $04B3
LBC31:  STA $E0
LBC33:  LDA $04B4
LBC36:  STA $E1
LBC38:  LDA ($E0),Y
LBC3A:  INC $04B2
LBC3D:  TAX
LBC3E:  BPL $BC4B
LBC40:  LSR
LBC41:  LDA #$01
LBC43:  BCS $BC49
LBC45:  LDA #$18
LBC47:  STA $F4
LBC49:  STA $F0
LBC4B:  TXA
LBC4C:  AND #$70
LBC4E:  LSR
LBC4F:  LSR
LBC50:  LSR
LBC51:  LSR
LBC52:  BNE $BC57
LBC54:  STA $04B0
LBC57:  STA $04B1
LBC5A:  TXA
LBC5B:  AND #$0E
LBC5D:  BNE $BC63
LBC5F:  CLC
LBC60:  ADC #$01
LBC62:  ASL
LBC63:  TAY
LBC64:  LDX #$0E
LBC66:  JSR $BF9E
LBC69:  LDA ($E0),Y
LBC6B:  INY
LBC6C:  TAX
LBC6D:  LDA ($E0),Y
LBC6F:  STA $E1
LBC71:  STX $E0
LBC73:  LDY #$00
LBC75:  LDA ($E0),Y
LBC77:  INY
LBC78:  TAX
LBC79:  LDA ($E0),Y
LBC7B:  INY
LBC7C:  STA ThisBkgPalette,X
LBC7F:  INX
LBC80:  CPX #$13
LBC82:  BEQ $BC88
LBC84:  CPX #$1B
LBC86:  BNE $BC79
LBC88:  LDA #PAL_UPDATE
LBC8A:  STA UpdatePalFlag
LBC8D:  RTS
LBC8E:  JSR $AF2E
LBC91:  JSR $C0F2
LBC94:  LDA #$25
LBC96:  STA PPUIOReg
LBC99:  LDA RoundTimerUB        ;($0306)
LBC9C:  AND #$F0
LBC9E:  LSR
LBC9F:  LSR
LBCA0:  LSR
LBCA1:  TAY
LBCA2:  LDA $BCB0,Y
LBCA5:  STA PPUIOReg
LBCA8:  INY
LBCA9:  LDA $BCB0,Y
LBCAC:  STA PPUIOReg
LBCAF:  RTS

LBCB0:  .byte $01, $01, $03, $06, $05, $09, $07, $02, $09, $03, $0A, $08, $0A, $0A

LBCBE:  JSR LoadPRGBank09       ;($AA5C)
LBCC1:  LDX #$00
LBCC3:  JSR $BF9E
LBCC6:  LDY $05CD
LBCC9:  LDA ($E0),Y
LBCCB:  TAX
LBCCC:  INY
LBCCD:  LDA ($E0),Y
LBCCF:  STA $E1
LBCD1:  STX $E0
LBCD3:  LDA #$10
LBCD5:  STA $E2
LBCD7:  LDX #$00
LBCD9:  LDY #$00
LBCDB:  LDA ($E0),Y
LBCDD:  STA $06E0,X
LBCE0:  INY
LBCE1:  INX
LBCE2:  DEC $E2
LBCE4:  BNE $BCDB
LBCE6:  LDA ($E0),Y
LBCE8:  TAX
LBCE9:  INY
LBCEA:  LDA ($E0),Y
LBCEC:  STA $E1
LBCEE:  STX $E0
LBCF0:  LDY #$00
LBCF2:  JSR $BEED
LBCF5:  LDA #$0B
LBCF7:  LDY #$0A
LBCF9:  LDX #$0D
LBCFB:  JSR $BEC9
LBCFE:  LDA #PAL_UPDATE
LBD00:  STA UpdatePalFlag
LBD03:  LDA #$00
LBD05:  STA $D000
LBD08:  LDA $06EE
LBD0B:  STA $E000
LBD0E:  LDA #$05
LBD10:  STA $B000
LBD13:  LDA $06EF
LBD16:  STA $C000
LBD19:  STA $A9
LBD1B:  LDA #$01
LBD1D:  JSR $C105
LBD20:  LDX OppKDFight          ;($03D1)
LBD23:  CPX #$02
LBD25:  BCC $BD2C
LBD27:  LDA #$02
LBD29:  JSR $C105
LBD2C:  LDA #$03
LBD2E:  JSR $C105
LBD31:  LDA #$00
LBD33:  STA OppBaseAnimIndex
LBD35:  JSR $C85C
LBD38:  LDA #$02
LBD3A:  STA OppBaseAnimIndex
LBD3C:  JSR $C85C
LBD3F:  JMP LoadPRGBank0C       ;($AA64)
LBD42:  JSR $BF3C
LBD45:  LDX #$00
LBD47:  LDA #$00
LBD49:  JSR $BF55
LBD4C:  LDX #$06
LBD4E:  JSR $BF9E
LBD51:  LDY #$20
LBD53:  STY $E2
LBD55:  LDX #$00
LBD57:  JSR $BEE1
LBD5A:  LDA #PAL_UPDATE
LBD5C:  STA UpdatePalFlag
LBD5F:  LDA #$FD
LBD61:  JSR $BFAE
LBD64:  LDX #$23
LBD66:  LDY #$C0
LBD68:  JSR $AF2E
LBD6B:  LDA #$00
LBD6D:  LDX #$40
LBD6F:  STA PPUIOReg
LBD72:  DEX
LBD73:  BNE $BD6F
LBD75:  JSR $AEA5

LBD78:  LDA #SPRT_BKG_ON        ;Enable sprites and background.
LBD7A:  STA SprtBkgUpdt         ;

LBD7C:  LDA #$FF
LBD7E:  STA GameStatus
LBD80:  LDA #$1A
LBD82:  STA MusicInit
LBD84:  JSR $AF02
LBD87:  LDA #$F6
LBD89:  JSR $BDA2
LBD8C:  LDA #$F7
LBD8E:  JSR $BDA2
LBD91:  JSR $ADC5
LBD94:  LDA #$80
LBD96:  STA MusicInit
LBD98:  JMP $BF7E
LBD9B:  LDA #$FF
LBD9D:  STA GameStatus
LBD9F:  JMP $AF02
LBDA2:  STA $04B0
LBDA5:  JSR $AF02
LBDA8:  JSR $BE09
LBDAB:  LDA $04B0
LBDAE:  BNE $BDA5
LBDB0:  RTS
LBDB1:  LDY #$00
LBDB3:  BEQ $BDB7
LBDB5:  LDY #$01
LBDB7:  LDA $06C0
LBDBA:  ROL
LBDBB:  LDA $06C0
LBDBE:  ROL
LBDBF:  STA $06C0
LBDC2:  BCC $BE08
LBDC4:  TYA
LBDC5:  BEQ $BDF3
LBDC7:  LDA $0204
LBDCA:  CMP #$F0
LBDCC:  BCS $BDD6
LBDCE:  SEC
LBDCF:  SBC $06C1
LBDD2:  BCS $BDD6
LBDD4:  LDA #$00
LBDD6:  STA $0204
LBDD9:  LDY #$08
LBDDB:  LDA $0200,Y
LBDDE:  CMP #$F0
LBDE0:  BCS $BDED
LBDE2:  SEC
LBDE3:  SBC $06C1
LBDE6:  BCS $BDEA
LBDE8:  LDA #$F8
LBDEA:  STA $0200,Y
LBDED:  INY
LBDEE:  INY
LBDEF:  INY
LBDF0:  INY
LBDF1:  BNE $BDDB
LBDF3:  LDA $20
LBDF5:  CLC
LBDF6:  ADC $06C1
LBDF9:  CMP $06C2
LBDFC:  BCC $BE02
LBDFE:  LDX #$01
LBE00:  STX $15
LBE02:  STA $20
LBE04:  LDA #$01
LBE06:  STA $17
LBE08:  RTS
LBE09:  JSR LoadPRGBank0A       ;($AA60)
LBE0C:  LDA $04B0
LBE0F:  BEQ $BE14
LBE11:  JMP $8000
LBE14:  RTS
LBE15:  LDA #$01
LBE17:  STA $17
LBE19:  RTS
LBE1A:  LDX #$08
LBE1C:  LDA $0201,X
LBE1F:  BEQ $BE2B
LBE21:  CMP #$01
LBE23:  BEQ $BE19
LBE25:  INX
LBE26:  INX
LBE27:  INX
LBE28:  INX
LBE29:  BNE $BE1C
LBE2B:  DEC $0202,X
LBE2E:  BNE $BE25
LBE30:  LDA $0203,X
LBE33:  TAY
LBE34:  AND #$F0
LBE36:  LSR
LBE37:  STA $0202,X
LBE3A:  LSR
LBE3B:  LSR
LBE3C:  LSR
LBE3D:  STA $E7
LBE3F:  TYA
LBE40:  ASL
LBE41:  ASL
LBE42:  ASL
LBE43:  ASL
LBE44:  ORA $E7
LBE46:  STA $0203,X
LBE49:  INX
LBE4A:  INX
LBE4B:  INX
LBE4C:  INX
LBE4D:  LDA $0201,X
LBE50:  CMP #$02
LBE52:  BCC $BE15
LBE54:  LDY $0202,X
LBE57:  BMI $BE61
LBE59:  EOR #$FF
LBE5B:  STA $0201,X
LBE5E:  JMP $BE49
LBE61:  LDA $0200,X
LBE64:  CMP #$F0
LBE66:  BCS $BE83
LBE68:  STA $E7
LBE6A:  LSR
LBE6B:  ORA #$F0
LBE6D:  STA $0200,X
LBE70:  LDA $E7
LBE72:  AND #$E0
LBE74:  LSR
LBE75:  LSR
LBE76:  LSR
LBE77:  STA $E7
LBE79:  TYA
LBE7A:  AND #$E3
LBE7C:  ORA $E7
LBE7E:  STA $0202,X
LBE81:  BNE $BE49
LBE83:  AND #$0F
LBE85:  ASL
LBE86:  STA $E7
LBE88:  TYA
LBE89:  AND #$1C
LBE8B:  ASL
LBE8C:  ASL
LBE8D:  ASL
LBE8E:  ORA $E7
LBE90:  STA $0200,X
LBE93:  JMP $BE49
LBE96:  JSR $AF2E
LBE99:  LDA #$70
LBE9B:  STA $E0
LBE9D:  LDA #$01
LBE9F:  STA $E1
LBEA1:  LDY #$00
LBEA3:  JSR $BEB3
LBEA6:  LDA #$28
LBEA8:  STA PPUIOReg
LBEAB:  JSR $BEB3
LBEAE:  LDA #$FF
LBEB0:  STA PPUIOReg
LBEB3:  CLC
LBEB4:  LDA ($E0),Y
LBEB6:  BNE $BEBA
LBEB8:  LDA #$FE
LBEBA:  INY
LBEBB:  ADC #$01
LBEBD:  STA PPUIOReg
LBEC0:  LDA ($E0),Y
LBEC2:  INY
LBEC3:  ADC #$01
LBEC5:  STA PPUIOReg
LBEC8:  RTS
LBEC9:  STA $E2
LBECB:  LDA $06E0,Y
LBECE:  STA $E0
LBED0:  LDA $06E1,Y
LBED3:  STA $E1
LBED5:  LDY #$00
LBED7:  BEQ $BEE1
LBED9:  LDX #$00
LBEDB:  LDY #$00
LBEDD:  LDA #$20
LBEDF:  STA $E2
LBEE1:  LDA ($E0),Y
LBEE3:  STA ThisBkgPalette,X
LBEE6:  INY
LBEE7:  INX
LBEE8:  DEC $E2
LBEEA:  BNE $BEE1
LBEEC:  RTS
LBEED:  LDA ($E0),Y
LBEEF:  CMP #$FF
LBEF1:  BEQ $BEFE
LBEF3:  INY
LBEF4:  TAX
LBEF5:  LDA ($E0),Y
LBEF7:  INY
LBEF8:  JSR $BEFF
LBEFB:  JMP $BEED
LBEFE:  RTS
LBEFF:  STA $E2
LBF01:  LDA ($E0),Y
LBF03:  STA $0200,X
LBF06:  INY
LBF07:  INX
LBF08:  DEC $E2
LBF0A:  BNE $BF01
LBF0C:  RTS
LBF0D:  STA OppBaseAnimIndex
LBF0F:  STX $06B1
LBF12:  LDA OppBaseAnimIndex
LBF14:  JSR $C850
LBF17:  INC OppBaseAnimIndex
LBF19:  INC OppBaseAnimIndex
LBF1B:  DEC $06B1
LBF1E:  BNE $BF12
LBF20:  RTS
LBF21:  STA $06B0
LBF24:  STX $06B1
LBF27:  LDA $06B0
LBF2A:  JSR $C113
LBF2D:  INC $06B0
LBF30:  DEC $06B1
LBF33:  BNE $BF27
LBF35:  RTS
LBF36:  JSR $AA06
LBF39:  JMP $BF3F
LBF3C:  JSR $AA0A
LBF3F:  JSR $AF02
LBF42:  LDA #$02
LBF44:  STA GameStatus
LBF46:  JSR $AE9B
LBF49:  JSR $AF38
LBF4C:  LDA #$00
LBF4E:  STA OppBaseXSprite
LBF50:  STA OppBaseYSprite
LBF52:  JMP LoadPRGBank0C       ;($AA64)
LBF55:  STA $E000
LBF58:  LDA #$00
LBF5A:  STA $D000
LBF5D:  STX $B000
LBF60:  STX $C000
LBF63:  STX $A9
LBF65:  RTS
LBF66:  STX $E0
LBF68:  LDX #$05
LBF6A:  STA $0413,Y
LBF6D:  INY
LBF6E:  DEX
LBF6F:  BNE $BF6A
LBF71:  TAX
LBF72:  LDA #$00
LBF74:  STA $0413,Y
LBF77:  INY
LBF78:  TXA
LBF79:  DEC $E0
LBF7B:  BNE $BF68
LBF7D:  RTS
LBF7E:  LDA #$40
LBF80:  STA $04C8
LBF83:  JSR $AF02
LBF86:  LDA $04C8
LBF89:  BNE $BF83
LBF8B:  LDA #$08
LBF8D:  JSR $AF04

LBF90:  LDA #SPRT_BKG_OFF       ;Disable sprites and background.
LBF92:  STA SprtBkgUpdt         ;

LBF94:  LDA #$08
LBF96:  JMP $AF04

Div16:
LBF99:  LSR                     ;
LBF9A:  LSR                     ;Divide by 16. Move upper nibble to lower nibble.
LBF9B:  LSR                     ;
LBF9C:  LSR                     ;
LBF9D:  RTS                     ;

LBF9E:  LDA $8000,X
LBFA1:  STA $E0
LBFA3:  INX
LBFA4:  LDA $8000,X
LBFA7:  STA $E1
LBFA9:  RTS
LBFAA:  LDY #$28
LBFAC:  BNE $BFB4
LBFAE:  LDY #$20
LBFB0:  BNE $BFB4
LBFB2:  LDY #$24
LBFB4:  LDX PPUStatus
LBFB7:  STY PPUAddress
LBFBA:  LDX #$00
LBFBC:  STX PPUAddress
LBFBF:  LDY #$04
LBFC1:  STA PPUIOReg
LBFC4:  DEX
LBFC5:  BNE $BFC1
LBFC7:  DEY
LBFC8:  BNE $BFC1
LBFCA:  RTS
LBFCB:  LDY #$B0
LBFCD:  LDA #$12
LBFCF:  BNE $BFF6
LBFD1:  LDY #$B0
LBFD3:  LDA #$0C
LBFD5:  JSR $BFF6
LBFD8:  LDA #$27
LBFDA:  STA $0411,X
LBFDD:  INX
LBFDE:  LDA #$00
LBFE0:  STA $0411,X
LBFE3:  INX
LBFE4:  STA $0411,X
LBFE7:  LDA #$23
LBFE9:  STA $0411
LBFEC:  LDA #$4B
LBFEE:  STA $0412
LBFF1:  RTS
LBFF2:  LDY #$53
LBFF4:  LDA #$1B
LBFF6:  STA $E2
LBFF8:  JSR LoadPRGBank0C       ;($AA64)
LBFFB:  LDX #$06
LBFFD:  JSR $BF9E
LC000:  LDX #$00
LC002:  LDA ($E0),Y
LC004:  STA $0411,X
LC007:  INY
LC008:  INX
LC009:  DEC $E2
LC00B:  BNE $C002
LC00D:  LDA #$81
LC00F:  STA $0410
LC012:  RTS
LC013:  LDA #$00
LC015:  STA $06DE
LC018:  JSR $A06F
LC01B:  JSR $AF02
LC01E:  JSR $A03A
LC021:  LDA $06DB
LC024:  BPL $C040
LC026:  LDA $06DC
LC029:  STA $E7
LC02B:  LDX #$3C
LC02D:  SEC
LC02E:  LDA $026F,X
LC031:  SBC $E7
LC033:  STA $026F,X
LC036:  DEX
LC037:  DEX
LC038:  DEX
LC039:  DEX
LC03A:  BPL $C02D
LC03C:  LDA #$81
LC03E:  STA $17
LC040:  RTS
LC041:  LDA PPUStatus
LC044:  LDX #$00
LC046:  LDA $0394
LC049:  BPL $C05F
LC04B:  LDA #$20
LC04D:  STA PPUAddress
LC050:  LDA $0395
LC053:  STA PPUAddress
LC056:  LDA $0396
LC059:  STA PPUIOReg
LC05C:  STX $0394
LC05F:  LDA $039B
LC062:  BPL $C078
LC064:  LDA #$20
LC066:  STA PPUAddress
LC069:  LDA $039C
LC06C:  STA PPUAddress
LC06F:  LDA $039D
LC072:  STA PPUIOReg
LC075:  STX $039B
LC078:  RTS
LC079:  LDA PPUStatus
LC07C:  LDA HeartDispStatus     ;($0325)
LC07F:  BPL $C09C
LC081:  LDA #$24
LC083:  STA PPUAddress
LC086:  LDA #$7D
LC088:  STA PPUAddress
LC08B:  LDA HeartDisplayUD      ;($0326)
LC08E:  STA PPUIOReg
LC091:  LDA HeartDisplayLD      ;($0327)
LC094:  STA PPUIOReg
LC097:  LDA #$00
LC099:  STA HeartDispStatus     ;($0325)
LC09C:  RTS
LC09D:  LDA PPUStatus
LC0A0:  LDA $0349
LC0A3:  BPL $C0BA
LC0A5:  LDA #$24
LC0A7:  STA PPUAddress
LC0AA:  LDA #$7A
LC0AC:  STA PPUAddress
LC0AF:  LDA $034A
LC0B2:  STA PPUIOReg
LC0B5:  LDA #$00
LC0B7:  STA $0349
LC0BA:  RTS
LC0BB:  LDA PPUStatus
LC0BE:  LDA $03F0
LC0C1:  BPL $C0DF
LC0C3:  LDA #$20
LC0C5:  STA PPUAddress
LC0C8:  LDA #$88
LC0CA:  STA PPUAddress
LC0CD:  LDX #$00
LC0CF:  LDA $03F1,X
LC0D2:  STA PPUIOReg
LC0D5:  INX
LC0D6:  CPX #$06
LC0D8:  BNE $C0CF
LC0DA:  LDA #$00
LC0DC:  STA $03F0
LC0DF:  RTS
LC0E0:  LDA PPUStatus
LC0E3:  LDA ClockDispStatus     ;($030A)
LC0E6:  BPL $C104
LC0E8:  LDA #$20
LC0EA:  STA PPUAddress
LC0ED:  LDA #$70
LC0EF:  STA PPUAddress
LC0F2:  LDX #$00
LC0F4:  LDA ClockDisplay,X      ;($030B)
LC0F7:  STA PPUIOReg
LC0FA:  INX
LC0FB:  CPX #$04
LC0FD:  BNE $C0F4
LC0FF:  LDA #$00
LC101:  STA ClockDispStatus     ;($030A)
LC104:  RTS
LC105:  ASL
LC106:  TAY
LC107:  LDX $06E0
LC10A:  STX $E0
LC10C:  LDX $06E1
LC10F:  STX $E1
LC111:  BNE $C11F

LC113:  LDX #$02
LC115:  BNE $C11A
LC117:  RTS
LC118:  LDX #$00
LC11A:  ASL
LC11B:  TAY
LC11C:  JSR $BF9E
LC11F:  LDA ($E0),Y
LC121:  INY
LC122:  STA $E2
LC124:  LDA ($E0),Y
LC126:  STA $E3
LC128:  LDY #$00
LC12A:  LDA ($E2),Y
LC12C:  INY
LC12D:  TAX
LC12E:  LDA PPUStatus
LC131:  LDA ($E2),Y
LC133:  INY
LC134:  STA PPUAddress
LC137:  STA $EF
LC139:  STX PPUAddress
LC13C:  STX $EE
LC13E:  STY $E4
LC140:  LDY $E4
LC142:  LDA ($E2),Y
LC144:  BEQ $C117
LC146:  INY
LC147:  LDA ($E2),Y
LC149:  INY
LC14A:  STA $E5
LC14C:  LDA ($E2),Y
LC14E:  INY
LC14F:  STA $E6
LC151:  STY $E4
LC153:  LDY #$00
LC155:  LDA ($E5),Y
LC157:  BEQ $C140
LC159:  AND #$0F
LC15B:  TAX
LC15C:  LDA ($E5),Y
LC15E:  INY
LC15F:  AND #$F0
LC161:  BEQ $C16D
LC163:  BMI $C1B7
LC165:  CMP #$50
LC167:  BEQ $C186
LC169:  BCS $C19F
LC16B:  BCC $C17B
LC16D:  LDA ($E5),Y
LC16F:  INY
LC170:  CLC
LC171:  STA PPUIOReg
LC174:  ADC #$01
LC176:  DEX
LC177:  BNE $C171
LC179:  BEQ $C155
LC17B:  LDA ($E5),Y
LC17D:  INY
LC17E:  STA PPUIOReg
LC181:  DEX
LC182:  BNE $C17B
LC184:  BEQ $C155
LC186:  LDA ($E5),Y
LC188:  INY
LC189:  STA $E1
LC18B:  LDA ($E5),Y
LC18D:  DEY
LC18E:  CLC
LC18F:  STA PPUIOReg
LC192:  ADC #$01
LC194:  DEC $E1
LC196:  BNE $C18F
LC198:  DEX
LC199:  BNE $C186
LC19B:  INY
LC19C:  INY
LC19D:  BNE $C155
LC19F:  STY $E7
LC1A1:  LDY $E7
LC1A3:  LDA ($E5),Y
LC1A5:  INY
LC1A6:  STA $E1
LC1A8:  LDA ($E5),Y
LC1AA:  INY
LC1AB:  STA PPUIOReg
LC1AE:  DEC $E1
LC1B0:  BNE $C1A8
LC1B2:  DEX
LC1B3:  BNE $C1A1
LC1B5:  BEQ $C155
LC1B7:  CMP #$90
LC1B9:  BCC $C1C3
LC1BB:  BEQ $C209
LC1BD:  CMP #$F0
LC1BF:  BEQ $C23A
LC1C1:  BNE $C229
LC1C3:  LDA ($E5),Y
LC1C5:  AND #$F0
LC1C7:  CMP #$80
LC1C9:  BNE $C1D8
LC1CB:  LDA ($E5),Y
LC1CD:  INY
LC1CE:  AND #$0F
LC1D0:  STX $E7
LC1D2:  CLC
LC1D3:  ADC $E7
LC1D5:  TAX
LC1D6:  BNE $C1C3
LC1D8:  LDA PPU0Load
LC1DA:  AND #$04
LC1DC:  BNE $C1ED
LC1DE:  TXA
LC1DF:  CLC
LC1E0:  ADC $EE
LC1E2:  LDX $EF
LC1E4:  STX PPUAddress
LC1E7:  STA PPUAddress
LC1EA:  JMP $C155
LC1ED:  TXA
LC1EE:  ASL
LC1EF:  ASL
LC1F0:  ASL
LC1F1:  ASL
LC1F2:  ASL
LC1F3:  CLC
LC1F4:  ADC $EE
LC1F6:  BCC $C1FA
LC1F8:  INC $EF
LC1FA:  STA $E7
LC1FC:  TXA
LC1FD:  LSR
LC1FE:  LSR
LC1FF:  LSR
LC200:  CLC
LC201:  ADC $EF
LC203:  TAX
LC204:  LDA $E7
LC206:  JMP $C1E4
LC209:  LDA PPU0Load
LC20B:  LDX #$01
LC20D:  AND #$04
LC20F:  BNE $C213
LC211:  LDX #$20
LC213:  TXA
LC214:  CLC
LC215:  ADC $EE
LC217:  TAX
LC218:  STA $EE
LC21A:  BCC $C21E
LC21C:  INC $EF
LC21E:  LDA $EF
LC220:  STA PPUAddress
LC223:  STX PPUAddress
LC226:  JMP $C155
LC229:  TXA
LC22A:  BNE $C22E
LC22C:  LDX #$20
LC22E:  LDA ($E5),Y
LC230:  INY
LC231:  STA PPUIOReg
LC234:  DEX
LC235:  BNE $C231
LC237:  JMP $C155
LC23A:  TXA
LC23B:  BNE $C23F
LC23D:  LDX #$20
LC23F:  LDA #$FF
LC241:  STA PPUIOReg
LC244:  DEX
LC245:  BNE $C241
LC247:  JMP $C155
LC24A:  LDX #$00
LC24C:  STX $0410
LC24F:  BEQ $C254
LC251:  INC $0412
LC254:  LDA $0411
LC257:  STA PPUAddress
LC25A:  LDA $0412
LC25D:  STA PPUAddress
LC260:  LDA $0413,X
LC263:  BEQ $C274
LC265:  INX
LC266:  STA PPUIOReg
LC269:  LDA $0413,X
LC26C:  BEQ $C274
LC26E:  INX
LC26F:  STA PPUIOReg
LC272:  BNE $C260
LC274:  INX
LC275:  LDA $0413,X
LC278:  BNE $C251
LC27A:  RTS
LC27B:  LDX $AC
LC27D:  BMI $C28E
LC27F:  LDA #$00
LC281:  STA $04FE
LC284:  STA $AC
LC286:  LDA $04FF
LC289:  ORA #$80
LC28B:  STA $04FF
LC28E:  JMP $C2F7
LC291:  LDA OppCurState
LC293:  BEQ $C2F9
LC295:  CMP #$81
LC297:  BEQ $C27B
LC299:  CMP #$01
LC29B:  BNE $C2F7
LC29D:  LDX VulnerableTimer
LC2A0:  BNE $C2E5
LC2A2:  LDA $AC
LC2A4:  BEQ $C2F7
LC2A6:  BMI $C2F7
LC2A8:  LDX $04FE
LC2AB:  BNE $C2CF
LC2AD:  LDA MacStatus           ;($50)
LC2AF:  AND #$7F
LC2B1:  CMP #$01
LC2B3:  BNE $C2F7
LC2B5:  JSR $C3CA
LC2B8:  BEQ $C2F7
LC2BA:  LDA $05BC
LC2BD:  BMI $C2C7
LC2BF:  STA $04FE
LC2C2:  JSR $C3C1
LC2C5:  BNE $C2F7
LC2C7:  LDA ReactTimer
LC2CA:  STA VulnerableTimer
LC2CD:  BNE $C2F7
LC2CF:  DEX
LC2D0:  STX $04FE
LC2D3:  JSR $C3CA
LC2D6:  BEQ $C2F7
LC2D8:  LDA ReactTimer
LC2DB:  STA VulnerableTimer
LC2DE:  LDA #$00
LC2E0:  STA $04FE
LC2E3:  BEQ $C2F7
LC2E5:  DEX
LC2E6:  CPX #$80
LC2E8:  BNE $C2EC
LC2EA:  LDX #$00
LC2EC:  STX VulnerableTimer
LC2EF:  LDA VulnerableTimer
LC2F2:  BNE $C2F7
LC2F4:  JSR $C3C1
LC2F7:  LDA $99
LC2F9:  BEQ $C318
LC2FB:  STA $E5
LC2FD:  LDY #$00
LC2FF:  STY $99
LC301:  STY $E7

LC303:  LDA VulnerableTimer
LC306:  BEQ $C319
LC308:  BMI $C318

LC30A:  LDX $05BA
LC30D:  CMP $05B9
LC310:  BCS $C315
LC312:  LDX $05BB
LC315:  STX VulnerableTimer
LC318:  RTS

LC319:  LDA OppPunching
LC31B:  BNE $C318
LC31D:  LDA ComboTimer
LC31F:  BNE $C318
LC321:  LDX MacPunchType
LC323:  LDA $0348
LC326:  BNE $C32B
LC328:  TXA
LC329:  BMI $C33D
LC32B:  LDA SpecialKD           ;($03CB)
LC32E:  CMP #$01
LC330:  BNE $C336
LC332:  TXA
LC333:  BPL $C342
LC335:  RTS
LC336:  CMP #$07
LC338:  BNE $C342
LC33A:  TXA
LC33B:  BPL $C341
LC33D:  LDA #$83
LC33F:  STA OppCurState
LC341:  RTS
LC342:  TXA
LC343:  BPL $C349
LC345:  LDA #$89
LC347:  BNE $C33F
LC349:  AND #$02
LC34B:  TAX
LC34C:  EOR #$02
LC34E:  LSR
LC34F:  STA $E6
LC351:  LDA $E5
LC353:  BPL $C369
LC355:  AND #$7F
LC357:  AND $058A
LC35A:  BEQ $C369
LC35C:  LDA $058B
LC35F:  JSR $AECE
LC362:  BCC $C369
LC364:  LDA $058C
LC367:  BNE $C33F
LC369:  LDA $AC
LC36B:  BMI $C380
LC36D:  LDA OppCurState
LC36F:  AND #$7F
LC371:  CMP #$01
LC373:  BNE $C380
LC375:  LDA $04FF
LC378:  AND #$7F
LC37A:  CMP $E6
LC37C:  BNE $C380
LC37E:  INC $E7
LC380:  TXA
LC381:  BEQ $C3A2
LC383:  LDA $E7
LC385:  BNE $C38F
LC387:  LDA $0587
LC38A:  JSR $AECE
LC38D:  BCC $C341
LC38F:  LDA $0589
LC392:  AND #$7F
LC394:  JSR $AEC8
LC397:  BCC $C39D
LC399:  LDA #$01
LC39B:  STA $AB
LC39D:  LDA #$89
LC39F:  JMP $B42C
LC3A2:  LDA $E7
LC3A4:  BNE $C3AE
LC3A6:  LDA $0586
LC3A9:  JSR $AECE
LC3AC:  BCC $C341
LC3AE:  LDA $0588
LC3B1:  BMI $C392
LC3B3:  JSR $AEC8
LC3B6:  BCC $C3BC
LC3B8:  LDA #$80
LC3BA:  STA $AB
LC3BC:  LDA #$83
LC3BE:  JMP $B424
LC3C1:  JSR $C3CA
LC3C4:  ORA #$80
LC3C6:  STA $04FF
LC3C9:  RTS
LC3CA:  LDA $04FF
LC3CD:  AND #$7F
LC3CF:  STA $E7
LC3D1:  LDA DPad1Status         ;($D2)
LC3D3:  LSR
LC3D4:  LSR
LC3D5:  LSR
LC3D6:  CMP $E7
LC3D8:  RTS
LC3D9:  RTS

LC3DA:  LDA $DD
LC3DC:  BPL $C410

LC3DE:  LDA $DC
LC3E0:  AND #$0C
LC3E2:  BEQ $C3FB

LC3E4:  CMP #$08
LC3E6:  BNE $C3F0

LC3E8:  SEC
LC3E9:  LDA OppBaseYSprite
LC3EB:  SBC #$01
LC3ED:  JMP $C3F5
LC3F0:  CLC
LC3F1:  LDA OppBaseYSprite
LC3F3:  ADC #$01
LC3F5:  STA OppBaseYSprite

LC3F7:  LDA #OPP_CHNG_POS
LC3F9:  STA OppAnimFlags

LC3FB:  LDA $DC
LC3FD:  AND #$03
LC3FF:  BEQ $C410
LC401:  CMP #$01
LC403:  BEQ $C40A
LC405:  DEC OppBaseXSprite
LC407:  JMP $C40C
LC40A:  INC OppBaseXSprite

LC40C:  LDA #OPP_CHNG_POS
LC40E:  STA OppAnimFlags

LC410:  LDA $DF
LC412:  BPL $C439
LC414:  TAY
LC415:  LDA $DE
LC417:  AND #$C0
LC419:  BEQ $C439
LC41B:  TAX
LC41C:  LDA OppAnimFlags
LC41E:  BMI $C439
LC420:  TYA
LC421:  AND #$01
LC423:  STA $DF
LC425:  TXA
LC426:  BPL $C43A
LC428:  LDA OppBaseAnimIndex
LC42A:  CLC
LC42B:  ADC #$02
LC42D:  CMP #$3C
LC42F:  BCC $C433
LC431:  LDA #$00
LC433:  STA OppBaseAnimIndex
LC435:  LDA #OPP_CHNG_SPRT
LC437:  STA OppAnimFlags
LC439:  RTS

LC43A:  LDA #$01
LC43C:  STA $A2
LC43E:  BNE $C435

;----------------------------------------------------------------------------------------------------

SetOppOutlineClr:
LC440:  LDA OppOutlineTimer     ;Is outline color timer active?
LC442:  BEQ OppOutlineEnd       ;If not, branch to exit.

LC444:  BMI SetOutlineTimer     ;Does ouotline color timer need to be initialized? If so, branch.

LC446:  DEC OppOutlineTimer     ;Decrement outline color timer. Has timer expired?
LC448:  BNE OppOutlineEnd       ;If not, branch to exit.

LC44A:  LDY #$01                ;Prepare to set normal outline color.
LC44C:  BNE PrepOutlineWrite    ;Branch always.

SetOutlineTimer:
LC44E:  AND #$7F                ;Clear MSB to indicate timer is running.
LC450:  STA OppOutlineTimer     ;Set outline color timer.
LC452:  LDY #$00                ;Prepare to set dodge indicator outline color.

PrepOutlineWrite:
LC454:  LDA OppOutline,Y        ;Get opponent outline color.
LC457:  LDX #$04                ;Prepare to change 4 sprite palette bytes.
LC459:  LDY #$03                ;Base index of palette bytes.

LoadDodgeClrLoop:
LC45B:  STA ThisSprtPalette,Y   ;Change byte of palette color.

LC45E:  INY                     ;
LC45F:  INY                     ;Increment to next palette.
LC460:  INY                     ;
LC461:  INY                     ;

LC462:  DEX                     ;Have all 4 palette bytes been changed?
LC463:  BNE LoadDodgeClrLoop    ;If not, branch to change another palette byte.

LC465:  LDA #PAL_UPDATE         ;Indicate the palettes need to be updated in the PPU.
LC467:  STA UpdatePalFlag       ;

OppOutlineEnd:
LC46A:  RTS                     ;End outline color change.

;----------------------------------------------------------------------------------------------------

LC46B:  AND #$7F
LC46D:  STA OppCurState
LC46F:  LDA #STAT_ACTIVE
LC471:  ORA OppStateStatus
LC473:  STA OppStateStatus
LC475:  LDY #$92
LC477:  LDX #$09
LC479:  JSR $AEF8
LC47C:  LDY #$B4
LC47E:  LDX #$06
LC480:  JSR $AEF8
LC483:  INX
LC484:  STX OppOutlineTimer
LC486:  STA $AF
LC488:  INC OppStateTimer
LC48A:  STA $5A
LC48C:  STA $AF
LC48E:  JSR PushFightBank       ;($AA48)
LC491:  LDY FightOffset         ;($03)
LC493:  LDA OppCurState
LC495:  CMP #$40
LC497:  BCS $C4A6
LC499:  TAX
LC49A:  LDA $8002,Y
LC49D:  STA $E0
LC49F:  LDA $8003,Y
LC4A2:  STA $E1
LC4A4:  BNE $C4B3
LC4A6:  SBC #$40
LC4A8:  TAX
LC4A9:  LDA $8004,Y
LC4AC:  STA $E0
LC4AE:  LDA $8005,Y
LC4B1:  STA $E1
LC4B3:  TXA
LC4B4:  ASL
LC4B5:  TAY
LC4B6:  LDA ($E0),Y
LC4B8:  STA OppStBasePtrLB
LC4BA:  INY
LC4BB:  LDA ($E0),Y
LC4BD:  STA OppStBasePtrUB
LC4BF:  LDA OppCurState
LC4C1:  CMP #$01
LC4C3:  BNE $C4E7
LC4C5:  LDA #$00
LC4C7:  STA $BA
LC4C9:  LDA $04FF
LC4CC:  AND #$7F
LC4CE:  STA $04FF
LC4D1:  LDA $05CC
LC4D4:  BEQ $C4E0
LC4D6:  LDA PPU0Load
LC4D8:  ORA #$20
LC4DA:  LDX #$10
LC4DC:  STA PPU0Load
LC4DE:  STX $80
LC4E0:  LDA #$0A
LC4E2:  BNE $C50E
LC4E4:  JMP $C46B
LC4E7:  LDA OppCurState
LC4E9:  BEQ $C54F
LC4EB:  BMI $C4E4
LC4ED:  LDX ComboTimer
LC4EF:  BEQ $C4FA
LC4F1:  DEX
LC4F2:  BNE $C4F8
LC4F4:  STX ComboCountDown
LC4F6:  STX $4C
LC4F8:  STX ComboTimer
LC4FA:  DEC OppStateTimer
LC4FC:  BNE $C54F
LC4FE:  CMP #$01
LC500:  BNE $C535
LC502:  LDA $04FF
LC505:  BPL $C535
LC507:  AND #$7F
LC509:  STA $04FF
LC50C:  LDA #$82
LC50E:  SEC
LC50F:  SBC $04FF
LC512:  SBC $04FF
LC515:  STA OppBaseAnimIndex

LC517:  LDA #OPP_CHNG_BOTH
LC519:  STA OppAnimFlags

LC51B:  JSR $C890
LC51E:  LDA $04FF
LC521:  ASL
LC522:  ASL
LC523:  TAY
LC524:  LDX #$00
LC526:  STX OppPunchSide
LC528:  STX OppPunchDamage

LC52A:  LDA $C828,Y
LC52D:  INY
LC52E:  STA OppHitDefense,X
LC530:  INX
LC531:  CPX #$04
LC533:  BNE $C52A

LC535:  INC OppStateTimer
LC537:  LDA $AF
LC539:  BEQ $C53E
LC53B:  JSR PushPRGBank06       ;($AA38)
LC53E:  LDA OppAnimSeg
LC540:  BEQ OppStateUpdate      ;($C550)Advance to the opponent's next state.

LC542:  DEC OppAnimSeg
LC544:  LDA OppAnimSegTimer
LC546:  STA OppStateTimer
LC548:  DEC OppStateIndex
LC54A:  LDY OppStateIndex
LC54C:  JMP $C5D6
LC54F:  RTS

;----------------------------[ Opponent State Machine Data Subroutines ]-----------------------------

;This function is the entry point for updating the opponent's state.  It uses the upper nibble of
;a control byte to pick a function to run from the table below.  The function it calls may then
;call another set of functions with the lower nibble of the same control byte(or it may not).

OppStateUpdate:
LC550:  LDY OppStateIndex       ;Get the control byte containing the function pointer index.
LC552:  LDA (OppStBasePtr),Y    ;

LC554:  INC OppStateIndex       ;Advance index to next state data byte.

LC556:  AND #$0F                ;Keep lower nibble for later.
LC558:  TAX                     ;

LC559:  LDA (OppStBasePtr),Y    ;Get next data byte from the state data.
LC55B:  INY                     ;

LC55C:  JSR Div16               ;($BF99)Shift upper nibble to lower nibble.
LC55F:  JSR IndFuncJump         ;($AED4)Indirect jump to desired function below.

LC562:  .word OppLoadSprites,  SpritesNxtXYState, $C5B3,           $C5B7
LC56A:  .word $C5C8,           $C5CE,             SprtMove,        OppMoveSprites
LC572:  .word OppSetTimer,     $C600,             OppBigMove,      OppStateUpdate1
LC57A:  .word OppStateUpdate1, OppStateUpdate1,   OppStateUpdate1, OppStateUpdate2

;----------------------------------------------------------------------------------------------------

ZeroByteInc:
LC582:  LDY OppStateIndex       ;Get next opponent state data byte.
LC584:  LDA (OppStBasePtr),Y    ;Is it zero?
LC586:  BNE ChngSpritesExit     ;If not, branch to exit. Valid state data.

LC588:  INC OppStateIndex       ;Increment past the zero byte.
LC58A:  BNE OppStateUpdate      ;($C550)Advance to the opponent's next state.

ChngSpritesExit:
LC58C:  RTS                     ;Done setting data to change opponent sprites.

OppLoadSprites:
LC58D:  STX OppStateTimer       ;Store the number of frames for the next animation.

LC58F:  LDA (OppStBasePtr),Y    ;Get the index for the next animation frame data.
LC591:  STA OppBaseAnimIndex    ;

LC593:  LDA #OPP_CHNG_SPRT      ;Indicate the opponent's sprites need to be changed.
LC595:  STA OppAnimFlags        ;

LC597:  INC OppStateIndex       ;Increment to next opponent state data byte.
LC599:  BNE ZeroByteInc         ;Should always branch.

;----------------------------------------------------------------------------------------------------

;This function is similar to the one above but it also provides new X and Y coordinates for the
;opponents new sprites.

SpritesNxtXYState:
LC59B:  STX OppStateTimer       ;Store the number of frames for the next animation.

LC59D:  LDA (OppStBasePtr),Y    ;
LC59F:  INY                     ;Get the index for the next animation frame data.
LC5A0:  STA OppBaseAnimIndex    ;

LC5A2:  LDA #OPP_CHNG_SPRT      ;Indicate the opponent's sprites need to be changed.
LC5A4:  STA OppAnimFlags        ;

OppXYPos:
LC5A6:  LDA (OppStBasePtr),Y    ;
LC5A8:  INY                     ;Get the data byte for the opponent's new X position.
LC5A9:  STA OppBaseXSprite      ;

LC5AB:  LDA (OppStBasePtr),Y    ;
LC5AD:  INY                     ;Get the data byte for the opponent's new Y position.
LC5AE:  STA OppBaseYSprite      ;

LC5B0:  STY OppStateIndex       ;Update the index to the next state data byte.
LC5B2:  RTS                     ;

;----------------------------------------------------------------------------------------------------

LC5B3:  STX OppStateTimer
LC5B5:  BNE OppXYPos

;----------------------------------------------------------------------------------------------------

LC5B7:  TXA
LC5B8:  JSR $AEAB
LC5BB:  BCC $C5C5

LC5BD:  LDA (OppStBasePtr),Y
LC5BF:  TAY

UpdateStateIndex4:
LC5C0:  STY OppStateIndex
LC5C2:  JMP OppStateUpdate      ;($C550)Advance to the opponent's next state.

LC5C5:  INY
LC5C6:  BNE UpdateStateIndex4

;----------------------------------------------------------------------------------------------------

LC5C8:  LDA #$01
LC5CA:  STA $A2
LC5CC:  BNE OppLoadSprites

;----------------------------------------------------------------------------------------------------

LC5CE:  LDA #$01
LC5D0:  STA $A2
LC5D2:  BNE $C59B

;----------------------------------------------------------------------------------------------------

SprtMove:
LC5D4:  STX OppStateTimer       ;Update the time for this sub-state.

SprtUpdateXY:
LC5D6:  LDA (OppStBasePtr),Y    ;Get X and Y movement values.
LC5D8:  INC OppStateIndex       ;

LC5DA:  LDX #OppBaseSprite      ;Prepare to update sprites X and Y positions.
LC5DC:  JSR UpdateMemPair       ;($C830)Update X and Y sprite positions.

LC5DF:  LDA #OPP_CHNG_POS       ;Indicate opponents sprites are moving.
LC5E1:  STA OppAnimFlags        ;

LC5E3:  JMP ZeroByteInc         ;($C582)Increment past zero data byte.

;----------------------------------------------------------------------------------------------------

;For the current opponent animation, they will move around on the screen.

OppMoveSprites:
LC5E6:  TXA                     ;
LC5E7:  AND #$03                ;
LC5E9:  CLC                     ;Frames per segment is bits 0,1 incremented by 1.
LC5EA:  ADC #$01                ;
LC5EC:  STA OppStateTimer       ;
LC5EE:  STA OppAnimSegTimer     ;

LC5F0:  TXA                     ;
LC5F1:  LSR                     ;
LC5F2:  LSR                     ;Number of movement segments is bits 2,3 incremented by 1.
LC5F3:  TAX                     ;
LC5F4:  INX                     ;
LC5F5:  STX OppAnimSeg          ;

LC5F7:  BNE SprtUpdateXY        ;Should branch always.

;----------------------------------------------------------------------------------------------------

OppSetTimer:
LC5F9:  LDA (OppStBasePtr),Y    ;
LC5FB:  INC OppStateIndex       ;Set the opponent's state timer to the value in the data table.
LC5FD:  STA OppStateTimer       ;
LC5FF:  RTS                     ;

;----------------------------------------------------------------------------------------------------

LC600:  STX $E0
LC602:  LDA (OppStBasePtr),Y
LC604:  STA $E1
LC606:  INY
LC607:  LDA (OppStBasePtr),Y
LC609:  STA $E2
LC60B:  INY
LC60C:  LDX #$00
LC60E:  LDA (OppStBasePtr),Y
LC610:  STA ($E1,X)
LC612:  INY
LC613:  INC $E1
LC615:  DEC $E0
LC617:  BNE $C60E
LC619:  STY OppStateIndex
LC61B:  JMP OppStateUpdate      ;($C550)Advance to the opponent's next state.

;----------------------------------------------------------------------------------------------------

OppBigMove:
LC61E:  STX OppStateTimer
LC620:  LDX #$00
LC622:  LDA OppBaseSprite,X
LC624:  SEC
LC625:  SBC $04D0,X
LC628:  JSR $C649

LC62B:  STA OppBaseSprite,X     ;($B0)
LC62D:  INX
LC62E:  CPX #$02
LC630:  BNE $C622

LC632:  LDX #$00
LC634:  LDA OppBaseSprite,X
LC636:  CMP $04D0,X
LC639:  BNE $C646

LC63B:  INX
LC63C:  CPX #$02
LC63E:  BNE $C634

LC640:  LDA (OppStBasePtr),Y
LC642:  TAY
LC643:  STY OppStateIndex
LC645:  RTS

LC646:  INY
LC647:  BNE $C643

LC649:  BPL $C660

LC64B:  EOR #$FF
LC64D:  CLC
LC64E:  ADC #$01
LC650:  CMP $04D2,X
LC653:  BCC $C658

LC655:  LDA $04D2,X

LC658:  STA $E7
LC65A:  LDA OppBaseSprite,X
LC65C:  CLC
LC65D:  ADC $E7
LC65F:  RTS

LC660:  CMP $04D2,X
LC663:  BCC $C668

LC665:  LDA $04D2,X

LC668:  STA $E7
LC66A:  LDA OppBaseSprite,X
LC66C:  SEC
LC66D:  SBC $E7
LC66F:  RTS

;----------------------------------------------------------------------------------------------------

OppStateUpdate1:
LC670:  TXA                     ;Get index into table below.
LC671:  JSR IndFuncJump         ;($AED4)Indirect jump to desired function below.

LC674:  .word OppCallFunc,  OppReturnFunc, NULL_PNTR, NULL_PNTR
LC67C:  .word OppVarStTime, OppNotPunch,   $C6CA,     $C6D7
LC684:  .word $C6DF,        $C6EA,         NULL_PNTR, NULL_PNTR
LC68C:  .word InitAudio

;----------------------------------------------------------------------------------------------------

OppCallFunc:
LC68E:  LDA OppStBasePtrLB      ;
LC690:  STA OppPtrReturnLB      ;Store opponent state base pointer.
LC692:  LDA OppStBasePtrUB      ;
LC694:  STA OppPtrReturnUB      ;

LC696:  LDA (OppStBasePtr),Y    ;
LC698:  INY                     ;
LC699:  TAX                     ;Get the address of opponent base state to call.
LC69A:  LDA (OppStBasePtr),Y    ;
LC69C:  INY                     ;

LC69D:  STY OppIndexReturn      ;Store index into current state for when its time to return.

LC69F:  STA OppStBasePtrUB      ;Jump to new opponent state base address.
LC6A1:  STX OppStBasePtrLB      ;

LC6A3:  LDY #$00                ;Zero state index to start at beginning of new state.
LC6A5:  STY OppStateIndex       ;
LC6A7:  JMP OppStateUpdate      ;($C550)Advance to the opponent's next state.

;----------------------------------------------------------------------------------------------------

OppReturnFunc:
LC6AA:  LDA OppPtrReturnLB      ;
LC6AC:  STA OppStBasePtrLB      ;Restore opponent state base pointer.
LC6AE:  LDA OppPtrReturnUB      ;
LC6B0:  STA OppStBasePtrUB      ;

LC6B2:  LDY OppIndexReturn      ;Restore state index.
LC6B4:  STY OppStateIndex       ;

LC6B6:  LDA #$00                ;Indicate the function has returned from subroutine.
LC6B8:  STA OppPtrReturnUB      ;
LC6BA:  JMP OppStateUpdate      ;($C550)Advance to the opponent's next state.

;----------------------------------------------------------------------------------------------------

OppVarStTime:
LC6BD:  LDA VariableStTime      ;
LC6C0:  STA OppStateTimer       ;Set a varying amount of time for this opponent's state time.
LC6C2:  RTS                     ;

;----------------------------------------------------------------------------------------------------

OppNotPunch:
LC6C3:  LDA #$00                ;Clear opponent punching flag.
LC6C5:  STA OppPunching         ;
LC6C7:  JMP OppStateUpdate      ;($C550)Advance to the opponent's next state.

;----------------------------------------------------------------------------------------------------

LC6CA:  LDA PPU0Load
LC6CC:  AND #$DF
LC6CE:  LDX #$08

LC6D0:  STA PPU0Load
LC6D2:  STX $80
LC6D4:  JMP OppStateUpdate      ;($C550)Advance to the opponent's next state.

;----------------------------------------------------------------------------------------------------

LC6D7:  LDA PPU0Load
LC6D9:  ORA #$20
LC6DB:  LDX #$10
LC6DD:  BNE $C6D0

;----------------------------------------------------------------------------------------------------

LC6DF:  LDA (OppStBasePtr),Y
LC6E1:  INY
LC6E2:  STA $E0
LC6E4:  LDA (OppStBasePtr),Y
LC6E6:  INY
LC6E7:  JMP $C78B

;----------------------------------------------------------------------------------------------------

LC6EA:  LDA (OppStBasePtr),Y
LC6EC:  BEQ $C6F6
LC6EE:  LDX RoundTmrStart       ;($0300)
LC6F1:  BNE $C6F6
LC6F3:  STA RoundTmrStart       ;($0300)
LC6F6:  EOR #$01
LC6F8:  STA $E7
LC6FA:  LDA RoundTmrCntrl
LC6FD:  AND #$FE
LC6FF:  ORA $E7
LC701:  STA RoundTmrCntrl
LC704:  INC OppStateIndex
LC706:  LDA #$64
LC708:  STA RoundTimerUB        ;($0306)
LC70B:  RTS

;----------------------------------------------------------------------------------------------------

InitAudio:
LC70C:  LDA (OppStBasePtr),Y    ;Get byte indicating which SFX/music to play.
LC70E:  INC OppStateIndex       ;

LC710:  TAY                     ;
LC711:  AND #$03                ;Lowest 2 bits are the SFX/music type.
LC713:  TAX                     ;

LC714:  TYA                     ;Is audio being turned off?
LC715:  AND #$FC                ;
LC717:  BMI SetAudioInit        ;If so, branch to disable the audio channel.

LC719:  LSR                     ;Audio is to be played. Transfer upper bits to lower bits.
LC71A:  LSR                     ;

SetAudioInit:
LC71B:  STA SoundInitBase,X     ;Init/end audio.
LC71D:  JMP OppStateUpdate      ;($C550)Advance to the opponent's next state.

;----------------------------------------------------------------------------------------------------

OppStateUpdate2:
LC720:  TXA                     ;Get index into table below.
LC721:  JSR IndFuncJump         ;($AED4)Indirect jump to desired function below.

LC724:  .word PunchActive,  OppStateJump, ChkMemAndBranch, ChkRepeatState
LC72C:  .word OppWaitState, OppRepeat,    OppPunchDirDmg,  OppDefInline
LC734:  .word $C7E1,        OppPunch,     WriteZPageByte,  OppSpecTimer
LC73C:  .word OppComboWait, $C816,        $C81D,           StateDone

;----------------------------------------------------------------------------------------------------

PunchActive:
LC744:  LDX OppPunchSts         ;Is the punch initialized but not yet processed?
LC746:  BMI OppStateWait        ;If so, branch.

LC748:  BNE PunchResults        ;Has punch been processed? If so, branch.

LC74A:  LDA #PUNCH_ACTIVE       ;Indicate a punch is active.
LC74C:  STA OppPunchSts         ;

OppStateWait:
LC74E:  DEC OppStateIndex       ;Stay on this state and exit.
LC750:  RTS                     ;

PunchResults:
LC751:  CPX #PUNCH_LANDED       ;Was punch landed?
LC753:  BEQ PunchLanded         ;If so, branch.

LC755:  BCC PunchBlckDck        ;Was punch blocked or ducked? If so, branch.

PunchDodged:
LC757:  DEX                     ;Dodged punch must have index increased by 2 (4-2=2).

PunchBlckDck:
LC758:  DEX                     ;Only decrement punch status by 1 for block/duck.
LC759:  TXA                     ;
LC75A:  CLC                     ;
LC75B:  ADC OppStateIndex       ;Get the index to jump to for blocked/ducked or dodged punches.
LC75D:  TAY                     ;
LC75E:  LDA (OppStBasePtr),Y    ;

EndPunch:
LC760:  TAY                     ;Indicate the puch processing is done.
LC761:  LDA #PUNCH_NONE         ;
LC763:  STA OppPunchSts         ;Update the state index.

UpdateStateIndex3:
LC765:  STY OppStateIndex       ;
LC767:  JMP OppStateUpdate      ;($C550)Advance to the opponent's next state.

PunchLanded:
LC76A:  TYA                     ;
LC76B:  CLC                     ;Move past the active punch sub-state.
LC76C:  ADC #$03                ;

LC76E:  BNE EndPunch            ;Branch always.

;----------------------------------------------------------------------------------------------------

OppStateJump:
LC770:  LDA (OppStBasePtr),Y    ;
LC772:  TAX                     ;Get lower byte of new state base address.
LC773:  INY                     ;

LC774:  LDA (OppStBasePtr),Y    ;
LC776:  STA GenByteE0           ;Get upper byte of new state base address.
LC778:  INY                     ;

LC779:  LDA (OppStBasePtr),Y    ;Get nex state index value.
LC77B:  TAY                     ;

LC77C:  LDA GenByteE0           ;
LC77E:  STA OppStBasePtrUB      ;Update state base address and state index.
LC780:  STX OppStBasePtrLB      ;
LC782:  BNE UpdateStateIndex3   ;

;----------------------------------------------------------------------------------------------------

;This function will check for a specific value in a memory address. If the value is not equal
;to a given value, it will continue on in a linear fashion in the state. If the value is equal
;to a given value, the state will jump to a new index given by the proceeding data byte.

ChkMemAndBranch:
LC784:  LDA (OppStBasePtr),Y    ;
LC786:  INY                     ;Get address to check.
LC787:  STA $E0                 ;

LC789:  LDA #$00                ;Upper address byte is always 0 for zero page access.
LC78B:  STA $E1                 ;

LC78D:  LDA (OppStBasePtr),Y    ;
LC78F:  INY                     ;Get byte to compare against.
LC790:  STY OppStateIndex       ;

LC792:  LDY #$00                ;Is value in memory equal to byte from state data?
LC794:  CMP ($E0),Y             ;
LC796:  BNE ChkNotEqual         ;If not, branch. No branch in state index.

LC798:  LDY OppStateIndex       ;State branch will occur.  Get next data byte and use it as the -->
LC79A:  LDA (OppStBasePtr),Y    ;new index into the state data.
LC79C:  TAY                     ;

UpdateStateIndex2:
LC79D:  STY OppStateIndex       ;Update opponent state index.
LC79F:  JMP OppStateUpdate      ;($C550)Advance to the opponent's next state.

ChkNotEqual:
LC7A2:  LDY OppStateIndex       ;
LC7A4:  INY                     ;Move past next byte in state data as branch will not occur.
LC7A5:  BNE UpdateStateIndex2   ;

;----------------------------------------------------------------------------------------------------

ChkRepeatState:
LC7A7:  DEC OppStRepeatCntr     ;Decrement sub-state repeat counter.
LC7A9:  BEQ ChkRepeatEnd        ;Does state need to be repeated? If not, branch to exit.

LC7AB:  LDA (OppStBasePtr),Y    ;Get index to jump to for repeating.
LC7AD:  TAY                     ;

RepeatIndexUpdate:
LC7AE:  STY OppStateIndex       ;Update the state index with the new index.
LC7B0:  JMP OppStateUpdate      ;($C550)Advance to the opponent's next state.

ChkRepeatEnd:
LC7B3:  INY                     ;Increment past the next byte. Not time to repeat.
LC7B4:  BNE RepeatIndexUpdate   ;Branch always.

;----------------------------------------------------------------------------------------------------

OppWaitState:
LC7B6:  LDA #$81                ;
LC7B8:  STA OppCurState         ;Put the opponent into their wait state.
LC7BA:  RTS                     ;

;----------------------------------------------------------------------------------------------------

OppRepeat:
LC7BB:  LDA (OppStBasePtr),Y    ;
LC7BD:  STA OppStRepeatCntr     ;Load a value into the repeat counter from data table.
LC7BF:  INC OppStateIndex       ;
LC7C1:  RTS                     ;

;----------------------------------------------------------------------------------------------------

OppPunchDirDmg:
LC7C2:  LDA (OppStBasePtr),Y    ;
LC7C4:  INY                     ;Indicate which side of Little Mac the punch is coming from.
LC7C5:  STA OppPunchSide        ;

LC7C7:  LDA (OppStBasePtr),Y    ;
LC7C9:  INY                     ;Get the damage the punch will do. Added to base damage.
LC7CA:  STA OppPunchDamage      ;

UpdateStateIndex1:
LC7CC:  STY OppStateIndex       ;Update index to opponent state data.
LC7CE:  JMP ZeroByteInc         ;($C582)Increment past zero data byte.

;----------------------------------------------------------------------------------------------------

;Load the opponent's defense values from data that is inline with the state data.

OppDefInline:
LC7D1:  LDY OppStateIndex       ;Set indexes for data copy.
LC7D3:  LDX #$00                ;

DefLoadLoop1:
LC7D5:  LDA (OppStBasePtr),Y    ;
LC7D7:  INY                     ;Get defense data from state data and load it onto opponents stats.
LC7D8:  STA OppHitDefense,X     ;
LC7DA:  INX                     ;

LC7DB:  CPX #$04                ;Have all 4 defense data bytes been loaded?
LC7DD:  BNE DefLoadLoop1        ;If not, branch to load another.

LC7DF:  BEQ UpdateStateIndex1   ;Increment past a trailing zero byte.

;----------------------------------------------------------------------------------------------------

LC7E1:  INC $53
LC7E3:  INC $53
LC7E5:  LDA #$01
LC7E7:  STA $52
LC7E9:  RTS

;----------------------------------------------------------------------------------------------------

OppPunch:
LC7EA:  LDA #$01                ;Indicate the opponent is attacking.
LC7EC:  STA OppPunching         ;
LC7EE:  JMP OppStateUpdate      ;($C550)Advance to the opponent's next state.

;----------------------------------------------------------------------------------------------------

;This function writes a value to a zero page byte. The information comes from the state data.

WriteZPageByte:
LC7F1:  LDA #$00                ;For zero page access, upper byte is always 0.
LC7F3:  STA GenPtrE0UB          ;

LC7F5:  LDA (OppStBasePtr),Y    ;
LC7F7:  INY                     ;Get address of byte to write.
LC7F8:  STA GenPtrE0LB          ;

LC7FA:  LDA (OppStBasePtr),Y    ;
LC7FC:  INY                     ;Get byte to write.
LC7FD:  STY OppStateIndex       ;

LC7FF:  LDY #$00                ;Write byte to address.
LC801:  STA (GenPtrE0),Y        ;
LC803:  JMP ZeroByteInc         ;($C582)Increment past zero data byte.

;----------------------------------------------------------------------------------------------------

OppSpecTimer:
LC806:  LDA TimerVal0585        ;
LC809:  STA ComboTimer          ;Load special state timer value.
LC80B:  RTS                     ;

;----------------------------------------------------------------------------------------------------

OppComboWait:
LC80C:  LDA ComboTimer          ;Has combo timer expired?
LC80E:  BNE +                   ;If not, branch to stay on this state.

LC810:  JMP OppStateUpdate      ;($C550)Advance to the opponent's next state.
LC813:* JMP OppStateWait        ;($C74E)Stay on this state until combo timer expires.

;----------------------------------------------------------------------------------------------------

LC816:  LDA (OppStBasePtr),Y
LC818:  STA $5A
LC81A:  INC OppStateIndex
LC81C:  RTS

;----------------------------------------------------------------------------------------------------

LC81D:  LDA #$82
LC81F:  BNE UpdateStateStat

;----------------------------------------------------------------------------------------------------

StateDone:
LC821:  DEC OppStateIndex       ;
LC823:  LDA #STAT_FINISHED      ;Indicate the end of the current state has been reached.

UpdateStateStat:
LC825:  STA OppStateStatus      ;
LC827:  RTS                     ;

;----------------------------------------------------------------------------------------------------

LC828:  .byte $00, $00, $08, $08, $08, $08, $00, $00

;----------------------------------------------------------------------------------------------------

UpdateMemPair:
LC830:  STA GenByteE0           ;Save nibble data for later.
LC832:  JSR HiNibbleSignExtend  ;($C844)Sign extend the upper nibble.
LC835:  JSR AddMemByte          ;($C83E)Add nibble to memory location.

LC838:  LDA GenByteE0           ;Restore nibble dta.
LC83A:  JSR LoNibbleSignExtend  ;($C847)Sign extend the lower nibble.

LC83D:  INX                     ;Move to next memory location.

AddMemByte:
LC83E:  CLC                     ;
LC83F:  ADC $00,X               ;Add signed nibble to memory location.
LC841:  STA $00,X               ;
LC843:  RTS                     ;

HiNibbleSignExtend:
LC844:  JSR Div16               ;($BF99)Shift upper nibble to lower nibble.

LoNibbleSignExtend:
LC847:  AND #$0F                ;Keep only lower nibble.
LC849:  CMP #$08                ;
LC84B:  BCC +                   ;Sign extend into upper nibble.
LC84D:  ORA #$F0                ;
LC84F:* RTS                     ;

;----------------------------------------------------------------------------------------------------

LC850:  LDA $8004
LC853:  STA $E0
LC855:  LDA $8005
LC858:  STA $E1
LC85A:  BNE $C866
LC85C:  LDA $06E2
LC85F:  STA $E0
LC861:  LDA $06E3
LC864:  STA $E1
LC866:  LDY OppBaseAnimIndex
LC868:  LDA ($E0),Y
LC86A:  STA $A3
LC86C:  INY
LC86D:  LDA ($E0),Y
LC86F:  STA $A4
LC871:  LDA #$00
LC873:  STA $A2
LC875:  TAY
LC876:  LDA ($A3),Y
LC878:  INY
LC879:  STA $AA
LC87B:  LDA #$FF
LC87D:  STA $E7
LC87F:  JSR $C978
LC882:  JSR $CC8B
LC885:  JSR $D176
LC888:  JMP $C88B
LC88B:  LDA #$01
LC88D:  STA $17
LC88F:  RTS

LC890:  LDA OppAnimFlags
LC892:  BEQ $C88F
LC894:  TAX
LC895:  LDA #$50
LC897:  STA $E7
LC899:  LDY FightOffset         ;($03)
LC89B:  LDA $8000,Y
LC89E:  STA $E0
LC8A0:  LDA $8001,Y
LC8A3:  STA $E1

LC8A5:  LDY #OPP_CHNG_NONE
LC8A7:  STY OppAnimFlags

LC8A9:  TXA
LC8AA:  BMI $C8AF
LC8AC:  JMP $C925
LC8AF:  LDA OppBaseAnimIndex
LC8B1:  BMI $C8D3
LC8B3:  LDA ($E0),Y
LC8B5:  INY
LC8B6:  STA $E2
LC8B8:  LDA ($E0),Y
LC8BA:  STA $E3
LC8BC:  LDY OppBaseAnimIndex
LC8BE:  LDA ($E2),Y
LC8C0:  STA $A3
LC8C2:  INY
LC8C3:  LDA ($E2),Y
LC8C5:  STA $A4
LC8C7:  JSR $C976
LC8CA:  JSR $CC8B
LC8CD:  JSR $D176
LC8D0:  JMP $C88B
LC8D3:  CMP #$C0
LC8D5:  BCS $C8FE
LC8D7:  SEC
LC8D8:  SBC #$80
LC8DA:  STA $E4
LC8DC:  LDY #$02
LC8DE:  LDA ($E0),Y
LC8E0:  INY
LC8E1:  STA $E2
LC8E3:  LDA ($E0),Y
LC8E5:  STA $E3
LC8E7:  LDY $E4
LC8E9:  LDA ($E2),Y
LC8EB:  STA $A3
LC8ED:  INY
LC8EE:  LDA ($E2),Y
LC8F0:  STA $A4
LC8F2:  JSR $D3FE
LC8F5:  JSR $CC8B
LC8F8:  JSR $D16E
LC8FB:  JMP $C88B
LC8FE:  SEC
LC8FF:  SBC #$C0
LC901:  STA $E4
LC903:  LDY #$04
LC905:  LDA ($E0),Y
LC907:  INY
LC908:  STA $E2
LC90A:  LDA ($E0),Y
LC90C:  STA $E3
LC90E:  LDY $E4
LC910:  LDA ($E2),Y
LC912:  STA $A3
LC914:  INY
LC915:  LDA ($E2),Y
LC917:  STA $A4
LC919:  JSR $D3FE
LC91C:  JSR $D043
LC91F:  JSR $D16E
LC922:  JMP $C88B
LC925:  LDA OppBaseAnimIndex
LC927:  BMI $C946
LC929:  LDA ($E0),Y
LC92B:  INY
LC92C:  STA $E2
LC92E:  LDA ($E0),Y
LC930:  STA $E3
LC932:  LDY OppBaseAnimIndex
LC934:  LDA ($E2),Y
LC936:  STA $A3
LC938:  INY
LC939:  LDA ($E2),Y
LC93B:  STA $A4
LC93D:  JSR $D3DB
LC940:  JSR $D043
LC943:  JMP $C88B
LC946:  CMP #$C0
LC948:  BCS $C951
LC94A:  SEC
LC94B:  SBC #$80
LC94D:  LDY #$02
LC94F:  BNE $C956
LC951:  SEC
LC952:  SBC #$C0
LC954:  LDY #$04
LC956:  STA $E4
LC958:  LDA ($E0),Y
LC95A:  INY
LC95B:  STA $E2
LC95D:  LDA ($E0),Y
LC95F:  STA $E3
LC961:  LDY $E4
LC963:  LDA ($E2),Y
LC965:  STA $A3
LC967:  INY
LC968:  LDA ($E2),Y
LC96A:  STA $A4
LC96C:  JSR $D3FE
LC96F:  JSR $D043
LC972:  JMP $C88B
LC975:  RTS

LC976:  LDY #$00
LC978:  LDX $AA
LC97A:  LDA ($A3),Y
LC97C:  INY
LC97D:  STA $B2
LC97F:  CLC
LC980:  ADC OppBaseXSprite
LC982:  STA $020F,X
LC985:  LDA ($A3),Y
LC987:  INY
LC988:  STA $B3
LC98A:  CLC
LC98B:  ADC OppBaseYSprite
LC98D:  STA $020C,X
LC990:  INX
LC991:  INX
LC992:  INX
LC993:  INX
LC994:  LDA ($A3),Y
LC996:  INY
LC997:  STA $A6
LC999:  LDA ($A3),Y
LC99B:  INY
LC99C:  STY $A5
LC99E:  STA $A7
LC9A0:  LDY #$00
LC9A2:  LDA ($A6),Y
LC9A4:  BEQ $C975
LC9A6:  AND #$0F
LC9A8:  STA $E2
LC9AA:  LDA ($A6),Y
LC9AC:  INY
LC9AD:  AND #$F0
LC9AF:  BEQ $C9BB
LC9B1:  BMI $CA0F
LC9B3:  CMP #$20
LC9B5:  BEQ $C9EE
LC9B7:  BCC $C9D8
LC9B9:  BCS $C9F1
LC9BB:  LDA ($A6),Y
LC9BD:  INY
LC9BE:  CLC
LC9BF:  ADC $020B,X
LC9C2:  STA $020F,X
LC9C5:  LDA $0208,X
LC9C8:  CLC
LC9C9:  ADC $80
LC9CB:  STA $020C,X
LC9CE:  TXA
LC9CF:  ADC #$04
LC9D1:  TAX
LC9D2:  DEC $E2
LC9D4:  BNE $C9EE
LC9D6:  BEQ $C9A2
LC9D8:  LDA ($A6),Y
LC9DA:  INY
LC9DB:  CLC
LC9DC:  ADC $020B,X
LC9DF:  STA $020F,X
LC9E2:  LDA $0208,X
LC9E5:  STA $020C,X
LC9E8:  INX
LC9E9:  INX
LC9EA:  INX
LC9EB:  INX
LC9EC:  BNE $C9A2
LC9EE:  JMP $CAE8
LC9F1:  LDA ($A6),Y
LC9F3:  INY
LC9F4:  CLC
LC9F5:  ADC $020B,X
LC9F8:  STA $020F,X
LC9FB:  LDA ($A6),Y
LC9FD:  INY
LC9FE:  CLC
LC9FF:  ADC $0208,X
LCA02:  STA $020C,X
LCA05:  INX
LCA06:  INX
LCA07:  INX
LCA08:  INX
LCA09:  DEC $E2
LCA0B:  BEQ $C9A2
LCA0D:  BNE $C9EE
LCA0F:  CMP #$80
LCA11:  BEQ $CA16
LCA13:  JMP $CAA4
LCA16:  LDA $E2
LCA18:  CMP #$08
LCA1A:  BCC $CA26
LCA1C:  CLC
LCA1D:  JSR $CB81
LCA20:  LDA $E2
LCA22:  AND #$07
LCA24:  BEQ $CAA1
LCA26:  CMP #$04
LCA28:  BCC $CA2F
LCA2A:  BNE $CA38
LCA2C:  CLC
LCA2D:  BEQ $CA69
LCA2F:  CMP #$02
LCA31:  BCC $CA93
LCA33:  CLC
LCA34:  BEQ $CA85
LCA36:  BNE $CA77
LCA38:  CMP #$06
LCA3A:  BCC $CA5B
LCA3C:  CLC
LCA3D:  BEQ $CA4D
LCA3F:  LDA #$F8
LCA41:  STA $020C,X
LCA44:  LDA $82
LCA46:  STA $020D,X
LCA49:  TXA
LCA4A:  ADC #$04
LCA4C:  TAX
LCA4D:  LDA #$F8
LCA4F:  STA $020C,X
LCA52:  LDA $82
LCA54:  STA $020D,X
LCA57:  TXA
LCA58:  ADC #$04
LCA5A:  TAX
LCA5B:  LDA #$F8
LCA5D:  STA $020C,X
LCA60:  LDA $82
LCA62:  STA $020D,X
LCA65:  TXA
LCA66:  ADC #$04
LCA68:  TAX
LCA69:  LDA #$F8
LCA6B:  STA $020C,X
LCA6E:  LDA $82
LCA70:  STA $020D,X
LCA73:  TXA
LCA74:  ADC #$04
LCA76:  TAX
LCA77:  LDA #$F8
LCA79:  STA $020C,X
LCA7C:  LDA $82
LCA7E:  STA $020D,X
LCA81:  TXA
LCA82:  ADC #$04
LCA84:  TAX
LCA85:  LDA #$F8
LCA87:  STA $020C,X
LCA8A:  LDA $82
LCA8C:  STA $020D,X
LCA8F:  TXA
LCA90:  ADC #$04
LCA92:  TAX
LCA93:  LDA #$F8
LCA95:  STA $020C,X
LCA98:  LDA $82
LCA9A:  STA $020D,X
LCA9D:  TXA
LCA9E:  ADC #$04
LCAA0:  TAX
LCAA1:  JMP $C9A2
LCAA4:  CMP #$A0
LCAA6:  BEQ $CAC7
LCAA8:  BCC $CAAC
LCAAA:  BCS $CACA
LCAAC:  LDA ($A6),Y
LCAAE:  INY
LCAAF:  CLC
LCAB0:  ADC $020B,X
LCAB3:  STA $020F,X
LCAB6:  LDA $0208,X
LCAB9:  CLC
LCABA:  ADC $80
LCABC:  STA $020C,X
LCABF:  TXA
LCAC0:  ADC #$04
LCAC2:  TAX
LCAC3:  DEC $E2
LCAC5:  BEQ $CAA1
LCAC7:  JMP $CBF2
LCACA:  LDA ($A6),Y
LCACC:  INY
LCACD:  CLC
LCACE:  ADC $020B,X
LCAD1:  STA $020F,X
LCAD4:  LDA ($A6),Y
LCAD6:  INY
LCAD7:  CLC
LCAD8:  ADC $0208,X
LCADB:  STA $020C,X
LCADE:  INX
LCADF:  INX
LCAE0:  INX
LCAE1:  INX
LCAE2:  DEC $E2
LCAE4:  BEQ $CAA1
LCAE6:  BNE $CAC7
LCAE8:  STY $E1
LCAEA:  LDY $0208,X
LCAED:  LDA $E2
LCAEF:  CMP #$04
LCAF1:  BCC $CAF7
LCAF3:  BNE $CAFF
LCAF5:  BEQ $CB38
LCAF7:  CMP #$02
LCAF9:  BCC $CB6B
LCAFB:  BEQ $CB5A
LCAFD:  BNE $CB49
LCAFF:  CMP #$06
LCB01:  BCC $CB27
LCB03:  BEQ $CB16
LCB05:  LDA $020B,X
LCB08:  CLC
LCB09:  ADC #$08
LCB0B:  STA $020F,X
LCB0E:  TYA
LCB0F:  STA $020C,X
LCB12:  INX
LCB13:  INX
LCB14:  INX
LCB15:  INX
LCB16:  LDA $020B,X
LCB19:  CLC
LCB1A:  ADC #$08
LCB1C:  STA $020F,X
LCB1F:  TYA
LCB20:  STA $020C,X
LCB23:  INX
LCB24:  INX
LCB25:  INX
LCB26:  INX
LCB27:  LDA $020B,X
LCB2A:  CLC
LCB2B:  ADC #$08
LCB2D:  STA $020F,X
LCB30:  TYA
LCB31:  STA $020C,X
LCB34:  INX
LCB35:  INX
LCB36:  INX
LCB37:  INX
LCB38:  LDA $020B,X
LCB3B:  CLC
LCB3C:  ADC #$08
LCB3E:  STA $020F,X
LCB41:  TYA
LCB42:  STA $020C,X
LCB45:  INX
LCB46:  INX
LCB47:  INX
LCB48:  INX
LCB49:  LDA $020B,X
LCB4C:  CLC
LCB4D:  ADC #$08
LCB4F:  STA $020F,X
LCB52:  TYA
LCB53:  STA $020C,X
LCB56:  INX
LCB57:  INX
LCB58:  INX
LCB59:  INX
LCB5A:  LDA $020B,X
LCB5D:  CLC
LCB5E:  ADC #$08
LCB60:  STA $020F,X
LCB63:  TYA
LCB64:  STA $020C,X
LCB67:  INX
LCB68:  INX
LCB69:  INX
LCB6A:  INX
LCB6B:  LDA $020B,X
LCB6E:  CLC
LCB6F:  ADC #$08
LCB71:  STA $020F,X
LCB74:  TYA
LCB75:  STA $020C,X
LCB78:  INX
LCB79:  INX
LCB7A:  INX
LCB7B:  INX
LCB7C:  LDY $E1
LCB7E:  JMP $C9A2
LCB81:  LDA #$F8
LCB83:  STA $020C,X
LCB86:  LDA $82
LCB88:  STA $020D,X
LCB8B:  TXA
LCB8C:  ADC #$04
LCB8E:  TAX
LCB8F:  LDA #$F8
LCB91:  STA $020C,X
LCB94:  LDA $82
LCB96:  STA $020D,X
LCB99:  TXA
LCB9A:  ADC #$04
LCB9C:  TAX
LCB9D:  LDA #$F8
LCB9F:  STA $020C,X
LCBA2:  LDA $82
LCBA4:  STA $020D,X
LCBA7:  TXA
LCBA8:  ADC #$04
LCBAA:  TAX
LCBAB:  LDA #$F8
LCBAD:  STA $020C,X
LCBB0:  LDA $82
LCBB2:  STA $020D,X
LCBB5:  TXA
LCBB6:  ADC #$04
LCBB8:  TAX
LCBB9:  LDA #$F8
LCBBB:  STA $020C,X
LCBBE:  LDA $82
LCBC0:  STA $020D,X
LCBC3:  TXA
LCBC4:  ADC #$04
LCBC6:  TAX
LCBC7:  LDA #$F8
LCBC9:  STA $020C,X
LCBCC:  LDA $82
LCBCE:  STA $020D,X
LCBD1:  TXA
LCBD2:  ADC #$04
LCBD4:  TAX
LCBD5:  LDA #$F8
LCBD7:  STA $020C,X
LCBDA:  LDA $82
LCBDC:  STA $020D,X
LCBDF:  TXA
LCBE0:  ADC #$04
LCBE2:  TAX
LCBE3:  LDA #$F8
LCBE5:  STA $020C,X
LCBE8:  LDA $82
LCBEA:  STA $020D,X
LCBED:  TXA
LCBEE:  ADC #$04
LCBF0:  TAX
LCBF1:  RTS
LCBF2:  STY $E1
LCBF4:  LDY $0208,X
LCBF7:  LDA $E2
LCBF9:  CMP #$04
LCBFB:  BCC $CC01
LCBFD:  BNE $CC09
LCBFF:  BEQ $CC42
LCC01:  CMP #$02
LCC03:  BMI $CC75
LCC05:  BEQ $CC64
LCC07:  BPL $CC53
LCC09:  CMP #$06
LCC0B:  BMI $CC31
LCC0D:  BEQ $CC20
LCC0F:  LDA $020B,X
LCC12:  SEC
LCC13:  SBC #$08
LCC15:  STA $020F,X
LCC18:  TYA
LCC19:  STA $020C,X
LCC1C:  INX
LCC1D:  INX
LCC1E:  INX
LCC1F:  INX
LCC20:  LDA $020B,X
LCC23:  SEC
LCC24:  SBC #$08
LCC26:  STA $020F,X
LCC29:  TYA
LCC2A:  STA $020C,X
LCC2D:  INX
LCC2E:  INX
LCC2F:  INX
LCC30:  INX
LCC31:  LDA $020B,X
LCC34:  SEC
LCC35:  SBC #$08
LCC37:  STA $020F,X
LCC3A:  TYA
LCC3B:  STA $020C,X
LCC3E:  INX
LCC3F:  INX
LCC40:  INX
LCC41:  INX
LCC42:  LDA $020B,X
LCC45:  SEC
LCC46:  SBC #$08
LCC48:  STA $020F,X
LCC4B:  TYA
LCC4C:  STA $020C,X
LCC4F:  INX
LCC50:  INX
LCC51:  INX
LCC52:  INX
LCC53:  LDA $020B,X
LCC56:  SEC
LCC57:  SBC #$08
LCC59:  STA $020F,X
LCC5C:  TYA
LCC5D:  STA $020C,X
LCC60:  INX
LCC61:  INX
LCC62:  INX
LCC63:  INX
LCC64:  LDA $020B,X
LCC67:  SEC
LCC68:  SBC #$08
LCC6A:  STA $020F,X
LCC6D:  TYA
LCC6E:  STA $020C,X
LCC71:  INX
LCC72:  INX
LCC73:  INX
LCC74:  INX
LCC75:  LDA $020B,X
LCC78:  SEC
LCC79:  SBC #$08
LCC7B:  STA $020F,X
LCC7E:  TYA
LCC7F:  STA $020C,X
LCC82:  INX
LCC83:  INX
LCC84:  INX
LCC85:  INX
LCC86:  LDY $E1
LCC88:  JMP $C9A2
LCC8B:  LDY $A5
LCC8D:  LDA ($A3),Y
LCC8F:  INY
LCC90:  STA $A6
LCC92:  LDA ($A3),Y
LCC94:  INY
LCC95:  STY $A5
LCC97:  STA $A7
LCC99:  LDY #$00
LCC9B:  LDX $AA
LCC9D:  LDA $A2
LCC9F:  STY $A2
LCCA1:  BEQ $CCA6
LCCA3:  JMP $CE72
LCCA6:  LDA ($A6),Y
LCCA8:  BEQ $CD0D
LCCAA:  AND #$1F
LCCAC:  STA $E2
LCCAE:  LDA ($A6),Y
LCCB0:  INY
LCCB1:  AND #$E0
LCCB3:  BMI $CCBF
LCCB5:  BEQ $CCC2
LCCB7:  CMP #$40
LCCB9:  BEQ $CCF4
LCCBB:  BCS $CD0E
LCCBD:  BCC $CCDB
LCCBF:  JMP $CD27
LCCC2:  LDA $020C,X
LCCC5:  CMP $E7
LCCC7:  BCS $CCD8
LCCC9:  LDA #$00
LCCCB:  STA $020E,X
LCCCE:  TXA
LCCCF:  ADC #$04
LCCD1:  TAX
LCCD2:  DEC $E2
LCCD4:  BNE $CCC2
LCCD6:  BEQ $CCA6
LCCD8:  JMP $CD5E
LCCDB:  LDA $020C,X
LCCDE:  CMP $E7
LCCE0:  BCS $CCF1
LCCE2:  LDA #$01
LCCE4:  STA $020E,X
LCCE7:  TXA
LCCE8:  ADC #$04
LCCEA:  TAX
LCCEB:  DEC $E2
LCCED:  BNE $CCDB
LCCEF:  BEQ $CCA6
LCCF1:  JMP $CD64
LCCF4:  LDA $020C,X
LCCF7:  CMP $E7
LCCF9:  BCS $CD0A
LCCFB:  LDA #$02
LCCFD:  STA $020E,X
LCD00:  TXA
LCD01:  ADC #$04
LCD03:  TAX
LCD04:  DEC $E2
LCD06:  BNE $CCF4
LCD08:  BEQ $CCA6
LCD0A:  JMP $CD6A
LCD0D:  RTS

LCD0E:  LDA $020C,X
LCD11:  CMP $E7
LCD13:  BCS $CD24
LCD15:  LDA #$03
LCD17:  STA $020E,X
LCD1A:  TXA
LCD1B:  ADC #$04
LCD1D:  TAX
LCD1E:  DEC $E2
LCD20:  BNE $CD0E
LCD22:  BEQ $CCA6
LCD24:  JMP $CD74
LCD27:  LDA $020C,X
LCD2A:  CMP $E7
LCD2C:  BCS $CD3F
LCD2E:  LDA ($A6),Y
LCD30:  INY
LCD31:  STA $020E,X
LCD34:  TXA
LCD35:  ADC #$04
LCD37:  TAX
LCD38:  DEC $E2
LCD3A:  BNE $CD27
LCD3C:  JMP $CCA6
LCD3F:  JMP $CDE5
LCD42:  LDA ($A6),Y
LCD44:  BEQ $CD0D
LCD46:  AND #$1F
LCD48:  STA $E2
LCD4A:  LDA ($A6),Y
LCD4C:  INY
LCD4D:  AND #$E0
LCD4F:  BMI $CD5B
LCD51:  BEQ $CD5E
LCD53:  CMP #$40
LCD55:  BEQ $CD6A
LCD57:  BCS $CD74
LCD59:  BCC $CD64
LCD5B:  JMP $CDE5
LCD5E:  STY $E1
LCD60:  LDA #$20
LCD62:  BNE $CD78
LCD64:  STY $E1
LCD66:  LDA #$21
LCD68:  BNE $CD78
LCD6A:  STY $E1
LCD6C:  LDA #$22
LCD6E:  BNE $CD78
LCD70:  LDY $E1
LCD72:  BNE $CD42
LCD74:  STY $E1
LCD76:  LDA #$23
LCD78:  LDY $E2
LCD7A:  CPY #$08
LCD7C:  BCC $CD99
LCD7E:  CPY #$10
LCD80:  BCC $CD8C
LCD82:  CPY #$18
LCD84:  BCC $CD89
LCD86:  JSR $D134
LCD89:  JSR $D134
LCD8C:  JSR $D134
LCD8F:  STA $E0
LCD91:  TYA
LCD92:  AND #$07
LCD94:  BEQ $CD70
LCD96:  TAY
LCD97:  LDA $E0
LCD99:  CPY #$04
LCD9B:  BCC $CDA1
LCD9D:  BNE $CDA9
LCD9F:  BEQ $CDC4
LCDA1:  CPY #$02
LCDA3:  BCC $CDD9
LCDA5:  BEQ $CDD2
LCDA7:  BCS $CDCB
LCDA9:  CPY #$06
LCDAB:  BCC $CDBD
LCDAD:  BEQ $CDB6
LCDAF:  STA $020E,X
LCDB2:  INX
LCDB3:  INX
LCDB4:  INX
LCDB5:  INX
LCDB6:  STA $020E,X
LCDB9:  INX
LCDBA:  INX
LCDBB:  INX
LCDBC:  INX
LCDBD:  STA $020E,X
LCDC0:  INX
LCDC1:  INX
LCDC2:  INX
LCDC3:  INX
LCDC4:  STA $020E,X
LCDC7:  INX
LCDC8:  INX
LCDC9:  INX
LCDCA:  INX
LCDCB:  STA $020E,X
LCDCE:  INX
LCDCF:  INX
LCDD0:  INX
LCDD1:  INX
LCDD2:  STA $020E,X
LCDD5:  INX
LCDD6:  INX
LCDD7:  INX
LCDD8:  INX
LCDD9:  STA $020E,X
LCDDC:  INX
LCDDD:  INX
LCDDE:  INX
LCDDF:  INX
LCDE0:  LDY $E1
LCDE2:  JMP $CD42
LCDE5:  LDA $E2
LCDE7:  CMP #$08
LCDE9:  BCC $CE02
LCDEB:  CMP #$10
LCDED:  BCC $CDF9
LCDEF:  CMP #$18
LCDF1:  BCC $CDF6
LCDF3:  JSR $D070
LCDF6:  JSR $D070
LCDF9:  JSR $D070
LCDFC:  LDA $E2
LCDFE:  AND #$07
LCE00:  BEQ $CE6F
LCE02:  CMP #$04
LCE04:  BCC $CE0B
LCE06:  BNE $CE14
LCE08:  CLC
LCE09:  BEQ $CE3F
LCE0B:  CMP #$02
LCE0D:  BCC $CE63
LCE0F:  CLC
LCE10:  BEQ $CE57
LCE12:  BPL $CE4B
LCE14:  CMP #$06
LCE16:  BCC $CE33
LCE18:  CLC
LCE19:  BEQ $CE27
LCE1B:  LDA ($A6),Y
LCE1D:  INY
LCE1E:  EOR #$20
LCE20:  STA $020E,X
LCE23:  TXA
LCE24:  ADC #$04
LCE26:  TAX
LCE27:  LDA ($A6),Y
LCE29:  INY
LCE2A:  EOR #$20
LCE2C:  STA $020E,X
LCE2F:  TXA
LCE30:  ADC #$04
LCE32:  TAX
LCE33:  LDA ($A6),Y
LCE35:  INY
LCE36:  EOR #$20
LCE38:  STA $020E,X
LCE3B:  TXA
LCE3C:  ADC #$04
LCE3E:  TAX
LCE3F:  LDA ($A6),Y
LCE41:  INY
LCE42:  EOR #$20
LCE44:  STA $020E,X
LCE47:  TXA
LCE48:  ADC #$04
LCE4A:  TAX
LCE4B:  LDA ($A6),Y
LCE4D:  INY
LCE4E:  EOR #$20
LCE50:  STA $020E,X
LCE53:  TXA
LCE54:  ADC #$04
LCE56:  TAX
LCE57:  LDA ($A6),Y
LCE59:  INY
LCE5A:  EOR #$20
LCE5C:  STA $020E,X
LCE5F:  TXA
LCE60:  ADC #$04
LCE62:  TAX
LCE63:  LDA ($A6),Y
LCE65:  INY
LCE66:  EOR #$20
LCE68:  STA $020E,X
LCE6B:  TXA
LCE6C:  ADC #$04
LCE6E:  TAX
LCE6F:  JMP $CD42
LCE72:  LDA ($A6),Y
LCE74:  BEQ $CED9
LCE76:  AND #$1F
LCE78:  STA $E2
LCE7A:  LDA ($A6),Y
LCE7C:  INY
LCE7D:  AND #$E0
LCE7F:  BMI $CE8B
LCE81:  BEQ $CE8E
LCE83:  CMP #$40
LCE85:  BEQ $CEC0
LCE87:  BCS $CEDA
LCE89:  BCC $CEA7
LCE8B:  JMP $CEF3
LCE8E:  LDA $020C,X
LCE91:  CMP $E7
LCE93:  BCS $CEA4
LCE95:  LDA #$40
LCE97:  STA $020E,X
LCE9A:  TXA
LCE9B:  ADC #$04
LCE9D:  TAX
LCE9E:  DEC $E2
LCEA0:  BNE $CE8E
LCEA2:  BEQ $CE72
LCEA4:  JMP $CF2C
LCEA7:  LDA $020C,X
LCEAA:  CMP $E7
LCEAC:  BCS $CEBD
LCEAE:  LDA #$41
LCEB0:  STA $020E,X
LCEB3:  TXA
LCEB4:  ADC #$04
LCEB6:  TAX
LCEB7:  DEC $E2
LCEB9:  BNE $CEA7
LCEBB:  BEQ $CE72
LCEBD:  JMP $CF32
LCEC0:  LDA $020C,X
LCEC3:  CMP $E7
LCEC5:  BCS $CED6
LCEC7:  LDA #$42
LCEC9:  STA $020E,X
LCECC:  TXA
LCECD:  ADC #$04
LCECF:  TAX
LCED0:  DEC $E2
LCED2:  BNE $CEC0
LCED4:  BEQ $CE72
LCED6:  JMP $CF38
LCED9:  RTS
LCEDA:  LDA $020C,X
LCEDD:  CMP $E7
LCEDF:  BCS $CEF0
LCEE1:  LDA #$43
LCEE3:  STA $020E,X
LCEE6:  TXA
LCEE7:  ADC #$04
LCEE9:  TAX
LCEEA:  DEC $E2
LCEEC:  BNE $CEDA
LCEEE:  BEQ $CE72
LCEF0:  JMP $CF42
LCEF3:  LDA $020C,X
LCEF6:  CMP $E7
LCEF8:  BCS $CF0D
LCEFA:  LDA ($A6),Y
LCEFC:  INY
LCEFD:  EOR #$40
LCEFF:  STA $020E,X
LCF02:  TXA
LCF03:  ADC #$04
LCF05:  TAX
LCF06:  DEC $E2
LCF08:  BNE $CEF3
LCF0A:  JMP $CE72
LCF0D:  JMP $CFB6
LCF10:  LDA ($A6),Y
LCF12:  BEQ $CED9
LCF14:  AND #$1F
LCF16:  STA $E2
LCF18:  LDA ($A6),Y
LCF1A:  INY
LCF1B:  AND #$E0
LCF1D:  BMI $CF29
LCF1F:  BEQ $CF2C
LCF21:  CMP #$40
LCF23:  BEQ $CF38
LCF25:  BCS $CF42
LCF27:  BCC $CF32
LCF29:  JMP $CFB6
LCF2C:  STY $E1
LCF2E:  LDA #$60
LCF30:  BNE $CF46
LCF32:  STY $E1
LCF34:  LDA #$61
LCF36:  BNE $CF46
LCF38:  STY $E1
LCF3A:  LDA #$62
LCF3C:  BNE $CF46
LCF3E:  LDY $E1
LCF40:  BNE $CF10
LCF42:  STY $E1
LCF44:  LDA #$63
LCF46:  LDY $E2
LCF48:  CPY #$08
LCF4A:  BCC $CF67
LCF4C:  CPY #$10
LCF4E:  BCC $CF5A
LCF50:  CPY #$18
LCF52:  BCC $CF57
LCF54:  JSR $D134
LCF57:  JSR $D134
LCF5A:  JSR $D134
LCF5D:  STA $E0
LCF5F:  TYA
LCF60:  AND #$07
LCF62:  BEQ $CF3E
LCF64:  TAY
LCF65:  LDA $E0
LCF67:  CPY #$04
LCF69:  BCC $CF6F
LCF6B:  BNE $CF77
LCF6D:  BEQ $CF92
LCF6F:  CPY #$02
LCF71:  BCC $CFA7
LCF73:  BEQ $CFA0
LCF75:  BCS $CF99
LCF77:  CPY #$06
LCF79:  BCC $CF8B
LCF7B:  BEQ $CF84
LCF7D:  STA $020E,X
LCF80:  INX
LCF81:  INX
LCF82:  INX
LCF83:  INX
LCF84:  STA $020E,X
LCF87:  INX
LCF88:  INX
LCF89:  INX
LCF8A:  INX
LCF8B:  STA $020E,X
LCF8E:  INX
LCF8F:  INX
LCF90:  INX
LCF91:  INX
LCF92:  STA $020E,X
LCF95:  INX
LCF96:  INX
LCF97:  INX
LCF98:  INX
LCF99:  STA $020E,X
LCF9C:  INX
LCF9D:  INX
LCF9E:  INX
LCF9F:  INX
LCFA0:  STA $020E,X
LCFA3:  INX
LCFA4:  INX
LCFA5:  INX
LCFA6:  INX
LCFA7:  STA $020E,X
LCFAA:  INX
LCFAB:  INX
LCFAC:  INX
LCFAD:  INX
LCFAE:  LDY $E1
LCFB0:  JMP $CF10
LCFB3:  JMP $CF10
LCFB6:  LDA $E2
LCFB8:  CMP #$08
LCFBA:  BCC $CFD3
LCFBC:  CMP #$10
LCFBE:  BCC $CFCA
LCFC0:  CMP #$18
LCFC2:  BCC $CFC7
LCFC4:  JSR $D0D2
LCFC7:  JSR $D0D2
LCFCA:  JSR $D0D2
LCFCD:  LDA $E2
LCFCF:  AND #$07
LCFD1:  BEQ $CFB3
LCFD3:  CMP #$04
LCFD5:  BCC $CFDC
LCFD7:  BNE $CFE5
LCFD9:  CLC
LCFDA:  BEQ $D010
LCFDC:  CMP #$02
LCFDE:  BCC $D034
LCFE0:  CLC
LCFE1:  BEQ $D028
LCFE3:  BPL $D01C
LCFE5:  CMP #$06
LCFE7:  BCC $D004
LCFE9:  CLC
LCFEA:  BEQ $CFF8
LCFEC:  LDA ($A6),Y
LCFEE:  INY
LCFEF:  EOR #$60
LCFF1:  STA $020E,X
LCFF4:  TXA
LCFF5:  ADC #$04
LCFF7:  TAX
LCFF8:  LDA ($A6),Y
LCFFA:  INY
LCFFB:  EOR #$60
LCFFD:  STA $020E,X
LD000:  TXA
LD001:  ADC #$04
LD003:  TAX
LD004:  LDA ($A6),Y
LD006:  INY
LD007:  EOR #$60
LD009:  STA $020E,X
LD00C:  TXA
LD00D:  ADC #$04
LD00F:  TAX
LD010:  LDA ($A6),Y
LD012:  INY
LD013:  EOR #$60
LD015:  STA $020E,X
LD018:  TXA
LD019:  ADC #$04
LD01B:  TAX
LD01C:  LDA ($A6),Y
LD01E:  INY
LD01F:  EOR #$60
LD021:  STA $020E,X
LD024:  TXA
LD025:  ADC #$04
LD027:  TAX
LD028:  LDA ($A6),Y
LD02A:  INY
LD02B:  EOR #$60
LD02D:  STA $020E,X
LD030:  TXA
LD031:  ADC #$04
LD033:  TAX
LD034:  LDA ($A6),Y
LD036:  INY
LD037:  EOR #$60
LD039:  STA $020E,X
LD03C:  TXA
LD03D:  ADC #$04
LD03F:  TAX
LD040:  JMP $CF10
LD043:  LDX #$00
LD045:  LDA $020C,X
LD048:  CMP #$50
LD04A:  BCS $D05B
LD04C:  LDA $020E,X
LD04F:  AND #$DF
LD051:  STA $020E,X
LD054:  INX
LD055:  INX
LD056:  INX
LD057:  INX
LD058:  BNE $D045
LD05A:  RTS
LD05B:  LDA $020E,X
LD05E:  TAY
LD05F:  AND #$20
LD061:  BNE $D06F
LD063:  TYA
LD064:  ORA #$20
LD066:  STA $020E,X
LD069:  INX
LD06A:  INX
LD06B:  INX
LD06C:  INX
LD06D:  BNE $D05B
LD06F:  RTS
LD070:  CLC
LD071:  LDA ($A6),Y
LD073:  INY
LD074:  EOR #$20
LD076:  STA $020E,X
LD079:  TXA
LD07A:  ADC #$04
LD07C:  TAX
LD07D:  LDA ($A6),Y
LD07F:  INY
LD080:  EOR #$20
LD082:  STA $020E,X
LD085:  TXA
LD086:  ADC #$04
LD088:  TAX
LD089:  LDA ($A6),Y
LD08B:  INY
LD08C:  EOR #$20
LD08E:  STA $020E,X
LD091:  TXA
LD092:  ADC #$04
LD094:  TAX
LD095:  LDA ($A6),Y
LD097:  INY
LD098:  EOR #$20
LD09A:  STA $020E,X
LD09D:  TXA
LD09E:  ADC #$04
LD0A0:  TAX
LD0A1:  LDA ($A6),Y
LD0A3:  INY
LD0A4:  EOR #$20
LD0A6:  STA $020E,X
LD0A9:  TXA
LD0AA:  ADC #$04
LD0AC:  TAX
LD0AD:  LDA ($A6),Y
LD0AF:  INY
LD0B0:  EOR #$20
LD0B2:  STA $020E,X
LD0B5:  TXA
LD0B6:  ADC #$04
LD0B8:  TAX
LD0B9:  LDA ($A6),Y
LD0BB:  INY
LD0BC:  EOR #$20
LD0BE:  STA $020E,X
LD0C1:  TXA
LD0C2:  ADC #$04
LD0C4:  TAX
LD0C5:  LDA ($A6),Y
LD0C7:  INY
LD0C8:  EOR #$20
LD0CA:  STA $020E,X
LD0CD:  TXA
LD0CE:  ADC #$04
LD0D0:  TAX
LD0D1:  RTS
LD0D2:  CLC
LD0D3:  LDA ($A6),Y
LD0D5:  INY
LD0D6:  EOR #$60
LD0D8:  STA $020E,X
LD0DB:  TXA
LD0DC:  ADC #$04
LD0DE:  TAX
LD0DF:  LDA ($A6),Y
LD0E1:  INY
LD0E2:  EOR #$60
LD0E4:  STA $020E,X
LD0E7:  TXA
LD0E8:  ADC #$04
LD0EA:  TAX
LD0EB:  LDA ($A6),Y
LD0ED:  INY
LD0EE:  EOR #$60
LD0F0:  STA $020E,X
LD0F3:  TXA
LD0F4:  ADC #$04
LD0F6:  TAX
LD0F7:  LDA ($A6),Y
LD0F9:  INY
LD0FA:  EOR #$60
LD0FC:  STA $020E,X
LD0FF:  TXA
LD100:  ADC #$04
LD102:  TAX
LD103:  LDA ($A6),Y
LD105:  INY
LD106:  EOR #$60
LD108:  STA $020E,X
LD10B:  TXA
LD10C:  ADC #$04
LD10E:  TAX
LD10F:  LDA ($A6),Y
LD111:  INY
LD112:  EOR #$60
LD114:  STA $020E,X
LD117:  TXA
LD118:  ADC #$04
LD11A:  TAX
LD11B:  LDA ($A6),Y
LD11D:  INY
LD11E:  EOR #$60
LD120:  STA $020E,X
LD123:  TXA
LD124:  ADC #$04
LD126:  TAX
LD127:  LDA ($A6),Y
LD129:  INY
LD12A:  EOR #$60
LD12C:  STA $020E,X
LD12F:  TXA
LD130:  ADC #$04
LD132:  TAX
LD133:  RTS
LD134:  STA $020E,X
LD137:  INX
LD138:  INX
LD139:  INX
LD13A:  INX
LD13B:  STA $020E,X
LD13E:  INX
LD13F:  INX
LD140:  INX
LD141:  INX
LD142:  STA $020E,X
LD145:  INX
LD146:  INX
LD147:  INX
LD148:  INX
LD149:  STA $020E,X
LD14C:  INX
LD14D:  INX
LD14E:  INX
LD14F:  INX
LD150:  STA $020E,X
LD153:  INX
LD154:  INX
LD155:  INX
LD156:  INX
LD157:  STA $020E,X
LD15A:  INX
LD15B:  INX
LD15C:  INX
LD15D:  INX
LD15E:  STA $020E,X
LD161:  INX
LD162:  INX
LD163:  INX
LD164:  INX
LD165:  STA $020E,X
LD168:  INX
LD169:  INX
LD16A:  INX
LD16B:  INX
LD16C:  RTS
LD16D:  RTS
LD16E:  LDY $A5
LD170:  LDA ($A3),Y
LD172:  TAX
LD173:  INY
LD174:  BNE $D17A
LD176:  LDY $A5
LD178:  LDX $AA
LD17A:  LDA ($A3),Y
LD17C:  BEQ $D16D
LD17E:  INY
LD17F:  STA $A8
LD181:  STY $A5
LD183:  BNE $D189
LD185:  DEC $A8
LD187:  BEQ $D16D
LD189:  LDY $A5
LD18B:  LDA ($A3),Y
LD18D:  INY
LD18E:  STA $A6
LD190:  LDA ($A3),Y
LD192:  INY
LD193:  STA $A7
LD195:  STY $A5
LD197:  LDY #$00
LD199:  LDA ($A6),Y
LD19B:  BEQ $D185
LD19D:  AND #$0F
LD19F:  STA $E2
LD1A1:  LDA ($A6),Y
LD1A3:  INY
LD1A4:  AND #$F0
LD1A6:  BEQ $D1B4
LD1A8:  BMI $D1B1
LD1AA:  CMP #$20
LD1AC:  BEQ $D22A
LD1AE:  JMP $D29B
LD1B1:  JMP $D2A3
LD1B4:  LDA ($A6),Y
LD1B6:  INY
LD1B7:  STY $E1
LD1B9:  LDY $E2
LD1BB:  CPY #$08
LD1BD:  BCC $D1CD
LD1BF:  JSR $D305
LD1C2:  STA $E0
LD1C4:  LDA $E2
LD1C6:  AND #$07
LD1C8:  BEQ $D225
LD1CA:  TAY
LD1CB:  LDA $E0
LD1CD:  CPY #$04
LD1CF:  BCC $D1D6
LD1D1:  BNE $D1DF
LD1D3:  CLC
LD1D4:  BEQ $D201
LD1D6:  CPY #$02
LD1D8:  BCC $D21C
LD1DA:  CLC
LD1DB:  BEQ $D213
LD1DD:  BPL $D20A
LD1DF:  CPY #$06
LD1E1:  BCC $D1F8
LD1E3:  CLC
LD1E4:  BEQ $D1EF
LD1E6:  STA $020D,X
LD1E9:  INX
LD1EA:  INX
LD1EB:  INX
LD1EC:  INX
LD1ED:  ADC $81
LD1EF:  STA $020D,X
LD1F2:  INX
LD1F3:  INX
LD1F4:  INX
LD1F5:  INX
LD1F6:  ADC $81
LD1F8:  STA $020D,X
LD1FB:  INX
LD1FC:  INX
LD1FD:  INX
LD1FE:  INX
LD1FF:  ADC $81
LD201:  STA $020D,X
LD204:  INX
LD205:  INX
LD206:  INX
LD207:  INX
LD208:  ADC $81
LD20A:  STA $020D,X
LD20D:  INX
LD20E:  INX
LD20F:  INX
LD210:  INX
LD211:  ADC $81
LD213:  STA $020D,X
LD216:  INX
LD217:  INX
LD218:  INX
LD219:  INX
LD21A:  ADC $81
LD21C:  STA $020D,X
LD21F:  INX
LD220:  INX
LD221:  INX
LD222:  INX
LD223:  ADC $81
LD225:  LDY $E1
LD227:  JMP $D199
LD22A:  LDA $E2
LD22C:  CMP #$08
LD22E:  BCC $D239
LD230:  JSR $D34F
LD233:  LDA $E2
LD235:  AND #$07
LD237:  BEQ $D227
LD239:  CMP #$04
LD23B:  BCC $D242
LD23D:  BNE $D24B
LD23F:  CLC
LD240:  BEQ $D270
LD242:  CMP #$02
LD244:  BCC $D28E
LD246:  CLC
LD247:  BEQ $D284
LD249:  BPL $D27A
LD24B:  CMP #$06
LD24D:  BCC $D266
LD24F:  CLC
LD250:  BEQ $D25C
LD252:  LDA ($A6),Y
LD254:  INY
LD255:  STA $020D,X
LD258:  TXA
LD259:  ADC #$04
LD25B:  TAX
LD25C:  LDA ($A6),Y
LD25E:  INY
LD25F:  STA $020D,X
LD262:  TXA
LD263:  ADC #$04
LD265:  TAX
LD266:  LDA ($A6),Y
LD268:  INY
LD269:  STA $020D,X
LD26C:  TXA
LD26D:  ADC #$04
LD26F:  TAX
LD270:  LDA ($A6),Y
LD272:  INY
LD273:  STA $020D,X
LD276:  TXA
LD277:  ADC #$04
LD279:  TAX
LD27A:  LDA ($A6),Y
LD27C:  INY
LD27D:  STA $020D,X
LD280:  TXA
LD281:  ADC #$04
LD283:  TAX
LD284:  LDA ($A6),Y
LD286:  INY
LD287:  STA $020D,X
LD28A:  TXA
LD28B:  ADC #$04
LD28D:  TAX
LD28E:  LDA ($A6),Y
LD290:  INY
LD291:  STA $020D,X
LD294:  TXA
LD295:  ADC #$04
LD297:  TAX
LD298:  JMP $D199
LD29B:  LDA ($A6),Y
LD29D:  INY
LD29E:  STA $A9
LD2A0:  JMP $D199
LD2A3:  LDA $E2
LD2A5:  CMP #$08
LD2A7:  BCC $D2B4
LD2A9:  LDA $82
LD2AB:  JSR $D3A1
LD2AE:  LDA $E2
LD2B0:  AND #$07
LD2B2:  BEQ $D2A0
LD2B4:  STY $E1
LD2B6:  TAY
LD2B7:  LDA $82
LD2B9:  CPY #$04
LD2BB:  BCC $D2C1
LD2BD:  BNE $D2C9
LD2BF:  BEQ $D2E4
LD2C1:  CPY #$02
LD2C3:  BMI $D2F9
LD2C5:  BEQ $D2F2
LD2C7:  BPL $D2EB
LD2C9:  CPY #$06
LD2CB:  BMI $D2DD
LD2CD:  BEQ $D2D6
LD2CF:  STA $020D,X
LD2D2:  INX
LD2D3:  INX
LD2D4:  INX
LD2D5:  INX
LD2D6:  STA $020D,X
LD2D9:  INX
LD2DA:  INX
LD2DB:  INX
LD2DC:  INX
LD2DD:  STA $020D,X
LD2E0:  INX
LD2E1:  INX
LD2E2:  INX
LD2E3:  INX
LD2E4:  STA $020D,X
LD2E7:  INX
LD2E8:  INX
LD2E9:  INX
LD2EA:  INX
LD2EB:  STA $020D,X
LD2EE:  INX
LD2EF:  INX
LD2F0:  INX
LD2F1:  INX
LD2F2:  STA $020D,X
LD2F5:  INX
LD2F6:  INX
LD2F7:  INX
LD2F8:  INX
LD2F9:  STA $020D,X
LD2FC:  INX
LD2FD:  INX
LD2FE:  INX
LD2FF:  INX
LD300:  LDY $E1
LD302:  JMP $D199
LD305:  CLC
LD306:  STA $020D,X
LD309:  INX
LD30A:  INX
LD30B:  INX
LD30C:  INX
LD30D:  ADC $81
LD30F:  STA $020D,X
LD312:  INX
LD313:  INX
LD314:  INX
LD315:  INX
LD316:  ADC $81
LD318:  STA $020D,X
LD31B:  INX
LD31C:  INX
LD31D:  INX
LD31E:  INX
LD31F:  ADC $81
LD321:  STA $020D,X
LD324:  INX
LD325:  INX
LD326:  INX
LD327:  INX
LD328:  ADC $81
LD32A:  STA $020D,X
LD32D:  INX
LD32E:  INX
LD32F:  INX
LD330:  INX
LD331:  ADC $81
LD333:  STA $020D,X
LD336:  INX
LD337:  INX
LD338:  INX
LD339:  INX
LD33A:  ADC $81
LD33C:  STA $020D,X
LD33F:  INX
LD340:  INX
LD341:  INX
LD342:  INX
LD343:  ADC $81
LD345:  STA $020D,X
LD348:  INX
LD349:  INX
LD34A:  INX
LD34B:  INX
LD34C:  ADC $81
LD34E:  RTS
LD34F:  CLC
LD350:  LDA ($A6),Y
LD352:  INY
LD353:  STA $020D,X
LD356:  TXA
LD357:  ADC #$04
LD359:  TAX
LD35A:  LDA ($A6),Y
LD35C:  INY
LD35D:  STA $020D,X
LD360:  TXA
LD361:  ADC #$04
LD363:  TAX
LD364:  LDA ($A6),Y
LD366:  INY
LD367:  STA $020D,X
LD36A:  TXA
LD36B:  ADC #$04
LD36D:  TAX
LD36E:  LDA ($A6),Y
LD370:  INY
LD371:  STA $020D,X
LD374:  TXA
LD375:  ADC #$04
LD377:  TAX
LD378:  LDA ($A6),Y
LD37A:  INY
LD37B:  STA $020D,X
LD37E:  TXA
LD37F:  ADC #$04
LD381:  TAX
LD382:  LDA ($A6),Y
LD384:  INY
LD385:  STA $020D,X
LD388:  TXA
LD389:  ADC #$04
LD38B:  TAX
LD38C:  LDA ($A6),Y
LD38E:  INY
LD38F:  STA $020D,X
LD392:  TXA
LD393:  ADC #$04
LD395:  TAX
LD396:  LDA ($A6),Y
LD398:  INY
LD399:  STA $020D,X
LD39C:  TXA
LD39D:  ADC #$04
LD39F:  TAX
LD3A0:  RTS
LD3A1:  STA $020D,X
LD3A4:  INX
LD3A5:  INX
LD3A6:  INX
LD3A7:  INX
LD3A8:  STA $020D,X
LD3AB:  INX
LD3AC:  INX
LD3AD:  INX
LD3AE:  INX
LD3AF:  STA $020D,X
LD3B2:  INX
LD3B3:  INX
LD3B4:  INX
LD3B5:  INX
LD3B6:  STA $020D,X
LD3B9:  INX
LD3BA:  INX
LD3BB:  INX
LD3BC:  INX
LD3BD:  STA $020D,X
LD3C0:  INX
LD3C1:  INX
LD3C2:  INX
LD3C3:  INX
LD3C4:  STA $020D,X
LD3C7:  INX
LD3C8:  INX
LD3C9:  INX
LD3CA:  INX
LD3CB:  STA $020D,X
LD3CE:  INX
LD3CF:  INX
LD3D0:  INX
LD3D1:  INX
LD3D2:  STA $020D,X
LD3D5:  INX
LD3D6:  INX
LD3D7:  INX
LD3D8:  INX
LD3D9:  RTS
LD3DA:  RTS
LD3DB:  LDY #$00
LD3DD:  LDA ($A3),Y
LD3DF:  INY
LD3E0:  STA $B2
LD3E2:  CLC
LD3E3:  ADC OppBaseXSprite
LD3E5:  SEC
LD3E6:  SBC $020F
LD3E9:  TAX
LD3EA:  LDA ($A3),Y
LD3EC:  INY
LD3ED:  STY $A5
LD3EF:  STA $B3
LD3F1:  CLC
LD3F2:  ADC OppBaseYSprite
LD3F4:  SEC
LD3F5:  SBC $020C
LD3F8:  TAY
LD3F9:  BNE $D421
LD3FB:  JMP $D672
LD3FE:  LDY #$00
LD400:  LDA ($A3),Y
LD402:  INY
LD403:  TAX
LD404:  BNE $D3DD
LD406:  STY $A5
LD408:  LDA $B2
LD40A:  CLC
LD40B:  ADC OppBaseXSprite
LD40D:  SEC
LD40E:  SBC $020F
LD411:  TAX
LD412:  LDA $B3
LD414:  CLC
LD415:  ADC OppBaseYSprite
LD417:  SEC
LD418:  SBC $020C
LD41B:  TAY
LD41C:  BNE $D421
LD41E:  JMP $D672
LD421:  CLC
LD422:  ADC $020C
LD425:  STA $020C
LD428:  CLC
LD429:  TYA
LD42A:  ADC $0210
LD42D:  STA $0210
LD430:  CLC
LD431:  TYA
LD432:  ADC $0214
LD435:  STA $0214
LD438:  CLC
LD439:  TYA
LD43A:  ADC $0218
LD43D:  STA $0218
LD440:  CLC
LD441:  TYA
LD442:  ADC $021C
LD445:  STA $021C
LD448:  CLC
LD449:  TYA
LD44A:  ADC $0220
LD44D:  STA $0220
LD450:  CLC
LD451:  TYA
LD452:  ADC $0224
LD455:  STA $0224
LD458:  CLC
LD459:  TYA
LD45A:  ADC $0228
LD45D:  STA $0228
LD460:  CLC
LD461:  TYA
LD462:  ADC $022C
LD465:  STA $022C
LD468:  CLC
LD469:  TYA
LD46A:  ADC $0230
LD46D:  STA $0230
LD470:  CLC
LD471:  TYA
LD472:  ADC $0234
LD475:  STA $0234
LD478:  CLC
LD479:  TYA
LD47A:  ADC $0238
LD47D:  STA $0238
LD480:  CLC
LD481:  TYA
LD482:  ADC $023C
LD485:  STA $023C
LD488:  CLC
LD489:  TYA
LD48A:  ADC $0240
LD48D:  STA $0240
LD490:  CLC
LD491:  TYA
LD492:  ADC $0244
LD495:  STA $0244
LD498:  CLC
LD499:  TYA
LD49A:  ADC $0248
LD49D:  STA $0248
LD4A0:  CLC
LD4A1:  TYA
LD4A2:  ADC $024C
LD4A5:  STA $024C
LD4A8:  CLC
LD4A9:  TYA
LD4AA:  ADC $0250
LD4AD:  STA $0250
LD4B0:  CLC
LD4B1:  TYA
LD4B2:  ADC $0254
LD4B5:  STA $0254
LD4B8:  CLC
LD4B9:  TYA
LD4BA:  ADC $0258
LD4BD:  STA $0258
LD4C0:  CLC
LD4C1:  TYA
LD4C2:  ADC $025C
LD4C5:  STA $025C
LD4C8:  CLC
LD4C9:  TYA
LD4CA:  ADC $0260
LD4CD:  STA $0260
LD4D0:  CLC
LD4D1:  TYA
LD4D2:  ADC $0264
LD4D5:  STA $0264
LD4D8:  CLC
LD4D9:  TYA
LD4DA:  ADC $0268
LD4DD:  STA $0268
LD4E0:  CLC
LD4E1:  TYA
LD4E2:  ADC $026C
LD4E5:  STA $026C
LD4E8:  CLC
LD4E9:  TYA
LD4EA:  ADC $0270
LD4ED:  STA $0270
LD4F0:  CLC
LD4F1:  TYA
LD4F2:  ADC $0274
LD4F5:  STA $0274
LD4F8:  CLC
LD4F9:  TYA
LD4FA:  ADC $0278
LD4FD:  STA $0278
LD500:  CLC
LD501:  TYA
LD502:  ADC $027C
LD505:  STA $027C
LD508:  CLC
LD509:  TYA
LD50A:  ADC $0280
LD50D:  STA $0280
LD510:  CLC
LD511:  TYA
LD512:  ADC $0284
LD515:  STA $0284
LD518:  CLC
LD519:  TYA
LD51A:  ADC $0288
LD51D:  STA $0288
LD520:  STY $E0
LD522:  LDA $028C
LD525:  CMP #$F8
LD527:  BCS $D593
LD529:  ADC $E0
LD52B:  STA $028C
LD52E:  LDA $0290
LD531:  CMP #$F8
LD533:  BCS $D593
LD535:  ADC $E0
LD537:  STA $0290
LD53A:  LDA $0294
LD53D:  CMP #$F8
LD53F:  BCS $D593
LD541:  ADC $E0
LD543:  STA $0294
LD546:  LDA $0298
LD549:  CMP #$F8
LD54B:  BCS $D593
LD54D:  ADC $E0
LD54F:  STA $0298
LD552:  LDA $029C
LD555:  CMP #$F8
LD557:  BCS $D593
LD559:  ADC $E0
LD55B:  STA $029C
LD55E:  LDA $02A0
LD561:  CMP #$F8
LD563:  BCS $D593
LD565:  ADC $E0
LD567:  STA $02A0
LD56A:  LDA $02A4
LD56D:  CMP #$F8
LD56F:  BCS $D593
LD571:  ADC $E0
LD573:  STA $02A4
LD576:  LDA $02A8
LD579:  CMP #$F8
LD57B:  BCS $D593
LD57D:  ADC $E0
LD57F:  STA $02A8
LD582:  LDA $02AC
LD585:  CMP #$F8
LD587:  BCS $D593
LD589:  ADC $E0
LD58B:  STA $02AC
LD58E:  LDA $02B0
LD591:  CMP #$F8
LD593:  BCS $D5F3
LD595:  ADC $E0
LD597:  STA $02B0
LD59A:  LDA $02B4
LD59D:  CMP #$F8
LD59F:  BCS $D5F3
LD5A1:  ADC $E0
LD5A3:  STA $02B4
LD5A6:  LDA $02B8
LD5A9:  CMP #$F8
LD5AB:  BCS $D5F3
LD5AD:  ADC $E0
LD5AF:  STA $02B8
LD5B2:  LDA $02BC
LD5B5:  CMP #$F8
LD5B7:  BCS $D5F3
LD5B9:  ADC $E0
LD5BB:  STA $02BC
LD5BE:  LDA $02C0
LD5C1:  CMP #$F8
LD5C3:  BCS $D5F3
LD5C5:  ADC $E0
LD5C7:  STA $02C0
LD5CA:  LDA $02C4
LD5CD:  CMP #$F8
LD5CF:  BCS $D5F3
LD5D1:  ADC $E0
LD5D3:  STA $02C4
LD5D6:  LDA $02C8
LD5D9:  CMP #$F8
LD5DB:  BCS $D5F3
LD5DD:  ADC $E0
LD5DF:  STA $02C8
LD5E2:  LDA $02CC
LD5E5:  CMP #$F8
LD5E7:  BCS $D5F3
LD5E9:  ADC $E0
LD5EB:  STA $02CC
LD5EE:  LDA $02D0
LD5F1:  CMP #$F8
LD5F3:  BCS $D672
LD5F5:  ADC $E0
LD5F7:  STA $02D0
LD5FA:  LDA $02D4
LD5FD:  CMP #$F8
LD5FF:  BCS $D672
LD601:  ADC $E0
LD603:  STA $02D4
LD606:  LDA $02D8
LD609:  CMP #$F8
LD60B:  BCS $D672
LD60D:  ADC $E0
LD60F:  STA $02D8
LD612:  LDA $02DC
LD615:  CMP #$F8
LD617:  BCS $D672
LD619:  ADC $E0
LD61B:  STA $02DC
LD61E:  LDA $02E0
LD621:  CMP #$F8
LD623:  BCS $D672
LD625:  ADC $E0
LD627:  STA $02E0
LD62A:  LDA $02E4
LD62D:  CMP #$F8
LD62F:  BCS $D672
LD631:  ADC $E0
LD633:  STA $02E4
LD636:  LDA $02E8
LD639:  CMP #$F8
LD63B:  BCS $D672
LD63D:  ADC $E0
LD63F:  STA $02E8
LD642:  LDA $02EC
LD645:  CMP #$F8
LD647:  BCS $D672
LD649:  ADC $E0
LD64B:  STA $02EC
LD64E:  LDA $02F0
LD651:  CMP #$F8
LD653:  BCS $D672
LD655:  ADC $E0
LD657:  STA $02F0
LD65A:  LDA $02F4
LD65D:  CMP #$F8
LD65F:  BCS $D672
LD661:  ADC $E0
LD663:  STA $02F4
LD666:  LDA $02F8
LD669:  CMP #$F8
LD66B:  BCS $D672
LD66D:  ADC $E0
LD66F:  STA $02F8
LD672:  TXA
LD673:  BNE $D678
LD675:  JMP $D3DA

LD678:  CLC
LD679:  ADC $020F
LD67C:  STA $020F
LD67F:  CLC
LD680:  TXA
LD681:  ADC $0213
LD684:  STA $0213
LD687:  CLC
LD688:  TXA
LD689:  ADC $0217
LD68C:  STA $0217
LD68F:  CLC
LD690:  TXA
LD691:  ADC $021B
LD694:  STA $021B
LD697:  CLC
LD698:  TXA
LD699:  ADC $021F
LD69C:  STA $021F
LD69F:  CLC
LD6A0:  TXA
LD6A1:  ADC $0223
LD6A4:  STA $0223
LD6A7:  CLC
LD6A8:  TXA
LD6A9:  ADC $0227
LD6AC:  STA $0227
LD6AF:  CLC
LD6B0:  TXA
LD6B1:  ADC $022B
LD6B4:  STA $022B
LD6B7:  CLC
LD6B8:  TXA
LD6B9:  ADC $022F
LD6BC:  STA $022F
LD6BF:  CLC
LD6C0:  TXA
LD6C1:  ADC $0233
LD6C4:  STA $0233
LD6C7:  CLC
LD6C8:  TXA
LD6C9:  ADC $0237
LD6CC:  STA $0237
LD6CF:  CLC
LD6D0:  TXA
LD6D1:  ADC $023B
LD6D4:  STA $023B
LD6D7:  CLC
LD6D8:  TXA
LD6D9:  ADC $023F
LD6DC:  STA $023F
LD6DF:  CLC
LD6E0:  TXA
LD6E1:  ADC $0243
LD6E4:  STA $0243
LD6E7:  CLC
LD6E8:  TXA
LD6E9:  ADC $0247
LD6EC:  STA $0247
LD6EF:  CLC
LD6F0:  TXA
LD6F1:  ADC $024B
LD6F4:  STA $024B
LD6F7:  CLC
LD6F8:  TXA
LD6F9:  ADC $024F
LD6FC:  STA $024F
LD6FF:  CLC
LD700:  TXA
LD701:  ADC $0253
LD704:  STA $0253
LD707:  CLC
LD708:  TXA
LD709:  ADC $0257
LD70C:  STA $0257
LD70F:  CLC
LD710:  TXA
LD711:  ADC $025B
LD714:  STA $025B
LD717:  CLC
LD718:  TXA
LD719:  ADC $025F
LD71C:  STA $025F
LD71F:  CLC
LD720:  TXA
LD721:  ADC $0263
LD724:  STA $0263
LD727:  CLC
LD728:  TXA
LD729:  ADC $0267
LD72C:  STA $0267
LD72F:  CLC
LD730:  TXA
LD731:  ADC $026B
LD734:  STA $026B
LD737:  CLC
LD738:  TXA
LD739:  ADC $026F
LD73C:  STA $026F
LD73F:  CLC
LD740:  TXA
LD741:  ADC $0273
LD744:  STA $0273
LD747:  CLC
LD748:  TXA
LD749:  ADC $0277
LD74C:  STA $0277
LD74F:  CLC
LD750:  TXA
LD751:  ADC $027B
LD754:  STA $027B
LD757:  CLC
LD758:  TXA
LD759:  ADC $027F
LD75C:  STA $027F
LD75F:  CLC
LD760:  TXA
LD761:  ADC $0283
LD764:  STA $0283
LD767:  CLC
LD768:  TXA
LD769:  ADC $0287
LD76C:  STA $0287
LD76F:  CLC
LD770:  TXA
LD771:  ADC $028B
LD774:  STA $028B
LD777:  CLC
LD778:  TXA
LD779:  ADC $028F
LD77C:  STA $028F
LD77F:  CLC
LD780:  TXA
LD781:  ADC $0293
LD784:  STA $0293
LD787:  CLC
LD788:  TXA
LD789:  ADC $0297
LD78C:  STA $0297
LD78F:  CLC
LD790:  TXA
LD791:  ADC $029B
LD794:  STA $029B
LD797:  CLC
LD798:  TXA
LD799:  ADC $029F
LD79C:  STA $029F
LD79F:  CLC
LD7A0:  TXA
LD7A1:  ADC $02A3
LD7A4:  STA $02A3
LD7A7:  CLC
LD7A8:  TXA
LD7A9:  ADC $02A7
LD7AC:  STA $02A7
LD7AF:  CLC
LD7B0:  TXA
LD7B1:  ADC $02AB
LD7B4:  STA $02AB
LD7B7:  CLC
LD7B8:  TXA
LD7B9:  ADC $02AF
LD7BC:  STA $02AF
LD7BF:  CLC
LD7C0:  TXA
LD7C1:  ADC $02B3
LD7C4:  STA $02B3
LD7C7:  CLC
LD7C8:  TXA
LD7C9:  ADC $02B7
LD7CC:  STA $02B7
LD7CF:  CLC
LD7D0:  TXA
LD7D1:  ADC $02BB
LD7D4:  STA $02BB
LD7D7:  CLC
LD7D8:  TXA
LD7D9:  ADC $02BF
LD7DC:  STA $02BF
LD7DF:  CLC
LD7E0:  TXA
LD7E1:  ADC $02C3
LD7E4:  STA $02C3
LD7E7:  CLC
LD7E8:  TXA
LD7E9:  ADC $02C7
LD7EC:  STA $02C7
LD7EF:  CLC
LD7F0:  TXA
LD7F1:  ADC $02CB
LD7F4:  STA $02CB
LD7F7:  CLC
LD7F8:  TXA
LD7F9:  ADC $02CF
LD7FC:  STA $02CF
LD7FF:  CLC
LD800:  TXA
LD801:  ADC $02D3
LD804:  STA $02D3
LD807:  CLC
LD808:  TXA
LD809:  ADC $02D7
LD80C:  STA $02D7
LD80F:  CLC
LD810:  TXA
LD811:  ADC $02DB
LD814:  STA $02DB
LD817:  CLC
LD818:  TXA
LD819:  ADC $02DF
LD81C:  STA $02DF
LD81F:  CLC
LD820:  TXA
LD821:  ADC $02E3
LD824:  STA $02E3
LD827:  CLC
LD828:  TXA
LD829:  ADC $02E7
LD82C:  STA $02E7
LD82F:  CLC
LD830:  TXA
LD831:  ADC $02EB
LD834:  STA $02EB
LD837:  CLC
LD838:  TXA
LD839:  ADC $02EF
LD83C:  STA $02EF
LD83F:  CLC
LD840:  TXA
LD841:  ADC $02F3
LD844:  STA $02F3
LD847:  CLC
LD848:  TXA
LD849:  ADC $02F7
LD84C:  STA $02F7
LD84F:  CLC
LD850:  TXA
LD851:  ADC $02FB
LD854:  STA $02FB
LD857:  RTS

;Unused.
LD858:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LD868:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LD878:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LD888:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LD898:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LD8A8:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LD8B8:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LD8C8:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LD8D8:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LD8E8:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LD8F8:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LD908:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LD918:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LD929:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LD938:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LD948:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LD958:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LD968:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LD978:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LD988:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LD998:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LD9A8:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LD9B8:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LD9C8:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LD9D8:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LD9E8:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LD9F8:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LDA08:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LDA18:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LDA28:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LDA38:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LDA48:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LDA58:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LDA68:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LDA78:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LDA88:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LDA98:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LDAA8:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LDAB8:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LDAC8:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LDAD8:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LDAE8:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LDAF8:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LDB08:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LDB18:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LDB28:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LDB38:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LDB48:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LDB58:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LDB68:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LDB78:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LDB88:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LDB98:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LDBA8:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LDBB8:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LDBC8:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LDBD8:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LDBE8:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LDBF8:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LDC08:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LDC18:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LDC28:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LDC38:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LDC48:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LDC58:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LDC68:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LDC78:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LDC88:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LDC98:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LDCA8:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LDCB8:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LDCC8:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LDCD8:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LDCE8:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LDCF8:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LDD08:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LDD18:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LDD28:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LDD38:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LDD48:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LDD58:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LDD68:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LDD78:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LDD88:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LDD98:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LDDA8:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LDDB8:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LDDC8:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LDDD8:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LDDE8:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LDDF8:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LDE08:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LDE18:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LDE28:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LDE38:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LDE48:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LDE58:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LDE68:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LDE78:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LDE88:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LDE98:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LDEA8:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LDEB8:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LDEC8:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LDED8:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LDEE8:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LDEF8:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LDF08:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LDF18:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LDF28:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LDF38:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LDF48:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LDF58:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LDF68:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LDF78:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LDF88:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LDF98:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LDFA8:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LDFB8:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LDFC8:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LDFD8:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LDFE8:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LDFF8:  .byte $00, $00, $00, $00, $00, $00, $00, $00

;---------------------------------[ DMC Audio Channel Sample Data ]----------------------------------

;DMC channel data.

DMCCrowdDat:
LE000:  .byte $F8, $01, $FC, $87, $3E, $E0, $03, $F0, $5F, $00, $FE, $FF, $03, $20, $00, $FF
LE010:  .byte $7F, $EC, $02, $80, $FD, $3F, $F0, $0B, $00, $FE, $1F, $00, $FA, $4B, $FB, $7F
LE020:  .byte $00, $00, $FE, $FF, $07, $00, $E0, $DF, $3F, $AC, $1A, $00, $E0, $FF, $7F, $00
LE030:  .byte $2C, $80, $F7, $FF, $05, $00, $2D, $F4, $FF, $03, $80, $1F, $E8, $FF, $9F, $00
LE040:  .byte $00, $FD, $BF, $80, $03, $FA, $2F, $00, $FB, $FF, $BF, $00, $00, $E0, $FF, $7F
LE050:  .byte $00, $F8, $0F, $E0, $3F, $00, $E0, $FF, $0F, $00, $78, $FF, $FF, $07, $00, $00
LE060:  .byte $FB, $FF, $03, $00, $FF, $0F, $00, $FE, $FF, $07, $00, $0C, $E2, $FF, $0F, $07
LE070:  .byte $04, $1E, $F8, $F7, $FF, $95, $00, $00, $EC, $FF, $9F, $00, $80, $62, $FF, $3F
LE080:  .byte $09, $00, $F0, $FF, $FF, $00, $00, $FB, $7F, $00, $C3, $7F, $00, $FC, $FF, $AA
LE090:  .byte $00, $F0, $03, $FF, $7F, $00, $3F, $00, $4C, $FF, $FF, $03, $00, $F0, $6B, $FF
LE0A0:  .byte $01, $40, $C0, $FE, $FF, $00, $C0, $93, $FF, $FF, $03, $00, $B0, $FF, $BF, $00
LE0B0:  .byte $00, $FA, $FF, $03, $00, $F0, $FF, $27, $00, $54, $D7, $FF, $0F, $2F, $00, $E0
LE0C0:  .byte $2F, $FF, $03, $00, $FA, $FF, $2F, $00, $E0, $FF, $0F, $00, $E0, $FF, $03, $F8
LE0D0:  .byte $0B, $00, $FF, $AF, $ED, $00, $80, $FE, $FF, $01, $00, $C0, $FF, $FF, $07, $00
LE0E0:  .byte $00, $FD, $FF, $FF, $00, $00, $E0, $FF, $7F, $02, $E0, $A5, $FF, $05, $20, $F4
LE0F0:  .byte $FF, $01, $00, $EB, $FF, $7F, $00, $00, $F0, $FF, $2F, $40, $17, $80, $FD, $3F
LE100:  .byte $FA, $03, $C0, $7F, $00, $E8, $8F, $FF, $00, $F0, $FF, $3F, $00, $E0, $1F, $80
LE110:  .byte $43, $FF, $7F, $00, $F8, $0F, $FC, $3F, $00, $00, $FB, $FF, $03, $80, $08, $68
LE120:  .byte $FF, $FF, $0B, $00, $F0, $FF, $00, $FE, $02, $F8, $7F, $F4, $05, $80, $FF, $FA
LE130:  .byte $01, $00, $F8, $FF, $FE, $00, $00, $E0, $FF, $7F, $00, $C0, $AA, $FE, $FF, $01
LE140:  .byte $A0, $3A, $80, $FD, $FF, $0F, $00, $C0, $FA, $9F, $7A, $81, $9F, $00, $80, $FF
LE150:  .byte $FF, $01, $80, $FF, $A1, $1F, $F8, $01, $E0, $FF, $7F, $00, $00, $F0, $FF, $1F
LE160:  .byte $2E, $00, $D4, $FF, $0B, $00, $FE, $FF, $00, $80, $FE, $C0, $FF, $17, $00, $7E
LE170:  .byte $00, $FB, $FF, $0B, $00, $80, $FF, $FF, $7F, $00, $00, $B0, $FF, $3F, $00, $A0
LE180:  .byte $AA, $FE, $FF, $00, $00, $FD, $FF, $09, $00, $FF, $F8, $03, $C0, $F8, $FF, $60
LE190:  .byte $0F, $00, $7A, $F1, $FF, $17, $00, $00, $FF, $FF, $03, $00, $F0, $FF, $FF, $01
LE1A0:  .byte $00, $E8, $FF, $1F, $00, $B0, $9F, $FF, $0F, $00, $00, $FE, $FF, $07, $00, $F0
LE1B0:  .byte $3F, $F4, $EA, $27, $00, $E8, $FF, $2F, $00, $38, $F4, $FF, $07, $00, $10, $FD
LE1C0:  .byte $FF, $0B, $00, $A0, $FF, $FF, $00, $E0, $EF, $0E, $E8, $3F, $01, $E0, $3F, $2E
LE1D0:  .byte $00, $FB, $FF, $03, $00, $FE, $FE, $27, $00, $A0, $FF, $7F, $00, $03, $F8, $FF
LE1E0:  .byte $C0, $0F, $00, $E0, $FF, $0F, $2F, $80, $1F, $60, $F7, $FF, $07, $00, $E0, $FF
LE1F0:  .byte $7F, $00, $00, $F4, $FF, $F8, $7F, $00, $00, $AE, $FF, $BF, $00, $00, $E0, $FE
LE200:  .byte $1F, $C0, $FE, $03, $80, $FE, $9F, $02, $A0, $FF, $3F, $00, $E0, $FF, $0F, $00
LE210:  .byte $F8, $F7, $1F, $00, $FA, $1F, $C0, $5F, $00, $00, $FE, $FF, $3F, $00, $00, $FF
LE220:  .byte $FF, $03, $00, $A0, $FF, $FF, $0F, $00, $C0, $FF, $FF, $03, $00, $A0, $FF, $7F
LE230:  .byte $00, $00, $F0, $FF, $FF, $0F, $00, $00, $FE, $FF, $00, $F8, $03, $FA, $FF, $01
LE240:  .byte $00, $F8, $FF, $3F, $00, $E0, $E8, $FF, $0F, $00, $A0, $FF, $FF, $00, $00, $E0
LE250:  .byte $FF, $BF, $00, $F0, $EB, $85, $F4, $FF, $00, $00, $EC, $FF, $05, $00, $F8, $FB
LE260:  .byte $FF, $07, $00, $A0, $FF, $FF, $03, $00, $80, $FF, $FF, $0B, $00, $F8, $FB, $03
LE270:  .byte $00, $FE, $FF, $F8, $01, $00, $F8, $FF, $FF, $00, $00, $F0, $87, $FE, $0B, $C0
LE280:  .byte $01, $FC, $FF, $0F, $00, $F8, $CF, $FF, $03, $00, $FC, $00, $F6, $1F, $00, $FE
LE290:  .byte $FF, $02, $00, $E8, $FF, $7F, $02, $00, $F8, $FF, $F8, $2F, $00, $D0, $8B, $FF
LE2A0:  .byte $FF, $01, $00, $00, $FE, $BF, $22, $00, $F0, $FF, $7F, $00, $A8, $FA, $FE, $3F
LE2B0:  .byte $00, $00, $FB, $7F, $92, $00, $F8, $FF, $2F, $20, $01, $D8, $FF, $BF, $00, $80
LE2C0:  .byte $56, $FA, $7F, $EC, $00, $A0, $FF, $FF, $0B, $00, $00, $FE, $FF, $07, $00, $A0
LE2D0:  .byte $FF, $0F, $F0, $07, $FA, $13, $80, $F0, $FF, $23, $FA, $01, $D0, $FF, $03, $28
LE2E0:  .byte $C9, $FF, $FF, $01, $00, $FF, $0A, $01, $C0, $FF, $FF, $00, $80, $FE, $C7, $7E
LE2F0:  .byte $01, $C0, $FE, $03, $02, $F8, $FF, $3F, $00, $E0, $FF, $5F, $00, $F8, $41, $1E
LE300:  .byte $E0, $FF, $97, $00, $FF, $03, $00, $8E, $FE, $BF, $F0, $03, $00, $F6, $4F, $F8
LE310:  .byte $7F, $00, $E8, $D5, $02, $F8, $FF, $03, $10, $00, $FC, $FF, $7F, $00, $C0, $FE
LE320:  .byte $FF, $27, $00, $80, $F8, $0F, $FC, $3F, $0A, $80, $E0, $FF, $1F, $00, $F0, $FF
LE330:  .byte $FF, $01, $00, $C0, $FF, $FF, $00, $00, $BC, $FF, $FF, $1F, $00, $00, $E8, $FF
LE340:  .byte $01, $8E, $FD, $01, $FE, $07, $04, $E0, $E7, $FF, $1F, $00, $24, $80, $FF, $FF
LE350:  .byte $02, $F8, $0F, $08, $E8, $7F, $E0, $27, $A0, $FF, $00, $F8, $7F, $7F, $01, $00
LE360:  .byte $FB, $0F, $00, $FC, $FF, $9D, $C0, $0F, $00, $00, $FE, $FF, $3F, $00, $00, $FF
LE370:  .byte $FF, $03, $00, $F0, $FF, $3F, $00, $00, $FD, $FF, $FF, $00, $00, $E0, $FF, $0F
LE380:  .byte $0C, $3F, $00, $FE, $7F, $51, $00, $00, $FE, $FF, $3F, $00, $00, $FF, $FF, $0B
LE390:  .byte $00, $80, $FF, $FF, $0F, $00, $C0, $FE, $FF, $07, $00, $00, $FA, $FF, $FF, $00
LE3A0:  .byte $00, $00, $FF, $FF, $FF, $03, $00, $A0, $FF, $71, $E0, $C7, $4F, $0A, $00, $FE
LE3B0:  .byte $FF, $2F, $00, $00, $FB, $0F, $E0, $FF, $01, $EC, $1D, $FA, $83, $00, $C8, $FF
LE3C0:  .byte $3F, $A0, $EA, $3F, $00, $E0, $BF, $0E, $E0, $FF, $0F, $00, $C0, $FE, $FF, $00
LE3D0:  .byte $00, $E0, $FF, $FF, $1F, $00, $F0, $7F, $9B, $00, $00, $F8, $FF, $0F, $C0, $3F
LE3E0:  .byte $02, $D7, $8F, $9F, $00, $A0, $F7, $FF, $09, $00, $E8, $B9, $FF, $3F, $00, $00
LE3F0:  .byte $FA, $FF, $03, $00, $B0, $FF, $3F, $05, $00, $FF, $BF, $AD, $00, $80, $6E, $FF
LE400:  .byte $2F, $00, $20, $FF, $7F, $23, $80, $FF, $02, $00, $FD, $EF, $7F, $00, $C0, $FE
LE410:  .byte $0B, $00, $A0, $FF, $FF, $7F, $00, $00, $B0, $FF, $3F, $00, $10, $F8, $FE, $FF
LE420:  .byte $22, $00, $E0, $FF, $FF, $0F, $00, $A0, $F7, $3F, $01, $00, $F8, $FF, $02, $00
LE430:  .byte $FE, $FF, $FF, $00, $00, $FC, $8F, $FF, $00, $00, $FE, $7F, $0F, $00, $3F, $40
LE440:  .byte $F2, $FF, $09, $88, $3C, $A0, $FD, $FF, $09, $00, $C0, $FE, $FF, $07, $00, $60
LE450:  .byte $FF, $FF, $03, $00, $D0, $FF, $3F, $00, $00, $FA, $FF, $1F, $00, $F8, $FF, $07
LE460:  .byte $00, $FC, $FF, $01, $00, $FD, $FF, $03, $00, $F0, $FF, $3F, $00, $00, $FF, $FF
LE470:  .byte $0F, $00, $80, $FD, $FF, $01, $00, $F8, $FF, $FF, $00, $00, $FC, $3F, $74, $E0
LE480:  .byte $27, $01, $80, $DF, $FF, $1F, $00, $80, $FF, $3F, $01, $00, $DF, $FF, $1F, $00
LE490:  .byte $D0, $FF, $FF, $01, $00, $60, $FF, $5F, $00, $00, $FE, $FF, $0F, $00, $FA, $01
LE4A0:  .byte $BE, $F8, $FF, $03, $00, $80, $FF, $7F, $B1, $0B, $00, $FE, $BF, $00, $4F, $00
LE4B0:  .byte $FF, $C1, $1F, $F8, $2F, $02, $00, $FA, $FF, $3F, $00, $A0, $EF, $FE, $8F, $04
LE4C0:  .byte $00, $E0, $FF, $7F, $00, $F8, $0F, $40, $FA, $FF, $83, $00, $FE, $15, $FA, $09
LE4D0:  .byte $00, $ED, $FF, $1F, $00, $F0, $FF, $C0, $01, $E0, $FF, $FF, $1F, $00, $00, $F4
LE4E0:  .byte $FB, $F1, $17, $00, $F0, $E2, $FF, $0F, $00, $00, $BB, $FF, $FF, $01, $00, $E0
LE4F0:  .byte $FE, $FF, $07, $00, $A0, $FF, $7F, $00, $00, $B0, $FF, $FF, $0F, $00, $80, $BE
LE500:  .byte $FF, $3F, $00, $00, $C0, $FF, $FF, $07, $00, $E0, $FF, $FF, $03, $00, $B0, $FF
LE510:  .byte $FF, $01, $00, $C0, $FF, $FF, $07, $00, $00, $FF, $FF, $FD, $03, $00, $00, $FB
LE520:  .byte $FF, $FF, $00, $00, $FC, $FF, $0F, $00, $00, $FE, $FF, $1F, $00, $00, $FF, $0F
LE530:  .byte $FC, $07, $00, $E0, $FA, $FF, $0F, $00, $00, $FC, $FF, $FF, $01, $00, $80, $FF
LE540:  .byte $FF, $0F, $00, $00, $FE, $FF, $7F, $01, $00, $C0, $FF, $FF, $07, $00, $00, $FF
LE550:  .byte $FF, $03, $00, $A0, $FF, $FF, $0F, $02, $00, $FE, $FF, $07, $80, $03, $FF, $7F
LE560:  .byte $00, $05, $00, $FC, $FF, $FF, $03, $00, $80, $FF, $FF, $0B, $00, $E0, $FE, $FF
LE570:  .byte $27, $00, $00, $FB, $FF, $FF, $00, $00, $40, $FB, $FF, $FF, $00, $00, $A0, $FF
LE580:  .byte $FF, $03, $00, $00, $FE, $FF, $7F, $02, $20, $01, $FC, $FF, $FF, $03, $00, $00
LE590:  .byte $FC, $FF, $0F, $00, $F8, $7F, $8E, $2A, $00, $FC, $FF, $09, $00, $F8, $FF, $FF
LE5A0:  .byte $00, $00, $80, $FF, $0F, $5C, $EF, $4F, $15, $00, $A0, $FF, $FF, $01, $00, $E8
LE5B0:  .byte $FE, $FF, $00, $F9, $03, $38, $00, $FE, $FF, $0F, $00, $D8, $F7, $FF, $00, $00
LE5C0:  .byte $AC, $FF, $FF, $13, $00, $80, $FF, $9F, $0E, $70, $00, $7E, $82, $FF, $7F, $00
LE5D0:  .byte $00, $F8, $FF, $3F, $00, $00, $FC, $FF, $FF, $07, $00, $00, $F8, $FF, $5F, $00
LE5E0:  .byte $01, $E0, $FF, $FF, $03, $28, $80, $FF, $FF, $51, $82, $00, $FE, $E2, $38, $7E
LE5F0:  .byte $BE, $00, $A0, $FE, $3F, $FF, $02, $00, $A0, $FD, $3F, $F0, $13, $20, $F4, $FE
LE600:  .byte $07, $FA, $01, $80, $FE, $FF, $10, $00, $FC, $E7, $FF, $03, $40, $41, $FD, $3F
LE610:  .byte $00, $00, $F8, $FF, $1F, $18, $F0, $1F, $C0, $DE, $1F, $FD, $09, $00, $F8, $FF
LE620:  .byte $1F, $00, $00, $E8, $FF, $7F, $00, $22, $F0, $FF, $07, $F0, $F3, $2F, $00, $FC
LE630:  .byte $3F, $06, $00, $F8, $FF, $FE, $05, $00, $E0, $FF, $7F, $00, $00, $FE, $FF, $12
LE640:  .byte $2A, $00, $F8, $0F, $FD, $3F, $2A, $02, $00, $FF, $FF, $3F, $01, $00, $C0, $FF
LE650:  .byte $FF, $17, $00, $00, $BF, $FE, $FF, $00, $00, $80, $FF, $FF, $1F, $00, $80, $FE
LE660:  .byte $FF, $0F, $00, $07, $C0, $FF, $02, $FE, $1F, $C0, $3F, $00, $A4, $FE, $7F, $00
LE670:  .byte $3E, $00, $3F, $FE, $5F, $00, $F4, $9F, $00, $B0, $FF, $07, $8E, $1F, $07, $00
LE680:  .byte $EC, $FF, $7F, $16, $00, $80, $FF, $FF, $7F, $00, $00, $D0, $FF, $FA, $0F, $00
LE690:  .byte $3A, $80, $F6, $FF, $07, $60, $03, $B0, $FF, $07, $88, $EF, $FF, $49, $00, $00
LE6A0:  .byte $FE, $FF, $04, $80, $FF, $00, $FA, $FF, $3F, $00, $00, $00, $FE, $FF, $3F, $00
LE6B0:  .byte $88, $FB, $FF, $1F, $00, $C0, $FF, $2F, $00, $E0, $D7, $7F, $02, $C0, $FF, $01
LE6C0:  .byte $FF, $01, $FC, $C3, $01, $E0, $FF, $07, $00, $E0, $FF, $FF, $02, $00, $5E, $17
LE6D0:  .byte $FE, $FF, $05, $80, $92, $02, $F8, $FF, $3F, $09, $00, $E0, $FF, $FF, $00, $80
LE6E0:  .byte $1E, $F8, $7F, $EE, $07, $00, $FC, $E7, $0F, $E0, $2F, $00, $FC, $FF, $0F, $00
LE6F0:  .byte $00, $F8, $FF, $C0, $7F, $00, $FF, $4B, $01, $C0, $AE, $FF, $07, $80, $FF, $27
LE700:  .byte $A0, $03, $B8, $FE, $FF, $00, $00, $FE, $3F, $80, $FF, $07, $80, $9F, $A0, $FE
LE710:  .byte $96, $00, $F8, $FF, $27, $00, $E0, $FF, $7F, $00, $00, $A1, $FF, $FF, $01, $00
LE720:  .byte $E0, $FF, $FF, $2F, $00, $00, $F8, $FF, $77, $BF, $00, $00, $C0, $FE, $1F, $3F
LE730:  .byte $01, $60, $FB, $3F, $00, $F8, $A5, $7F, $00, $7E, $02, $FD, $81, $FF, $C0, $7E
LE740:  .byte $00, $E0, $BF, $FF, $07, $00, $00, $FF, $0F, $FC, $3F, $A0, $02, $80, $BA, $FE
LE750:  .byte $BF, $B0, $0F, $00, $FE, $03, $10, $FE, $FF, $00, $FE, $03, $60, $A5, $FF, $24
LE760:  .byte $80, $FF, $1F, $80, $FF, $00, $F8, $17, $00, $FF, $FF, $27, $20, $00, $F8, $2F
LE770:  .byte $F0, $3F, $FA, $AB, $00, $2E, $00, $F8, $FF, $FF, $02, $00, $00, $FF, $FF, $03
LE780:  .byte $00, $36, $FD, $3F, $F6, $13, $00, $B0, $FF, $3F, $80, $1F, $C0, $7F, $00, $18
LE790:  .byte $FE, $FF, $3F, $00, $00, $FA, $0F, $FC, $07, $80, $AB, $FF, $2F, $00, $C0, $FE
LE7A0:  .byte $1F, $C0, $7F, $02, $E0, $FF, $03, $D8, $8B, $42, $FF, $4F, $00, $00, $FE, $FF
LE7B0:  .byte $3F, $00, $48, $FF, $01, $60, $FF, $0F, $00, $FA, $7F, $00, $F8, $FA, $FF, $00
LE7C0:  .byte $00, $FC, $87, $FE, $03, $FA, $05, $E8, $6F, $01, $FC, $E8, $2F, $E0, $2F, $00
LE7D0:  .byte $E8, $3F, $87, $15, $FB, $0F, $80, $EB, $0F, $00, $FF, $0F, $14, $40, $FF, $FF
LE7E0:  .byte $27, $00, $AC, $60, $FB, $FF, $00, $00, $FC, $3F, $2A, $00, $FB, $5F, $00, $FF
LE7F0:  .byte $7F, $02, $00, $FA, $FF, $17, $00, $A8, $FB, $76, $E0, $02, $F8, $83, $FF, $0B
LE800:  .byte $60, $58, $FF, $1F, $00, $FA, $0F, $03, $C0, $FE, $FA, $5F, $00, $00, $F0, $FF
LE810:  .byte $7F, $01, $E0, $BF, $00, $FE, $02, $FE, $0F, $2A, $30, $FD, $2C, $F0, $EF, $07
LE820:  .byte $80, $FF, $02, $C0, $FF, $3F, $00, $E8, $07, $FA, $1F, $00, $B0, $FF, $3B, $C0
LE830:  .byte $E2, $2F, $09, $E8, $07, $F0, $FF, $17, $00, $FC, $67, $C9, $8F, $00, $0E, $FE
LE840:  .byte $65, $AB, $FF, $00, $50, $A0, $DF, $FF, $17, $00, $F0, $01, $FF, $5F, $15, $00
LE850:  .byte $FE, $82, $87, $FE, $0B, $C0, $3E, $01, $FA, $FF, $0B, $C0, $07, $A0, $FF, $81
LE860:  .byte $9F, $C0, $FE, $03, $F8, $01, $E8, $FF, $0F, $E0, $07, $00, $FC, $FF, $09, $E0
LE870:  .byte $38, $F8, $FF, $05, $08, $EC, $FF, $81, $EE, $07, $00, $BC, $EC, $3F, $F0, $82
LE880:  .byte $3A, $61, $DA, $5F, $01, $05, $DF, $03, $F8, $7F, $62, $13, $80, $FF, $07, $F0
LE890:  .byte $56, $2F, $80, $FF, $02, $80, $FF, $FF, $00, $14, $2F, $F0, $FF, $E0, $09, $E0
LE8A0:  .byte $47, $F7, $0B, $C0, $0F, $12, $FF, $2F, $00, $F8, $FF, $FF, $02, $00, $1C, $F8
LE8B0:  .byte $7F, $02, $00, $FF, $FF, $00, $FE, $03, $2B, $00, $E0, $DF, $FF, $13, $D0, $00
LE8C0:  .byte $E8, $FF, $F5, $02, $C0, $7F, $E0, $C7, $80, $FF, $07, $C0, $03, $D8, $FE, $BF
LE8D0:  .byte $00, $7E, $A0, $FF, $00, $FC, $2F, $58, $00, $F8, $FF, $BF, $00, $00, $F0, $FF
LE8E0:  .byte $0F, $14, $04, $FE, $FF, $00, $80, $ED, $FF, $2F, $00, $00, $FE, $BF, $25, $41
LE8F0:  .byte $E0, $FF, $07, $A8, $87, $4E, $FE, $83, $70, $5E, $38, $80, $FF, $07, $7E, $00
LE900:  .byte $F8, $0F, $FE, $07, $80, $FE, $C5, $0F, $0C, $C0, $BF, $FD, $07, $80, $5D, $1F
LE910:  .byte $07, $E0, $DF, $3E, $00, $C0, $8E, $FE, $D7, $0F, $00, $F8, $FF, $0F, $00, $74
LE920:  .byte $00, $FF, $5F, $10, $E0, $FE, $7F, $C0, $46, $E8, $BB, $00, $E8, $FF, $7F, $02
LE930:  .byte $00, $F8, $FF, $17, $00, $A0, $FF, $7F, $00, $C0, $FE, $FF, $00, $00, $A1, $FF
LE940:  .byte $F7, $1F, $00, $80, $7F, $00, $FE, $FF, $3F, $00, $00, $FC, $FF, $0F, $00, $80
LE950:  .byte $FF, $2F, $7E, $00, $3F, $0F, $1C, $00, $FE, $FF, $00, $08, $FC, $FF, $7F, $01
LE960:  .byte $00, $74, $FD, $07, $80, $FD, $FF, $00, $02, $6A, $FF, $BF, $00, $00, $E8, $FF
LE970:  .byte $0F, $00, $D0, $FF, $FF, $E8, $01, $A0, $FF, $01, $E0, $FF, $0F, $BC, $00, $F0
LE980:  .byte $FF, $03, $00, $E8, $FF, $3F, $42, $03, $80, $FD, $FF, $81, $0B, $80, $FE, $1D
LE990:  .byte $F8, $2F, $00, $D8, $3F, $FC, $1F, $00, $40, $FB, $FF, $03, $C0, $F9, $FF, $00
LE9A0:  .byte $00, $FE, $FF, $05, $00, $C0, $FF, $FF, $00, $B0, $82, $FF, $89, $93, $E4, $7F
LE9B0:  .byte $00, $20, $FA, $FF, $7F, $01, $00, $C0, $FF, $FF, $04, $00, $FE, $FF, $00, $00
LE9C0:  .byte $FB, $FF, $0F, $00, $80, $FF, $FF, $01, $00, $E8, $DF, $F6, $02, $F0, $FF, $C0
LE9D0:  .byte $01, $00, $FF, $FF, $1F, $00, $D0, $FF, $25, $01, $E8, $FF, $3F, $00, $C0, $FF
LE9E0:  .byte $5F, $00, $00, $EA, $FF, $0F, $00, $FA, $FF, $0B, $04, $08, $E0, $FF, $FF, $0F
LE9F0:  .byte $00, $05, $B4, $FF, $0B, $9D, $FD, $01, $00, $EC, $FF, $FF, $00, $80, $1F, $3B
LEA00:  .byte $24, $E0, $FF, $2F, $00, $FC, $C1, $E3, $07, $80, $FF, $FA, $01, $E0, $1A, $F9
LEA10:  .byte $FF, $2A, $00, $E0, $FF, $89, $16, $00, $7E, $FD, $3F, $88, $16, $80, $FE, $FE
LEA20:  .byte $07, $80, $1E, $E0, $FF, $03, $27, $00, $FC, $FF, $57, $00, $00, $FE, $FF, $07
LEA30:  .byte $00, $A0, $FF, $FF, $03, $00, $CE, $FF, $DF, $00, $E0, $07, $FE, $4B, $20, $F0
LEA40:  .byte $03, $FF, $C9, $0F, $3A, $00, $E2, $FF, $FF, $03, $00, $A0, $FF, $3F, $00, $9C
LEA50:  .byte $FB, $0B, $00, $AA, $FE, $FF, $04, $00, $EC, $FF, $7F, $00, $C0, $BB, $AF, $00
LEA60:  .byte $F8, $FF, $C0, $34, $00, $E8, $FF, $5F, $40, $41, $80, $FF, $0F, $FC, $00, $FE
LEA70:  .byte $43, $FC, $25, $FD, $23, $00, $40, $FF, $0F, $5C, $1F, $70, $FE, $D5, $09, $00
LEA80:  .byte $AF, $FE, $AB, $00, $80, $FF, $FF, $01, $00, $F8, $FF, $97, $20, $00, $FC, $FF
LEA90:  .byte $0F, $00, $FF, $09, $5C, $05, $F8, $FF, $02, $80, $FD, $E2, $D1, $BF, $00, $A0
LEAA0:  .byte $EE, $3F, $80, $FF, $27, $00, $80, $7F, $FF, $FF, $03, $00, $00, $FB, $FF, $0B
LEAB0:  .byte $00, $F8, $4E, $FD, $7F, $00, $00, $D6, $FD, $FF, $01, $00, $E8, $FF, $1F, $18
LEAC0:  .byte $00, $FC, $DF, $7E, $00, $C0, $FF, $17, $05, $00, $E8, $FF, $0F, $00, $FF, $8F
LEAD0:  .byte $02, $F8, $B9, $FF, $03, $00, $E8, $FF, $81, $FE, $00, $B0, $FF, $27, $00, $FC
LEAE0:  .byte $DA, $3F, $02, $C0, $FF, $1F, $00, $F0, $F7, $D3, $00, $A0, $FF, $FF, $01, $00
LEAF0:  .byte $F4, $FF, $07, $00, $80, $F8, $FF, $1F, $00, $FE, $FF, $00, $00, $FC, $FF, $0F
LEB00:  .byte $00, $F8, $FF, $43, $00, $B0, $5E, $FF, $7F, $00, $98, $F6, $1F, $00, $F0, $9F
LEB10:  .byte $AB, $7E, $00, $40, $FF, $FF, $00, $00, $7E, $E7, $4F, $E0, $05, $FE, $03, $F8
LEB20:  .byte $80, $FD, $3F, $00, $E0, $FF, $01, $00, $FB, $FF, $FF, $00, $00, $FC, $BF, $00
LEB30:  .byte $E0, $FF, $01, $6E, $C5, $FE, $13, $02, $00, $FC, $FF, $81, $9F, $80, $FE, $43
LEB40:  .byte $03, $F1, $1F, $FD, $2F, $00, $00, $F8, $FF, $27, $00, $EC, $BF, $F8, $8F, $00
LEB50:  .byte $FE, $03, $04, $F0, $FF, $FF, $01, $00, $E8, $FF, $FF, $00, $00, $E8, $FF, $7F
LEB60:  .byte $00, $00, $FA, $FF, $02, $D8, $1D, $EC, $81, $B3, $FD, $0B, $00, $F8, $FB, $BF
LEB70:  .byte $00, $00, $E0, $FF, $7F, $02, $F8, $7F, $00, $07, $80, $FF, $7F, $01, $80, $FB
LEB80:  .byte $FF, $03, $00, $7A, $EC, $3F, $80, $FF, $D0, $0F, $00, $D0, $FE, $FF, $00, $C0
LEB90:  .byte $FF, $23, $80, $FF, $C0, $FF, $03, $00, $FE, $01, $57, $7F, $01, $C0, $FE, $BF
LEBA0:  .byte $00, $FA, $03, $FF, $0F, $00, $7F, $01, $0D, $C4, $FF, $9F, $00, $A0, $FF, $FF
LEBB0:  .byte $01, $00, $F8, $BF, $AB, $00, $A0, $FF, $3F, $40, $00, $FD, $FF, $02, $50, $D9
LEBC0:  .byte $FF, $07, $00, $FC, $07, $7E, $F0, $C0, $FE, $13, $02, $88, $FF, $FF, $28, $02
LEBD0:  .byte $40, $F7, $FF, $05, $D0, $0F, $AD, $06, $E0, $FF, $7F, $00, $80, $7E, $6E, $3B
LEBE0:  .byte $70, $48, $EC, $A1, $FF, $07, $80, $AF, $F8, $7F, $00, $00, $F0, $FF, $07, $44
LEBF0:  .byte $EE, $3F, $00, $EC, $BF, $5E, $00, $38, $DB, $FF, $00, $58, $F0, $FF, $09, $00

DMCGruntDat:
LEC00:  .byte $55, $AB, $D5, $AA, $5A, $4B, $95, $4A, $55, $A9, $54, $D5, $D6, $AA, $A4, $35
LEC10:  .byte $4B, $89, $52, $55, $D9, $5B, $5F, $57, $75, $2A, $49, $42, $92, $22, $4D, $D5
LEC20:  .byte $76, $DB, $D7, $2A, $A5, $24, $92, $28, $52, $A9, $7F, $DF, $DB, $6D, $4F, $89
LEC30:  .byte $20, $24, $82, $88, $D2, $7B, $77, $AD, $AA, $54, $8A, $41, $48, $FF, $7F, $57
LEC40:  .byte $7B, $5F, $12, $02, $92, $22, $02, $6A, $7B, $57, $AA, $6A, $A5, $48, $10, $FF
LEC50:  .byte $FF, $77, $73, $7F, $45, $20, $40, $89, $08, $2A, $B5, $53, $95, $AA, $AA, $24
LEC60:  .byte $6A, $FF, $FF, $BF, $D6, $57, $82, $00, $28, $49, $88, $A8, $D6, $AC, $A4, $D2
LEC70:  .byte $8C, $DA, $FF, $FF, $BF, $D6, $B5, $08, $08, $20, $29, $82, $90, $D6, $56, $25
LEC80:  .byte $A9, $A6, $DD, $FF, $FF, $AF, $DA, $35, $22, $80, $A0, $A2, $80, $A0, $5A, $A7
LEC90:  .byte $94, $4A, $5B, $FD, $FF, $FF, $CD, $7A, $8B, $02, $01, $8A, $04, $22, $88, $76
LECA0:  .byte $55, $52, $4A, $DB, $FF, $FF, $D7, $76, $3F, $2A, $20, $48, $49, $20, $08, $75
LECB0:  .byte $97, $8A, $AC, $56, $FA, $CA, $8A, $A8, $A5, $4A, $01, $02, $95, $22, $08, $A0

DMCLaugh1Dat:
LECC0:  .byte $4A, $52, $55, $B5, $55, $33, $95, $4A, $55, $AB, $55, $A9, $2A, $55, $55, $DD
LECD0:  .byte $37, $2A, $09, $4A, $AB, $6D, $57, $4A, $29, $AA, $B5, $D5, $9A, $4A, $A5, $54
LECE0:  .byte $AB, $5A, $A5, $52, $55, $AA, $FD, $17, $A5, $00, $69, $6B, $7B, $93, $A2, $92
LECF0:  .byte $74, $5B, $6D, $8D, $A2, $92, $5A, $5B, $AA, $2A, $4A, $DD, $FF, $98, $04, $20
LED00:  .byte $B7, $76, $AF, $48, $89, $64, $77, $75, $AD, $88, $94, $B2, $B6, $4A, $8B, $A2
LED10:  .byte $FF, $8F, $29, $00, $74, $CB, $FF, $08, $2A, $22, $FD, $AD, $5D, $09, $64, $49
LED20:  .byte $DD, $2A, $25, $EA, $FF, $D3, $08, $00, $7E, $F6, $3D, $02, $25, $52, $FF, $D3
LED30:  .byte $2D, $00, $35, $5A, $9F, $88, $D6, $FF, $B3, $00, $80, $7D, $FE, $0F, $80, $0A
LED40:  .byte $ED, $DF, $BA, $02, $90, $A6, $ED, $0A, $F2, $FF, $D3, $20, $00, $FD, $FC, $2F
LED50:  .byte $00, $0C, $DE, $7F, $D3, $02, $C0, $9A, $BE, $08, $FD, $BF, $0E, $01, $F0, $4F
LED60:  .byte $FF, $02, $40, $D2, $FF, $1D, $0D, $00, $EE, $D1, $23, $F8, $FF, $1C, $08, $E0
LED70:  .byte $3F, $FF, $03, $00, $C3, $FF, $37, $20, $00, $FD, $C3, $42, $FF, $3F, $03, $00
LED80:  .byte $FC, $DF, $F3, $00, $C0, $F5, $FF, $09, $00, $E0, $7F, $20, $F4, $FF, $37, $00
LED90:  .byte $C0, $FF, $3F, $03, $00, $D7, $FF, $13, $00, $50, $7F, $03, $F8, $FF, $3B, $00
LEDA0:  .byte $C0, $FF, $3F, $01, $C0, $E7, $FF, $03, $00, $B0, $BF, $00, $FD, $FF, $0E, $00
LEDB0:  .byte $F8, $FF, $8B, $00, $F0, $F7, $3F, $00, $00, $F7, $07, $E0, $FF, $F3, $00, $C0
LEDC0:  .byte $FF, $3F, $08, $C0, $EF, $FF, $02, $00, $F0, $3F, $00, $FF, $CF, $03, $80, $FF
LEDD0:  .byte $F7, $00, $00, $FF, $FF, $03, $00, $D0, $BF, $00, $FF, $3F, $0F, $00, $FD, $EF
LEDE0:  .byte $03, $00, $FC, $FD, $0F, $00, $C0, $FF, $00, $FC, $3F, $0F, $00, $FE, $DF, $03
LEDF0:  .byte $00, $FC, $FF, $0F, $00, $40, $FF, $02, $FC, $3F, $0F, $00, $FC, $FF, $03, $00
LEE00:  .byte $FC, $FF, $0F, $00, $40, $FF, $01, $FC, $3F, $0F, $00, $FC, $FF, $03, $00, $FC
LEE10:  .byte $FF, $2F, $00, $00, $FF, $03, $F8, $BF, $2E, $00, $FC, $DF, $0F, $00, $F0, $F7
LEE20:  .byte $3F, $00, $00, $FF, $03, $F0, $FF, $BC, $00, $F0, $FF, $3E, $00, $C0, $DF, $FF
LEE30:  .byte $00, $00, $FC, $3F, $00, $FF, $CF, $03, $00, $FF, $FF, $02, $00, $7E, $FF, $07
LEE40:  .byte $00, $C0, $FF, $02, $F0, $FF, $BB, $00, $C0, $FF, $3F, $00, $80, $FF, $FF, $00
LEE50:  .byte $00, $FD, $0F, $08, $C1, $FF, $BF, $00, $C0, $FF, $3F, $00, $C0, $FF, $5F, $00
LEE60:  .byte $D0, $DD, $9D, $08, $A2, $FF, $FF, $00, $00, $FC, $FF, $08, $00, $FF, $77, $09
LEE70:  .byte $A0, $D6, $B7, $89, $A4, $62, $FF, $3F, $00, $A0, $FD, $55, $0A, $62, $DD, $55

DMCLaugh2Dat:
LEE80:  .byte $75, $FF, $07, $00, $C0, $FF, $0F, $40, $D0, $FF, $0F, $02, $E8, $DF, $A8, $20
LEE90:  .byte $C8, $FF, $FF, $04, $00, $FC, $FF, $03, $00, $FC, $FF, $0F, $00, $D0, $FF, $03
LEEA0:  .byte $00, $D0, $FF, $FF, $00, $00, $FF, $FF, $00, $00, $FF, $FF, $03, $00, $FC, $BF
LEEB0:  .byte $00, $F0, $FF, $3F, $00, $C0, $FF, $BF, $00, $00, $FD, $FF, $00, $00, $F0, $0F
LEEC0:  .byte $FC, $FF, $3C, $00, $F0, $FF, $3F, $00, $F0, $FF, $3F, $00, $00, $C0, $F2, $FF
LEED0:  .byte $DF, $00, $00, $FF, $FF, $00, $00, $FF, $FF, $01, $00, $00, $FC, $FF, $FF, $00
LEEE0:  .byte $C0, $FF, $7F, $00, $80, $FF, $FF, $00, $00, $00, $FF, $FF, $0F, $30, $FC, $FF
LEEF0:  .byte $0F, $00, $F0, $FF, $0F, $00, $00, $F0, $FF, $3F, $F0, $C3, $FF, $3F, $F0, $80
LEF00:  .byte $FF, $0F, $00, $00, $F0, $FF, $0F, $F0, $C3, $FF, $2F, $FC, $03, $FC, $03, $F0
LEF10:  .byte $0F, $FC, $FF, $00, $FF, $C0, $FF, $00, $3F, $00, $2C, $00, $FF, $C0, $FF, $0F
LEF20:  .byte $FC, $03, $FC, $2F, $00, $00, $F0, $03, $FC, $C0, $FF, $2F, $FC, $00, $F0, $3F
LEF30:  .byte $00, $00, $C0, $0B, $3C, $FC, $FF, $0F, $3F, $00, $FC, $0F, $00, $00, $FE, $03
LEF40:  .byte $0F, $FF, $FF, $03, $3F, $70, $FF, $0F, $00, $00, $F8, $C0, $0F, $FF, $FF, $C3
LEF50:  .byte $0F, $10, $FF, $03, $00, $00, $FF, $C0, $C3, $FF, $FF, $C2, $0F, $C0, $FF, $03
LEF60:  .byte $00, $00, $3F, $C0, $C3, $FF, $FF, $C0, $03, $CC, $FF, $03, $00, $00, $BF, $C0
LEF70:  .byte $C3, $FF, $FF, $C3, $03, $CC, $FF, $03, $00, $00, $FD, $00, $03, $FF, $FF, $07
LEF80:  .byte $0F, $F0, $FF, $0F, $00, $00, $FC, $03, $00, $FC, $FF, $3F, $3C, $C0, $FF, $3F
LEF90:  .byte $00, $00, $F0, $2F, $00, $00, $FF, $FF, $0F, $3F, $F0, $FF, $0F, $00, $00, $FE
LEFA0:  .byte $0F, $00, $00, $FF, $FF, $0F, $00, $F0, $FF, $2F, $00, $00, $FF, $0F, $00, $00
LEFB0:  .byte $FE, $FF, $FF, $03, $00, $FF, $0F, $00, $00, $FD, $FF, $03, $40, $B6, $FF, $F7
LEFC0:  .byte $FF, $47, $09, $00, $01, $F0, $2D, $94, $22, $77, $6B, $57, $A0, $FD, $DB, $FF
LEFD0:  .byte $21, $29, $CA, $26, $80, $02, $ED, $A9, $56, $52, $B7, $DA, $2A, $D6, $AD, $FD
LEFE0:  .byte $09, $D9, $52, $B7, $08, $88, $A9, $4A, $73, $29, $AA, $B6, $55, $A9, $AA, $55
LEFF0:  .byte $5B, $CB, $54, $6D, $55, $AD, $4A, $35, $55, $93, $2A, $55, $55, $95, $4A, $55

DMCLaugh3Dat:
LF000:  .byte $36, $89, $52, $D5, $AD, $8A, $4A, $D5, $75, $95, $48, $5A, $5B, $55, $4A, $55
LF010:  .byte $6A, $F7, $1F, $00, $88, $FD, $3F, $24, $80, $F7, $AF, $09, $82, $FD, $AD, $88
LF020:  .byte $50, $AB, $5A, $23, $FB, $FF, $00, $00, $FC, $FF, $14, $00, $FC, $3F, $8F, $00
LF030:  .byte $FD, $CA, $2A, $80, $2D, $D9, $FF, $BF, $00, $00, $FC, $FF, $0A, $00, $FC, $FF
LF040:  .byte $03, $40, $BD, $3E, $0A, $40, $D1, $FF, $FF, $00, $00, $FC, $FF, $0F, $00, $F8
LF050:  .byte $FF, $07, $00, $3D, $BD, $02, $80, $F6, $FF, $5F, $00, $C0, $FF, $7F, $00, $00
LF060:  .byte $FF, $FF, $03, $00, $F8, $9F, $00, $F0, $FF, $FF, $00, $00, $FF, $FF, $00, $00
LF070:  .byte $FF, $FF, $03, $00, $E0, $3F, $00, $FE, $FF, $1D, $00, $F0, $FF, $0F, $00, $F0
LF080:  .byte $FF, $3F, $00, $00, $FC, $0F, $C0, $FF, $7F, $03, $00, $FD, $FF, $00, $00, $FE
LF090:  .byte $FF, $0F, $00, $80, $FF, $00, $F8, $FF, $3F, $00, $C0, $FF, $3F, $00, $C0, $FF
LF0A0:  .byte $FF, $00, $00, $F0, $3F, $00, $FD, $FF, $0F, $00, $F8, $FF, $03, $00, $F8, $FF
LF0B0:  .byte $3F, $00, $00, $FC, $07, $C0, $FF, $FF, $03, $00, $FC, $FF, $01, $00, $FC, $FF
LF0C0:  .byte $0F, $00, $C0, $FF, $02, $80, $FF, $FF, $03, $00, $FE, $FF, $02, $00, $FC, $FF
LF0D0:  .byte $0F, $00, $C0, $FF, $21, $00, $FC, $FF, $2F, $00, $F0, $FF, $0F, $00, $F0, $FF
LF0E0:  .byte $3F, $00, $80, $FF, $0F, $00, $60, $FF, $FF, $00, $00, $FE, $FF, $03, $00, $FC
LF0F0:  .byte $FF, $07, $00, $FE, $DD, $22, $40, $AD, $FD, $FF, $0B, $00, $D8, $DD, $22, $24
LF100:  .byte $D5, $6D, $55, $4A, $55, $6B, $A5, $B2, $54, $D5, $B5, $6C, $AB, $A9, $24, $55
LF110:  .byte $95, $54, $4B, $AD, $4A, $55, $55, $AB, $56, $A9, $B2, $6A, $AD, $4A, $AD, $AA
LF120:  .byte $56, $49, $A9, $6A, $2B, $4A, $55, $B5, $A6, $A5, $52, $75, $AD, $4A, $CA, $5A
LF130:  .byte $AB, $2A, $69, $55, $B5, $2A, $A9, $AA, $56, $55, $2A, $55, $AD, $55, $A5, $AA

DMCLaugh4Dat:
LF140:  .byte $59, $95, $65, $95, $A9, $9A, $AA, $AA, $AA, $69, $AA, $A6, $AA, $6A, $D5, $2D
LF150:  .byte $89, $52, $55, $B7, $2A, $A9, $94, $75, $6D, $A5, $48, $6A, $AD, $55, $A5, $54
LF160:  .byte $A5, $DA, $FD, $17, $00, $88, $FE, $BF, $50, $20, $F0, $7F, $AB, $09, $82, $F5
LF170:  .byte $B7, $8A, $40, $D5, $AA, $56, $49, $FB, $FF, $02, $00, $E0, $FF, $0F, $0B, $00
LF180:  .byte $F7, $5F, $2F, $02, $D8, $2F, $B5, $0A, $60, $4B, $DA, $FF, $FF, $00, $00, $D0
LF190:  .byte $FF, $AF, $02, $00, $FD, $FF, $07, $00, $D6, $E7, $95, $00, $52, $E1, $FF, $FF
LF1A0:  .byte $03, $00, $C0, $FF, $FF, $01, $00, $FC, $FF, $0F, $00, $F0, $E3, $AB, $00, $A0
LF1B0:  .byte $F6, $FF, $3F, $01, $00, $FC, $FF, $3F, $00, $00, $FF, $FF, $07, $00, $A0, $7F
LF1C0:  .byte $07, $00, $FC, $FF, $FF, $00, $00, $FC, $FF, $0F, $00, $C0, $FF, $FF, $03, $00
LF1D0:  .byte $00, $FF, $07, $C0, $FF, $FF, $0E, $00, $C0, $FF, $FF, $00, $00, $FC, $FF, $3F
LF1E0:  .byte $00, $00, $F8, $3F, $00, $FC, $FF, $F7, $00, $00, $FF, $FF, $03, $00, $E0, $FF
LF1F0:  .byte $FF, $02, $00, $C0, $FF, $02, $C0, $FF, $FF, $03, $00, $F0, $FF, $3F, $00, $00
LF200:  .byte $FF, $FF, $0F, $00, $00, $FD, $0F, $00, $FF, $FF, $3D, $00, $C0, $FF, $FF, $00
LF210:  .byte $00, $FC, $FF, $3F, $00, $00, $F0, $BF, $00, $F0, $FF, $FF, $01, $00, $F8, $FF
LF220:  .byte $0F, $00, $C0, $FF, $FF, $07, $00, $00, $FF, $07, $02, $F0, $FF, $FF, $00, $00
LF230:  .byte $FF, $FF, $03, $00, $E0, $FF, $FF, $03, $00, $C0, $FF, $83, $00, $E0, $FF, $FF
LF240:  .byte $03, $00, $F0, $FF, $3F, $00, $00, $FF, $FF, $2F, $00, $80, $FF, $8F, $00, $00
LF250:  .byte $F7, $FF, $3F, $00, $00, $FE, $FF, $0B, $00, $E0, $FF, $FF, $00, $00, $7F, $77
LF260:  .byte $0B, $40, $55, $DB, $FF, $BF, $02, $00, $74, $77, $8D, $82, $52, $6D, $5B, $95
LF270:  .byte $52, $55, $AD, $55, $2A, $53, $55, $6D, $2D, $6D, $AB, $A9, $A2, $A8, $55, $4A
LF280:  .byte $55, $55, $D5, $52, $55, $55, $AD, $6A, $96, $2A, $AB, $56, $AB, $4A, $B5, $AA
LF290:  .byte $56, $25, $95, $AA, $D6, $8A, $52, $55, $B5, $A6, $AA, $8A, $6A, $5B, $AB, $A2
LF2A0:  .byte $D2, $5A, $AD, $2A, $A5, $66, $55, $AB, $52, $AA, $AA, $56, $55, $A9, $54, $B5
LF2B0:  .byte $5A, $55, $A9, $B4, $6A, $55, $65, $AA, $55, $55, $55, $55, $AA, $56, $55, $55

DMCLaugh5Dat:
LF2C0:  .byte $D7, $56, $A5, $48, $6A, $AD, $55, $55, $4A, $55, $A5, $DA, $FF, $95, $80, $80
LF2D0:  .byte $E8, $FF, $2D, $92, $20, $F0, $FD, $AD, $16, $22, $68, $F7, $AD, $8A, $08, $55
LF2E0:  .byte $AB, $6A, $55, $D2, $FE, $FF, $00, $00, $40, $FF, $FF, $70, $80, $80, $FF, $37
LF2F0:  .byte $BD, $08, $C0, $FD, $4A, $AD, $02, $62, $4B, $A9, $FF, $FF, $2F, $00, $00, $F0
LF300:  .byte $FF, $2F, $0A, $00, $F0, $FF, $DF, $01, $00, $DB, $A7, $37, $0A, $A0, $34, $F4
LF310:  .byte $FF, $FF, $03, $00, $00, $FE, $FF, $3F, $00, $00, $FC, $FF, $3F, $00, $40, $5F
LF320:  .byte $F9, $2A, $00, $A1, $DA, $FF, $FF, $12, $00, $00, $FF, $FF, $3F, $00, $00, $FC
LF330:  .byte $FF, $7F, $02, $00, $A8, $FD, $1D, $00, $D0, $FF, $FF, $3F, $00, $00, $FC, $FF
LF340:  .byte $3F, $00, $00, $F8, $FF, $FF, $01, $00, $00, $FD, $3F, $20, $F0, $FF, $FF, $2C
LF350:  .byte $00, $00, $FF, $FF, $0F, $00, $00, $FD, $FF, $DF, $00, $00, $40, $FF, $1D, $00
LF360:  .byte $FD, $FF, $3F, $03, $00, $E0, $FF, $FF, $03, $00, $C0, $FF, $FF, $3B, $00, $00
LF370:  .byte $C0, $FF, $0B, $00, $FF, $FF, $CF, $02, $00, $F0, $FF, $FF, $00, $00, $E0, $FF
LF380:  .byte $FF, $2F, $00, $00, $E0, $FF, $02, $40, $FF, $FF, $F3, $00, $00, $FC, $FF, $3F
LF390:  .byte $00, $00, $F4, $FF, $FF, $03, $00, $00, $F6, $BF, $00, $D0, $FF, $FF, $37, $00
LF3A0:  .byte $00, $FC, $FF, $1F, $00, $00, $FC, $FF, $FF, $03, $00, $00, $FD, $3F, $00, $40

;----------------------------------------------------------------------------------------------------

;Unused.
LF3B0:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LF3C0:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LF3D0:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LF3E0:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LF3F0:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

;----------------------------------------------------------------------------------------------------

GetNoteLength:
LF400:  AND #$1F                ;Limit index into table to 32 positions.
LF402:  CLC                     ;
LF403:  ADC NoteLengthsBase     ;Add index to the base index for this music.
LF406:  TAY                     ;
LF407:  LDA NoteLengthsTbl,Y    ;Get the note length from the table.
LF40A:  RTS                     ;

SetSQ1Control:
LF40B:  STX SQ1Cntrl0           ;Set duty cycle, length counter and volume control bits on SQ1.
LF40E:  STY SQ1Cntrl1           ;Set sweep unit control bits on SQ1.
LF411:  RTS                     ;

SQ2CntrlAndSwpDis:
LF412:  LDY #$7F                ;Disable the sweep unit on SQ2.

SetSQ2Control:
LF414:  STX SQ2Cntrl0           ;Set duty cycle, length counter and volume control bits on SQ2.
LF417:  STY SQ2Cntrl1           ;Set sweep unit control bits on SQ2.
LF41A:  RTS                     ;

UpdateSQ2:
LF41B:  JSR SetSQ2Control       ;($F414)Set SQ2 control registers.

UpdateSQ2Note:
LF41E:  LDX #AUD_SQ2_INDEX      ;Prepare to update SQ2 note.
LF420:  BNE GetChannelNote      ;Branch always.

UpdateTriNote:
LF422:  LDX #AUD_TRI_INDEX      ;Prepare to update triangle note.
LF424:  BNE GetChannelNote      ;Branch always.

UpdateSQ1:
LF426:  JSR SetSQ1Control       ;($F40B)Set control registers for SQ1.

UpdateSQ1Note:
LF429:  LDX #AUD_SQ1_INDEX      ;Prepare to update SQ1 note.

GetChannelNote:
LF42B:  TAY                     ;Get lower bits of next note to play for given channel.
LF42C:  LDA NotesTbl+1,Y        ;Is there a next note to play?
LF42F:  BEQ GetNoteDone         ;If not, branch to exit.

LF431:  STA SQ1Cntrl2,X         ;Update channel frequency lower bits hardware.

LF434:  CPX #AUD_SQ1_INDEX      ;Is this SQ0?
LF436:  BNE +                   ;If not, branch.

LF438:  STA SQ1LoFreqBits       ;Save lower frequenct bits of SQ1.
LF43B:  BNE GetNoteUpperBits    ;

LF43D:* CPX #AUD_SQ2_INDEX      ;Is this SQ1?
LF43F:  BNE GetNoteUpperBits    ;If not, branch.

LF441:  STA SQ2LoFreqBits       ;Save lower frequenct bits of SQ2.

GetNoteUpperBits:
LF444:  LDA NotesTbl,Y          ;Get the upper bits of next note to play for given channel.
LF447:  ORA #$08                ;Set length counter to 1(turn on output of channel).
LF449:  STA SQ1Cntrl3,X         ;Update channel frequency upper bits hardware.

GetNoteDone:
LF44C:  RTS                     ;Done updating the given channel's note to play.

;----------------------------------------------------------------------------------------------------

;The following arelogarithmic sweep functions.  They increase the frequency.  As the frequency -->
;gets higher, the change in frequency gets less. The functions set the delta frequency to -->
;different amounts. The higher the divide number, the slower the frequency sweeps. These -->
;functions are used in the opponent punch SFX.

LogDiv64:
LF44D:  LSR                     ;Slowest logarithmic sweep.

LogDiv32:
LF44E:  LSR                     ;Next slowest logarithmic sweep.

LogDiv16:
LF44F:  LSR                     ;A faster logarithmic sweep.

LogDiv8:
LF450:  LSR                     ;
LF451:  LSR                     ;Divide by 8.
LF452:  LSR                     ;
LF453:  STA GenByteE0           ;Is there anything left to subtract?
LF455:  BNE +                   ;If so, branch. Frequency must increase a minimal amount.

LF457:  INC GenByteE0           ;Set amount to subtract to 1.

LF459:* TYA                     ;
LF45A:  SEC                     ;Return the logarithmic increase in the frequency in A.
LF45B:  SBC GenByteE0           ;
LF45D:  RTS                     ;

;----------------------------------------------------------------------------------------------------

LF45E:  LDA SQ1SFXTimer
LF461:  BNE $F466

LF463:  LDA SQ1NoteRemain
LF466:  LDX #$00
LF468:  LDY SQ1LoFreqBits
LF46B:  BNE $F47A

LF46D:  LDA SQ2SFXTimer
LF470:  BNE $F475

LF472:  LDA SQ2NoteRemain

LF475:  LDX #$04
LF477:  LDY SQ2LoFreqBits

LF47A:  STY $0711
LF47D:  LSR
LF47E:  LSR
LF47F:  LSR
LF480:  BCS $F48A

LF482:  LDA #$FF
LF484:  CLC
LF485:  ADC $0711
LF488:  BNE $F490

LF48A:  LDA #$01
LF48C:  CLC
LF48D:  ADC $0711

LF490:  STA SQ1Cntrl2,X
LF493:  RTS

LF494:  STY SFXIndexSQ1
LF496:  STA SQ1SFXTimer
LF499:  LDA #$00
LF49B:  STA SQ1InUse

LF49E:  LDA #$7F
LF4A0:  STA SQ1Cntrl1
LF4A3:  STA SQ2Cntrl1
LF4A6:  LDA NoiseInUse
LF4A9:  BEQ $F4B5

LF4AB:  LDA #$10
LF4AD:  STA NoiseCntrl0
LF4B0:  LDA #$00
LF4B2:  STA NoiseInUse
LF4B5:  LDA #$01
LF4B7:  STA SQ2InUse

LF4BA:  LDA SFXIndexSQ1
LF4BC:  CMP #$0C
LF4BE:  BEQ $F4CC

LF4C0:  CMP #$15
LF4C2:  BEQ $F4CC

LF4C4:  LDA #$0A
LF4C6:  STA SQ1Cntrl3
LF4C9:  STA SQ2Cntrl3
LF4CC:  RTS

LF4CD:  STA SQ1Cntrl0
LF4D0:  SEC
LF4D1:  SBC #$03
LF4D3:  CMP #$90
LF4D5:  BCS $F4D9

LF4D7:  LDA #$90
LF4D9:  STA SQ2Cntrl0
LF4DC:  RTS

LF4DD:  STA SQ1Cntrl2
LF4E0:  CMP #$0A
LF4E2:  BCS $F4E8

LF4E4:  LDA #$00
LF4E6:  BEQ $F4EB

LF4E8:  SEC
LF4E9:  SBC #$0A
LF4EB:  STA SQ2Cntrl2
LF4EE:  RTS

;----------------------------------------------------------------------------------------------------

InitSQ1SFX:
LF4EF:  STY SFXIndexSQ1         ;Save timer value for length of SFX.
LF4F1:  STA SQ1SFXTimer         ;Save index to SFX.

LF4F4:  LDA #$01
LF4F6:  STA SQ1InUse

LF4F9:  LDA NoiseInUse
LF4FC:  BEQ $F508

LF4FE:  LDA #$10
LF500:  STA NoiseCntrl0
LF503:  LDA #$00
LF505:  STA NoiseInUse

LF508:  LDA SQ2InUse
LF50B:  BEQ $F517

LF50D:  LDA #$10
LF50F:  STA SQ2Cntrl0
LF512:  LDA #$00
LF514:  STA SQ2InUse
LF517:  RTS

;----------------------------------------------------------------------------------------------------

InitSQ1SQ2SFX:
LF518:  STY SFXIndexSQ1         ;Save the length of the SFX.
LF51A:  STA SQ1SFXTimer         ;

LF51D:  LDA #$00                ;Indicate SQ1 channel is not in use.
LF51F:  STA SQ1InUse            ;

LF522:  LDA SQ2InUse            ;Is SQ2 channel in use?
LF525:  BEQ SetNoiseInUse       ;If not, branch.

LF527:  LDA #$10                ;Silence SQ2 channel.
LF529:  STA SQ2Cntrl0           ;

LF52C:  LDA #$00                ;Indicate SQ2 channel is not in use.
LF52E:  STA SQ2InUse            ;

SetNoiseInUse:
LF531:  LDA #$10                ;Silence SQ1 channel.
LF533:  STA SQ1Cntrl0           ;

LF536:  LDA #$01                ;
LF538:  STA NoiseInUse          ;Indicate the noise channel is in use.
LF53B:  RTS                     ;

;----------------------------------------------------------------------------------------------------

;The following table contains the musical notes in the game. The first byte is
;the period high information(3 bits) and the second byte is the period low information(8 bits).
;The formula for figuring out the SQ1, SQ2 frequency is as follows: 1789773/(16*(hhhllllllll+1)).
;The frequency for the triangle channel is 1/2 the frequency for the square wave channels.

NotesTbl:
LF53C:  .byte $00, $00          ;Index #$00 - No sound.
LF53E:  .byte $00, $00          ;Index #$02 - No sound.
LF540:  .byte $06, $AE          ;Index #$04 - 65.38Hz   - C2  (SQ1/SQ2), 32.96Hz   - C1 (TRI).
LF542:  .byte $06, $4E          ;Index #$06 - 69.26Hz   - C#2 (SQ1/SQ2), 34.63Hz   - C#1 (TRI).
LF544:  .byte $05, $F3          ;Index #$08 - 73.40Hz   - D2  (SQ1/SQ2), 36.70Hz   - D1 (TRI).
LF546:  .byte $05, $9E          ;Index #$0A - 77.74Hz   - D#2 (SQ1/SQ2), 38.87Hz   - D#1 (TRI).
LF548:  .byte $05, $4D          ;Index #$0C - 82.37Hz   - E2  (SQ1/SQ2), 41.19Hz   - E1 (TRI).
LF54A:  .byte $05, $02          ;Index #$0E - 87.19Hz   - F2  (SQ1/SQ2), 43.60Hz   - F1 (TRI).
LF54C:  .byte $04, $B9          ;Index #$10 - 92.45Hz   - F#2 (SQ1/SQ2), 46.23Hz   - F#1 (TRI).
LF54E:  .byte $04, $75          ;Index #$12 - 97.95Hz   - G2  (SQ1/SQ2), 48.98Hz   - G1 (TRI).
LF550:  .byte $04, $35          ;Index #$14 - 103.77Hz  - G#2 (SQ1/SQ2), 51.89Hz   - G#1 (TRI).
LF552:  .byte $03, $F8          ;Index #$16 - 109.99Hz  - A2  (SQ1/SQ2), 55.00Hz   - A1 (TRI).
LF554:  .byte $03, $BF          ;Index #$18 - 116.52Hz  - A#2 (SQ1/SQ2), 58.26Hz   - A#1 (TRI).
LF556:  .byte $03, $89          ;Index #$1A - 123.47Hz  - B2  (SQ1/SQ2), 61.74Hz   - B1 (TRI).
LF558:  .byte $03, $57          ;Index #$1C - 130.68Hz  - C3  (SQ1/SQ2), 65.38Hz   - C2  (TRI).
LF55A:  .byte $03, $27          ;Index #$1E - 138.44Hz  - C#3 (SQ1/SQ2), 69.26Hz   - C#2 (TRI).
LF55C:  .byte $02, $F9          ;Index #$20 - 146.80Hz  - D3  (SQ1/SQ2), 73.40Hz   - D2  (TRI).
LF55E:  .byte $02, $CF          ;Index #$22 - 155.36Hz  - D#3 (SQ1/SQ2), 77.74Hz   - D#2 (TRI).
LF560:  .byte $02, $A6          ;Index #$24 - 164.74Hz  - E3  (SQ1/SQ2), 82.37Hz   - E2  (TRI).
LF562:  .byte $02, $80          ;Index #$26 - 174.51Hz  - F3  (SQ1/SQ2), 87.19Hz   - F2  (TRI).
LF564:  .byte $02, $5C          ;Index #$28 - 184.89Hz  - F#3 (SQ1/SQ2), 92.45Hz   - F#2 (TRI).
LF565:  .byte $02, $3A          ;Index #$2A - 195.90Hz  - G3  (SQ1/SQ2), 97.95Hz   - G2  (TRI).
LF566:  .byte $02, $1A          ;Index #$2C - 207.53Hz  - G#3 (SQ1/SQ2), 103.77Hz  - G#2 (TRI).
LF56A:  .byte $01, $FC          ;Index #$2E - 219.77Hz  - A3  (SQ1/SQ2), 109.99Hz  - A2  (TRI).
LF56C:  .byte $01, $DF          ;Index #$30 - 233.04Hz  - A#3 (SQ1/SQ2), 116.52Hz  - A#2 (TRI).
LF56E:  .byte $01, $C4          ;Index #$32 - 246.93Hz  - B3  (SQ1/SQ2), 123.47Hz  - B2  (TRI).
LF570:  .byte $01, $AB          ;Index #$34 - 261.36Hz  - C4  (SQ1/SQ2), 130.68Hz  - C3  (TRI).
LF572:  .byte $01, $93          ;Index #$36 - 276.88Hz  - C#4 (SQ1/SQ2), 138.44Hz  - C#3 (TRI).
LF573:  .byte $01, $7C          ;Index #$38 - 293.60Hz  - D4  (SQ1/SQ2), 146.80Hz  - D3  (TRI).
LF574:  .byte $01, $67          ;Index #$3A - 310.72Hz  - D#4 (SQ1/SQ2), 155.36Hz  - D#3 (TRI).
LF575:  .byte $01, $52          ;Index #$3C - 329.97Hz  - E4  (SQ1/SQ2), 164.74Hz  - E3  (TRI).
LF57A:  .byte $01, $3F          ;Index #$3E - 349.57Hz  - F4  (SQ1/SQ2), 174.51Hz  - F3  (TRI).
LF57C:  .byte $01, $2D          ;Index #$40 - 370.40Hz  - F#4 (SQ1/SQ2), 184.89Hz  - F#3 (TRI).
LF57E:  .byte $01, $1C          ;Index #$42 - 392.49Hz  - G4  (SQ1/SQ2), 95.90Hz   - G3  (TRI).
LF580:  .byte $01, $0C          ;Index #$44 - 415.84Hz  - G#4 (SQ1/SQ2), 207.53Hz  - G#3 (TRI).
LF582:  .byte $00, $FD          ;Index #$46 - 440.40Hz  - A4  (SQ1/SQ2), 219.77Hz  - A3  (TRI).
LF583:  .byte $00, $EE          ;Index #$48 - 468.04Hz  - A#4 (SQ1/SQ2), 233.04Hz  - A#3 (TRI).
LF584:  .byte $00, $E1          ;Index #$4A - 494.96Hz  - B4  (SQ1/SQ2), 246.93Hz  - B3  (TRI).
LF585:  .byte $00, $D4          ;Index #$4C - 525.17Hz  - C5  (SQ1/SQ2), 261.36Hz  - C4  (TRI).
LF58A:  .byte $00, $C8          ;Index #$4E - 556.52Hz  - C#5 (SQ1/SQ2), 276.88Hz  - C#4 (TRI).
LF58C:  .byte $00, $BD          ;Index #$50 - 588.74Hz  - D5  (SQ1/SQ2), 293.60Hz  - D4  (TRI).
LF58E:  .byte $00, $B2          ;Index #$52 - 624.92Hz  - D#5 (SQ1/SQ2), 310.72Hz  - D#4 (TRI).
LF590:  .byte $00, $A8          ;Index #$54 - 661.90Hz  - E5  (SQ1/SQ2), 329.97Hz  - E4  (TRI).
LF592:  .byte $00, $9F          ;Index #$56 - 699.13Hz  - F5  (SQ1/SQ2), 49.57Hz   - F4  (TRI).
LF594:  .byte $00, $96          ;Index #$58 - 740.80Hz  - F#5 (SQ1/SQ2), 370.40Hz  - F#4 (TRI).
LF596:  .byte $00, $8D          ;Index #$5A - 787.75Hz  - G5  (SQ1/SQ2), 392.49Hz  - G4  (TRI).
LF598:  .byte $00, $85          ;Index #$5C - 834.78Hz  - G#5 (SQ1/SQ2), 415.84Hz  - G#4 (TRI).
LF59A:  .byte $00, $7E          ;Index #$5E - 880.79Hz  - A5  (SQ1/SQ2), 440.40Hz  - A4  (TRI).
LF59C:  .byte $00, $76          ;Index #$60 - 940.01Hz  - A#5 (SQ1/SQ2), 468.04Hz  - A#4 (TRI).
LF59E:  .byte $00, $70          ;Index #$62 - 989.92Hz  - B5  (SQ1/SQ2), 494.96Hz  - B4  (TRI).
LF5A0:  .byte $00, $6A          ;Index #$64 - 1045.43Hz - C6  (SQ1/SQ2), 525.17Hz  - C5  (TRI).
LF5A2:  .byte $00, $64          ;Index #$66 - 1107.53Hz - C#6 (SQ1/SQ2), 556.52Hz  - C#5 (TRI).
LF5A4:  .byte $00, $5F          ;Index #$68 - 1165.22Hz - D6  (SQ1/SQ2), 588.74Hz  - D5  (TRI).
LF5A6:  .byte $00, $59          ;Index #$6A - 1242.90Hz - D#6 (SQ1/SQ2), 624.92Hz  - D#5 (TRI).
LF5A8:  .byte $00, $54          ;Index #$6C - 1316.01Hz - E6  (SQ1/SQ2), 661.90Hz  - E5  (TRI).
LF5AA:  .byte $00, $50          ;Index #$6E - 1381.00Hz - F6  (SQ1/SQ2), 699.13Hz  - F5  (TRI).
LF5AC:  .byte $00, $4B          ;Index #$70 - 1471.85Hz - F#6 (SQ1/SQ2), 740.80Hz  - F#5 (TRI).
LF5AE:  .byte $00, $47          ;Index #$72 - 1553.62Hz - G6  (SQ1/SQ2), 787.75Hz  - G5  (TRI).
LF5B0:  .byte $00, $43          ;Index #$74 - 1645.01Hz - G#6 (SQ1/SQ2), 834.78Hz  - G#5 (TRI).
LF5B2:  .byte $00, $3F          ;Index #$76 - 1747.83Hz - A6  (SQ1/SQ2), 880.79Hz  - A5  (TRI).
LF5B4:  .byte $00, $3B          ;Index #$78 - 1864.35Hz - A#6 (SQ1/SQ2), 940.01Hz  - A#5 (TRI).
LF5B6:  .byte $00, $38          ;Index #$7A - 1962.47Hz - B6  (SQ1/SQ2), 989.92Hz  - B5  (TRI).
LF5B8:  .byte $00, $35          ;Index #$7C - 2071.50Hz - C7  (SQ1/SQ2), 1045.43Hz - C6  (TRI).
LF5BA:  .byte $00, $32          ;Index #$7E - 2193.35Hz - C#7 (SQ1/SQ2), 1107.53Hz - C#6 (TRI).

;----------------------------------------------------------------------------------------------------

;The following table contains the note lengths used by the varios pieces of music.

NoteLengthsTbl:
;Unused.
LF5BC:  .byte $08, $18, $10, $20, $30, $40, $60, $80, $0B, $0A, $15, $16, $50, $FF, $05, $06
LF5CC:  .byte $16, $00, $00, $00, $00, $00, $00

;Index #$17. Used by Intro/attract/end music segments.
LF5D3:  .byte $07, $15, $0E, $1C, $2A, $38, $54, $70, $09, $0A, $13, $12, $46, $E0, $05, $04
LF5E3:  .byte $12, $00, $00, $10, $04, $00, $00, $06, $13, $0D, $1A, $27, $34, $4E, $68, $09

;Unused.
LF5F3:  .byte $08, $11, $12, $41, $D0, $04, $05, $12, $00, $00, $00, $00, $07, $14

;Index #$45. Used by newspaper, circuit champion, fight win, fight loss, title bout,
;pre-fight, dream fight, Von Kaiser intro, Glass Joe intro, Don Flamenco intro,
;King Hippo intro, Soda Popinsky intro and Piston Honda intro music segments.
LF601:  .byte $06, $12, $0C, $18, $24, $30, $48, $60, $08, $08, $10, $10, $3C, $C0, $04, $04
LF611:  .byte $10, $6C, $54, $0F, $03, $00, $00

;Index #$5C. Used by main fight music segments.
LF618:  .byte $06, $11, $0B, $16, $21, $2C, $42, $58, $07, $08, $0F, $0E, $37, $B0, $04, $03
LF628:  .byte $0E, $00, $00, $00, $00, $05, $10

;Index #$73. Used by the game over, training, opponent down and little Mac down music segments.
LF62F:  .byte $05, $0F, $0A, $14, $1E, $28, $3C, $50, $07, $06, $0D, $0E, $32, $A0, $03, $04
LF63F:  .byte $0E, $5A, $46, $00, $00, $00, $00, $05, $0E, $09, $12, $1B, $24, $36, $48, $06
LF64F:  .byte $06, $0C, $0C, $2D, $90, $03, $03, $0C, $00, $00, $00, $00, $04, $0D, $04, $0C
LF65F:  .byte $08, $10, $18, $20, $30, $40, $05, $06, $0B, $0A, $28, $80, $03, $02, $0A, $48
LF66F:  .byte $38, $00, $00, $00, $00

;----------------------------------------------------------------------------------------------------

;The following table is data loaded into the SQ1, SQ2 channel duty cycle and envelope control
;register. A new value is loaded every 4th frame.

SQDCEnvTbl:
;The most common data used by most music.
LF674:  .byte $DA, $DA, $DA, $D9, $D9, $D9, $D8, $D8, $D8, $D7, $D7, $D7, $D6, $D6, $D6, $D5

;Used in the training music and the newspaper music.
LF684:  .byte $9A, $9A, $9A, $99, $99, $99, $98, $98, $98, $97, $97, $97, $96, $1E, $03, $48

;Used in the main fight music and whrn Little Mac or an opponent is knocked down.
LF694:  .byte $D3, $D3, $D3, $D3, $D3, $D3, $D3, $D3, $D3, $D3, $D4, $D4, $D4, $D5, $D5, $D6

;These values do not appear to be used by any music.
LF6A4:  .byte $53, $53, $53, $53, $53, $53, $53, $53, $53, $53, $54, $54, $54, $15, $15, $56
LF6B4:  .byte $50, $50, $51, $51, $52, $52, $53, $53, $54, $55, $56, $57, $58, $59, $5A, $5B
LF6C4:  .byte $90, $90, $91, $91, $92, $92, $93, $93, $94, $95, $96, $97, $98, $99, $9A, $9B

;Used in the intro/attract/end music and pre-fight music.
LF6D4:  .byte $50, $50, $50, $50, $50, $50, $50, $50, $50, $50, $51, $52, $53, $54, $55, $56

;Used in the intro/attract/end music.
LF6E4:  .byte $90, $90, $90, $90, $90, $90, $90, $90, $90, $91, $93, $94, $96, $97, $99, $9A

;In the trianing music, these envelope values make the SQ2 envelope and duty cycle rapidly 
;change which gives the effect of a fast playing violin or something similar.
LF6F4:  .byte $10, $10, $10, $10, $12, $95, $D3, $14, $95, $17, $D4, $15, $97, $18, $DA, $D0
LF704:  .byte $0C, $13, $D4, $15, $97, $D5, $16, $97, $19, $D6, $17, $99, $17, $DB, $D0, $0C

;----------------------------------------------------------------------------------------------------

;The following table applies a decay to drum beats 10 and 11.  The volume is slowly reduced
;over a period of 40 frames. The values of the volume are in the lower nibble of each byte
;below. The table starts at the end and works backwards.

NoiseDecayTbl:
LF714:  .byte $10, $11, $11, $11, $11, $12, $11, $12, $11, $12, $11, $12, $11, $12, $13, $12
LF724:  .byte $13, $12, $13, $12, $13, $14, $13, $14, $13, $14, $15, $14, $15, $14, $15, $16
LF734:  .byte $15, $16, $17, $18, $19, $1A, $1B, $1D

;----------------------------------------------------------------------------------------------------

;The following table contains the 11 different drum beats that can be used in the music.  There
;are 3 bytes per drum beat and are loaded directly into the noise hardware registers.

NoiseDatTbl:
LF73C:  .byte $1D, $03, $48, $00    ;Index #$02. Drum beat 1.
LF740:  .byte $19, $06, $38, $00    ;Index #$06. Drum beat 2.
LF744:  .byte $19, $08, $38, $00    ;Index #$0A. Drum beat 3.
LF748:  .byte $19, $0A, $38, $00    ;Index #$0E. Drum beat 4.
LF74C:  .byte $16, $07, $98, $00    ;Index #$12. Drum beat 5.
LF750:  .byte $10, $00, $00, $00    ;Index #$16. Drum silent.
LF754:  .byte $80, $00, $08, $00    ;Index #$1A. Drum beat 7.
LF758:  .byte $80, $01, $08, $00    ;Index #$1E. Drum beat 8.
LF75C:  .byte $81, $01, $08, $00    ;Index #$22. Drum beat 9.
LF670:  .byte $1D, $02, $08, $00    ;Index #$26. Drum beat 10.
LF764:  .byte $1D, $03, $08, $00    ;Index #$2A. Drum beat 11.

;----------------------------------------------------------------------------------------------------

;The following table contains the addresses and lengths of DMC channel data. The values in
;the tables are loaded into the 3rd and 4th DMC hardware registers

DMCSamplePtrTbl:
LF768:  .byte $80, $C0          ;Crowd.  Address: $E000. Length: 3072 bytes.
LF76A:  .byte $B3, $1C          ;Laugh1. Address: $ECC0. Length: 448  bytes.
LF76C:  .byte $BA, $18          ;Laugh2. Address: $EE80. Length: 384  bytes.
LF76E:  .byte $C0, $14          ;Laugh3. Address: $F000. Length: 320  bytes.
LF770:  .byte $C5, $18          ;Laugh4. Address: $F140. Length: 384  bytes.
LF772:  .byte $CB, $0F          ;Laugh5. Address: $F2C0. Length: 240  bytes.
LF774:  .byte $B0, $0C          ;Grunt.  Address: $EC00. Length: 192  bytes.

;----------------------------------------------------------------------------------------------------

;The following is sweep data loaded into SQ1Cntrl1 during the SQ1_FALL SFX.
FallSFXSweepTbl:
LF776:  .byte $8D, $84, $84, $84, $84, $8C, $8C, $8C

;The following table contains the noise data for the SQ1_PUNCH_MISS1 SFX. The lower nibble in
;each byte is loaded into NoiseCntrl2 and the upper nibble is loaded into  NoiseCntrl0.
PnchMs1SFXTbl:
LF77E:  .byte $FE, $FC, $EA, $E8, $D7, $C9, $9A, $8B, $7C, $7D, $5E, $5F, $3E, $3F, $2F, $1F

;The following table contains the noise data for the SQ1_PUNCH_MISS2 SFX. The lower nibble in
;each byte is loaded into NoiseCntrl2 and the upper nibble is loaded into  NoiseCntrl0.
PnchMs2SFXTbl:
LF78E:  .byte $FB, $E9, $D7, $C9, $9A, $8B, $7C, $5D, $3E, $2F

;The following table contains values loaded into SQ1Cntrl0 during the SQ1_TALK1 SFX.
Talk1CntrlTbl:
LF798:  .byte $93, $95, $97, $99

;The following table contains the notes to use in the SQ1_TALK1 SFX. The notes are all the same.
Talk1NoteTbl:
LF79C:  .byte SQ_C_6, SQ_C_6, SQ_C_6, SQ_C_6, SQ_C_6, SQ_C_6, SQ_C_6, SQ_C_6
LF7A4:  .byte SQ_C_6, SQ_C_6, SQ_C_6, SQ_C_6, SQ_C_6, SQ_C_6, SQ_C_6, SQ_C_6

;The following table contains the notes to use in the SQ1_TALK2 SFX.
Talk2NoteTbl:
LF7AC:  .byte SQ_C_5,       SQ_G_4,       SQ_F_SHARP_5, SQ_D_5
LF7B0:  .byte SQ_F_4,       SQ_E_5,       SQ_C_SHARP_5, SQ_A_5
LF7B4:  .byte SQ_C_SHARP_5, SQ_A_SHARP_4, SQ_D_SHARP_5, SQ_G_SHARP_4
LF7B8:  .byte SQ_G_SHARP_5, SQ_B_4,       SQ_A_SHARP_5, SQ_F_SHARP_4

;The following table contains the notes to use in the SQ1_TALK3 SFX.
Talk3NoteTbl:
LF7BC:  .byte $24, $2A, $1C, $34, $2E, $20, $32, $22, $38, $2C, $1E, $30, $26, $2C, $3C, $28

LF7CC:  .byte $16, $19
LF7CE:  .byte $10, $10, $1B, $1D, $1F, $1B, $17, $18, $19, $1A, $1B, $10, $10, $1C, $1D, $1E 
LF7DE:  .byte $10, $10, $1C, $1D, $1E, $1F, $18, $1A, $1C, $1E, $1C, $1A, $B0, $E0, $D8, $00
LF7EE:  .byte $00, $50, $48, $18, $10, $D0, $C0, $B0, $A0, $90, $00, $00, $40, $50, $60, $00
LF7FE:  .byte $00, $20, $30, $40, $13, $00, $10, $20, $30, $40, $50, $90, $F8, $E6, $AA, $8B
LF80E:  .byte $4C, $85, $84, $84, $84, $84, $8C, $8C, $8C, $04, $08, $0C, $10, $18, $30, $28
LF81E:  .byte $1F, $E2, $1D, $FE, $40, $08, $10, $18, $20, $28, $30, $38, $40, $48, $50, $58
LF82E:  .byte $60, $01, $03, $05, $08, $0A, $0F, $D0, $D1, $D2, $D3, $D4, $D5, $D6, $D7, $D8
LF83E:  .byte $D9, $DA, $DB, $DC, $DD, $DE, $DF, $50, $51, $52, $53, $54, $55, $56, $57, $58
LF84E:  .byte $59, $5A, $5B, $5C, $5D, $5E, $5F, $08, $09, $08, $09, $10, $11, $11, $12, $13
LF85E:  .byte $14, $15, $16, $17, $18, $19, $1A, $17, $18, $19, $1A

;----------------------------------------------------------------------------------------------------

;Unused.
LF869:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LF879:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LF889:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LF899:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LF8A9:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LF8B9:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LF8C9:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LF8D9:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LF8E9:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LF8F9:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LF909:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LF919:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LF929:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LF939:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LF949:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LF959:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LF969:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LF979:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LF989:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LF999:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LF9A9:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LF9B9:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LF9C9:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LF9D9:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LF9E9:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LF9F9:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LFA09:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LFA19:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LFA29:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LFA39:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LFA49:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LFA59:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LFA69:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LFA79:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LFA89:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LFA99:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LFAA9:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LFAB9:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LFAC9:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LFAD9:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LFAE9:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LFAF9:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LFB09:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LFB19:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LFB29:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LFB39:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LFB49:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LFB59:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LFB69:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LFB79:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LFB89:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LFB99:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LFBA9:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LFBB9:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LFBC9:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LFBD9:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LFBE9:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LFBF9:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LFC09:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LFC19:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LFC29:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LFC39:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LFC49:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LFC59:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LFC69:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LFC79:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LFC89:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LFC99:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LFCA9:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LFCB9:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LFCC9:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LFCD9:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LFCE9:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LFCF9:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LFD09:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LFD19:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LFD29:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LFD39:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LFD49:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LFD59:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LFD69:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LFD79:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LFD89:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LFD99:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LFDA9:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LFDB9:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LFDC9:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LFDD9:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LFDE9:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LFDF9:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LFE09:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LFE19:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LFE29:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LFE39:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LFE49:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LFE59:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LFE69:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LFE79:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LFE89:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LFE99:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LFEA9:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LFEB9:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LFEC9:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LFED9:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LFEE9:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LFEF9:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LFF09:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LFF19:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LFF29:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LFF39:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LFF49:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LFF59:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LFF69:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LFF79:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LFF89:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LFF99:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LFFA9:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LFFB9:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LFFC9:  .byte $00, $00, $00, $00, $00, $00, $00

;----------------------------------------------------------------------------------------------------

LFFD0:  JMP $B27A
LFFD3:  JMP $B283
LFFD6:  JMP $B28F

LFFD9:  .byte $00, $00, $00     ;Unused.

Spinlock1:
LFFDC:  JMP Spinlock1           ;($FFDC)Spinlock the game. Reset required.

LFFDF:  .byte $00, $00, $00     ;Unused.
LFFE2:  .byte $00, $00, $00     ;

;              P    U    N    C    H    -    O    U    T    !    !
LFFE5:  .byte $50, $55, $4E, $43, $48, $2D, $4F, $55, $54, $21, $21
LFFF0:  .byte $DE, $03, $FF, $FF, $33, $04, $01, $0A, $01, $BF

LFFFA:  .word NMI               ;($A008)NMI vector.
LFFFC:  .word RESET             ;($A000)Reset vector.
LFFFE:  .word IRQ               ;($A000)IRQ vector.
