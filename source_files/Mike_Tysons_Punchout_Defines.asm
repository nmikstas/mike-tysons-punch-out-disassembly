;-------------------------------------[General Purpose Variables]------------------------------------

.alias GenByteE0        $E0     ;General purpose byte.
.alias GenByteE1        $E1     ;General purpose byte.

.alias GenPtrE0         $E0     ;General use pointer.
.alias GenPtrE0LB       $E0     ;General use pointer, lower byte.
.alias GenPtrE0UB       $E1     ;General use pointer, upper byte.

;-----------------------------------------[Variable Defines]-----------------------------------------

.alias FightBank        $02     ;The memory bank containing the data for the current fight
.alias FightOffset      $03     ;Offset of the current fight within its memory bank
.alias KnockdownSts     $05     ;Knockdown status #$01=Opp down, #$02=Mac down
.alias RoundNumber      $06     ;Current round number.
.alias MacLosses        $0A     ;Number of losses on Mac's record
.alias CurrPRGBank      $0D     ;The current PRG bank mapped to $8000-$9FFF
.alias SavedPRGBank     $0E     ;The last PRG bank to be loaded

.alias PPU0Load         $10     ;Value to load next into PPU control register 0.
.alias PPU1Load         $11     ;Value to load next into PPU control register 1.

.alias SprtBkgUpdt      $1B     ;MSB set=update sprite/background enable/disable.
                                ;#$80=Disable sprites and background.
                                ;#$81=Enable sprites and background.
.alias GameEngStatus    $1C     ;0=Main game engine running, non-zero=Main game engine not running.
.alias GameStatus       $1D     ;Enables/disables portions of the game.
                                ;#$00 - Main game engine running.
                                ;#$01 - Run game timers.
                                ;#$02 - Stop all game processing.
                                ;#$03 - Process only audio.
                                ;#$FF - Run non-playable portions of game(intro, cut scenes, etc).

.alias FrameCounter     $1E     ;Increments every frame and rolls over when maxed out.
.alias TransTimer       $1F     ;Countdown timer for various transitions.

.alias ComboTimer       $4A     ;Frames left until another punch must be landed to keep combo alive.
.alias ComboCountDown   $4B     ;Hits left in current combo.

.alias MacStatus        $50     ;Status of Little Mac during a fight. MSB set=status update.

.alias MacPunchType     $74     ;Little Mac punch type.
                                ;#$00=Right punch to face.
                                ;#$01=Left punch to face.
                                ;#$02=Right punch to stomach.
                                ;#$03=Left punch to stomach.
                                ;#$80=Super punch.
.alias MacPunchDamage   $75     ;The amount of damage Little Mac's puch will do to opponent.
.alias MacDefense1      $76     ;Little Mac's defense. there are 2 values but they are always -->
.alias MacDefense2      $77     ;written to the same value. Maybe there was plans for a left and -->
                                ;right defense? #$FF=Dodge, #$08=Block, #$80=Duck.

.alias OppCurState      $90     ;Opponent's current state. Set MSB=initialize new state.
.alias OppStateStatus   $91     ;Status of opponent's current state.
.alias OppStateTimer    $92     ;Timer for opponents current state.
.alias OppStateIndex    $93     ;Index to opponent current state data.
.alias OppStBasePtr     $94     ;Pase pointer to opponent's current state data.
.alias OppStBasePtrLB   $94     ;Pase pointer to opponent's current state data, lower byte.
.alias OppStBasePtrUB   $95     ;Pase pointer to opponent's current state data, upper byte.
.alias OppStRepeatCntr  $96     ;Counter used to repeat the opponent's current state.
.alias OppPunching      $97     ;#$00=Opponent not punching, #$01=Opponent punching.
.alias OppPunchSts      $98     ;Same as OppLastPunchSts except #$80=punch active.

.alias OppAnimSeg       $9A     ;Number of timed segments in opponent's current animation.
.alias OppAnimSegTimer  $9B     ;Number of frames per segment in Opponent's animation.
.alias OppOutlineTimer  $9C     ;Timer for dodge indicator outline color. MSB set=set timer.
.alias OppIndexReturn   $9D     ;Restore value of OppStateIndex after function return.
.alias OppPtrReturnLB   $9E     ;Restore value of OppStBasePtrLB after function return.
.alias OppPtrReturnUB   $9F     ;Restore value of OppStBasePtrUB after function return.
.alias OppAnimFlags     $A0     ;MSB set=Change opponent sprites, LSB set=Move opponent on screen.
.alias OppBaseAnimIndex $A1     ;Base animation index for opponent sprites.

.alias OppBaseSprite    $B0     ;Base address for opponent sprite X,Y positions.
.alias OppBaseXSprite   $B0     ;Base X position for opponent sprites.
.alias OppBaseYSprite   $B1     ;Base Y position for opponent sprites.

