
.org $8000

.include "Mike_Tysons_Punchout_Defines.asm"

;--------------------------------------[ Forward Declarations ]--------------------------------------

.alias GetNoteLength            $F400
.alias SetSQ1Control            $F40B
.alias SQ2CntrlAndSwpDis        $F412
.alias SetSQ2Control            $F414
.alias UpdateSQ2                $F41B
.alias UpdateSQ2Note            $F41E
.alias UpdateTriNote            $F422
.alias UpdateSQ1                $F426
.alias UpdateSQ1Note            $F429
.alias LogDiv32                 $F44E
.alias LogDiv16                 $F44F
.alias LogDiv8                  $F450
.alias NoiseDecayTbl            $F714
.alias NoiseDatTbl              $F73C

;-----------------------------------------[ Start Of Code ]------------------------------------------

SoundEngine:
L8000:  LDA #$C0                ;Set APU into 5-step mode.
L8002:  STA APUCommonCntrl1     ;

L8005:  JSR $8025
L8008:  JSR $80CA
L800B:  JSR $84B1
L800E:  JSR PlayMusic           ;($88E2)Initialize or play music.

L8011:  LDA #$00                ;
L8013:  STA SFXInitSQ1          ;
L8015:  STA SFXInitSQ2          ;Clear out any initialization flags.
L8017:  STA MusicInit           ;
L8019:  STA DMCInit             ;
L801B:  RTS                     ;

L801C:  LDY DMCIndex
L801E:  CPY #$06
L8020:  BCS $807B

L8022:  INY
L8023:  STY DMCInit

L8025:  LDY DMCInit
L8027:  BMI $807B

L8029:  BNE $8040

L802B:  LDA DMCIndex
L802D:  CMP #$01
L802F:  BEQ $8084

L8031:  LDA DMCIndex
L8033:  BEQ $807F

L8035:  DEC $071E
L8038:  BEQ $801C

L803A:  DEC $071F
L803D:  BEQ $807F

L803F:  RTS

L8040:  STY DMCIndex
L8042:  LDA #$0E
L8044:  STA $071E

L8047:  LDX #$05
L8049:  LDA DMCIndex
L804B:  CMP #$07
L804D:  BNE $8051

L804F:  LDX #$03
L8051:  STX $071F

L8054:  TYA
L8055:  ASL
L8056:  TAY

L8057:  LDA $F766,Y
L805A:  STA DMCCntrl2
L805D:  LDA $F767,Y
L8060:  STA DMCCntrl3

L8063:  LDX #$4F
L8065:  LDA DMCIndex
L8067:  CMP #$01
L8069:  BEQ $806D
L806B:  LDX #$0F
L806D:  STX DMCCntrl0
L8070:  LDA #$0F
L8072:  STA APUCommonCntrl0
L8075:  LDA #$1F
L8077:  STA APUCommonCntrl0
L807A:  RTS

L807B:  LDA #$00
L807D:  STA DMCIndex
L807F:  LDA #$0F
L8081:  STA APUCommonCntrl0
L8084:  RTS

L8085:  LDA #$40
L8087:  JSR $F4EF

L808A:  LDA #$1A
L808C:  STA $0713
L808F:  LDX #$9F
L8091:  LDY #$83
L8093:  JSR SetSQ1Control       ;($F40B)Set control bits for the SQ1 channel.

L8096:  LDA $0712
L8099:  CMP #$40
L809B:  BCS $80A4
L809D:  LSR
L809E:  LSR
L809F:  ORA #$90
L80A1:  STA SQ1Cntrl0
L80A4:  LDA $0712
L80A7:  AND #$07
L80A9:  BNE $80C7

L80AB:  LDA $0713
L80AE:  LSR
L80AF:  LSR
L80B0:  LSR
L80B1:  LSR
L80B2:  SEC
L80B3:  ADC $0713
L80B6:  STA $0713
L80B9:  ROL
L80BA:  ROL
L80BB:  ROL
L80BC:  STA SQ1Cntrl2
L80BF:  ROL
L80C0:  AND #$07
L80C2:  ORA #$08
L80C4:  STA SQ1Cntrl3
L80C7:  JMP $813E

L80CA:  LDY SFXInitSQ1
L80CC:  BMI $8143

L80CE:  LDA SFXIndexSQ1
L80D0:  CPY #$01
L80D2:  BEQ $8085

L80D4:  CMP #$01
L80D6:  BEQ $8096

L80D8:  CPY #$02
L80DA:  BEQ $80EB

L80DC:  CMP #$02
L80DE:  BEQ $80F9

L80E0:  CPY #$03
L80E2:  BEQ $8124

L80E4:  CMP #$03
L80E6:  BEQ $8132

L80E8:  JMP $81C7

L80EB:  LDA #$7F
L80ED:  JSR $F4EF

L80F0:  LDX #$9C
L80F2:  LDY #$7F
L80F4:  LDA #$62
L80F6:  JSR UpdateSQ1           ;($F426)Update SQ1 control and note bytes.

L80F9:  LDA $0712
L80FC:  CMP #$6C
L80FE:  BEQ $8121

L8100:  BCC $810D

L8102:  AND #$07
L8104:  TAY
L8105:  LDA $F776,Y
L8108:  STA SQ1Cntrl1
L810B:  BNE $8121

L810D:  CMP #$6B
L810F:  BNE $8116

L8111:  LDY #$A5
L8113:  STY SQ1Cntrl1
L8116:  CMP #$30
L8118:  BCS $8121

L811A:  LSR
L811B:  LSR
L811C:  ORA #$90
L811E:  STA SQ1Cntrl0
L8121:  JMP $813E

L8124:  LDA #$16
L8126:  JSR $F4EF

L8129:  LDX #$5F
L812B:  LDY #$8B
L812D:  LDA #$12
L812F:  JSR UpdateSQ1           ;($F426)Update SQ1 control and note bytes.

L8132:  LDA $0712
L8135:  CMP #$10
L8137:  BCS $813E

L8139:  ORA #$50
L813B:  STA SQ1Cntrl0
L813E:  DEC $0712
L8141:  BNE $816F

L8143:  LDA NoiseInUse
L8146:  BEQ $8152

L8148:  LDA #$10
L814A:  STA NoiseCntrl0

L814D:  LDA #$00
L814F:  STA NoiseInUse

L8152:  LDA SQ2InUse
L8155:  BEQ $8161

L8157:  LDA #$10                ;Silence the SQ2 channel.
L8159:  STA SQ2Cntrl0           ;

L815C:  LDA #$00
L815E:  STA SQ2InUse

L8161:  LDA #$00
L8163:  STA $0726

L8166:  LDA #$00
L8168:  STA SFXIndexSQ1

L816A:  LDA #$10
L816C:  STA SQ1Cntrl0
L816F:  RTS

L8170:  LDA #$04
L8172:  JSR $F518

L8175:  LDX #$0A
L8177:  LDA #$1A
L8179:  LDY #$08
L817B:  STY NoiseCntrl3
L817E:  STX NoiseCntrl2
L8181:  STA NoiseCntrl0

L8184:  LDX #$DA
L8186:  LDY #$85
L8188:  LDA #$24
L818A:  JSR UpdateSQ1           ;($F426)Update SQ1 control and note bytes.

L818D:  JMP $813E

L8190:  LDA #$20
L8192:  JSR $F4EF

L8195:  LDA #$FF
L8197:  STA $0713

L819A:  LDX #$1E
L819C:  LDY #$81
L819E:  JSR SetSQ1Control       ;($F40B)Set control bits for the SQ1 channel.

L81A1:  LDA $0713
L81A4:  TAY
L81A5:  JSR LogDiv8             ;($F450)Logarithmically increase frequency.

L81A8:  STA $0713
L81AB:  ROL
L81AC:  ROL
L81AD:  STA SQ1Cntrl2

L81B0:  ROL
L81B1:  AND #$03
L81B3:  ORA #$08
L81B5:  STA SQ1Cntrl3

L81B8:  LDA $0712
L81BB:  CMP #$0E
L81BD:  BCS $81C4

L81BF:  ORA #$90
L81C1:  STA SQ1Cntrl0
L81C4:  JMP $813E

L81C7:  CPY #$04
L81C9:  BEQ $8170
L81CB:  CMP #$04
L81CD:  BEQ $818D
L81CF:  CPY #$05
L81D1:  BEQ $8190
L81D3:  CMP #$05
L81D5:  BEQ $81A1
L81D7:  CPY #$06
L81D9:  BEQ $81F2
L81DB:  CMP #$06
L81DD:  BEQ $81F7
L81DF:  CPY #$07
L81E1:  BEQ $8215
L81E3:  CMP #$07
L81E5:  BEQ $821A
L81E7:  CPY #$08
L81E9:  BEQ $8222
L81EB:  CMP #$08
L81ED:  BEQ $8230
L81EF:  JMP $827F

L81F2:  LDA #$10
L81F4:  JSR $F518
L81F7:  LDY $0712
L81FA:  LDA $F77D,Y
L81FD:  TAX
L81FE:  AND #$0F
L8200:  STA NoiseCntrl2
L8203:  TXA
L8204:  LSR
L8205:  LSR
L8206:  LSR
L8207:  LSR
L8208:  ORA #$10
L820A:  STA NoiseCntrl0
L820D:  LDA #$08
L820F:  STA NoiseCntrl3
L8212:  JMP $813E
L8215:  LDA #$0A
L8217:  JSR $F518
L821A:  LDY $0712
L821D:  LDA $F78D,Y
L8220:  BNE $81FD
L8222:  LDA #$10
L8224:  JSR $F4EF

L8227:  LDX #$43
L8229:  LDY #$84
L822B:  LDA #$4C
L822D:  JSR UpdateSQ1           ;($F426)Update SQ1 control and note bytes.

L8230:  JMP $813E
L8233:  LDA #$04
L8235:  JSR $F4EF
L8238:  LDA #$7F
L823A:  STA SQ1Cntrl1
L823D:  INC $0713
L8240:  LDA $0713
L8243:  AND #$0F
L8245:  TAY
L8246:  LDA $F79C,Y
L8249:  JSR UpdateSQ1Note       ;($F429)Update SQ1 note frequency.

L824C:  LDY $0712
L824F:  LDA $F797,Y
L8252:  STA SQ1Cntrl0
L8255:  JMP $813E
L8258:  LDA #$04
L825A:  JSR $F4EF
L825D:  LDA #$BC
L825F:  STA SQ1Cntrl1
L8262:  INC $0713
L8265:  LDA $0713
L8268:  AND #$0F
L826A:  TAY
L826B:  LDA SFXIndexSQ1
L826D:  CMP #$0B
L826F:  BEQ $8276
L8271:  LDA $F7AC,Y
L8274:  BNE $8279
L8276:  LDA $F7BC,Y
L8279:  JSR UpdateSQ1Note       ;($F429)Update SQ1 note frequency.

L827C:  JMP $824C
L827F:  CPY #$09
L8281:  BEQ $8233
L8283:  CMP #$09
L8285:  BEQ $824C
L8287:  CPY #$0A
L8289:  BEQ $8258
L828B:  CMP #$0A
L828D:  BEQ $827C
L828F:  CPY #$0B
L8291:  BEQ $8258
L8293:  CMP #$0B
L8295:  BEQ $827C
L8297:  CPY #$0C
L8299:  BEQ $82A2
L829B:  CMP #$0C
L829D:  BEQ $82BE
L829F:  JMP $8316
L82A2:  LDA #$40
L82A4:  JSR $F494
L82A7:  LDX #$88
L82A9:  STX SQ1Cntrl0
L82AC:  STX SQ2Cntrl0
L82AF:  LDA #$58
L82B1:  JSR UpdateSQ1Note       ;($F429)Update SQ1 note frequency.

L82B4:  LDA #$22
L82B6:  STA SQ2Cntrl2
L82B9:  LDA #$08
L82BB:  STA SQ2Cntrl3
L82BE:  LDA $0712
L82C1:  CMP #$28
L82C3:  BNE $82CD
L82C5:  LDX #$8F
L82C7:  STX SQ1Cntrl0
L82CA:  STX SQ2Cntrl0
L82CD:  JMP $813E
L82D0:  LDA #$0F
L82D2:  JSR $F494
L82D5:  LDA #$00
L82D7:  STA $0713
L82DA:  LDA $0712
L82DD:  LSR
L82DE:  CLC
L82DF:  ADC $0713
L82E2:  TAY
L82E3:  LDA $F7CC,Y
L82E6:  JSR $F4CD
L82E9:  LDA $F7EB,Y
L82EC:  JSR $F4DD
L82EF:  JMP $813E

