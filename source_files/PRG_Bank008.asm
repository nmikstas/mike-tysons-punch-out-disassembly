
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
.alias InitSQ1SFX               $F4EF
.alias InitSQ1SQ2SFX			$F518
.alias SQDCEnvTbl               $F674
.alias NoiseDecayTbl            $F714
.alias NoiseDatTbl              $F73C
.alias DMCSamplePtrTbl          $F768
.alias FallSFXSweepTbl			$F776
.alias PnchMs1SFXTbl			$F77E
.alias PnchMs2SFXTbl			$F78E
.alias Talk1CntrlTbl			$F798
.alias Talk1NoteTbl				$F79C
.alias Talk2NoteTbl				$F7AC
.alias Talk3NoteTbl				$F7BC

;-----------------------------------------[ Start Of Code ]------------------------------------------

SoundEngine:
L8000:  LDA #$C0                ;Set APU to 5-step mode.
L8002:  STA APUCommonCntrl1     ;

L8005:  JSR PlayDMCSFX          ;($8025)Initialize or play DMC SFX.
L8008:  JSR PlaySQ1SFX          ;($80CA)Initialize or play SQ1 SFX.
L800B:  JSR PlaySQ2SFX          ;($84B1)Initialize or play SQ2 SFX.
L800E:  JSR PlayMusic           ;($88E2)Initialize or play music.

L8011:  LDA #$00                ;
L8013:  STA SFXInitSQ1          ;
L8015:  STA SFXInitSQ2          ;Clear out any initialization flags.
L8017:  STA MusicInit           ;
L8019:  STA DMCInit             ;
L801B:  RTS                     ;

;----------------------------------------------------------------------------------------------------
;|                                          DMC SFX Player                                          |
;----------------------------------------------------------------------------------------------------

IncToNextLaugh:
L801C:  LDY DMCIndex            ;Has the last laugh SFX segment been played?
L801E:  CPY #DMC_LAUGH5         ;
L8020:  BCS DMCSFXDone          ;If so, branch. SFX done.

L8022:  INY                     ;Initialize the next laugh segment.
L8023:  STY DMCInit             ;

PlayDMCSFX:
L8025:  LDY DMCInit             ;Does the DMC SFX need to be stopped?
L8027:  BMI DMCSFXDone          ;If so, branch.

L8029:  BNE DMCSFXInit          ;Does a new DMC SFX need to be started? If so, branch.

L802B:  LDA DMCIndex            ;Is the DMC playing the crowd cheering SFX?
L802D:  CMP #DMC_CROWD          ;
L802F:  BEQ DMCExit             ;If so, branch to exit. No timers to update.

L8031:  LDA DMCIndex            ;Is a DMC SFX currently being played?
L8033:  BEQ DMCDisable          ;If not, branch to keep DMC disabled and exit.

L8035:  DEC DMCLaughLength      ;Has this laugh segment finished?
L8038:  BEQ IncToNextLaugh      ;If so, branch to load next laugh segment.

L803A:  DEC DMCLghAudLength     ;Has the audible portion of this laugh segment completed?
L803D:  BEQ DMCDisable          ;
L803F:  RTS                     ;If so, branch to silence the DMC channel.

DMCSFXInit:
L8040:  STY DMCIndex            ;Save init index into currently playing DMC SFX index.

L8042:  LDA #$0E                ;Set length between DMC laugh SFX segments to be 14 frames.
L8044:  STA DMCLaughLength      ;

L8047:  LDX #$05                ;Assume the DMC SFX is 5 frames long.

L8049:  LDA DMCIndex            ;Is this the grunt SFX?
L804B:  CMP #DMC_GRUNT          ;
L804D:  BNE +                   ;If not, branch to keep length at 5 frames.

L804F:  LDX #$03                ;Grunt SFX is only 3 frames long.
L8051:* STX DMCLghAudLength     ;

L8054:  TYA                     ;
L8055:  ASL                     ;*2. 2 bytes per DMCSamplePtrTbl entry.
L8056:  TAY                     ;

L8057:  LDA DMCSamplePtrTbl-2,Y ;
L805A:  STA DMCCntrl2           ;Get the DMC sample data start address and byte count.
L805D:  LDA DMCSamplePtrTbl-1,Y ;
L8060:  STA DMCCntrl3           ;

L8063:  LDX #$4F                ;Assume the DMC SFX will repeat.
L8065:  LDA DMCIndex            ;Is this the repeatig crowd SFX?
L8067:  CMP #DMC_CROWD          ;
L8069:  BEQ SetDMCRegs          ;If so, branch to allow SFX to repeat.

L806B:  LDX #$0F                ;Disable DMC repeat.

SetDMCRegs:
L806D:  STX DMCCntrl0           ;Set sample rate for the fastest value(Best quality).

L8070:  LDA #$0F                ;
L8072:  STA APUCommonCntrl0     ;
L8075:  LDA #$1F                ;Disable then enable the DMC channel to start the SFX.
L8077:  STA APUCommonCntrl0     ;
L807A:  RTS                     ;

DMCSFXDone:
L807B:  LDA #$00                ;Indicate not current DMC SFX is running.
L807D:  STA DMCIndex            ;

DMCDisable:
L807F:  LDA #$0F                ;Disable DMC channel.
L8081:  STA APUCommonCntrl0     ;

DMCExit:
L8084:  RTS                     ;DMC channel disabled, exit.

;----------------------------------------------------------------------------------------------------
;|                                          SQ1 SFX Player                                          |
;----------------------------------------------------------------------------------------------------

;Punch SFX during intro after the start button has been pressed.

SQ1IntroPunchInit:
L8085:  LDA #$40                ;SFX will last for 64 frames.
L8087:  JSR InitSQ1SFX          ;($F4EF)Initialize SQ1 SFX.

L808A:  LDA #$1A				;Load initial timer data.
L808C:  STA SQ1SFXByte			;

L808F:  LDX #$9F				;50% duty, length cntr disabled, const. volume, volume=15(max).
L8091:  LDY #$83				;Enable sweep, 1 half frame, shift count=3.
L8093:  JSR SetSQ1Control       ;($F40B)Set control bits for the SQ1 channel.

SQ1IntroPunchCont:
L8096:  LDA SQ1SFXTimer			;Is this the first frame of the SFX?
L8099:  CMP #$40				;If so, branch to skip updating the volume.
L809B:  BCS ChkIntroPunchUpdt	;

L809D:  LSR						;Decrease volume by 1 every 4th frame.
L809E:  LSR						;
L809F:  ORA #$90				;Ensure 50% duty cycle with a constant volume.
L80A1:  STA SQ1Cntrl0			;

ChkIntroPunchUpdt:
L80A4:  LDA SQ1SFXTimer			;Update the SFX every 8 frames.
L80A7:  AND #$07				;Is it time to update the SFX?
L80A9:  BNE SQ1IntroPunchEnd	;If not, branch to exit for this frame.

L80AB:  LDA SQ1SFXByte			;
L80AE:  LSR						;
L80AF:  LSR						;Transfer upper nibble of SQ1SFXByte to lower nibble.
L80B0:  LSR						;
L80B1:  LSR						;

L80B2:  SEC						;Add lower nibble back into byte + 1.
L80B3:  ADC SQ1SFXByte			;Sequence: $1A, $1C, $1E, $20, $23, $26.
L80B6:  STA SQ1SFXByte			;

L80B9:  ROL						;
L80BA:  ROL						;Multiply by 8 to ensure channel is never muted.
L80BB:  ROL						;
L80BC:  STA SQ1Cntrl2			;Save lower timer value into control register.

L80BF:  ROL						;Rotate in the data for the upper timer value.
L80C0:  AND #$07				;Ensure only upper timer data is used.
L80C2:  ORA #$08				;Set length counter load to 1.
L80C4:  STA SQ1Cntrl3			;

SQ1IntroPunchEnd:
L80C7:  JMP FinishSQ1SFXFrame   ;($813E)Finish processing SQ1 SFX for this frame.

;----------------------------------------------------------------------------------------------------

PlaySQ1SFX:
L80CA:  LDY SFXInitSQ1          ;Does the SQ1 SFX need to be stopped?
L80CC:  BMI SilenceSQ1SFX       ;If so, branch.

ChkSQ1SFX1:
L80CE:  LDA SFXIndexSQ1         ;Does the SQ1 intro punch SFX need to be started?
L80D0:  CPY #SQ1_INTRO_PUNCH    ;If so, branch to initialize.
L80D2:  BEQ SQ1IntroPunchInit   ;
L80D4:  CMP #SQ1_INTRO_PUNCH    ;Is the SQ1 intro punch SFX already playing?
L80D6:  BEQ SQ1IntroPunchCont   ;If so, branch to continue SFX.