.alias OppPunchSide     $B4     ;#$00=Punching Little Mac's left side, #$01=Little Mac's right side.
.alias OppPunchDamage   $B5     ;The amount of damage the current punch will do to Little Mac.
.alias OppHitDefense    $B6     ;Base address to opponent defense to Little Mac's various punches.
.alias OppHitDefenseUR  $B6     ;Amount to subtract from Little Mac right punch to face damage.
.alias OppHitDefenseUL  $B7     ;Amount to subtract from Little Mac left punch to face damage.
.alias OppHitDefenseLR  $B8     ;Amount to subtract from Little Mac right punch to stomach damage.
.alias OppHitDefenseLL  $B9     ;Amount to subtract from Little Mac left punch to stomach damage.

.alias GameStatusBB     $BB     ;Various game statuses.
                                ;#$00=No action.
                                ;#$01=Referee moving on screen.
                                ;#$02=Opponent throwing right hook.
                                ;#$03=Opponent getting up.
                                ;#$04=Opponent walking to Little Mac after knowck down.
                                ;#$80=Little Mac falling down.
                                ;#$FD=Freeze fight.
                                ;#$FF=Opponent victory dance.
.alias MacCanPunch      $BC     ;#$00=Little Mac can't punch, #$01=Little Mac can punch.

.alias OppLastPunchSts  $BD     ;Last punch status of opponent. See punch statuses below.

.alias CurrentCount     $C2     ;Current referee count. #$9A=1 through #$A2=9.

.alias OppGetUpCount    $C4     ;Count opponent will get up on. #$9A=1 through #$A2=9.

.alias Joy1Buttons      $D0     ;Controller 1 button presses.
.alias Joy2Buttons      $D1     ;Controller 2 button presses.

.alias Button1Status    $D2     ;Base for controller 1 button statuses.
.alias Button1History   $D3     ;Base for controller 1 button histories.      -->
                                ;#$00=Not pressed.                            -->
                                ;#$01=Dpad not released since last change.    -->
                                ;#$81=Dpad/button first press since last release.

.alias DPad1Status      $D2     ;Controller 1 dpad status.
.alias DPad1History     $D3     ;Controller 1 dpad history.
.alias A1Status         $D4     ;Controller 1 A button status.
.alias A1History        $D5     ;Controller 1 A button history.
.alias B1Status         $D6     ;Controller 1 B button status.
.alias B1History        $D7     ;Controller 1 B button history.
.alias Strt1Status      $D8     ;Controller 1 start status.
.alias Strt1History     $D9     ;Controller 1 start history.
.alias Sel1Status       $DA     ;Controller 1 select button status.
.alias Sel1History      $DB     ;Controller 1 select button history.

.alias _IndJumpPtr      $00EE   ;Pointer for indirect jump.
.alias IndJumpPtr       $EE     ;Pointer for indirect jump.
.alias IndJumpPtrLB     $EE     ;Pointer for indirect jump, lower byte.
.alias IndJumpPtrUB     $EF     ;Pointer for indirect jump, upper byte.

.alias EnteredPasswd    $0110   ;To $0119 and $0120 to $0129. The first 10 bytes are password data
                                ;that after A+B+select were pressed. The second 10 bytes are normal
                                ;password data entered by the user.

.alias RoundTmrStart    $0300   ;Round timer started: 0=Not started, 1=Started, MSB=needs reset
.alias RoundTmrCntrl    $0301   ;Round timer control. 0=running, 1=halt, 2=flash clock
.alias RoundClock       $0301   ;Base address for clock values
.alias RoundMinute      $0302   ;Current minute in round.
.alias RoundColon       $0303   ;Colon tile pointer used to separate minutes from seconds.
.alias RoundUpperSec    $0304   ;Current tens of seconds in round.
.alias RoundLowerSec    $0305   ;Current second in round(base 10).

.alias RoundTimerUB     $0306   ;Underlying timer behind round clock, upper byte
.alias RoundTimerLB     $0307   ;Underlying timer behind round clock, lower byte
.alias ClockRateUB      $0308   ;Rate that RoundTimer advances per frame, upper byte
.alias ClockRateLB      $0309   ;Rate that RoundTimer advances per frame, lower byte

.alias ClockDispStatus  $030A   ;Whether the clock display requires an update, MSB=needs update
.alias ClockDisplay     $030B   ;Base address for clock display values
.alias ClockDispMin     $030B   ;Clock digit index for minutes
.alias ClockDispColon   $030C   ;Clock digit index for the colon
.alias ClockDispSecUD   $030D   ;Clock digit index for tens of seconds
.alias ClockDispSecLD   $030E   ;Clock digit index for seconds

.alias NewHeartsUD      $0321   ;New amount of hearts, upper digit(base 10).
.alias NewHeartsLD      $0322   ;New amount of hearts, lower digit(base 10).
.alias CurHeartsUD      $0323   ;Current amount of hearts, upper digit(base 10).
.alias CurHeartsLD      $0324   ;Current amount of hearts, lower digit(base 10).
.alias HeartDispStatus  $0325   ;Hearts display status, MSB=needs update
.alias HeartDisplayUD   $0326   ;Hearts display digit index, upper digit
.alias HeartDisplayLD   $0327   ;Hearts display digit index, lower digit