L82F2:  LDA #$12
L82F4:  JSR $F494
L82F7:  LDA #$08
L82F9:  STA $0713
L82FC:  BNE $82DA
L82FE:  LDA #$1E
L8300:  JSR $F494
L8303:  LDA #$08
L8305:  STA $0713
L8308:  BNE $82DA
L830A:  LDA #$0C
L830C:  JSR $F494
L830F:  LDA #$18
L8311:  STA $0713
L8314:  BNE $82DA
L8316:  CPY #$0D
L8318:  BEQ $82D0
L831A:  CMP #$0D
L831C:  BEQ $82DA
L831E:  CPY #$0E
L8320:  BEQ $82F2
L8322:  CMP #$0E
L8324:  BEQ $82DA
L8326:  CPY #$0F
L8328:  BEQ $82FE
L832A:  CMP #$0F
L832C:  BEQ $82DA
L832E:  CPY #$10
L8330:  BEQ $830A
L8332:  CMP #$10
L8334:  BEQ $82DA
L8336:  CPY #$11
L8338:  BEQ $8359
L833A:  CMP #$11
L833C:  BEQ $835E
L833E:  CPY #$12
L8340:  BEQ $8367
L8342:  CMP #$12
L8344:  BEQ $8375
L8346:  CPY #$13
L8348:  BEQ $8378
L834A:  CMP #$13
L834C:  BEQ $8386
L834E:  CPY #$14
L8350:  BEQ $8395
L8352:  CMP #$14
L8354:  BEQ $83A3
L8356:  JMP $8402
L8359:  LDA #$05
L835B:  JSR $F518
L835E:  LDY $0712
L8361:  LDA $F809,Y
L8364:  JMP $81FD
L8367:  LDA #$20
L8369:  JSR $F4EF

L836C:  LDX #$98
L836E:  LDY #$7F
L8370:  LDA #$64
L8372:  JSR UpdateSQ1           ;($F426)Update SQ1 control and note bytes.

L8375:  JMP $813E
L8378:  LDA #$12
L837A:  JSR $F4EF

L837D:  LDX #$5F
L837F:  LDY #$8B
L8381:  LDA #$0E
L8383:  JSR UpdateSQ1           ;($F426)Update SQ1 control and note bytes.

L8386:  LDA $0712
L8389:  CMP #$0C
L838B:  BCS $8392
L838D:  ORA #$50
L838F:  STA SQ1Cntrl0
L8392:  JMP $813E
L8395:  LDA #$06
L8397:  JSR $F4EF

L839A:  LDX #$95
L839C:  LDY #$7F
L839E:  LDA #$4A
L83A0:  JSR UpdateSQ1           ;($F426)Update SQ1 control and note bytes.

L83A3:  LDA $0712
L83A6:  CMP #$03
L83A8:  BNE $83AF
L83AA:  LDA #$42
L83AC:  JSR UpdateSQ1Note       ;($F429)Update SQ1 note frequency.

L83AF:  JMP $813E
L83B2:  LDA #$04
L83B4:  STA $0713
L83B7:  LDA #$18
L83B9:  LDY #$15
L83BB:  JMP $82A4
L83BE:  LDA $0712
L83C1:  CMP #$01
L83C3:  BNE $83CA
L83C5:  DEC $0713
L83C8:  BNE $83B7
L83CA:  JMP $82BE
L83CD:  LDA #$24
L83CF:  JSR $F4EF
L83D2:  DEC $0712
L83D5:  LDA #$8F
L83D7:  STA $0713
L83DA:  LDX #$9C
L83DC:  LDY #$82
L83DE:  JSR SetSQ1Control       ;($F40B)Set control bits for the SQ1 channel.

L83E1:  LDA $0712
L83E4:  CMP #$12
L83E6:  BEQ $83D2
L83E8:  LDA $0713
L83EB:  TAY
L83EC:  JSR LogDiv16            ;($F44F)Logarithmically increase frequency.

L83EF:  STA $0713
L83F2:  ROL
L83F3:  ROL
L83F4:  STA SQ1Cntrl2
L83F7:  ROL
L83F8:  AND #$03
L83FA:  ORA #$08
L83FC:  STA SQ1Cntrl3
L83FF:  JMP $813E

L8402:  CPY #$15
L8404:  BEQ $83B2
L8406:  CMP #$15
L8408:  BEQ $83BE
L840A:  CPY #$16
L840C:  BEQ $83CD
L840E:  CMP #$16
L8410:  BEQ $83E1
L8412:  CPY #$17
L8414:  BEQ $8423

L8416:  CMP #$17
L8418:  BEQ $8431
L841A:  CPY #$18
L841C:  BEQ $8440
L841E:  CMP #$18
L8420:  BEQ $8463
L8422:  RTS

L8423:  LDA #$10
L8425:  JSR $F4EF

L8428:  LDX #$82
L842A:  LDY #$A2
L842C:  LDA #$56
L842E:  JSR UpdateSQ1           ;($F426)Update SQ1 control and note bytes.

L8431:  LDA $0712
L8434:  CMP #$0E
L8436:  BNE $843D
L8438:  LDA #$3E
L843A:  JSR UpdateSQ1Note       ;($F429)Update SQ1 note frequency.

L843D:  JMP $813E

L8440:  LDA #$20
L8442:  JSR $F518
L8445:  LDA #$09
L8447:  STA NoiseCntrl0
L844A:  LDA #$0F
L844C:  STA NoiseCntrl2
L844F:  LDA #$08
L8451:  STA NoiseCntrl3
L8454:  LDA #$0F
L8456:  STA TriangleCntrl0
L8459:  LDA #$00
L845B:  STA TriangleCntrl2
L845E:  LDA #$09
L8460:  STA TriangleCntrl3
L8463:  JMP $813E
L8466:  LDA $0715
L8469:  AND #$07
L846B:  BNE $8489
L846D:  LDA $0716
L8470:  LSR
L8471:  LSR
L8472:  LSR
L8473:  LSR
L8474:  SEC
L8475:  ADC $0716
L8478:  STA $0716
L847B:  ROL
L847C:  ROL
L847D:  ROL
L847E:  STA SQ2Cntrl2
L8481:  ROL
L8482:  AND #$07
L8484:  ORA #$08
L8486:  STA SQ2Cntrl3
L8489:  RTS

L848A:  STY SFXIndexSQ2
L848C:  LDA #$40
L848E:  STA $0715
L8491:  LDA #$1A
L8493:  STA $0716
L8496:  LDX #$9F
L8498:  LDY #$83
L849A:  JSR SetSQ2Control       ;($F414)Set control registers for SQ2.

L849D:  LDA $0715
L84A0:  CMP #$40
L84A2:  BCS $84AB
L84A4:  LSR
L84A5:  LSR
L84A6:  ORA #$90
L84A8:  STA SQ2Cntrl0
L84AB:  JSR $8466
L84AE:  JMP $8514

L84B1:  LDA SQ2InUse
L84B4:  BEQ $84BB

L84B6:  LDA #$00
L84B8:  STA SFXIndexSQ2
L84BA:  RTS

L84BB:  LDY SFXInitSQ2
L84BD:  BMI $8519

L84BF:  LDA SFXIndexSQ2
L84C1:  CPY #$01
L84C3:  BEQ $848A
L84C5:  CMP #$01
L84C7:  BEQ $849D
L84C9:  CPY #$02
L84CB:  BEQ $84DC
L84CD:  CMP #$02
L84CF:  BEQ $84EC
L84D1:  CPY #$03
L84D3:  BEQ $8523
L84D5:  CMP #$03
L84D7:  BEQ $852F
L84D9:  JMP $85B0

L84DC:  STY SFXIndexSQ2
L84DE:  LDA #$7F
L84E0:  STA $0715

L84E3:  LDX #$9C
L84E5:  LDY #$7F
L84E7:  LDA #$62
L84E9:  JSR UpdateSQ2           ;($F41B)Update SQ2 control and note bytes.

L84EC:  LDA $0715
L84EF:  CMP #$6C
L84F1:  BEQ $8514
L84F3:  BCC $8500
L84F5:  AND #$07
L84F7:  TAY
L84F8:  LDA $F80F,Y
L84FB:  STA SQ2Cntrl1
L84FE:  BNE $8514
L8500:  CMP #$6B
L8502:  BNE $8509
L8504:  LDY #$A5
L8506:  STY SQ2Cntrl1
L8509:  CMP #$30
L850B:  BCS $8514
L850D:  LSR
L850E:  LSR
L850F:  ORA #$90
L8511:  STA SQ2Cntrl0

L8514:  DEC $0715
L8517:  BNE $8522

L8519:  LDA #$00
L851B:  STA SFXIndexSQ2

L851D:  LDA #$10
L851F:  STA SQ2Cntrl0
L8522:  RTS

L8523:  STY SFXIndexSQ2
L8525:  LDA #$10
L8527:  STA $0715
L852A:  LDA #$04
L852C:  STA $0716
L852F:  LDY $0716
L8532:  LDA $0715
L8535:  CMP $F816,Y
L8538:  BNE $8550
L853A:  LDX #$84
L853C:  JSR SQ2CntrlAndSwpDis   ;($F412)Disable SQ2 and set control bits.
L853F:  LDY $0716
L8542:  LDA $F81A,Y
L8545:  STA SQ2Cntrl2
L8548:  LDA #$08
L854A:  STA SQ2Cntrl3
L854D:  DEC $0716
L8550:  JMP $8514

L8553:  STY SFXIndexSQ2
L8555:  LDA #$20
L8557:  STA $0715
L855A:  LDX #$1A
L855C:  LDY #$CD
L855E:  LDA #$42
L8560:  BNE $856F
L8562:  LDA $0715
L8565:  CMP #$18
L8567:  BNE $8572
L8569:  LDX #$94
L856B:  LDY #$C5
L856D:  LDA #$50
L856F:  JSR UpdateSQ2           ;($F41B)Update SQ2 control and note bytes.
L8572:  JMP $8514

L8575:  STY SFXIndexSQ2
L8577:  LDA #$10
L8579:  STA $0715
L857C:  LDA #$38
L857E:  BNE $8589
L8580:  LDA $0715
L8583:  CMP #$0C
L8585:  BNE $8591

L8587:  LDA #$44
L8589:  LDX #$CD
L858B:  STX SQ2Cntrl1
L858E:  JSR UpdateSQ2Note       ;($F41E)Update the SQ2 channel note frequency.

L8591:  LDY $0715
L8594:  LDA $F858,Y
L8597:  STA SQ2Cntrl0
L859A:  JMP $8514

L859D:  STY SFXIndexSQ2
L859F:  LDA #$10
L85A1:  STA $0715
L85A4:  LDX #$43
L85A6:  LDY #$84
L85A8:  LDA #$4C
L85AA:  JSR UpdateSQ2           ;($F41B)Update SQ2 control and note bytes.

L85AD:  JMP $8514
L85B0:  CPY #$04
L85B2:  BEQ $8553
L85B4:  CMP #$04
L85B6:  BEQ $8562
L85B8:  CPY #$05
L85BA:  BEQ $8575
L85BC:  CMP #$05
L85BE:  BEQ $8580
L85C0:  CPY #$06
L85C2:  BEQ $859D
L85C4:  CMP #$06
L85C6:  BEQ $85AD
L85C8:  CPY #$07
L85CA:  BEQ $85DB
L85CC:  CMP #$07
L85CE:  BEQ $85EB
L85D0:  CPY #$08
L85D2:  BEQ $85FA
L85D4:  CMP #$08
L85D6:  BEQ $860A
L85D8:  JMP $8666

L85DB:  STY SFXIndexSQ2
L85DD:  LDA #$16
L85DF:  STA $0715
L85E2:  LDX #$5F
L85E4:  LDY #$8B
L85E6:  LDA #$0E
L85E8:  JSR UpdateSQ2           ;($F41B)Update SQ2 control and note bytes.

L85EB:  LDA $0715
L85EE:  CMP #$10
L85F0:  BCS $85F7
L85F2:  ORA #$50
L85F4:  STA SQ2Cntrl0
L85F7:  JMP $8514

L85FA:  STY SFXIndexSQ2
L85FC:  LDA #$10
L85FE:  STA $0715
L8601:  LDX #$85
L8603:  LDY #$85
L8605:  LDA #$1C
L8607:  JSR UpdateSQ2           ;($F41B)Update SQ2 control and note bytes.
L860A:  JMP $8514

L860D:  STY SFXIndexSQ2
L860F:  LDA #$20
L8611:  STA $0715
L8614:  LDA #$8F
L8616:  STA $0716
L8619:  LDX #$5D
L861B:  LDY #$81
L861D:  JSR SetSQ2Control       ;($F414)Set control registers for SQ2.