L80D8:  CPY #SQ1_FALL         	;Does the SQ1 fall SFX need to be started?
L80DA:  BEQ SQ1FallInit    		;If so, branch to initialize.
L80DC:  CMP #SQ1_FALL    		;Is the SQ1 fall SFX already playing?
L80DE:  BEQ SQ1FallCont   		;If so, branch to continue SFX.

L80E0:  CPY #SQ1_PUNCH1         ;Does the SQ1 punch1 SFX need to be started?
L80E2:  BEQ SQ1Punch1Init    	;If so, branch to initialize.
L80E4:  CMP #SQ1_PUNCH1    		;Is the SQ1 punch1 SFX already playing?
L80E6:  BEQ SQ1Punch1Cont   	;If so, branch to continue SFX.

L80E8:  JMP ChkSQ1SFX2          ;($81C7)Second phase of checking for SFX to play/continue.

;----------------------------------------------------------------------------------------------------

SQ1FallInit:
L80EB:  LDA #$7F                ;SFX will last for 127 frames.
L80ED:  JSR InitSQ1SFX          ;($F4EF)Initialize SQ1 SFX.

L80F0:  LDX #$9C				;50% duty cycle, no length counter, const. vol, vol=12.
L80F2:  LDY #$7F				;Disable Sweep.
L80F4:  LDA #SQ_B_5				;Note B5.
L80F6:  JSR UpdateSQ1           ;($F426)Update SQ1 control and note bytes.

SQ1FallCont:
L80F9:  LDA SQ1SFXTimer			;Is this the 20th frame of the SFX?
L80FC:  CMP #$6C				;
L80FE:  BEQ SQ1FallEnd			;If so, branch to end for this frame.

L8100:  BCC Fall2ndPart			;Is SFX been playing for more than 20 frames? If so, branch.

L8102:  AND #$07				;Get lower three bits of timer and use as index into FallSFXSweepTbl.
L8104:  TAY						;

L8105:  LDA FallSFXSweepTbl,Y	;Set sweep data for SQ1.
L8108:  STA SQ1Cntrl1			;
L810B:  BNE SQ1FallEnd			;Branch always.

Fall2ndPart:
L810D:  CMP #$6B				;Is this the 21st frame of the SFX?
L810F:  BNE +					;If not, branch.

L8111:  LDY #$A5				;Enable sweep. divider period=3 half frames, shift count=5, down.
L8113:  STY SQ1Cntrl1			;

L8116:* CMP #$30				;Is this the 80th or greater frame of the SFX?
L8118:  BCS SQ1FallEnd			;If so, branch.

L811A:  LSR						;Use timer to set volume.
L811B:  LSR						;
L811C:  ORA #$90				;Ensure 50% duty cycle and constant volume.
L811E:  STA SQ1Cntrl0			;

SQ1FallEnd:
L8121:  JMP FinishSQ1SFXFrame   ;($813E)Finish processing SQ1 SFX for this frame.

;----------------------------------------------------------------------------------------------------

SQ1Punch1Init:
L8124:  LDA #$16                ;SFX will last for 22 frames.
L8126:  JSR InitSQ1SFX          ;($F4EF)Initialize SQ1 SFX.

L8129:  LDX #$5F				;25% duty cycle, no len. counter, const. vol, vol=15(max).
L812B:  LDY #$8B				;Enable sweep, divider period=1 half frame, shift count=3, up.
L812D:  LDA #SQ_G_2				;Note G2.
L812F:  JSR UpdateSQ1           ;($F426)Update SQ1 control and note bytes.

SQ1Punch1Cont:
L8132:  LDA SQ1SFXTimer			;Is this the final 16 frames of the SFX?
L8135:  CMP #$10				;
L8137:  BCS FinishSQ1SFXFrame   ;If not, branch to finish processing SQ1 SFX for this frame.

L8139:  ORA #$50				;12.5% duty cycle, constant volume.
L813B:  STA SQ1Cntrl0			;

FinishSQ1SFXFrame:
L813E:  DEC SQ1SFXTimer         ;Decrement SQ1 SFX timer.
L8141:  BNE SQ1SFXEnd           ;Is SFX finished? If not, branch.

SilenceSQ1SFX:
L8143:  LDA NoiseInUse          ;Is the noise channel currently in use?
L8146:  BEQ ChkSQ2InUse1        ;If not, branch.

L8148:  LDA #$10                ;
L814A:  STA NoiseCntrl0         ;Silence the noise channel and clear in use flag.
L814D:  LDA #$00                ;
L814F:  STA NoiseInUse          ;

ChkSQ2InUse1:
L8152:  LDA SQ2InUse            ;Is the SQ2 channel currently in use?
L8155:  BEQ ClearSQ1InUse       ;If not, branch to clear SQ1 in use flag.

L8157:  LDA #$10                ;
L8159:  STA SQ2Cntrl0           ;Silence the SQ2 channel and clear the in use flag.
L815C:  LDA #$00                ;
L815E:  STA SQ2InUse            ;

ClearSQ1InUse:
L8161:  LDA #$00                ;
L8163:  STA SQ1InUse            ;Clear SQ1 SFX in use flag and clear index.
L8166:  LDA #$00                ;
L8168:  STA SFXIndexSQ1         ;

L816A:  LDA #$10                ;Silence SQ1 SFX channel.
L816C:  STA SQ1Cntrl0           ;

SQ1SFXEnd:
L816F:  RTS                     ;Finished processing SQ1 SFX. return.

;----------------------------------------------------------------------------------------------------

SQ1PunchBlockInit:
L8170:  LDA #$04                ;SFX will last for 4 frames.
L8172:  JSR InitSQ1SQ2SFX		;($F518)Use noise channel for SFX, disable SQ1, SQ2.

L8175:  LDX #$0A				;No loop, period=10.
L8177:  LDA #$1A				;Length counter halt, Volume=10.
L8179:  LDY #$08				;Length counter=1.

L817B:  STY NoiseCntrl3			;
L817E:  STX NoiseCntrl2			;Update npise channel.
L8181:  STA NoiseCntrl0			;

L8184:  LDX #$DA				;25% duty cycle, constant volume, volume=10.
L8186:  LDY #$85				;Enable sweep, shift count=5, down.
L8188:  LDA #SQ_E_3				;Note E3.
L818A:  JSR UpdateSQ1           ;($F426)Update SQ1 control and note bytes.

SQ1PunchBlockCont:
L818D:  JMP FinishSQ1SFXFrame   ;($813E)Finish processing SQ1 SFX for this frame.

;----------------------------------------------------------------------------------------------------

SQ1OppPunch1Init:
L8190:  LDA #$20                ;SFX will last for 32 frames.
L8192:  JSR InitSQ1SFX          ;($F4EF)Initialize SQ1 SFX.

L8195:  LDA #$FF				;Load initial value used for SQ1 timer value.
L8197:  STA SQ1SFXByte			;

L819A:  LDX #$1E				;12.5% duty cycle, const. vol, vol=14.
L819C:  LDY #$81				;Enable sweep, down, shift count=1.
L819E:  JSR SetSQ1Control       ;($F40B)Set control bits for the SQ1 channel.

SQ1OppPunch1Cont:
L81A1:  LDA SQ1SFXByte			;Prepare to decrease SQ1SFXByte.
L81A4:  TAY						;
L81A5:  JSR LogDiv8             ;($F450)Logarithmically increase frequency.

L81A8:  STA SQ1SFXByte			;Update SQ1SFXByte with new value.

L81AB:  ROL						;
L81AC:  ROL						;Update lower timer value.
L81AD:  STA SQ1Cntrl2			;

L81B0:  ROL						;Update upper timer value(only 3 bits).
L81B1:  AND #$03				;

L81B3:  ORA #$08				;Length counter=1.
L81B5:  STA SQ1Cntrl3			;

L81B8:  LDA SQ1SFXTimer			;Is SQ1SFXTimer at its minimum value?
L81BB:  CMP #$0E				;
L81BD:  BCS +					;If so, branch.

L81BF:  ORA #$90				;Ensure 25% duty cycle and constant volume.
L81C1:  STA SQ1Cntrl0			;
L81C4:* JMP FinishSQ1SFXFrame   ;($813E)Finish processing SQ1 SFX for this frame.

;----------------------------------------------------------------------------------------------------

ChkSQ1SFX2:
L81C7:  CPY #SQ1_PUNCH_BLOCK    ;Does the SQ1 punch block SFX need to be started?
L81C9:  BEQ SQ1PunchBlockInit	;If so, branch to initialize.
L81CB:  CMP #SQ1_PUNCH_BLOCK    ;Is the SQ1 punch block SFX already playing?
L81CD:  BEQ SQ1PunchBlockCont   ;If so, branch to continue SFX.