.alias HeartRecover     $032D   ;recover hearts this round, base address.
.alias HeartNormRecUD   $032D   ;recover hearts this round, normal amount, upper digit(base 10).
.alias HeartNormRecLD   $032E   ;recover hearts this round, normal amount, lower digit(base 10).
.alias HeartNormRedUD   $032F   ;recover hearts this round, reduced amount, upper digit(base 10).
.alias HeartNormRedLD   $0330   ;recover hearts this round, reduced amount, lower digit(base 10).

.alias NumStars         $0342   ;Current number of stars Little Mac has.
.alias IncStars         $0343   ;#$01=Increment number of stars.

.alias StarCountDown    $0347   ;Must count down to 1 before stars will be given.

.alias healthpoints     $0390
.alias MacNextHP        $0391   ;Next value to assign to Little Mac HP.
.alias MacCurrentHP     $0392   ;Current vlaue of Little Mac's HP.
.alias MacDisplayedHP   $0393   ;Displayed HP for Little Mac.

.alias MacMaxHP         $0397   ;Max allowable HP for Little Mac.
.alias OppHP            $0398   ;Base for HP opponent HP addresses below.
.alias OppNextHP        $0398   ;Next value to assign to opponent's HP.
.alias OppCurrentHP     $0399   ;Current value of opponents HP.
.alias OppDisplayedHP   $039A   ;Displayed value of opponent's HP.

.alias MacKDRound       $03C9   ;Number of times Mac has been knocked down in this round
.alias OppKDRound       $03CA   ;Number of times opponent has been knocked down this round
.alias SpecialKD        $03CB   ;Special knockdown condition

.alias MacKDFight       $03D0   ;Number of times Mac has been knocked down in this fight
.alias OppKDFight       $03D1   ;Number of times opponent has been knocked down this fight
.alias LastPunchSts     $03D2   ;Who made the last punch? #$81=Mac #$82=Opp

.alias SelectRefill     $03D9   ;Amount of HP refill Mac will receive from pushing select

.alias PointsStatus     $03E0   ;Status of points
.alias PointsNew        $03E1   ;New points that should be added to the total (base 10)
.alias PointsTotal      $03E8   ;Total points for this round (base 10)

.alias ThisBkgPalette   $0480   ;Through $048F. Current background palette data.
.alias ThisSprtPalette  $0490   ;Through $049F. Current sprite palette data.
.alias UpdatePalFlag    $04A0   ;Non-zero value indicates the palettes need to be updated.

.alias DatIndexTemp     $04C9   ;Temporary storage for data index.

.alias VulnerableTimer  $04FD   ;Opponent is vunerable while counting down. Does not count on combos.

.alias VariableStTime   $0581   ;A vaiable time for states. Usually decreases after being punched.

.alias TimerVal0585     $0585   ;A variable used to load special timer values.

.alias HeartTable       $05A3   ;Table of heart values for this fight. (Indexing starts at 3)

.alias StarCountReset   $05B0   ;Reset value for StarCountDown.

.alias ReactTimer       $05B8   ;Opponents reaction time. Does not count on combos.

.alias ComboDataPtrLB   $05C2   ;Pointer to combo data for the current opponent, lower byte
.alias ComboDataPtrUB   $05C3   ;Pointer to combo data for the current opponent, upper byte

.alias OppRefillPtr     $05D5   ;Pointer to beginning of table of random refill values
.alias OppRefillPtrLB   $05D5   ;Pointer to random refill table, lower byte
.alias OppRefillPtrUB   $05D6   ;Pointer to random refill table, upper byte
.alias OppHPBoostCap    $05D7   ;Soft cap for HP boosts
.alias ClockRateTable   $05D8   ;Table of values for this fight. (Indexing starts at 2)

.alias OppGetUpTable    $05E0   ;Base address for opponent stand up times after knock down

.alias OppOutline       $05EC   ;Base address for determining the opponent's outline color.

.alias SelRefillPtrLB   $05EE   ;Pointer to refill table for pressing Select between rounds
.alias SelRefillPtrUB   $05EF   ;Pointer to refill table for pressing Select between rounds

.alias OppMessages      $05F0   ;Table of message indices for current opponent
.alias TrainerMessages  $05F8   ;Table of message indices from trainer for this fight

.alias JoyRawReads      $06A0   ;Through $06A8. Raw reads from controller 1 and 2. Even values -->
                                ;are from controller 1 while odd values are from controller 2. -->
                                ;The controllers are polled 4 times each per frame. Used to -->
                                ;DPCM conflict.

;--------------------------------------[Sound Engine Variables]--------------------------------------