L8620:  LDA $0716
L8623:  TAY
L8624:  JSR LogDiv16            ;($F44F)Logarithmically increase frequency.

L8627:  STA $0716
L862A:  ROL
L862B:  ROL
L862C:  STA SQ2Cntrl2
L862F:  ROL
L8630:  AND #$03
L8632:  ORA #$08
L8634:  STA SQ2Cntrl3
L8637:  LDA $0715
L863A:  CMP #$0D
L863C:  BCS $8643
L863E:  ORA #$90
L8640:  STA SQ2Cntrl0
L8643:  JMP $8514

L8646:  STY SFXIndexSQ2
L8648:  LDA #$10
L864A:  STA $0715
L864D:  LDA #$FF
L864F:  STA $0716
L8652:  LDX #$5D
L8654:  LDY #$81
L8656:  JSR SetSQ2Control       ;($F414)Set control registers for SQ2.

L8659:  LDA $0716
L865C:  TAY
L865D:  JSR LogDiv8             ;($F450)Logarithmically increase frequency.
L8660:  STA $0716
L8663:  JMP $862A
L8666:  CPY #$09
L8668:  BEQ $860D
L866A:  CMP #$09
L866C:  BEQ $8620
L866E:  CPY #$0A
L8670:  BEQ $8646
L8672:  CMP #$0A
L8674:  BEQ $8659
L8676:  CPY #$0B
L8678:  BEQ $8681
L867A:  CMP #$0B
L867C:  BEQ $8691
L867E:  JMP $86D9

L8681:  STY SFXIndexSQ2
L8683:  LDA #$18
L8685:  STA $0715
L8688:  LDX #$C8
L868A:  LDY #$CC
L868C:  LDA #$34
L868E:  JSR UpdateSQ2           ;($F41B)Update SQ2 control and note bytes.
L8691:  JMP $8514

L8694:  STY SFXIndexSQ2
L8696:  LDA #$0C
L8698:  STA $0715
L869B:  LDX #$03
L869D:  LDY #$C5
L869F:  JSR SetSQ2Control       ;($F414)Set control registers for SQ2.

L86A2:  LDA #$38
L86A4:  BNE $86B6
L86A6:  LDA $0715
L86A9:  CMP #$08
L86AB:  BNE $86B9
L86AD:  LDX #$02
L86AF:  LDY #$CC
L86B1:  JSR SetSQ2Control       ;($F414)Set control registers for SQ2.

L86B4:  LDA #$48
L86B6:  JMP $856F
L86B9:  JMP $8514

L86BC:  STY SFXIndexSQ2
L86BE:  LDA #$10
L86C0:  STA $0715

L86C3:  LDX #$88
L86C5:  LDY #$D3
L86C7:  LDA #$1C
L86C9:  JSR UpdateSQ2           ;($F41B)Update SQ2 control and note bytes.

L86CC:  LDA #$3A
L86CE:  JSR UpdateTriNote       ;($F422)Update the triangle channel note frequency.

L86D1:  LDA #$1C
L86D3:  STA TriangleCntrl0
L86D6:  JMP $8514
L86D9:  CPY #$0C
L86DB:  BEQ $8694
L86DD:  CMP #$0C
L86DF:  BEQ $86A6
L86E1:  CPY #$0D
L86E3:  BEQ $86BC
L86E5:  CMP #$0D
L86E7:  BEQ $86D6
L86E9:  CPY #$0E
L86EB:  BEQ $86FC
L86ED:  CMP #$0E
L86EF:  BEQ $870F
L86F1:  CPY #$0F
L86F3:  BEQ $872B
L86F5:  CMP #$0F
L86F7:  BEQ $873F
L86F9:  JMP $87D9

L86FC:  STY SFXIndexSQ2
L86FE:  LDA #$0A
L8700:  STA $0715
L8703:  LDA #$1A
L8705:  STA $0716
L8708:  LDX #$9F
L870A:  LDY #$83
L870C:  JSR SetSQ2Control       ;($F414)Set control registers for SQ2.

L870F:  LDA $0715
L8712:  CMP #$06
L8714:  BCC $871B
L8716:  JSR $8466
L8719:  BNE $8728
L871B:  CMP #$05
L871D:  BNE $8728
L871F:  LDX #$81
L8721:  LDY #$8B
L8723:  LDA #$34
L8725:  JSR UpdateSQ2           ;($F41B)Update SQ2 control and note bytes.
L8728:  JMP $8514

L872B:  STY SFXIndexSQ2
L872D:  LDA #$18
L872F:  STA $0715
L8732:  LDA #$14
L8734:  STA $0716
L8737:  LDX #$9E
L8739:  LDY #$B3
L873B:  LDA #$40
L873D:  BNE $874D
L873F:  LDA $0715
L8742:  CMP $0716
L8745:  BNE $8750
L8747:  LDX #$86
L8749:  LDY #$C5
L874B:  LDA #$5E
L874D:  JSR UpdateSQ2           ;($F41B)Update SQ2 control and note bytes.
L8750:  JMP $8514

L8753:  STY SFXIndexSQ2
L8755:  LDA #$60
L8757:  STA $0715
L875A:  LDA #$0C
L875C:  STA $0716
L875F:  LDA #$0F
L8761:  STA $0717
L8764:  LDA #$00
L8766:  STA $0728
L8769:  LDA #$04
L876B:  STA $0729
L876E:  LDY $0717
L8771:  LDA $0728
L8774:  BEQ $877B
L8776:  LDA $F845,Y
L8779:  BNE $877E
L877B:  LDA $F835,Y
L877E:  STA SQ2Cntrl0
L8781:  LDA $0715
L8784:  LDY $0716
L8787:  CMP $F822,Y
L878A:  BNE $87CB
L878C:  INY
L878D:  TYA
L878E:  LSR
L878F:  TAY
L8790:  LDA $F82E,Y
L8793:  STA $0717
L8796:  LDA $0716
L8799:  LSR
L879A:  BCS $87A2
L879C:  LDA #$CA
L879E:  LDX #$00
L87A0:  BEQ $87A6
L87A2:  LDA #$BB
L87A4:  LDX #$01
L87A6:  STX $0728
L87A9:  STA SQ2Cntrl1
L87AC:  LDA $0716
L87AF:  BEQ $87B4
L87B1:  DEC $0716
L87B4:  LDY $0729
L87B7:  LDA $F81E,Y
L87BA:  STA SQ2Cntrl2
L87BD:  LDA $F854,Y
L87C0:  STA SQ2Cntrl3
L87C3:  DEY
L87C4:  BNE $87C8
L87C6:  LDY #$04
L87C8:  STY $0729
L87CB:  LDA $0717
L87CE:  BEQ $87D3
L87D0:  DEC $0717
L87D3:  JMP $8514
L87D6:  JMP $8753
L87D9:  CPY #$10
L87DB:  BEQ $87D6
L87DD:  CMP #$10
L87DF:  BEQ $876E
L87E1:  CPY #$11
L87E3:  BEQ $87F4
L87E5:  CMP #$11
L87E7:  BEQ $8807
L87E9:  CPY #$12
L87EB:  BEQ $8823
L87ED:  CMP #$12
L87EF:  BEQ $8836
L87F1:  JMP $88B6

L87F4:  STY SFXIndexSQ2
L87F6:  LDA #$08
L87F8:  STA $0715
L87FB:  LDA #$1F
L87FD:  STA $0716
L8800:  LDX #$9A
L8802:  LDY #$83
L8804:  JSR SetSQ2Control       ;($F414)Set control registers for SQ2.

L8807:  LDA $0715
L880A:  CMP #$04
L880C:  BCC $8813
L880E:  JSR $8466
L8811:  BNE $8820
L8813:  CMP #$03
L8815:  BNE $8820
L8817:  LDX #$81
L8819:  LDY #$8B
L881B:  LDA #$50
L881D:  JSR UpdateSQ2           ;($F41B)Update SQ2 control and note bytes.
L8820:  JMP $8514

L8823:  STY SFXIndexSQ2
L8825:  LDA #$40
L8827:  STA $0715
L882A:  LDA #$FF
L882C:  STA $0716
L882F:  LDX #$1E
L8831:  LDY #$82
L8833:  JSR SetSQ2Control       ;($F414)Set control registers for SQ2.

L8836:  LDA $0716
L8839:  TAY
L883A:  JSR LogDiv16            ;($F44F)Logarithmically increase frequency.

L883D:  STA $0716
L8840:  ROL
L8841:  ROL
L8842:  STA SQ2Cntrl2
L8845:  ROL
L8846:  AND #$03
L8848:  ORA #$08
L884A:  STA SQ2Cntrl3

L884D:  LDA $0715
L8850:  CMP #$0C
L8852:  BCS $8859
L8854:  ORA #$90
L8856:  STA SQ2Cntrl0
L8859:  JMP $8514

L885C:  STY SFXIndexSQ2
L885E:  LDA #$10
L8860:  STA $0715

L8863:  LDX #$82
L8865:  LDY #$A2
L8867:  LDA #$56
L8869:  JSR UpdateSQ2           ;($F41B)Update SQ2 control and note bytes.

L886C:  LDA $0715
L886F:  CMP #$0E
L8871:  BNE $8878
L8873:  LDA #$3E
L8875:  JSR UpdateSQ2Note       ;($F41E)Update the SQ2 channel note frequency.
L8878:  JMP $8514

L887B:  STY SFXIndexSQ2
L887D:  LDA #$20
L887F:  STA $0715
L8882:  LDA #$7F
L8884:  BNE $888B
L8886:  LDA #$5F
L8888:  DEC $0715
L888B:  STA $0716
L888E:  LDX #$9E
L8890:  LDY #$82
L8892:  JSR SetSQ2Control       ;($F414)Set control registers for SQ2.

L8895:  LDA $0715
L8898:  CMP #$10
L889A:  BEQ $8886
L889C:  LDA $0716
L889F:  TAY
L88A0:  JSR LogDiv32            ;($F44E)Logarithmically increase frequency.

L88A3:  STA $0716
L88A6:  ROL
L88A7:  ROL
L88A8:  STA SQ2Cntrl2
L88AB:  ROL
L88AC:  AND #$03
L88AE:  ORA #$08
L88B0:  STA SQ2Cntrl3
L88B3:  JMP $8514

L88B6:  CPY #$13
L88B8:  BEQ $885C
L88BA:  CMP #$13
L88BC:  BEQ $886C
L88BE:  CPY #$14
L88C0:  BEQ $887B
L88C2:  CMP #$14
L88C4:  BEQ $8895
L88C6:  CPY #$15
L88C8:  BEQ $88CF
L88CA:  CMP #$15
L88CC:  BEQ $88DF
L88CE:  RTS

L88CF:  STY SFXIndexSQ2
L88D1:  LDA #$10
L88D3:  STA $0715

L88D6:  LDX #$C8
L88D8:  LDY #$AC
L88DA:  LDA #$42
L88DC:  JSR UpdateSQ2           ;($F41B)Update SQ2 control and note bytes.

L88DF:  JMP $8514

;------------------------------------------[ Music Player ]------------------------------------------

PlayMusic:
L88E2:  LDA MusicInit           ;
L88E4:  BMI StopMusic           ;
L88E6:  CMP #MUS_NONE7          ;Does music need to be stopped?
L88E8:  BEQ StopMusic           ;If so, branch.
L88EA:  CMP #MUS_NONE8          ;
L88EC:  BEQ StopMusic           ;

L88EE:  LDA MusicInit           ;Does new music need to be initialized?
L88F0:  BNE DoInitMusic         ;If so, branch.

L88F2:  LDA MusicIndex          ;Is music currently playing?
L88F4:  BEQ ExitNoMusic         ;If not, branch to exit.

L88F6:  JMP UpdateSQ2Music      ;($8A0A)Update the music.

DoInitMusic:
L88F9:  JMP InitMusic           ;($8964)Initialize new music.

L88FC:  LDA MusicIndex
L88FE:  CMP #MUS_TRAIN_RPT
L8900:  BCS $8969

StopMusic:
L8902:  LDA #$00
L8904:  STA MusicIndex

L8906:  LDA NoiseInUse
L8909:  BEQ $8922

L890B:  LDA SFXIndexSQ2
L890D:  BEQ $891B

L890F:  LDA #$10
L8911:  STA SQ1Cntrl0

L8914:  LDA #$00
L8916:  STA TriangleCntrl0
L8919:  BEQ ResetSQ1SQ2Env

L891B:  LDA #$10
L891D:  STA SQ2Cntrl0
L8920:  BNE $8911