L81CF:  CPY #SQ1_OPP_PUNCH1    	;Does the SQ1 opp punch1 SFX need to be started?
L81D1:  BEQ SQ1OppPunch1Init	;If so, branch to initialize.
L81D3:  CMP #SQ1_OPP_PUNCH1    	;Is the SQ1 opp punch1 SFX already playing?
L81D5:  BEQ SQ1OppPunch1Cont   	;If so, branch to continue SFX.

L81D7:  CPY #SQ1_PUNCH_MISS1    ;Does the SQ1 punch miss1 SFX need to be started?
L81D9:  BEQ SQ1PunchMiss1Init	;If so, branch to initialize.
L81DB:  CMP #SQ1_PUNCH_MISS1    ;Is the SQ1 punch miss1 SFX already playing?
L81DD:  BEQ SQ1PunchMiss1Cont   ;If so, branch to continue SFX.

L81DF:  CPY #SQ1_PUNCH_MISS2    ;Does the SQ1 punch miss2 SFX need to be started?
L81E1:  BEQ SQ1PunchMiss2Init	;If so, branch to initialize.
L81E3:  CMP #SQ1_PUNCH_MISS2    ;Is the SQ1 punch miss2 SFX already playing?
L81E5:  BEQ SQ1PunchMiss2Cont   ;If so, branch to continue SFX.

L81E7:  CPY #SQ1_PUNCH2    		;Does the SQ1 punch2 SFX need to be started?
L81E9:  BEQ SQ1Punch2Init		;If so, branch to initialize.
L81EB:  CMP #SQ1_PUNCH2    		;Is the SQ1 punch2 SFX already playing?
L81ED:  BEQ SQ1Punch2Cont   	;If so, branch to continue SFX.

L81EF:  JMP ChkSQ1SFX3          ;($827F)Third phase of checking for SFX to play/continue.

;----------------------------------------------------------------------------------------------------

SQ1PunchMiss1Init:
L81F2:  LDA #$10                ;SFX will last for 16 frames.
L81F4:  JSR InitSQ1SQ2SFX		;($F518)Use noise channel for SFX, disable SQ1, SQ2.

SQ1PunchMiss1Cont:
L81F7:  LDY SQ1SFXTimer			;Get noise data from table based on SFX timer.
L81FA:  LDA PnchMs1SFXTbl-1,Y	;

ParseNoiseData:
L81FD:  TAX						;Save a copy of the data.

L81FE:  AND #$0F				;Set period of noise channel.
L8200:  STA NoiseCntrl2			;

L8203:  TXA						;
L8204:  LSR						;
L8205:  LSR						;Move upper nibble to lower nibble.
L8206:  LSR						;
L8207:  LSR						;

L8208:  ORA #$10				;Ensure the length counter is halted.
L820A:  STA NoiseCntrl0			;Set volume of noise channel.

L820D:  LDA #$08				;Set length of counter to 1.
L820F:  STA NoiseCntrl3			;
L8212:  JMP FinishSQ1SFXFrame   ;($813E)Finish processing SQ1 SFX for this frame.

;----------------------------------------------------------------------------------------------------

SQ1PunchMiss2Init:
L8215:  LDA #$0A                ;SFX will last for 10 frames.
L8217:  JSR InitSQ1SQ2SFX		;($F518)Use noise channel for SFX, disable SQ1, SQ2.

SQ1PunchMiss2Cont:
L821A:  LDY SQ1SFXTimer			;Get noise data from table.
L821D:  LDA PnchMs2SFXTbl-1,Y	;
L8220:  BNE ParseNoiseData		;Branch always.

;----------------------------------------------------------------------------------------------------

SQ1Punch2Init:
L8222:  LDA #$10                ;SFX will last for 16 frames.
L8224:  JSR InitSQ1SFX          ;($F4EF)Initialize SQ1 SFX.

L8227:  LDX #$43				;25% duty cycle. length count, const vol disabled, vol=3.
L8229:  LDY #$84				;Sweep enabled, shift count=4, down.
L822B:  LDA #SQ_C_5				;Note C5.
L822D:  JSR UpdateSQ1           ;($F426)Update SQ1 control and note bytes.

SQ1Punch2Cont:
L8230:  JMP FinishSQ1SFXFrame   ;($813E)Finish processing SQ1 SFX for this frame.

;----------------------------------------------------------------------------------------------------

SQ1Talk1Init:
L8233:  LDA #$04                ;SFX will last for 4 frames.
L8235:  JSR InitSQ1SFX          ;($F4EF)Initialize SQ1 SFX.

L8238:  LDA #$7F				;Disable sweep.
L823A:  STA SQ1Cntrl1			;

L823D:  INC SQ1SFXByte			;Increment SQ1SFXByte. Doesn't matter where it starts.
L8240:  LDA SQ1SFXByte			;
L8243:  AND #$0F				;Get last 4 bits of SQ1SFXByte.

L8245:  TAY						;Grab a note from the table. All the notes are C6.
L8246:  LDA Talk1NoteTbl,Y		;
L8249:  JSR UpdateSQ1Note       ;($F429)Update SQ1 note frequency.

SQ1Talk1Cont:
L824C:  LDY SQ1SFXTimer			;Load a new value for SQ1Cntrl0 based on the SFX timer.
L824F:  LDA Talk1CntrlTbl-1,Y	;
L8252:  STA SQ1Cntrl0			;
L8255:  JMP FinishSQ1SFXFrame   ;($813E)Finish processing SQ1 SFX for this frame.

;----------------------------------------------------------------------------------------------------

SQ2Talk23Init:
L8258:  LDA #$04                ;SFX will last for 4 frames.
L825A:  JSR InitSQ1SFX          ;($F4EF)Initialize SQ1 SFX.

L825D:  LDA #$BC
L825F:  STA SQ1Cntrl1

L8262:  INC SQ1SFXByte
L8265:  LDA SQ1SFXByte
L8268:  AND #$0F

L826A:  TAY
L826B:  LDA SFXIndexSQ1
L826D:  CMP #SQ1_TALK3
L826F:  BEQ GetTalk3Note

GetTalk2Note:
L8271:  LDA Talk2NoteTbl,Y
L8274:  BNE SetTalk23Note

GetTalk3Note:
L8276:  LDA Talk3NoteTbl,Y

SetTalk23Note:
L8279:  JSR UpdateSQ1Note       ;($F429)Update SQ1 note frequency.

SQ1Talk23Cont:
L827C:  JMP SQ1Talk1Cont		;($824C)Load SQ1Cntrl0 based on the SFX timer.

;----------------------------------------------------------------------------------------------------

ChkSQ1SFX3:
L827F:  CPY #SQ1_TALK1    		;Does the SQ1 talk1 SFX need to be started?
L8281:  BEQ SQ1Talk1Init		;If so, branch to initialize.
L8283:  CMP #SQ1_TALK1    		;Is the talk1 SFX already playing?
L8285:  BEQ SQ1Talk1Cont   		;If so, branch to continue SFX.

L8287:  CPY #SQ1_TALK2    		;Does the SQ1 talk2 SFX need to be started?
L8289:  BEQ SQ2Talk23Init		;If so, branch to initialize.
L828B:  CMP #SQ1_TALK2    		;Is the talk2 SFX already playing?
L828D:  BEQ SQ1Talk23Cont   	;If so, branch to continue SFX.

L828F:  CPY #SQ1_TALK3    		;Does the SQ1 talk3 SFX need to be started?
L8291:  BEQ SQ2Talk23Init		;If so, branch to initialize.
L8293:  CMP #SQ1_TALK3    		;Is the talk3 SFX already playing?
L8295:  BEQ SQ1Talk23Cont   	;If so, branch to continue SFX.

L8297:  CPY #SQ1_BELL1    		;Does the SQ1 bell1 SFX need to be started?
L8299:  BEQ SQ1Bell1Init		;If so, branch to initialize.
L829B:  CMP #SQ1_BELL1    		;Is the bell1 SFX already playing?
L829D:  BEQ SQ1Bell1Cont   		;If so, branch to continue SFX.

L829F:  JMP ChkSQ1SFX4          ;($8316)Fourth phase of checking for SFX to play/continue.

;----------------------------------------------------------------------------------------------------

SQ1Bell1Init:
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

SQ1Bell1Cont:
L82BE:  LDA SQ1SFXTimer
L82C1:  CMP #$28
L82C3:  BNE $82CD
L82C5:  LDX #$8F
L82C7:  STX SQ1Cntrl0
L82CA:  STX SQ2Cntrl0
L82CD:  JMP FinishSQ1SFXFrame   ;($813E)Finish processing SQ1 SFX for this frame.

;----------------------------------------------------------------------------------------------------