.alias SoundInitBase    $F0     ;Base address for sound initialization addresses below.
.alias SFXInitSQ1       $F0     ;The SFX index to be started that uses SQ1.
.alias SFXInitSQ2       $F1     ;The SFX index to be started that uses SQ2.
.alias MusicInit        $F2     ;The music index to be started.
.alias DMCInit          $F3     ;The DMC SFX index to be started.
.alias SFXIndexSQ1      $F4     ;The SFX currently being played that uses SQ1.
.alias SFXIndexSQ2      $F5     ;The SFX currently being played that uses SQ2.
.alias MusicIndex       $F6     ;The music currently being played.
.alias DMCIndex         $F7     ;The DMC SFX currently being played.
.alias MusicDataPtr     $F8     ;Pointer base of music data.
.alias MusicDataPtrLB   $F8     ;Pointer base of music data, lower byte.
.alias MusicDataPtrUB   $F9     ;Pointer base of music data, upper byte.

.alias SQ2NoteIndex     $FC     ;Index to current SQ2 musical note data.
.alias SQ1NoteIndex     $FD     ;Index to current SQ1 musical note data.

.alias SQ2NoteRemain    $0700   ;The counter used for remaining SQ2 note time.
.alias SQ1NoteRemain    $0701   ;The counter used for remaining SQ1 note time.
.alias TriNoteRemain    $0702   ;The counter used for remaining triangle note time.
.alias NoiseNoteRemain  $0703   ;The counter used for remaining noise note time.
.alias SQ2NoteLength    $0704   ;The total length of the of the current SQ2 note.
.alias SQ1NoteLength    $0705   ;The total length of the of the current SQ1 note.
.alias TriNoteLength    $0706   ;The total length of the of the current triangle note.
.alias NoiseNoteLength  $0707   ;The total length of the of the current noise note.
.alias SQ2EnvIndex      $0708   ;The current index to SQ2 envelope data while playing music.
.alias SQ1EnvIndex      $0709   ;The current index to SQ1 envelope data while playing music.
.alias MusSeqBase       $070A   ;Base index for finding music sequence data.
.alias MusSeqIndex      $070B   ;Current index for finding music sequence data.
.alias NoiseIndexReload $070C   ;Reload address to repeat drum beatsin song background.
.alias NoteLengthsBase  $070D   ;Base index for note lengths for a given piece of music.
.alias SQ1SweepCntrl    $070E   ;Control byte for SQ1 sweep hardware.
.alias SQ1LoFreqBits    $070F   ;Lower frequency bits of SQ0.
.alias SQ2LoFreqBits    $0710   ;Lower frequency bits of SQ2.

;$0711

.alias SQ1SFXTimer      $0712   ;Length timer for SQ1 SFX.
.alias SQ1SFXByte       $0713   ;Multi purpose register for SQ1 SFX.

.alias SQ2SFXTimer      $0715   ;Length timer for SQ2 SFX.
.alias SQ2SFXByte1      $0716   ;Multi purpose register for SQ2 SFX.
.alias SQ2SFXByte2      $0717   ;Multi purpose register for SQ2 SFX.
.alias SQ2ShortPause    $0718   ;Creates a short 2 frame pause in SQ2 music.
.alias SQ1ShortPause    $0719   ;Creates a short 2 frame pause in SQ1 music.
.alias SQ2RestartFlag   $071A   ;Flag indicating SQ2 music needs to resume after SFX completes.
.alias SQ1RestartFlag   $071B   ;Flag indicating SQ1 music needs to resume after SFX completes.
.alias SQ2EnvBase       $071C   ;Base index for SQ2 envelope data while playing music.
.alias SQ1EnvBase       $071D   ;Base index for SQ1 envelope data while playing music.

;These registers are used for the timing with the DMC laugh SFX. $071E is the time between
;laughs while $071F is the time of the audible portion of the laugh. Each laugh has a small
;silence between them.

.alias DMCLaughLength   $071E   ;Time remaining until next laugh starts.
.alias DMCLghAudLength  $071F   ;Auduble time remaining in this laugh segment.
.alias NoiseVolIndex    $0720   ;Index to noise channel control byte for volume/envelope.
.alias NoiseBeatType    $0721   ;If drum beat is type 10 or 11, decay will be applied.
.alias TriNoteIndex     $0722   ;Index to current triangle musical note data.
.alias NoiseMusicIndex  $0723   ;Index to current noise music data.
.alias NoiseInUse       $0724   ;Non-zero indicates an SFX is using the noise channel.
.alias SQ2InUse         $0725   ;Non-zero indicates an SFX is using the SQ2 channel.
.alias SQ1InUse         $0726   ;Non-zero indicates an SFX is using the SQ1 channel.

;$0728
;$0729

;These register functionalities are hard to explain. When the intro or Piston Honda's intro
;music are playing, a special situation exists where the triangle channel needs to turn off
;before the note length expires. This leaves gaps where the triangle channel does not play.
;Let's call this a "blip". There are 3 situations where special processing is considered:
;  1)If triangle note length > #$09 frames, blib occurs 5 frames before note timer end.
;  2)If #$09 >= triangle note length > #$07, blib occurs in the middle of the note timer.
;  3)if triangle note length <= #$07, a blip occurs 2 frames after the note timer start.
;Registers $072A and $072B keep track of the timing values for the blips. Register $072C determines
;which blip type to use based on initial note length.