L8922:  LDA $0726
L8925:  BEQ $8934

L8927:  LDA SFXIndexSQ2
L8929:  BEQ $892D
L892B:  BNE $8939

L892D:  LDA #$10
L892F:  STA SQ2Cntrl0
L8932:  BNE $894D

L8934:  LDA SQ2InUse
L8937:  BEQ ChkMusicEnd

L8939:  LDA #$10                ;Prepare to silence only triangle and noise channels.
L893B:  BNE SilenceTriNoise     ;Branch always.

ChkMusicEnd:
L893D:  LDA SFXIndexSQ2         ;Has the end of the music data been reached?
L893F:  BEQ SilenceAllChannels  ;If so, branch to stop the music.

L8941:  LDA #$10                ;Prepare to silence only SQ1, triangle and noise channels.
L8943:  BNE SilenceSQ1TriNoise  ;Branch always.

SilenceAllChannels:
L8945:  LDA #$10                ;Silence SQ2 channel.
L8947:  STA SQ2Cntrl0           ;

SilenceSQ1TriNoise:
L894A:  STA SQ1Cntrl0           ;Silence SQ1 channel.

SilenceTriNoise:
L894D:  STA NoiseCntrl0         ;
L8950:  LDA #$00                ;
L8952:  STA TriangleCntrl0      ;Silence all the audio channels.

ResetSQ1SQ2Env:
L8955:  LDA #$00                ;
L8957:  STA SQ2EnvIndex         ;Reset the SQ1 and SQ2 envelope indexes.
L895A:  STA SQ1EnvIndex         ;
L895D:  STA NoiseVolIndex       ;

ExitNoMusic:
L8960:  RTS                     ;No music is playing. Exit.

L8961:  JMP $88FC

InitMusic:
L8964:  TAX
L8965:  JSR $8906

L8968:  TXA

L8969:  STA MusicIndex
L896B:  STA $070A
L896E:  LDY #$00
L8970:  STY $070B
L8973:  LDY $070A
L8976:  LDA $8FFF,Y
L8979:  CLC
L897A:  ADC $070B
L897D:  INC $070B
L8980:  TAY
L8981:  LDA $9000,Y
L8984:  TAY
L8985:  BEQ $8961

L8987:  LDA MusicIndex          ;Is the music to be initialized in one of the upper indexes?
L8989:  CMP #MUS_VON_KAISER     ;
L898B:  BCS InitUpperMusic      ;If so, branch.

InitLowerMusic:
L898D:  LDA MusicInitTbl1,Y
L8990:  STA NoteLengthsBase

L8993:  LDA MusicInitTbl1+1,Y
L8996:  STA MusicDataPtrLB
L8998:  LDA MusicInitTbl1+2,Y
L899B:  STA MusicDataPtrUB

L899D:  LDA MusicInitTbl1+3,Y
L89A0:  STA TriNoteIndex

L89A3:  LDA MusicInitTbl1+4,Y
L89A6:  STA SQ1NoteIndex

L89A8:  LDA MusicInitTbl1+5,Y
L89AB:  STA NoiseMusicIndex
L89AE:  STA NoiseIndexReload

L89B1:  LDA MusicInitTbl1+6,Y
L89B4:  STA SQ2EnvBase

L89B7:  LDA MusicInitTbl1+7,Y
L89BA:  STA SQ1EnvBase

L89BD:  JMP PrepMusicStart      ;($89F3)Initialize remaining variables for music start.
L89C0:  JMP $8973

InitUpperMusic:
L89C3:  LDA MusicInitTbl2,Y
L89C6:  STA NoteLengthsBase

L89C9:  LDA MusicInitTbl2+1,Y
L89CC:  STA MusicDataPtrLB
L89CE:  LDA MusicInitTbl2+2,Y
L89D1:  STA MusicDataPtrUB

L89D3:  LDA MusicInitTbl2+3,Y
L89D6:  STA TriNoteIndex

L89D9:  LDA MusicInitTbl2+4,Y
L89DC:  STA SQ1NoteIndex

L89DE:  LDA MusicInitTbl2+5,Y
L89E1:  STA NoiseMusicIndex
L89E4:  STA NoiseIndexReload

L89E7:  LDA MusicInitTbl2+6,Y
L89EA:  STA SQ2EnvBase

L89ED:  LDA MusicInitTbl2+7,Y
L89F0:  STA SQ1EnvBase

PrepMusicStart:
L89F3:  LDA #$00                ;Index to SQ2 music data always comes first.
L89F5:  STA SQ2NoteIndex        ;

L89F7:  LDA #$01                ;
L89F9:  STA SQ2NoteRemain       ;
L89FC:  STA SQ1NoteRemain       ;Prepare to update notes on all channels.
L89FF:  STA TriNoteRemain       ;
L8A02:  STA NoiseNoteRemain     ;

L8A05:  LDA #$7F                ;Disable SQ1 sweep function.
L8A07:  STA SQ1SweepCntrl       ;

;------------------------------------[ SQ2 Music Channel Update ]------------------------------------

UpdateSQ2Music:
L8A0A:  LDA SFXIndexSQ2
L8A0C:  BNE $8A13

L8A0E:  LDA SQ2InUse
L8A11:  BEQ DecSQ2NoteTime

L8A13:  LDA SQ2EnvBase
L8A16:  CMP #$40
L8A18:  BCS $8A26

L8A1A:  LDA #$3F
L8A1C:  STA SQ2EnvIndex

L8A1F:  LDA #$01
L8A21:  STA $071A

L8A24:  BNE DecSQ2NoteTime

L8A26:  LDA #$00
L8A28:  STA SQ2EnvIndex

DecSQ2NoteTime:
L8A2B:  DEC SQ2NoteRemain       ;Is it time to load a new SQ2 note?
L8A2E:  BEQ GetNewSQ2Note       ;If so, branch.

L8A30:  BNE SQ2NoteContinue     ;Not time to load a new note. Branch always.

L8A32:  JSR GetNoteLength       ;($F400)Get the length of this note to play.
L8A35:  STA SQ2NoteLength       ;

GetNewSQ2Note:
L8A38:  LDY SQ2NoteIndex
L8A3A:  INC SQ2NoteIndex

L8A3C:  LDA (MusicDataPtr),Y
L8A3E:  BEQ $89C0
L8A40:  BMI $8A32

L8A42:  STA $0718
L8A45:  LDY SFXIndexSQ2
L8A47:  BNE ResetSQ2NoteLength

L8A49:  LDY SQ2InUse
L8A4C:  BNE ResetSQ2NoteLength

L8A4E:  JSR UpdateSQ2Note       ;($F41E)Update the SQ2 channel note frequency.
L8A51:  BEQ ResetSQ2NoteLength

L8A53:  LDA SQ2EnvBase
L8A56:  CMP #$80
L8A58:  BCC $8A5E

L8A5A:  LDA #$7F
L8A5C:  BNE $8A60

L8A5E:  LDA #$3F
L8A60:  STA SQ2EnvIndex

ResetSQ2NoteLength:
L8A63:  LDA SQ2NoteLength
L8A66:  STA SQ2NoteRemain

SQ2NoteContinue:
L8A69:  LDA SFXIndexSQ2
L8A6B:  BNE UpdateSQ1Music

L8A6D:  LDA SQ2InUse
L8A70:  BNE UpdateSQ1Music

L8A72:  LDA SQ2EnvBase
L8A75:  CMP #$40
L8A77:  BCS $8A98

L8A79:  LDA $0718
L8A7C:  CMP #$02
L8A7E:  BEQ $8A94

L8A80:  LDX $071A
L8A83:  BEQ $8A8D

L8A85:  JSR UpdateSQ2Note       ;($F41E)Update the SQ2 note frequency.

L8A88:  LDX #$00
L8A8A:  STX $071A

L8A8D:  LDA SQ2NoteRemain
L8A90:  CMP #$02
L8A92:  BCS $8A98

L8A94:  LDX #$10
L8A96:  BNE $8AAE

L8A98:  JSR $F472

L8A9B:  LDA SQ2EnvIndex
L8A9E:  BEQ $8AA5

L8AA0:  LSR                     ;/4. The envelope data will change every 4 frames.
L8AA1:  LSR                     ;

L8AA2:  DEC SQ2EnvIndex

L8AA5:  CLC
L8AA6:  ADC SQ2EnvBase
L8AA9:  TAY
L8AAA:  LDA $F674,Y
L8AAD:  TAX
L8AAE:  JSR SQ2CntrlAndSwpDis   ;($F412)Disable SQ2 sweep and set control bits.

;------------------------------------[ SQ1 Music Channel Update ]------------------------------------

UpdateSQ1Music:
L8AB1:  LDA SQ1NoteIndex
L8AB3:  BNE $8AB8

L8AB5:  JMP UpdateTRIMusic      ;($8B63)Update triangle musical note.

L8AB8:  LDA SFXIndexSQ1
L8ABA:  BEQ $8AD4

L8ABC:  LDA SQ1EnvBase
L8ABF:  CMP #$40
L8AC1:  BCS $8ACF

L8AC3:  LDA #$3F
L8AC5:  STA SQ1EnvIndex

L8AC8:  LDA #$01
L8ACA:  STA $071B
L8ACD:  BNE $8AD4

L8ACF:  LDA #$00
L8AD1:  STA SQ1EnvIndex

L8AD4:  DEC SQ1NoteRemain
L8AD7:  BEQ $8AE1

L8AD9:  BNE $8B18

L8ADB:  JSR GetNoteLength       ;($F400)Get the length of this note to play.
L8ADE:  STA SQ1NoteLength       ;

L8AE1:  LDY SQ1NoteIndex
L8AE3:  INC SQ1NoteIndex

L8AE5:  LDA (MusicDataPtr),Y
L8AE7:  BMI $8ADB

L8AE9:  BNE $8AF6

L8AEB:  LDY SQ1NoteIndex
L8AED:  INC SQ1NoteIndex

L8AEF:  LDA (MusicDataPtr),Y
L8AF1:  STA SQ1SweepCntrl       ;Set SQ1 sweep control byte.

L8AF4:  BNE $8AE1

L8AF6:  STA $0719
L8AF9:  LDY SFXIndexSQ1
L8AFB:  BNE $8B12

L8AFD:  JSR UpdateSQ1Note       ;($F429)Update the SQ1 channel note frequency.

L8B00:  BEQ $8B12
L8B02:  LDA SQ1EnvBase
L8B05:  CMP #$80
L8B07:  BCC $8B0D

L8B09:  LDA #$7F
L8B0B:  BNE $8B0F
L8B0D:  LDA #$3F
L8B0F:  STA SQ1EnvIndex

L8B12:  LDA SQ1NoteLength
L8B15:  STA SQ1NoteRemain

L8B18:  LDA SFXIndexSQ1
L8B1A:  BNE $8B63
L8B1C:  LDA SQ1EnvBase
L8B1F:  CMP #$40
L8B21:  BCS $8B42
L8B23:  LDA $0719
L8B26:  CMP #$02
L8B28:  BEQ $8B3E
L8B2A:  LDX $071B
L8B2D:  BEQ $8B37
L8B2F:  JSR UpdateSQ1Note       ;($F429)Update SQ1 note frequency.

L8B32:  LDX #$00
L8B34:  STX $071B
L8B37:  LDA SQ1NoteRemain
L8B3A:  CMP #$02
L8B3C:  BCS $8B42
L8B3E:  LDX #$10
L8B40:  BNE $8B58
L8B42:  JSR $F463
L8B45:  LDA SQ1EnvIndex
L8B48:  BEQ $8B4F
L8B4A:  LSR
L8B4B:  LSR
L8B4C:  DEC SQ1EnvIndex
L8B4F:  CLC
L8B50:  ADC SQ1EnvBase
L8B53:  TAY

L8B54:  LDA $F674,Y
L8B57:  TAX

L8B58:  LDY SQ1SweepCntrl       ;Prepare to set sweep control byte for SQ1.
L8B5B:  JSR SetSQ1Control       ;($F40B)Set control bits for the SQ1 channel.

L8B5E:  BNE UpdateTRIMusic      ;Done updating SQ1. Update triangle channel.

DoNoiseMusic:
L8B60:  JMP UpdateNoiseMusic    ;($8C1B)Update noise channel music.

;---------------------------------[ Triangle Music Channel Update ]----------------------------------

UpdateTRIMusic:
L8B63:  LDY TriNoteIndex
L8B66:  BEQ DoNoiseMusic

L8B68:  DEC $072A

L8B6B:  DEC TriNoteRemain
L8B6E:  BEQ $8B78

L8B70:  BNE $8BD2