L82D0:  LDA #$0F
L82D2:  JSR $F494
L82D5:  LDA #$00
L82D7:  STA SQ1SFXByte
L82DA:  LDA SQ1SFXTimer
L82DD:  LSR
L82DE:  CLC
L82DF:  ADC SQ1SFXByte
L82E2:  TAY
L82E3:  LDA $F7CC,Y
L82E6:  JSR $F4CD
L82E9:  LDA $F7EB,Y
L82EC:  JSR $F4DD
L82EF:  JMP FinishSQ1SFXFrame   ;($813E)Finish processing SQ1 SFX for this frame.

L82F2:  LDA #$12
L82F4:  JSR $F494
L82F7:  LDA #$08
L82F9:  STA SQ1SFXByte
L82FC:  BNE $82DA

L82FE:  LDA #$1E
L8300:  JSR $F494
L8303:  LDA #$08
L8305:  STA SQ1SFXByte
L8308:  BNE $82DA

L830A:  LDA #$0C
L830C:  JSR $F494
L830F:  LDA #$18
L8311:  STA SQ1SFXByte
L8314:  BNE $82DA

;----------------------------------------------------------------------------------------------------

ChkSQ1SFX4:
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

L8356:  JMP ChkSQ1SFX5          ;($8402)Fifth phase of checking for SFX to play/continue.

;----------------------------------------------------------------------------------------------------

L8359:  LDA #$05
L835B:  JSR InitSQ1SQ2SFX		;($F518)Use noise channel for SFX, disable SQ1, SQ2.

L835E:  LDY SQ1SFXTimer
L8361:  LDA $F809,Y
L8364:  JMP $81FD
L8367:  LDA #$20
L8369:  JSR InitSQ1SFX          ;($F4EF)Initialize SQ1 SFX.

L836C:  LDX #$98
L836E:  LDY #$7F
L8370:  LDA #$64
L8372:  JSR UpdateSQ1           ;($F426)Update SQ1 control and note bytes.
L8375:  JMP FinishSQ1SFXFrame   ;($813E)Finish processing SQ1 SFX for this frame.

L8378:  LDA #$12
L837A:  JSR InitSQ1SFX          ;($F4EF)Initialize SQ1 SFX.

L837D:  LDX #$5F
L837F:  LDY #$8B
L8381:  LDA #$0E
L8383:  JSR UpdateSQ1           ;($F426)Update SQ1 control and note bytes.

L8386:  LDA SQ1SFXTimer
L8389:  CMP #$0C
L838B:  BCS $8392
L838D:  ORA #$50
L838F:  STA SQ1Cntrl0
L8392:  JMP FinishSQ1SFXFrame   ;($813E)Finish processing SQ1 SFX for this frame.

L8395:  LDA #$06
L8397:  JSR InitSQ1SFX          ;($F4EF)Initialize SQ1 SFX.

L839A:  LDX #$95
L839C:  LDY #$7F
L839E:  LDA #$4A
L83A0:  JSR UpdateSQ1           ;($F426)Update SQ1 control and note bytes.

L83A3:  LDA SQ1SFXTimer
L83A6:  CMP #$03
L83A8:  BNE $83AF
L83AA:  LDA #$42
L83AC:  JSR UpdateSQ1Note       ;($F429)Update SQ1 note frequency.
L83AF:  JMP FinishSQ1SFXFrame   ;($813E)Finish processing SQ1 SFX for this frame.

;----------------------------------------------------------------------------------------------------

SQ1Bell3Init:
L83B2:  LDA #$04
L83B4:  STA SQ1SFXByte
L83B7:  LDA #$18
L83B9:  LDY #$15
L83BB:  JMP $82A4

SQ1Bell3Cont:
L83BE:  LDA SQ1SFXTimer
L83C1:  CMP #$01
L83C3:  BNE $83CA
L83C5:  DEC SQ1SFXByte
L83C8:  BNE $83B7
L83CA:  JMP $82BE

;----------------------------------------------------------------------------------------------------

SQ1StarPunchInit:
L83CD:  LDA #$24                ;SFX will last for 36 frames.
L83CF:  JSR InitSQ1SFX          ;($F4EF)Initialize SQ1 SFX.

L83D2:  DEC SQ1SFXTimer
L83D5:  LDA #$8F
L83D7:  STA SQ1SFXByte
L83DA:  LDX #$9C
L83DC:  LDY #$82
L83DE:  JSR SetSQ1Control       ;($F40B)Set control bits for the SQ1 channel.

SQ1StarPunchCont:
L83E1:  LDA SQ1SFXTimer
L83E4:  CMP #$12
L83E6:  BEQ $83D2
L83E8:  LDA SQ1SFXByte
L83EB:  TAY
L83EC:  JSR LogDiv16            ;($F44F)Logarithmically increase frequency.

L83EF:  STA SQ1SFXByte
L83F2:  ROL
L83F3:  ROL
L83F4:  STA SQ1Cntrl2
L83F7:  ROL
L83F8:  AND #$03
L83FA:  ORA #$08
L83FC:  STA SQ1Cntrl3
L83FF:  JMP FinishSQ1SFXFrame   ;($813E)Finish processing SQ1 SFX for this frame.

;----------------------------------------------------------------------------------------------------

ChkSQ1SFX5:
L8402:  CPY #SQ1_BELL3    		;Does the SQ1 bell3 SFX need to be started?
L8404:  BEQ SQ1Bell3Init		;If so, branch to initialize.
L8406:  CMP #SQ1_BELL3    		;Is the SQ1 bell3 SFX already playing?
L8408:  BEQ SQ1Bell3Cont   		;If so, branch to continue SFX.

L840A:  CPY #SQ1_STAR_PUNCH    	;Does the star punch SFX need to be started?
L840C:  BEQ SQ1StarPunchInit	;If so, branch to initialize.
L840E:  CMP #SQ1_STAR_PUNCH    	;Is the star punch SFX already playing?
L8410:  BEQ SQ1StarPunchCont   	;If so, branch to continue SFX.

L8412:  CPY #SQ1_HIPPO_TALK    	;Does the hippo talk SFX need to be started?
L8414:  BEQ SQ1HippoTalkInit	;If so, branch to initialize.
L8416:  CMP #SQ1_HIPPO_TALK    	;Is the hippo talk SFX already playing?
L8418:  BEQ SQ1HippoTalkCont   	;If so, branch to continue SFX.

L841A:  CPY #SQ1_HOLE_PUNCH    	;Does the hole punch SFX need to be started?
L841C:  BEQ SQ1HolePunchInit	;If so, branch to initialize.
L841E:  CMP #SQ1_HOLE_PUNCH    	;Is the hole punch SFX already playing?
L8420:  BEQ SQ1HolePunchCont   	;If so, branch to continue SFX.
L8422:  RTS

;----------------------------------------------------------------------------------------------------

;King Hippo fight talk SQ1 SFX.

SQ1HippoTalkInit:
L8423:  LDA #$10                ;SFX will last for 16 frames.
L8425:  JSR InitSQ1SFX          ;($F4EF)Initialize SQ1 SFX.

L8428:  LDX #$82				;50% duty cycle, length cntr=en, const vol=dis, vol=2.
L842A:  LDY #$A2				;Sweep enabled, divider period=3 half frames, shift counter=2.
L842C:  LDA #SQ_F_5				;Note F5.
L842E:  JSR UpdateSQ1           ;($F426)Update SQ1 control and note bytes.

SQ1HippoTalkCont:
L8431:  LDA SQ1SFXTimer			;Is the SFX timer on the 14th frame from the end?
L8434:  CMP #$0E				;
L8436:  BNE +					;If not, branch.

L8438:  LDA #SQ_F_4				;Note F4.
L843A:  JSR UpdateSQ1Note       ;($F429)Update SQ1 note frequency.
L843D:* JMP FinishSQ1SFXFrame   ;($813E)Finish processing SQ1 SFX for this frame.

;----------------------------------------------------------------------------------------------------

;Glove punching hole in introduction SQ1 SFX.

SQ1HolePunchInit:
L8440:  LDA #$20                ;SFX will last for 32 frames.
L8442:  JSR InitSQ1SQ2SFX		;($F518)Use noise channel for SFX, disable SQ1, SQ2.

L8445:  LDA #$09				;length counter, const vol disabled, vol=9.
L8447:  STA NoiseCntrl0			;

L844A:  LDA #$0F				;Mode 0, period=15.
L844C:  STA NoiseCntrl2			;

L844F:  LDA #$08				;Length counter=1.
L8451:  STA NoiseCntrl3			;

L8454:  LDA #$0F				;Length counter=enabled, lin. cntr=15.
L8456:  STA TriangleCntrl0		;

L8459:  LDA #$00				;Timer low=0.
L845B:  STA TriangleCntrl2		;