.alias TriMidBlip       $072A   ;Loaded with 1/2 of Triangle note counter.
.alias TriFrontBlip     $072B   ;Loaded with triangle note counter - 2.
.alias TriBlipType      $072C   ;#$00=Front half blip, #$01=Mid way blip, #$02=Back half blip.


;-------------------------------------[Hardware Registers]-------------------------------------------

.alias PPUControl0      $2000   ;
.alias PPUControl1      $2001   ;
.alias PPUStatus        $2002   ;
.alias SPRAddress       $2003   ;PPU hardware control registers.
.alias SPRIOReg         $2004   ;
.alias PPUScroll        $2005   ;
.alias PPUAddress       $2006   ;
.alias PPUIOReg         $2007   ;

.alias SQ1Cntrl0        $4000   ;
.alias SQ1Cntrl1        $4001   ;SQ1 hardware control registers.
.alias SQ1Cntrl2        $4002   ;
.alias SQ1Cntrl3        $4003   ;

.alias SQ2Cntrl0        $4004   ;
.alias SQ2Cntrl1        $4005   ;SQ2 hardware control registers.
.alias SQ2Cntrl2        $4006   ;
.alias SQ2Cntrl3        $4007   ;

.alias TriangleCntrl0   $4008   ;
.alias TriangleCntrl1   $4009   ;Triangle hardware control registers.
.alias TriangleCntrl2   $400A   ;
.alias TriangleCntrl3   $400B   ;

.alias NoiseCntrl0      $400C   ;
.alias NoiseCntrl1      $400D   ;Noise hardware control registers.
.alias NoiseCntrl2      $400E   ;
.alias NoiseCntrl3      $400F   ;

.alias DMCCntrl0        $4010   ;
.alias DMCCntrl1        $4011   ;DMC hardware control registers.
.alias DMCCntrl2        $4012   ;
.alias DMCCntrl3        $4013   ;

.alias SPRDMAReg        $4014   ;Sprite RAM DMA register.
.alias APUCommonCntrl0  $4015   ;APU common control 1 register.
.alias CPUJoyPad1       $4016   ;Joypad1 register.
.alias APUCommonCntrl1  $4017   ;Joypad2/APU common control 2 register.

;------------------------------------------[MMC Registers]-------------------------------------------

.alias BankSelect       $AFFF

;--------------------------------------------[Constants]---------------------------------------------

;Silent note indexes.
.alias NO_NOTE1         $00     ;Silent note.
.alias NO_NOTE2         $02     ;Silent note.

;Sound channel indexes.
.alias AUD_SQ1_INDEX    $00     ;Square wave 1 channel index.
.alias AUD_SQ2_INDEX    $04     ;Square wave 2 channel index.
.alias AUD_TRI_INDEX    $08     ;Triangle wave channel index.

;Drum beat types.
.alias DRUM_BEAT_1      $02     ;
.alias DRUM_BEAT_2      $06     ;
.alias DRUM_BEAT_3      $0A     ;
.alias DRUM_BEAT_4      $0E     ;
.alias DRUM_BEAT_5      $12     ;Various drum beats used in the music. Drum beat -->
.alias DRUM_SILENT      $16     ;10 and 11 will have a decay value applied to them.
.alias DRUM_BEAT_7      $1A     ;
.alias DRUM_BEAT_8      $1E     ;
.alias DRUM_BEAT_9      $22     ;
.alias DRUM_BEAT_10     $26     ;
.alias DRUM_BEAT_11     $2A     ;

;DMC SFX index numbers.
.alias DMC_CROWD        $01     ;Crowd cheering, repeats.
.alias DMC_LAUGH1       $02     ;Opponent laughing, style 1.
.alias DMC_LAUGH2       $03     ;Opponent laughing, style 2.
.alias DMC_LAUGH3       $04     ;Opponent laughing, style 3.
.alias DMC_LAUGH4       $05     ;Opponent laughing, style 4.
.alias DMC_LAUGH5       $06     ;Opponent laughing, style 5.
.alias DMC_GRUNT        $07     ;Opponent grunt when hit blocked.