L8B72:  JSR GetNoteLength       ;($F400)Get the length of this note to play.
L8B75:  STA TriNoteLength       ;

L8B78:  LDY TriNoteIndex
L8B7B:  INC TriNoteIndex

L8B7E:  LDA (MusicDataPtr),Y
L8B80:  BMI $8B72

L8B82:  LDY SFXIndexSQ2
L8B84:  CPY #$0D
L8B86:  BEQ $8BA1

L8B88:  LDY SFXIndexSQ1
L8B8A:  CPY #$18
L8B8C:  BEQ $8BA1

L8B8E:  CMP #$02                ;Should triangle note be silenced?
L8B90:  BNE PlayTriNote         ;If not, branch to play new note.

L8B92:  LDY #$00                ;Disable the triangle channel.
L8B94:  STY TriangleCntrl0      ;
L8B97:  BEQ +                   ;Branch always.

PlayTriNote:
L8B99:  LDY #$81                ;Enable the triangle channel.
L8B9B:  STY TriangleCntrl0      ;
L8B9E:  JSR UpdateTriNote       ;($F422)Update the triangle channel note frequency.

L8BA1:* LDA TriNoteLength
L8BA4:  STA TriNoteRemain

L8BA7:  LDY MusicIndex
L8BA9:  CPY #$15
L8BAB:  BEQ $8BB1

L8BAD:  CPY #$04
L8BAF:  BCS $8BD2

L8BB1:  CMP #$0B
L8BB3:  BCS $8BCD

L8BB5:  TAX
L8BB6:  SEC
L8BB7:  SBC #$02
L8BB9:  STA $072B

L8BBC:  TXA
L8BBD:  LSR
L8BBE:  STA $072A

L8BC1:  CMP #$04
L8BC3:  BCS $8BC9

L8BC5:  LDA #$00
L8BC7:  BEQ $8BCF

L8BC9:  LDA #$01
L8BCB:  BNE $8BCF

L8BCD:  LDA #$02
L8BCF:  STA $072C

L8BD2:  LDA SFXIndexSQ2
L8BD4:  CMP #$0D
L8BD6:  BEQ UpdateNoiseMusic

L8BD8:  LDA SFXIndexSQ1
L8BDA:  CMP #$18
L8BDC:  BEQ UpdateNoiseMusic

L8BDE:  LDA MusicIndex
L8BE0:  CMP #$15
L8BE2:  BEQ $8BE8

L8BE4:  CMP #$04
L8BE6:  BCS ChkTriNoteEnd

L8BE8:  LDA $072C
L8BEB:  CMP #$01
L8BED:  BEQ $8BFD

L8BEF:  CMP #$02
L8BF1:  BEQ $8C06

L8BF3:  LDA TriNoteRemain
L8BF6:  CMP $072B
L8BF9:  BNE UpdateNoiseMusic

L8BFB:  BEQ TriNoteEnd

L8BFD:  LDA $072A
L8C00:  CMP #$02
L8C02:  BNE UpdateNoiseMusic

L8C04:  BEQ TriNoteEnd

L8C06:  LDA TriNoteRemain
L8C09:  CMP #$07
L8C0B:  BNE UpdateNoiseMusic

L8C0D:  BEQ TriNoteEnd

ChkTriNoteEnd:
L8C0F:  LDA TriNoteRemain       ;Is it time to shut off the triangle note being played?
L8C12:  CMP #$02                ;
L8C14:  BNE UpdateNoiseMusic    ;If not, branch.

TriNoteEnd:
L8C16:  LDA #$00                ;Disable the triangle channel.
L8C18:  STA TriangleCntrl0      ;

;-----------------------------------[ Noise Channel Music Update ]-----------------------------------

UpdateNoiseMusic:
L8C1B:  LDA NoiseMusicIndex     ;Is the noise data for this piece of music?
L8C1E:  BEQ MusicUpdateEnd      ;If not, branch to end noise update.

L8C20:  LDA NoiseInUse          ;Is an SFX currently using the noise channel?
L8C23:  BEQ DecNoiseNoteTime    ;If not, branch to decrement noise time remaining.

L8C25:  LDA #$00                ;Disable volume control for this channel. It is being -->
L8C27:  STA NoiseVolIndex       ;controlled by the SFX player.

DecNoiseNoteTime:
L8C2A:  DEC NoiseNoteRemain     ;Decrement the time to play the note.
L8C2D:  BEQ GetNextNoiseNote    ;Is it time to get a new note? If so, branch.

L8C2F:  BNE ChkNoiseVolAdj      ;Branch always to see if the note decay needs to be changed.

UpdateNoiseLength:
L8C31:  JSR GetNoteLength       ;($F400)Get the length of this note to play.
L8C34:  STA NoiseNoteLength     ;

GetNextNoiseNote:
L8C37:  LDY NoiseMusicIndex     ;Prepare to get next note data byte for the noise channel.
L8C3A:  INC NoiseMusicIndex     ;

L8C3D:  LDA (MusicDataPtr),Y    ;Get next noise music data byte. Is this a control byte?
L8C3F:  BMI UpdateNoiseLength   ;If so, branch to change the note length.

L8C41:  BNE SaveNoiseDecay      ;Should beat start over? If not, branch.

L8C43:  LDA NoiseIndexReload    ;Restart drum beat from beginning.
L8C46:  STA NoiseMusicIndex     ;Is this an active music channel? 
L8C49:  BNE GetNextNoiseNote    ;If so, branch to get next musical note data.

SaveNoiseDecay:
L8C4B:  TAY                     ;Save the drum beat type to check later.
L8C4C:  STA NoiseBeatType       ;

L8C4F:  LDA NoiseInUse          ;Is npise channel being used by an SFX?
L8C52:  BNE ResetNoiseNoteLen   ;If so, branch to keep SFX active.

L8C54:  LDA NoiseDatTbl-2,Y     ;
L8C57:  STA NoiseCntrl0         ;
L8C5A:  LDA NoiseDatTbl-1,Y     ;Get the next drum beat and load it into the noise registers.
L8C5D:  STA NoiseCntrl2         ;
L8C60:  LDA NoiseDatTbl,Y       ;
L8C63:  STA NoiseCntrl3         ;

L8C66:  LDA #$27                ;Have drum beat potentially decay over 40 frames ->>
L8C68:  STA NoiseVolIndex       ;if drum beat 10 or 11.

ResetNoiseNoteLen:
L8C6B:  LDA NoiseNoteLength     ;Set the max length of time for this note.
L8C6E:  STA NoiseNoteRemain     ;

ChkNoiseVolAdj:
L8C71:  LDA NoiseBeatType       ;Is this drum beat 10 or 11?
L8C74:  CMP #DRUM_BEAT_10       ;
L8C76:  BCC MusicUpdateEnd      ;If not, branch to end. No decay will be applied.

L8C78:  LDA NoiseInUse          ;Is the noise channel being used by an SFX?
L8C7B:  BNE MusicUpdateEnd      ;If so, branch to exit.

L8C7D:  LDY NoiseVolIndex       ;Is there still noise volume left to decay?
L8C80:  BEQ SetNoiseVolume      ;If not, branch to avoid volume loop around.

L8C82:  DEC NoiseVolIndex       ;Decrement noise volume index advance the decay.

SetNoiseVolume:
L8C85:  LDA NoiseDecayTbl,Y     ;Adjust the volume of the drum beat to apply decay.
L8C88:  STA NoiseCntrl0         ;

MusicUpdateEnd:
L8C8B:  RTS                     ;End the music updating routines.

;----------------------------------------------------------------------------------------------------

;Unused.
L8C8C:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L8C9C:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L8CAC:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L8CBC:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L8CCC:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L8CDC:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L8CEC:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L8CFC:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L8D0C:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L8D1C:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L8D2C:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L8D3C:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L8D4C:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L8D5C:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L8D6C:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L8D7C:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L8D8C:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L8D9C:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L8DAC:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L8DBC:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L8DCC:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L8DDC:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L8DEC:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L8DFC:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L8E0C:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L8E1C:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L8E2C:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L8E3C:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L8E4C:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L8E5C:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L8E6C:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L8E7C:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L8E8C:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L8E9C:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L8EAC:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L8EBC:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L8ECC:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L8EDC:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L8EEC:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L8EFC:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L8F0C:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L8F1C:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L8F2C:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L8F3C:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L8F4C:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L8F5C:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L8F6C:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L8F7C:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L8F8C:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L8F9C:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L8FAC:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L8FBC:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L8FCC:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L8FDC:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L8FEC:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L8FFC:  .byte $00, $00, $00, $00

L9000:  .byte $1F, $2B, $48, $2F, $31, $33, $35, $37, $39, $3C, $3E, $3F, $48, $4C, $4E, $4F
L9010:  .byte $51, $53, $55, $57, $59, $5B, $5C, $5D, $5E, $5F, $63, $64, $65, $67, $69, $05
L9020:  .byte $0D, $15, $05, $0D, $15, $05, $0D, $1D, $25, $2D, $00, $35, $15, $00, $00, $3D
L9030:  .byte $00, $45, $00, $4D, $00, $55, $00, $5D, $00, $65, $6D, $00, $75, $00, $00, $05
L9040:  .byte $0D, $15, $05, $0D, $1D, $25, $2D, $00, $05, $0D, $15, $00, $7D, $00, $00, $10
L9050:  .byte $00, $18, $00, $20, $00, $28, $00, $30, $00, $38, $00, $00, $00, $00, $00, $40
L9060:  .byte $48, $50, $00, $00, $00, $78, $00, $80, $00

;----------------------------------------------------------------------------------------------------

;The following tables are used to initialize the different songs. There are a total of 8 bytes
;per entry
;Byte  1   - Index into NoteLengthsTbl.
;Bytes 2,3 - Starting address for the musical notes data.
;Byte  4   - Index into the musical notes data for the triangle channel.
;Byte  5   - Index into the musical notes data for the SQ1 channel.
;Byte  6   - Index into the musical notes data for the noise channel.
;Byte  7   - 
;Byte  8   - 
;NOTE: The SQ2 data always starts at index 0 of the music data.

MusicInitTbl1:
;Unused.
L9069:  .byte $58, $60, $68, $70, $00

;Music index #$01, #$03, #$0C, #$0D. Init attract/end music, part 1.
L906E:  .byte $17
L906F:  .word AttractMusic1
L9071:  .byte $5D, $40, $7B, $00, $60

;Init attract/end music part 2:
L9076:  .byte $17
L9077:  .word $91EF
L9079:  .byte $5D, $24, $7E, $70, $60

;Init Intro/attract/end music, part 2:
L907E:  .byte $17
L907F:  .word $9296
L9081:  .byte $4B, $1A, $71, $70, $60

;Init end music, part 3. The final conclusion after end credits.
L9086:  .byte $17
L9087:  .word $9338
L9089:  .byte $38, $15, $52, $70, $60

;Init end music, part 4.
L908E:  .byte $17
L908F:  .word $93B7
L9091:  .byte $11, $09, $19, $70, $60

;Init end music, part 5.
L9096:  .byte $17
L9097:  .word $93D8
L9099:  .byte $05, $03, $08, $70, $60

;Music index #$02. Init intro/end music, part 1.
L909E:  .byte $17
L909F:  .word $93E2
L90A1:  .byte $05, $03, $00, $70, $60

;Music index #$04. Init newspaper music.
L90A6:  .byte $45
L90A7:  .word $93E9
L90A9:  .byte $3F, $20, $76, $10, $10

;Music index #$05. Init circuit champion music.
L90AE:  .byte $45
L90AF:  .word $946A
L90B1:  .byte $43, $22, $00, $00, $00

;Music index #$06. Init fight win music.
L90B6:  .byte $45
L90B7:  .word $94D9
L90B9:  .byte $31, $19, $00, $00, $00

;Music index #$07. Init fight loss music.
L90BE:  .byte $45
L90BF:  .word $9602
L90C1:  .byte $21, $11, $00, $00, $00

;Music index #$08. Init title bout music.
L90C6:  .byte $45
L90C7:  .word $9529
L90C9:  .byte $2F, $18, $4B, $00, $00

;Music index #$09. Init game over music, part 1:
L90CE:  .byte $73
L90CF:  .word $963C
L90D1:  .byte $35, $1B, $59, $00, $00

;Init game over music, part 2:
L90D6:  .byte $73
L90D7:  .word $96AC
L90D9:  .byte $35, $1B, $59, $00, $00

MusicInitTbl2:
;Music index #$0A. Init pre-fight music.
L90DE:  .byte $45
L90DF:  .word $95D4
L90E1:  .byte $25, $0D, $00, $00, $60