L845E:  LDA #$09				;timer high=1, Length counter load=1.
L8460:  STA TriangleCntrl3		;

SQ1HolePunchCont:
L8463:  JMP FinishSQ1SFXFrame   ;($813E)Finish processing SQ1 SFX for this frame.

;----------------------------------------------------------------------------------------------------
;|                                          SQ2 SFX Player                                          |
;----------------------------------------------------------------------------------------------------

L8466:  LDA SQ2SFXTimer
L8469:  AND #$07
L846B:  BNE $8489
L846D:  LDA SQ2SFXByte1
L8470:  LSR
L8471:  LSR
L8472:  LSR
L8473:  LSR
L8474:  SEC
L8475:  ADC SQ2SFXByte1
L8478:  STA SQ2SFXByte1
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
L848E:  STA SQ2SFXTimer
L8491:  LDA #$1A
L8493:  STA SQ2SFXByte1
L8496:  LDX #$9F
L8498:  LDY #$83
L849A:  JSR SetSQ2Control       ;($F414)Set control registers for SQ2.

L849D:  LDA SQ2SFXTimer
L84A0:  CMP #$40
L84A2:  BCS $84AB
L84A4:  LSR
L84A5:  LSR
L84A6:  ORA #$90
L84A8:  STA SQ2Cntrl0
L84AB:  JSR $8466
L84AE:  JMP $8514

PlaySQ2SFX:
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
L84E0:  STA SQ2SFXTimer

L84E3:  LDX #$9C
L84E5:  LDY #$7F
L84E7:  LDA #$62
L84E9:  JSR UpdateSQ2           ;($F41B)Update SQ2 control and note bytes.

L84EC:  LDA SQ2SFXTimer
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

L8514:  DEC SQ2SFXTimer
L8517:  BNE $8522

L8519:  LDA #$00
L851B:  STA SFXIndexSQ2

L851D:  LDA #$10
L851F:  STA SQ2Cntrl0
L8522:  RTS

L8523:  STY SFXIndexSQ2
L8525:  LDA #$10
L8527:  STA SQ2SFXTimer
L852A:  LDA #$04
L852C:  STA SQ2SFXByte1
L852F:  LDY SQ2SFXByte1
L8532:  LDA SQ2SFXTimer
L8535:  CMP $F816,Y
L8538:  BNE $8550
L853A:  LDX #$84
L853C:  JSR SQ2CntrlAndSwpDis   ;($F412)Disable SQ2 and set control bits.
L853F:  LDY SQ2SFXByte1
L8542:  LDA $F81A,Y
L8545:  STA SQ2Cntrl2
L8548:  LDA #$08
L854A:  STA SQ2Cntrl3
L854D:  DEC SQ2SFXByte1
L8550:  JMP $8514

L8553:  STY SFXIndexSQ2
L8555:  LDA #$20
L8557:  STA SQ2SFXTimer
L855A:  LDX #$1A
L855C:  LDY #$CD
L855E:  LDA #$42
L8560:  BNE $856F
L8562:  LDA SQ2SFXTimer
L8565:  CMP #$18
L8567:  BNE $8572
L8569:  LDX #$94
L856B:  LDY #$C5
L856D:  LDA #$50
L856F:  JSR UpdateSQ2           ;($F41B)Update SQ2 control and note bytes.
L8572:  JMP $8514

L8575:  STY SFXIndexSQ2
L8577:  LDA #$10
L8579:  STA SQ2SFXTimer
L857C:  LDA #$38
L857E:  BNE $8589
L8580:  LDA SQ2SFXTimer
L8583:  CMP #$0C
L8585:  BNE $8591

L8587:  LDA #$44
L8589:  LDX #$CD
L858B:  STX SQ2Cntrl1
L858E:  JSR UpdateSQ2Note       ;($F41E)Update the SQ2 channel note frequency.

L8591:  LDY SQ2SFXTimer
L8594:  LDA $F858,Y
L8597:  STA SQ2Cntrl0
L859A:  JMP $8514

L859D:  STY SFXIndexSQ2
L859F:  LDA #$10
L85A1:  STA SQ2SFXTimer
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
L85DF:  STA SQ2SFXTimer
L85E2:  LDX #$5F
L85E4:  LDY #$8B
L85E6:  LDA #$0E
L85E8:  JSR UpdateSQ2           ;($F41B)Update SQ2 control and note bytes.

L85EB:  LDA SQ2SFXTimer
L85EE:  CMP #$10
L85F0:  BCS $85F7
L85F2:  ORA #$50
L85F4:  STA SQ2Cntrl0
L85F7:  JMP $8514

L85FA:  STY SFXIndexSQ2
L85FC:  LDA #$10
L85FE:  STA SQ2SFXTimer
L8601:  LDX #$85
L8603:  LDY #$85
L8605:  LDA #$1C
L8607:  JSR UpdateSQ2           ;($F41B)Update SQ2 control and note bytes.
L860A:  JMP $8514

L860D:  STY SFXIndexSQ2
L860F:  LDA #$20
L8611:  STA SQ2SFXTimer
L8614:  LDA #$8F
L8616:  STA SQ2SFXByte1
L8619:  LDX #$5D
L861B:  LDY #$81
L861D:  JSR SetSQ2Control       ;($F414)Set control registers for SQ2.

L8620:  LDA SQ2SFXByte1
L8623:  TAY
L8624:  JSR LogDiv16            ;($F44F)Logarithmically increase frequency.

L8627:  STA SQ2SFXByte1
L862A:  ROL
L862B:  ROL
L862C:  STA SQ2Cntrl2
L862F:  ROL
L8630:  AND #$03
L8632:  ORA #$08
L8634:  STA SQ2Cntrl3
L8637:  LDA SQ2SFXTimer
L863A:  CMP #$0D
L863C:  BCS $8643
L863E:  ORA #$90
L8640:  STA SQ2Cntrl0
L8643:  JMP $8514

L8646:  STY SFXIndexSQ2
L8648:  LDA #$10
L864A:  STA SQ2SFXTimer
L864D:  LDA #$FF
L864F:  STA SQ2SFXByte1
L8652:  LDX #$5D
L8654:  LDY #$81
L8656:  JSR SetSQ2Control       ;($F414)Set control registers for SQ2.

L8659:  LDA SQ2SFXByte1
L865C:  TAY
L865D:  JSR LogDiv8             ;($F450)Logarithmically increase frequency.
L8660:  STA SQ2SFXByte1
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
L8685:  STA SQ2SFXTimer
L8688:  LDX #$C8
L868A:  LDY #$CC
L868C:  LDA #$34
L868E:  JSR UpdateSQ2           ;($F41B)Update SQ2 control and note bytes.
L8691:  JMP $8514

L8694:  STY SFXIndexSQ2
L8696:  LDA #$0C
L8698:  STA SQ2SFXTimer
L869B:  LDX #$03
L869D:  LDY #$C5
L869F:  JSR SetSQ2Control       ;($F414)Set control registers for SQ2.

L86A2:  LDA #$38
L86A4:  BNE $86B6
L86A6:  LDA SQ2SFXTimer
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
L86C0:  STA SQ2SFXTimer

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
L8700:  STA SQ2SFXTimer
L8703:  LDA #$1A
L8705:  STA SQ2SFXByte1
L8708:  LDX #$9F
L870A:  LDY #$83
L870C:  JSR SetSQ2Control       ;($F414)Set control registers for SQ2.

L870F:  LDA SQ2SFXTimer
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
L872F:  STA SQ2SFXTimer
L8732:  LDA #$14
L8734:  STA SQ2SFXByte1
L8737:  LDX #$9E
L8739:  LDY #$B3
L873B:  LDA #$40
L873D:  BNE $874D
L873F:  LDA SQ2SFXTimer
L8742:  CMP SQ2SFXByte1
L8745:  BNE $8750
L8747:  LDX #$86
L8749:  LDY #$C5
L874B:  LDA #$5E
L874D:  JSR UpdateSQ2           ;($F41B)Update SQ2 control and note bytes.
L8750:  JMP $8514