;SQ1 SFX index numbers.
.alias SQ1_INTRO_PUNCH  $01     ;Punch SFX when start is pressed at intro.
.alias SQ1_FALL         $02     ;Opponent/player falls to the ground SFX.
.alias SQ1_PUNCH1       $03     ;Opponent/player lands a punch SFX, version 1.
.alias SQ1_PUNCH_BLOCK  $04     ;Opponent/player blocks a punch SFX.
.alias SQ1_OPP_PUNCH1   $05     ;Opponent punch SFX, vesrion 1.
.alias SQ1_PUNCH_MISS1  $06     ;Little Mac misses a punch SFX, vesion 1.
.alias SQ1_PUNCH_MISS2  $07     ;Little Mac misses a punch SFX, vesion 2.
.alias SQ1_PUNCH2       $08     ;Little Mac lands a punch, version 2.
.alias SQ1_TALK1        $09     ;Talking SFX, version 1.
.alias SQ1_TALK2        $0A     ;Talking SFX, version 2.
.alias SQ1_TALK3        $0B     ;Talking SFX, version 3.
.alias SQ1_BELL1        $0C     ;Single bell ring SFX.
.alias SQ1_FIGHT        $0D     ;Referee "Fight!" SFX.
.alias SQ1_KO           $0E     ;Referee "KO" SFX.
.alias SQ1_TKO          $0F     ;Referee "TKO" SFX.
.alias SQ1_COUNT        $10     ;Referee count SFX.
.alias SQ1_DODGE        $11     ;Little Mac dodge to one side SFX.
.alias SQ1_DIGIT        $12     ;Beep when password digit entered SFX.
.alias SQ1_PUNCH3       $13     ;Opponent/player lands a punch SFX, version 3.
.alias SQ1_BEEP         $14     ;Beep SFX.
.alias SQ1_BELL3        $15     ;3 bells SFX.
.alias SQ1_STAR_PUNCH   $16     ;Little Mac star punch wind up SFX.
.alias SQ1_HIPPO_TALK   $17     ;King Hippo talking SFX.
.alias SQ1_HOLE_PUNCH   $18     ;Glove punching a hole in the intro SFX.

;SQ2 SFX index numbers.
.alias SQ2_INTRO_PUNCH  $01     ;Punch SFX when start is pressed at intro.
.alias SQ2_FALL         $02     ;Opponent/player falls to the ground SFX.
.alias SQ2_GET_STAR     $03     ;Little Mac gets a star SFX.
.alias SQ2_HONK1        $04     ;Opponent honk SFX, version 1.
.alias SQ2_HONK2        $05     ;Opponent honk SFX, version 2.
.alias SQ2_PUNCH1       $06     ;Little Mac lands a punch, version 1
.alias SQ2_PUNCH2       $07     ;Little Mac lands a punch, version 2.
.alias SQ2_OPP_PUNCH1   $08     ;Opponent punch SFX, version 1.
.alias SQ2_OPP_PUNCH2   $09     ;Opponent punch SFX, version 2.
.alias SQ2_OPP_PUNCH3   $0A     ;Opponent punch SFX, version 3.
.alias SQ2_SPRING1      $0B     ;Opponent spring SFX, version 1.
.alias SQ2_TAUNT        $0C     ;Opponent taunt.
.alias SQ2_OPP_PUNCH4   $0D     ;Opponent punch SFX, version 4.
.alias SQ2_STUN1        $0E     ;Opponent stunned SFX, version 1.
.alias SQ2_TIGER_PUNCH  $0F     ;Great Tiger magic punch SFX.
.alias SQ2_MAGIC        $10     ;Great Tiger Dissapear SFX.
.alias SQ2_FLEX         $11     ;Mike Tyson muscle flex.
.alias SQ2_MACHO_PUNCH  $12     ;Super Macho Man super punch SFX.
.alias SQ2_HIPPO_TALK   $13     ;King Hippo talking SFX.
.alias SQ2_WIND_UP      $14     ;Opponent punch wind up SFX.
.alias SQ2_SPRING2      $15     ;Opponent spring SFX, version 2.

;Music index numbers.
.alias MUS_END          $01     ;End music.
.alias MUS_SHORT_INTRO  $02     ;Short version of the intro music.
.alias MUS_ATTRACT      $03     ;Attract music.
.alias MUS_NEWSPAPER    $04     ;Music that plays newspaper is displayed.
.alias MUS_CHAMP        $05     ;Circuit champion music.
.alias MUS_FIGHT_WIN    $06     ;Fight win music.
.alias MUS_FIGHT_LOSS   $07     ;Fight loss music.
.alias MUS_TITLE_BOUT   $08     ;Title bout music.
.alias MUS_GAME_OVER    $09     ;Game over music.
.alias MUS_PRE_FIGHT    $0A     ;Pre-fight music.
.alias MUS_NONE         $0B     ;No music.
.alias MUS_INTRO        $0C     ;Intro music.
.alias MUS_ATTRACT2     $0D     ;Attract music. Same as above.
.alias MUS_DREAM_FIGHT  $0E     ;Dream fight music.
.alias MUS_NONE2        $0F     ;No music.
.alias MUS_VON_KAISER   $10     ;Von Kaiser/Macho Man intro music.
.alias MUS_GLASS_JOE    $11     ;Glass Joe intro music.
.alias MUS_DON_FLAM     $12     ;Don Flamenco intro music.
.alias MUS_KING_HIPPO   $13     ;King Hippo intro music.
.alias MUS_SODA_POP     $14     ;Soda popinski intro music.
.alias MUS_PISTON_HON   $15     ;Piston Honda intro music.
.alias MUS_NONE3        $16     ;No music.
.alias MUS_NONE4        $17     ;No music.
.alias MUS_NONE5        $18     ;No music.
.alias MUS_NONE6        $19     ;No music.
.alias MUS_TRAIN_RPT    $1A     ;Training music, repeats.
.alias MUS_NONE7        $1B     ;No music.
.alias MUS_NONE8        $1C     ;No music.
.alias MUS_OPP_DOWN     $1D     ;Opponent on the mat music.
.alias MUS_MAC_DOWN     $1E     ;Little Mac on the mat music.
.alias MUS_FIGHT        $1F     ;Main fight music.