;Music index #$0E. Init dream fight music.
L90E6:  .byte $45
L90E7:  .word $9592
L90E9:  .byte $27, $14, $2F, $00, $00

;Music index #$10. Init Von Kaiser/Macho Man intro music.
L90EE:  .byte $45
L90EF:  .word $972D
L90F1:  .byte $47, $1F, $65, $00, $00

;Music index #$11. Init Glass Joe Intro music.
L90F6:  .byte $45
L90F7:  .word $97A0
L90F9:  .byte $63, $31, $8D, $00, $00

;Music index #$12. Init Don Flamenco intro music.
L90FE:  .byte $45
L90FF:  .word $9866
L9101:  .byte $82, $41, $93, $00, $00

;Misic index #$13. Init King Hippo intro music.
L9106:  .byte $45
L9107:  .word $993C
L9109:  .byte $21, $11, $33, $80, $00

;Music index #$14. Init Soda Popinsky intro music.
L910E:  .byte $45
L910F:  .word $997C
L9111:  .byte $35, $1B, $62, $00, $00

;Music index #$15. Init Piston Honda intro music.
L9116:  .byte $45
L9117:  .word $99F2
L9119:  .byte $51, $16, $00, $00, $00

;Music index #$1A. Init training music, part 1.
L911E:  .byte $73
L911F:  .word $9A80
L9121:  .byte $73, $3D, $D4, $10, $00

;Init training music, part 2.
L9126:  .byte $73
L9127:  .word $9B61
L9129:  .byte $8C, $34, $BD, $80, $10

;Init training music, part 3.
L912E:  .byte $73
L912F:  .word $9C2B
L9131:  .byte $14, $12, $22, $80, $10

;Music index #$0F. Init main fight music, part 1.
L9136:  .byte $5C
L9137:  .word $9C5A
L9139:  .byte $41, $21, $00, $20, $20

;Init main fight music, part 2.
L913E:  .byte $5C
L913F:  .word $9CCD
L9141:  .byte $47, $24, $00, $20, $20

;Init main fight music, part 3.
L9146:  .byte $5C
L9147:  .word $9D35
L9149:  .byte $4D, $27, $00, $20, $20

;Init main fight music, part 4.
L914E:  .byte $5C
L914F:  .word $9DA3
L9151:  .byte $59, $2D, $00, $20, $20

;Music index #$1D. Init opponent down music.
L9156:  .byte $73
L9157:  .word $9E43
L9159:  .byte $41, $21, $00, $20, $20

;Music index #$1E. Init Little Mac down music.
L915E:  .byte $73
L915F:  .word $9EA5
L9161:  .byte $51, $29, $00, $20, $20

;-------------------------------------------[ Music Data ]-------------------------------------------

AttractMusic1:

AttractMusic1SQ2:
L9166:  .byte $93, $02, $94, $4C, $4C, $4C, $88, $4C, $42, $89, $4C, $88, $54, $4C, $89, $42
L9176:  .byte $83, $4C, $93, $02, $94, $54, $54, $54, $88, $54, $4C, $89, $54, $88, $5A, $54
L9186:  .byte $89, $4C, $83, $54, $82, $02, $80, $4C, $54, $83, $5A, $88, $42, $4C, $89, $54
L9196:  .byte $81, $5A, $80, $5E, $81, $62, $80, $60, $81, $5E, $80, $5C, $83, $5A, $42, $00

AttractMusic1SQ1:
L91A6:  .byte $87, $02, $02, $83, $02, $80, $5A, $5E, $5A, $5E, $5A, $5E, $5A, $5E, $5A, $5E
L91B6:  .byte $5A, $56, $81, $5A, $80, $58, $81, $56, $80, $54, $83, $50, $02

AttractMusic1Tri:
L91C3:  .byte $82, $34, $02, $86, $02, $82, $3C, $02, $86, $02, $82, $42, $02, $85, $02, $81
L91C6:  .byte $02, $80, $46, $81, $4A, $80, $48, $81, $46, $80, $44, $83, $42, $02

AttractMusic1Noise:
L91E1:  .byte $87               ;Play drum strike for 112 frames.
L91E2:  .byte DRUM_BEAT_11      ;Drum beat 11.
L91E3:  .byte DRUM_BEAT_10      ;Drum beat 10.
L91E4:  .byte DRUM_BEAT_10      ;Drum beat 10.
L91E5:  .byte $81               ;Play drum strike for 21 frames.
L91E6:  .byte DRUM_BEAT_10      ;Drum beat 10.
L91E7:  .byte $80               ;Play drum strike for 7 frames.
L91E8:  .byte DRUM_BEAT_9       ;Drum beat 9.
L91E9:  .byte $81               ;Play drum strike for 21 frames.
L91EA:  .byte DRUM_BEAT_10      ;Drum beat 10.
L91EB:  .byte $80               ;Play drum strike for 7 frames.
L91EC:  .byte DRUM_BEAT_9       ;Drum beat 9.
L91ED:  .byte $85               ;Play drum strike for 56 frames.
L91EE:  .byte DRUM_BEAT_10      ;Drum beat 10.

;----------------------------------------------------------------------------------------------------

L91EF:  .byte $83
L91F0:  .byte $54, $84, $4C, $82, $02, $42, $44, $83, $46, $82, $44, $83, $42, $82, $02, $83
L9200:  .byte $42, $56, $84, $50, $82, $02, $42, $44, $83, $46, $82, $44, $83, $42, $82, $02
L9210:  .byte $83, $42, $00, $83, $02, $80, $42, $44, $46, $48, $4A, $4C, $54, $56, $54, $56
L9220:  .byte $54, $56, $54, $56, $54, $56, $54, $56, $54, $56, $54, $56, $82, $54, $83, $02
L9230:  .byte $02, $80, $46, $48, $4A, $4C, $4E, $50, $56, $5A, $56, $5A, $56, $5A, $56, $5A
L9240:  .byte $56, $5A, $56, $5A, $56, $5A, $56, $5A, $82, $56, $83, $02, $82, $34, $42, $2A
L9250:  .byte $42, $34, $42, $2A, $42, $34, $42, $2A, $42, $34, $42, $2A, $42, $38, $42, $2A
L9260:  .byte $42, $38, $42, $2A, $42, $38, $42, $2A, $42, $38, $42, $2A, $42, $82, $1A, $1A
L9270:  .byte $83, $26, $82, $1A, $80, $1A, $1A, $82, $1E, $1A, $1A, $1A, $1E, $1A, $1A, $1A
L9280:  .byte $1E, $1A, $1A, $1A, $83, $26, $82, $1A, $1A, $1E, $80, $1A, $1A, $82, $1A, $1A
L9290:  .byte $1E, $1A, $1A, $1A, $1E, $1A, $83

L9296:  .byte $5A, $84, $54, $82, $02, $4A, $4C, $83, $50
L92A0:  .byte $4C, $4A, $82, $46, $44, $42, $44, $46, $48, $83, $4A, $54, $85, $4C, $02, $00
L92B0:  .byte $80, $58, $5A, $58, $5A, $58, $5A, $58, $5A, $5A, $5C, $5A, $5C, $5A, $5C, $5A
L92C0:  .byte $5C, $5C, $5E, $5C, $5E, $5C, $5E, $5C, $5E, $83, $40, $82, $40, $40, $42, $40
L92D0:  .byte $3E, $3C, $83, $38, $32, $82, $34, $80, $50, $54, $56, $5A, $5E, $62, $83, $64
L92E0:  .byte $02, $82

L92E2:  .byte $34, $42, $2A, $42, $34, $44, $3C, $44, $26, $3E, $34, $3E, $28, $40
L92F0:  .byte $34, $40, $2A, $2C, $2E, $30, $32, $42, $3C, $42, $34, $80, $20, $24, $26, $2A
L9300:  .byte $2E, $32, $82, $34, $02, $34, $02, $82, $1E, $80, $1E, $1E, $82, $1E, $80, $1E
L9310:  .byte $1E, $82, $1E, $80, $1E, $1E, $82, $1E, $80, $1E, $1E, $82, $1E, $80, $1E, $1E
L9320:  .byte $82, $1E, $80, $1E, $1E, $82, $1E, $80, $1E, $1E, $82, $1E, $80, $1E, $1E, $85
L9330:  .byte $26, $83, $26, $26, $86, $26, $83, $26

L9338:  .byte $83, $5A, $84, $54, $82, $02, $4A, $4C
L9340:  .byte $83, $50, $4C, $4A, $82, $46, $44, $83, $42, $44, $46, $4A, $00, $80, $58, $5A
L9350:  .byte $58, $5A, $58, $5A, $58, $5A, $5A, $5C, $5A, $5C, $5A, $5C, $5A, $5C, $5C, $5E
L9360:  .byte $5C, $5E, $5C, $5E, $5C, $5E, $83, $40, $82, $40, $40, $83, $3C, $3E, $3E, $42
L9370:  .byte $82, $34, $42, $2A, $42, $34, $44, $3C, $44, $26, $3E, $34, $3E, $28, $40, $34
L9380:  .byte $40, $82, $2A, $42, $2A, $42, $2A, $42, $2A, $42, $82, $1E, $80, $1E, $1E, $82
L9390:  .byte $1E, $80, $1E, $1E, $82, $1E, $80, $1E, $1E, $82, $1E, $80, $1E, $1E, $82, $1E
L93A0:  .byte $80, $1E, $1E, $82, $1E, $80, $1E, $1E, $82, $1E, $80, $1E, $1E, $82, $1E, $80
L93B0:  .byte $1E, $1E, $85, $26, $83, $26, $26

L93B7:  .byte $83, $4C, $88, $34, $88, $34, $89, $34, $00
L93C0:  .byte $83, $42, $88, $2A, $88, $2A, $89, $2A, $83, $4C, $88, $34, $88, $34, $89, $34
L93D0:  .byte $83, $26, $88, $2A, $88, $2A, $89, $2A

L93D8:  .byte $85, $34, $00, $85, $2A, $83, $34, $02, $85, $2A

L93E2:  .byte $83, $42, $00, $83, $02, $83, $02

L93E9:  .byte $85, $4C, $83, $42, $4C, $81, $50
L93F0:  .byte $80, $50, $85, $50, $82, $4C, $50, $85, $54, $83, $4C, $54, $81, $56, $80, $56
L9400:  .byte $85, $56, $82, $54, $56, $87, $5A, $02, $00, $85, $3C, $83, $3C, $3C, $81, $3E
L9410:  .byte $80, $3E, $85, $3E, $82, $3E, $3E, $85, $42, $83, $42, $42, $81, $50, $80, $50
L9420:  .byte $85, $50, $82, $4C, $50, $87, $54, $02, $83, $34, $88, $34, $34, $89, $34, $83
L9430:  .byte $34, $34, $30, $88, $30, $30, $89, $30, $83, $30, $30, $34, $88, $34, $34, $89
L9440:  .byte $34, $83, $34, $34, $30, $88, $30, $30, $89, $30, $83, $30, $30, $34, $88, $34
L9450:  .byte $34, $89, $34, $83, $34, $34, $34, $88, $34, $34, $89, $34, $83, $34, $34, $83
L9460:  .byte $02, $88, $02, $02, $89, $02, $83, $02, $02, $00

L946A:  .byte $83, $48, $80, $48, $48, $48
L9470:  .byte $48, $83, $44, $81, $42, $80, $3E, $81, $3C, $80, $42, $85, $4C, $82, $42, $4C
L9480:  .byte $85, $48, $83, $44, $88, $48, $44, $89, $48, $87, $4C, $00, $83, $38, $80, $38
L9490:  .byte $38, $38, $38, $83, $38, $81, $38, $80, $38, $81, $3C, $80, $3C, $85, $3C, $82
L94A0:  .byte $3C, $3C, $85, $38, $83, $38, $88, $38, $38, $89, $38, $87, $3C, $83, $48, $80
L94B0:  .byte $48, $48, $48, $48, $83, $48, $81, $48, $80, $48, $83, $4C, $80, $4C, $4C, $4C
L94C0:  .byte $4C, $83, $4C, $82, $34, $4C, $83, $48, $80, $48, $48, $48, $48, $83, $48, $48
L94D0:  .byte $83, $4C, $80, $34, $34, $34, $34, $85, $34

L94D9:  .byte $82, $4C, $4C, $5A, $80, $5A, $56
L94E0:  .byte $02, $56, $02, $54, $82, $56, $5A, $81, $60, $5E, $60, $5E, $82, $60, $5E, $86
L94F0:  .byte $64, $00, $82, $3C, $3C, $4C, $80, $4C, $4C, $02, $4C, $02, $4C, $82, $4C, $4C
L9500:  .byte $81, $50, $4C, $50, $4C, $82, $50, $4C, $86, $54, $82, $34, $34, $34, $80, $34
L9510:  .byte $34, $02, $34, $02, $34, $82, $34, $34, $81, $56, $56, $56, $56, $82, $56, $56
L9520:  .byte $83, $4C, $88, $34, $34, $89, $34, $83, $34