L8753:  STY SFXIndexSQ2
L8755:  LDA #$60
L8757:  STA SQ2SFXTimer
L875A:  LDA #$0C
L875C:  STA SQ2SFXByte1
L875F:  LDA #$0F
L8761:  STA SQ2SFXByte2
L8764:  LDA #$00
L8766:  STA $0728
L8769:  LDA #$04
L876B:  STA $0729
L876E:  LDY SQ2SFXByte2
L8771:  LDA $0728
L8774:  BEQ $877B
L8776:  LDA $F845,Y
L8779:  BNE $877E
L877B:  LDA $F835,Y
L877E:  STA SQ2Cntrl0
L8781:  LDA SQ2SFXTimer
L8784:  LDY SQ2SFXByte1
L8787:  CMP $F822,Y
L878A:  BNE $87CB
L878C:  INY
L878D:  TYA
L878E:  LSR
L878F:  TAY
L8790:  LDA $F82E,Y
L8793:  STA SQ2SFXByte2
L8796:  LDA SQ2SFXByte1
L8799:  LSR
L879A:  BCS $87A2
L879C:  LDA #$CA
L879E:  LDX #$00
L87A0:  BEQ $87A6
L87A2:  LDA #$BB
L87A4:  LDX #$01
L87A6:  STX $0728
L87A9:  STA SQ2Cntrl1
L87AC:  LDA SQ2SFXByte1
L87AF:  BEQ $87B4
L87B1:  DEC SQ2SFXByte1
L87B4:  LDY $0729
L87B7:  LDA $F81E,Y
L87BA:  STA SQ2Cntrl2
L87BD:  LDA $F854,Y
L87C0:  STA SQ2Cntrl3
L87C3:  DEY
L87C4:  BNE $87C8
L87C6:  LDY #$04
L87C8:  STY $0729
L87CB:  LDA SQ2SFXByte2
L87CE:  BEQ $87D3
L87D0:  DEC SQ2SFXByte2
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
L87F8:  STA SQ2SFXTimer
L87FB:  LDA #$1F
L87FD:  STA SQ2SFXByte1
L8800:  LDX #$9A
L8802:  LDY #$83
L8804:  JSR SetSQ2Control       ;($F414)Set control registers for SQ2.

L8807:  LDA SQ2SFXTimer
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
L8827:  STA SQ2SFXTimer
L882A:  LDA #$FF
L882C:  STA SQ2SFXByte1
L882F:  LDX #$1E
L8831:  LDY #$82
L8833:  JSR SetSQ2Control       ;($F414)Set control registers for SQ2.

L8836:  LDA SQ2SFXByte1
L8839:  TAY
L883A:  JSR LogDiv16            ;($F44F)Logarithmically increase frequency.

L883D:  STA SQ2SFXByte1
L8840:  ROL
L8841:  ROL
L8842:  STA SQ2Cntrl2
L8845:  ROL
L8846:  AND #$03
L8848:  ORA #$08
L884A:  STA SQ2Cntrl3

L884D:  LDA SQ2SFXTimer
L8850:  CMP #$0C
L8852:  BCS $8859
L8854:  ORA #$90
L8856:  STA SQ2Cntrl0
L8859:  JMP $8514

L885C:  STY SFXIndexSQ2
L885E:  LDA #$10
L8860:  STA SQ2SFXTimer

L8863:  LDX #$82
L8865:  LDY #$A2
L8867:  LDA #$56
L8869:  JSR UpdateSQ2           ;($F41B)Update SQ2 control and note bytes.

L886C:  LDA SQ2SFXTimer
L886F:  CMP #$0E
L8871:  BNE $8878
L8873:  LDA #$3E
L8875:  JSR UpdateSQ2Note       ;($F41E)Update the SQ2 channel note frequency.
L8878:  JMP $8514

L887B:  STY SFXIndexSQ2
L887D:  LDA #$20
L887F:  STA SQ2SFXTimer
L8882:  LDA #$7F
L8884:  BNE $888B
L8886:  LDA #$5F
L8888:  DEC SQ2SFXTimer
L888B:  STA SQ2SFXByte1
L888E:  LDX #$9E
L8890:  LDY #$82
L8892:  JSR SetSQ2Control       ;($F414)Set control registers for SQ2.

L8895:  LDA SQ2SFXTimer
L8898:  CMP #$10
L889A:  BEQ $8886
L889C:  LDA SQ2SFXByte1
L889F:  TAY
L88A0:  JSR LogDiv32            ;($F44E)Logarithmically increase frequency.

L88A3:  STA SQ2SFXByte1
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
L88D3:  STA SQ2SFXTimer

L88D6:  LDX #$C8
L88D8:  LDY #$AC
L88DA:  LDA #$42
L88DC:  JSR UpdateSQ2           ;($F41B)Update SQ2 control and note bytes.

L88DF:  JMP $8514

;----------------------------------------------------------------------------------------------------
;|                                           Music Player                                           |
;----------------------------------------------------------------------------------------------------

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

ChkRepeatMusic:
L88FC:  LDA MusicIndex          ;Does current music need to loop?
L88FE:  CMP #MUS_TRAIN_RPT      ;
L8900:  BCS UpdateMusicIndex    ;If so, branch to reload the music index.

StopMusic:
L8902:  LDA #$00                ;Zero out the music index to indicate no music to play.
L8904:  STA MusicIndex          ;

SilenceChannels:
L8906:  LDA NoiseInUse          ;Is the noise channel in use by an SFX?
L8909:  BEQ ChkSQ1Use           ;If not, branch.

L890B:  LDA SFXIndexSQ2         ;Is SFX using SQ2?
L890D:  BEQ SilenceSQ2          ;If not, branch to silence SQ2.

L890F:  LDA #$10                ;Silence SQ1 channel.
L8911:* STA SQ1Cntrl0           ;

L8914:  LDA #$00                ;Silence the triangle channel.
L8916:  STA TriangleCntrl0      ;
L8919:  BEQ ResetSQ1SQ2Env      ;Branch always to reset SQ1, SQ2 envelope data indexes.

SilenceSQ2:
L891B:  LDA #$10                ;Silence SQ2.
L891D:  STA SQ2Cntrl0           ;
L8920:  BNE -                   ;Branch always to silence SQ1.

ChkSQ1Use:
L8922:  LDA SQ1InUse            ;Is SQ1 being used by an SFX?
L8925:  BEQ ChkSQ2Use           ;If not, branch to check SQ2 usage.

L8927:  LDA SFXIndexSQ2         ;Is SQ2 being used by an SFX?
L8929:  BEQ _SilenceSQ2         ;If not, branch to silence SQ2.

L892B:  BNE ChkTriNoiseSilence  ;Branch to check noise and triangle channel usage.

_SilenceSQ2:
L892D:  LDA #$10                ;Silence SQ2 channel.
L892F:  STA SQ2Cntrl0           ;
L8932:  BNE SilenceTriNoise     ;Branch always.

ChkSQ2Use:
L8934:  LDA SQ2InUse            ;Is SQ2 channel currently being used by an SFX?
L8937:  BEQ ChkMusicEnd         ;If so, branch to exit.

ChkTriNoiseSilence:
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
L8950:  LDA #$00                ;Silence all the audio channels.
L8952:  STA TriangleCntrl0      ;

ResetSQ1SQ2Env:
L8955:  LDA #$00                ;
L8957:  STA SQ2EnvIndex         ;Reset the SQ1 and SQ2 envelope indexes.
L895A:  STA SQ1EnvIndex         ;
L895D:  STA NoiseVolIndex       ;

ExitNoMusic:
L8960:  RTS                     ;No music is playing. Exit.

JmpChkRepeatMusic:
L8961:  JMP ChkRepeatMusic      ;($88FC)Check if repeating music is playing.

InitMusic:
L8964:  TAX                     ;Save new music index in x temporarily.
L8965:  JSR SilenceChannels     ;($8906)Silence audio channels not being used by SFX.

L8968:  TXA                     ;Place requested music index back in A and set as current music.

UpdateMusicIndex:
L8969:  STA MusicIndex          ;Update current music index with new music to play.
L896B:  STA MusSeqBase          ;Use music index as base for finding music sequence data.

L896E:  LDY #$00
L8970:  STY MusSeqIndex
L8973:  LDY MusSeqBase
L8976:  LDA MusSeqIndexTbl-1,Y
L8979:  CLC
L897A:  ADC MusSeqIndex
L897D:  INC MusSeqIndex
L8980:  TAY
L8981:  LDA MusSeqIndexTbl,Y
L8984:  TAY
L8985:  BEQ JmpChkRepeatMusic   ;($8961)Check if repeating music is playing.

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
L8A21:  STA SQ2RestartFlag

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

L8A42:  STA SQ2ShortPause
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

L8A79:  LDA SQ2ShortPause
L8A7C:  CMP #$02
L8A7E:  BEQ $8A94

L8A80:  LDX SQ2RestartFlag
L8A83:  BEQ $8A8D

L8A85:  JSR UpdateSQ2Note       ;($F41E)Update the SQ2 note frequency.

L8A88:  LDX #$00
L8A8A:  STX SQ2RestartFlag

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
L8AAA:  LDA SQDCEnvTbl,Y
L8AAD:  TAX
L8AAE:  JSR SQ2CntrlAndSwpDis   ;($F412)Disable SQ2 sweep and set control bits.

;------------------------------------[ SQ1 Music Channel Update ]------------------------------------