;Game status.
.alias ST_REF_MOVING    $01     ;Indicates ref is moving on the screen.

;Little Mac status.
.alias MAC_NO_FIGHT     $00     ;Fight not running.
.alias MAC_WAITING      $01     ;Normal. Waiting for player input.
.alias MAC_NO_HEARTS    $02     ;No hearts.
.alias MAC_DODGE_RIGHT  $03     ;Dodging right.
.alias MAC_DODGE_LEFT   $05     ;Dodging left.
.alias MAC_BLOCK        $07     ;Blocking.
.alias MAC_BLOCK_HIT    $08     ;Blocking hit.
.alias MAC_RP_LO        $09     ;Right punching opponent's stomach.
.alias MAC_LP_LO        $0A     ;Left punching opponent's stomach.
.alias MAC_RP_HI        $0B     ;Right punching opponent's face.
.alias MAC_LP_HI        $0C     ;Left punching opponent's face.
.alias MAC_SUPER_PUNCH  $0D     ;Super punching opponent.
.alias MAC_DUCK         $0E     ;Ducking.
.alias MAC_STUN_RIGHT   $10     ;Little Mac stunned to the right.
.alias MAC_STUN_LEFT    $11     ;Little Mac stunned to the left.
.alias MAC_PRE_WAIT     $40     ;Pre-fight wait.
.alias MAC_OPP_WAIT     $41     ;Opponent down wait.
.alias MAC_ROUND_WAIT   $42     ;Round over.

;Opponent punch side of Little Mac.
.alias MAC_LEFT_SIDE    $00     ;Punch comming in on Little Mac's left side.
.alias MAC_RIGHT_SIDE   $01     ;Punch comming in on Little Mac's right side.

;Opponent state functions.
.alias ST_SPRITES       $00     ;Load sprite data for current opponent sub-state.
.alias ST_SPRITES_XY    $10     ;Load sprite data and XY position for current opponent sub-state.
.alias ST_SPRT_MV_NU    $60     ;Move opponent sprites with no animation update.
.alias ST_SPRTS_MOVE    $70     ;Move opponent animation around on the screen. -->
                                ;Bits 0,1=frames between movements, bits 2,3=number of movements.
.alias ST_TIMER         $80     ;Number of frames for sub-state to wait.
.alias ST_SPRT_BIG_MV   $A0     ;Move opponent around the screen large lengths.
.alias ST_CALL_FUNC     $E0     ;Call an opponent state subroutine.
.alias ST_RETURN_FUNC   $E1     ;Return from an opponent state subroutine.
.alias ST_VAR_TIME      $E4     ;Set opponent's state time to a varying amount.
.alias ST_AUD_INIT      $EC     ;Play a SFX/music.
.alias ST_PNCH_ACTIVE   $F0     ;Indicates an opponent's punch is active.
.alias ST_JUMP          $F1     ;Jump to new state base address and index.
.alias ST_CHK_BRANCH    $F2     ;Check memory for value and branch in state data if value found.
.alias ST_CHK_REPEAT    $F3     ;Check if a sub-state needs to repeat.
.alias ST_WAIT_STATE    $F4     ;Put opponent into wait state.
.alias ST_REPEAT        $F5     ;Load a repeat value for this sub-state.
.alias ST_PUNCH_SIDE    $F6     ;Indicate what side of Little Mac a punch is approaching.
.alias ST_DEFENSE       $F7     ;Load Opponent's defense from following 4 data bytes.
.alias ST_PUNCH         $F9     ;Indicate the opponent is punching.
.alias ST_WRITE_BYTE    $FA     ;Write a byte into zero page memory.
.alias ST_SPEC_TIMER    $FB     ;Load a special state timer value.
.alias ST_COMBO_WAIT    $FC     ;Wait for combo timer to expire.
.alias ST_END           $FF     ;Indicate the end of this state has been reached.

;Opponent state status.
.alias STAT_NONE        $00     ;Current state is not active.
.alias STAT_ACTIVE      $80     ;Current state is active.
.alias STAT_FINISHED    $83     ;Current state has finished.

;Opponent punch status.
.alias PUNCH_NONE       $00     ;No opponent punch being thrown.
.alias PUNCH_BLOCKED    $01     ;Punch blocked by Little Mac.
.alias PUNCH_DUCKED     $02     ;Punch is ducked by Little Mac.
.alias PUNCH_LANDED     $03     ;Punch hit Little Mac.
.alias PUNCH_DODGED     $04     ;Punch dodged by Little Mac.
.alias PUNCH_ACTIVE     $80     ;Punch is initialized.