L9529:  .byte $82, $46, $4A, $4C, $83, $4A, $82
L9530:  .byte $4C, $83, $50, $82, $4C, $50, $54, $83, $50, $54, $82, $5A, $87, $5E, $83, $02
L9540:  .byte $00, $82, $3E, $3E, $3E, $83, $42, $82, $42, $83, $42, $82, $46, $46, $46, $83
L9550:  .byte $4A, $4A, $82, $4A, $87, $4E, $83, $02, $82, $46, $46, $46, $42, $42, $42, $42
L9560:  .byte $42, $3E, $3E, $3E, $42, $42, $42, $42, $42, $46, $46, $2E, $2E, $46, $2E, $2E
L9570:  .byte $83, $46, $82, $02, $82, $02, $02, $02, $83, $2A, $82, $02, $02, $02, $82, $02
L9580:  .byte $02, $02, $83, $2A, $82, $02, $02, $02, $82, $2A, $2A, $2A, $2A, $2A, $2A, $2A
L9590:  .byte $84, $2A

L9592:  .byte $83, $42, $83, $42, $82, $42, $42, $83, $4A, $82, $42, $4A, $82, $50
L95A0:  .byte $42, $4A, $50, $87, $5A, $00, $83, $02, $83, $32, $82, $32, $32, $83, $38, $82
L95B0:  .byte $38, $38, $82, $38, $38, $38, $38, $87, $62, $83, $02, $85, $38, $42, $4A, $87
L95C0:  .byte $50, $83, $2A, $83, $2A, $82, $2A, $2A, $83, $2A, $82, $2A, $2A, $82, $2A, $2A
L95D0:  .byte $2A, $2A, $87, $2A

L95D4:  .byte $90, $34, $89, $34, $86, $3E, $89, $42, $3E, $42, $86, $4C
L95E0:  .byte $00, $83, $02, $89, $56, $4C, $46, $56, $4C, $46, $56, $4C, $46, $56, $4C, $46
L95F0:  .byte $5E, $56, $4C, $5E, $56, $4C, $5E, $56, $4C, $83, $02, $3E, $34, $3E, $34, $3E
L9600:  .byte $34, $3E

L9602:  .byte $84, $34, $82, $02, $83, $34, $82, $38, $92, $3A, $8E, $38, $88, $3A
L9610:  .byte $91, $38, $00, $84, $2A, $82, $02, $83, $2A, $82, $2E, $92, $30, $8E, $2E, $88
L9620:  .byte $30, $91, $2E, $82, $34, $2A, $34, $2A, $34, $2A, $34, $2A, $3A, $30, $3A, $30
L9630:  .byte $3A, $30, $3A, $30, $38, $2E, $38, $2E, $38, $2E, $38, $2E

L963C:  .byte $82, $42, $4C, $50
L9640:  .byte $83, $52, $50, $48, $85, $3E, $82, $44, $42, $3E, $82, $42, $4C, $50, $83, $52
L9650:  .byte $50, $56, $85, $48, $84, $02, $00, $82, $3A, $42, $42, $83, $42, $42, $3E, $85
L9660:  .byte $38, $82, $38, $38, $38, $82, $3A, $42, $42, $83, $42, $42, $50, $85, $38, $84
L9670:  .byte $02, $82, $34, $34, $34, $34, $34, $34, $34, $34, $82, $48, $48, $48, $48, $48
L9680:  .byte $48, $48, $48, $82, $34, $34, $34, $34, $34, $34, $34, $34, $82, $48, $48, $48
L9690:  .byte $48, $48, $48, $48, $48, $82, $0A, $0A, $02, $0A, $82, $0A, $0A, $02, $0A, $82
L96A0:  .byte $0A, $0A, $02, $0A, $82, $0A, $0A, $02, $80, $0A, $02, $00

L96AC:  .byte $82, $42, $4C, $50
L96B0:  .byte $83, $52, $50, $48, $85, $3E, $82, $44, $42, $3E, $83, $52, $88, $56, $5A, $89
L96C0:  .byte $56, $83, $50, $48, $87, $4C, $00, $82, $3A, $42, $42, $83, $42, $42, $3E, $85
L96D0:  .byte $38, $82, $38, $38, $38, $83, $4C, $88, $4C, $4C, $89, $4C, $83, $3E, $38, $87
L96E0:  .byte $3C, $82, $34, $34, $34, $34, $34, $34, $34, $34, $82, $48, $48, $48, $48, $48
L96F0:  .byte $48, $48, $48, $83, $44, $88, $44, $44, $89, $44, $83, $48, $48, $4C, $80, $34
L9700:  .byte $34, $34, $34, $85, $34, $82, $0A, $0A, $02, $0A, $82, $0A, $0A, $02, $0A, $82
L9710:  .byte $0A, $0A, $02, $0A, $82, $0A, $0A, $02, $80, $0A, $02, $83, $0A, $88, $0A, $0A
L9720:  .byte $89, $0A, $83, $02, $02, $0A, $80, $02, $06, $0A, $0E, $85, $12

L972D:  .byte $82, $34, $80
L9730:  .byte $2E, $34, $83, $3C, $34, $82, $3C, $80, $34, $3C, $83, $42, $3C, $82, $42, $80
L9740:  .byte $3C, $42, $83, $4A, $89, $32, $32, $88, $32, $85, $3C, $00, $80, $5E, $54, $4C
L9750:  .byte $54, $5E, $54, $4C, $54, $5E, $54, $4C, $54, $5A, $54, $4C, $54, $5A, $54, $4C
L9760:  .byte $54, $5A, $54, $4C, $54, $5A, $54, $4A, $54, $5A, $54, $4A, $54, $89, $24, $24
L9770:  .byte $88, $24, $85, $34, $82, $2E, $80, $26, $2E, $83, $34, $2E, $82, $34, $80, $2E
L9780:  .byte $34, $83, $3C, $34, $82, $3C, $80, $34, $3C, $83, $42, $89, $2A, $2A, $88, $2A
L9790:  .byte $85, $34, $85, $16, $86, $2A, $86, $2A, $89, $26, $89, $26, $88, $26, $85, $2A

L97A0:  .byte $82, $38, $80, $38, $38, $82, $42, $42, $80, $02, $42, $02, $42, $82, $46, $46
L97B0:  .byte $80, $02, $46, $02, $46, $84, $50, $82, $4A, $42, $42, $4A, $42, $83, $3C, $85
L97C0:  .byte $4C, $88, $4A, $4C, $89, $46, $82, $42, $02, $88, $42, $42, $89, $42, $83, $42
L97D0:  .byte $00, $82, $02, $80, $02, $02, $82, $38, $38, $80, $02, $38, $02, $38, $82, $3E
L97E0:  .byte $3E, $80, $02, $3E, $02, $3E, $84, $4A, $82, $42, $83, $02, $82, $42, $02, $83
L97F0:  .byte $02, $85, $3C, $88, $38, $38, $89, $3E, $82, $38, $02, $88, $38, $38, $89, $38
L9800:  .byte $83, $38, $00, $82, $02, $80, $02, $02, $82, $38, $4A, $42, $4A, $38, $4C, $3E
L9810:  .byte $4C, $42, $4A, $50, $50, $50, $4A, $83, $42, $82, $42, $3C, $85, $34, $88, $38
L9820:  .byte $3E, $89, $46, $82, $4A, $02, $88, $4A, $4C, $89, $46, $83, $42, $82, $0E, $80
L9830:  .byte $0E, $0E, $82, $2A, $16, $80, $0E, $0E, $0E, $0E, $82, $2A, $16, $80, $0E, $0E
L9840:  .byte $0E, $0E, $82, $1A, $16, $2A, $16, $2A, $16, $80, $0E, $0E, $82, $16, $80, $0E
L9850:  .byte $0E, $0E, $0E, $83, $2A, $16, $88, $0E, $0E, $89, $0E, $82, $0E, $16, $88, $2A
L9860:  .byte $2A, $89, $2A, $83, $2A, $00

L9866:  .byte $82, $44, $80, $44, $44, $44, $3A, $34, $3A, $82
L9870:  .byte $44, $80, $44, $44, $44, $48, $4C, $48, $82, $44, $80, $44, $44, $48, $44, $42
L9880:  .byte $44, $83, $48, $80, $02, $48, $46, $48, $82, $4E, $80, $4E, $4E, $4E, $44, $40
L9890:  .byte $44, $82, $4E, $80, $4E, $4E, $4E, $52, $56, $52, $82, $4E, $80, $4E, $4C, $82
L98A0:  .byte $48, $80, $48, $46, $85, $42, $00, $82, $34, $80, $34, $34, $34, $34, $2C, $34
L98B0:  .byte $82, $34, $80, $34, $34, $34, $36, $3A, $36, $82, $34, $80, $34, $34, $42, $3E
L98C0:  .byte $3A, $3E, $83, $42, $80, $02, $42, $40, $42, $82, $3E, $80, $3E, $3E, $3E, $3E
L98D0:  .byte $36, $3E, $82, $82, $3E, $80, $3E, $3E, $3E, $42, $44, $42, $82, $3E, $80, $3E
L98E0:  .byte $3E, $82, $3E, $80, $3E, $3E, $85, $3C, $83, $2C, $22, $2C, $22, $2C, $2A, $26
L98F0:  .byte $22, $1E, $2C, $1E, $2C, $1E, $2A, $34, $2A, $80, $12, $16, $02, $16, $02, $16
L9900:  .byte $02, $16, $02, $16, $02, $16, $02, $16, $02, $16, $02, $16, $02, $16, $02, $16
L9910:  .byte $02, $16, $02, $16, $16, $16, $2A, $16, $16, $16, $02, $16, $02, $16, $02, $16
L9920:  .byte $02, $16, $02, $16, $02, $16, $02, $16, $02, $16, $02, $16, $02, $16, $02, $16
L9930:  .byte $02, $16, $2A, $16, $16, $16, $2A, $16, $16, $16, $16, $16

L993C:  .byte $83, $02, $48, $5A
L9940:  .byte $5A, $82, $5C, $5A, $58, $5A, $83, $02, $4E, $50, $85, $48, $00, $83, $02, $42
L9950:  .byte $48, $48, $82, $4C, $48, $44, $48, $83, $02, $48, $48, $85, $48, $83, $48, $3A
L9960:  .byte $3A, $3A, $82, $3E, $3A, $38, $3A, $83, $48, $3E, $3E, $85, $3E, $83, $02, $83
L9970:  .byte $2A, $0A, $0A, $2A, $0A, $0A, $2A, $0A, $0A, $2A, $02, $02

L997C:  .byte $82, $42, $3C, $83
L9980:  .byte $46, $85, $3C, $82, $42, $3C, $83, $46, $85, $3C, $83, $38, $3C, $38, $38, $82
L9990:  .byte $42, $3C, $83, $46, $85, $3C, $00, $82, $3C, $34, $83, $3A, $85, $34, $82, $3C
L99A0:  .byte $34, $83, $3A, $85, $34, $83, $34, $34, $34, $32, $82, $3C, $34, $83, $3A, $85
L99B0:  .byte $34, $83, $3C, $40, $82, $42, $80, $42, $46, $82, $42, $42, $83, $3C, $40, $82
L99C0:  .byte $42, $80, $42, $46, $82, $42, $42, $46, $44, $42, $40, $3E, $80, $2A, $2E, $82
L99D0:  .byte $3E, $80, $2A, $3E, $83, $3C, $40, $82, $42, $80, $42, $46, $83, $42, $83, $0E
L99E0:  .byte $0E, $0E, $2A, $0E, $0E, $0E, $2A, $0E, $0E, $0E, $2A, $82, $2A, $2A, $83, $2A
L99F0:  .byte $85, $2A