UpdateSQ1Music:
L8AB1:  LDA SQ1NoteIndex        ;Is there SQ1 music data that needs to be updated?
L8AB3:  BNE +                   ;If not, jump to triangle music updates.

L8AB5:  JMP UpdateTRIMusic      ;($8B63)Update triangle musical note.

L8AB8:* LDA SFXIndexSQ1
L8ABA:  BEQ SQ1NoteCont

L8ABC:  LDA SQ1EnvBase
L8ABF:  CMP #$40
L8AC1:  BCS $8ACF

L8AC3:  LDA #$3F
L8AC5:  STA SQ1EnvIndex

L8AC8:  LDA #$01
L8ACA:  STA SQ1RestartFlag
L8ACD:  BNE SQ1NoteCont

L8ACF:  LDA #$00
L8AD1:  STA SQ1EnvIndex

SQ1NoteCont:
L8AD4:  DEC SQ1NoteRemain       ;Update note time remaining. Is it time to get a new note?
L8AD7:  BEQ GetNextSQ1Note      ;If so, branch.

L8AD9:  BNE $8B18

L8ADB:  JSR GetNoteLength       ;($F400)Get the length of this note to play.
L8ADE:  STA SQ1NoteLength       ;

GetNextSQ1Note:
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

L8AF6:  STA SQ1ShortPause
L8AF9:  LDY SFXIndexSQ1
L8AFB:  BNE $8B12

L8AFD:  JSR UpdateSQ1Note       ;($F429)Update the SQ1 note frequency.

L8B00:  BEQ $8B12
L8B02:  LDA SQ1EnvBase
L8B05:  CMP #$80
L8B07:  BCC $8B0D

L8B09:  LDA #$7F
L8B0B:  BNE +

L8B0D:  LDA #$3F
L8B0F:* STA SQ1EnvIndex

L8B12:  LDA SQ1NoteLength
L8B15:  STA SQ1NoteRemain

L8B18:  LDA SFXIndexSQ1
L8B1A:  BNE UpdateTRIMusic

L8B1C:  LDA SQ1EnvBase
L8B1F:  CMP #$40
L8B21:  BCS $8B42

L8B23:  LDA SQ1ShortPause
L8B26:  CMP #$02
L8B28:  BEQ $8B3E

L8B2A:  LDX SQ1RestartFlag
L8B2D:  BEQ $8B37
L8B2F:  JSR UpdateSQ1Note       ;($F429)Update SQ1 note frequency.

L8B32:  LDX #$00
L8B34:  STX SQ1RestartFlag

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

L8B54:  LDA SQDCEnvTbl,Y
L8B57:  TAX

L8B58:  LDY SQ1SweepCntrl       ;Prepare to set sweep control byte for SQ1.
L8B5B:  JSR SetSQ1Control       ;($F40B)Set control bits for the SQ1 channel.

L8B5E:  BNE UpdateTRIMusic      ;Done updating SQ1. Update triangle channel.

DoNoiseMusic:
L8B60:  JMP UpdateNoiseMusic    ;($8C1B)Update noise channel music.

;---------------------------------[ Triangle Music Channel Update ]----------------------------------

UpdateTRIMusic:
L8B63:  LDY TriNoteIndex        ;Is the triangle channel used in this music?
L8B66:  BEQ DoNoiseMusic        ;If not, branch to skip triangle processing.

L8B68:  DEC TriMidBlip          ;Decrement mid way blip timer.

L8B6B:  DEC TriNoteRemain
L8B6E:  BEQ GetNextTriNote

L8B70:  BNE ContinueTriNote

UpdateTriLength:
L8B72:  JSR GetNoteLength       ;($F400)Get the length of this note to play.
L8B75:  STA TriNoteLength       ;

GetNextTriNote:
L8B78:  LDY TriNoteIndex        ;Prepare to get next note data byte for the triangle channel.
L8B7B:  INC TriNoteIndex        ;

L8B7E:  LDA (MusicDataPtr),Y    ;Get new triangle channel note data.
L8B80:  BMI UpdateTriLength     ;Is this a control byte? If so, branch to change note length.

L8B82:  LDY SFXIndexSQ2
L8B84:  CPY #SQ2_OPP_PUNCH4
L8B86:  BEQ ResetTriNoteLen

L8B88:  LDY SFXIndexSQ1
L8B8A:  CPY #SQ1_HOLE_PUNCH
L8B8C:  BEQ ResetTriNoteLen

L8B8E:  CMP #$02                ;Should triangle note be silenced?
L8B90:  BNE PlayTriNote         ;If not, branch to play new note.

L8B92:  LDY #$00                ;Silence the triangle channel.
L8B94:  STY TriangleCntrl0      ;
L8B97:  BEQ ResetTriNoteLen     ;Branch always.

PlayTriNote:
L8B99:  LDY #$81                ;Enable the triangle channel.
L8B9B:  STY TriangleCntrl0      ;
L8B9E:  JSR UpdateTriNote       ;($F422)Update the triangle channel note frequency.

ResetTriNoteLen:
L8BA1:  LDA TriNoteLength       ;Set the max length of time for this note.
L8BA4:  STA TriNoteRemain       ;

L8BA7:  LDY MusicIndex
L8BA9:  CPY #MUS_PISTON_HON
L8BAB:  BEQ $8BB1

L8BAD:  CPY #MUS_NEWSPAPER
L8BAF:  BCS ContinueTriNote

L8BB1:  CMP #$0B
L8BB3:  BCS $8BCD

L8BB5:  TAX
L8BB6:  SEC
L8BB7:  SBC #$02
L8BB9:  STA TriFrontBlip

L8BBC:  TXA
L8BBD:  LSR
L8BBE:  STA TriMidBlip

L8BC1:  CMP #$04
L8BC3:  BCS $8BC9

L8BC5:  LDA #$00
L8BC7:  BEQ StoreBlipType

L8BC9:  LDA #$01
L8BCB:  BNE StoreBlipType

L8BCD:  LDA #$02

StoreBlipType:
L8BCF:  STA TriBlipType

ContinueTriNote:
L8BD2:  LDA SFXIndexSQ2
L8BD4:  CMP #SQ2_OPP_PUNCH4
L8BD6:  BEQ UpdateNoiseMusic

L8BD8:  LDA SFXIndexSQ1
L8BDA:  CMP #SQ1_HOLE_PUNCH
L8BDC:  BEQ UpdateNoiseMusic

L8BDE:  LDA MusicIndex          ;Is Piston Honda intro music playing?
L8BE0:  CMP #MUS_PISTON_HON     ;
L8BE2:  BEQ ChkBlipType         ;If so, branch to check blip type.

L8BE4:  CMP #MUS_NEWSPAPER      ;Is intro/attract/end music playing?
L8BE6:  BCS ChkTriNoteEnd       ;If not, branch to skip checking blip type.

ChkBlipType:
L8BE8:  LDA TriBlipType         ;Should a mid way blip be checked?
L8BEB:  CMP #$01                ;
L8BED:  BEQ ChkMidBlip          ;If so, branch.

L8BEF:  CMP #$02                ;Should a back half blip be checked?
L8BF1:  BEQ ChkBackBlip         ;If so, branch.

ChkFrontBlip:
L8BF3:  LDA TriNoteRemain       ;Is the note 2 frames from start?
L8BF6:  CMP TriFrontBlip        ;
L8BF9:  BNE UpdateNoiseMusic    ;If not, branch to exit.
L8BFB:  BEQ TriNoteSilence      ;Else do a 1 frame blip.

ChkMidBlip:
L8BFD:  LDA TriMidBlip          ;Has half the note time expired?
L8C00:  CMP #$02                ;
L8C02:  BNE UpdateNoiseMusic    ;If not, branch to exit.
L8C04:  BEQ TriNoteSilence      ;Else do a 1 frame note silence.

ChkBackBlip:
L8C06:  LDA TriNoteRemain       ;Is the note 5 frames from end?
L8C09:  CMP #$07                ;
L8C0B:  BNE UpdateNoiseMusic    ;If not, branch to exit.
L8C0D:  BEQ TriNoteSilence      ;Else do a 1 frame note silence.

ChkTriNoteEnd:
L8C0F:  LDA TriNoteRemain       ;Is it time to shut off the triangle note being played?
L8C12:  CMP #$02                ;
L8C14:  BNE UpdateNoiseMusic    ;If not, branch.

TriNoteSilence:
L8C16:  LDA #$00                ;Silence the triangle channel.
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

;----------------------------------------------------------------------------------------------------

;The following table represent the indexes to find the sequences to play for the various music
;in the game.  The index number is referenced from the start of this table but always looks
;in the table below it.