;Controller bits.
.alias IN_RIGHT         $01     ;Right on the dpad.
.alias IN_LEFT          $02     ;Left on the dpad.
.alias IN_DOWN          $04     ;Down on the dpad.
.alias IN_UP            $08     ;Up on the dpad.
.alias IN_START         $10     ;Start button.
.alias IN_SELECT        $20     ;Select button.
.alias IN_B             $40     ;B button.
.alias IN_A             $80     ;A button.

;Nibble selection bit masks.
.alias LO_NIBBLE        $0F     ;Bitmask for lower nibble.
.alias HI_NIBBLE        $F0     ;Bitmask for upper nibble.

;Opponent state flags
.alias OPP_CHNG_NONE    $00     ;Done changing opponent sprites.
.alias OPP_CHNG_POS     $01     ;Move opponent's sprites on the screen.
.alias OPP_CHNG_SPRT    $80     ;Change opponent's sprites(Next animation sequence).
.alias OPP_CHNG_BOTH    $81     ;Change both position and sprites.
.alias OPP_RGHT_HOOK    $02     ;Indicate a right hook is being thrown.

;Misc. items.
.alias NULL_PNTR        $0000   ;Null pointer.
.alias NO_ACTION        $00     ;Idle memory byte.
.alias SND_OFF          $80     ;Silences sound channel.
.alias PPU_LEFT_EN      $06     ;Enable both left background column and left sprite column.
.alias GAME_ENG_RUN     $00     ;Enables the main game engine.
.alias SPRT_BKG_OFF     $80     ;Disable sprites and background.
.alias SPRT_BKG_ON      $81     ;Enable sprites and background.
.alias PAL_UPDATE       $81     ;Update palettes flag.

;Musical note indexes SQ1, SQ2.
.alias SQ_C_2           $04     ;C2
.alias SQ_C_SHARP_2     $06     ;C#2
.alias SQ_D_2           $08     ;D2
.alias SQ_D_SHARP_2     $0A     ;D#2
.alias SQ_E_2           $0C     ;E2
.alias SQ_F_2           $0E     ;F2
.alias SQ_F_SHARP_2     $10     ;F#2
.alias SQ_G_2           $12     ;G2
.alias SQ_G_SHARP_2     $14     ;G#2
.alias SQ_A_2           $16     ;A2
.alias SQ_A_SHARP_2     $18     ;A#2
.alias SQ_B_2           $1A     ;B2
.alias SQ_C_3           $1C     ;C3
.alias SQ_C_SHARP_3     $1E     ;C#3
.alias SQ_D_3           $20     ;D3
.alias SQ_D_SHARP_3     $22     ;D#3
.alias SQ_E_3           $24     ;E3
.alias SQ_F_3           $26     ;F3
.alias SQ_F_SHARP_3     $28     ;F#3
.alias SQ_G_3           $2A     ;G3
.alias SQ_G_SHARP_3     $2C     ;G#3
.alias SQ_A_3           $2E     ;A3
.alias SQ_A_SHARP_3     $30     ;A#3
.alias SQ_B_3           $32     ;B3
.alias SQ_C_4           $34     ;C4
.alias SQ_C_SHARP_4     $36     ;C#4
.alias SQ_D_4           $38     ;D4
.alias SQ_D_SHARP_4     $3A     ;D#4
.alias SQ_E_4           $3C     ;E4
.alias SQ_F_4           $3E     ;F4
.alias SQ_F_SHARP_4     $40     ;F#4
.alias SQ_G_4           $42     ;G4
.alias SQ_G_SHARP_4     $44     ;G#4
.alias SQ_A_4           $46     ;A4
.alias SQ_A_SHARP_4     $48     ;A#4
.alias SQ_B_4           $4A     ;B4
.alias SQ_C_5           $4C     ;C5
.alias SQ_C_SHARP_5     $4E     ;C#5
.alias SQ_D_5           $50     ;D5
.alias SQ_D_SHARP_5     $52     ;D#5
.alias SQ_E_5           $54     ;E5
.alias SQ_F_5           $56     ;F5
.alias SQ_F_SHARP_5     $58     ;F#5
.alias SQ_G_5           $5A     ;G5
.alias SQ_G_SHARP_5     $5C     ;G#5
.alias SQ_A_5           $5E     ;A5
.alias SQ_A_SHARP_5     $60     ;A#5
.alias SQ_B_5           $62     ;B5
.alias SQ_C_6           $64     ;C6
.alias SQ_C_SHARP_6     $66     ;C#6
.alias SQ_D_6           $68     ;D6
.alias SQ_D_SHARP_6     $6A     ;D#6
.alias SQ_E_6           $6C     ;E6
.alias SQ_F_6           $6E     ;F6
.alias SQ_F_SHARP_6     $70     ;F#6
.alias SQ_G_6           $72     ;G6
.alias SQ_G_SHARP_6     $74     ;G#6
.alias SQ_A_6           $76     ;A6
.alias SQ_A_SHARP_6     $78     ;A#6
.alias SQ_B_6           $7A     ;B6
.alias SQ_C_7           $7C     ;C7
.alias SQ_C_SHARP_7     $7E     ;C#7