L99F2:  .byte $83, $46, $46, $85, $4A, $83, $46, $46, $85, $4A, $83, $46, $4A, $4C
L9A00:  .byte $4A, $46, $82, $4A, $46, $85, $3E, $00, $80, $34, $3C, $38, $34, $34, $3C, $38
L9A10:  .byte $34, $38, $3E, $3C, $38, $38, $3E, $3C, $38, $34, $3C, $38, $34, $34, $3C, $38
L9A20:  .byte $34, $38, $3E, $3C, $38, $3C, $38, $34, $4A, $34, $3C, $34, $3C, $38, $3E, $38
L9A30:  .byte $3E, $3C, $42, $3C, $42, $38, $3E, $38, $3E, $34, $2E, $3C, $34, $34, $3C, $34
L9A40:  .byte $3C, $85, $38, $81, $2E, $80, $34, $82, $3C, $46, $81, $2C, $80, $38, $82, $3E
L9A50:  .byte $42, $81, $2E, $80, $34, $82, $3C, $46, $81, $2C, $80, $38, $82, $3E, $42, $2E
L9A60:  .byte $80, $46, $2E, $82, $2C, $80, $42, $2A, $82, $2A, $80, $42, $2E, $82, $2C, $80
L9A70:  .byte $42, $2A, $81, $2E, $80, $32, $82, $34, $3C, $80, $02, $38, $3E, $46, $83, $4A

L9A80:  .byte $87, $46, $83, $54, $82, $50, $83, $4C, $4A, $87, $42, $82, $02, $83, $50, $82
L9A90:  .byte $4C, $83, $4A, $46, $87, $3E, $82, $02, $83, $4C, $82, $4A, $83, $46, $42, $8D
L9AA0:  .byte $3C, $82, $02, $88, $38, $3C, $87, $3E, $83, $02, $89, $02, $82, $3C, $83, $3A
L9AB0:  .byte $87, $3C, $82, $02, $82, $46, $83, $46, $84, $44, $83, $02, $00, $87, $3C, $83
L9AC0:  .byte $3C, $82, $3C, $83, $3C, $3C, $87, $38, $82, $02, $83, $38, $82, $38, $83, $38
L9AD0:  .byte $38, $87, $34, $82, $02, $83, $34, $82, $34, $83, $34, $34, $8D, $32, $82, $02
L9AE0:  .byte $87, $2E, $85, $02, $84, $02, $87, $32, $82, $02, $82, $3C, $3E, $40, $42, $44
L9AF0:  .byte $46, $48, $4A, $82, $2E, $46, $2E, $46, $2E, $46, $2E, $46, $2E, $46, $2E, $46
L9B00:  .byte $2E, $46, $2E, $46, $2A, $42, $2A, $42, $2A, $42, $2A, $42, $2A, $42, $2A, $42
L9B10:  .byte $2A, $42, $2A, $42, $26, $3E, $26, $3E, $26, $3E, $26, $3E, $26, $3E, $26, $3E
L9B20:  .byte $26, $3E, $26, $3E, $24, $3C, $24, $3C, $24, $3C, $24, $3C, $24, $3C, $24, $3C
L9B30:  .byte $24, $3C, $24, $3C, $20, $38, $20, $38, $20, $38, $20, $38, $20, $38, $20, $38
L9B40:  .byte $20, $38, $20, $38, $24, $3C, $24, $3C, $24, $3C, $24, $3C, $34, $38, $34, $38
L9B50:  .byte $34, $32, $2E, $2A, $82, $0A, $0E, $12, $0A, $0A, $0E, $80, $12, $12, $82, $0A
L9B60:  .byte $00

L9B61:  .byte $82, $5E, $83, $02, $82, $5E, $83, $02, $82, $5E, $02, $02, $5E, $83, $02
L9B70:  .byte $5E, $5E, $82, $5A, $83, $02, $82, $5A, $83, $02, $82, $5A, $02, $02, $5A, $83
L9B80:  .byte $02, $5A, $5A, $82, $56, $83, $02, $82, $56, $83, $02, $82, $56, $02, $02, $56
L9B90:  .byte $83, $02, $56, $56, $00, $8E, $46, $4A, $8F, $4C, $83, $02, $8E, $46, $4A, $8F
L9BA0:  .byte $4C, $83, $02, $8E, $46, $4A, $8F, $4C, $82, $02, $02, $46, $4A, $4C, $54, $83
L9BB0:  .byte $50, $82, $4C, $8E, $42, $46, $8F, $4A, $83, $02, $8E, $42, $46, $8F, $4A, $83
L9BC0:  .byte $02, $8E, $42, $46, $8F, $4A, $82, $02, $02, $42, $46, $4A, $50, $83, $4C, $8E
L9BD0:  .byte $3E, $42, $8F, $46, $83, $02, $8E, $3E, $42, $8F, $46, $83, $02, $8E, $3E, $42
L9BE0:  .byte $8F, $46, $82, $02, $02, $3E, $42, $46, $4C, $83, $4A, $82, $46, $82, $46, $2E
L9BF0:  .byte $2E, $46, $2E, $2E, $46, $2E, $46, $2E, $2E, $46, $2E, $2E, $46, $2E, $42, $2A
L9C00:  .byte $2A, $42, $2A, $2A, $42, $2A, $42, $2A, $2A, $42, $2A, $2A, $42, $2A, $3E, $26
L9C10:  .byte $26, $3E, $26, $26, $3E, $26, $3E, $26, $26, $3E, $26, $26, $3E, $26, $82, $0A
L9C20:  .byte $0E, $12, $0A, $0A, $0E, $80, $12, $12, $82, $0A, $00

L9C2B:  .byte $82, $3C, $83, $02, $82
L9C30:  .byte $3C, $83, $02, $82, $3C, $82, $02, $83, $3C, $38, $34, $32, $00, $8D, $3C, $82
L9C40:  .byte $3C, $24, $24, $3C, $24, $24, $3C, $24, $83, $3C, $38, $34, $32, $82, $0A, $0E
L9C50:  .byte $12, $0A, $0A, $0E, $80, $12, $12, $82, $0A, $00

L9C5A:  .byte $83, $3C, $84, $02, $82, $3C
L9C60:  .byte $3C, $83, $38, $86, $02, $82, $02, $83, $34, $84, $02, $82, $34, $34, $83, $38
L9C70:  .byte $86, $02, $82, $38, $83, $3C, $86, $02, $87, $02, $00, $83, $34, $84, $02, $82
L9C80:  .byte $34, $34, $83, $32, $86, $02, $82, $02, $83, $2E, $84, $02, $82, $2E, $2E, $83
L9C90:  .byte $32, $86, $02, $82, $32, $83, $34, $86, $02, $87, $02, $82, $2E, $2E, $2E, $2E
L9CA0:  .byte $2E, $2E, $2E, $2E, $2A, $2A, $2A, $2A, $2A, $2A, $2A, $2A, $26, $26, $26, $26
L9CB0:  .byte $26, $26, $26, $26, $42, $2A, $2A, $42, $2A, $2A, $42, $2A, $82, $46, $2E, $2E
L9CC0:  .byte $46, $2E, $2E, $46, $2E, $46, $2E, $46, $2E, $2E, $2E, $46, $2E

L9CCD:  .byte $86, $46, $83
L9CD0:  .byte $4A, $82, $4C, $02, $4C, $02, $4A, $46, $83, $02, $80, $44, $83, $46, $80, $02
L9CE0:  .byte $82, $42, $83, $02, $80, $44, $83, $46, $80, $02, $82, $42, $83, $02, $4C, $4A
L9CF0:  .byte $00, $86, $3C, $83, $3C, $82, $3C, $02, $3C, $02, $3C, $3C, $83, $02, $80, $3A
L9D00:  .byte $83, $3C, $80, $02, $82, $38, $83, $02, $80, $3A, $83, $3C, $80, $02, $82, $38
L9D10:  .byte $83, $02, $3C, $3C, $82, $46, $2E, $2E, $46, $2E, $2E, $46, $2E, $46, $2E, $46
L9D20:  .byte $2E, $2E, $2E, $46, $2E, $42, $2A, $2A, $42, $2A, $2A, $42, $2A, $42, $2A, $2A
L9D30:  .byte $42, $2A, $2A, $42, $2A

L9D35:  .byte $86, $46, $83, $4A, $82, $4C, $02, $4C, $02, $4A, $4C
L9D40:  .byte $83, $02, $80, $52, $83, $54, $80, $02, $82, $50, $83, $02, $80, $52, $83, $54
L9D50:  .byte $80, $02, $82, $50, $83, $02, $82, $54, $50, $54, $50, $00, $86, $3C, $83, $3C
L9D60:  .byte $82, $42, $02, $42, $02, $42, $42, $83, $02, $80, $44, $83, $46, $80, $02, $82
L9D70:  .byte $46, $83, $02, $80, $44, $83, $46, $80, $02, $82, $46, $83, $02, $82, $46, $46
L9D80:  .byte $46, $46, $82, $46, $2E, $2E, $46, $2E, $2E, $46, $2E, $46, $2E, $46, $2E, $2E
L9D90:  .byte $2E, $46, $2E, $3C, $24, $24, $3C, $24, $24, $3C, $24, $3C, $24, $24, $3C, $24
L9DA0:  .byte $24, $3C, $24

L9DA3:  .byte $86, $46, $82, $4C, $54, $02, $5E, $02, $64, $02, $62, $02, $86
L9DB0:  .byte $5A, $82, $02, $5E, $62, $02, $64, $02, $62, $02, $64, $62, $02, $86, $56, $82
L9DC0:  .byte $5A, $5E, $02, $5E, $02, $5E, $64, $83, $62, $82, $02, $87, $6C, $87, $02, $00
L9DD0:  .byte $86, $3C, $82, $3C, $3C, $02, $54, $02, $54, $02, $54, $02, $86, $4A, $82, $02
L9DE0:  .byte $54, $54, $02, $54, $02, $54, $02, $54, $50, $02, $86, $46, $82, $46, $4C, $02
L9DF0:  .byte $50, $02, $50, $50, $83, $50, $82, $02, $87, $4A, $87, $02, $82, $46, $2E, $2E
L9E00:  .byte $46, $2E, $2E, $46, $2E, $46, $2E, $46, $2E, $2E, $2E, $46, $2E, $82, $42, $2A
L9E10:  .byte $2A, $42, $2A, $2A, $42, $2A, $2A, $32, $2A, $38, $2A, $3E, $2A, $42, $82, $3E
L9E20:  .byte $26, $26, $3E, $26, $26, $3E, $26, $26, $2E, $26, $34, $26, $3C, $26, $3E, $24
L9E30:  .byte $3C, $24, $3C, $24, $3C, $24, $3C, $80, $3C, $3C, $02, $3C, $3C, $38, $34, $2E
L9E40:  .byte $83, $3C, $02

L9E43:  .byte $82, $34, $34, $38, $34, $02, $83, $3C, $82, $34, $83, $3E, $82
L9E50:  .byte $3C, $8C, $38, $82, $38, $38, $3C, $38, $02, $83, $3E, $82, $3C, $83, $42, $82
L9E60:  .byte $3E, $8C, $3C, $00, $82, $2A, $2A, $2A, $2A, $02, $83, $34, $82, $2A, $83, $38
L9E70:  .byte $82, $34, $8C, $32, $82, $2A, $2A, $2A, $2A, $02, $83, $32, $82, $32, $83, $34
L9E80:  .byte $82, $34, $8C, $34, $82, $34, $34, $34, $34, $34, $34, $34, $34, $34, $34, $34
L9E90:  .byte $34, $34, $34, $34, $34, $38, $38, $38, $38, $38, $38, $38, $38, $42, $42, $42
L9EA0:  .byte $42, $42, $42, $42, $42

L9EA5:  .byte $82, $54, $4C, $46, $83, $54, $82, $3C, $3C, $02, $82
L9EB0:  .byte $56, $50, $46, $83, $56, $82, $3E, $3E, $02, $82, $54, $4C, $46, $83, $54, $82
L9EC0:  .byte $3C, $3C, $02, $82, $50, $4A, $42, $83, $50, $82, $38, $38, $02, $00, $82, $4C
L9ED0:  .byte $46, $3C, $83, $4C, $82, $34, $34, $02, $82, $50, $46, $3E, $83, $50, $82, $38
L9EE0:  .byte $38, $02, $82, $4C, $46, $3C, $83, $4C, $82, $34, $34, $02, $82, $4A, $42, $38
L9EF0:  .byte $83, $4A, $82, $32, $32, $02, $82, $46, $46, $46, $46, $46, $46, $46, $46, $82
L9F00:  .byte $3E, $3E, $3E, $3E, $3E, $3E, $3E, $3E, $82, $46, $46, $46, $46, $46, $46, $46
L9F10:  .byte $46, $82, $42, $42, $42, $42, $42, $42, $42, $42

;----------------------------------------------------------------------------------------------------

;Unused.
L9F1A:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9F2A:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9F3A:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9F4A:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9F5A:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9F6A:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9F7A:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9F8A:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9F9A:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9FAA:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9FBA:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9FCA:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9FDA:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9FEA:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9FFA:  .byte $00, $00, $00, $00, $00, $00