MusSeqIndexTbl:
L9000:  .byte $1F               ;End music.                 Music index #$01.
L9001:  .byte $2B               ;Short intro music.         Music index #$02.
L9002:  .byte $48               ;Attract music.             Music index #$03.
L9003:  .byte $2F               ;Newspaper music.           Music index #$04.
L9004:  .byte $31               ;Circuit champ music.       Music index #$05.
L9005:  .byte $33               ;Fight win music.           Music index #$06.
L9006:  .byte $35               ;Fight loss music.          Music index #$07.
L9007:  .byte $37               ;Title bout music.          Music index #$08.
L9008:  .byte $39               ;Game over music.           Music index #$09.
L9009:  .byte $3C               ;Pre-fight music.           Music index #$0A.
L900A:  .byte $3E               ;No music.                  Music index #$0B.
L900B:  .byte $3F               ;Intro music.               Music index #$0C.
L900C:  .byte $48               ;Attract music.             Music index #$0D.
L900D:  .byte $4C               ;Dream fight music.         Music index #$0E.
L900E:  .byte $4E               ;No music.                  Music index #$0F.
L900F:  .byte $4F               ;Von Kaiser intro music.    Music index #$10.
L9010:  .byte $51               ;Glass Joe intro music.     Music index #$11.
L9011:  .byte $53               ;Don Flamenco intro music.  Music index #$12.
L9012:  .byte $55               ;King Hippo intro music.    Music index #$13.
L9013:  .byte $57               ;Soda popinski intro music. Music index #$14.
L9014:  .byte $59               ;Piston Honda intro music.  Music index #$15.
L9015:  .byte $5B               ;No music.                  Music index #$16.
L9016:  .byte $5C               ;No music.                  Music index #$17.
L9017:  .byte $5D               ;No music.                  Music index #$18.
L9018:  .byte $5E               ;No music.                  Music index #$19.
L9019:  .byte $5F               ;Training music.            Music index #$1A.
L901A:  .byte $63               ;No music.                  Music index #$1B.
L901B:  .byte $64               ;No music.                  Music index #$1C.
L901C:  .byte $65               ;Opponent down music.       Music index #$1D.
L901D:  .byte $67               ;Mac Down music.            Music index #$1E.
L901E:  .byte $69               ;Fight music.               Music index #$1F.

;This table is referenced from above and is the indexes into MusicInitTbl1 to play the various
;segments for different songs. Some music indexes play multiple segments while some only play
;one segment. Other music indexes dont play any music at all.

MusSequenceTbl:
L901F:  .byte $05, $0D, $15, $05, $0D, $15  ;Index #$1F. End music.
L9025:  .byte $05, $0D, $1D, $25, $2D, $00
L902B:  .byte $35, $15, $00, $00            ;Index #$2B. Short Intro music.
L902F:  .byte $3D, $00                      ;Index #$2F. Newspaper music.
L9031:  .byte $45, $00                      ;Index #$31. Circuit champ music.
L9033:  .byte $4D, $00                      ;Index #$33. Fight win music.
L9035:  .byte $55, $00                      ;Index #$35. Fight loss music.
L9037:  .byte $5D, $00                      ;Index #$37. Title bout music.
L9039:  .byte $65, $6D, $00                 ;Index #$39. Game over music.
L903C:  .byte $75, $00                      ;Index #$3C. Pre-fight music.
L903E:  .byte $00                           ;Index #$3E. No music.
L903F:  .byte $05, $0D, $15, $05, $0D, $1D  ;Index #$3F. intro music.
L9045:  .byte $25, $2D, $00
L9048:  .byte $05, $0D, $15, $00            ;Index #$48. Attract music.
L904C:  .byte $7D, $00, $00                 ;Index #$4C. Dream fight music.
L904F:  .byte $10, $00                      ;Index #$4F. Von Kaiser intro music.
L9051:  .byte $18, $00                      ;Index #$51. Glass Joe intro music.
L9053:  .byte $20, $00                      ;Index #$53. Don Flamenco intro music.
L9055:  .byte $28, $00                      ;Index #$55. King Hippo intro music.
L9057:  .byte $30, $00                      ;Index #$57. Soda popinski intro music.
L9059:  .byte $38, $00                      ;Index #$59. Piston Honda intro music.
L905B:  .byte $00                           ;Index #$5B. No music.
L905C:  .byte $00                           ;Index #$5C. No music.
L905D:  .byte $00                           ;Index #$5D. No music.
L905E:  .byte $00                           ;Index #$5E. No music.
L905F:  .byte $40, $48, $50, $00            ;Index #$5F. Training music.
L9063:  .byte $00                           ;Index #$63. No music.
L9064:  .byte $00                           ;Index #$64. No music.
L9065:  .byte $78, $00                      ;Index #$65. Opponent down music.
L9067:  .byte $80, $00                      ;Index #$67. Mac Down music.

;----------------------------------------------------------------------------------------------------

;The following tables are used to initialize the different songs. There are a total of 8 bytes
;per entry
;Byte  1   - Index into NoteLengthsTbl.
;Bytes 2,3 - Starting address for the musical notes data.
;Byte  4   - Index into the musical notes data for the triangle channel.
;Byte  5   - Index into the musical notes data for the SQ1 channel.
;Byte  6   - Index into the musical notes data for the noise channel.
;Byte  7   - Base index to SQ2 envelope data.
;Byte  8   - Base index to SQ1 envelope data.
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
L9077:  .word AttractMusic2
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

AttractMusic2:

AttractMusic2SQ2:
L91EF:  .byte $83, $54, $84, $4C, $82, $02, $42, $44, $83, $46, $82, $44, $83, $42, $82, $02
L91F0:  .byte $83, $42, $56, $84, $50, $82, $02, $42, $44, $83, $46, $82, $44, $83, $42, $82
L9200:  .byte $02, $83, $42, $00

L9213:	.byte $83, $02, $80, $42, $44, $46, $48, $4A, $4C, $54, $56, $54, $56
L9220:  .byte $54, $56, $54, $56, $54, $56, $54, $56, $54, $56, $54, $56, $82, $54, $83, $02
L9230:  .byte $02, $80, $46, $48, $4A, $4C, $4E, $50, $56, $5A, $56, $5A, $56, $5A, $56, $5A
L9240:  .byte $56, $5A, $56, $5A, $56, $5A, $56, $5A, $82, $56, $83, $02

L924C:	.byte $82, $34, $42, $2A
L9250:  .byte $42, $34, $42, $2A, $42, $34, $42, $2A, $42, $34, $42, $2A, $42, $38, $42, $2A
L9260:  .byte $42, $38, $42, $2A, $42, $38, $42, $2A, $42, $38, $42, $2A, $42

L926D:	.byte $82, $1A, $1A, $83, $26, $82, $1A, $80, $1A, $1A, $82, $1E, $1A, $1A, $1A, $1E
L9270:  .byte $1A, $1A, $1A, $1E, $1A, $1A, $1A, $83, $26, $82, $1A, $1A, $1E, $80, $1A, $1A
L9280:  .byte $82, $1A, $1A, $1E, $1A, $1A, $1A, $1E, $1A, $83

;----------------------------------------------------------------------------------------------------

L9296:  .byte $5A, $84, $54, $82, $02, $4A, $4C, $83, $50
L92A0:  .byte $4C, $4A, $82, $46, $44, $42, $44, $46, $48, $83, $4A, $54, $85, $4C, $02, $00
L92B0:  .byte $80, $58, $5A, $58, $5A, $58, $5A, $58, $5A, $5A, $5C, $5A, $5C, $5A, $5C, $5A
L92C0:  .byte $5C, $5C, $5E, $5C, $5E, $5C, $5E, $5C, $5E, $83, $40, $82, $40, $40, $42, $40
L92D0:  .byte $3E, $3C, $83, $38, $32, $82, $34, $80, $50, $54, $56, $5A, $5E, $62, $83, $64
L92E0:  .byte $02, $82

;----------------------------------------------------------------------------------------------------

L92E2:  .byte $34, $42, $2A, $42, $34, $44, $3C, $44, $26, $3E, $34, $3E, $28, $40
L92F0:  .byte $34, $40, $2A, $2C, $2E, $30, $32, $42, $3C, $42, $34, $80, $20, $24, $26, $2A
L9300:  .byte $2E, $32, $82, $34, $02, $34, $02, $82, $1E, $80, $1E, $1E, $82, $1E, $80, $1E
L9310:  .byte $1E, $82, $1E, $80, $1E, $1E, $82, $1E, $80, $1E, $1E, $82, $1E, $80, $1E, $1E
L9320:  .byte $82, $1E, $80, $1E, $1E, $82, $1E, $80, $1E, $1E, $82, $1E, $80, $1E, $1E, $85
L9330:  .byte $26, $83, $26, $26, $86, $26, $83, $26

;----------------------------------------------------------------------------------------------------

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